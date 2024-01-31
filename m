Return-Path: <linux-wireless+bounces-2858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7C843318
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D24B25130
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DD4C9B;
	Wed, 31 Jan 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TF59mXLP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA04C98
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666511; cv=none; b=D0tH1yARqlI2emrusF07FZQNP8MGzbLP55PKZCgS2JGH871uXk3udOPQgPpEFTMIZ/rRj1sikApK0ueO/BsonQAFU6hAqXeoowwc3rZWGC9BkEGT//9Q7z4lwn/znkgi5McLVdWbCEa7CGW+zlhr2KcFCSwIMaYs/a10gEVb6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666511; c=relaxed/simple;
	bh=bVW6lzunZ2jJx81/ImQBi0Xwnl4k7RS7zRdXcZZsHJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V+KNn3d3/tcQfZR1XrunOtLRDoT8+53aUk5tzUB+x8PwqhS0xPkZe3bGMyPhK6MmK73ExA1+r59WaqGCG9ioyKZW5BH8qFEhi61USbxz0IAh8sHttBcA+lOaSONwER3boel9qgDWbiGZJdoOXxHqiCP6zjWiCmXgxW3f3sNTAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TF59mXLP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V0GEGE027971;
	Wed, 31 Jan 2024 02:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qF+f0yshJR8OgFlSQedsqYf6Yd5XbhAAHOGR2TIpWt0=; b=TF
	59mXLPKuktH5OgBnX+EQ64tOnV5XVhHq7vFv5a9ubHqaAl8w5X768Hlq1DYqUCin
	eSQpudAVmvn+DMDt+j66TpZZ9f5T8sSLK0fVwwd48pn7KmiuqEyOoRyzlS4l3HzP
	ucaDpbbZVWQ/KrrALXvwQ7LIvwIxREkyk6IFrIbXba3+VvEtrAcrRk+CVBd1RCZi
	NK2rXOiHkMOj+iqk751BuOU1MhDbQlLQtj0CxIbc8jHV7Wl5AhywXvQzModd+Deu
	Ux2gOhFz1Vnu9SvvhzfZdHyiXRLHrDsREQ47lWcOH0yE327o2ivhfxHSJE0TfkNy
	3MyvHbEHZMfyfy6hOdFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxtp32kgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:01:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V21hPg016669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:01:43 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 18:01:42 -0800
Message-ID: <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
Date: Wed, 31 Jan 2024 10:01:40 +0800
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TeBJLYeySVUdj1h-f2j50wODxp2z1FAb
X-Proofpoint-GUID: TeBJLYeySVUdj1h-f2j50wODxp2z1FAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310014



On 1/30/2024 8:47 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 1/29/24 11:00 PM, Baochen Qiang wrote:
>>
>>
>> On 1/27/2024 3:18 AM, James Prestwood wrote:
>>> On 1/24/24 5:06 AM, James Prestwood wrote:
>>>
>>>> Hi,
>>>>
>>>> I recently added support to ath10k, for the QCA6174, to receive 
>>>> multicast action frames in order to support DPP. I'm trying to do 
>>>> this for the ath11k QCNFA765/WCN6855. I took the same approach as 
>>>> ath10k which was actually quite simple but I'm unable to see any 
>>>> multicast frames coming over even when I enable RX/DATA debugging.
>>>>
>>>> What I've done so far is:
>>>>
>>>>  - Add FIF_MCAST_ACTION to the supported filters list
>>>>
>>>>  - Created/started a monitor vdev from within 
>>>> ath11k_mac_op_configure_filter()
>>>>
>>>>     ath11k_mac_monitor_vdev_create(ar);
>>>>
>>>>     ath11k_mac_monitor_start(ar);
>>>>
>>>> - Also tried adding
>>>>
>>>>     ath11k_mac_config_mon_status_default(ar, true);
>>>>
>>>> I can successfully create/start the monitor vdev. I see now as I'm 
>>>> writing this email that my specific hardware does not support 
>>>> monitor mode outright... Is this a dead end or is there hope with 
>>>> purely driver changes? or is it some filtering at the firmware level 
>>>> preventing this?
>>>
>>> I was able to finally see my broadcast frame after some additional 
>>> testing. It seems the driver/firmware/something gets a bit hung up 
>>> when I attempt to put it in monitor mode. It will start printing 
>>> these messages for about a minute:
>>>
>>> [   51.093034] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a2 != status ppdu_id a1a1 dest_mon_not_reaped = 650 dest_mon_stuck 
>>> = 12
>>> [   51.094461] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a3 != status ppdu_id a1a2 dest_mon_not_reaped = 651 dest_mon_stuck 
>>> = 12
>>> [   51.096281] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a5 != status ppdu_id a1a3 dest_mon_not_reaped = 652 dest_mon_stuck 
>>> = 12
>>>
>>> In most cases these ppdu ID's are a one-off from the expected ID 
>>> which seemed weird to me. But if I let it sit long enough I all of a 
>>> sudden get a ton of "data rx" messages, which is what I would expect 
>>> if I enabled a monitor vdev. Once this flurry starts I see the action 
>>> frame from my other client, sometimes at least. The firmware 
>>> generally crashes after a while so I've still got a ways to go but it 
>>> seems within the realm of possibility that this device could receive 
>>> broadcast action frames?
>>>
>>> Hoping for some breadcrumbs to follow here...
>>>
>> Hi James, as you already mentioned, ath11k/WCN6855 doesn't support 
>> monitor mode yet. I don't know why you are testing multicast action 
>> frame with monitor mode. So if monitor mode is not a must, could you 
>> test this with STATION mode? We would look into this if any issue found.
> 
> As you may have guessed I don't _really_ know what I'm doing. When I got 
> this working with ath10k I saw monitor device was being used in order to 
> receive probes, and did the same for multicast action frames and it 
> "just worked". The frames themselves were still being received on the 
> station device. I attempted to mimic the changes with ath11k.
> 
> The end goal here is just that, be able to receive multicast action 
> frames on the station device which currently does not work. I'm only 
> seeing unicast frames when i enable RX debugging. The driver support for 
> multicast action RX in the kernel for this is basically zero. An 
> extended feature flag was added by Jouni when he added support to ath9k, 
> I added limited ath10k support for a variant I tested, and I'd like to 
> do the same for ath11k as we are transitioning to the WCN6855.
OK, so you are testing this with latest ath.git, without any private 
changes, and it doesn't work, right? Could you share your test steps? 
Basically how are you sending multicast action frames from AP/peer, and 
how to check if that frame received or not (I am assuming by checking RX 
logs)?

> 
> And help is much appreciated, and I'm happy to put in the work its just 
> a steep learning curve coupled with the fact that any FW level 
> communication is proprietary. I really just need a nudge in the right 
> direction.
> 
> Thanks,
> 
> James
> 
>>
>>> Thanks,
>>>
>>> James
>>>
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>
>>

