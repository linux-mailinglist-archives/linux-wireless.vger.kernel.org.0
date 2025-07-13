Return-Path: <linux-wireless+bounces-25341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74645B032AE
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A132189531F
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDFC280A3B;
	Sun, 13 Jul 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NuMvbprJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732651C5A
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752433157; cv=none; b=idopJjJgRgagN4ceg0opLkGjoMihmta4+E9pDbYiwrRV+ySS0pCBNFM4MwUnvshH1diDJ7joYAq9N4NaDkKVKKA+mo2U+z5Xkr6jIn8RwaJnTr3z3IUs/goiB6t5ugs9EOTmH88GP/8BjIUIC4g7iW64euOePzEre8Y3SVjqHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752433157; c=relaxed/simple;
	bh=iPIl4OoSWVWBC1QnIoDkEU5st6FYMe9HpX04zR+ptt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ao8NZSYSDKnYcpS6vyFV3CRfPIzxPY28QSgl/TA5+xtww8yCmB8IOyLVbB8LGs8DP93k5c2smYu+/g0q7ScUnhx5Vj+K+PssmasQfQdOmROUUCPwdxil62ZWT6+PaSYgZuN/XQbF8+D5Elx63LG/mMofZT7d2/G28COpMcgcMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NuMvbprJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56D5R5mA012290
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 18:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyZvakpdmc+ctfdhCgjkf+kMrxFZE2wvdi85totUeJM=; b=NuMvbprJFlyz7x3C
	JH5Wlk+4c3AQ3GX2iGHS1McjYXcui4G9etHw5xxbmo0XkZeL7V+tLQXp5tFCpTcG
	MBAIS/oOUcpKDtch59KTAdBRKn76mraiQdev6x/r9ajI4qb+M/jTyP2VGZL4ry+P
	gYEP2Me5K6NbshL/ApqHn1PMh3XVFCDdBwwJX6KiqiBzc0BWLcsvl5U09qIH2xaK
	OAlE5X3HcpkKzdy9cN7ki/Tk8V3gaCHSO8krt8L4mpuvGshQ9BagfHLJYnHVS2ao
	tCaFoaOVmEed3eCZU6NOU3SXlkNTypuc/9zLGbHiNd7kgh4xg6fi7hM+k7PefbCr
	eOZgMw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut2eap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 18:59:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234fedd3e51so33835895ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752433151; x=1753037951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyZvakpdmc+ctfdhCgjkf+kMrxFZE2wvdi85totUeJM=;
        b=BrD0yGAi94alzezlqRFkziaTFQ6y6LavYtxfu22PgqcwOP/AAMXtsStHNNBXMpWTT0
         0tBYGY0ToJpbC1iqMcxh5m/V+L/2kSmp+E9H/a192Q7Scv89gRVuPDm9eUAcgwLX/L4+
         ODtBV04N1BjE4gCGkITMjgMnK7Ew7xPzSJYyrg7Q5fBZjTVhwyqCilLwHQlY2Sjz7Q2W
         GpF1yhNzusFoIpieKV0f/2bCSRI8vBMliA7D9kc2SLE4BHXFcW3/owbKIK4J5wM/59eM
         VY5X0Wgffd7kXsoKcXF44jV+JnD4Dr2mxzG48g2g7szUCx8CQ3mqEu7iPoCO892aofN8
         0qnQ==
X-Gm-Message-State: AOJu0YzEjLlexnhKkRZHxzaVGJQPRbTHQgyAOpXmPEdP0ANJsTbCq47d
	o7s+tH1aDSFdyVIJqUJF9r445Xye7ATK3u5WwkHyzcaHZWYNzoq/KOCzA0ytmi313hOSUNR2yim
	V9YziQXWepV4Fp5HyiS8guwS+thpqFqNTGG4/+gTBmYJTArQca6rw77mkK+wKMeoGsdxU6g==
