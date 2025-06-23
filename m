Return-Path: <linux-wireless+bounces-24350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B5AE3DED
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050D83A69A1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039731BC4E;
	Mon, 23 Jun 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpqTkRmc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2917F7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678253; cv=none; b=SoghQVCT8kCy8UQxjWuvOp9G/HDkheubYd8HTHNOZY7MWq+sf6PZo8B0ItYnL+jh6CChn0Jvb+WB6pwscFO5/495sf50VfjeVGDfMl3aEVKdV7plyRs/lMz+3su7bWrOA2hmsL6ZCGGMBJXqhf8HYL2jMa4cW+omH7IG//PXURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678253; c=relaxed/simple;
	bh=EK84rHMVB9MNo8PxQeRZ/KxhBQsDBYKzv5sViwerq1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdqteaZY4e0r91Ck9xotnmwwS79KWKqoSSKz+2Rgurfka3qYHPe41yqK1ka9lxIpJqlB0sOlG6xc+VaXkQ17q161u3srk5kCEvHvh57ey2BORTC+PPJ/llvAe2oDQqaHoqtecLzhzqfeA8YP3InmRCAiHtdSTd5gIh0kgpX5R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpqTkRmc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7fYOO021714
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cC0a82Nqr1oRMitqgiqnc83OcyyPlsb8y8XBEn5qyaM=; b=BpqTkRmcubsKFMNu
	4OIlTxSx1xvufjPLinppwQUCCGygjmsYukmlHkRv23imXUSuXHUzDEDX4MWOHge1
	TyQeGjVTQTj6+uQl91LDFcllScSIGl3fL+sWRawsj0Ymc7zyjLTPyhWeEerxTlxI
	GvkcN6B7YrN/YDHMnrCeYXsgjdjkNCIUfEL7n76Cu0ohuoisumiGdHOXrUru+yQL
	mX2JwceQL+NjEY1lX0Ct8du17lwvIi8HX9O/aO7p/6NxCTHyk7m6XBBpJ73P0yPH
	dvFrSylROwC9jizFIuHDZLHCmgYcvtqhlpZHX/4zRaZE/bxD6llL6sxjkeN66QHM
	CZAO6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rprmct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 11:30:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d0a9d20c2eso110140785a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 04:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750678246; x=1751283046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC0a82Nqr1oRMitqgiqnc83OcyyPlsb8y8XBEn5qyaM=;
        b=awWnJoOnZV5eBPF7ZwNfgZzrdsLwymtb89UfXdoAWZ8GIvPD/OVdlXjiLigKVbgko7
         dhhe36ibSoIAtf5ug191CXalX1kQx8tZCrL6o3zyEdcTW5H4rFAA5oS1E747YDkFJFBp
         swDRJnDQsWCxH9soXEgwlCrrhnspK2TVzzdTbLpmME6mVS5Hcu4KRL5R83kByQwqVIM9
         FmMs6N7td1LoEqQFxCcXBxj8XjKCENICmuAtDNnJI4YRxtl1SSQFw0LgW1cd7tgF2Y34
         O00P+rWIRHk87cwWf6pt4Y/eXaBrWHvy8gdm3SDsKzq4wWwUNmu8sASWGQj99D0ps416
         RGVg==
X-Gm-Message-State: AOJu0YwbD/UmEXc6JXsBsD6QQxfd+0d+ZFDqn0nIjAnVOtIv2Kny7rAA
	qGP+Sd5qNs6qpEUqoaKqtjk5aGXMR2XTQxRjakRTctQtnL0mfoqHXN0nAxMry4HhWT0v6oabNtI
	Y3mLq9twvvZvKpMz0uO13u7GCHCTiut5tHa/TDARBHXbHNWGqtLgPvdzjKBrN9ExcKz2A9nL0J6
	o9HQ==
X-Gm-Gg: ASbGncvv/hWrYAPaeYlhQr+OZR+hE14U4NdP7/OKZdGxS1HU0VRUnSvbtDw7Fmcc3Dq
	fVrU/d47VuBgVC/7AOIswCUe2QoiClOSwULO2WbAyq4DDljqpbfKYF4XjYpYajTbVs/enfQmVGx
	s5w8bkSrVb6kGa9tNPhT2A9D0+6cEeEqk4+3OzjUXv6sMtWf9Pfgfzxd/BLZV7miMQ2plwgUiIM
	YqVOJDp/OF9EnXbUyCw/1iSYCwYDvQ5xSFdjVrsR5Zna7GHaapG4l4hLfGvd4JDcbS82m4PmzdJ
	uTNo9UdScMevIcESDLXoC8iB9P0FSj/0YM+lnKjNKf9WY1CWMr+8NwQ7f/60PA3SwjWJeuJs6ZS
	nufQ=
X-Received: by 2002:a05:620a:f04:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d3f994246fmr560660185a.11.1750678244591;
        Mon, 23 Jun 2025 04:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdv8hMxrAYrzpXedJ1qpOB6HXMHTmhUs/nSKzVmqqFno+uYD//oV1h5uucfXx+YXIapXenlQ==
X-Received: by 2002:a05:620a:f04:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d3f994246fmr560657085a.11.1750678243288;
        Mon, 23 Jun 2025 04:30:43 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a1505294sm12476766b.83.2025.06.23.04.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 04:30:42 -0700 (PDT)
Message-ID: <08a310dd-6982-4e63-9f6a-02bd9d579167@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 13:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <51da74b0-d8d3-4520-9fc9-06b50b552bb2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <51da74b0-d8d3-4520-9fc9-06b50b552bb2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=68593ae7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=qjP6Q97ROuULwijAGjgA:9
 a=Q9DrPZHZ-Oa1Bcc-:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2OSBTYWx0ZWRfX4B1/6z8sT/j9
 HqrHgj2Yq17Ill+cTMySaYq4gBZsiQ8AeOQjy/mmVGfvdRo9oyJsvSQ8U7AiD9zkcIkIWi8D7AA
 9vIxzCFTh8G563xtD/+Q9a81BvE0E4YnN2cs/SyGGepH19+PykR3hksUaK0PbkkhedER+wURUYq
 RiGkXJEq+qCAl59lcHTzSdJDQd3lw8yCJRjKrcQl3xXS876bI5W8s6zj2fM3AnUeFQyDP1Ko/1u
 aOKIme+KP+RH3fSVND6Cp+m+moMLeF031WJ9lLdPOaTHg7OIWeAwJ1V1ivWdthRg5U18J8EHOy+
 7FD8QCQ0LSrsuBh/lUagdARogFJh9Qlg8qULSSzuOIPW0vWzLPDLSmu3F/1uRFDGrNEOTze3reg
 qKxLmBBR1ISAGf0R2yKCOT4l3Gv4TIeehv2ssDxJ9qM+mCvN+9CdBcgK811MLXY9H/aRqXR9
X-Proofpoint-ORIG-GUID: T8D4oT4tqL7PmnA3NYlcwVUnY_AYe-iZ
X-Proofpoint-GUID: T8D4oT4tqL7PmnA3NYlcwVUnY_AYe-iZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230069

On 6/18/25 4:00 AM, Baochen Qiang wrote:
> 
> 
> On 6/18/2025 8:15 AM, Konrad Dybcio wrote:
>> On 3/28/25 6:32 AM, Baochen Qiang wrote:
>>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
>>> This works for suspend (S3) but breaks for hibernation (S4), because
>>> WoWLAN mode requires WLAN power to be sustained, which is not the case
>>> during hibernation. For hibernation, the default mode should be used.
>>>
>>> Register a PM notifier with which kernel can notify us of the actual PM
>>> operation: if system is going to suspend, the original PM policy is
>>> honored; while if it is hibernation, overwrite it with default policy.
>>>
>>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
>>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
>>> non-WoWLAN mode is chosen for all.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Tested-by: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---

[...]

> Could you share complete kernel dmesg log?

