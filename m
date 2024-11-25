Return-Path: <linux-wireless+bounces-15679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC589D7BEC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 08:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EA0B21846
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA5143722;
	Mon, 25 Nov 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i1hj1BjF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C2E1426C
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519434; cv=none; b=t+5dpnkCXe9/CmQ9zTtsbUDnSWLeqDrrtY0EWFKYlP832qAqF6TMM2zBzDFPeEB+DHx6Mghn2e8s8e0+8oWXxnWSsVGGvb9hYYnGgOfGnJTEuOhTkjGICeRkul5GrzR4vdDmzjeQt2D6yW5YRAWrBJisVTDiV7SjDbO6sFMNWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519434; c=relaxed/simple;
	bh=Dxvftyp8XHsdFVatNTkx1UXuPMBA9rbRgQd9rIR+PGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2Uo9jTiRO8iy60awBSypPGGXCqtKUrue1yBIfJOpi5eQ7H76Tua6kYqTfvrQFiJR/eJw4+Ydu8B2Nd37vSTHvLdLUTC3ryVJMtg337kNKGVQYG0AcPbRvoXi/gzRJnA3F0cvLi6jA3f4dtngGs1YorgXFwnTqX0XAotYr9j6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i1hj1BjF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONGkdS028343;
	Mon, 25 Nov 2024 07:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5metnj5cPRuH4ZqBUkOLFL9hdzHs+yRd9JUlmwMTag=; b=i1hj1BjFvQQUf8ti
	vJP44Lb7R2HsEV/q6QuX3LYcbj/msgIGb4dtt+ZfPcWWJCo4e6gWZ/bzUuOfnv6N
	qmUMWq81o1+xLwXpV5d/FWcCi5mJ3ALzWqo1Q0xHRMlkc47MWIoVRU/plfkwMYLv
	iHSRTyVOFnv2QIVz+Ah3/Ns/O0x+v7TuYDSl5N4viMazpiSBtm6tPewB/F/6onNy
	yr6f3CKf08mIlexKOBhvD8LvAk1RDtHjQmV0UB4k5OeWpXrAyVtIzO10BVKiCEsm
	mzcM/1mIsi4WVJsWGcHkzH1DJJJWwIa3oYkFTqbwAVGxaCFfMVdms+8qZFQc3XYy
	PJx+IQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfku0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 07:23:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP7NhZb031194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 07:23:43 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 24 Nov
 2024 23:23:42 -0800
Message-ID: <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com>
Date: Mon, 25 Nov 2024 15:23:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Tim Harvey <tharvey@gateworks.com>
CC: <ath11k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NSewfjX8385_nUlmC69DJcmEd3-1Snx6
X-Proofpoint-ORIG-GUID: NSewfjX8385_nUlmC69DJcmEd3-1Snx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250062