X-Gm-Gg: ASbGncvYzRONV4ncXvEkAspwrJEhXRmFQhZdf+Zyv4OkUqg4cSPNmYBl891ot688Lez
	gDVrxKHA/TNEO9sgchMCFCQQYU7rwtD5043G2gZOeqeiWchnvhBghccImSO92nhvFHhm0GkvUmQ
	D797HiB0C11banL0+9zjEHZ7qeAr05FJuCzcscS8WgBsRilEFnrM2ARXc8Z8hi+MNmiVpOqDhPu
	jl0ONqxtYeY+MkCcUptgSxj74a/mP0LFZ624GkvYK8zT1rTG/FI1DIiRsqyF75BKfbsZQT/CCO7
	SVp5WHKwSQJ3EudqB268p+b/h+OXoGtqZcHh8uso53nOzrtFYlfIPIbh9B8nHFgZVvJ13QZ+
X-Received: by 2002:a17:902:cece:b0:236:9726:7261 with SMTP id d9443c01a7336-23dee0c6ed8mr164466495ad.39.1752433151473;
        Sun, 13 Jul 2025 11:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuaNgVKheQk3b8imU87osEwh6357NjhpUB01ZTuui3OhavmkVNst3Pv+44GC5dKU3LNhXnLg==
X-Received: by 2002:a17:902:cece:b0:236:9726:7261 with SMTP id d9443c01a7336-23dee0c6ed8mr164466245ad.39.1752433151007;
        Sun, 13 Jul 2025 11:59:11 -0700 (PDT)
