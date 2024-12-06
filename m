Return-Path: <linux-wireless+bounces-15945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F99E6464
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 03:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCB4284824
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE57BE46;
	Fri,  6 Dec 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZS6WtJd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE74C9A
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453242; cv=none; b=apJ+pv6ieGJnewFpTclWC3hgsEUHt2GGtNHLl+WIkrnS4Amgn2l9EHvRFIvGib8PIlPae91v/2BNME8K6BemISSxWse6ZXy+L2j00gnNZlFx7y4nsmheWkptgoIuUtXxmN3xsGHl34GG58XpYYBZJZWUYUUv8gsOOsFjOGRM6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453242; c=relaxed/simple;
	bh=MwZdEiFUZi3EAI9pAgRq4nR9xq5QCxW4kGA+FZoJ39E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ahw9n0j93x2b+2n/qvffH72azAVOJagBD4NU3WyS/PAXR9YSuw1wRUHA9FJ43hMJ64RH8ToInfh06NHIEFycNQlCJDoMkuQqsNb/0ZPQ0isk2RRE0p8T/CziEhfo9TVh5101f3GcmVvjdcdkR/ABVktLiINNMNd1ABbQG86gL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZS6WtJd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B62Rn3C003213;
	Fri, 6 Dec 2024 02:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fYv3A1qYsT2jKhETXXlZZrq4V3QAFPZS+/1ugwDLFQ4=; b=HZS6WtJdivIBX5uX
	8on8OZijR2gfoK7/XQclOIuQSoLnhKyuYmZUqcjoOLj2q1XdAkt32Lk4MV7ulrwV
	s85qiGm8Qm3FRDSysHb2qXIWwGXY23YSHUZu501NUjWWsE8G0/8vfO4JFYy8AfZF
	YtCEjRlAS7vAju7ILV2NR03g59MFLI3H5CyVC40MY+9IU4GUT1YKNom2vY0hzC7v
	1tXce4dj0cz7tOyd/bIV4lMB4ZyrFqrBJtAfV1V4GJLzC7SU0N6t6wIg3I6VM+zf
	dR4G2WZ5Fwbdu3t2QeauP8Lw7maPFHANJJd6hSPPcYUi3jfZ27/wWSoX8VfTns6K
	0YRJGQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43brgp01by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 02:47:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B62lE6r019493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 02:47:14 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 18:47:13 -0800
Message-ID: <54f29515-047d-483d-8d9f-a0315a71ad7a@quicinc.com>
Date: Fri, 6 Dec 2024 10:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        James Prestwood
	<prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
Content-Language: en-US
In-Reply-To: <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _nNfjY-u6OuLEQEGLOoI4Po8ZShXWiOQ
X-Proofpoint-ORIG-GUID: _nNfjY-u6OuLEQEGLOoI4Po8ZShXWiOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060018



On 9/5/2024 9:46 AM, Baochen Qiang wrote:
> 
> 
> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>
>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>> Hi,
>>>>>
>>>>> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
>>>>>
>>>>> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>
>>>>>  From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
>>>>>
>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
>>>>>
>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>
>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>
>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>
>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>
>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>>
>>> Yep, using:
>>>
>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp 
>>> crc32 bf907c7c
>>>
>>> I did try in one instance the latest firmware, 309, and still saw the 
>>> same behavior but 288 is what all our devices are running.
>>>
>>> Thanks,
>>>
>>> James
>>
>> Baochen, are you looking more into this? Would prefer to fix the root cause
>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
> I asked CST team to try to reproduce this issue such that we can get firmware dump for debug further. What I got is that CST team is currently busy at other critical schedules and they are planning to debug this ath10k issue after those schedules get finished.
> 

Jeff, I am notified that CST team can not reproduce this issue.



