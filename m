Return-Path: <linux-wireless+bounces-12504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44D96C5EF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB421F21C96
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA981DCB10;
	Wed,  4 Sep 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Idvd2Oye"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE882AE9F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472996; cv=none; b=G8nqvc1uAyNy8fNhdtYBpyScd97P6lgEJ4TqlnPv3TOvd7rby8vF1/d82ZuZ8Rs7l7JZAgB96sKNzOHDpZ3Ej8X74aZtyM3SMuzE9Jl/9obrZaYNKb5zZJEGXn0bx3zsBITlAk+uqd94ITrMu4U8dXHHlBt1v9sEvXNGSnVzXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472996; c=relaxed/simple;
	bh=GwoikESulHieke+ZZ3u1T9GKQEUNZaqojuv8zsIy/kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=icdB61XLhE4t+h6hamO6rxxxsVN04eyh5+2SV9v1btL6c6Jz/2NaMNRXa4n6Eno9vcQ/WMNWAGvdsePJuofW/q5ljzl5zFWiTvuWNKVi6UkUE0YgGnaJkryseoQ9Qt7myEf0dU/G88Sq8fz22u5g24cex0RBj+C7n0bpYGbkabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Idvd2Oye; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484A8DXH032324;
	Wed, 4 Sep 2024 18:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C+mCS5lP2ka/cVdgoQuM49qHg/bVva8yppVEpMU9C64=; b=Idvd2OyegE9AIgHS
	RL9MGsFCMiKzVDzphu1j/aNUC1uYoHKkeTXnwSrpsPx8G2S8diPqlIeqODJBJ/00
	hBXnWSSLAvArySmRCYreb/nTn0yNI2d/wLno2VDQI9qchwq2omAU3kVOebWMviuC
	huybo/6Hpdpso+i+DFwcGytMqyaQNBNQkQUkDyAM1BASbF9GKwkXNVaatISwNlnM
	xJqwx8vdpYs4i4w3OHnWSem4BlOQMih/3cExeZwZ+Hm5YrVgpMWnXdf1p6nASMUW
	lLteyuSMtXwLLlTCxYiZd8MGhyYxpdCCGn3Og5oCzUkJWGcWZxjCGwrV5jkuPxFF
	E3AvRA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe5x00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 18:03:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484I39Zv023736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 18:03:09 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 11:03:08 -0700
Message-ID: <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
Date: Wed, 4 Sep 2024 11:03:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: James Prestwood <prestwoj@gmail.com>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nJvYYzMD0tTqY_RH4fatu06C_eJ7caP8
X-Proofpoint-ORIG-GUID: nJvYYzMD0tTqY_RH4fatu06C_eJ7caP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040135

On 8/16/2024 5:04 AM, James Prestwood wrote:
> Hi Baochen,
> 
> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>
>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>> Hi,
>>>
>>> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
>>>
>>> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>
>>>  From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
>>>
>>> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
>>>
>>> --- No deauth frame sent, just association timeouts after the error ---
>>>
>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>
>>> --- Deauth frame sent amidst the association timeouts ---
>>>
>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>
>> Hi James, this is QCA6174, right? could you also share firmware version?
> 
> Yep, using:
> 
> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp 
> crc32 bf907c7c
> 
> I did try in one instance the latest firmware, 309, and still saw the 
> same behavior but 288 is what all our devices are running.
> 
> Thanks,
> 
> James

Baochen, are you looking more into this? Would prefer to fix the root cause
rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"

