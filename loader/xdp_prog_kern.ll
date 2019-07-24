; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !18
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_abort_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_drop_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_pass_func(%struct.xdp_md* nocapture readonly) #0 section "xdp_pass" !dbg !43 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !58, metadata !DIExpression()), !dbg !60
  call void @llvm.dbg.value(metadata i32 2, metadata !59, metadata !DIExpression()), !dbg !61
  %3 = bitcast i32* %2 to i8*, !dbg !62
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !62
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !62
  call void @llvm.dbg.value(metadata i32 2, metadata !68, metadata !DIExpression()) #3, !dbg !82
  store i32 2, i32* %2, align 4, !tbaa !83
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !87
  %5 = load i32, i32* %4, align 4, !dbg !87, !tbaa !88
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !90
  %7 = load i32, i32* %6, align 4, !dbg !90, !tbaa !91
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !92
  %9 = icmp eq i8* %8, null, !dbg !93
  br i1 %9, label %22, label %10, !dbg !95

; <label>:10:                                     ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !96
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !97
  %12 = zext i32 %5 to i64, !dbg !98
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !99
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !100
  %13 = sub nsw i64 %12, %11, !dbg !101
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !102
  %14 = bitcast i8* %8 to i64*, !dbg !103
  %15 = load i64, i64* %14, align 8, !dbg !104, !tbaa !105
  %16 = add i64 %15, 1, !dbg !104
  store i64 %16, i64* %14, align 8, !dbg !104, !tbaa !105
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !108
  %18 = bitcast i8* %17 to i64*, !dbg !108
  %19 = load i64, i64* %18, align 8, !dbg !109, !tbaa !110
  %20 = add i64 %13, %19, !dbg !109
  store i64 %20, i64* %18, align 8, !dbg !109, !tbaa !110
  %21 = load i32, i32* %2, align 4, !dbg !111, !tbaa !83
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !82
  br label %22

; <label>:22:                                     ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !112
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !113
  ret i32 %23, !dbg !114
}

; Function Attrs: nounwind
define dso_local i32 @xdp_drop_func(%struct.xdp_md* nocapture readonly) #0 section "xdp_drop" !dbg !115 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !117, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.value(metadata i32 1, metadata !118, metadata !DIExpression()), !dbg !120
  %3 = bitcast i32* %2 to i8*, !dbg !121
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !121
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !121
  call void @llvm.dbg.value(metadata i32 1, metadata !68, metadata !DIExpression()) #3, !dbg !123
  store i32 1, i32* %2, align 4, !tbaa !83
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !124
  %5 = load i32, i32* %4, align 4, !dbg !124, !tbaa !88
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !125
  %7 = load i32, i32* %6, align 4, !dbg !125, !tbaa !91
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !126
  %9 = icmp eq i8* %8, null, !dbg !127
  br i1 %9, label %22, label %10, !dbg !128

; <label>:10:                                     ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !129
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !130
  %12 = zext i32 %5 to i64, !dbg !131
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !132
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !133
  %13 = sub nsw i64 %12, %11, !dbg !134
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !135
  %14 = bitcast i8* %8 to i64*, !dbg !136
  %15 = load i64, i64* %14, align 8, !dbg !137, !tbaa !105
  %16 = add i64 %15, 1, !dbg !137
  store i64 %16, i64* %14, align 8, !dbg !137, !tbaa !105
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !138
  %18 = bitcast i8* %17 to i64*, !dbg !138
  %19 = load i64, i64* %18, align 8, !dbg !139, !tbaa !110
  %20 = add i64 %13, %19, !dbg !139
  store i64 %20, i64* %18, align 8, !dbg !139, !tbaa !110
  %21 = load i32, i32* %2, align 4, !dbg !140, !tbaa !83
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !123
  br label %22

; <label>:22:                                     ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !141
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !142
  ret i32 %23, !dbg !143
}

; Function Attrs: nounwind
define dso_local i32 @xdp_abort_func(%struct.xdp_md* nocapture readonly) #0 section "xdp_abort" !dbg !144 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !146, metadata !DIExpression()), !dbg !148
  call void @llvm.dbg.value(metadata i32 0, metadata !147, metadata !DIExpression()), !dbg !149
  %3 = bitcast i32* %2 to i8*, !dbg !150
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !150
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !150
  call void @llvm.dbg.value(metadata i32 0, metadata !68, metadata !DIExpression()) #3, !dbg !152
  store i32 0, i32* %2, align 4, !tbaa !83
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !153
  %5 = load i32, i32* %4, align 4, !dbg !153, !tbaa !88
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !154
  %7 = load i32, i32* %6, align 4, !dbg !154, !tbaa !91
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !155
  %9 = icmp eq i8* %8, null, !dbg !156
  br i1 %9, label %22, label %10, !dbg !157

