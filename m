Return-Path: <linux-wireless+bounces-8087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADD8CFE4C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA293B22055
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A713B2BC;
	Mon, 27 May 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BGsPO+4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E513AA32
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806679; cv=none; b=Uw+Nv9/V6yrMC8asn0f54OeWsPO8Q3CwXEmv8VmZMeyXtHpW4i0KDskLFwLhur8RXbNrDdrAuv6kKXla0hZ4z5pCgIw1GU5cgwedp+BdOhMNyGZ5BPugnzI5GnBGtkrfBChxPq06ooia38yHwlRyvF3WzD4U4pDUh1GhOubjP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806679; c=relaxed/simple;
	bh=ZqvHPNPPzns+w3YE4y0x7CCHo8YWUjWviaBd1klascw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ad8PEUvBtp4il2Q4Mo1OIECRJb4Q0D/gPxzmfhxKq5x8513gN4Px1+rbBwgibYVpFukDbqbdP8yiBuj5oOENnMTflNbdX38ARUzAEoPu7PQqPNAwAJHrX+EsLBiSbwMuCLNL9ADwGap5iKyUxbl5ENtC09MXwMyrDk4LBwilWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BGsPO+4B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R0pAfN028592;
	Mon, 27 May 2024 10:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zS2upqEJPTc2o+bpoUmAK7s8Ws9weTQuIUuSl+5jx3o=; b=BGsPO+4BVcc91agQ
	LyOeFJqOQErQ21OymzitmyiXh6Bf6nfUOiP+654ZSnJn+mfGY++HLpJb5Yfc7j/l
	Ff0vbw+LmZIta8Oga/htlFCWRwQGOZrtLUgL7+QZExHlSh93dV1fxBxsIvC4bXgw
	ed/gWsELP/yMZeY5kXTe/uDr7rG8yXFLEKARukLdlbeGpSoW4mrL5alNX7aRoZvR
	1CiSviUc0KCYCnJkbepq7FlteetvHX5MeuU9j7Sm8n56IJmimOshZWKX5IoCwp0v
	325kxyReIP68DsFyS3+xgsKRgIMeFK/SM6yTPJFBbsCNViA/SPdCRhuggxaQEUBV
	Z5g3fA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj3bhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 10:44:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RAiRah002700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 10:44:27 GMT
Received: from [10.152.203.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 03:44:26 -0700
Message-ID: <b3b577f6-507f-4373-b380-2b011bcc826e@quicinc.com>
Date: Mon, 27 May 2024 16:14:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] wifi: ath12k: Add support to enable
 debugfs_htt_stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <874jarehpf.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <874jarehpf.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JNEGPvLIYwzFrigq_yV2Z48sICbnQ7U8
X-Proofpoint-ORIG-GUID: JNEGPvLIYwzFrigq_yV2Z48sICbnQ7U8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270087



