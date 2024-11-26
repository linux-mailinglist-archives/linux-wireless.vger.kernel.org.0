Return-Path: <linux-wireless+bounces-15704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0E9D9087
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 03:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB46168994
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 02:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81063B7A8;
	Tue, 26 Nov 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EvybvIiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10769CA6F
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589788; cv=none; b=GTN13ejVVRF0EoUUaJu6tkHS2LsM7QNBPqjd5c/FU96SwT6ilC1EqLO+DykhHxZZvQz54oXCMpkL1xK3hdCHYrwUa2rvaTt0mEXHBV2bJ15fLz+FdxUtXlMmz/zXopzUx8w27xq53Ne7+jlfVoVHJBeQGu9CQOD7BvRBGNUcLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589788; c=relaxed/simple;
	bh=v33U9cQLnnhjuO0TOvz/Tlm/aLrR3HjkfrWpLtGcyfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TBjFoHMSQorvf6dhw22DBTIPIyoSYfAWZSLAD6oCIbMuryHRRxFKzRtKjt6g3cr7eRIfnN+EqIwy2J6tSejsdVizeN++aZZEeMGWUG36t9bkNX6PYhpnC3zdy4tgTqucN3qCJrKe/ThQfwGI1j2N7FJEIlAXPL9SnjOMbwQmCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EvybvIiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APDBcfK010839;
	Tue, 26 Nov 2024 02:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dcO2JlsISWsXRPkLtPihxMn++RpFJ6H0sa+oT3aD+LM=; b=EvybvIiLBNTsbpxE
	sEme06IoGi1+JUnL4wls10IXxmYkteb4rEIceFmz5p4NUMGZJ10PAjaHaD04RzQu
	GiYZqSyjRoBVJDnF3X0w8RZB4EOT7DlrnW2EQhViGpN1JfPSBViLordr8xKjP88b
	/wj1nxYscxAxiXSXhFHnR2Vc7iIu55+2HT6A4sH1PoOaeLmE+UvAwHDmcjRZ5jbD
	rt9QX7OUJwCHyKPvu/qGjnEAOiz1aE37+lxKYd7L5jd6CAqfHDKYutUXun5sJzJz
	4Q6LInnyZO3uGXXoVLN3V+Aplz2CTP4krEBUJbmE0S5txbhZKdBDkGBreLF12Y1q
	M3BJQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw99s9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 02:56:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ2u9LB009707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 02:56:09 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 18:56:08 -0800
Message-ID: <90e546e0-80c8-4925-9711-a6091fa1a625@quicinc.com>
Date: Tue, 26 Nov 2024 10:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: James Prestwood <prestwoj@gmail.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        Kalle Valo <kvalo@kernel.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
 <87c9bf22-9534-4292-bf9f-013cc710a3bc@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87c9bf22-9534-4292-bf9f-013cc710a3bc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PqxU2PTBThIITF0dnwHrHNHZ3acy4RRJ
X-Proofpoint-ORIG-GUID: PqxU2PTBThIITF0dnwHrHNHZ3acy4RRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260024



On 11/25/2024 9:32 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 9/4/24 6:46 PM, Baochen Qiang wrote:
>>
>> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>>> Hi Baochen,
>>>>
>>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've seen this error mentioned on random forum posts, but its always associated with
>>>>>> a kernel crash/warning or some very obvious negative behavior. I've noticed this
>>>>>> occasionally and at one location very frequently during FT roaming, specifically
>>>>>> just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any
>>>>>> negative behavior apart from a 3 second delay in sending the re-association frame
>>>>>> since the kernel waits for this timeout. But we have some networks our clients run
>>>>>> on that we do not own (different vendor), and we are seeing association timeouts
>>>>>> after this error occurs and in some cases the AP is sending a deauthentication with
>>>>>> reason code 8 instead of replying with a reassociation reply and an error status,
>>>>>> which is quite odd.
>>>>>>
>>>>>> We are chasing down this with the vendor of these APs as well, but the behavior
>>>>>> always happens after we see this key removal failure/timeout on the client side. So
>>>>>> it would appear there is potentially a problem on both the client and AP. My guess
>>>>>> is _something_ about the re-association frame changes when this error is
>>>>>> encountered, but I cannot see how that would be the case. We are working to get
>>>>>> PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>>
>>>>>>   From the kernel code this error would appear innocuous, the old key is failing to
>>>>>> be removed but it gets immediately replaced by the new key. And we don't see that
>>>>>> addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/
>>>>>> mac80211/key.c#n503
>>>>>>
>>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent
>>>>>> by the AP, some with just timeouts:
>>>>>>
>>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>>
>>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>> <new BSS>
>>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>> peer <previous BSS>: -110
>>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>> hardware (-110)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>> aid=16)
>>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>>
>>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>>
>>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>> <new BSS>
>>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>> peer <previous BSS>: -110
>>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>> hardware (-110)
>>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating
>>>>>> (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>> aid=101)
>>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>>
>>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>>> Yep, using:
>>>>
>>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp
>>>> crc32 bf907c7c
>>>>
>>>> I did try in one instance the latest firmware, 309, and still saw the
>>>> same behavior but 288 is what all our devices are running.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>> Baochen, are you looking more into this? Would prefer to fix the root cause
>>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
>> I asked CST team to try to reproduce this issue such that we can get firmware dump for
>> debug further. What I got is that CST team is currently busy at other critical schedules
>> and they are planning to debug this ath10k issue after those schedules get finished.
> 
> Any movement on this front? We are still carrying that RFC patch to work around the
> associated compatibility issues with Cisco APs when this timeout occurs.
I ask the test team again, the response is that hopefully they can get bandwidth next week.

> 
> While I do agree the RFC patch isn't optimal, trying to get a firmware fix for ~6 year old
> hardware also may not be very easy. fwiw we've been running the RFC patch for about 3
> months now, as of today its running on over 4000 client devices. So IMO the patch itself
> is safe if there was any concern.
thanks for the info.

> 
> Thanks,
> 
> James
> 