There's nothing interesting in it, but sure..

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b0]
[    0.000000] Linux version 6.16.0-rc3-next-20250623 (konrad@archlinux) (clang version 20.1.6, LLD 20.1.6) #12182 SMP Mon Jun 23 13:27:07 CEST 2025
[    0.000000] KASLR enabled
[    0.000000] Machine model: Qualcomm SC8280XP CRD
[    0.000000] efi: EFI v2.7 by Qualcomm Technologies, Inc.
[    0.000000] efi: ACPI 2.0=0x9e615000 MEMATTR=0x9ba73018 ESRT=0x9b772a18 SMBIOS=0x9e4e9000 RTPROP=0x9e49bf98 TPMEventLog=0x9e5d1018 INITRD=0x8e687e98 RNG=0x9e5d0018 MEMRESERVE=0x8e687018 
[    0.000000] random: crng init done
[    0.000000] TPM Final Events table not present
[    0.000000] esrt: Reserving ESRT space from 0x000000009b772a18 to 0x000000009b772a50.
[    0.000000] Reserved memory: created CMA memory pool at 0x0000000271a00000, size 128 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000271a00000..0x00000002799fffff (131072 KiB) map reusable linux,cma
[    0.000000] earlycon: qcom_geni0 at MMIO 0x0000000000884000 (options '115200n8')
[    0.000000] printk: legacy bootconsole [qcom_geni0] enabled
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008085ffff (8576 KiB) nomap non-reusable reserved-region@80000000
[    0.000000] OF: reserved mem: 0x0000000080860000..0x000000008087ffff (128 KiB) nomap non-reusable cmd-db-region@80860000
[    0.000000] OF: reserved mem: 0x0000000080880000..0x00000000808fffff (512 KiB) nomap non-reusable reserved-region@80880000
[    0.000000] OF: reserved mem: 0x0000000080900000..0x0000000080afffff (2048 KiB) nomap non-reusable smem-region@80900000
[    0.000000] OF: reserved mem: 0x0000000080b00000..0x0000000080bfffff (1024 KiB) nomap non-reusable reserved-region@80b00000
[    0.000000] OF: reserved mem: 0x0000000083b00000..0x00000000851fffff (23552 KiB) nomap non-reusable reserved-region@83b00000
[    0.000000] OF: reserved mem: 0x0000000085b00000..0x00000000866fffff (12288 KiB) nomap non-reusable reserved-region@85b00000
[    0.000000] OF: reserved mem: 0x0000000086c00000..0x0000000088bfffff (32768 KiB) nomap non-reusable adsp-region@86c00000
[    0.000000] OF: reserved mem: 0x0000000088c00000..0x000000008a0fffff (21504 KiB) nomap non-reusable slpi-region@88c00000
[    0.000000] OF: reserved mem: 0x000000008a100000..0x000000008befffff (30720 KiB) nomap non-reusable cdsp0-region@8a100000
[    0.000000] OF: reserved mem: 0x000000008c600000..0x000000008e3fffff (30720 KiB) nomap non-reusable cdsp1-region@8c600000
[    0.000000] OF: reserved mem: 0x00000000aeb00000..0x00000000c50fffff (366592 KiB) nomap non-reusable reserved-region@aeb00000
[    0.000000] OF: reserved mem: 0x000000008bf00000..0x000000008bf01fff (8 KiB) nomap non-reusable gpu-mem@8bf00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080600000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080600000-0x00000000806fffff]
[    0.000000]   node   0: [mem 0x0000000080880000-0x00000000808affff]
[    0.000000]   node   0: [mem 0x00000000808c0000-0x00000000808effff]
[    0.000000]   node   0: [mem 0x0000000080c00000-0x00000000826fffff]
[    0.000000]   node   0: [mem 0x000000008e400000-0x000000009e08dfff]
[    0.000000]   node   0: [mem 0x000000009e08e000-0x000000009e539fff]
[    0.000000]   node   0: [mem 0x000000009e53a000-0x000000009f5cffff]
[    0.000000]   node   0: [mem 0x000000009f5f7000-0x000000009f5fffff]
[    0.000000]   node   0: [mem 0x000000009f600000-0x00000000aeafffff]
[    0.000000]   node   0: [mem 0x00000000aeb00000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x00000000c6200000-0x00000000c85fffff]
[    0.000000]   node   0: [mem 0x00000000c8600000-0x0000000279b65fff]
[    0.000000]   node   0: [mem 0x0000000279b66000-0x000000027dffffff]
[    0.000000]   node   0: [mem 0x000000027e000000-0x000000027fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080600000-0x000000027fffffff]
[    0.000000] On node 0, zone DMA: 1536 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 384 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 16 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 784 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 48384 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 39 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 25088 pages in unavailable ranges
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] psci: OSI mode supported.
[    0.000000] psci: [Firmware Bug]: failed to set PC mode: -3
[    0.000000] percpu: Embedded 32 pages/cpu s92496 r8192 d30384 u131072
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (architected QARMA5 algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: SSBS not fully self-synchronizing
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: clk_ignore_unused earlycon console=ttyMSM0 no_console_suspend PMOS_NO_OUTPUT_REDIRECT root=/dev/nvme0n1p18
[    0.000000] Unknown kernel command line parameters "PMOS_NO_OUTPUT_REDIRECT", will be passed to user space.
[    0.000000] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2020921
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Running RCU synchronous self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU lockdep checking is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] Running RCU synchronous self tests
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICD_CTRL.DS=0, SCR_EL3.FIQ=1
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000017a60000
[    0.000000] ITS [mem 0x17a40000-0x17a5ffff]
[    0.000000] ITS@0x0000000017a40000: allocated 8192 Devices @100160000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000017a40000: allocated 32768 Interrupt Collections @100170000 (flat, esz 2, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000100180000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000100190000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000000] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.008451] Console: colour dummy device 80x25
[    0.013029] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.020983] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.025192] ... MAX_LOCK_DEPTH:          48
[    0.029490] ... MAX_LOCKDEP_KEYS:        8192
[    0.033971] ... CLASSHASH_SIZE:          4096
[    0.038449] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.043015] ... MAX_LOCKDEP_CHAINS:      65536
[    0.047584] ... CHAINHASH_SIZE:          32768
[    0.052149]  memory used by lock dependency info: 6429 kB
[    0.057696]  memory used for stack traces: 4224 kB
[    0.062619]  per task-struct memory footprint: 1920 bytes
[    0.068188] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.078817] pid_max: default: 32768 minimum: 301
[    0.083641] LSM: initializing lsm=capability,landlock,lockdown,yama,apparmor
[    0.091022] landlock: Up and running.
[    0.094796] Yama: becoming mindful.
[    0.098599] AppArmor: AppArmor initialized
[    0.102878] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.110664] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.119604] Running RCU synchronous self tests
[    0.124185] Running RCU synchronous self tests
[    0.130793] rcu: Hierarchical SRCU implementation.
[    0.135729] rcu:     Max phase no-delay instances is 1000.
[    0.141343] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.150320] Remapping and enabling EFI services.
[    0.155918] smp: Bringing up secondary CPUs ...
[    0.161527] Detected PIPT I-cache on CPU1
[    0.161578] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
[    0.161591] GICv3: CPU1: using allocated LPI pending table @0x00000001001a0000
[    0.161630] CPU1: Booted secondary processor 0x0000000100 [0x410fd4b0]
[    0.162733] Detected PIPT I-cache on CPU2
[    0.162772] GICv3: CPU2: found redistributor 200 region 0:0x0000000017aa0000
[    0.162783] GICv3: CPU2: using allocated LPI pending table @0x00000001001b0000
[    0.162815] CPU2: Booted secondary processor 0x0000000200 [0x410fd4b0]
[    0.163818] Detected PIPT I-cache on CPU3
[    0.163856] GICv3: CPU3: found redistributor 300 region 0:0x0000000017ac0000
[    0.163866] GICv3: CPU3: using allocated LPI pending table @0x00000001001c0000
[    0.163897] CPU3: Booted secondary processor 0x0000000300 [0x410fd4b0]
[    0.167027] Detected PIPT I-cache on CPU4
[    0.167072] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
[    0.167082] GICv3: CPU4: using allocated LPI pending table @0x00000001001d0000
[    0.167108] CPU4: Booted secondary processor 0x0000000400 [0x410fd4c0]
[    0.168114] Detected PIPT I-cache on CPU5
[    0.168148] GICv3: CPU5: found redistributor 500 region 0:0x0000000017b00000
[    0.168158] GICv3: CPU5: using allocated LPI pending table @0x00000001001e0000
[    0.168186] CPU5: Booted secondary processor 0x0000000500 [0x410fd4c0]
[    0.169189] Detected PIPT I-cache on CPU6
[    0.169223] GICv3: CPU6: found redistributor 600 region 0:0x0000000017b20000
[    0.169232] GICv3: CPU6: using allocated LPI pending table @0x00000001001f0000
[    0.169256] CPU6: Booted secondary processor 0x0000000600 [0x410fd4c0]
[    0.170308] Detected PIPT I-cache on CPU7
[    0.170342] GICv3: CPU7: found redistributor 700 region 0:0x0000000017b40000
[    0.170351] GICv3: CPU7: using allocated LPI pending table @0x0000000100200000
[    0.170375] CPU7: Booted secondary processor 0x0000000700 [0x410fd4c0]
[    0.170524] smp: Brought up 1 node, 8 CPUs
[    0.353147] SMP: Total of 8 processors activated.
[    0.357984] CPU: All CPU(s) started at EL1
[    0.362203] CPU features: detected: 32-bit EL0 Support
[    0.367484] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.376331] CPU features: detected: Common not Private translations
[    0.382775] CPU features: detected: CRC32 instructions
[    0.388063] CPU features: detected: Generic authentication (architected QARMA5 algorithm)
[    0.396463] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.402374] CPU features: detected: LSE atomic instructions
[    0.408107] CPU features: detected: Privileged Access Never
[    0.413846] CPU features: detected: PMUv3
[    0.417974] CPU features: detected: RAS Extension Support
[    0.423531] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.430830] alternatives: applying system-wide alternatives
[    0.439323] CPU features: detected: Hardware dirty bit management on CPU0-7
[    0.446746] Memory: 7227424K/8083684K available (24320K kernel code, 6950K rwdata, 37396K rodata, 1472K init, 12462K bss, 714844K reserved, 131072K cma-reserved)
[    0.463120] devtmpfs: initialized
[    0.495119] Running RCU synchronous self tests
[    0.499774] Running RCU synchronous self tests
[    0.504485] Running RCU Tasks Trace wait API self tests
[    0.558311] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.568458] posixtimers hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    0.576265] futex hash table entries: 2048 (262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
[    0.585637] 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.592080] 0 pages in range for non-PLT usage
[    0.592083] 503584 pages in range for PLT usage
[    0.596853] pinctrl core: initialized pinctrl subsystem
[    0.607765] SMBIOS 3.3 present.
[    0.611007] DMI: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[    0.619333] DMI: Memory slots populated: 1/1
[    0.624958] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.632307] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.639692] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.647790] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.656032] audit: initializing netlink subsys (disabled)
[    0.658327] Callback from call_rcu_tasks_trace() invoked.
[    0.661706] audit: type=2000 audit(0.560:1): state=initialized audit_enabled=0 res=1
[    0.662339] thermal_sys: Registered thermal governor 'step_wise'
[    0.675132] cpuidle: using governor menu
[    0.685494] NET: Registered PF_QIPCRTR protocol family
[    0.690893] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.698017] ASID allocator initialised with 32768 entries
[    0.704189] Serial: AMBA PL011 UART driver
[    0.712988] CPUidle PSCI: Initialized CPU PM domain topology using OSI mode
[    0.729552] /soc@0/ufshc@1d84000: Fixed dependency cycle(s) with /soc@0/phy@1d87000
[    0.737462] /soc@0/phy@1d87000: Fixed dependency cycle(s) with /soc@0/ufshc@1d84000
[    0.746240] /soc@0/phy@88eb000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae90000
[    0.757968] /soc@0/phy@88eb000: Fixed dependency cycle(s) with /soc@0/usb@a6f8800/usb@a600000
[    0.767444] /soc@0/phy@8903000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae98000
[    0.779170] /soc@0/phy@8903000: Fixed dependency cycle(s) with /soc@0/usb@a8f8800/usb@a800000
[    0.788695] /soc@0/usb@a6f8800/usb@a600000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    0.798170] /soc@0/usb@a8f8800/usb@a800000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    0.807247] /soc@0/display-subsystem@ae00000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    0.817681] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    0.833254] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae98000
[    0.848826] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae90000
[    0.864277] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    0.876972] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    0.890187] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    0.905576] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    0.917403] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    0.930374] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    0.944018] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    0.959408] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    0.971231] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    0.984201] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    0.997168] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel
[    1.014765] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    1.030344] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/phy@aec5a00
[    1.042229] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    1.055392] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.069539] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    1.086763] /soc@0/phy@aec5a00: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.095619] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@aec5a00
[    1.104590] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    1.113556] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    1.122701] /soc@0/interrupt-controller@17a00000: Fixed dependency cycle(s) with /soc@0/interrupt-controller@17a00000
[    1.140923] /soc@0/ufshc@1d84000: Fixed dependency cycle(s) with /soc@0/phy@1d87000
[    1.149054] /soc@0/ufshc@1d84000: Fixed dependency cycle(s) with /soc@0/phy@1d87000
[    1.157007] /soc@0/phy@1d87000: Fixed dependency cycle(s) with /soc@0/ufshc@1d84000
[    1.170149] /soc@0/phy@88eb000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae90000
[    1.181878] /soc@0/phy@88eb000: Fixed dependency cycle(s) with /soc@0/usb@a6f8800/usb@a600000
[    1.191864] /soc@0/phy@8903000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae98000
[    1.203578] /soc@0/phy@8903000: Fixed dependency cycle(s) with /soc@0/usb@a8f8800/usb@a800000
[    1.214756] /soc@0/usb@a6f8800/usb@a600000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    1.224816] /soc@0/usb@a8f8800/usb@a800000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    1.234690] /soc@0/display-subsystem@ae00000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.245322] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    1.260966] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae98000
[    1.276610] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae90000
[    1.292055] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    1.304746] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.318252] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    1.333641] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    1.345525] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.358484] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    1.372422] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    1.387810] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    1.399702] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.412666] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    1.425794] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel
[    1.443606] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/display-controller@ae01000
[    1.459178] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/phy@aec5a00
[    1.471047] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000
[    1.484202] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.498702] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    1.516227] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/phy@aec5a00
[    1.528270] /soc@0/phy@aec5a00: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.537597] /soc@0/phy@aec5a00: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.546725] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.559770] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.572757] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.585714] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.598397] /soc@0/display-subsystem@ae00000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    1.608503] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@aec5a00
[    1.617535] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    1.626572] /soc@0/clock-controller@af00000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    1.649985] /soc@0/rsc@18200000/regulators-0: Fixed dependency cycle(s) with /soc@0/rsc@18200000/regulators-0/smps11
[    1.663906] /pmic-glink/connector@0: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    1.672337] /pmic-glink/connector@0: Fixed dependency cycle(s) with /soc@0/usb@a6f8800/usb@a600000
[    1.681795] /pmic-glink/connector@1: Fixed dependency cycle(s) with /soc@0/phy@8903000
[    1.690232] /pmic-glink/connector@1: Fixed dependency cycle(s) with /soc@0/usb@a8f8800/usb@a800000
[    1.701497] /pmic-glink/connector@0: Fixed dependency cycle(s) with /usb0-sbu-mux
[    1.709644] /usb0-sbu-mux: Fixed dependency cycle(s) with /pmic-glink/connector@0
[    1.717616] /pmic-glink/connector@1: Fixed dependency cycle(s) with /usb1-sbu-mux
[    1.725792] /usb1-sbu-mux: Fixed dependency cycle(s) with /pmic-glink/connector@1
[    1.734717] HugeTLB: allocation took 0ms with hugepage_allocation_threads=2
[    1.741880] HugeTLB: allocation took 0ms with hugepage_allocation_threads=2
[    1.749039] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.756020] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    1.762457] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    1.769427] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    1.775866] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.782838] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    1.789280] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    1.796251] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    1.972341] raid6: neonx8   gen() 14133 MB/s
[    2.142425] raid6: neonx4   gen() 12730 MB/s
[    2.312508] raid6: neonx2   gen() 10116 MB/s
[    2.482589] raid6: neonx1   gen()  9179 MB/s
[    2.652671] raid6: int64x8  gen()  5511 MB/s
[    2.822754] raid6: int64x4  gen()  5737 MB/s
[    2.992836] raid6: int64x2  gen()  4992 MB/s
[    3.162919] raid6: int64x1  gen()  3977 MB/s
[    3.167315] raid6: using algorithm neonx8 gen() 14133 MB/s
[    3.343006] raid6: .... xor() 9578 MB/s, rmw enabled
[    3.348111] raid6: using neon recovery algorithm
[    3.353035] ACPI: Interpreter disabled.
[    3.384719] iommu: Default domain type: Translated
[    3.389652] iommu: DMA domain TLB invalidation policy: strict mode
[    3.396749] SCSI subsystem initialized
[    3.400837] usbcore: registered new interface driver usbfs
[    3.406528] usbcore: registered new interface driver hub
[    3.412012] usbcore: registered new device driver usb
[    3.417484] mc: Linux media interface: v0.10
[    3.421910] videodev: Linux video capture interface: v2.00
[    3.427607] pps_core: LinuxPPS API ver. 1 registered
[    3.432717] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.442110] PTP clock support registered
[    3.446197] EDAC MC: Ver: 3.0.0
[    3.449777] scmi_core: SCMI protocol bus registered
[    3.455580] Advanced Linux Sound Architecture Driver Initialized.
[    3.462483] Bluetooth: Core ver 2.22
[    3.466195] NET: Registered PF_BLUETOOTH protocol family
[    3.471654] Bluetooth: HCI device and connection manager initialized
[    3.478199] Bluetooth: HCI socket layer initialized
[    3.483216] Bluetooth: L2CAP socket layer initialized
[    3.488427] Bluetooth: SCO socket layer initialized
[    3.493784] nfc: nfc_init: NFC Core ver 0.1
[    3.498130] NET: Registered PF_NFC protocol family
[    3.503174] vgaarb: loaded
[    3.506204] clocksource: Switched to clocksource arch_sys_counter
[    3.512948] VFS: Disk quotas dquot_6.6.0
[    3.517014] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.524703] AppArmor: AppArmor Filesystem Enabled
[    3.529584] pnp: PnP ACPI: disabled
[    3.540373] NET: Registered PF_INET protocol family
[    3.545503] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    3.554999] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    3.563924] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.571888] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    3.580120] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    3.591053] TCP: Hash tables configured (established 65536 bind 65536)
[    3.597839] UDP hash table entries: 4096 (order: 8, 1048576 bytes, linear)
[    3.605194] UDP-Lite hash table entries: 4096 (order: 8, 1048576 bytes, linear)
[    3.613073] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.619234] RPC: Registered named UNIX socket transport module.
[    3.625322] RPC: Registered udp transport module.
[    3.630168] RPC: Registered tcp transport module.
[    3.635003] RPC: Registered tcp-with-tls transport module.
[    3.640645] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.647692] PCI: CLS 0 bytes, default 64
[    3.651954] Trying to unpack rootfs image as initramfs...
[    3.677757] Initialise system trusted keyrings
[    3.682454] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    3.689359] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.695545] NFS: Registering the id_resolver key type
[    3.700762] Key type id_resolver registered
[    3.705077] Key type id_legacy registered
[    3.709333] fuse: init (API version 7.44)
[    3.714439] cryptd: max_cpu_qlen set to 1000
[    3.729865] NET: Registered PF_ALG protocol family
[    3.734822] xor: measuring software checksum speed
[    3.740012]    8regs           : 13732 MB/sec
[    3.744729]    32regs          : 13811 MB/sec
[    3.749606]    arm64_neon      :  8567 MB/sec
[    3.754082] xor: using function: 32regs (13811 MB/sec)
[    3.759377] Key type asymmetric registered
[    3.763602] Asymmetric key parser 'x509' registered
[    3.768691] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 238)
[    3.776300] io scheduler mq-deadline registered
[    3.780085] Freeing initrd memory: 7384K
[    3.780963] io scheduler kyber registered
[    3.797967] ledtrig-cpu: registered to indicate activity on CPUs
[    3.846097] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    3.859046] /soc@0/display-subsystem@ae00000/displayport-controller@ae98000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    3.871983] /soc@0/display-subsystem@ae00000/displayport-controller@ae90000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    3.884896] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/clock-controller@af00000
[    3.914703] vreg_s1c: Setting 1888000-1888000uV
[    3.914825] vreg_s10b: Setting 1800000-1800000uV
[    3.918439] msm_serial: driver initialized
[    3.919910] vreg_l1c: Setting 1800000-1800000uV
[    3.923491] Error: Driver 'efi-framebuffer' is already registered, aborting...
[    3.924559] vreg_s11b: Setting 1272000-1272000uV
[    3.928701] vreg_l6c: Setting 1800000-2960000uV
[    3.933537] vreg_s12b: Setting 984000-984000uV
[    3.940999] vreg_l7c: Setting 2504000-2504000uV
[    3.945719] vreg_l3b: Setting 1200000-1200000uV
[    3.949428] brd: module loaded
[    3.950436] vreg_l9c: Setting 2960000-2960000uV
[    3.954767] vreg_l4b: Setting 912000-912000uV
[    3.956477] loop: module loaded
[    3.957162] zram: Added device: zram0
[    3.959236] spmi_pmic_arb c440000.spmi: PMIC arbiter version v5 (0x50020000)
[    3.959457] vreg_l13c: Setting 3072000-3072000uV
[    3.964180] vreg_l6b: Setting 880000-880000uV
[    3.987307] tun: Universal TUN/TAP device driver, 1.6
[    4.004918] CAN device driver interface
[    4.009300] PPP generic driver version 2.4.2
[    4.013839] PPP BSD Compression module registered
[    4.018691] PPP Deflate Compression module registered
[    4.023900] PPP MPPE Compression module registered
[    4.030021] usbcore: registered new device driver r8152-cfgselector
[    4.036520] usbcore: registered new interface driver r8152
[    4.042210] usbcore: registered new interface driver asix
[    4.047817] usbcore: registered new interface driver ax88179_178a
[    4.054129] usbcore: registered new interface driver cdc_ether
[    4.060177] usbcore: registered new interface driver net1080
[    4.066045] usbcore: registered new interface driver cdc_subset
[    4.072179] usbcore: registered new interface driver zaurus
[    4.077966] usbcore: registered new interface driver cdc_ncm
[    4.083830] usbcore: registered new interface driver qmi_wwan
[    4.089785] usbcore: registered new interface driver r8153_ecm
[    4.097156] usbcore: registered new interface driver cdc_wdm
[    4.103027] usbcore: registered new interface driver usb-storage
[    4.109365] usbcore: registered new device driver onboard-usb-dev
[    4.115969] UDC core: g_ether: couldn't find an available UDC
[    4.123814] i2c_dev: i2c /dev entries driver
[    4.131511] input: pmic_pwrkey as /devices/platform/soc@0/c440000.spmi/spmi-0/0-00/c440000.spmi:pmic@0:pon@1300/c440000.spmi:pmic@0:pon@1300:pwrkey/input/input0
[    4.161949] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    4.171074] Bluetooth: HCI UART driver ver 2.3
[    4.175650] Bluetooth: HCI UART protocol H4 registered
[    4.180956] Bluetooth: HCI UART protocol QCA registered
[    4.186389] usbcore: registered new interface driver btusb
[    4.194642] sdhci: Secure Digital Host Controller Interface driver
[    4.201017] sdhci: Copyright(c) Pierre Ossman
[    4.205955] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.213825] efifb: probing for efifb
[    4.217572] efifb: No BGRT, not showing boot graphics
[    4.222771] efifb: framebuffer at 0xc6200000, using 8100k, total 8100k
[    4.229525] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    4.235796] efifb: scrolling: redraw
[    4.239495] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    4.246350] fbcon: Deferring console take-over
[    4.250954] fb0: EFI VGA frame buffer device
[    4.259177] usbcore: registered new interface driver usbhid
[    4.264916] usbhid: USB HID core driver
[    4.291044] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 (0,8000003f) counters available
[    4.308706] 
[    4.310258] ======================================================
[    4.316611] WARNING: possible circular locking dependency detected
[    4.322959] 6.16.0-rc3-next-20250623 #12182 Not tainted
[    4.328326] ------------------------------------------------------
[    4.334682] swapper/0/1 is trying to acquire lock:
[    4.339612] ffffce0c91aee7a8 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node_track_caller_noprof+0xb4/0x420
[    4.349369] 
[    4.349369] but task is already holding lock:
[    4.355366] ffffce0c91e4ada8 (icc_bw_lock){+.+.}-{4:4}, at: icc_node_add+0x4c/0x174
[    4.363255] 
[    4.363255] which lock already depends on the new lock.
[    4.363255] 
[    4.371655] 
[    4.371655] the existing dependency chain (in reverse order) is:
[    4.379334] 
[    4.379334] -> #1 (icc_bw_lock){+.+.}-{4:4}:
[    4.385249]        icc_init+0x4c/0x114
[    4.389119]        do_one_initcall+0xf0/0x320
[    4.393607]        do_initcall_level+0xd0/0x174
[    4.398279]        do_initcalls+0x5c/0xa0
[    4.402411]        do_basic_setup+0x20/0x30
[    4.406718]        kernel_init_freeable+0x88/0xf4
[    4.411558]        kernel_init+0x28/0x138
[    4.415698]        ret_from_fork+0x10/0x20
[    4.419922] 
[    4.419922] -> #0 (fs_reclaim){+.+.}-{0:0}:
[    4.425737]        __lock_acquire+0x1524/0x2798
[    4.430406]        lock_acquire+0x114/0x25c
[    4.434719]        fs_reclaim_acquire+0x68/0x94
[    4.439385]        __kmalloc_node_track_caller_noprof+0xb4/0x420
[    4.445559]        devm_kmalloc+0x54/0xcc
[    4.449704]        devm_kvasprintf+0x7c/0xe4
[    4.454100]        devm_kasprintf+0x5c/0x88
[    4.458400]        icc_node_add+0xdc/0x174
[    4.462617]        qcom_osm_l3_probe+0x24c/0x2e8
[    4.467373]        platform_probe+0xb4/0xd4
[    4.471677]        really_probe+0x130/0x354
[    4.475989]        __driver_probe_device+0xac/0x110
[    4.481003]        driver_probe_device+0x44/0x110
[    4.485840]        __driver_attach+0xbc/0x17c
[    4.490322]        bus_for_each_dev+0x88/0xe0
[    4.494807]        driver_attach+0x2c/0x3c
[    4.499024]        bus_add_driver+0xf4/0x22c
[    4.503419]        driver_register+0x70/0x10c
[    4.507904]        __platform_driver_register+0x28/0x38
[    4.513278]        osm_l3_driver_init+0x24/0x34
[    4.517944]        do_one_initcall+0xf0/0x320
[    4.522427]        do_initcall_level+0xd0/0x174
[    4.527087]        do_initcalls+0x5c/0xa0
[    4.531219]        do_basic_setup+0x20/0x30
[    4.535530]        kernel_init_freeable+0x88/0xf4
[    4.540369]        kernel_init+0x28/0x138
[    4.544501]        ret_from_fork+0x10/0x20
[    4.548717] 
[    4.548717] other info that might help us debug this:
[    4.548717] 
[    4.556936]  Possible unsafe locking scenario:
[    4.556936] 
[    4.563014]        CPU0                    CPU1
[    4.567676]        ----                    ----
[    4.572340]   lock(icc_bw_lock);
[    4.575670]                                lock(fs_reclaim);
[    4.581490]                                lock(icc_bw_lock);
[    4.587396]   lock(fs_reclaim);
[    4.590635] 
[    4.590635]  *** DEADLOCK ***
[    4.590635] 
[    4.596723] 3 locks held by swapper/0/1:
[    4.600764]  #0: ffff000080db98f8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x48/0x5c
[    4.609707]  #1: ffffce0c91e4ad18 (icc_lock){+.+.}-{4:4}, at: icc_node_add+0x3c/0x174
[    4.617762]  #2: ffffce0c91e4ada8 (icc_bw_lock){+.+.}-{4:4}, at: icc_node_add+0x4c/0x174
[    4.626082] 
[    4.626082] stack backtrace:
[    4.630562] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc3-next-20250623 #12182 NONE 
[    4.630570] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[    4.630574] Call trace:
[    4.630576]  show_stack+0x20/0x30 (C)
[    4.630583]  __dump_stack+0x30/0x44
[    4.630588]  dump_stack_lvl+0x6c/0x90
[    4.630593]  dump_stack+0x20/0x30
[    4.630597]  print_circular_bug+0x328/0x330
[    4.630605]  check_noncircular+0x154/0x170
[    4.630612]  __lock_acquire+0x1524/0x2798
[    4.630618]  lock_acquire+0x114/0x25c
[    4.630624]  fs_reclaim_acquire+0x68/0x94
[    4.630629]  __kmalloc_node_track_caller_noprof+0xb4/0x420
[    4.630636]  devm_kmalloc+0x54/0xcc
[    4.630644]  devm_kvasprintf+0x7c/0xe4
[    4.630648]  devm_kasprintf+0x5c/0x88
[    4.630651]  icc_node_add+0xdc/0x174
[    4.630659]  qcom_osm_l3_probe+0x24c/0x2e8
[    4.630662]  platform_probe+0xb4/0xd4
[    4.630668]  really_probe+0x130/0x354
[    4.630673]  __driver_probe_device+0xac/0x110
[    4.630678]  driver_probe_device+0x44/0x110
[    4.630682]  __driver_attach+0xbc/0x17c
[    4.630687]  bus_for_each_dev+0x88/0xe0
[    4.630690]  driver_attach+0x2c/0x3c
[    4.630694]  bus_add_driver+0xf4/0x22c
[    4.630698]  driver_register+0x70/0x10c
[    4.630703]  __platform_driver_register+0x28/0x38
[    4.630709]  osm_l3_driver_init+0x24/0x34
[    4.630712]  do_one_initcall+0xf0/0x320
[    4.630717]  do_initcall_level+0xd0/0x174
[    4.630723]  do_initcalls+0x5c/0xa0
[    4.630729]  do_basic_setup+0x20/0x30
[    4.630734]  kernel_init_freeable+0x88/0xf4
[    4.630740]  kernel_init+0x28/0x138
[    4.630746]  ret_from_fork+0x10/0x20
[    4.792571] NET: Registered PF_INET6 protocol family
[    4.800362] Segment Routing with IPv6
[    4.804154] In-situ OAM (IOAM) with IPv6
[    4.808251] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.814520] NET: Registered PF_PACKET protocol family
[    4.819728] can: controller area network core
[    4.824233] NET: Registered PF_CAN protocol family
[    4.829167] can: raw protocol
[    4.832227] can: broadcast manager protocol
[    4.836533] can: netlink gateway - max_hops=1
[    4.842926] Bluetooth: RFCOMM TTY layer initialized
[    4.847977] Bluetooth: RFCOMM socket layer initialized
[    4.853267] Bluetooth: RFCOMM ver 1.11
[    4.857140] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.862597] Bluetooth: BNEP filters: protocol multicast
[    4.867972] Bluetooth: BNEP socket layer initialized
[    4.873081] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    4.879167] Bluetooth: HIDP socket layer initialized
[    4.884300] 8021q: 802.1Q VLAN Support v1.8
[    4.888643] Key type dns_resolver registered
[    4.899507] registered taskstats version 1
[    4.903782] Loading compiled-in X.509 certificates
[    4.917714] Loaded X.509 cert 'Build time autogenerated kernel key: 23d07d80b96f017f5e79bf1c5e7074697e9cd37d'
[    4.932224] Key type .fscrypt registered
[    4.936272] Key type fscrypt-provisioning registered
[    4.942182] Btrfs loaded, zoned=no, fsverity=no
[    4.946877] AppArmor: AppArmor sha256 policy hashing enabled
[    4.990283] cpu cpu0: EM: OPP:1555200 is inefficient
[    4.995382] cpu cpu0: EM: OPP:595200 is inefficient
[    5.000422] cpu cpu0: EM: OPP:499200 is inefficient
[    5.005430] cpu cpu0: EM: OPP:403200 is inefficient
[    5.010467] cpu cpu0: EM: OPP:300000 is inefficient
[    5.016499] cpu cpu0: EM: created perf domain
[    5.020993] energy_model: Accessing cpu4 policy failed
[    5.031158] cpu cpu4: EM: created perf domain
[    5.035639] energy_model: updating cpu0 cpu_cap=798 old capacity=981
[    5.042169] cpu cpu0: EM: OPP:1670400 is inefficient
[    5.047269] cpu cpu0: EM: OPP:1555200 is inefficient
[    5.052369] cpu cpu0: EM: OPP:595200 is inefficient
[    5.057390] cpu cpu0: EM: OPP:499200 is inefficient
[    5.062394] cpu cpu0: EM: OPP:403200 is inefficient
[    5.067409] cpu cpu0: EM: OPP:300000 is inefficient
[    5.075601] qcom_scm: convention: smc arm 64
[    5.080175] qcom_scm firmware:scm: qseecom: found qseecom with version 0x1402000
[    5.087766] qcom_scm firmware:scm: qseecom: untested machine, skipping
[    5.096395] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier 8903000.phy for /pmic-glink/connector@1
[    5.114681] vreg_l3d: Setting 1200000-1200000uV
[    5.114992] arm-smmu 3da0000.iommu: probing hardware configuration...
[    5.119516] vreg_l4d: Setting 1200000-1200000uV
[    5.125955] arm-smmu 3da0000.iommu: SMMUv2 with:
[    5.130775] vreg_l6d: Setting 880000-880000uV
[    5.135354] arm-smmu 3da0000.iommu:  stage 1 translation
[    5.140189] vreg_l7d: Setting 3072000-3072000uV
[    5.145266] arm-smmu 3da0000.iommu:  coherent table walk
[    5.150360] vreg_l9d: Setting 912000-912000uV
[    5.155374] arm-smmu 3da0000.iommu:  stream matching with 9 register groups
[    5.167005] arm-smmu 3da0000.iommu:  7 context banks (0 stage-2 only)
[    5.173626] arm-smmu 3da0000.iommu:  Supported page sizes: 0x61311000
[    5.180238] arm-smmu 3da0000.iommu:  Stage-1: 48-bit VA -> 36-bit IPA
[    5.186905] arm-smmu 3da0000.iommu:  preserved 0 boot mappings
[    5.193760] platform 3d00000.gpu: Adding to iommu group 0
[    5.199380] platform 3d6a000.gmu: Adding to iommu group 1
[    5.208147] arm-smmu 15000000.iommu: probing hardware configuration...
[    5.214845] arm-smmu 15000000.iommu: SMMUv2 with:
[    5.219688] arm-smmu 15000000.iommu:         stage 1 translation
[    5.225229] arm-smmu 15000000.iommu:         coherent table walk
[    5.230769] arm-smmu 15000000.iommu:         stream matching with 162 register groups
[    5.238187] arm-smmu 15000000.iommu:         110 context banks (0 stage-2 only)
[    5.245066] arm-smmu 15000000.iommu:         Limiting the stream matching groups to 128
[    5.252945] arm-smmu 15000000.iommu:         Supported page sizes: 0x61311000
[    5.259653] arm-smmu 15000000.iommu:         Stage-1: 36-bit VA -> 36-bit IPA
[    5.266385] arm-smmu 15000000.iommu:         preserved 0 boot mappings
[    5.273274] platform 8c0000.geniqup: Adding to iommu group 2
[    5.279147] platform 9c0000.geniqup: Adding to iommu group 3
[    5.285013] platform ac0000.geniqup: Adding to iommu group 4
[    5.290898] platform 1d84000.ufshc: Adding to iommu group 5
[    5.296688] platform 8804000.mmc: Adding to iommu group 6
[    5.302301] platform ae00000.display-subsystem: Adding to iommu group 7
[    5.313045] platform a600000.usb: Adding to iommu group 8
[    5.318700] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier a600000.usb for /pmic-glink/connector@0
[    5.330744] /soc@0/phy@88eb000: Fixed dependency cycle(s) with /soc@0/usb@a6f8800/usb@a600000
[    5.339530] /soc@0/usb@a6f8800/usb@a600000: Fixed dependency cycle(s) with /soc@0/phy@88eb000
[    5.351456] platform a800000.usb: Adding to iommu group 9
[    5.357087] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier a800000.usb for /pmic-glink/connector@1
[    5.406403] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    5.412043] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    5.422353] xhci-hcd xhci-hcd.0.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000808000000010
[    5.432014] xhci-hcd xhci-hcd.0.auto: irq 191, io mem 0x0a800000
[    5.438251] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    5.443879] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    5.451732] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.1 Enhanced SuperSpeed
[    5.459306] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.16
[    5.467783] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.475192] usb usb1: Product: xHCI Host Controller
[    5.480207] usb usb1: Manufacturer: Linux 6.16.0-rc3-next-20250623 xhci-hcd
[    5.487351] usb usb1: SerialNumber: xhci-hcd.0.auto
[    5.493078] hub 1-0:1.0: USB hub found
[    5.496947] hub 1-0:1.0: 1 port detected
[    5.501108] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    5.509452] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.16
[    5.517933] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.525340] usb usb2: Product: xHCI Host Controller
[    5.530349] usb usb2: Manufacturer: Linux 6.16.0-rc3-next-20250623 xhci-hcd
[    5.537497] usb usb2: SerialNumber: xhci-hcd.0.auto
[    5.543150] hub 2-0:1.0: USB hub found
[    5.547021] hub 2-0:1.0: 1 port detected
[    5.551143] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier a800000.usb for /pmic-glink/connector@1
[    5.564131] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier usb0-sbu-mux for /pmic-glink/connector@0
[    5.576695] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier usb1-sbu-mux for /pmic-glink/connector@1
[    5.589917] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6100: registered as rtc0
[    5.596750] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6100: setting system clock to 1970-01-01T00:01:06 UTC (66)
[    5.616249] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
[    5.616791] sdhci_msm 8804000.mmc: Got CD GPIO
[    5.627248] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find vccq2-supply regulator, assuming enabled
[    5.674085] scsi host0: ufshcd
[    5.677641] mmc0: SDHCI controller on 8804000.mmc [8804000.mmc] using ADMA 64-bit
[    5.678489] scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.679188] remoteproc remoteproc0: slpi is available
[    5.679855] remoteproc remoteproc0: Direct firmware load for qcom/sc8280xp/qcslpi8280.mbn failed with error -2
[    5.679861] remoteproc remoteproc0: powering up slpi
[    5.679903] remoteproc remoteproc0: Direct firmware load for qcom/sc8280xp/qcslpi8280.mbn failed with error -2
[    5.679907] remoteproc remoteproc0: request_firmware failed: -2
[    5.680210] remoteproc remoteproc1: adsp is available
[    5.680666] remoteproc remoteproc1: Direct firmware load for qcom/sc8280xp/qcadsp8280.mbn failed with error -2
[    5.680671] remoteproc remoteproc1: powering up adsp
[    5.680713] remoteproc remoteproc1: Direct firmware load for qcom/sc8280xp/qcadsp8280.mbn failed with error -2
[    5.680716] remoteproc remoteproc1: request_firmware failed: -2
[    5.681098] remoteproc remoteproc2: cdsp is available
[    5.682028] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier 88eb000.phy for /pmic-glink/connector@0
[    5.684878] qcom-pcie 1c00000.pcie: supply vdda not found, using dummy regulator
[    5.685001] remoteproc remoteproc2: Direct firmware load for qcom/sc8280xp/qccdsp8280.mbn failed with error -2
[    5.685005] remoteproc remoteproc2: powering up cdsp
[    5.685034] qcom-pcie 1c00000.pcie: host bridge /soc@0/pcie@1c00000 ranges:
[    5.685044] remoteproc remoteproc2: Direct firmware load for qcom/sc8280xp/qccdsp8280.mbn failed with error -2
[    5.685047] remoteproc remoteproc2: request_firmware failed: -2
[    5.685061] qcom-pcie 1c00000.pcie:       IO 0x0030200000..0x00302fffff -> 0x0000000000
[    5.685075] qcom-pcie 1c00000.pcie:      MEM 0x0030300000..0x0031ffffff -> 0x0030300000
[    5.685101] qcom-pcie 1c10000.pcie: supply vdda not found, using dummy regulator
[    5.685320] qcom-pcie 1c10000.pcie: host bridge /soc@0/pcie@1c10000 ranges:
[    5.685563] qcom-pcie 1c20000.pcie: supply vdda not found, using dummy regulator
[    5.685760] qcom-pcie 1c20000.pcie: host bridge /soc@0/pcie@1c20000 ranges:
[    5.685797] qcom-pcie 1c20000.pcie:       IO 0x003c200000..0x003c2fffff -> 0x0000000000
[    5.685812] qcom-pcie 1c20000.pcie:      MEM 0x003c300000..0x003dffffff -> 0x003c300000
[    5.686141] 884000.serial: ttyMSM0 at MMIO 0x884000 (irq = 216, base_baud = 0) is a MSM
[    5.695174] scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.699192] qcom-pcie 1c10000.pcie:       IO 0x0034200000..0x00342fffff -> 0x0000000000
[    5.710398] scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.714542] qcom-pcie 1c10000.pcie:      MEM 0x0034300000..0x0035ffffff -> 0x0034300000
[    5.725856] scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.777782] mmc0: new high speed SD card at address 71bf
[    5.786362] scsi 0:0:0:1: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.786382] sd 0:0:0:0: [sda] 61652992 4096-byte logical blocks: (253 GB/235 GiB)
[    5.786470] sd 0:0:0:0: [sda] Write Protect is off
[    5.786478] sd 0:0:0:0: [sda] Mode Sense: 00 32 00 10
[    5.786633] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.786705] sd 0:0:0:0: [sda] Preferred minimum I/O size 524288 bytes
[    5.786711] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[    5.793101] mmcblk0: mmc0:71bf SD02G 1.83 GiB
[    5.804145] sd 0:0:0:1: [sdb] 5120 4096-byte logical blocks: (21.0 MB/20.0 MiB)
[    5.804171] scsi 0:0:0:2: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.838210] qcom-pcie 1c00000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    5.839698] sd 0:0:0:1: [sdb] Write Protect is off
[    5.839732] qcom-pcie 1c20000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    5.839896] scsi 0:0:0:3: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.840047] sd 0:0:0:2: [sdc] 5120 4096-byte logical blocks: (21.0 MB/20.0 MiB)
[    5.840102] sd 0:0:0:2: [sdc] Write Protect is off
[    5.840104] sd 0:0:0:2: [sdc] Mode Sense: 00 32 00 10
[    5.840187] sd 0:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.840232] sd 0:0:0:2: [sdc] Preferred minimum I/O size 524288 bytes
[    5.840234] sd 0:0:0:2: [sdc] Optimal transfer size 524288 bytes
[    5.840905] sd 0:0:0:3: [sdd] 8192 4096-byte logical blocks: (33.6 MB/32.0 MiB)
[    5.840950] sd 0:0:0:3: [sdd] Write Protect is off
[    5.840953] sd 0:0:0:3: [sdd] Mode Sense: 00 32 00 10
[    5.841039] sd 0:0:0:3: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.841080] sd 0:0:0:3: [sdd] Preferred minimum I/O size 524288 bytes
[    5.841082] sd 0:0:0:3: [sdd] Optimal transfer size 524288 bytes
[    5.841131] scsi 0:0:0:4: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.841774]  mmcblk0: p1
[    5.841939] sd 0:0:0:4: [sde] 786432 4096-byte logical blocks: (3.22 GB/3.00 GiB)
[    5.841984] sd 0:0:0:4: [sde] Write Protect is off
[    5.841986] sd 0:0:0:4: [sde] Mode Sense: 00 32 00 10
[    5.842072] sd 0:0:0:4: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.842113] scsi 0:0:0:5: Direct-Access     SAMSUNG  KLUEG8UHDC-B0E1  0200 PQ: 0 ANSI: 6
[    5.842115] sd 0:0:0:4: [sde] Preferred minimum I/O size 524288 bytes
[    5.842117] sd 0:0:0:4: [sde] Optimal transfer size 524288 bytes
[    5.844226] sd 0:0:0:5: [sdf] 8192 4096-byte logical blocks: (33.6 MB/32.0 MiB)
[    5.844275] sd 0:0:0:5: [sdf] Write Protect is off
[    5.844277] sd 0:0:0:5: [sdf] Mode Sense: 00 32 00 10
[    5.844365] sd 0:0:0:5: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.844407] sd 0:0:0:5: [sdf] Preferred minimum I/O size 524288 bytes
[    5.844408] sd 0:0:0:5: [sdf] Optimal transfer size 524288 bytes
[    5.857724] qcom-pcie 1c10000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    5.862567] sd 0:0:0:1: [sdb] Mode Sense: 00 32 00 10
[    5.879257]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    5.885800] sd 0:0:0:1: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    5.894039] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.898967]  sdc: sdc1 sdc2 sdc3 sdc4
[    5.899016]  sdd: sdd2 sdd3
[    5.899226] sd 0:0:0:3: [sdd] Attached SCSI disk
[    5.899339] sd 0:0:0:2: [sdc] Attached SCSI disk
[    5.901981] sd 0:0:0:1: [sdb] Preferred minimum I/O size 524288 bytes
[    5.902768]  sdf: sdf2 sdf3
[    5.902868] sd 0:0:0:5: [sdf] Attached SCSI disk
[    5.907411]  sde: sde1 sde2 sde3 sde4 sde5 sde6 sde7 sde8 sde9 sde10 sde11 sde12 sde13 sde14 sde15 sde16 sde17 sde18 sde19 sde20 sde21 sde22 sde23 sde24 sde25 sde26 sde27 sde28 sde29 sde30 sde31 sde32 sde33 sde34 sde35 sde36 sde37 sde38 sde39 sde40 sde41 sde42 sde43 sde44 sde45 sde46 sde47 sde48 sde49 sde50 sde51 sde52 sde53 sde54 sde55
[    5.909918] sd 0:0:0:4: [sde] Attached SCSI disk
[    5.946216] qcom-pcie 1c20000.pcie: PCIe Gen.3 x4 link up
[    5.949439] sd 0:0:0:1: [sdb] Optimal transfer size 524288 bytes
[    5.957952] qcom-pcie 1c20000.pcie: PCI host bridge to bus 0002:00
[    5.957961] qcom-pcie 1c00000.pcie: PCIe Gen.2 x1 link up
[    5.970568] qcom-pcie 1c10000.pcie: PCIe Gen.3 x2 link up
[    5.975533] pci_bus 0002:00: root bus resource [bus 00-ff]
[    6.354294] pci_bus 0002:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[    6.354298] pci_bus 0002:00: root bus resource [mem 0x3c300000-0x3dffffff]
[    6.354480] pci 0002:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    6.354505] pci 0002:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    6.354512] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    6.354521] pci 0002:00:00.0:   bridge window [io  0x100000-0x100fff]
[    6.354527] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.354537] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.354623] pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
[    6.356953] pci 0002:01:00.0: [1e0f:0001] type 00 class 0x010802 PCIe Endpoint
[    6.426217] pci 0002:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    6.426704] pci 0002:01:00.0: PME# supported from D0 D3hot
[    6.439078] printk: legacy console [ttyMSM0] enabled
[    6.439078] printk: legacy console [ttyMSM0] enabled
[    6.446330] pci 0002:00:00.0: bridge window [mem 0x3c300000-0x3c3fffff]: assigned
[    6.446411] qcom-pcie 1c10000.pcie: PCI host bridge to bus 0004:00
[    6.446419] pci_bus 0004:00: root bus resource [bus 00-ff]
[    6.446330] pci 0002:00:00.0: bridge window [mem 0x3c300000-0x3c3fffff]: assigned
[    6.446424] pci_bus 0004:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x0000-0xfffff])
[    6.446427] pci_bus 0004:00: root bus resource [mem 0x34300000-0x35ffffff]
[    6.446545] pci 0004:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    6.446562] pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    6.446567] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    6.446574] pci 0004:00:00.0:   bridge window [io  0x200000-0x200fff]
[    6.446578] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.446586] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.446647] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[    6.448178] pci 0004:01:00.0: [17cb:0306] type 00 class 0xff0000 PCIe Endpoint
[    6.448389] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    6.448404] pci 0004:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
[    6.448914] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[    6.446411] qcom-pcie 1c10000.pcie: PCI host bridge to bus 0004:00
[    6.449135] pci 0004:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0004:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[    6.449284] printk: legacy bootconsole [qcom_geni0] disabled
[    6.446419] pci_bus 0004:00: root bus resource [bus 00-ff]
[    6.456966] pci 0002:00:00.0: BAR 0 [mem 0x3c400000-0x3c400fff]: assigned
[    6.446424] pci_bus 0004:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x0000-0xfffff])
[    6.469031] pci 0004:00:00.0: bridge window [mem 0x34300000-0x343fffff]: assigned
[    6.446427] pci_bus 0004:00: root bus resource [mem 0x34300000-0x35ffffff]
[    6.469066] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0006:00
[    6.446545] pci 0004:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    6.469071] pci_bus 0006:00: root bus resource [bus 00-ff]
[    6.446562] pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    6.469073] pci_bus 0006:00: root bus resource [io  0x0000-0xfffff]
[    6.446567] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    6.469074] pci_bus 0006:00: root bus resource [mem 0x30300000-0x31ffffff]
[    6.446574] pci 0004:00:00.0:   bridge window [io  0x200000-0x200fff]
[    6.469142] pci 0006:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    6.446578] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.469155] pci 0006:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    6.446586] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.469158] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    6.446647] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[    6.469162] pci 0006:00:00.0:   bridge window [io  0x0000-0x0fff]
[    6.448178] pci 0004:01:00.0: [17cb:0306] type 00 class 0xff0000 PCIe Endpoint
[    6.469165] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.448389] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    6.469171] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.448404] pci 0004:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
[    6.469215] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    6.448914] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[    6.476627] pci 0002:01:00.0: BAR 0 [mem 0x3c300000-0x3c303fff 64bit]: assigned
[    6.449135] pci 0004:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0004:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[    6.486084] pci 0004:00:00.0: BAR 0 [mem 0x34400000-0x34400fff]: assigned
[    6.449284] printk: legacy bootconsole [qcom_geni0] disabled
[    6.493183] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    6.456966] pci 0002:00:00.0: BAR 0 [mem 0x3c400000-0x3c400fff]: assigned
[    6.500643] pci 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    6.469031] pci 0004:00:00.0: bridge window [mem 0x34300000-0x343fffff]: assigned
[    6.500684] pci 0004:01:00.0: BAR 2 [mem 0x34301000-0x34301fff 64bit]: assigned
[    6.469066] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0006:00
[    6.506729] pci 0002:00:00.0:   bridge window [mem 0x3c300000-0x3c3fffff]
[    6.469071] pci_bus 0006:00: root bus resource [bus 00-ff]
[    6.512126] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    6.469073] pci_bus 0006:00: root bus resource [io  0x0000-0xfffff]
[    6.518704] pci_bus 0002:00: resource 4 [io  0x100000-0x1fffff]
[    6.469074] pci_bus 0006:00: root bus resource [mem 0x30300000-0x31ffffff]
[    6.525666] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
[    6.469142] pci 0006:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    6.526250] pci 0006:00:00.0: BAR 0 [mem 0x30300000-0x30300fff]: assigned
[    6.469155] pci 0006:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    6.526254] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    6.469158] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    6.526259] pci_bus 0006:00: resource 4 [io  0x0000-0xfffff]
[    6.469162] pci 0006:00:00.0:   bridge window [io  0x0000-0x0fff]
[    6.526261] pci_bus 0006:00: resource 5 [mem 0x30300000-0x31ffffff]
[    6.469165] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.527516] pcieport 0006:00:00.0: PME: Signaling with IRQ 218
[    6.469171] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.528729] pci 0006:01:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    6.469215] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    6.528971] pci 0006:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    6.476627] pci 0002:01:00.0: BAR 0 [mem 0x3c300000-0x3c303fff 64bit]: assigned
[    6.529465] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[    6.486084] pci 0004:00:00.0: BAR 0 [mem 0x34400000-0x34400fff]: assigned
[    6.529651] pci 0006:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0006:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    6.493183] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    6.533614] pci_bus 0002:00: resource 5 [mem 0x3c300000-0x3dffffff]
[    6.500643] pci 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    6.539875] pci_bus 0004:00: resource 4 [io  0x200000-0x2fffff]
[    6.500684] pci 0004:01:00.0: BAR 2 [mem 0x34301000-0x34301fff 64bit]: assigned
[    6.539877] pci_bus 0004:00: resource 5 [mem 0x34300000-0x35ffffff]
[    6.506729] pci 0002:00:00.0:   bridge window [mem 0x3c300000-0x3c3fffff]
[    6.546290] pcieport 0006:00:00.0: bridge window [mem 0x30400000-0x305fffff]: assigned
[    6.512126] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    6.546293] pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    6.518704] pci_bus 0002:00: resource 4 [io  0x100000-0x1fffff]
[    6.546525] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    6.525666] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
[    6.546588] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
[    6.526250] pci 0006:00:00.0: BAR 0 [mem 0x30300000-0x30300fff]: assigned
[    6.547242] ath11k_pci 0006:01:00.0: MSI vectors: 32
[    6.526254] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    6.547266] ath11k_pci 0006:01:00.0: wcn6855 hw2.0
[    6.526259] pci_bus 0006:00: resource 4 [io  0x0000-0xfffff]
[    6.547297] pci_bus 0002:01: resource 1 [mem 0x3c300000-0x3c3fffff]
[    6.526261] pci_bus 0006:00: resource 5 [mem 0x30300000-0x31ffffff]
[    6.553904] pci_bus 0004:01: resource 1 [mem 0x34300000-0x343fffff]
[    6.527516] pcieport 0006:00:00.0: PME: Signaling with IRQ 218
[    6.576882]  sdb: sdb1 sdb2 sdb3 sdb4
[    6.528729] pci 0006:01:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    6.528971] pci 0006:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    6.529465] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[    6.529651] pci 0006:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0006:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    6.533614] pci_bus 0002:00: resource 5 [mem 0x3c300000-0x3dffffff]
[    6.539875] pci_bus 0004:00: resource 4 [io  0x200000-0x2fffff]
[    6.539877] pci_bus 0004:00: resource 5 [mem 0x34300000-0x35ffffff]
[    6.546290] pcieport 0006:00:00.0: bridge window [mem 0x30400000-0x305fffff]: assigned
[    6.546293] pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    6.546525] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    6.546588] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
[    6.547242] ath11k_pci 0006:01:00.0: MSI vectors: 32
[    6.547266] ath11k_pci 0006:01:00.0: wcn6855 hw2.0
[    6.547297] pci_bus 0002:01: resource 1 [mem 0x3c300000-0x3c3fffff]
[    6.553904] pci_bus 0004:01: resource 1 [mem 0x34300000-0x343fffff]
[    6.576882]  sdb: sdb1 sdb2 sdb3 sdb4
[    7.290189] sd 0:0:0:1: [sdb] Attached SCSI disk
[    7.293864] i2c_hid_of 21-0015: supply vddl not found, using dummy regulator
[    7.293920] i2c_hid_of 21-0068: supply vddl not found, using dummy regulator
[    7.295840] 988000.serial: ttyHS1 at MMIO 0x988000 (irq = 254, base_baud = 0) is a MSM
[    7.317748] serial serial0: tty port ttyHS1 registered
[    7.323969] Bluetooth: hci0: setting up wcn6855
[    7.324321] i2c_hid_of 4-0010: supply vddl not found, using dummy regulator
[    7.356376] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    7.371735] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae98000
[    7.387071] /soc@0/display-subsystem@ae00000/display-controller@ae01000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@ae90000
[    7.393577] Bluetooth: hci0: QCA Product ID   :0x00000013
[    7.402691] input: hid-over-i2c 04F3:31AC Mouse as /devices/platform/soc@0/8c0000.geniqup/894000.i2c/i2c-21/21-0015/0018:04F3:31AC.0001/input/input1
[    7.405162] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel
[    7.405239] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    7.405625] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel
[    7.405642] /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/aux-bus/panel: Fixed dependency cycle(s) with /soc@0/display-subsystem@ae00000/displayport-controller@aea0000
[    7.407954] Bluetooth: hci0: QCA SOC Version  :0x400c0200
[    7.407956] Bluetooth: hci0: QCA ROM Version  :0x00000200
[    7.407958] Bluetooth: hci0: QCA Patch Version:0x000017f3
[    7.422033] input: hid-over-i2c 04F3:31AC Touchpad as /devices/platform/soc@0/8c0000.geniqup/894000.i2c/i2c-21/21-0015/0018:04F3:31AC.0001/input/input3
[    7.425482] i2c_hid_of 4-0010: i2c_hid_get_input: IRQ triggered but there's no data
[    7.425593] input: hid-over-i2c 04F3:2C98 Touchscreen as /devices/platform/soc@0/9c0000.geniqup/990000.i2c/i2c-4/4-0010/0018:04F3:2C98.0002/input/input4
[    7.425904] input: hid-over-i2c 04F3:2C98 as /devices/platform/soc@0/9c0000.geniqup/990000.i2c/i2c-4/4-0010/0018:04F3:2C98.0002/input/input5
[    7.425976] input: hid-over-i2c 04F3:2C98 as /devices/platform/soc@0/9c0000.geniqup/990000.i2c/i2c-4/4-0010/0018:04F3:2C98.0002/input/input6
[    7.426028] hid-generic 0018:04F3:2C98.0002: input: I2C HID v1.00 Device [hid-over-i2c 04F3:2C98] on 4-0010
[    7.443183] input: hid-over-i2c 0416:C300 Keyboard as /devices/platform/soc@0/8c0000.geniqup/894000.i2c/i2c-21/21-0068/0018:0416:C300.0003/input/input8
[    7.446322] Bluetooth: hci0: QCA controller version 0x02000200
[    7.446327] Bluetooth: hci0: QCA Downloading qca/hpbtfw20.tlv
[    7.446402] bluetooth hci0: Direct firmware load for qca/hpbtfw20.tlv failed with error -2
[    7.446407] Bluetooth: hci0: QCA Failed to request file: qca/hpbtfw20.tlv (-2)
[    7.446410] Bluetooth: hci0: QCA Failed to download patch (-2)
[    7.446666] Bluetooth: hci0: unexpected event for opcode 0xfc48
[    7.455552] hid-generic 0018:04F3:31AC.0001: input: I2C HID v1.00 Mouse [hid-over-i2c 04F3:31AC] on 21-0015
[    7.530171] panel-simple-dp-aux aux-aea0000.displayport-controller: Detected SHP LQ140M1JW48 (0x1511)
[    7.653574] hid-generic 0018:0416:C300.0003: input: I2C HID v1.00 Keyboard [hid-over-i2c 0416:C300] on 21-0068
[    7.664981] mhi mhi0: Requested to power ON
[    7.669302] mhi mhi0: Power on setup success
[    7.669494] mhi mhi0: Direct firmware load for ath11k/WCN6855/hw2.0/amss.bin failed with error -2
[    7.676664] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    7.682811] mhi mhi0: Error loading firmware: -2
[    7.688434] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 3
[    7.690855] xhci-hcd xhci-hcd.2.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000808000000010
[    7.693232] ath11k_pci 0006:01:00.0: failed to power up mhi: -110
[    7.701051] xhci-hcd xhci-hcd.2.auto: irq 262, io mem 0x0a600000
[    7.710678] ath11k_pci 0006:01:00.0: failed to start mhi: -110
[    7.717031] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    7.723103] ath11k_pci 0006:01:00.0: failed to power up :-110
[    7.729092] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 4
[    7.748488] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.1 Enhanced SuperSpeed
[    7.756099] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.16
[    7.756666] ath11k_pci 0006:01:00.0: failed to create soc core: -110
[    7.764591] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.771114] ath11k_pci 0006:01:00.0: failed to init core: -110
[    7.778516] usb usb3: Product: xHCI Host Controller
[    7.789509] usb usb3: Manufacturer: Linux 6.16.0-rc3-next-20250623 xhci-hcd
[    7.796660] usb usb3: SerialNumber: xhci-hcd.2.auto
[    7.802238] hub 3-0:1.0: USB hub found
[    7.806098] hub 3-0:1.0: 1 port detected
[    7.810250] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    7.818594] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.16
[    7.827082] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.834494] usb usb4: Product: xHCI Host Controller
[    7.839507] usb usb4: Manufacturer: Linux 6.16.0-rc3-next-20250623 xhci-hcd
[    7.846657] usb usb4: SerialNumber: xhci-hcd.2.auto
[    7.852231] hub 4-0:1.0: USB hub found
[    7.856090] hub 4-0:1.0: 1 port detected
[    7.860486] qcom_pmic_glink pmic-glink: Failed to create device link (0x180) with supplier a600000.usb for /pmic-glink/connector@0
[    7.875243] msm_dpu ae01000.display-controller: bound ae90000.displayport-controller (ops msm_dp_display_comp_ops)
[    7.888162] msm_dpu ae01000.display-controller: bound ae98000.displayport-controller (ops msm_dp_display_comp_ops)
[    7.899585] msm_dpu ae01000.display-controller: bound aea0000.displayport-controller (ops msm_dp_display_comp_ops)
[    7.910600] adreno 3d00000.gpu: supply vdd not found, using dummy regulator
[    7.917799] adreno 3d00000.gpu: supply vddcx not found, using dummy regulator
[    7.932155] msm_dpu ae01000.display-controller: bound 3d00000.gpu (ops a3xx_ops)
[    7.940833] [drm:dpu_kms_hw_init:1173] dpu hardware revision:0x80000000
[    7.941092] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -110
[    7.952002] [drm] Initialized msm 1.12.0 for ae01000.display-controller on minor 0
[    7.957330] pcieport 0002:00:00.0: PME: Signaling with IRQ 220
[    7.963859] msm_dpu ae01000.display-controller: Direct firmware load for qcom/a660_sqe.fw failed with error -2
[    7.970433] nvme nvme0: pci function 0002:01:00.0
[    7.979956] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] *ERROR* failed to load a660_sqe.fw
[    7.984802] nvme 0002:01:00.0: enabling device (0000 -> 0002)
[    8.014802] fbcon: Deferring console take-over
[    8.019385] msm_dpu ae01000.display-controller: [drm] fb0: msmdrmfb frame buffer device
[    8.029385] input: gpio-keys as /devices/platform/gpio-keys/input/input9
[    8.036878] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.044992] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.050946] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    8.058410] clk: Not disabling unused clocks
[    8.062803] PM: genpd: Disabling unused power domains
[    8.069399] hwmon hwmon19: temp1_input not attached to any thermal zone
[    8.070186] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    8.076272] hwmon hwmon19: temp2_input not attached to any thermal zone
[    8.085041] cfg80211: failed to load regulatory.db
[    8.092758] ALSA device list:
[    8.099823]   No soundcards found.
[    8.109116] nvme nvme0: allocated 61 MiB host memory buffer (16 segments).
[    8.278772] nvme nvme0: 8/0/0 default/read/poll queues
[    8.293147]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19
[    8.306800] pcieport 0004:00:00.0: PME: Signaling with IRQ 232
[    8.312907] mhi-pci-generic 0004:01:00.0: MHI PCI device found: foxconn-sdx55
[    8.320253] mhi-pci-generic 0004:01:00.0: enabling device (0000 -> 0002)
[    8.329847] mhi mhi0: Requested to power ON
[    8.334167] mhi mhi0: Power on setup success
[    8.366028] mhi mhi0: Wait for device to enter SBL or Mission mode
[    8.424806] wwan wwan0: port wwan0qcdm0 attached
[    8.430321] wwan wwan0: port wwan0mbim0 attached
[    8.432472] Freeing unused kernel memory: 1472K
[    8.435777] wwan wwan0: port wwan0at0 attached
[    8.439882] Run /init as init process
[    8.448189]   with arguments:
[    8.451272]     /init
[    8.453633]     PMOS_NO_OUTPUT_REDIRECT
[    8.457611]   with environment:
[    8.460867]     HOME=/
[    8.463321]     TERM=linux
mount: /sys/firmware/efi/efivars: mount(2) system call failed: Operation not supported.
       dmesg(1) may have more information after failed mount system call.
