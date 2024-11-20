Return-Path: <linux-wireless+bounces-15517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDE9D3235
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5328429B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976240BE0;
	Wed, 20 Nov 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VFkQDjk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA40EEB2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069974; cv=none; b=RfrVwfrHgSKMG8wNDy4Bo/KCRrb0HZzBHHj+hxNg2ulNmkIHjpKGRvBC6dS7vjArVdqZ/pmVcTDrsI0nIsTJYQ9saL2GM2A7uwN+51F0ZsaWNbjcTEDB4PVWSm7JaiwVvyQfQwudCUoQ5uER7Boc0n6+gAtJJMQGrVUFOJyN4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069974; c=relaxed/simple;
	bh=2+cBX1ubAUamTojQhDvdkk9M3sj5Oo3OP5linY96poI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xy/CJ9wwWbKXsOQea0Dz8fWEYDBAEc+nPp8axqzmWvpf+piDm4GoztMlH1oA8EQLhmjJcRM7OmgvyD5uS2QL8lMZmrtBlbW+cCl8afiXrOBZ8VY5H8mxaPuAS01jshqaAhxAVIBXxm1QBl+zalpO/HI/ugPE4KiuqSqbmmDvp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VFkQDjk0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIAjd3004697;
	Wed, 20 Nov 2024 02:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qYolO8RgpYlpWq7Jt4AcWYsfaSE0B0KfrXuyi6/bh3o=; b=VFkQDjk0dihLQTQD
	hbvlBEz0raLGaOwcyIfhqIq+v4auhETXoJiQRgKEaCp38NTzspgGzRsI3KpnyhCD
	eKSoRyQyFksJ0Xd2dD1c/bkMM1HzDKC7AQ8bUkV4Lh+tOdvA86xhHPXwoiosaY1b
	s4A1O4wEVdInkTvQj/D/sAhHMTWV+IoLHi69KekJGUbc30bRla4W8foCM3VoJjNd
	ZSF8NnfHhW9k6/1wlp0709p79b+sAlTTI3n7qC2r6cNY10vSE3f40DKn0Hh7WG60
	eGDfQ+kusS9Y5+YxIdEt93V+GFXobtDW+5PALcr4O/eJeectZI/jqHNYe64CKY/S
	nAz6DA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7vdym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 02:32:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK2WfXl006337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 02:32:41 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 18:32:40 -0800
Message-ID: <ac097ff6-5a17-4dad-89e7-cb4360e23e89@quicinc.com>
Date: Wed, 20 Nov 2024 10:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full
To: Tim Harvey <tharvey@gateworks.com>, <ath11k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <CAJ+vNU0dCV7-2gFDPTiOjAV-HCeHZ3H1DjGdqYKo+MGadfrSbA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAJ+vNU0dCV7-2gFDPTiOjAV-HCeHZ3H1DjGdqYKo+MGadfrSbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BFV8pRtlObf1NYy9NAkO0LnOGk3Q5nvV
X-Proofpoint-ORIG-GUID: BFV8pRtlObf1NYy9NAkO0LnOGk3Q5nvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200019



On 11/20/2024 4:16 AM, Tim Harvey wrote:
> Greetings,
> 
> I've got an ath11k card that is failing to init on an IMX8MM system
> with 4GB of DRAM:
> [    7.551582] ath11k_pci 0000:01:00.0: BAR 0 [mem
> 0x18000000-0x181fffff 64bit]: assigned
> [    7.551713] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    7.552401] ath11k_pci 0000:01:00.0: MSI vectors: 16
> [    7.552440] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
> [    7.887186] mhi mhi0: Loaded FW: ath11k/QCN9074/hw1.0/amss.bin,
> sha256: 5ee1b7b204541b5f99984f21d694ececaec08fbce1b520ffe6fe740b02a4afd7
> [    8.435964] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
> board_id 0xff soc_id 0xffffffff
> [    8.435991] ath11k_pci 0000:01:00.0: fw_version 0x270206d0
> fw_build_timestamp 2022-08-04 12:48 fw_build_id
> WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> [    8.441700] ath11k_pci 0000:01:00.0: Loaded FW:
> ath11k/QCN9074/hw1.0/board-2.bin, sha256:
> dbf0ca14aa1229eccd48f26f1026901b9718b143bd30b51b8ea67c84ba6207f1
> [    9.753764] ath11k_pci 0000:01:00.0: Loaded FW:
> ath11k/QCN9074/hw1.0/m3.bin, sha256:
> b6d957f335073a15a8de809398e1506f0200a08747eaf7189c843cf519ffc1de
> [    9.789791] ath11k_pci 0000:01:00.0: swiotlb buffer is full (sz:
> 1048583 bytes), total 32768 (slots), used 2528 (slots)
> [    9.789853] ath11k_pci 0000:01:00.0: failed to set up tcl_comp ring (0) :-12
> [    9.790238] ath11k_pci 0000:01:00.0: failed to init DP: -12
> root@noble-venice:~# cat /proc/cmdline
> console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
> root=PARTUUID=5cdde84f-01 rootwait net.ifnames=0 cma=196M
> 
> The IMX8MM's DRAM base is at 1GB so anything above 3GB hits the 32bit
> address boundary. If I pass in a mem=3096M the device registers just
> fine.
yeah ... that parameter makes kernel alloc memory below 32bit boundary, thus swiotlb is not necessary.

> 
> I found this to be the case with modern kernels however I found
> differing behavior with older kernels:
> - 6.6 and 6.1 the device registers with 4GB DRAM but crashes on client connect
> - 5.15 devices registers with 4GB DRAM and appears to work just fine
are you using Linus' tree or the stable tree?

> 
> Could anyone explain what is going on here? Obviously there have been
> changes at some point to start using swiotlb which I believe was all
> about avoiding 32bit DMA limitations but I'm not clear how I should be
> configuring this for IMX8MM with 4GB DRAM. Maybe my kernel IOMMU
> configuration is incorrect somehow?
there are quite some options associated with IOMMU, not sure which one might be causing this. But basically you may check:

CONFIG_IOMMU_IOVA
CONFIG_IOMMU_API
CONFIG_IOMMU_SUPPORT
CONFIG_IOMMU_DMA=y

> 
> I'm also unclear why there was no apparent problem with older kernels
> such as 5.15.
> 
> Best Regards,
> 
> Tim
> 


