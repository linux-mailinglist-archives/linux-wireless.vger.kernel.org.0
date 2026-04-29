Return-Path: <linux-wireless+bounces-35572-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKmUJjay8WmwjgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35572-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:24:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CFA4906B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB63C300B536
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043031F9A2;
	Wed, 29 Apr 2026 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpBYu/gq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CuDIKx2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186F3A3836
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447467; cv=none; b=tcjP+DwAjJbTE9ySPAL99HBvf8il72MARCUGti+5akPhpipcTjr07clCP17pkAZ23qr+CGBTi88nr95aALL9QqshRJ5oGecGQ3q6FdonQ0Jlan4NrA4naIB2OFx4dncZ3iLdiaeIvJYp+FZkLBkLnR6Ma91vYg0s7PRP5yVRp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447467; c=relaxed/simple;
	bh=NpM53rfoiM/WLHwUMqqVM2+P8uuB5qTcQIN6lCxAIkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X6j5/AePgJ7gVvVcRTCTbA/DIb+7fSQ1OTWxf6tcvwEwf7miPxPTlFMtjZUcw5Wn73xGbS3Lh7dgSBivvRfwUC8IiH4Vl4x5pk7c9ncqA8l9XYWppEvWNMrCPzRbsahz9AG/tQWfrwsa0JkyK76DUnwi22jEh4gY5qXSEn8Gme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpBYu/gq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CuDIKx2C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5NFlM3348637
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zj0xBV81UoPAshj4m0JS+H1oV0zb80F5GqRHUDXF/go=; b=RpBYu/gqoKVDoN0l
	s7jD7xhpYjIWfKnuaBMF8swxL3uOszmXUUZQ3qQV+YJMWiFgIxW/e3YeG+DUpsHe
	GXc24eI15OzPtxWoPZdWE/+2jj27Yjc4K3OTVGc8G0rxJnb3OIZEe3cEW+tfUWbc
	YCiTi51Z5zVN237Suc6LkwfqyXDZ8ecMhBGaL5Ou5xX5m4aHIIePtMv8NIN5zXrz
	Mh/sDkMuKR35T7pEONtHibn7jsz9puwjM+TEfoERqiIk4ffPLIdcAtcv7Wmwi924
	1r+nqSDBSdyVFNwUc205I9fNW65KdT/5uIN5Dg1wkU9zpkaKwTG08LSl2W/F/b+B
	THN1Cw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4t5ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:24:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b7aba0af02so60547565ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777447463; x=1778052263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zj0xBV81UoPAshj4m0JS+H1oV0zb80F5GqRHUDXF/go=;
        b=CuDIKx2CcPG2yMy7fPWrORrLlfCvaZrYjzywcPIimggBOduFIbBtmlnbVtYJaQOria
         R3S6OM12J61Z/rMWI20lcL7VjgJga8zEB3tjKkN+K44AfjZqzOejBwXfdAr3CGtosmjW
         5fYZsvHcRzUVuzq1HHy7ryPOzrfUi3Hgvt4vNS1seqGGhbncCFmzwesdSJzkHA1JWELQ
         saukCUo19NWHXrDDVB3HUhk0N3NIS4Z4YTVJhZgTGXNDtqGzy8czsL6CSG9ORIJNdtZU
         quwk4awZVzThD21gCJKZoSV+p8Vh0LzFfBJY7QVFnoUcREAKdPcvPsJWLRNJIT3IH9JN
         Y9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777447463; x=1778052263;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj0xBV81UoPAshj4m0JS+H1oV0zb80F5GqRHUDXF/go=;
        b=A0j+1mabTHFDCOYyErzKj9CaNNpX+PyvCrPxHdDn2XpMqOLre2MztYQdMmGjFHKF41
         WVOgsRfjNvJsCUt5wU9SqVDSQNcOn++v6zeuVrIF+Y2UNsFPlwqExQhO9OAsyqJjtWAB
         l5wqJawgaNaI7oshi9vzmoU1ZNEDks72g5wAp/zMPJZt9lK9tMzPc8lBe8T8Pf6Hbhbm
         ocXN+U7mV3DtnJ4JdhlwFfvmP+RET+bS9C89F8GGTmkTx/Xir63csbNiNFL10nFsNTgD
         a0lL4MIkI/6PIjh7nSILdcthrNHDW+g+cwIADpAFDaMvlYf92immdlUOQm7sI8K4UNrG
         r0Yg==
X-Gm-Message-State: AOJu0YzMXsJLuDVf+vgAqjH9mYmyOKC+KFZ6DEBzh7VYjAVppp3tPxsg
	iEMi1fSMj1bBele94AbLGpkaXAET/XubAeCILY+FpwRK4gKwbRzN5PwZvw7AMM2LMmLkhLXZyVv
	UoEnHk5GsLKmc91g5G3yB5riHjFe8b9NNU0tnxughA/5rCMKIqUjHitpYTQoaHbGs1ASr4Q==
