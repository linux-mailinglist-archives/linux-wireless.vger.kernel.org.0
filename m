Return-Path: <linux-wireless+bounces-14796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8C9B8887
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 02:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6AF1F22C02
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECB450F2;
	Fri,  1 Nov 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C2/EUBvV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5627473;
	Fri,  1 Nov 2024 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424781; cv=none; b=gu81JWi58TtteoylCNkqZWlGkqLb10u8beIdxaL3dIrvQxqHrLj62NSOi9HFcApLFAGVKKQorL5WltDHpHUx13amIdSqn2Jz9LyLD/5j3pMuCecUa519kK8Dx0O/xyZi8b/C1uYN7CaItbUncaE95ioWd+T4KT9lv5tDglVOUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424781; c=relaxed/simple;
	bh=E0aXj+6yccqkcviulQjqqSi+OkjivzWg/QX+ShkqelU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gTyG6CabjQH0MOxkeYBzzoGFGPcu4pfQfnuM7xJ2a5y5p5bioKHKUPcrkeXjh65zN2BRiMmHlqifbYBbOcJ3NKQ9hmPMFQ/bvMtIWVrR85YPc1tvoeOaTAtZ8JST/aqScG+o8b0wbGv5mSpPr+qXUkLDREqv9GL6DDakptu/J8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C2/EUBvV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VCk51U003883;
	Fri, 1 Nov 2024 01:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PevRws9lWahN3nDSBG5OMAd+WeRoNqqEizhnVsb/dHc=; b=C2/EUBvVqtZ1U91E
	kJzn2opTY8m9h1Wj0CZmuvq2qEDe78acaSLpVQwIMnzEtJ4t2QBkGzyo93lpEIlo
	hqhMcVd0Y4p+vq28/ud2wkrcK+n+Nu79lBR8/vzWAP7ZYl0fawONBFwCHRDL9go0
	hsHOl5NxMv/PyYUKMsAYWJnaWXpGuQMJfftLAL2QYsH8rni19IWureBauVNRGIUf
	ZzGGV4eq/KLetFkYr1Qa4cRLj3aj/szefDZ5jpzXZgj2TvhhMrrteE7HryUvTPnT
	QWiUb1Axhl4EZwRPjwPkGey4Kz7huaHMxR2/yyR32uDoaBq+jVazC088ofzP78/7
	iARvfA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kns3n9s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 01:32:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A11Wf3F021935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 01:32:41 GMT
