# Julia wrapper for header: cexport.h
# Automatically generated using Clang.jl


function aiGetExportFormatCount()
    ccall((:aiGetExportFormatCount, assimp), Csize_t, ())
end

function aiGetExportFormatDescription(pIndex)
    ccall((:aiGetExportFormatDescription, assimp), Ptr{aiExportFormatDesc}, (Csize_t,), pIndex)
end

function aiReleaseExportFormatDescription(desc)
    ccall((:aiReleaseExportFormatDescription, assimp), Cvoid, (Ptr{aiExportFormatDesc},), desc)
end

function aiCopyScene(pIn, pOut)
    ccall((:aiCopyScene, assimp), Cvoid, (Ptr{aiScene}, Ptr{Ptr{aiScene}}), pIn, pOut)
end

function aiFreeScene(pIn)
    ccall((:aiFreeScene, assimp), Cvoid, (Ptr{aiScene},), pIn)
end

function aiExportScene(pScene, pFormatId, pFileName, pPreprocessing)
    ccall((:aiExportScene, assimp), aiReturn, (Ptr{aiScene}, Cstring, Cstring, UInt32), pScene, pFormatId, pFileName, pPreprocessing)
end

function aiExportSceneEx(pScene, pFormatId, pFileName, pIO, pPreprocessing)
    ccall((:aiExportSceneEx, assimp), aiReturn, (Ptr{aiScene}, Cstring, Cstring, Ptr{aiFileIO}, UInt32), pScene, pFormatId, pFileName, pIO, pPreprocessing)
end

function aiExportSceneToBlob(pScene, pFormatId, pPreprocessing)
    ccall((:aiExportSceneToBlob, assimp), Ptr{aiExportDataBlob}, (Ptr{aiScene}, Cstring, UInt32), pScene, pFormatId, pPreprocessing)
end

function aiReleaseExportBlob(pData)
    ccall((:aiReleaseExportBlob, assimp), Cvoid, (Ptr{aiExportDataBlob},), pData)
end
# Julia wrapper for header: cimport.h
# Automatically generated using Clang.jl


function aiImportFile(pFile, pFlags)
    ccall((:aiImportFile, assimp), Ptr{aiScene}, (Cstring, UInt32), pFile, pFlags)
end

function aiImportFileEx(pFile, pFlags, pFS)
    ccall((:aiImportFileEx, assimp), Ptr{aiScene}, (Cstring, UInt32, Ptr{aiFileIO}), pFile, pFlags, pFS)
end

function aiImportFileExWithProperties(pFile, pFlags, pFS, pProps)
    ccall((:aiImportFileExWithProperties, assimp), Ptr{aiScene}, (Cstring, UInt32, Ptr{aiFileIO}, Ptr{aiPropertyStore}), pFile, pFlags, pFS, pProps)
end

function aiImportFileFromMemory(pBuffer, pLength, pFlags, pHint)
    ccall((:aiImportFileFromMemory, assimp), Ptr{aiScene}, (Cstring, UInt32, UInt32, Cstring), pBuffer, pLength, pFlags, pHint)
end

function aiImportFileFromMemoryWithProperties(pBuffer, pLength, pFlags, pHint, pProps)
    ccall((:aiImportFileFromMemoryWithProperties, assimp), Ptr{aiScene}, (Cstring, UInt32, UInt32, Cstring, Ptr{aiPropertyStore}), pBuffer, pLength, pFlags, pHint, pProps)
end

function aiApplyPostProcessing(pScene, pFlags)
    ccall((:aiApplyPostProcessing, assimp), Ptr{aiScene}, (Ptr{aiScene}, UInt32), pScene, pFlags)
end

function aiGetPredefinedLogStream(pStreams, file)
    ccall((:aiGetPredefinedLogStream, assimp), aiLogStream, (aiDefaultLogStream, Cstring), pStreams, file)
end

function aiAttachLogStream(stream)
    ccall((:aiAttachLogStream, assimp), Cvoid, (Ptr{aiLogStream},), stream)
end

function aiEnableVerboseLogging(d)
    ccall((:aiEnableVerboseLogging, assimp), Cvoid, (aiBool,), d)
end