On 11/23/2024 8:43 AM, Tim Harvey wrote:
> On Thu, Nov 21, 2024 at 9:51 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>>
>>
>>
>> On 11/22/2024 5:50 AM, Tim Harvey wrote:
>>> On Tue, Nov 19, 2024 at 6:32 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/20/2024 4:16 AM, Tim Harvey wrote:
>>>>> Greetings,
>>>>>
>>>>> I've got an ath11k card that is failing to init on an IMX8MM system
>>>>> with 4GB of DRAM:
>>>>> [    7.551582] ath11k_pci 0000:01:00.0: BAR 0 [mem
>>>>> 0x18000000-0x181fffff 64bit]: assigned
>>>>> [    7.551713] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
>>>>> [    7.552401] ath11k_pci 0000:01:00.0: MSI vectors: 16
>>>>> [    7.552440] ath11k_pci 0000:01:00.0: qcn9074 hw1.0
>>>>> [    7.887186] mhi mhi0: Loaded FW: ath11k/QCN9074/hw1.0/amss.bin,
>>>>> sha256: 5ee1b7b204541b5f99984f21d694ececaec08fbce1b520ffe6fe740b02a4afd7
>>>>> [    8.435964] ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0x0
>>>>> board_id 0xff soc_id 0xffffffff
>>>>> [    8.435991] ath11k_pci 0000:01:00.0: fw_version 0x270206d0
>>>>> fw_build_timestamp 2022-08-04 12:48 fw_build_id
>>>>> WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>>>> [    8.441700] ath11k_pci 0000:01:00.0: Loaded FW:
>>>>> ath11k/QCN9074/hw1.0/board-2.bin, sha256:
>>>>> dbf0ca14aa1229eccd48f26f1026901b9718b143bd30b51b8ea67c84ba6207f1
>>>>> [    9.753764] ath11k_pci 0000:01:00.0: Loaded FW:
>>>>> ath11k/QCN9074/hw1.0/m3.bin, sha256:
>>>>> b6d957f335073a15a8de809398e1506f0200a08747eaf7189c843cf519ffc1de
>>>>> [    9.789791] ath11k_pci 0000:01:00.0: swiotlb buffer is full (sz:
>>>>> 1048583 bytes), total 32768 (slots), used 2528 (slots)
>>>>> [    9.789853] ath11k_pci 0000:01:00.0: failed to set up tcl_comp ring (0) :-12
>>>>> [    9.790238] ath11k_pci 0000:01:00.0: failed to init DP: -12
>>>>> root@noble-venice:~# cat /proc/cmdline
>>>>> console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
>>>>> root=PARTUUID=5cdde84f-01 rootwait net.ifnames=0 cma=196M
>>>>>
>>>>> The IMX8MM's DRAM base is at 1GB so anything above 3GB hits the 32bit
>>>>> address boundary. If I pass in a mem=3096M the device registers just
>>>>> fine.
>>>> yeah ... that parameter makes kernel alloc memory below 32bit boundary, thus swiotlb is not necessary.
>>>
>>> Hi Baochen,
>>>
>>> Yes, that makes sense as I step through the code. On IMX8M with DRAM
>>> 3GB or less dma_capable(...) is true so swiotlb bounce buffers are not
>>> needed.
>>>
>>>>
>>>>>
>>>>> I found this to be the case with modern kernels however I found
>>>>> differing behavior with older kernels:
>>>>> - 6.6 and 6.1 the device registers with 4GB DRAM but crashes on client connect
>>>>> - 5.15 devices registers with 4GB DRAM and appears to work just fine
>>>> are you using Linus' tree or the stable tree?
>>>>
>>>
>>> For 6.6 I tested stable.
>> can you try Linus's tree ? as I know the stable tree is possible to miss some important fix.
>>
>>>
>>> This likely has something to do with commit dbd73acb22d8 ("wifi:
>>> ath11k: enable 36 bit mask for stream DMA") but it would seem to me
>>> that patch was trying to avoid the entire 32bit DMA limitation. Maybe
>>> that patch sets the ath11k device DMA mask to 36 bits but maybe the
>>> IMX8M PCI DMA is only capable of 32bits?
>> that patch is making situation better, not worse. that said, it helps to avoid swiotlb in
>> ath11k DMA, rather than to get it involved.
>>
> 
> Yes, that patch would be an improvement on systems capable of
> addressing 64bit memory but not on the IMX8M which is seemingly
> capable of only 32bit DMA over PCI.
> 
>>>
>>>>>
>>>>> Could anyone explain what is going on here? Obviously there have been
>>>>> changes at some point to start using swiotlb which I believe was all
>>>>> about avoiding 32bit DMA limitations but I'm not clear how I should be
>>>>> configuring this for IMX8MM with 4GB DRAM. Maybe my kernel IOMMU
>>>>> configuration is incorrect somehow?
>>>> there are quite some options associated with IOMMU, not sure which one might be causing this. But basically you may check:
>>>>
>>>> CONFIG_IOMMU_IOVA
>>>> CONFIG_IOMMU_API
>>>> CONFIG_IOMMU_SUPPORT
>>>> CONFIG_IOMMU_DMA=y
>>>>
>>>
>>> These are enabled which I believe appropriate for IMX8M. If I want to
>>> utilize the full 4GB DRAM on IMX then I must use IOMMU and swiotlb
>>> which would mean a performance hit due to copying mem to/from bounce
>>> buffers not to mention the fact that I can't figure out how to
>>> configure the system to avoid the 'swiotlb swiotlb buffer is full'
>>> issue.
> 
> My statement regarding needing an IOMMU above is wrong; apparently the
> IMX8M SoC's don't have an IOMMU but the fact I have it enabled in the
> kernel should be a don't-care. If I understand swiotlb correctly, if I
> did have an IOMMU then it would be used instead of swiotlb.
> 
>>>
>>> Enabling CONFIG_SWIOTLB_DYNAMIC does not help nor does increasing the
>>> number of slots - it has something to do with the number/size of DMA
>>> buffers that ath11k is asking for:
>> yeah, ath11k asks for fixed size DMA buffer regardless of that config.
>>
>>> # dmesg | grep swiotlb_tbl_map_single
>>> [    5.237731] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16384 (slots=32768/    32)
>>> [    5.247519] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16416 (slots=32768/    64)
>>> [    5.261794] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16448 (slots=32768/    96)
>>> [    5.275114] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16480 (slots=32768/   128)
>>> [    5.287757] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16512 (slots=32768/   160)
>>> [    5.299688] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16544 (slots=32768/   192)
>>> [    5.312482] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16576 (slots=32768/   224)
>>> [    5.324493] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16608 (slots=32768/   256)
>>> [    5.337001] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16640 (slots=32768/   288)
>>> [    5.346754] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16672 (slots=32768/   320)
>>> [    5.356571] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16704 (slots=32768/   352)
>>> [    5.366372] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16736 (slots=32768/   384)
>>> [    5.376164] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16768 (slots=32768/   416)
>>> [    5.385944] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16800 (slots=32768/   448)
>>> [    5.395712] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16832 (slots=32768/   480)
>>> [    5.408270] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16864 (slots=32768/   512)
>>> [    5.419768] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16896 (slots=32768/   544)
>>> [    5.430966] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16928 (slots=32768/   576)
>>> [    5.442368] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16960 (slots=32768/   608)
>>> [    5.452422] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 16992 (slots=32768/   640)
>>> [    5.463507] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17024 (slots=32768/   672)
>>> [    5.473536] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17056 (slots=32768/   704)
>>> [    5.485661] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17088 (slots=32768/   736)
>>> [    5.495404] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17120 (slots=32768/   768)
>>> [    5.509626] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17152 (slots=32768/   800)
>>> [    5.519353] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17184 (slots=32768/   832)
>>> [    5.529077] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17216 (slots=32768/   864)
>>> [    5.538799] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17248 (slots=32768/   896)
>>> [    5.548517] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17280 (slots=32768/   928)
>>> [    5.558238] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17312 (slots=32768/   960)
>>> [    5.567965] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index= 17344 (slots=32768/   992)
>>> [    5.578943] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=     0 (slots=32768/   992)
>>> [    5.578964] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8192 (slots=32768/   993)
>>> [    5.599793] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=    32 (slots=32768/   992)
>>> [    5.599861] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  68B index=  8193 (slots=32768/   993)
>>> [    5.609589] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=    64 (slots=32768/   993)
>>> [    5.628921] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=    96 (slots=32768/   992)
>>> [    5.638703] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  68B index= 17376 (slots=32768/   993)
>>> [    5.649602] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   128 (slots=32768/   992)
>>> [    5.659389] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   160 (slots=32768/   992)
>>> [    5.674038] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  96B index= 17377 (slots=32768/   993)
>>> [    5.685016] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   192 (slots=32768/   992)
>>> [    5.694819] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   224 (slots=32768/   992)
>>> [    5.694831] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index= 17378 (slots=32768/   993)
>>> [    5.714194] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  40B index= 17379 (slots=32768/   994)
>>> [    5.725089] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   256 (slots=32768/   992)
>>> [    5.753507] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17380 (slots=32768/   996)
>>> [    5.764668] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   288 (slots=32768/   992)
>>> [    5.774456] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   320 (slots=32768/   992)
>>> [    5.774620] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17384 (slots=32768/   996)
>>> [    5.795091] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   352 (slots=32768/   992)
>>> [    5.795241] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17388 (slots=32768/   996)
>>> [    5.815724] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   384 (slots=32768/   992)
>>> [    5.815884] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17392 (slots=32768/   996)
>>> [    5.836357] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   416 (slots=32768/   992)
>>> [    5.836368] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8194 (slots=32768/   993)
>>> [    5.855856] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17396 (slots=32768/   997)
>>> [    5.866818] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   448 (slots=32768/   992)
>>> [    5.866978] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17400 (slots=32768/   996)
>>> [    5.887451] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   480 (slots=32768/   992)
>>> [    5.897231] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   512 (slots=32768/   992)
>>> [    5.897389] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17404 (slots=32768/   996)
>>> [    5.917866] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   544 (slots=32768/   992)
>>> [    5.918026] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17408 (slots=32768/   996)
>>> [    5.938489] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   576 (slots=32768/   992)
>>> [    5.938642] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17412 (slots=32768/   996)
>>> [    5.959121] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   608 (slots=32768/   992)
>>> [    5.959135] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8195 (slots=32768/   993)
>>> [    5.978619] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17416 (slots=32768/   997)
>>> [    5.989588] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   640 (slots=32768/   992)
>>> [    5.989738] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17420 (slots=32768/   996)
>>> [    6.010215] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   672 (slots=32768/   992)
>>> [    6.020001] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   704 (slots=32768/   992)
>>> [    6.020158] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17424 (slots=32768/   996)
>>> [    6.040643] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   736 (slots=32768/   992)
>>> [    6.040798] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17428 (slots=32768/   996)
>>> [    6.061287] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   768 (slots=32768/   992)
>>> [    6.061437] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17432 (slots=32768/   996)
>>> [    6.081918] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   800 (slots=32768/   992)
>>> [    6.081929] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8196 (slots=32768/   993)
>>> [    6.101409] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17436 (slots=32768/   997)
>>> [    6.112375] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   832 (slots=32768/   992)
>>> [    6.112528] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17440 (slots=32768/   996)
>>> [    6.133004] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   864 (slots=32768/   992)
>>> [    6.142785] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   896 (slots=32768/   992)
>>> [    6.142949] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17444 (slots=32768/   996)
>>> [    6.163426] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   928 (slots=32768/   992)
>>> [    6.163576] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17448 (slots=32768/   996)
>>> [    6.184058] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   960 (slots=32768/   992)
>>> [    6.184208] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17452 (slots=32768/   996)
>>> [    6.204691] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=   992 (slots=32768/   992)
>>> [    6.204704] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8197 (slots=32768/   993)
>>> [    6.224183] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17456 (slots=32768/   997)
>>> [    6.235148] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1024 (slots=32768/   992)
>>> [    6.235308] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 6224B index= 17460 (slots=32768/   996)
>>> [    6.255777] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1056 (slots=32768/   992)
>>> [    6.265552] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1088 (slots=32768/   992)
>>> [    6.265633] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 2128B index= 17464 (slots=32768/   994)
>>> [    6.286142] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1120 (slots=32768/   992)
>>> [    6.286182] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  72B index= 17466 (slots=32768/   993)
>>> [    7.574489] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1152 (slots=32768/   992)
>>> [    7.584645] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  60B index= 17467 (slots=32768/   993)
>>> [    7.595593] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1184 (slots=32768/   992)
>>> [    7.595608] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  8198 (slots=32768/   993)
>>> [    7.605359] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1216 (slots=32768/   993)
>>> [    7.624703] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 452B index=  1248 (slots=32768/   993)
>>> [    7.635603] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1280 (slots=32768/   992)
>>> [    7.645344] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>>  52B index=  1312 (slots=32768/   993)
>>> [    7.656247] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1314 (slots=32768/   992)
>>> [    7.683567] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single size=
>>> 65535B index=  1346 (slots=32768/   992)
>>> [    7.696095] ath11k_pci 0000:01:00.0: swiotlb_tbl_map_single
>>> size=1048583B index=    -1 (slots=32768/   992)
>>>
>>> I'm still trying to understand the swiotlb allocation to see if there
>>> is some configuration change I should be making.
>>
>> I suspect you hit the same issue mentioned here:
>>
>> https://lore.kernel.org/all/CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com/
>>
>> so can you check if below commit present in your kernel, and if not could you pick it up
>> and try again?
>>
>> commit 14cebf689a78 ("swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE")
ignore this request since it should be no related to your issue :(

>>
> 
> I bisected the 'swiotlb buffer is full' issue back to commit
> aaf244141ed7 ("wifi: ath11k: fix IOMMU errors on buffer rings") which
> looks to me to be a legitimate fix and if I revert it swiotlb is now
> happy and the driver registers but I get the crash on client connect
> that I was seeing in 6.6 so that commit fixes an issue, but causes
> swiotlb to not be fulfilled.
not really ... that commit is not the cause to your issue. you don;t see the 'swiotlb
full' error after revert it simply because dma_map_single() is NOT called then.


> 
> The issue seems to be that the swiotlb memory buffer allocator is
> getting too fragmented to be useful with what ath11k is now asking for
> (a lot of 2K and 64K buffers and then finally a 1048583B buffer which
> fails due to the fragmentation of the swiotlb buffer.
no, the direct cause to 'swiotlb full' error is that kernel does not allow a swiotlb map
request larger than 256kb [1]:

'A single allocation from swiotlb is limited to IO_TLB_SIZE * IO_TLB_SEGSIZE bytes, which
is 256 KiB with current definitions'

while here ath11k is requesting a buffer of 1048583 bytes.


howevr the question is that why swiotlb is involved here: for streamed DMA operation
ath11k is capable of addressing 64GB memory (with 36bit DMA mask), in your case this
covers whole system memory. the most possible reason I can think of is that swiotlb is
forcebly enabled in your kernel (with swiotlb=force?) such that each DMA buffer would be
bounced by swiotlb regardless of its physical address.



[1] Documentation/core-api/swiotlb.rst

> 
> I'm guessing that this has gone unnoticed for a while because there
> are maybe not a lot of systems out there that require swiotlb with
> ath11k (either no IOMMU or more memory than DMA can address) and my
> guess is that if you test ath11k with swiotlb=force you will easily
> see this 'swiotlb buffer is full' issue on other systems.
> 
> I'm not that knowledgeable about ath11k but I do know that ath10 and
> ath12k do not have this issue with swiotlb. Debugging a bit shows that
> there are a lot of large DMA buffers being requested by ath11k and I'm
> wondering if that could be reduced or optimized somehow.
> 
>>
>>>
>>> To avoid using swiotlb is there some way to limit the memory region
>>> used for DMA operations to below 32bit boundary yet still allow the
>>> memory above 32bit to be useful in the system for userspace maybe?
>> if you are using dma_alloc_coherent() I'm afraid there is no way for that. the API
>> internally ignores any zone flags passed with the 'gfp' argument. see
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c#n615
>>
> 
> is DMA_RESTRICTED_POOL a solution for me?
i don;t think this help since this is used in coherent DMA?

> 
> Best Regards,
> 
> Tim
> 


