Return-Path: <linux-wireless+bounces-14529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94089B05B0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6D51F24CD7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B71D2F6D;
	Fri, 25 Oct 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tkv9IZar"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371B7083A;
	Fri, 25 Oct 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866240; cv=none; b=Fq1xdQWAFRl6X3YRVnAdrnUMN3AeWymIT4/irGi98+HKAfhmyTHmRl921wEIAiefJk34y4Z0F8WxBusi4XG1ItCrXhYlUNnmpbVkCxrR/TCq32jCczC0RLlPO2t8BUSyIK9VNcYP30gJyXtpr35DsNptH1l48mJsfQOmBj0+U+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866240; c=relaxed/simple;
	bh=Eagn6KR7Vu5qf4a0WFptrizR1Q3pPwQYGYlaKFrvzC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=seSxgU93O8luMllMkDOmLGr/VYhM3dieDjVcqIp0Ifhp3Df8gQA5M2bjyMRvjOlth0IEbhVuohScjfBQb9WHte1nr4oEpb53vKD5bzOo7aF4l2ekwU+82WcUDJMSJaELkDu4Y1tUvnMFGMvKwbnLAeNx453Ys/GF76uuMaWpgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tkv9IZar; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBAla8003727;
	Fri, 25 Oct 2024 14:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XVUU3LW0UdnWfaq9PHUYoJe/VTZeYml3GXCx25NU4Q=; b=Tkv9IZarkuL0krp9
	Yv2It454poX1+1VmvVU2JaqnAKyD+bRyiydtBpq64zMyHKMRF+TDnC5rY3aarpoY
	O4K4F6a8WinyV8SYdmRVFynwubKtFeuxYFBhsw1217c1dqeVEcluaWGFYaugYOrC
	9iIIPpcbBgIuz9N334S+nzofUx3mlq3LlE10CjTI1sAx4u9V6Qrcrt854/CpEEHV
	6+42PbVfJxC2xAZBUGwx/WiU2XErza6cNVAp53lOGZiluwvOiFLmvAuEGEb0u2mc
	br6BahQbOLTBCESjm8le9SCt2fgNY+nHSXKHkpdUZQy9uB3ojR2RjxvTAJxdHvt2
	zeXXdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em689cfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:23:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PENoQ9013672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 14:23:50 GMT
Received: from [10.253.77.237] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 07:23:48 -0700
Message-ID: <49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>
Date: Fri, 25 Oct 2024 22:23:45 +0800
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
 <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
 <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
 <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
 <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
 <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h9Cc_friCQJt2G3sPk3zR8I5gKmypg5E
X-Proofpoint-GUID: h9Cc_friCQJt2G3sPk3zR8I5gKmypg5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250111