Received: from [10.231.216.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 18:32:39 -0700
Message-ID: <3dd897cb-5cc3-409d-a310-66e71847d58f@quicinc.com>
Date: Fri, 1 Nov 2024 09:32:37 +0800
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
        <linux-arm-msm@vger.kernel.org>, <quic_zhichen@quicinc.com>
References: <46de0bfe-ebdd-4b37-a957-3c64e30a1376@quicinc.com>
 <CAA8EJpr4zgV4Sa4sPdCToQWs+CFJu6Xz6CPcPyHDhDczmuzj=g@mail.gmail.com>
 <06ff37ef-dfda-470f-80f7-0f54bae25686@quicinc.com>
 <CAA8EJppFCXeUAZax+jv42JrKYgLmaPQNpXhn-06q_K_uB9JZLQ@mail.gmail.com>
 <46b18b39-9e88-42f8-aa88-5b527fc92a9f@quicinc.com>
 <xp5j6kkpggfhxvzuozqcvs2ugon5xexjgzl24zjlen7kggdaju@vd3okew4vcsy>
 <49313be4-b0e2-4ec4-8663-bd4daf20f78a@quicinc.com>
 <ksyukz7oouw2ilxxpx5nhnshu3zmnd5rtgeloea2vykzzn6ii5@unvpx26neirt>
 <590b729b-a921-4ed7-af2d-326cf596ae1f@quicinc.com>
 <73916bc3-f3c8-4ef9-ab8b-d1497f228d13@quicinc.com>
 <csqlwll36viejkp7k57r3jdejpt2kkttmzawq6y6q7i7qs25ht@n3mazu6owblv>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <csqlwll36viejkp7k57r3jdejpt2kkttmzawq6y6q7i7qs25ht@n3mazu6owblv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PoiHM9QdpBOLbAxERmVTpj8U4bo0ifsT
X-Proofpoint-ORIG-GUID: PoiHM9QdpBOLbAxERmVTpj8U4bo0ifsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=863 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010009



On 10/28/2024 9:45 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 28, 2024 at 06:32:58PM +0800, Miaoqing Pan wrote:
>>
>>
>> On 10/26/2024 10:31 AM, Miaoqing Pan wrote:
>>>
>>>
>>> On 10/25/2024 11:27 PM, Dmitry Baryshkov wrote:
>>>> On Fri, Oct 25, 2024 at 10:23:45PM +0800, Miaoqing Pan wrote:
>>>>>
>>>>>
>>>>> On 10/25/2024 10:01 PM, Dmitry Baryshkov wrote:
>>>>>> On Fri, Oct 25, 2024 at 09:43:04PM +0800, Miaoqing Pan wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/25/2024 8:21 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Fri, 25 Oct 2024 at 15:03, Miaoqing Pan
>>>>>>>> <quic_miaoqing@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 10/25/2024 6:20 PM, Dmitry Baryshkov wrote:
>>>>>>>>>> On Fri, 25 Oct 2024 at 10:23, Miaoqing Pan
>>>>>>>>>> <quic_miaoqing@quicinc.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 10/25/2024 2:01 PM, Dmitry Baryshkov wrote:
>>>>>>>>>>>> On Fri, Oct 25, 2024 at 10:56:02AM +0800, Miaoqing Pan wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 10/25/2024 3:39 AM, Dmitry Baryshkov wrote:
>>>>>>>>>>>>>> On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
>>>>>>>>>>>>>>> QCA6698AQ IP core is the
>>>>>>>>>>>>>>> same as WCN6855 hw2.1,
>>>>>>>>>>>>>>> but it has different RF,
>>>>>>>>>>>>>>> IPA, thermal, RAM size
>>>>>>>>>>>>>>> and etc, so new firmware
>>>>>>>>>>>>>>> files used. This change
>>>>>>>>>>>>>>> allows board DT files to
>>>>>>>>>>>>>>> override the subdir of
>>>>>>>>>>>>>>> the firmware directory
>>>>>>>>>>>>>>> used to lookup the amss.bin and m3.bin.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I have slight concerns
>>>>>>>>>>>>>> regarding the _board_ DT
>>>>>>>>>>>>>> files overriding the
>>>>>>>>>>>>>> subdir. This opens a can of
>>>>>>>>>>>>>> worms, allowing per-board
>>>>>>>>>>>>>> firmware sets,
>>>>>>>>>>>>>> which (as far as I
>>>>>>>>>>>>>> understand) is far from
>>>>>>>>>>>>>> being what driver
>>>>>>>>>>>>>> maintainers
>>>>>>>>>>>>>> would like to see. This was
>>>>>>>>>>>>>> required for ath10k-snoc
>>>>>>>>>>>>>> devices, since
>>>>>>>>>>>>>> firmware for those platforms
>>>>>>>>>>>>>> is signed by the vendor keys
>>>>>>>>>>>>>> and it is
>>>>>>>>>>>>>> limited to a particular SoC
>>>>>>>>>>>>>> or SoC family. For
>>>>>>>>>>>>>> ath11k-pci there is no
>>>>>>>>>>>>>> such limitation.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Would it be possible to use
>>>>>>>>>>>>>> PCI subvendor / subdev to
>>>>>>>>>>>>>> identify affected
>>>>>>>>>>>>>> cards? PCI Revision? Any
>>>>>>>>>>>>>> other way to identify the
>>>>>>>>>>>>>> device?  Please
>>>>>>>>>>>>>> provide lspci -nnvv for the
>>>>>>>>>>>>>> affected device kind. Is
>>>>>>>>>>>>>> there a way to
>>>>>>>>>>>>>> identify the RF part somehow?
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's rather difficult, for
>>>>>>>>>>>>> WCN685x, there are multiple
>>>>>>>>>>>>> evolved subseries for
>>>>>>>>>>>>> customized products. e.g.
>>>>>>>>>>>>>
>>>>>>>>>>>>> QCA6698AQ/hw2.1
>>>>>>>>>>>>> QCA2066/hw2.1
>>>>>>>>>>>>> WCN6855/hw2.0/hw2.1
>>>>>>>>>>>>> WCN6856/hw2.1
>>>>>>>>>>>>>
>>>>>>>>>>>>> They have the same PCIe ID
>>>>>>>>>>>>> (17cb:1103), the commit
>>>>>>>>>>>>> 5dc9d1a55e95 ("wifi:
>>>>>>>>>>>>> ath11k: add support for
>>>>>>>>>>>>> QCA2066") reads
>>>>>>>>>>>>> TCSR_SOC_HW_SUB_VER to enumerate
>>>>>>>>>>>>> all
>>>>>>>>>>>>> QCA2066 cards, it lacks of
>>>>>>>>>>>>> flexibility, as the list will
>>>>>>>>>>>>> become longer and
>>>>>>>>>>>>> longer. But it's the only choice
>>>>>>>>>>>>> for QCA2066, as it's customized
>>>>>>>>>>>>> for X86
>>>>>>>>>>>>> platform which without DT files.
>>>>>>>>>>>>
>>>>>>>>>>>> I guess, this is closer to Kalle's
>>>>>>>>>>>> expectations: being able to detect
>>>>>>>>>>>> the hardware instead of adding DT properties.
>>>>>>>>>>>>
>>>>>>>>>>>>> So for MSM those have DT file
>>>>>>>>>>>>> platforms, like SA8775P-RIDE/
>>>>>>>>>>>>> QCS8300-RIDE both
>>>>>>>>>>>>> attached to QCA6698AQ, we can specify the correct firmware to
>>>>>>>>>>>>> 'ath11k/WCN6855/hw2.1/qca6698aq',
>>>>>>>>>>>>> so it's not per-board firmware,
>>>>>>>>>>>>> it depends
>>>>>>>>>>>>> on the type of the products(x86 windows, IoT products or AUTO).
>>>>>>>>>>>>
>>>>>>>>>>>> No-no-no and no. The firmware used
>>>>>>>>>>>> must not be specific to the product
>>>>>>>>>>>> type.  This is what everybody here is trying to avoid. Please try
>>>>>>>>>>>> following the QCA2066 approach
>>>>>>>>>>>> instead. And note that it could use
>>>>>>>>>>>> new
>>>>>>>>>>>> TLD as it perfectly shows itself as a different hardware kind.
>>>>>>>>>>>
>>>>>>>>>>> Actually, TCSR_SOC_HW_SUB_VER is not SOC register, it's a TLMM hw
>>>>>>>>>>> revision register in BAR0 space, it's hard to maintain the list.
>>>>>>>>>>
>>>>>>>>>> How is it so?
>>>>>>>>>
>>>>>>>>> I think QCA2066 approach is just a workaround.
>>>>>>>>> Different batches of chip
>>>>>>>>> manufacture has different value in TCSR_SOC_HW_SUB_VER.
>>>>>>>>
>>>>>>>> Ok. So, subvendor / subdevice?
>>>>>>>
>>>>>>> The 'subvendor' is fixed to 0x17cb, so it's useless. And
>>>>>>> I don't have enough
>>>>>>> samples to decide to use 'subdevice', it's a risk for
>>>>>>> existing devices.
>>>>>>
>>>>>> What kind of risk? If subvendor is fixed, then it's Qualcomm who
>>>>>> enumerates subdevices.
>>>>>
>>>>> It's risk for there is not enough sample card to verify.
>>>>> Subdevice is never
>>>>> used by ath1xk drivers.
>>>>
>>>> Oh, so it's just about development. I'd say, please discuss such risks
>>>> with your management, unless Kalle or Jeff disagree with using the
>>>> subdevice for identification.
>>>
>>> Kalle & Jeff, any idea to introduce subdevice ?
>>>
>>>
>>
>> Whether 'QCA2066 approach' or 'subdevice approach', all need to introduce
>> lots of redundant code, as they share the same IP code.
>>
>> 'DT approach' only needs minor change, brings great flexibility. It's only
>> for Snapdragon boards, will not affect default firmware for X86 platforms.
>>
>>>>
>>>>>
>>>>>>
>>>>>> I'm really reluctant to bringing more DT usage into the PCIe space.
>>>>>> Especially if the user is able to swap cards.
>>>>>
>>>>> Understand your concern, automatic adaptation is always the best
>>>>> choice. But
>>>>> it may not work for MSM boards, the PCIe card (non m.2) is
>>>>> customized, which
>>>>> has special PMU control. User can't swap cards. And that's why power
>>>>> sequencing module was introduced.
>>>>
>>>> I know. Still, it's better to have less unnecessary data there for
>>>> autodiscoverable devices.
>>>
>>
>> We discussed internally, we have no other choice to enable NFA765 for non
>> X86 boards. Could you please approve this 'DT' approach ?
> 
> If you can't use subdevice approach for some reason, then we have no
> other choice that I can imagine.
> 

A new patch was submitted: 
https://lore.kernel.org/linux-wireless/20241031000541.3331606-1-quic_miaoqing@quicinc.com/. 
This patch will add QCA6698AQ support, which follows the approach done 
in commit 5dc9d1a55e95 ("wifi: ath11k: add support for QCA2066"), 
enumerates the subversion number to identify the specific card.

But there is still a problem enabling NFA765 m.2 card for IoT platforms, 
which requires ath11k to support board-specific firmware overrides.




