Return-Path: <linux-wireless+bounces-16022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7D9E8BAF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 07:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C6C1625EE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4B2144D5;
	Mon,  9 Dec 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fuWE68pV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C362101AA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726899; cv=none; b=jFLolEZTmqEbcXRlgAXTWBXheRgxUCB6M271DkMxBHHNyxZ1zgGQjthlH+Brslo0H8Cp00IiWmlhRrvxu5F1rmx9KTOs5D+dcihutFUFbtBj9eRVFELcBFWZzZSOv+mOMSGNtTp5oS4MvX4Jq6eff25HlsxgHPTNimJdLNy6Vo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726899; c=relaxed/simple;
	bh=n6FK+97GP59oLdXUhtfDH/kjsyUGPbo3KaM6hvGjZ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M6rDSwkDPp+CV7vmy+zY+BolQgrQYJIqcDvu9gL1zr9Jr3vzzCmlZeNSKTDC78dZ1WTG2Y7PUo6hLR5La4r7Whf7bh7I91zrMjajDPY7+k7NZyLy49zDH4JayXiZOkabQIRr9L2mRZKLcmIXCh3l31lcwxfoSDrB62bAZrPS+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fuWE68pV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MK3vd020690;
	Mon, 9 Dec 2024 06:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6sEaUpJ9zfbeMMwepHeuw8iwXcE+F0KxfjSMq/XKp30=; b=fuWE68pV6NT7wpAT
	bkJERUPJ2IY/UkyP0pOtyTqBcpbYj95KROm4hL1dYFsZyDpcrZWQsPhTC7K8btOS
	nI4NxR///ZxwkoALSGx6G8nGvXhNoKdN9hoozjOjSYXyvSvRQtPVkX5RAazqsf+f
	BKGfWIzyTfv1nMbqlOaaZsMqoz2/gDRN8+YKXRJcz7QRU1nhjXn/QBB0ANAykdUG
	6c5p35IHPt/3qYJ5oYObYY3hUmStaDVLD6etiIAx3UAzts3UZfK1U03xjDGJvPKR
	o9I427/gVYK/9Cr7IDA4mfGm23yPEZPVhn4/vTKyVtTou5h/wRgOPSA/mqKfSyob
	SlNCNQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cf4e3hyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:48:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B96mD9J027838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 06:48:13 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 22:48:12 -0800
Message-ID: <0e474fe5-cebc-487e-8884-ba505d83711a@quicinc.com>
Date: Mon, 9 Dec 2024 14:48:10 +0800
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
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
 <54f29515-047d-483d-8d9f-a0315a71ad7a@quicinc.com>
 <d5587bb4-4622-4ba2-bb4d-71a21e237021@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d5587bb4-4622-4ba2-bb4d-71a21e237021@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xEm0RPUQmOeFvzNKNT9ayXduQcBp4_th
X-Proofpoint-ORIG-GUID: xEm0RPUQmOeFvzNKNT9ayXduQcBp4_th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090052



On 12/6/2024 8:27 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 12/5/24 6:47 PM, Baochen Qiang wrote:
>>
>> On 9/5/2024 9:46 AM, Baochen Qiang wrote:
>>>
>>> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>>>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>>>> Hi Baochen,
>>>>>
>>>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I've seen this error mentioned on random forum posts, but its always associated
>>>>>>> with a kernel crash/warning or some very obvious negative behavior. I've noticed
>>>>>>> this occasionally and at one location very frequently during FT roaming,
>>>>>>> specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm
>>>>>>> not seeing any negative behavior apart from a 3 second delay in sending the re-
>>>>>>> association frame since the kernel waits for this timeout. But we have some
>>>>>>> networks our clients run on that we do not own (different vendor), and we are
>>>>>>> seeing association timeouts after this error occurs and in some cases the AP is
>>>>>>> sending a deauthentication with reason code 8 instead of replying with a
>>>>>>> reassociation reply and an error status, which is quite odd.
>>>>>>>
>>>>>>> We are chasing down this with the vendor of these APs as well, but the behavior
>>>>>>> always happens after we see this key removal failure/timeout on the client side. So
>>>>>>> it would appear there is potentially a problem on both the client and AP. My guess
>>>>>>> is _something_ about the re-association frame changes when this error is
>>>>>>> encountered, but I cannot see how that would be the case. We are working to get
>>>>>>> PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>>>
>>>>>>>   From the kernel code this error would appear innocuous, the old key is failing to
>>>>>>> be removed but it gets immediately replaced by the new key. And we don't see that
>>>>>>> addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>>>
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/
>>>>>>> mac80211/key.c#n503
>>>>>>>
>>>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent
>>>>>>> by the AP, some with just timeouts:
>>>>>>>
>>>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>>>
>>>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>>> <new BSS>
>>>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>>> peer <previous BSS>: -110
>>>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>>> hardware (-110)
>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>>> aid=16)
>>>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>>>
>>>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>>>
>>>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>>> <new BSS>
>>>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>>> peer <previous BSS>: -110
>>>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>>> hardware (-110)
>>>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating
>>>>>>> (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>>> aid=101)
>>>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>>>
>>>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>>>> Yep, using:
>>>>>
>>>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp
>>>>> crc32 bf907c7c
>>>>>
>>>>> I did try in one instance the latest firmware, 309, and still saw the
>>>>> same behavior but 288 is what all our devices are running.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>>>> Baochen, are you looking more into this? Would prefer to fix the root cause
>>>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
>>> I asked CST team to try to reproduce this issue such that we can get firmware dump for
>>> debug further. What I got is that CST team is currently busy at other critical
>>> schedules and they are planning to debug this ath10k issue after those schedules get
>>> finished.
>>>
>> Jeff, I am notified that CST team can not reproduce this issue.
> 
> Thanks for reaching out to them at least. Maybe the firmware team can provide some info
> about how long it _should_ take to remove a key and we can make the timeout reflect that?

are you implying that the failure is due to a not-long-enough wait in host driver? or you
want to know the maximum time firmware needs in removing key, and if it is less than 3s we
can reduce current timeout to WAR the issue you hit?

> 
> Thanks,
> 
> James
> 
> 


