Return-Path: <linux-wireless+bounces-24757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D3AF0C41
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A65447CCB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 07:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B12922541F;
	Wed,  2 Jul 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeAvkgy7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA30140E34
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440245; cv=none; b=lZ6WV32MhhfVAbgYfVyvyjG6pj/m+vqCB3/0s4F2Gc/3CLtCrExmAf7cnSgM5yvgZ/JpKYSRnBZNTJLe2ClK1igEOP8GzVm/O9D2O1vL18eR6wSVtgFb5JTlVX4RdmCtoicIzknIAryNMpVHEhEJSDlXxp4bk7/eZBetK5U9FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440245; c=relaxed/simple;
	bh=wM5KftaeQRn6qwIcY5rniJjwgWxiV9BfDTasKj4vsFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcF9w9+26L2hmY2bwVi2OlChgmu8C4/RBHzvlRWkuKMDCmNh3NpbVsdsncxXnTv5qRtF1UQS7JeRjqkHNuauYoeab234giNnPu9ibTlwSyHmGd0gH3Jvi7DlkFEr7i993I8u6452qdrX2+QwXkLJPR3z++qLo39hj+dOTuIw7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeAvkgy7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561K6DQH025086
	for <linux-wireless@vger.kernel.org>; Wed, 2 Jul 2025 07:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RCA3laQUQgLfr4d3l5ToyQ/eRvjHKHLDwpnt3NLlado=; b=KeAvkgy7miYsdzsE
	076/VOy1kJ3L98Gd5ihfqHoKdRQ/AYP8yI3ee9KhynregnxtjLo3AJYMAR02gAix
	RuwjdIKO39fyJZJsvOedZe/KOAs9qzlu6Hcs3mSu1OKYKzdaLjwZVtyHInEWJj2j
	WAOsZb3sNlPKuCU8WgGNEM6XuKuO16v+g18wo/AB3ddyDYUHeCeJXNq/GRIVjddp
	1cC5PWoWGvIjYjba7ggfjlrfWuo0f3n3fbW8DoQdzVqf9Zk7BB71f5OSuJXXV8Xp
	X662SA3//wsU5iDyZ055lwbjiCLmFNCzZE8xK3+pTF5qE/7YSyeW1dol+G9NXXeW
	qpTgLw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8023dy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 07:10:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7489ac848f3so6726916b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 00:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440239; x=1752045039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCA3laQUQgLfr4d3l5ToyQ/eRvjHKHLDwpnt3NLlado=;
        b=Ixfahtb0FLZa2naZS/dayD5FqpDuIeX7+xIhQjMXkSyxd6jf9xEwOLE5AWm0nlxLWJ
         n58hCSy+dLdiWBTQrYfYZJqMh+6nOb8ulDdBIFapc5dC2G1hsPQCuzLSF05ih2A0bdSw
         0fgUr9T3umx9jVc7BdbP1rH9KXvXuJZ5KL5YahcmSKhNh2Z00UsxeEvzz4LiF2Ihls06
         WXeYswbGtgMX/Mm9HdKExUm0cAa06cAPO7NzBMcnmU9FaPpYxGsHtNBbenCg/J99Z8tZ
         s4uXw+z9NYiUZhaF6DXZVi9TOg0FoWJeggzyip4Di4VFbOKpYZzzl4SiWwcPCfhupLQn
         0L4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1d7aO6/C2K/fvkWXv8IDSDUMSZbzIu+PV6M0jm8ZZiJZyszKNUOcngV/8NNQwav8b+McbS1pHxAqPxuCkNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEvRhyOfkrRFgOGqfUdUn4pFUuet6KWXK4Ii+CxBh8F/d7U/x
	QbHQ8M/5yoWTj4d/UNywYioK/i4/KmQzgyFCL/M05F6dxqFG9nru2U23XQ+J+IqECiw7/69ybUw
	gAOU4CFUSjrHgICmj1tKPPc2ZcxOotO9SAFW2h0JY041/R3RlNgdEzy4rIJMoszvbBWj9CQ==
X-Gm-Gg: ASbGncv3CebgU5SvhqopQInEEHd3eYlHNzpytDKHW8EHxszKj5Yqlg2PfU+MMYQHZ3d
	PBNASELySJIWRPl79Ai604eXLwAT6HRS0XaVY0EwDQdFdONr/qzrGFj0M/FpKiCV6ZWOV76Wfhk
	dIsrmKCR63oexl60j2D0R5XzHQa4oTuX6kbxiDHWtEEmCqMgKY7FemT7H5R4bRIDsAI0Xih8Mew
	7bptA4WeQoVhrazXw1xamwiXhxSd0vW0l4OHqbwGIERcWxnf/LzugcOA+sX8/TCNSZBoK2Odg2M
	4mghmVDo+aMVm6OqpdVE8MQJF/Oc6h2jJ4ar90Pd/KIFtrVXD3MR7gZySbJ7VFE9w8Iv3nXm4qT
	5R/I2oJrRV9xryAY=
X-Received: by 2002:a05:6a00:1a8e:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-74b51513b5bmr2503472b3a.24.1751440239060;
        Wed, 02 Jul 2025 00:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPtEnawlGMpCtfFrj4XZgsJyOlvmqGRqt3CEEGBVF1/+L6vgFtb/yE1jQDvC02NOyWgzA9A==
X-Received: by 2002:a05:6a00:1a8e:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-74b51513b5bmr2503447b3a.24.1751440238639;
        Wed, 02 Jul 2025 00:10:38 -0700 (PDT)