Received: from [192.168.1.2] ([122.164.84.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359b6fsm78444725ad.212.2025.07.13.11.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 11:59:10 -0700 (PDT)
Message-ID: <94354e7b-1931-da3a-bec6-78e578468dd2@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 00:29:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH wireless-next 0/3] wifi: Preamble puncturing support for
 mesh
To: Johannes Berg <johannes@sipsolutions.net>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
 <a8ff80ff5a811a09cf5556e20c7232eb1e201c2b.camel@sipsolutions.net>
 <21b7d547-b550-23a9-3bff-1f1787e307a8@oss.qualcomm.com>
 <61d6cdebee2c89e5d2d93d3297c94051efb70790.camel@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <61d6cdebee2c89e5d2d93d3297c94051efb70790.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68740200 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6VSqIenKxx6KD5xKWEYkZg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QZ1lA0b2CmYMIHELQRAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: p0p51JrY_A66Y1VSFAHdD1XIIwhphWsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEzMiBTYWx0ZWRfX/Ch363JbE7kV
 4u0rYl/z848p79jKidJHF3SmTWiWGKxQJj84qytRfUTxpGkPvBW+dKTYKpGJI49GvLjnaEDvRsK
 ECgJlMQcSh/7A998WuorQWQSWrrNRT2lAxgvfL94007bRNQyqJqvjFTJajjtaQJb2R5AxmNDOz0
 EuguIELF08tsYjMptfTkGgjvlhsqn1PCm+smWQGLUnPuYsmg1iXkc0WNEYIDMDJwVhRJGQdfDGt
 jVGlKJhIp/+ahyf1RqonuxkbqHVjo8sz1kajBUQtgbx0tWd9dqdA2CiQmc8IpTN8rXGgmDOyC8y
 B7IqspZi8sRLuFWS6jb7o3DwhMs4BKGsy3yWo80C0mZjyc52a5q9ZPaPXXBoPke6xHPjB5HNJVp
 jMcchUOGRdruITDlVEUmckVXNMqXRRqiWfbRwRA1+0ejDhrnmwuGiWNnQDe8LfVCrb7DkATO
X-Proofpoint-ORIG-GUID: p0p51JrY_A66Y1VSFAHdD1XIIwhphWsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507130132



On 6/30/2025 6:51 PM, Johannes Berg wrote:
> On Fri, 2025-06-27 at 19:49 +0530, Ramasamy Kaliappan wrote:
>>> I ... don't really understand how this is supposed to work.
>>>
>>> Say, for the sake of simplicity, we have an 80 MHz channel, the lowest
>>> channel is the control channel (so puncturing 0x1 is invalid). Possible
>>> puncturing values are 0x2, 0x4 and 0x8.
>>>
>>> If locally we have 0x2, that means (I assume, since that's how chandef
>>> is meant to work) CCA and RX is always on the control channel and upper
>>> 40 MHz parts. If you're now going to transmit to a station that has
>>> puncturing 0x8, you didn't do CCA on the 0x2 subchannel, but ...
>>> transmit anyway?
>>>
>> Yes,we do not transmit blindly to mesh peers with different puncturing.
>> Before initiating transmission, the driver computes the intersection of
>> the local and peer puncturing bitmaps to determine the set of valid sub
>> channels.
> 
> Hm, I guess that's fair, but why not do that in mac80211 instead, that'd
> be simpler and far more obvious/safe?
> 

Hmm, I originally thought the bandwidth determination would need to 
happen within the driver,  since it’s required at the time of packet 
transmission for each mesh STA. The assumption was partly influenced by 
our existing firmware design.

But yeah, since the bandwidth doesn’t really change much across PPDUs 
for the same STA, it actually makes more sense to handle it in mac80211 
and drivers can use it.

> Also, clearly your driver _doesn't_ do what you say "the driver" does,
> if anything it magically and "undocumentedly" happens in firmware.
> 

Yes that's right, the intersection and BW selection is done for every 
PPDU at Firmware.

>>> I mean, maybe this could work if the remote puncturing is a superset of
>>> the local puncturing? But just blindly doing it the way it appears to be
>>> done in this patchset seems ... questionable at best?
>>>
>>> Can you explain more how this is even supposed to work?
>>>
>> When associating with a mesh peer, the mesh peer's puncture pattern is
>> shared with the driver. The driver evaluates the intersection of this
>> bitmap with local pattern.
> 
> Could also be done in mac80211, I guess.
> 

Thats right

>> if the resulting pattern corresponds to valid transmission bandwidth,
>> the valid subchannels used for transmission.
>>
>> If the resulting pattern does not support a valid bandwidth, the driver
>> falls back to using only the primary 20 MHz control channel for
>> transmission.
> 
> Right.
> 
> I also note that there's not even any definition where the puncturing
> pattern is rooted ... is it relative to the local chandef? Relative to
> the peer's chandef? Clearly not even that is documented.


When not considering CSA scenario then the puncturing pattern is an 
intersection of the local channel def and puncturing pattern advertised 
by peer.

If the local and peer mesh are capable of EHT, the negotiated EHT 
bandwidth of the peer mesh is considered first. The intersection of 
puncturing patterns is then applied on top of this to derive 
bandwidth—potentially reduced and with or without additional puncturing.

> What happens if
> the bitmap changes? Why does userspace track it rather than mac80211,

When a channel switch is triggered by a userspace application,
the user space is fully aware of the bitmap changes and pass them to the 
mac80211 driver.
But when a peer mesh initiates a channel switch via CSA, the mac80211 
driver on the local mesh receives bitmap changes through CSA 
beacon/action frames and processes the channel changes internally.

However, unless the new bitmap is explicitly forwarded to userspace, the 
userspace component might not be aware of the bitmap changes.

> which has the beacon of the peer and handles CSA, so what happens with
> puncturing in CSA?
> 

I am thinking something like below for CSA with puncturing in Mesh,
1. Acquire the puncturing bitmap from the peer initiating the CSA action 
/ beacon frame.
2. Validate the new channel's compatibility with the new puncturing 
pattern, and apply the new channel context.
3. Forward the csa beacon/CSA action.
4. Reset the existing bitmap and apply the new bitmap to associated STAs.

I didn't take care of this in the patch series. I am planning to address 
this in the upcoming series

> Did you think about any of these questions, or are you just using me as
> a design tool? ;-)
> 

No, certainly not Johannes! 😊
I initially assumed the bandwidth would need to be decided by the driver 
  since it’s tied to packet transmission for each mesh STA— that’s kind of
how the firmware seemed to be built.

> johannes