function aiDetachLogStream(stream)
    ccall((:aiDetachLogStream, assimp), aiReturn, (Ptr{aiLogStream},), stream)
end

function aiDetachAllLogStreams()
    ccall((:aiDetachAllLogStreams, assimp), Cvoid, ())
end

function aiReleaseImport(pScene)
    ccall((:aiReleaseImport, assimp), Cvoid, (Ptr{aiScene},), pScene)
end

function aiGetErrorString()
    ccall((:aiGetErrorString, assimp), Cstring, ())
end

function aiIsExtensionSupported(szExtension)
    ccall((:aiIsExtensionSupported, assimp), aiBool, (Cstring,), szExtension)
end

function aiGetExtensionList(szOut)
    ccall((:aiGetExtensionList, assimp), Cvoid, (Ptr{aiString},), szOut)
end

function aiGetMemoryRequirements(pIn, in)
    ccall((:aiGetMemoryRequirements, assimp), Cvoid, (Ptr{aiScene}, Ptr{aiMemoryInfo}), pIn, in)
end

function aiCreatePropertyStore()
    ccall((:aiCreatePropertyStore, assimp), Ptr{aiPropertyStore}, ())
end

function aiReleasePropertyStore(p)
    ccall((:aiReleasePropertyStore, assimp), Cvoid, (Ptr{aiPropertyStore},), p)
end

function aiSetImportPropertyInteger(store, szName, value)
    ccall((:aiSetImportPropertyInteger, assimp), Cvoid, (Ptr{aiPropertyStore}, Cstring, Cint), store, szName, value)
end

function aiSetImportPropertyFloat(store, szName, value)
    ccall((:aiSetImportPropertyFloat, assimp), Cvoid, (Ptr{aiPropertyStore}, Cstring, ai_real), store, szName, value)
end

function aiSetImportPropertyString(store, szName, st)
    ccall((:aiSetImportPropertyString, assimp), Cvoid, (Ptr{aiPropertyStore}, Cstring, Ptr{aiString}), store, szName, st)
end

function aiSetImportPropertyMatrix(store, szName, mat)
    ccall((:aiSetImportPropertyMatrix, assimp), Cvoid, (Ptr{aiPropertyStore}, Cstring, Ptr{aiMatrix4x4}), store, szName, mat)
end

function aiCreateQuaternionFromMatrix(quat, mat)
    ccall((:aiCreateQuaternionFromMatrix, assimp), Cvoid, (Ptr{aiQuaternion}, Ptr{aiMatrix3x3}), quat, mat)
end

function aiDecomposeMatrix(mat, scaling, rotation, position)
    ccall((:aiDecomposeMatrix, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Ptr{aiQuaternion}, Ptr{aiVector3D}), mat, scaling, rotation, position)
end

function aiTransposeMatrix4(mat)
    ccall((:aiTransposeMatrix4, assimp), Cvoid, (Ptr{aiMatrix4x4},), mat)
end

function aiTransposeMatrix3(mat)
    ccall((:aiTransposeMatrix3, assimp), Cvoid, (Ptr{aiMatrix3x3},), mat)
end

function aiTransformVecByMatrix3(vec, mat)
    ccall((:aiTransformVecByMatrix3, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiMatrix3x3}), vec, mat)
end

function aiTransformVecByMatrix4(vec, mat)
    ccall((:aiTransformVecByMatrix4, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiMatrix4x4}), vec, mat)
end

function aiMultiplyMatrix4(dst, src)
    ccall((:aiMultiplyMatrix4, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiMatrix4x4}), dst, src)
end

function aiMultiplyMatrix3(dst, src)
    ccall((:aiMultiplyMatrix3, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiMatrix3x3}), dst, src)
end

function aiIdentityMatrix3(mat)
    ccall((:aiIdentityMatrix3, assimp), Cvoid, (Ptr{aiMatrix3x3},), mat)
end

function aiIdentityMatrix4(mat)
    ccall((:aiIdentityMatrix4, assimp), Cvoid, (Ptr{aiMatrix4x4},), mat)
end

function aiGetImportFormatCount()
    ccall((:aiGetImportFormatCount, assimp), Csize_t, ())
end

function aiGetImportFormatDescription(pIndex)
    ccall((:aiGetImportFormatDescription, assimp), Ptr{aiImporterDesc}, (Csize_t,), pIndex)