; <label>:10:                                     ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !158
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !159
  %12 = zext i32 %5 to i64, !dbg !160
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !161
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !162
  %13 = sub nsw i64 %12, %11, !dbg !163
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !164
  %14 = bitcast i8* %8 to i64*, !dbg !165
  %15 = load i64, i64* %14, align 8, !dbg !166, !tbaa !105
  %16 = add i64 %15, 1, !dbg !166
  store i64 %16, i64* %14, align 8, !dbg !166, !tbaa !105
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !167
  %18 = bitcast i8* %17 to i64*, !dbg !167
  %19 = load i64, i64* %18, align 8, !dbg !168, !tbaa !110
  %20 = add i64 %13, %19, !dbg !168
  store i64 %20, i64* %18, align 8, !dbg !168, !tbaa !110
  %21 = load i32, i32* %2, align 4, !dbg !169, !tbaa !83
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !152
  br label %22

; <label>:22:                                     ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !170
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !171
  ret i32 %23, !dbg !172
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!39, !40, !41}
!llvm.ident = !{!42}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 11, type: !30, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 (tags/RELEASE_800/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/irevoire/syncookie/loader")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/irevoire/syncookie/loader")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !{!0, !18, !24}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 76, type: !20, isLocal: false, isDefinition: true)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 32, elements: !22)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !{!23}
!23 = !DISubrange(count: 4)
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !26, line: 20, type: !27, isLocal: true, isDefinition: true)
!26 = !DIFile(filename: "../headers/bpf_helpers.h", directory: "/home/irevoire/syncookie/loader")
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DISubroutineType(types: !29)
!29 = !{!15, !15, !15}
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !26, line: 210, size: 224, elements: !31)
!31 = !{!32, !33, !34, !35, !36, !37, !38}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !30, file: !26, line: 211, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !30, file: !26, line: 212, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !30, file: !26, line: 213, baseType: !7, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !30, file: !26, line: 214, baseType: !7, size: 32, offset: 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !30, file: !26, line: 215, baseType: !7, size: 32, offset: 128)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "inner_map_idx", scope: !30, file: !26, line: 216, baseType: !7, size: 32, offset: 160)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "numa_node", scope: !30, file: !26, line: 217, baseType: !7, size: 32, offset: 192)
!39 = !{i32 2, !"Dwarf Version", i32 4}
!40 = !{i32 2, !"Debug Info Version", i32 3}
!41 = !{i32 1, !"wchar_size", i32 4}
!42 = !{!"clang version 8.0.0 (tags/RELEASE_800/final)"}
!43 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 53, type: !44, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !57)
!44 = !DISubroutineType(types: !45)
!45 = !{!46, !47}
!46 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !49)
!49 = !{!50, !53, !54, !55, !56}
!50 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !48, file: !6, line: 2857, baseType: !51, size: 32)
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !52, line: 27, baseType: !7)
!52 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!53 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !48, file: !6, line: 2858, baseType: !51, size: 32, offset: 32)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !48, file: !6, line: 2859, baseType: !51, size: 32, offset: 64)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !48, file: !6, line: 2861, baseType: !51, size: 32, offset: 96)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !48, file: !6, line: 2862, baseType: !51, size: 32, offset: 128)
!57 = !{!58, !59}
!58 = !DILocalVariable(name: "ctx", arg: 1, scope: !43, file: !3, line: 53, type: !47)
!59 = !DILocalVariable(name: "action", scope: !43, file: !3, line: 55, type: !51)
!60 = !DILocation(line: 53, column: 35, scope: !43)
!61 = !DILocation(line: 55, column: 8, scope: !43)
!62 = !DILocation(line: 26, column: 46, scope: !63, inlinedAt: !81)
!63 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 26, type: !64, scopeLine: 27, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !66)
!64 = !DISubroutineType(types: !65)
!65 = !{!51, !47, !51}
!66 = !{!67, !68, !69, !70, !71, !80}
!67 = !DILocalVariable(name: "ctx", arg: 1, scope: !63, file: !3, line: 26, type: !47)
!68 = !DILocalVariable(name: "action", arg: 2, scope: !63, file: !3, line: 26, type: !51)
!69 = !DILocalVariable(name: "data_end", scope: !63, file: !3, line: 28, type: !15)
!70 = !DILocalVariable(name: "data", scope: !63, file: !3, line: 29, type: !15)
!71 = !DILocalVariable(name: "rec", scope: !63, file: !3, line: 35, type: !72)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !74, line: 8, size: 128, elements: !75)
!74 = !DIFile(filename: "./common_kern_user.h", directory: "/home/irevoire/syncookie/loader")
!75 = !{!76, !79}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !73, file: !74, line: 9, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !52, line: 31, baseType: !78)
!78 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !73, file: !74, line: 10, baseType: !77, size: 64, offset: 64)
!80 = !DILocalVariable(name: "bytes", scope: !63, file: !3, line: 40, type: !77)
!81 = distinct !DILocation(line: 57, column: 9, scope: !43)
!82 = !DILocation(line: 26, column: 57, scope: !63, inlinedAt: !81)
!83 = !{!84, !84, i64 0}
!84 = !{!"int", !85, i64 0}
!85 = !{!"omnipotent char", !86, i64 0}
!86 = !{!"Simple C/C++ TBAA"}
!87 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !81)
!88 = !{!89, !84, i64 4}
!89 = !{!"xdp_md", !84, i64 0, !84, i64 4, !84, i64 8, !84, i64 12, !84, i64 16}
!90 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !81)
!91 = !{!89, !84, i64 0}
!92 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !81)
!93 = !DILocation(line: 36, column: 7, scope: !94, inlinedAt: !81)
!94 = distinct !DILexicalBlock(scope: !63, file: !3, line: 36, column: 6)
!95 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !81)
!96 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !81)
!97 = !DILocation(line: 29, column: 8, scope: !63, inlinedAt: !81)
!98 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !81)
!99 = !DILocation(line: 28, column: 8, scope: !63, inlinedAt: !81)
!100 = !DILocation(line: 35, column: 18, scope: !63, inlinedAt: !81)
!101 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !81)
!102 = !DILocation(line: 40, column: 8, scope: !63, inlinedAt: !81)
!103 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !81)
!104 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !81)
!105 = !{!106, !107, i64 0}
!106 = !{!"datarec", !107, i64 0, !107, i64 8}
!107 = !{!"long long", !85, i64 0}
!108 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !81)
!109 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !81)
!110 = !{!106, !107, i64 8}
!111 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !81)
!112 = !DILocation(line: 0, scope: !63, inlinedAt: !81)
!113 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !81)
!114 = !DILocation(line: 57, column: 2, scope: !43)
!115 = distinct !DISubprogram(name: "xdp_drop_func", scope: !3, file: !3, line: 61, type: !44, scopeLine: 62, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !116)
!116 = !{!117, !118}
!117 = !DILocalVariable(name: "ctx", arg: 1, scope: !115, file: !3, line: 61, type: !47)
!118 = !DILocalVariable(name: "action", scope: !115, file: !3, line: 63, type: !51)
!119 = !DILocation(line: 61, column: 35, scope: !115)
!120 = !DILocation(line: 63, column: 8, scope: !115)
!121 = !DILocation(line: 26, column: 46, scope: !63, inlinedAt: !122)
!122 = distinct !DILocation(line: 65, column: 9, scope: !115)
!123 = !DILocation(line: 26, column: 57, scope: !63, inlinedAt: !122)
!124 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !122)
!125 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !122)
!126 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !122)
!127 = !DILocation(line: 36, column: 7, scope: !94, inlinedAt: !122)
!128 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !122)
!129 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !122)
!130 = !DILocation(line: 29, column: 8, scope: !63, inlinedAt: !122)
!131 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !122)
!132 = !DILocation(line: 28, column: 8, scope: !63, inlinedAt: !122)
!133 = !DILocation(line: 35, column: 18, scope: !63, inlinedAt: !122)
!134 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !122)
!135 = !DILocation(line: 40, column: 8, scope: !63, inlinedAt: !122)
!136 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !122)
!137 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !122)
!138 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !122)
!139 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !122)
!140 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !122)
!141 = !DILocation(line: 0, scope: !63, inlinedAt: !122)
!142 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !122)
!143 = !DILocation(line: 65, column: 2, scope: !115)
!144 = distinct !DISubprogram(name: "xdp_abort_func", scope: !3, file: !3, line: 69, type: !44, scopeLine: 70, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !145)
!145 = !{!146, !147}
!146 = !DILocalVariable(name: "ctx", arg: 1, scope: !144, file: !3, line: 69, type: !47)
!147 = !DILocalVariable(name: "action", scope: !144, file: !3, line: 71, type: !51)
!148 = !DILocation(line: 69, column: 36, scope: !144)
!149 = !DILocation(line: 71, column: 8, scope: !144)
!150 = !DILocation(line: 26, column: 46, scope: !63, inlinedAt: !151)
!151 = distinct !DILocation(line: 73, column: 9, scope: !144)
!152 = !DILocation(line: 26, column: 57, scope: !63, inlinedAt: !151)
!153 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !151)
!154 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !151)
!155 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !151)
!156 = !DILocation(line: 36, column: 7, scope: !94, inlinedAt: !151)
!157 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !151)
!158 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !151)
!159 = !DILocation(line: 29, column: 8, scope: !63, inlinedAt: !151)
!160 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !151)
!161 = !DILocation(line: 28, column: 8, scope: !63, inlinedAt: !151)
!162 = !DILocation(line: 35, column: 18, scope: !63, inlinedAt: !151)
!163 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !151)
!164 = !DILocation(line: 40, column: 8, scope: !63, inlinedAt: !151)
!165 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !151)
!166 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !151)
!167 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !151)
!168 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !151)
!169 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !151)
!170 = !DILocation(line: 0, scope: !63, inlinedAt: !151)
!171 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !151)
!172 = !DILocation(line: 73, column: 2, scope: !144)
