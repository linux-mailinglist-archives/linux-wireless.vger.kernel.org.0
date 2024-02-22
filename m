Return-Path: <linux-wireless+bounces-3891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76585EF23
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 03:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4669D28389E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA806125D7;
	Thu, 22 Feb 2024 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T3MSHrPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291210A19
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568838; cv=none; b=a/uE63xU3aD9ZAqzGMJDvfFBjWGsLAEllDJ+lgTzHzew9+GZVIDO0PYFgA4ssiU69vo+UGqLf01L/mCZZ1shxXr9xDHdaMl3HOVxiC+YBM1hfA44CKTpBp7fJuN63i5242IgCnwnb4QKWAb3bacu99wjCCYeslkRkfTrILiiSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568838; c=relaxed/simple;
	bh=tG50GTxK5OW86d0q0gJBhQ+MbSOQwQ5Jf3aVaDnimj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oxNs5GXxKluu3nmVExR8E3B7QhjDJczontbSBbo+uLfk130lDHEu1iQaBOfNIKgIBST0fWR5YD+nMFZRVJwOAFOo0QR5eSMiFy/a7hdMsEzk2VOwMkiZvPvoNnYDs+YCF1YQGM6PnyjXzYLq6+Mo10bPCHwYVg2K0Am2ycbeJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T3MSHrPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M0t79R003821;
	Thu, 22 Feb 2024 02:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WCRqsmVIUC0ZU9cijek8ats1kVe1u6JnVzeVhtYNO1g=; b=T3
	MSHrPQwmD4oRkvp+D2K0YX6YV1gl70fuMl7yAvDn+RaYdn7XGEikVIsZdlk/prtJ
	meqSLUFKqwqHT1dRKcNFCOkGwquFiFNdyxJyqQNJ3LiRkW8WuZAgqiNHSb+wVXri
	QqDEv0/5CF/dKxrtqxuV8lzTvb0gTqyCadPSe9F7g27IHNHvYu+wcBOAXjThCoGp
	EkUWGs/XgJPmPLLxYiwT6hFBsZZdROsgJSa1H5ccXLanXgskBUwFBsgJkEgGg5jL
	27q0u5bxaC7FDo6hT/miZsDpurGkU+WkwbLRTg4i9ItGoPZkVAVzjw15EovKG9O5
	FkAmumB78hkV0Qus4r8w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfx4hxc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:27:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M2QnKJ013300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:26:49 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 18:26:48 -0800
Message-ID: <026d9ba3-525d-4a12-8d03-5fece818330c@quicinc.com>
Date: Thu, 22 Feb 2024 10:26:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
 <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
 <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
 <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aoXNhlcmuNX24PyQzxDv1ccO7RvbfToT
X-Proofpoint-GUID: aoXNhlcmuNX24PyQzxDv1ccO7RvbfToT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220018



On 2/21/2024 8:24 PM, James Prestwood wrote:
> 
> On 2/20/24 7:45 PM, Baochen Qiang wrote:
>>
>>
>> On 1/31/2024 8:28 PM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>>>> As you may have guessed I don't _really_ know what I'm doing. When 
>>>>> I got this working with ath10k I saw monitor device was being used 
>>>>> in order to receive probes, and did the same for multicast action 
>>>>> frames and it "just worked". The frames themselves were still being 
>>>>> received on the station device. I attempted to mimic the changes 
>>>>> with ath11k.
>>>>>
>>>>> The end goal here is just that, be able to receive multicast action 
>>>>> frames on the station device which currently does not work. I'm 
>>>>> only seeing unicast frames when i enable RX debugging. The driver 
>>>>> support for multicast action RX in the kernel for this is basically 
>>>>> zero. An extended feature flag was added by Jouni when he added 
>>>>> support to ath9k, I added limited ath10k support for a variant I 
>>>>> tested, and I'd like to do the same for ath11k as we are 
>>>>> transitioning to the WCN6855.
>>>> OK, so you are testing this with latest ath.git, without any private 
>>>> changes, and it doesn't work, right? Could you share your test 
>>>> steps? Basically how are you sending multicast action frames from 
>>>> AP/peer, and how to check if that frame received or not (I am 
>>>> assuming by checking RX logs)?
>>>
>>> Yep I'm on the latest ath.git, and with no changes apart from that 
>>> MSI vector hack to get it working with vfio-pci.
>>>
>>> The way I'm testing this is using IWD with DPP PKEX. Building IWD 
>>> should be relatively straight forward, very few dependencies. This 
>>> will also include iwctl which is IWD's command line utility:
>>>
>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/
>>>
>>> I have two devices, the configurator device (device A, ath11k) is 
>>> what should be able to receive the multicast action frames. The 
>>> enrollee device (device B) can use probably any hardware as sending 
>>> multicast action frames should be supported. IWD will not start a DPP 
>>> PKEX configurator without EXT_FEATURE_MULTICAST_REGISTRATIONS set but 
>>> if you enable RX logging that should be good enough to see if the 
>>> frame is making it to the ath11k driver itself. Once multicast RX is 
>>> supported we would need to add that extended feature to ath11k, or at 
>>> least the tested variant. If you want, you can hack in that feature 
>>> bit and start a configurator but if your able to get the muticast RX 
>>> working I can probably take it from there:
>>>
>>> 1. Enable RX logging on device A
>>>
>>> 2. Start IWD on device A
>>>
>>>      iwd -d
>>>
>>> 3. Connect to a network on device A
>>>
>>>      iwctl station <wlan> connect <ssid>
>>>
>>>      <enter passphrase>
>>>
>>> # Optional: start a configurator. This won't work without the ext 
>>> feature set
>>>
>>>     iwctl pkex <wlan> configure secret123
>>>
>>> 4. Start IWD on device B, do not connect.
>>>
>>>      iwd -d
>>>
>>> 5. Start DPP PKEX as an enrollee on device B:
>>>
>>>      iwctl pkex <wlan> enroll secret123
>>>
>>> On device B you should see IWD first scan to establish nearby 
>>> APs/frequencies, then begin iterating those frequencies and sending a 
>>> multicast action frame.
>> Hi James, I reproduced this issue following your guide. From the 
>> advise of firmware team, a new flag is needed. With that flag, I did 
>> see the multicast action frame in device A logging. Before I proceed, 
>> want to clarify something: that frame is only seen after device A 
>> triggers a scan (I triggered it manually using iw, not IWD itself 
>> because IWD not working on device A due to unknown errors), if no scan 
>> no frame seen. I am not sure if this behavior is expected so now 
>> checking with internal team on it.
>>
>> So there comes a question: will IWD triggers scan on device A in order 
>> to receive that frame?
> 
> That's great its possible! And thank you for looking into this.
> 
> That seems very odd that device A would need to scan in order to receive 
> a multicast frame. In all reality neither device should have to scan at 
> all, device B just does in order to know what frequencies to start 
> sending the multicast frames on. Even this isn't entirely needed if the 
> frequency was known ahead of time. I think something is not right if a 
> scan must be issued in order to receive these frames. This wasn't 
> required by ath10k when I added it, nor is it by mac80211_hwsim; you can 
But you are using monitor mode, not station mode, on ath10k, right?

> just start listening and receive the frames.
> 
> Thanks,
> 
> James
> 
>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>>
>>>>>
>>>>> And help is much appreciated, and I'm happy to put in the work its 
>>>>> just a steep learning curve coupled with the fact that any FW level 
>>>>> communication is proprietary. I really just need a nudge in the 
>>>>> right direction.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> James
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>> James
>>>>>>>>
>>>>>>>>
>>>>>>