end

function aiVector2AreEqual(a, b)
    ccall((:aiVector2AreEqual, assimp), Cint, (Ptr{aiVector2D}, Ptr{aiVector2D}), a, b)
end

function aiVector2AreEqualEpsilon(a, b, epsilon)
    ccall((:aiVector2AreEqualEpsilon, assimp), Cint, (Ptr{aiVector2D}, Ptr{aiVector2D}, Cfloat), a, b, epsilon)
end

function aiVector2Add(dst, src)
    ccall((:aiVector2Add, assimp), Cvoid, (Ptr{aiVector2D}, Ptr{aiVector2D}), dst, src)
end

function aiVector2Subtract(dst, src)
    ccall((:aiVector2Subtract, assimp), Cvoid, (Ptr{aiVector2D}, Ptr{aiVector2D}), dst, src)
end

function aiVector2Scale(dst, s)
    ccall((:aiVector2Scale, assimp), Cvoid, (Ptr{aiVector2D}, Cfloat), dst, s)
end

function aiVector2SymMul(dst, other)
    ccall((:aiVector2SymMul, assimp), Cvoid, (Ptr{aiVector2D}, Ptr{aiVector2D}), dst, other)
end

function aiVector2DivideByScalar(dst, s)
    ccall((:aiVector2DivideByScalar, assimp), Cvoid, (Ptr{aiVector2D}, Cfloat), dst, s)
end

function aiVector2DivideByVector(dst, v)
    ccall((:aiVector2DivideByVector, assimp), Cvoid, (Ptr{aiVector2D}, Ptr{aiVector2D}), dst, v)
end

function aiVector2Length(v)
    ccall((:aiVector2Length, assimp), Cfloat, (Ptr{aiVector2D},), v)
end

function aiVector2SquareLength(v)
    ccall((:aiVector2SquareLength, assimp), Cfloat, (Ptr{aiVector2D},), v)
end

function aiVector2Negate(dst)
    ccall((:aiVector2Negate, assimp), Cvoid, (Ptr{aiVector2D},), dst)
end

function aiVector2DotProduct(a, b)
    ccall((:aiVector2DotProduct, assimp), Cfloat, (Ptr{aiVector2D}, Ptr{aiVector2D}), a, b)
end

function aiVector2Normalize(v)
    ccall((:aiVector2Normalize, assimp), Cvoid, (Ptr{aiVector2D},), v)
end

function aiVector3AreEqual(a, b)
    ccall((:aiVector3AreEqual, assimp), Cint, (Ptr{aiVector3D}, Ptr{aiVector3D}), a, b)
end

function aiVector3AreEqualEpsilon(a, b, epsilon)
    ccall((:aiVector3AreEqualEpsilon, assimp), Cint, (Ptr{aiVector3D}, Ptr{aiVector3D}, Cfloat), a, b, epsilon)
end

function aiVector3LessThan(a, b)
    ccall((:aiVector3LessThan, assimp), Cint, (Ptr{aiVector3D}, Ptr{aiVector3D}), a, b)
end

function aiVector3Add(dst, src)
    ccall((:aiVector3Add, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiVector3D}), dst, src)
end

function aiVector3Subtract(dst, src)
    ccall((:aiVector3Subtract, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiVector3D}), dst, src)
end

function aiVector3Scale(dst, s)
    ccall((:aiVector3Scale, assimp), Cvoid, (Ptr{aiVector3D}, Cfloat), dst, s)
end

function aiVector3SymMul(dst, other)
    ccall((:aiVector3SymMul, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiVector3D}), dst, other)
end

function aiVector3DivideByScalar(dst, s)
    ccall((:aiVector3DivideByScalar, assimp), Cvoid, (Ptr{aiVector3D}, Cfloat), dst, s)
end

function aiVector3DivideByVector(dst, v)
    ccall((:aiVector3DivideByVector, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiVector3D}), dst, v)
end

function aiVector3Length(v)
    ccall((:aiVector3Length, assimp), Cfloat, (Ptr{aiVector3D},), v)
end

function aiVector3SquareLength(v)
    ccall((:aiVector3SquareLength, assimp), Cfloat, (Ptr{aiVector3D},), v)
