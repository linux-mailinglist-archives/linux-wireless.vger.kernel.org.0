Return-Path: <linux-wireless+bounces-9516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C2915D6A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 05:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0119F1F22492
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045571B47;
	Tue, 25 Jun 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WVFGrptx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C32F56;
	Tue, 25 Jun 2024 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287072; cv=none; b=Fsy3cPXnFx32/104XOFZA7qE9vcUDxxV6dd5OpRW923HbzHkD4VUdOj1gFIrgdTJbwP2HLtkEkHcolbB7gvhim3VkvLE66zeV/mM94inJkybZmHwwqTGpaEKVgntJNRGyy68FM+fYf59gqhI4AJxcAag/AOdLLiqt3iolRExH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287072; c=relaxed/simple;
	bh=6EMafBGH3lZGZh1R5u1ZykvmkKcRw2eLTZHoaWukykw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=G8qfmQUIMDyxUshIneqKUnCBPzihivIOHzeO44RWk8IzsJ/UE0atCXGF4J/od7WOp7VrnSYweENgkBjBYAz6cPggshdp0StneNz5WLKPCLbuPOouWeKJ0+7Eq9QZMzkiU+KSx22/PK3o7EEZECbW8jTFv51d35TcjMzkoO5dx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WVFGrptx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJM3FC018145;
	Tue, 25 Jun 2024 03:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FhE/XN7HbqOcNLinT/I0utbiZjY1u/vFS/ijB5Q+2UA=; b=WVFGrptxI06Augd0
	cslLmg71MEroPFpn7FGkPfy30V9iYHx2LbNkVh6T7OOCXTeUAJqA9R08MopNRm3L
	p+41fFnNePXRciSB5PmyMleaczDfrjGMAEwJ4j5FPpOrGoDXFZR+DUW7JLATJGaM
	IjRdKbTjocXyvEgNwJ/JOB4G4QjPSmyYsOCZgYopPjMROzl/i86paKGeUJtiq9v9
	VG0au69ClxwOiPz0Ol9cpzsfDBpuuW5odERHIUAOz3HL3mfEM25/z+5NizzSuI9x
	FctFXHrzEFls+8Jm4gRjLB2krj3VcPAwFuO1tglnPL+kPp7SlbceuqYj2cwSTUtc
	eMFv0g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6n9eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 03:44:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P3iDNm012853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 03:44:13 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 20:44:12 -0700
Message-ID: <c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
Date: Mon, 24 Jun 2024 20:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ieee80211.h virtual_map splat
Content-Language: en-US
To: Koen Vandeputte <koen.vandeputte@citymesh.com>,
        <ath10k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <netdev@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
        Kees
 Cook <keescook@chromium.org>
In-Reply-To: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UQjx-IszhvKKCdE0R4jfygcx3Ald-VBB
X-Proofpoint-ORIG-GUID: UQjx-IszhvKKCdE0R4jfygcx3Ald-VBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_22,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=561 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250027

On 6/21/2024 1:04 AM, Koen Vandeputte wrote:
> Hi all,
> 
> Within OpenWRT, we switched to kernel 6.6 some time ago.
> 
> During testing on a WiFi WDS setup (ath10k), I noticed an old standing
> bug which now prints a lot more data due to the kernel upgrade:
> 
> - All WDS stations are connected
> - The splat occurs
> - All WDS station seem to go in timeout and disconnect
> - The behavior is fixed after a reboot
> 
> Yes, we use ath10k-ct over here, but this part of the code is
> identical to upstream ath10k.
> 
> The main issue:
> 
> memcpy: detected field-spanning write (size 64) of single field
> "tim->virtual_map" at
> ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
> (size 1)
> 
> 
> looks like virtual_map is defined as  "u8 virtual_map[1]", triggering
> that error within "include/linux/ieee80211.h"
> 
> /**
>  * struct ieee80211_tim_ie - Traffic Indication Map information element
>  * @dtim_count: DTIM Count
>  * @dtim_period: DTIM Period
>  * @bitmap_ctrl: Bitmap Control
>  * @virtual_map: Partial Virtual Bitmap
>  *
>  * This structure represents the payload of the "TIM element" as
>  * described in IEEE Std 802.11-2020 section 9.4.2.5.
>  */
> struct ieee80211_tim_ie {
>         u8 dtim_count;
>         u8 dtim_period;
>         u8 bitmap_ctrl;
>         /* variable size: 1 - 251 bytes */
>         u8 virtual_map[1];
> } __packed;
> 
> 
> According to this page, defining it this way is actually deprecated:
> https://www.kernel.org/doc/html/latest/process/deprecated.html
> 
> What is the correct way to fix this?
> Converting it to "u8 virtual_map[];"  ?