:: running early hook [udev]
Warning: /lib/modules/6.16.0-rc3-next-20250623/modules.devname not found - ignoring
Starting systemd-udevd version 253-1-arch
:: running hook [udev]
:: Triggering uevents...
[    8.714531] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-ac: failed to send uevent
[    8.726783] power_supply qcom-battmgr-ac: uevent: failed to send synthetic uevent: -11
qcom-battmgr-ac: Failed to write 'add' to '/sys/devices/platform[    8.735087] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-bat: failed to send uevent
[    8.753047] power_supply qcom-battmgr-bat: uevent: failed to send synthetic uevent: -11
[    8.761365] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-usb: failed to send uevent
/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-[    8.773696] power_supply qcom-battmgr-usb: uevent: failed to send synthetic uevent: -11
ac/uevent': Resource temporarily unavailable
qcom-battmgr-bat: [    8.787799] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-wls: failed to send uevent
Failed to write 'add' to '/sys/devices/platform/pmic-glink/pmic_[    8.805740] power_supply qcom-battmgr-wls: uevent: failed to send synthetic uevent: -11
glink.power-supply.0/power_supply/qcom-battmgr-bat/uevent': Resource temporarily unavailable
qcom-battmgr-usb: Failed to write 'add' to '/sys/devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-usb/uevent': Resource temporarily unavailable
qcom-battmgr-wls: Failed to write 'add' to '/sys/devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-wls/uevent': Resource temporarily unavailable
:: running hook [keymap]
:: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for device
done.
:: performing fsck on '/dev/nvme0n1p18'
/dev/nvme0n1p18: clean, 231050/6406144 files, 5482933/25599744 blocks
********************** WARNING **********************
*                                                   *
*  The root device is not configured to be mounted  *
*  read-write! It may be fsck'd again later.        *
*                                                   *
*****************************************************
:: mounting '/dev/nvme0n1p18' on[    9.017017] EXT4-fs (nvme0n1p18): orphan cleanup on readonly fs
 real root