end

function aiVector3Negate(dst)
    ccall((:aiVector3Negate, assimp), Cvoid, (Ptr{aiVector3D},), dst)
end

function aiVector3DotProduct(a, b)
    ccall((:aiVector3DotProduct, assimp), Cfloat, (Ptr{aiVector3D}, Ptr{aiVector3D}), a, b)
end

function aiVector3CrossProduct(dst, a, b)
    ccall((:aiVector3CrossProduct, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiVector3D}, Ptr{aiVector3D}), dst, a, b)
end

function aiVector3Normalize(v)
    ccall((:aiVector3Normalize, assimp), Cvoid, (Ptr{aiVector3D},), v)
end

function aiVector3NormalizeSafe(v)
    ccall((:aiVector3NormalizeSafe, assimp), Cvoid, (Ptr{aiVector3D},), v)
end

function aiVector3RotateByQuaternion(v, q)
    ccall((:aiVector3RotateByQuaternion, assimp), Cvoid, (Ptr{aiVector3D}, Ptr{aiQuaternion}), v, q)
end

function aiMatrix3FromMatrix4(dst, mat)
    ccall((:aiMatrix3FromMatrix4, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiMatrix4x4}), dst, mat)
end

function aiMatrix3FromQuaternion(mat, q)
    ccall((:aiMatrix3FromQuaternion, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiQuaternion}), mat, q)
end

function aiMatrix3AreEqual(a, b)
    ccall((:aiMatrix3AreEqual, assimp), Cint, (Ptr{aiMatrix3x3}, Ptr{aiMatrix3x3}), a, b)
end

function aiMatrix3AreEqualEpsilon(a, b, epsilon)
    ccall((:aiMatrix3AreEqualEpsilon, assimp), Cint, (Ptr{aiMatrix3x3}, Ptr{aiMatrix3x3}, Cfloat), a, b, epsilon)
end

function aiMatrix3Inverse(mat)
    ccall((:aiMatrix3Inverse, assimp), Cvoid, (Ptr{aiMatrix3x3},), mat)
end

function aiMatrix3Determinant(mat)
    ccall((:aiMatrix3Determinant, assimp), Cfloat, (Ptr{aiMatrix3x3},), mat)
end

function aiMatrix3RotationZ(mat, angle)
    ccall((:aiMatrix3RotationZ, assimp), Cvoid, (Ptr{aiMatrix3x3}, Cfloat), mat, angle)
end

function aiMatrix3FromRotationAroundAxis(mat, axis, angle)
    ccall((:aiMatrix3FromRotationAroundAxis, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiVector3D}, Cfloat), mat, axis, angle)
end

function aiMatrix3Translation(mat, translation)
    ccall((:aiMatrix3Translation, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiVector2D}), mat, translation)
end

function aiMatrix3FromTo(mat, from, to)
    ccall((:aiMatrix3FromTo, assimp), Cvoid, (Ptr{aiMatrix3x3}, Ptr{aiVector3D}, Ptr{aiVector3D}), mat, from, to)
end

function aiMatrix4FromMatrix3(dst, mat)
    ccall((:aiMatrix4FromMatrix3, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiMatrix3x3}), dst, mat)
end

function aiMatrix4FromScalingQuaternionPosition(mat, scaling, rotation, position)
    ccall((:aiMatrix4FromScalingQuaternionPosition, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Ptr{aiQuaternion}, Ptr{aiVector3D}), mat, scaling, rotation, position)
end

function aiMatrix4Add(dst, src)
    ccall((:aiMatrix4Add, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiMatrix4x4}), dst, src)
end

function aiMatrix4AreEqual(a, b)
    ccall((:aiMatrix4AreEqual, assimp), Cint, (Ptr{aiMatrix4x4}, Ptr{aiMatrix4x4}), a, b)
end

function aiMatrix4AreEqualEpsilon(a, b, epsilon)
    ccall((:aiMatrix4AreEqualEpsilon, assimp), Cint, (Ptr{aiMatrix4x4}, Ptr{aiMatrix4x4}, Cfloat), a, b, epsilon)
end

function aiMatrix4Inverse(mat)
    ccall((:aiMatrix4Inverse, assimp), Cvoid, (Ptr{aiMatrix4x4},), mat)