X-Gm-Gg: AeBDietWJWIUz28XgA0sSZDb5oFGOk53IRzGy5AtBhxJHfK5C/M0KF6CUkkrfSO+47t
	JICFY/X65/8d0KjE2MIx3R2c3H30gYo9L/yVUrvS1CUBRQtNCok0FGdlOTLG1cloboOQWkIPB41
	v2/JfO2o4wl0LocFIPTndF6KuYcX16Xq1pF0msbZ4qdnXvLFSg9sYSFY6Zd4K/1evl44leJgsPU
	3vK0hg8SVBlyXCFuMVOGFWOeQyxtAi7JDnJ/1n9O0rru9XP6JTgPTkiyZVgTfeBvwVGM8lxDebX
	LUi5M2pu7dt/u8G22tXJmt+CO3zdV/a/vPslD1fJXfgTXIlc8GPZsP2eubPQw1jEH3y/FF8r9ES
	8BQxP3yozG92+mDBbChuGO0AT7CnrACyrWqI+rOcdZsToXP2oljp5B9rMfg026IHXUNCKLF1xea
	ertrI43xdPC/os/tz07/NA1bDDkNhIY5gP6/4MvG+H8UgeEv63JQ==
X-Received: by 2002:a17:903:b47:b0:2b2:481b:de68 with SMTP id d9443c01a7336-2b98746e3c7mr24133725ad.35.1777447462648;
        Wed, 29 Apr 2026 00:24:22 -0700 (PDT)
X-Received: by 2002:a17:903:b47:b0:2b2:481b:de68 with SMTP id d9443c01a7336-2b98746e3c7mr24133515ad.35.1777447462175;
        Wed, 29 Apr 2026 00:24:22 -0700 (PDT)
Received: from [10.131.77.91] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772c33sm13043765ad.8.2026.04.29.00.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:24:21 -0700 (PDT)
Message-ID: <be22f637-592f-4aea-a6e8-0c4662027dbe@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:54:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: change memory
 allocation for link_sinfo structure
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
 <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
 <59fa69de18211d2f17d346d22f2d07bbe72c157c.camel@sipsolutions.net>
 <3945df66-0f90-4371-a85d-26cd220dfc56@oss.qualcomm.com>
 <eb8474cd25dd12541557afecf3434e58a69a322b.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <eb8474cd25dd12541557afecf3434e58a69a322b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3MiBTYWx0ZWRfX6sF50B2juxwk
 1Ip74cqRLp0qls8dCDZPrOWmhFFx/XkSQRXoFKG9cSt5BaXs8mnPQJI73M11DU8cAeh3RN7qLa7
 0Jxr80xKcXClMyvjHpyU54RBIxEqhLqrscmaUP0tQV5HLg0lvVd0UmqjcWIZ6JCTsZa0ThCtAHL
 tua8yp34wZgsZ4xgqqgsM9QM6eg69eNseEoeRDgTA2DiuNOltXzGCbyjy23AZWSEREWXXSvNYTr
 FgTIW/xBkp+bBrDMo8og24EvpGthUdqxk9BtfoRrWHILK9w4i3OIl/9zBS81HCnlYhIPHvi4wBa
 bFBl6T7oJKO8D7lUE2kUlVfTjEGrGRZ6ZPTL0e3WqVD1JdZ8q8wP8ukQScUsTrvUSZU3zyMkig+
 mgnmMnNNT1DZL1UGRDcajy4XQa2Lze2O+z16xlljEx6+cn3SFDfDPlZUW8IFvw85bZpnL7VxnOC
 E4EVmsQoT3ru7DblZAw==
X-Proofpoint-GUID: a5e3Ill0Hx9GtpFpunQslYVUUCOLUuEj
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1b227 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=oU_uwikN5HYfHWX31qgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: a5e3Ill0Hx9GtpFpunQslYVUUCOLUuEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290072
X-Rspamd-Queue-Id: 93CFA4906B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35572-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 29-04-2026 11:46, Johannes Berg wrote:
> On Wed, 2026-04-29 at 11:38 +0530, Sarika Sharma wrote:
>>
>> On 28-04-2026 15:01, Johannes Berg wrote:
>>> On Tue, 2026-04-28 at 14:39 +0530, Sarika Sharma wrote:
>>>>
>>>> +int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_sinfo,
>>>
>>> really?
>>>
>>> johannes
>>
>> So, this helper API I introduced in cfg80211 since struct
>> link_station_info is defined and primarily used
>> there. Keeping allocation and lifetime management in cfg80211 ensures
>> consistent ownership and cleanup once the link_station_info is consumed.
>>
>> Please let me know if I understood your concern correctly, or if you
>> were referring to something else in this patch.
> 
> Hah, right. I was merely thinking of returning an error and using a
> double-pointer for assignment. There are better ways of doing that.
> 
> johannes

Thanks for the clarification. I can rework this to use a simpler pattern.

