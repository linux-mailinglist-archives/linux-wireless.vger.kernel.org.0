Return-Path: <linux-wireless+bounces-6211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3D8A2506
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F9B1F241FD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 04:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998353E0E;
	Fri, 12 Apr 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fltbi8H8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1753E0C
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895138; cv=none; b=Ktm0FtZJ17Tj/Hqhi7sB6JNsNLDnSVLN/t/YRuQ6xU+jllkaf2mp8ZOYc5zcpC5Ju4bMNsJ3yQEwUMBQMZbSO8BBkRjGM+7ihFVrwRsxSaJ43X/hJCc+uw1hLHBafVe6u6EckRS8GkdaERXj6BlOSQiHQhFvvhmdcyvIVMgv1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895138; c=relaxed/simple;
	bh=cXXYRit1lQTxvtNuja3KkC2s9KSuIiCfKlu90pM9Rgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LXh5yiGCMOFSAxEQJ4j1A3trTWQX6HEcB0iAvGXYgfZ0vlY0804dUTzH+ABThPoiPuoiKorDL3ayRMYD9EiKWdpIrDt10+d0DmdD9EnXF7RPfgW9AKoM5AqNdiydJaxi6b0gA/jB4tTtNGbFE9LUw5CVIm/r1K4GNO9cb1aLoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fltbi8H8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C3HWp7018755;
	Fri, 12 Apr 2024 04:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=V28+JOadOYjwfGsVqtPSP0u596xNzPVUwVpRdbH3x3g=; b=fl
	tbi8H8NofVUc33v5DKW1dSx+EKz4tzr2UNt6qrpt779C/pKMsSONwj3yrtjw99xW
	LCgXYbfY+7Qftv11wnJWtQjCOnwpmkWVBGdThu8jnT2WegVuupC082wLNh7cGGqj
	+lrLWayp+eohqyzkoWjd93PTu3morXWlStqk3S8EN6lnMDjws8CoN4f7RgIrpgEM
	4MxpaRZ1yqaKYS/rIPq7aXWsCyEtH6jrEsFIuOF2PU8r6PfmMjgUPU/mFixkAICr
	R/w83tR3W7A7Kt24NjzrW149zPT0GclXkFhmnAZpEZXLqdjsDiiQu1yKtlVXQ6zG
	XphzohosiHI4JcP+MeAw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xep6fgrb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 04:11:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C4Bs6o024156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 04:11:54 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 21:11:51 -0700
Message-ID: <cb991a00-fce2-5a3d-c03f-579b44f922f5@quicinc.com>
Date: Fri, 12 Apr 2024 09:41:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y0A4HPy7R4UUzPI68klmUXQhwRXh8DEo
X-Proofpoint-ORIG-GUID: y0A4HPy7R4UUzPI68klmUXQhwRXh8DEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404120028



On 4/11/2024 2:33 AM, Ben Greear wrote:
> On 4/10/24 08:42, Johannes Berg wrote:
>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>
>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>> + *    hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>> + *    one wiphy can advertise the list of channels supported by each physical
>>>>>>>>> + *    hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>> + *    used while describing interface combination for each of them.
>>>>>>>>
>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>> a single "hardware"?
>>>>>>>>
>>>>>>>
>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>> hardware.
>>>>>>
>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>> knew or paid attention to.
>>>>>
>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>> other phys as needed to get a full picture?
>>>>>
>>>>
>>>> There's not really a good way to _do_ that short of creating multiple
>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>> and mac80211) so we rejected it years ago.
>>>
>>> I thought the problem ath12k is trying to fix is that there are currently multiple phys 
>>> (radios) that needed to be made to
>>> look like a single phy?
>>
>> Correct.
>>
>>> For dual and tri-concurrent radios, I think we will need them to look like 3 individual 
>>> radios for non-MLO use
>>> cases
>>
>> No, I don't see why, and if you want that we wouldn't support it anyway,
>> you'd have to have a module option or something to decide which way to
>> go.
>>
>> But it really ought to not be needed - the point of these patches is to
>> give userspace enough information to know how to (and where) to create
>> separate BSSes, with or without MLO between them.
>>
>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used 
>>> independently.
>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to 
>>> start acting
>>> at least somewhat like a single entity
>>
>> Yes.
>>
>>> (while also concurrently being able to act as individual
>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>
>> No.
> 
> Hello Johannes,
> 
> Is there any design document for the combined phy approach somewhere publicly available?
> 
> It is hard to understand the over all goals by just reading patches as they show up on
> the public mailing lists...
> 

Hi Ben,

I dont think there is a document for this composite phy approach. But we try to clarify
as much as possible in the commit log and kernel-doc. Pls let us know the area which
is more appropriate to be clarified in the path.

Vasanth