Received: from [10.133.33.132] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ed353sm13034533b3a.153.2025.07.02.00.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 00:10:38 -0700 (PDT)
Message-ID: <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
Date: Wed, 2 Jul 2025 15:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jeff Johnson <jjohnson@kernel.org>,
        will@kernel.org, joro@8bytes.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, 1107521@bugs.debian.org,
        iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
 <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
 <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oVIXrbs0d4N-eAKmxB39wX3twFK5FIm5
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6864db70 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1xDctz_ZAAAA:8 a=PsUJ3HgR6tW1sV_hUDoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=1a1P4aADmYxDp9Cj9Seq:22
X-Proofpoint-ORIG-GUID: oVIXrbs0d4N-eAKmxB39wX3twFK5FIm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA1NiBTYWx0ZWRfX6xQynZpiK3Qo
 I88GEg0JC0B6qOOYJQ9j+xnvWTA9TPLXILaFOSSTH4GSXbMp915Dd/TfLdYwVCFeB1/xp5qCgAE
 JPUtPGx/tunNiKR5jE+ber6mG6M7ZmRFJs2z3IicdusNKAhPwQ7teJovbB+MQphKsWVwBBrI/Jm
 Jh0GsvkwIeKZ7ZMDjKi9/RUBD77mDA5NE8Bipw9fRTBuOw8NyBTIDEzBcyS0RuQnUA8mN+LhCoc
 KMkrlqOz+ngoYwoqi1B/o0q5xnD+K4uZ0h8wJmJPCyz0AyYoN2vvlqo1HuykrA2ckXyOo7kCTA1
 bejbiBDl+UptRv3W3bry65J8njAj8SU8AIcba2G/0cn2vQQSBN8PokbarIHZDucBctVu47/l9vo
 aiiDC33WeJqOvRdHpgLeXTqvF/n9NosSbd3qWvO8aJBHW8ZRnz6cJ8u1Cn/QR/XA6NrZEi5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020056



On 7/2/2025 1:17 PM, Matt Mower wrote:
>> A couple more things I'd try on the ath12k side: firstly, boot with
>> "iommu.strict=1" and see if that makes the faults any more
>> frequent/reproducible;
> 
> The issue is easy enough to reproduce in 6.12.27 onward and I may be
> mistaken about the rarity in 6.12.22; I reproduced it relatively
> quickly in .22 today, so if this was the primary purpose for setting
> iommu.strict=1, then testing with or without strict works. FWIW, I did
> test iommu.strict=1 with 6.15.3 and still have not reproduced this
> issue there.
> 
>> if a fault is fairly easily reproducible, then
>> use the DMA API and/or IOMMU API tracepoints to compare the fault
>> address to prior DMA mapping activity - that can usually reveal the
>> nature of the bug enough to then know what to go looking for.
> 
> This is unfamiliar territory for me, so I hope the following is at
> least close to what you requested. If not, happy to provide more test
> results based on a set of instructions. Here's what I did:
> 
> 1. Set CONFIG_DMA_API_DEBUG=y
> 2. Set kernel command line to: iommu.strict=1 log_buf_len=100M
> dma_debug_driver=ath12k_pci trace_event=dma:*,iommu:*
> 3. Booted and waited for page fault, then cat'd
> /sys/kernel/tracing/trace to a file.
> 
> Additionally, though I'm pretty sure this is irrelevant now, I added
> logging after each dma_map_single() in the ath12k driver to print the
> function name and resultant address to the kernel log.
> 
> Comparing the addresses of several io_page_fault lines in the trace
> and in the kernel log, they line up. So, I'm hopeful this is on the
> right track.
> 
> DMA/IOMMU trace: https://cmphys.com/ath12k/iommu_dma_trace-20250701.log
> Kernel log with additional logging:
> https://cmphys.com/ath12k/dmesg-6.12.35-20250701.log
> Diff showing extra logging added to v6.12.35:
> https://cmphys.com/ath12k/ath12k-extra-logging-6.12.35-20250701.diff

Thanks, the log is helpful.

So the whole thing is:

#1 ath12k allocates/maps it at a very early stage:
   (udev-worker)-532     [010] .....     4.878076: map: IOMMU: iova=0x00000000fe980000 -
0x00000000fea00000 paddr=0x000000010ec80000 size=524288
   (udev-worker)-532     [010] .....     4.878079: dma_alloc: 0000:c2:00.0
dma_addr=fe980000 size=524288 virt_addr=000000006cadbcb1 flags=GFP_KERNEL attrs=

#2 here it is unmapped/freed
   kworker/u64:0-12      [011] .....   327.747763: dma_free: 0000:c2:00.0
dma_addr=fe980000 size=524288 virt_addr=000000006cadbcb1 attrs=
   kworker/u64:0-12      [011] .....   327.747766: unmap: IOMMU: iova=0x00000000fe980000 -
0x00000000fea00000 size=524288 unmapped_size=524288

#3 then the page fault
irq/26-AMD-Vi-154     [006] .....   327.753942: io_page_fault: IOMMU:ath12k_pci
0000:c2:00.0 iova=0x00000000fe980000 flags=0x0001

#4 here seems ath12k is recovering
[  327.849022] mhi mhi0: Requested to power ON

This gives me the impression that the IOMMU page fault is caused by misbehaved firmware
which crashes. The sequence is, first firmware crashes, then host gets that event and
begins to recover, during which some DMA buffer is freed/unmapped. However the firmware
does not know that and continues to access it, and hence the page fault.


Matt, could you help enable verbose ath12k log to verify my guess?

modprobe ath12k debug_mask=0xffffffff

note this would make ath12k throws lots of logs. Here the purpose is to check whether
firmware crash happens before the page fault. You may monitor

	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");

in ath12k_core_reset(), which is the entry of ath12k recovery process.

And one more thing, the issue buffer is handled by dma_alloc/free_xxx API family, so
adding logs to dma_map/unmap_xxx API does not help here.

> 
> Thanks,
> Matt