end

function aiMatrix4Determinant(mat)
    ccall((:aiMatrix4Determinant, assimp), Cfloat, (Ptr{aiMatrix4x4},), mat)
end

function aiMatrix4IsIdentity(mat)
    ccall((:aiMatrix4IsIdentity, assimp), Cint, (Ptr{aiMatrix4x4},), mat)
end

function aiMatrix4DecomposeIntoScalingEulerAnglesPosition(mat, scaling, rotation, position)
    ccall((:aiMatrix4DecomposeIntoScalingEulerAnglesPosition, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Ptr{aiVector3D}, Ptr{aiVector3D}), mat, scaling, rotation, position)
end

function aiMatrix4DecomposeIntoScalingAxisAnglePosition(mat, scaling, axis, angle, position)
    ccall((:aiMatrix4DecomposeIntoScalingAxisAnglePosition, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Ptr{aiVector3D}, Ptr{ai_real}, Ptr{aiVector3D}), mat, scaling, axis, angle, position)
end

function aiMatrix4DecomposeNoScaling(mat, rotation, position)
    ccall((:aiMatrix4DecomposeNoScaling, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiQuaternion}, Ptr{aiVector3D}), mat, rotation, position)
end

function aiMatrix4FromEulerAngles(mat, x, y, z)
    ccall((:aiMatrix4FromEulerAngles, assimp), Cvoid, (Ptr{aiMatrix4x4}, Cfloat, Cfloat, Cfloat), mat, x, y, z)
end

function aiMatrix4RotationX(mat, angle)
    ccall((:aiMatrix4RotationX, assimp), Cvoid, (Ptr{aiMatrix4x4}, Cfloat), mat, angle)
end

function aiMatrix4RotationY(mat, angle)
    ccall((:aiMatrix4RotationY, assimp), Cvoid, (Ptr{aiMatrix4x4}, Cfloat), mat, angle)
end

function aiMatrix4RotationZ(mat, angle)
    ccall((:aiMatrix4RotationZ, assimp), Cvoid, (Ptr{aiMatrix4x4}, Cfloat), mat, angle)
end

function aiMatrix4FromRotationAroundAxis(mat, axis, angle)
    ccall((:aiMatrix4FromRotationAroundAxis, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Cfloat), mat, axis, angle)
end

function aiMatrix4Translation(mat, translation)
    ccall((:aiMatrix4Translation, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}), mat, translation)
end

function aiMatrix4Scaling(mat, scaling)
    ccall((:aiMatrix4Scaling, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}), mat, scaling)
end

function aiMatrix4FromTo(mat, from, to)
    ccall((:aiMatrix4FromTo, assimp), Cvoid, (Ptr{aiMatrix4x4}, Ptr{aiVector3D}, Ptr{aiVector3D}), mat, from, to)
end

function aiQuaternionFromEulerAngles(q, x, y, z)
    ccall((:aiQuaternionFromEulerAngles, assimp), Cvoid, (Ptr{aiQuaternion}, Cfloat, Cfloat, Cfloat), q, x, y, z)
end

function aiQuaternionFromAxisAngle(q, axis, angle)
    ccall((:aiQuaternionFromAxisAngle, assimp), Cvoid, (Ptr{aiQuaternion}, Ptr{aiVector3D}, Cfloat), q, axis, angle)
end

function aiQuaternionFromNormalizedQuaternion(q, normalized)
    ccall((:aiQuaternionFromNormalizedQuaternion, assimp), Cvoid, (Ptr{aiQuaternion}, Ptr{aiVector3D}), q, normalized)
end

function aiQuaternionAreEqual(a, b)
    ccall((:aiQuaternionAreEqual, assimp), Cint, (Ptr{aiQuaternion}, Ptr{aiQuaternion}), a, b)
end

function aiQuaternionAreEqualEpsilon(a, b, epsilon)
    ccall((:aiQuaternionAreEqualEpsilon, assimp), Cint, (Ptr{aiQuaternion}, Ptr{aiQuaternion}, Cfloat), a, b, epsilon)
end

function aiQuaternionNormalize(q)
    ccall((:aiQuaternionNormalize, assimp), Cvoid, (Ptr{aiQuaternion},), q)