Adding netdev to the initial message in the thread.
https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/

There was some discussion in the thread, with the observation that the splat 
is fixed by:
2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")

Followed by discussion if this should be backported.

Kees said that "netdev [...] maintainers have asked that contributors not 
include "Cc: stable" tags, as they want to evaluate for themselves whether 
patches should go to stable or not"

So the purpose of this message is to notify the netdev maintainers that this 
issue has been observed on a LTS kernel with the popular OpenWrt package so 
that the maintainers can make a backporting decision.

/jeff


> [29009.581820] ------------[ cut here ]------------
> [29009.581898] WARNING: CPU: 0 PID: 0 at
> ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
> ath10k_wmi_event_host_swba+0x7c4/0x824 [ath10k_core]
> [29009.585574] memcpy: detected field-spanning write (size 64) of
> single field "tim->virtual_map" at
> ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
> (size 1)
> [29009.712626]  unwind_backtrace from show_stack+0x10/0x14
> [29009.717217]  show_stack from dump_stack_lvl+0x40/0x4c
> [29009.722337]  dump_stack_lvl from __warn+0x94/0xbc
> [29009.727546]  __warn from warn_slowpath_fmt+0xf8/0x15c
> [29009.732233]  warn_slowpath_fmt from
> ath10k_wmi_event_host_swba+0x7c4/0x824 [ath10k_core]
> [29009.737309]  ath10k_wmi_event_host_swba [ath10k_core] from
> ath10k_wmi_10_4_op_rx+0x444/0x6a4 [ath10k_core]
> [29009.745437]  ath10k_wmi_10_4_op_rx [ath10k_core] from
> ath10k_htc_rx_completion_handler+0xa8/0x210 [ath10k_core]
> [29009.754899]  ath10k_htc_rx_completion_handler [ath10k_core] from
> ath10k_pci_fw_dump_work+0xf28/0xf94 [ath10k_pci]
> [29009.764894]  ath10k_pci_fw_dump_work [ath10k_pci] from
> ath10k_ce_per_engine_service+0x64/0x84 [ath10k_core]
> [29009.775299]  ath10k_ce_per_engine_service [ath10k_core] from
> ath10k_ce_per_engine_service_any+0x74/0x194 [ath10k_core]
> [29009.784848]  ath10k_ce_per_engine_service_any [ath10k_core] from
> ath10k_pci_napi_poll+0x44/0x138 [ath10k_pci]
> [29009.795611]  ath10k_pci_napi_poll [ath10k_pci] from
> __napi_poll.constprop.0+0x2c/0x180
> [29009.805589]  __napi_poll.constprop.0 from net_rx_action+0x140/0x2e8
> [29009.813400]  net_rx_action from __do_softirq+0x100/0x270
> [29009.819561]  __do_softirq from irq_exit+0x88/0xb4
> [29009.825117]  irq_exit from call_with_stack+0x18/0x20
> [29009.829715]  call_with_stack from __irq_svc+0x80/0x98
> [29009.834751] Exception stack(0xc0d01f28 to 0xc0d01f70)
> [29009.839706] 1f20:                   00000003 00000001 1d2e2e44
> 40000000 00000000 c0d04f68
> [29009.844745] 1f40: c0d084c0 c0d04fa0 00000000 00000000 c0d04f08
> 00000000 0000001f c0d01f78
> [29009.852898] 1f60: c09deaf8 c09df260 60000013 ffffffff
> [29009.861055]  __irq_svc from default_idle_call+0x2c/0x30
> [29009.866089]  default_idle_call from do_idle+0x1d8/0x228
> [29009.871124]  do_idle from cpu_startup_entry+0x28/0x2c
> [29009.876328]  cpu_startup_entry from kernel_init+0x0/0x12c
> [29009.881537]  kernel_init from arch_post_acpi_subsys_init+0x0/0x8
> [29009.886973] ---[ end trace 0000000000000000 ]---