[    9.029817] EXT4-fs (nvme0n1p18): mounted filesystem b185d95c-e8f6-41d3-84ad-d77eeaeaffe6 ro with ordered data mode. Quota mode: none.
:: running cleanup hook [udev]
[    9.353317] systemd[1]: System time before build time, advancing clock.
[    9.400553] systemd[1]: systemd 255.3-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
[    9.433871] systemd[1]: Detected architecture arm64.

Welcome to Arch Linux ARM!

[    9.460271] systemd[1]: Hostname set to <sc8280xp-crd>.
[    9.558944] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the kernel, BPF LSM not supported
[    9.931771] systemd[1]: Queued start job for default target Graphical Interface.
[   10.041257] systemd[1]: Created slice Slice /system/dirmngr.
[  OK  ] Created slice Slice /system/dirmngr.
[   10.068400] systemd[1]: Created slice Slice /system/getty.
[  OK  ] Created slice Slice /system/getty.
[   10.098617] systemd[1]: Created slice Slice /system/gpg-agent.
[  OK  ] Created slice Slice /system/gpg-agent.
[   10.129786] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[  OK  ] Created slice Slice /system/gpg-agent-browser.
[   10.168663] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[  OK  ] Created slice Slice /system/gpg-agent-extra.
[   10.208753] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[  OK  ] Created slice Slice /system/gpg-agent-ssh.
[   10.248406] systemd[1]: Created slice Slice /system/keyboxd.
[  OK  ] Created slice Slice /system/keyboxd.
[   10.288688] systemd[1]: Created slice Slice /system/modprobe.
[  OK  ] Created slice Slice /system/modprobe.
[   10.318657] systemd[1]: Created slice Slice /system/serial-getty.
[  OK  ] Created slice Slice /system/serial-getty.
[   10.348243] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[   10.377553] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[   10.407306] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[   10.437358] systemd[1]: Arbitrary Executable File Formats File System Automount Point was skipped because of an unmet condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
[   10.454131] systemd[1]: Expecting device /dev/disk/by-uuid/70a38dab-c9df-4025-8728-1d4353cfeca0...
         Expecting device /dev/disk/by-uuid…8dab-c9df-4025-8728-1d4353cfeca0...