On 5/21/2024 1:10 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> Bring in the basic infrastructure necessary for enabling htt_stats via debugfs.
>> Patch series bring support to request stats type to firmware, dump the stats
>> and request to reset the stats from firmware.
>>
>> Schema with one ath12k device:
>>
>> ath12k
>> `-- pci-0000:06:00.0
>>     |-- mac0
>>         `-- htt_stats
>>         |-- htt_stats_type
>>         |-- htt_stats_reset
>>
>> Dinesh Karthikeyan (3):
>>   wifi: ath12k: Add support to enable debugfs_htt_stats
>>   wifi: ath12k: Add htt_stats_dump file ops support
>>   wifi: ath12k: Add support to parse requested stats_type
>>
>> Lingbo Kong (1):
>>   wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
>>
>> Ramya Gnanasekar (1):
>>   wifi: ath12k: Dump additional Tx PDEV HTT stats
> 
> I did a quick test with WCN7850:
> 
> cd /sys/kernel/debug/ath12k/pci-0000:06:00.0/mac0
> echo 1 > htt_stats_type 
> cat htt_stats
> 
> And in the dmesg I see:
> 
> [  178.634501] ==================================================================
> [  178.634870] BUG: KASAN: slab-out-of-bounds in skip_spaces+0x105/0x110
> [  178.635156] Read of size 1 at addr ffff888109d4696a by task bash/1474
> [  178.635367] 
> [  178.635513] CPU: 1 PID: 1474 Comm: bash Not tainted 6.9.0-wt-ath+ #1523
> [  178.635747] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [  178.636078] Call Trace:
> [  178.636238]  <TASK>
> [  178.636393]  dump_stack_lvl+0x7d/0xe0
> [  178.636578]  print_address_description.constprop.0+0x33/0x3a0
> [  178.636786]  print_report+0xb5/0x260
> [  178.637004]  ? kasan_complete_mode_report_info+0x3c/0x1a0
> [  178.637211]  kasan_report+0xd8/0x110
> [  178.637353]  ? skip_spaces+0x105/0x110
> [  178.637392]  ? skip_spaces+0x105/0x110
> [  178.637433]  __asan_report_load1_noabort+0x14/0x20
> [  178.637488]  skip_spaces+0x105/0x110
> [  178.637526]  vsscanf+0x3e9/0x3100
> [  178.637573]  ? ip6_compressed_string+0xb80/0xb80
> [  178.637614]  ? debug_smp_processor_id+0x17/0x20
> [  178.637655]  ? __lock_release.isra.0+0x49c/0xae0
> [  178.637696]  ? reacquire_held_locks+0x4d0/0x4d0
> [  178.637736]  ? lock_sync+0x1a0/0x1a0
> [  178.637774]  sscanf+0xa6/0xd0
> [  178.637809]  ? vsscanf+0x3100/0x3100
> [  178.637846]  ? __might_fault+0x119/0x170
> [  178.637933]  ? __might_fault+0xc0/0x170
> [  178.637983]  ? __kasan_check_write+0x14/0x20
> [  178.638023]  ath12k_write_htt_stats_type+0x122/0x330 [ath12k]
> [  178.638092]  ? ath12k_open_htt_stats+0xbe0/0xbe0 [ath12k]
> [  178.638515]  full_proxy_write+0xf8/0x180
> [  178.638563]  vfs_write+0x220/0x1200
> [  178.638601]  ? do_user_addr_fault+0x3f5/0xbb0
> [  178.638640]  ? reacquire_held_locks+0x220/0x4d0
> [  178.638680]  ? kernel_write+0x680/0x680
> [  178.638720]  ? __kasan_check_read+0x11/0x20
> [  178.638757]  ? __fget_light+0x53/0x1e0
> [  178.638796]  ksys_write+0x10e/0x230
> [  178.638833]  ? __ia32_sys_read+0xa0/0xa0
> [  178.638917]  ? debug_smp_processor_id+0x17/0x20
> [  178.638959]  __x64_sys_write+0x6d/0xa0
> [  178.638997]  ? lockdep_hardirqs_on+0x7d/0x100
> [  178.639036]  x64_sys_call+0x9cf/0x9e0
> [  178.639073]  do_syscall_64+0x65/0x130
> [  178.639111]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  178.639721] RIP: 0033:0x7f35ca96b297
> [  178.640363] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  178.641642] RSP: 002b:00007fff7addfa38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  178.642327] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f35ca96b297
> [  178.643013] RDX: 0000000000000002 RSI: 000055c737df4390 RDI: 0000000000000001
> [  178.643652] RBP: 000055c737df4390 R08: 000000000000000a R09: 0000000000000001
> [  178.644332] R10: 000055c703828017 R11: 0000000000000246 R12: 0000000000000002
> [  178.645010] R13: 00007f35caa4a6a0 R14: 00007f35caa464a0 R15: 00007f35caa458a0
> [  178.645643]  </TASK>
> [  178.646321] 
> [  178.646984] Allocated by task 1474 on cpu 1 at 178.634368s:
> [  178.647616]  kasan_save_stack+0x26/0x50
> [  178.648290]  kasan_save_track+0x18/0x60
> [  178.648955]  kasan_save_alloc_info+0x37/0x40
> [  178.649560]  __kasan_kmalloc+0x90/0xa0
> [  178.650197]  __kmalloc+0x1be/0x3f0
> [  178.650765]  ath12k_write_htt_stats_type+0xc1/0x330 [ath12k]
> [  178.651408]  full_proxy_write+0xf8/0x180
> [  178.652029]  vfs_write+0x220/0x1200
> [  178.652583]  ksys_write+0x10e/0x230
> [  178.653181]  __x64_sys_write+0x6d/0xa0
> [  178.653726]  x64_sys_call+0x9cf/0x9e0
> [  178.654319]  do_syscall_64+0x65/0x130
> [  178.654844]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  178.655410] 
> [  178.655970] The buggy address belongs to the object at ffff888109d46968#012[  178.655970]  which belongs to the cache kmalloc-8 of size 8
> [  178.657054] The buggy address is located 0 bytes to the right of#012[  178.657054]  allocated 2-byte region [ffff888109d46968, ffff888109d4696a)
> [  178.658142] 
> [  178.658668] The buggy address belongs to the physical page:
> [  178.659256] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888109d46a08 pfn:0x109d46
> [  178.659824] flags: 0x200000000000a00(workingset|slab|node=0|zone=2)
> [  178.660438] page_type: 0xffffffff()
> [  178.661053] raw: 0200000000000a00 ffff88810004c3c0 ffffea0004275850 ffff8881000403d0
> [  178.661637] raw: ffff888109d46a08 0000000000190010 00000001ffffffff 0000000000000000
> [  178.662265] page dumped because: kasan: bad access detected
> [  178.662872] 
> [  178.663475] Memory state around the buggy address:
> [  178.664108]  ffff888109d46800: fc fc fc fc fc fa fc fc fc fc fc fc fc fc fc fc
> [  178.664710]  ffff888109d46880: fc fc fc fc fc fc fc fc fc fa fc fc fc fc fc fc
> [  178.665972] >ffff888109d46900: fc fc fc fc fc fc fc fc fc fc fc fc fc 02 fc fc
> [  178.666571]                                                           ^
> [  178.667223]  ffff888109d46980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  178.667836]  ffff888109d46a00: fc fa fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  178.668488] ==================================================================
> [  178.669233] Disabling lock debugging due to kernel taint
> 

Thanks Kalle. I was not facing this in QCN9274. May be I will check my
.config to confirm whether KASAN config is enabled.

