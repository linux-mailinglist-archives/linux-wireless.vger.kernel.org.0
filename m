Return-Path: <linux-wireless+bounces-3861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D491085DA0A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 14:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026CB1C22097
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73179953;
	Wed, 21 Feb 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="co7LpC06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FC7BB03
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521886; cv=none; b=RHJORu0lep+VK9Hr6dMJWFaD2oI19rJctJDO62aeYYaxW+/66kBKlPZEioknUi5TqdCpjHzxUxx8C2KQyD4C3VvZ6kZN2k8wGVP3m1pw+wFfv6pvUaqiT9DC425kYLwFM4/1eeWruoPoavIJUC7QQYVl2cy/8+l0KjzhWYT5JuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521886; c=relaxed/simple;
	bh=X/2bOJ0j4/gjsnIn6/xZ+SAkfdbGfyu5qHhxvQ8JonE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kenYvz+kThFoDSEE9dwT5T0RAgqu+gd4BJDj52fqkas1UWXpMvONMKuTjWM8pRQ1TSdmE0NeThG1nOdSnpMXLaJLGahGCBu26wavfkysuzcKuAosm66v4FP74wh7tt5m1meDlkj/gsoqY2G9dszRucUkPOAaLrMPYKj1u+txgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=co7LpC06; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L88ZSG005380;
	Wed, 21 Feb 2024 13:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P/qK5TqAjPViEt37XC0w6INh2ahRNozGnu7xeaXNpK0=; b=co
	7LpC065U8ZGLx/p+J1+OkLj+2A7DJxYOUgQMa50aqtySnYvJrYr1oiAC6/UaqC3P
	8VjhqqTIPoTJe0Jrt105c1UKG9A4sYaeMvtRhbcw/YrWB/D+kAaqR/M3Fu2sSpUf
	Ob+bKhkvGbO/VyvrMZUuk6Lirg1HnsSx/com2ATBAasI/gKZT1jiZ66aycW13BXw
	2U95uL5HiDRnYsXrT9BKefSpaqRZnlDfttYDMhMwoRgkRd2Tc+4fA5D5CUEgf1MR
	iejsNM2vX+UmHM8J1eOSJ4hFNZv4g4IMuk0dslMuCfCuwoA/0VSIBZY2TB29oUjU
	vtLdf3CFN81ty83EHj1A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdddg0pcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 13:22:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LDMUeb013929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 13:22:30 GMT
Received: from [10.216.12.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 05:22:26 -0800
Message-ID: <48a16061-d62b-4456-8545-36e3f040e317@quicinc.com>
Date: Wed, 21 Feb 2024 18:52:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
 <5a89e63fb7644d12be72154c90c96199@realtek.com>
 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
 <beee9cc5-6174-473b-bd57-1101430f200b@quicinc.com>
 <31b97f3c18129edd835ca4d968cd59947efab950.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <31b97f3c18129edd835ca4d968cd59947efab950.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w_ItDBQDYg-zFGiebFRjAMXihnsQp8pv
X-Proofpoint-ORIG-GUID: w_ItDBQDYg-zFGiebFRjAMXihnsQp8pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210104

On 2/21/24 18:38, Johannes Berg wrote:
> Hi,
> 
> On Wed, 2024-02-21 at 18:22 +0530, Aditya Kumar Singh wrote:
>> On 2/21/24 13:39, Johannes Berg wrote:
>>> Qualcomm:
>>>    - copies and updates CSA/ECSA elements all by itself
>>>    - btw, not sure here about probe responses, does it do that too?
>>
>> We had a thought about keeping this CSA/ECSA handling at host/kernel
>> level only. But the major point of concern is _synchronization_ among
>> firmware of each of the links participating in the MLD.
> 
> Sure.
> 
>> * Even if we ignore TSF/TBTT synchronization for a moment, how firmware
>> will know when to transmit the beacon with a particular counter or when
>> CSA has finished on other link? If rely on host's update then there is
>> room for further delay and hence errors.
>>        - This is because, counter value on the reported link depends on
>> the last beacon transmitted by the affected link.
> 
> Sure.
> 
> I don't think anyone suggested that the host will put the exact counter
> value there, just to have the template.
> 
>> * Host can send the template on all links
> 
> Right.
> 
>> but how to ensure that first
>> template is reached on the affected link and then only on the partner
>> links? Host will queue the command properly but reaping of the command
>> on n (no of links) independent firmware can not be guaranteed in the
>> same order in which host has filled. It depends how busy each of host to
>> firmware path is.
> 
> True, and there's a potential for race conditions there I suppose, but I
> suppose in the Intel, Realtek and hwsim case at least we wouldn't have
> *different* firmwares running multiple links, but a single one.

oh okay, makes sense.

> 
> In any case, you could solve this even with multiple, by applying the
> new template only after you have the CSA'ing link's new beacon template,
> if it requires filling in CSA counters, or such.
> 
>> * And then obviously, considering TSF/TBTT will be again complicating
>> the synchronization part and making it more difficult to manage just via
>> host.
> 
> Again, not suggesting that it is managed completely by the host, just
> the templates.
> 
>> Hence there is a strong urge to let firmware handle all this for beacons.
> 
> Sure, that's fine, your call :)
> 
>> As far as how firmware will _magically_ communicate among themselves is
>> concerned, we have *IPC* in place to achieve that. One link firmware can
>> talk to other link firmware when required.
> 
> :-)
> 
> It probably doesn't actually help you make it race-free though, so does
> it really matter? But again, it's your call how you want to do it, and
> we'll just have to handle it in software appropriately. While I'd prefer
> to have _one_ way of doing things, at least so far we've basically seen
> one way of having the host involved and ath12k not having the host
> involved, so it's all still really simple.