[   10.487212] systemd[1]: Expecting device /dev/ttyMSM0...
         Expecting device /dev/ttyMSM0...
[   10.507235] systemd[1]: Reached target Local Encrypted Volumes.
[  OK  ] Reached target Local Encrypted Volumes.
[   10.537244] systemd[1]: Reached target Local Integrity Protected Volumes.
[  OK  ] Reached target Local Integrity Protected Volumes.
[   10.567349] systemd[1]: Reached target Path Units.
[  OK  ] Reached target Path Units.
[   10.587241] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[   10.617283] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[   10.637272] systemd[1]: Reached target Local Verity Protected Volumes.
[  OK  ] Reached target Local Verity Protected Volumes.
[   10.668195] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[   10.702209] systemd[1]: Listening on Process Core Dump Socket.
[  OK  ] Listening on Process Core Dump Socket.
[   10.727447] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   10.756993] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[   10.777985] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[   10.806440] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[   10.820973] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[   10.847566] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   10.928665] systemd[1]: Mounting Huge Pages File System...
         Mounting Huge Pages File System...
[   10.952067] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System..[   10.961164] systemd[1]: Mounting Kernel Debug File System...
.
         Mounting Kernel Debug File System...
[   10.980466] systemd[1]: Mounting Kernel Trace File System...
         Mounting Kernel Trace File System...
