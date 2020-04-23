#if !defined(TESSELLATION_INCLUDED)
#define TESSELLATION_INCLUDED
Shader "Custom/Tessellation" 
{
	[UNITY_domain("tri")]
	[UNITY_outputcontrolpoints(3)]
	[UNITY_outputtopology("triangle_cw")]
	[UNITY_partitioning("integer")]
	[UNITY_patchconstantfunc("MyPatchConstantFunction")]
	VertexData MyHullProgram(InputPatch<VertexData, 3> patch, uint id: SV_OutputControlPointID)
	{
		return patch[id];
	}

	struct TessellationFactors {
		float edge[3] : SV_TessFactor;
		float inside : SV_InsideTessFactor;
	};

	TessellationFactors MyPatchConstantFunction(InputPatch<VertexData, 3> patch) {
		TessellationFactors f;
		f.edge[0] = 1;
		f.edge[1] = 1;
		f.edge[2] = 1;
		f.inside = 1;
		return f;
	}

	[UNITY_domain("tri")]
	void MyDomainProgram(
		TessellationFactors factors,
		OutputPatch<VertexData, 3> patch,
		float3 barycentricCoordinates : SV_DomainLocation
	) {
		#define MY_DOMAIN_PROGRAM_INTERPOLATE(fieldName) data.fieldName = \
			patch[0].fieldName * barycentricCoordinates.x + \
			patch[1].fieldName * barycentricCoordinates.y + \
			patch[2].fieldName * barycentricCoordinates.z;

		MY_DOMAIN_PROGRAM_INTERPOLATE(vertex)
		MY_DOMAIN_PROGRAM_INTERPOLATE(normal)
		MY_DOMAIN_PROGRAM_INTERPOLATE(tangent)
		MY_DOMAIN_PROGRAM_INTERPOLATE(uv)
		MY_DOMAIN_PROGRAM_INTERPOLATE(uv1)
		MY_DOMAIN_PROGRAM_INTERPOLATE(uv2)
	}
}
#endif