end

function aiQuaternionConjugate(q)
    ccall((:aiQuaternionConjugate, assimp), Cvoid, (Ptr{aiQuaternion},), q)
end

function aiQuaternionMultiply(dst, q)
    ccall((:aiQuaternionMultiply, assimp), Cvoid, (Ptr{aiQuaternion}, Ptr{aiQuaternion}), dst, q)
end

function aiQuaternionInterpolate(dst, start, _end, factor)
    ccall((:aiQuaternionInterpolate, assimp), Cvoid, (Ptr{aiQuaternion}, Ptr{aiQuaternion}, Ptr{aiQuaternion}, Cfloat), dst, start, _end, factor)
end
# Julia wrapper for header: material.h
# Automatically generated using Clang.jl


function TextureTypeToString(in)
    ccall((:TextureTypeToString, assimp), Cstring, (aiTextureType,), in)
end

function aiGetMaterialProperty(pMat, pKey, type, index, pPropOut)
    ccall((:aiGetMaterialProperty, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{Ptr{aiMaterialProperty}}), pMat, pKey, type, index, pPropOut)
end

function aiGetMaterialFloatArray(pMat, pKey, type, index, pOut, pMax)
    ccall((:aiGetMaterialFloatArray, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{ai_real}, Ptr{UInt32}), pMat, pKey, type, index, pOut, pMax)
end

function aiGetMaterialIntegerArray(pMat, pKey, type, index, pOut, pMax)
    ccall((:aiGetMaterialIntegerArray, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{Cint}, Ptr{UInt32}), pMat, pKey, type, index, pOut, pMax)
end

function aiGetMaterialColor(pMat, pKey, type, index, pOut)
    ccall((:aiGetMaterialColor, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{aiColor4D}), pMat, pKey, type, index, pOut)
end

function aiGetMaterialUVTransform(pMat, pKey, type, index, pOut)
    ccall((:aiGetMaterialUVTransform, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{aiUVTransform}), pMat, pKey, type, index, pOut)
end

function aiGetMaterialString(pMat, pKey, type, index, pOut)
    ccall((:aiGetMaterialString, assimp), aiReturn, (Ptr{aiMaterial}, Cstring, UInt32, UInt32, Ptr{aiString}), pMat, pKey, type, index, pOut)
end

function aiGetMaterialTextureCount(pMat, type)
    ccall((:aiGetMaterialTextureCount, assimp), UInt32, (Ptr{aiMaterial}, aiTextureType), pMat, type)
end

function aiGetMaterialTexture(mat, type, index, path, mapping, uvindex, blend, op, mapmode, flags)
    ccall((:aiGetMaterialTexture, assimp), aiReturn, (Ptr{aiMaterial}, aiTextureType, UInt32, Ptr{aiString}, Ptr{aiTextureMapping}, Ptr{UInt32}, Ptr{ai_real}, Ptr{aiTextureOp}, Ptr{aiTextureMapMode}, Ptr{UInt32}), mat, type, index, path, mapping, uvindex, blend, op, mapmode, flags)
end
# Julia wrapper for header: qnan.h
# Automatically generated using Clang.jl


function is_qnan()
    ccall((:is_qnan, assimp), Cint, ())
end

function is_special_float()
    ccall((:is_special_float, assimp), Cint, ())
end

function get_qnan()
    ccall((:get_qnan, assimp), ai_real, ())
end
# Julia wrapper for header: version.h
# Automatically generated using Clang.jl


function aiGetLegalString()
    ccall((:aiGetLegalString, assimp), Cstring, ())
end

function aiGetVersionPatch()
    ccall((:aiGetVersionPatch, assimp), UInt32, ())
end

function aiGetVersionMinor()
    ccall((:aiGetVersionMinor, assimp), UInt32, ())
end

function aiGetVersionMajor()
    ccall((:aiGetVersionMajor, assimp), UInt32, ())
end

function aiGetVersionRevision()
    ccall((:aiGetVersionRevision, assimp), UInt32, ())
end

function aiGetBranchName()
    ccall((:aiGetBranchName, assimp), Cstring, ())
end

function aiGetCompileFlags()
    ccall((:aiGetCompileFlags, assimp), UInt32, ())
end