On 10/25/2024 10:01 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 25, 2024 at 09:43:04PM +0800, Miaoqing Pan wrote:
>>
>>
>> On 10/25/2024 8:21 PM, Dmitry Baryshkov wrote:
>>> On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
>>>>>>> On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
>>>>>>>>> On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
>>>>>>>>>> QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
>>>>>>>>>> IPA, thermal, RAM size and etc, so new firmware files used. This change
>>>>>>>>>> allows board DT files to override the subdir of the firmware directory
>>>>>>>>>> used to lookup the amss.bin and m3.bin.
>>>>>>>>>
>>>>>>>>> I have slight concerns regarding the _board_ DT files overriding the
>>>>>>>>> subdir. This opens a can of worms, allowing per-board firmware sets,
>>>>>>>>> which (as far as I understand) is far from being what driver maintainers
>>>>>>>>> would like to see. This was required for ath10k-snoc devices, since
>>>>>>>>> firmware for those platforms is signed by the vendor keys and it is
>>>>>>>>> limited to a particular SoC or SoC family. For ath11k-pci there is no
>>>>>>>>> such limitation.
>>>>>>>>>
>>>>>>>>> Would it be possible to use PCI subvendor / subdev to identify affected
>>>>>>>>> cards? PCI Revision? Any other way to identify the device?  Please
>>>>>>>>> provide lspci -nnvv for the affected device kind. Is there a way to
>>>>>>>>> identify the RF part somehow?
>>>>>>>>
>>>>>>>> It's rather difficult, for WCN685x, there are multiple evolved subseries for
>>>>>>>> customized products. e.g.
>>>>>>>>
>>>>>>>> QCA6698AQ/hw2.1
>>>>>>>> QCA2066/hw2.1
>>>>>>>> WCN6855/hw2.0/hw2.1
>>>>>>>> WCN6856/hw2.1
>>>>>>>>
>>>>>>>> They have the same PCIe ID (17cb:1103), the commit 5dc9d1a55e95 ("wifi:
>>>>>>>> ath11k: add support for QCA2066") reads TCSR_SOC_HW_SUB_VER to enumerate all
>>>>>>>> QCA2066 cards, it lacks of flexibility, as the list will become longer and
>>>>>>>> longer. But it's the only choice for QCA2066, as it's customized for X86
>>>>>>>> platform which without DT files.
>>>>>>>
>>>>>>> I guess, this is closer to Kalle's expectations: being able to detect
>>>>>>> the hardware instead of adding DT properties.
>>>>>>>
>>>>>>>> So for MSM those have DT file platforms, like SA8775P-RIDE/QCS8300-RIDE both
>>>>>>>> attached to QCA6698AQ, we can specify the correct firmware to
>>>>>>>> 'ath11k/WCN6855/hw2.1/qca6698aq', so it's not per-board firmware, it depends
>>>>>>>> on the type of the products(x86 windows, IoT products or AUTO).
>>>>>>>
>>>>>>> No-no-no and no. The firmware used must not be specific to the product
>>>>>>> type.  This is what everybody here is trying to avoid. Please try
>>>>>>> following the QCA2066 approach instead. And note that it could use new
>>>>>>> TLD as it perfectly shows itself as a different hardware kind.
>>>>>>
>>>>>> Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
>>>>>> revision register in BAR0 space, it's hard to maintain the list.
>>>>>
>>>>> How is it so?
>>>>
>>>> I think QCA2066 approach is just a workaround. Different batches of chip
>>>> manufacture has different value in TCSR_SOC_HW_SUB_VER.
>>>
>>> Ok. So, subvendor / subdevice?
>>
>> The 'subvendor' is fixed to 0x17cb, so it's useless. And I don't have enough
>> samples to decide to use 'subdevice', it's a risk for existing devices.
> 
> What kind of risk? If subvendor is fixed, then it's Qualcomm who
> enumerates subdevices.

It's risk for there is not enough sample card to verify. Subdevice is 
never used by ath1xk drivers.

> 
> I'm really reluctant to bringing more DT usage into the PCIe space.
> Especially if the user is able to swap cards.

Understand your concern, automatic adaptation is always the best choice. 
But it may not work for MSM boards, the PCIe card (non m.2) is 
customized, which has special PMU control. User can't swap cards. And 
that's why power sequencing module was introduced.

> 
>>>>> And if it is hard, can we please get to the _normal_ way how vendors
>>>>> handle PCI hardware differences: the subvendor and subdevice? This is
>>>>> a usual way to describe that the PCIe device is the same, but the
>>>>> analog / tuner / RF / etc parts are different.
>>>>
>>>>
>>>>>
>>>>>> We're going to have another problem to enable NFA765 m.2 card for IoT
>>>>>> platforms, which has different feature sets with X86 platform, so also
>>>>>> new firmware should be used. In this case, QCA2066 approach not works.
>>>>>> Seems DT approach is only choice.
>>>>>>
>>>>>> Could you advice ?
>>>>>
>>>>> Hmm, The first question is _why_ does it have different feature sets?
>>>>> What exactly is different?
>>>>
>>>> Yeah, for IoT device will support SAP/TWT/UL-OFDMA/BSS color and etc new
>>>> features, and the existing x86 firmware mainly for STA mode.
>>>>
>>>> What if the user plugs a normal (laptop)
>>>>> M.2 card into their IoT device?
>>>>
>>>> If there is no DT file to specify the firmware, IoT device will load the
>>>> default firmware, it will affect SAP and WiFi-6 advanced features.
>>>
>>> Can we get all those nice features into x86 world instead?
>>
>> It's out of our scope, we will not touch the existing stable firmware
>> version, also it's not allowed.
> 
> If it's not allowed for laptop cards, why is it allowed for IoT M.2
> cards (which then can be perfectly installed into the laptop)?
> 

Only specific IoT M.2 cards.



