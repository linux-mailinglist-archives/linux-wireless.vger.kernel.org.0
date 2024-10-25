Return-Path: <linux-wireless+bounces-14501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1699AFAE2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AAC1C21D4C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF01925B0;
	Fri, 25 Oct 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aRmCfi8+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE21BC5C;
	Fri, 25 Oct 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840988; cv=none; b=PJuLTNwQLN/i+h9Qr7YLevpvSUF7K6UKZrpEEg4IsptrcoSO/SIhWztt27YfE/vxgdhqsgn57vlsXxN4oqA3yqLNJsPecNJPaI5Z5Oe3caG8MN2UmkhXdfDA+aC66YQsA9UztbqiJPfSvI8AisLpOHIpf1D19ROsCKfcfgFLQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840988; c=relaxed/simple;
	bh=Vz81de2dTtcSvQVe9/uWcYxcYzqICUHN3tnjqyy/zbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XJyWTGJLW141RcJWNcbcLijrELNPPAvXgIAKht1XfUC3OR1/f6cO0xxdijgYCYUHQk5m256h2Kd9k3Qxc+CON36vFqRJ7HW4LmYdnHHeuW8tDKaVowRNiHIlR+ioBYkq5GulfcEAPSBJrt0Ht0CJ29Cbxp2tvPykF5jG4f/o2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aRmCfi8+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P62Nt4011872;
	Fri, 25 Oct 2024 07:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3fGhefmJFrI68WA5TIXt8nAew1p7nkACWVJKgZe3/9w=; b=aRmCfi8+i7JnmKbA
	nh0AgbjpXD9d9szwNFN5AVut/wwDplRCt1jQYv4BNhpEa9oDOUb4mOgMoYBFOLVX
	oPcbKooS2yoPUDx/voY0TR5H03urcKKv+IkwS3slEeaeByNGVHpKwKJueFnViv8Z
	tHVeiAGpcw5H+Ij60fefvbrRljKQoD1AoDBwIJHl579Lh4AaeRs5fqrvBixdDCTJ
	jzbDz57yRvCaVAev3XkwcPZQTqcbuP0WqirXDDLKeRQVdBsdHPlqPQe/Au/fri5R
	z7ymgS/kvtHbWSBaCYcpvSHIekKzQSFvtdre37koiigeWnw/mGW280xsJREtuDV9
	731ucw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g5q80601-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:22:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P7MwgK004582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:22:58 GMT
Received: from [10.231.216.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 00:22:56 -0700
Message-ID: <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
Date: Fri, 25 Oct 2024 15:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
 <20241024002514.92290-3-quic_miaoqing@quicinc.com>
 <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
 <bc3c06eb-1cb2-4cbb-aaad-95c09223f0cc@quicinc.com>
 <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <ig3m3sgmnkgfmwrlglundhqif6rygzl7uh7rzoemrz3yxgvfpc@35a323mw2wbt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vLY0gUNKwtSfUmcadLkU2VtZiE56iv5q
X-Proofpoint-GUID: vLY0gUNKwtSfUmcadLkU2VtZiE56iv5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=970 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250056



On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
>>
>>
>> On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
>>>> QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
>>>> IPA, thermal, RAM size and etc, so new firmware files used. This change
>>>> allows board DT files to override the subdir of the firmware directory
>>>> used to lookup the amss.bin and m3.bin.
>>>
>>> I have slight concerns regarding the _board_ DT files overriding the
>>> subdir. This opens a can of worms, allowing per-board firmware sets,
>>> which (as far as I understand) is far from being what driver maintainers
>>> would like to see. This was required for ath10k-snoc devices, since
>>> firmware for those platforms is signed by the vendor keys and it is
>>> limited to a particular SoC or SoC family. For ath11k-pci there is no
>>> such limitation.
>>>
>>> Would it be possible to use PCI subvendor / subdev to identify affected
>>> cards? PCI Revision? Any other way to identify the device?  Please
>>> provide lspci -nnvv for the affected device kind. Is there a way to
>>> identify the RF part somehow?
>>
>> It's rather difficult, for WCN685x, there are multiple evolved subseries for
>> customized products. e.g.
>>
>> QCA6698AQ/hw2.1
>> QCA2066/hw2.1
>> WCN6855/hw2.0/hw2.1
>> WCN6856/hw2.1
>>
>> They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
>> ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
>> QCA2066 cards, it lacks of flexibility, as the list will become longer and
>> longer. But it's the only choice for QCA2066, as it's customized for X86
>> platform which without DT files.
> 
> I guess, this is closer to Kalle's expectations: being able to detect
> the hardware instead of adding DT properties.
> 
>> So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
>> attached to QCA6698AQ, we can specify the correct firmware to
>> 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
>> on the type of the products(x86 windows, IoT products or AUTO).
> 
> No-no-no and no. The firmware used must not be specific to the product
> type.  This is what everybody here is trying to avoid. Please try
> following the QCA2066 approach instead. And note that it could use new
> TLD as it perfectly shows itself as a different hardware kind.

Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw 
revision register in BAR0 space, it's hard to maintain the list.

We're going to have another problem to enable NFA765 m.2 card for IoT 
platforms, which has different feature sets with X86 platform, so also 
new firmware should be used. In this case, QCA2066 approach not works. 
Seems DT approach is only choice.

Could you advice ?


> 
>> 0000:01:00.0 Network controller [0280]: Qualcomm QCNFA765 Wireless Network
>> Adapter [17cb:1103] (rev 01)
>> 	Subsystem: Qualcomm QCNFA765 Wireless Network Adapter [17cb:0108]
>> 	Device tree node: /sys/firmware/devicetree/base/pci@1c00000/pcie@0/wifi@0
>>
>>
>>>
>>> Could you possibly clarify, how this situation is handled in Windows
>>> world?
>>
>> X86 platforms use standard m.2 PCIe card, and it will only use the default
>> main firmware files, as they without DT files.
> 
> So QCA6698AQ cannot appear on an M.2 PCIe card?

No, but no m.2 PCIe card so far. It depends on power sequencing module 
to do power up.

> 
>>
>>>
>>>>
>>>> For example:
>>>>
>>>> - ath11k/WCN6855/hw2.1/amss.bin,
>>>>     ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default
>>>>
>>>> - ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
>>>>     ath11k/WCN6855/hw2.1/qca6698aq/m3.bin
>>>
> 