Yes!

> 
>> 				Kernel Level
>> ____________________________________________________________________________
>>    -------------- 	      -------------- 		 --------------
>>>    Firmware 1 |  <- IPC ->  |   Firmware 2 | <- IPC -> |   Firmware 3 |
>>>     on HW 1   |	     |    on HW 2   |           |    on HW 3   |
>>    -------------- 	      --------------             --------------
>>
>>
>> Hence, host just needs to update template of the affected link and
>> indicate to firmware that it is a critical update. This firmware then
>> can indicate other link firmware(s) to append CSA/ECSA IE with a given
>> counter value to its beacon via this IPC.
> 
> Sure. You still have a race, because if you send a message over IPC
> saying that the CSA needs to be included and it's just before the TBTT,
> chances are the TBTT event will still happen without that. So in a sense
> it's similar to the host updating the partner link's beacon template
> "too late". You can have a situation where the CSA link's template is
> updated just before _its_ TBTT, and the partner link's TBTT is just a
> little bit later, but the update is delayed ...
> 
> You could probably solve that by making your IPC synchronous but then
> you risk your TBTT timings in cases like this.
> 
> Arguably, I'm not sure it matters. I'm thinking we'll enforce that the
> CSA must be in progress when updating the partner links beacon/probe
> response templates referring to it (*), but ... ultimately,  I think we
> can accept that the partner link updates the CSA one beacon later if
> their TBTTs are very close.
> 
> 
> (*) and now that I think about it, that might have to immediately come
> with a separate template to use _after_ the switch, like CSA does for
> the CSA link

True. So each link will have to send two templates. beacon_csa and 
beacon_after

> 
>>   Parsing the IE and
>> de-fragmenting and fragmenting it again can be done by firmware itself.
>> (Agree that it is bit complex but when comparing with complexity of
>> maintaining synchronicity across links, this looks more doable)
> 
> That sync maintenance is because of your hardware design though, others
> don't necessarily have that because multiple links are handled by the
> same NIC, not separate ones.
> 
>> Hence we have taken "offloading beacons fully to firmware" approach.
> 
> Sure, fair enough.
> 
>> For probe responses, it is handled in host/kernel only. Firmware sends
>> back the last transmitted count in beacon to host. So we have the last
>> transmitted count info. Per STA profile generation logic is also there.
>> So we manage via that.
> 
> So I think like in Realtek's case I'd probably advocate doing that in
> the driver with the offsets given by hostapd/software stack, although
> that requires having *two* feature flags, one for beacons and one for
> probe responses ... since you lack the "magic" for probe responses.
> 
:) I guess yeah. So this approach we discussed is fine right?

Have some _feature flag_ to indicate whether host would like templates 
(with offsets) for reporting links or not. If it does then hostapd can 
send those, otherwise it won't. Hosts can further handle as per their need.