[   10.991944] systemd[1]: Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/6.16.0-rc3-next-20250623/modules.devname).
[   11.011759] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[   11.051036] systemd[1]: Starting Load Kernel Module dm_mod...
         Starting Load Kernel Module dm_mod...
[   11.082011] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[   11.112895] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[   11.153090] systemd[1]: Starting Load Kernel Module loop...
         Starting Load Kernel Module loop...
[   11.193359] systemd[1]: Starting File System Check on Root Device...
         Starting File System Check on Root Device...
[   11.239042] systemd[1]: systemd-journald.service: unit configures an IP firewall, but the local system does not support BPF/cgroup firewalling.
[   11.252516] systemd[1]: systemd-journald.service: (This warning is only shown for the first unit using IP firewalling.)
[   11.283629] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   11.298463] systemd[1]: Starting Load Kernel Modules...
[   11.305576] systemd[1]: Starting Generate network units from Kernel command line...
[   11.316744] systemd[1]: TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).

         Starting Generate network units from Kernel [   11.330770] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
command line...
[   11.343700] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
         Starting Create Static Device Nodes in /dev gr[   11.347266] systemd-journald[345]: Collecting audit messages is disabled.
acefully...
[   11.358688] systemd[1]: Starting Coldplug All udev Devices...
         Starting Coldplug All udev Devices...
[   11.385290] systemd[1]: Mounted Huge Pages File System.
[  OK  ] Mounted Huge Pages File System.
[   11.397451] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.
[   11.426445] systemd[1]: Mounted Kernel Debug File System.
[  OK  ] Mounted Kernel Debug File System.
[   11.439437] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Mounted Kernel Trace File System.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module dm_mod.
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Module loop.
[  OK  ] Finished File System Check on Root Device.
[  OK  ] Finished Load Kernel Modules.
[  OK  ] Finished Generate network units fro[   11.622571] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-ac: failed to send uevent
[   11.637779] power_supply qcom-battmgr-ac: uevent: failed to send synthetic uevent: -11
[   11.646006] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-bat: failed to send uevent
[   11.658336] power_supply qcom-battmgr-bat: uevent: failed to send synthetic uevent: -11
[   11.666623] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-usb: failed to send uevent
[   11.678956] power_supply qcom-battmgr-usb: uevent: failed to send synthetic uevent: -11
[   11.687240] synth uevent: /devices/platform/pmic-glink/pmic_glink.power-supply.0/power_supply/qcom-battmgr-wls: failed to send uevent
[   11.699571] power_supply qcom-battmgr-wls: uevent: failed to send synthetic uevent: -11
m Kernel command line.
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Reached target Preparation for Network.
         Mounting FUSE Control File System...
         Mounting Kernel Configuration File System...
         Starting Remount Root and Kernel File Systems...
         Starting Apply Kernel Variables...
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Apply Kernel Variables.
[   12.019140] EXT4-fs (nvme0n1p18): re-mounted b185d95c-e8f6-41d3-84ad-d77eeaeaffe6 r/w.
[  OK  ] Finished Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Load/Save OS Random Seed...
[   12.095475] systemd-journald[345]: Received client request to flush runtime journal.
[  OK  ] Finished Create Static Device Nodes in /dev gracefully.
[   12.120984] systemd-journald[345]: /var/log/journal/03a85d255d294a3393e4506cc89d2e69/system.journal: Realtime clock jumped backwards relative to last journal entry, rotating.
[   12.137096] systemd-journald[345]: Rotating system journal.
[  OK  ] Finished Load/Save OS Random Seed.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Preparation for Local File Systems.
         Starting Rule-based Manager for Device Events and Files...
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Started Rule-based Manager for Device Events and Files.
         Starting Network Configuration...
[  OK  ] Found device /dev/ttyMSM0.
[  OK  ] Started Network Configuration.
[  OK  ] Found device KBG40ZNS256G TOSHIBA MEMORY 19.
[  OK  ] Created slice Slice /system/systemd-backlight.
[  OK  ] Reached target Bluetooth Support.
[  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
         Activating swap /dev/disk/by-uuid/…8dab-c9df-4025-8728-1d4353cfeca0...
[   13.000761] Adding 16777212k swap on /dev/nvme0n1p19.  Priority:-2 extents:1 across:16777212k SS
         Starting Load/Save Screen Backligh…rightness of backlight:backlight...
         Starting Virtual Console Setup...
[  OK  ] Activated swap /dev/disk/by-uuid/70a38dab-c9df-4025-8728-1d4353cfeca0.
[  OK  ] Finished Load/Save Screen Backlight Brightness of backlight:backlight.
[  OK  ] Reached target Swaps.
         Mounting Temporary Directory /tmp...
         Starting Load/Save RF Kill Switch Status...
[  OK  ] Mounted Temporary Directory /tmp.
[  OK  ] Reached target Local File Systems.
[  OK  ] Listening on System Extension Image Management (Varlink).
         Starting Create Volatile Files and Directories...
[  OK  ] Started Load/Save RF Kill Switch Status.
[  OK  ] Finished Virtual Console Setup.
[  OK  ] Finished Create Volatile Files and Directories.
         Starting Network Name Resolution...
         Starting Network Time Synchronization...
         Starting Record System Boot/Shutdown in UTMP...
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Started Network Time Synchronization.
[  OK  ] Reached target System Time Set.
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Refresh existing PGP keys of archlinux-keyring regularly.
[  OK  ] Started Daily verification of password and group files.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timer Units.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on GnuPG network certifi…ent daemon for /etc/pacman.d/gnupg.
[  OK  ] Listening on GnuPG cryptographic a… browsers) for /etc/pacman.d/gnupg.
[  OK  ] Listening on GnuPG cryptographic a…estricted) for /etc/pacman.d/gnupg.
[  OK  ] Listening on GnuPG cryptographic a…emulation) for /etc/pacman.d/gnupg.
[  OK  ] Listening on GnuPG cryptographic a…rase cache for /etc/pacman.d/gnupg.
[  OK  ] Listening on GnuPG public key mana…nt service for /etc/pacman.d/gnupg.
[  OK  ] Reached target Socket Units.
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Reached target Basic System.
         Starting Network Manager...
[  OK  ] Started QIPCRTR Name Service.
[  OK  ] Started Qualcomm PD mapper service.
         Starting User Login Management...
[  OK  ] Started User Login Management.
         Starting Hostname Service...
[  OK  ] Started Hostname Service.
         Starting Network Manager Script Dispatcher Service...
[  OK  ] Started Network Manager.
[  OK  ] Started Network Manager Script Dispatcher Service.
[  OK  ] Reached target Network.
[  OK  ] Started OpenSSH Daemon.
         Starting Permit User Sessions...
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyMSM0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
[   14.963985] fbcon: Taking over console
[   14.968712] Console: switching to colour frame buffer device 240x67
[   14.968727] fb0: sys_imageblit: framebuffer is not in virtual address space.
[   14.976916] fb0: sys_fillrect: framebuffer is not in virtual address space.

Arch Linux 6.16.0-rc3-next-20250623 (ttyMSM0)

sc8280xp-crd login: root
Password:

Last login: Mon May  5 13:08:28 on ttyMSM0
[root@sc8280xp-crd ~]# echo mem > /sys/power/state 
[   22.407182] PM: suspend entry (s2idle)
[   22.422341] Filesystems sync: 0.011 seconds
[   22.439415] ------------[ cut here ]------------
[   22.444194] Invalid notifier called!
[   22.444208] WARNING: kernel/notifier.c:79 at notifier_call_chain+0x84/0x1a4, CPU#3: bash/518
[   22.456607] Modules linked in:
[   22.459781] CPU: 3 UID: 0 PID: 518 Comm: bash Not tainted 6.16.0-rc3-next-20250623 #12182 NONE 
[   22.468736] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[   22.477959] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   22.485132] pc : notifier_call_chain+0x84/0x1a4
[   22.489810] lr : notifier_call_chain+0x80/0x1a4
[   22.494496] sp : ffff800087ddbb30
[   22.497922] x29: ffff800087ddbb40 x28: ffffce0c91a21f08 x27: 0000000000000000
[   22.505273] x26: 0000000000000000 x25: 0000000000000000 x24: ffffce0c9200d000
[   22.512624] x23: ffff00008dc88000 x22: 0000000000000003 x21: 0000000000000000
[   22.519982] x20: 00000000fffffffb x19: ffff800087ddbba4 x18: ffff800087e35088
[   22.527339] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000003135
[   22.534686] x14: 0000000000000000 x13: 0000000000000003 x12: 00000000ffffefff
[   22.542044] x11: 0000000000000001 x10: 0000000000000003 x9 : 5505375e0ec6e700
[   22.549397] x8 : 5505375e0ec6e700 x7 : 0000000000000000 x6 : ffffce0c8f3e7e48
[   22.556744] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800087ddb818
[   22.564095] x2 : ffff800087ddb820 x1 : 00000000ffffefff x0 : 0000000000000018
[   22.571442] Call trace:
[   22.573985]  notifier_call_chain+0x84/0x1a4 (P)
[   22.578670]  notifier_call_chain_robust+0x4c/0xa8
[   22.583527]  blocking_notifier_call_chain_robust+0x54/0x88
[   22.589184]  pm_notifier_call_chain_robust+0x2c/0x4c
[   22.594307]  pm_suspend+0x20c/0x65c
[   22.597927]  state_store+0x6c/0x9c
[   22.601448]  kobj_attr_store+0x20/0x38
[   22.605335]  sysfs_kf_write+0x5c/0x7c
[   22.609126]  kernfs_fop_write_iter+0xe8/0x184
[   22.613629]  vfs_write+0x2dc/0x308
[   22.617154]  ksys_write+0x80/0xec
[   22.620596]  __arm64_sys_write+0x24/0x34
[   22.624658]  invoke_syscall+0x48/0x100
[   22.628543]  el0_svc_common+0xb4/0xe8
[   22.632336]  do_el0_svc+0x24/0x34
[   22.635765]  el0_svc+0x58/0xd4
[   22.638941]  el0t_64_sync_handler+0x114/0x130
[   22.643440]  el0t_64_sync+0x1a0/0x1a4
[   22.647227] irq event stamp: 0
[   22.650397] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   22.656859] hardirqs last disabled at (0): [<ffffce0c8dcb17c0>] copy_process+0x508/0xef4
[   22.665191] softirqs last  enabled at (0): [<ffffce0c8dcb17d4>] copy_process+0x51c/0xef4
[   22.673529] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   22.679983] ---[ end trace 0000000000000000 ]---
[   22.685963] Freezing user space processes
[   22.691434] Freezing user space processes completed (elapsed 0.001 seconds)
[   22.698611] OOM killer disabled.
[   22.701957] Freezing remaining freezable tasks
[   22.707699] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   23.126881] Unable to handle kernel paging request at virtual address dead00000000012a
[   23.135041] Mem abort info:
[   23.137935]   ESR = 0x0000000096000044
[   23.141805]   EC = 0x25: DABT (current EL), IL = 32 bits
[   23.147279]   SET = 0, FnV = 0
[   23.150443]   EA = 0, S1PTW = 0
[   23.153693]   FSC = 0x04: level 0 translation fault
[   23.158720] Data abort info:
[   23.161707]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[   23.167366]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[   23.172573]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   23.178055] [dead00000000012a] address between user and kernel address ranges
[   23.185403] Internal error: Oops: 0000000096000044 [#1]  SMP
[   23.191244] Modules linked in:
[   23.194416] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           6.16.0-rc3-next-20250623 #12182 NONE 
[   23.205231] Tainted: [W]=WARN
[   23.208309] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[   23.217525] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   23.224693] pc : __run_timer_base+0x1e0/0x330
[   23.229201] lr : __run_timer_base+0x1c4/0x330
[   23.233701] sp : ffff800080003e80
[   23.237131] x29: ffff800080003ee0 x28: ffff800080003e98 x27: dead000000000122
[   23.244483] x26: 0000000000000000 x25: 0000000000000000 x24: ffffce0c91a2dc80
[   23.251831] x23: 0000000000000101 x22: ffff00008727ead0 x21: 00000000ffff93cf
[   23.259179] x20: ffffce0c91a21f08 x19: ffff0001fef64dc0 x18: ffff800080005028
[   23.266529] x17: 0000000000000001 x16: ffff0001fef64e60 x15: ffff0001fef64e20
[   23.273878] x14: 0000000000008000 x13: ffff00008727ead0 x12: ffff800080003ea0
[   23.281226] x11: 00000000e0000d86 x10: ffffce0c919c47c8 x9 : ffff800080003e98
[   23.288575] x8 : dead000000000122 x7 : 0000000000000000 x6 : ffffce0c8dd8c620
[   23.295924] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
[   23.303272] x2 : 000000000000007a x1 : 000000000000007d x0 : 0000000000000001
[   23.310623] Call trace:
[   23.313157]  __run_timer_base+0x1e0/0x330 (P)
[   23.317660]  run_timer_softirq+0x40/0x78
[   23.321711]  handle_softirqs+0x14c/0x3dc
[   23.325770]  __do_softirq+0x1c/0x2c
[   23.329379]  ____do_softirq+0x18/0x28
[   23.333164]  call_on_irq_stack+0x3c/0x50
[   23.337214]  do_softirq_own_stack+0x24/0x34
[   23.341539]  __irq_exit_rcu+0xc4/0x174
[   23.345411]  irq_exit_rcu+0x18/0x40
[   23.349019]  el1_interrupt+0x40/0x5c
[   23.352718]  el1h_64_irq_handler+0x20/0x30
[   23.356956]  el1h_64_irq+0x6c/0x70
[   23.360475]  arch_local_irq_enable+0x8/0xc (P)
[   23.365073]  cpuidle_enter+0x40/0x5c
[   23.368771]  call_cpuidle+0x24/0x48
[   23.372379]  do_idle+0x1a8/0x228
[   23.375725]  cpu_startup_entry+0x3c/0x40
[   23.379786]  kernel_init+0x0/0x138
[   23.383307]  start_kernel+0x334/0x3f0
[   23.387095]  __primary_switched+0x90/0x98
[   23.391239] Code: 36000428 a94026c8 f9000128 b4000048 (f9000509) 
[   23.397516] ---[ end trace 0000000000000000 ]---
[   23.402282] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[   23.409363] SMP: stopping secondary CPUs
[   24.477869] SMP: failed to stop secondary CPUs 1
[   24.482644] Kernel Offset: 0x4e0c0dc30000 from 0xffff800080000000
[   24.488917] PHYS_OFFSET: 0x80000000
[   24.492522] CPU features: 0x2000,000005c0,02004ca1,540072ab
[   24.498267] Memory Limit: none


Konrad

