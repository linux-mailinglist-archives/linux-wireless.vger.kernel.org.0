Return-Path: <linux-wireless+bounces-31890-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAhGOSBRk2nA3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31890-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:17:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9EB146A33
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3F03012C56
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCD1DFD96;
	Mon, 16 Feb 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NuwGtpHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BasvM5KB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7528851F
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262237; cv=none; b=aLPMxR1ucZyshUZ89C7j/O1cNiZcdPHrP4ho66afJZNfuWWtaoHqNQkZfBiT8kW6JBGrptnZ0nja0VCnR9dGcBKewfWfCPEpbXQVsXjaah28cAvXpuNEVGsjKN6dkuXMx54Qbz5w1dn91lrerwAKuO04hw9qk8119VDD5xgDBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262237; c=relaxed/simple;
	bh=H/nzbORyTBtPSnQDuh5wlgjXF1Lt4r7f1ZgHQJ1iJgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdVvjdD+odgDsaOtYnRIeos5C5qqV365u4n5gKt8jz+EVeKoptlyVSjm239eXU6r328Tr/V9cpbqb9gFtj3hmHNzrkiMxWk1/olY1CKIrCa43X7lOJuJJFOrE4N95DCGNX6UCDZ3TrhQzEDcmyeyyamIwk7GvUDYp+UcDJFKfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NuwGtpHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BasvM5KB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GH4ElT1544900
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tRx/Lm4pAe/AFgor8xlXcXnKCVXzzTERQn5gOs5u3Tg=; b=NuwGtpHJ4hpqZV4O
	jZaMlMAIOtqPO4Eq9RXjN0hESohcsT9GtSauZACQXPDm8p3tsSDncakEt8viW4E6
	OH4dCkgvEZcw5sbp7ezUY+v6VKHHIC1tq0DtdfHPHRRSboDQSj6TYYBy9z/hQhEJ
	CDo+LiBH1CzFLhWLLP0pRr3cIENuJTGxhAcCu2luhkFQ2TDdReEm5kqHcBA0WQmf
	+5Kl41ZwlsrjB1WWFqtlKIpQSr1MgpDjTMRqw7SD44b10WLLZHAi7ovwHgmUJr63
	Zhve0Tiwv3uGujCPcWspF6c6Qu5xjOwDfT7VjXL6ENqlnOvKdTmDLe5UrWxvh5t/
	5jJo3g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ajr165-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:17:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8249cbbf769so1460450b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771262235; x=1771867035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRx/Lm4pAe/AFgor8xlXcXnKCVXzzTERQn5gOs5u3Tg=;
        b=BasvM5KBcyay8Qg5I2PyRcvZusUHDnT2kJMPAEpqHs9juB4B82A20Q6M8L0JQLvPik
         IGBN8JBbw456tvG0O4/DkKoDEb1YZxTmH8QUQUDBDAk2pxXckWTSZWXisIwc+q+/8bVy
         W8FS7KUwKRhtVnfiJ4g+/SBqYryYG1WDT59tyYoZjqFsP+Hjo8KkryYnLVeneOiHPTCo
         QxHnRH87S3qe9nKP+hLDM6SV9E9gmzJZ6nmQ44MBwjw2eyeNuvA1sui/lYuApdUTSZSZ
         q9NjBBeeoJlXTrKPNwJxNwG0JdzIQAB4VhnwNgGRRIm1GWEWMVlEAGePahyESXhQuA1V
         Rxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262235; x=1771867035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRx/Lm4pAe/AFgor8xlXcXnKCVXzzTERQn5gOs5u3Tg=;
        b=LuUP+LAbr07RGMHc+bQ2H8aeqI3sqnfilO0S3O/mURP+2AfD2DVb/+AjIaDBarhfdH
         kau+SHXTvejXP+JvZWTJ2OvJdtX8lJaPlKd6uv4vexOajThaW8AlAEF8kYSqAizd04NG
         wCMYyAA/KDHyTRkLENRAbb/A65KJ+Ytvkb7zoPPj9izpnbcySUilsL/rQDMvgEycrx6j
         iol1LiX89iGze2eNePcFAt6PFyJEgcvZxyP2LPVKT04TlptJO2SEWROt2GdB3z3uP9Ex
         j4863DLKOJbvjiW1U4zekQ4hOXiv1JAc2Tvk3nqOl2TdW+96NTGA5rm6gUpWwxHCMnV1
         gDaA==
X-Forwarded-Encrypted: i=1; AJvYcCXpLg6kPHVESqZEG4mM4dHbP2TH9LEnoIJwRCmESaoStZkVFyE1AGNOwI9W0L8DjOGGD/EPog0OmvmG4gNCgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMJu+ATeEd8fz9JtGAfsIFqNzCtPDzaJtSW5KtmA8GkPorrMk
	bo/4L/ljU+oem+edYsR44HyJ9YSRC5ueV+RitiuttUtaObH8Mu1+I+UkfFU2pGacOfy+TNUaDOH
	p2Bg9+t9lzebzzpJZOKcisQf5frqE4GBqVI3r/rYmCphg6UzFsDKwTMLPCfM1cOur5hXwUA==
X-Gm-Gg: AZuq6aKZdoj+1HCEjNbHGnvWLrHIWH3FS/2jdwgLooU7V4SwgqLM3Olyy2gdH4ArJfs
	+o+BzvRvkMOQOTZYqa/g8cNp3SDkUO0REU/qqwwPzYlTRzUPmzdZhHY394X3VItaQ8ZJ1hP7IOr
	EYre5dZtt7cTBKO9mbe1mj6bzmjTNDS/I0uZR4iRcJy3ca4xBkp2Nezca9v8uuOQx1mzZCSRV/w
	+a4ObbPbyFVTGNZiDZk961xQqTO8D6P5caZQ8ZlTu4W/1Z+PJTJQMuxHeIF6p+go5dCqjcafHB6
	tCw8fy2nzmatQocsMkEEiS7B/q6jFZ06fPs2w1esCepKSWxPucstWyxBFon5cVf+EbxksLte3dp
	g5PvkDlzxbL7eh12UqfG6tJeeDl7q4TnUnD8YVMa5AP9TivvudUG9
X-Received: by 2002:a05:6a00:3d48:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-824c94e7cfcmr9441761b3a.14.1771262234334;
        Mon, 16 Feb 2026 09:17:14 -0800 (PST)
X-Received: by 2002:a05:6a00:3d48:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-824c94e7cfcmr9441748b3a.14.1771262233801;
        Mon, 16 Feb 2026 09:17:13 -0800 (PST)
Received: from [192.168.1.2] ([115.97.96.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69efdsm10689806b3a.40.2026.02.16.09.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:17:13 -0800 (PST)
Message-ID: <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 22:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        vasanthakumar.thiagarajan@oss.qualcomm.com,
        Lorenzo Bianconi <lorenzo@kernel.org>, ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
Content-Language: en-US
From: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE0OCBTYWx0ZWRfX41FNjrb/4h65
 amQ8jihkHaGyao2EVKGYYKm2sgS7Ufgv8zRie7zA9yZEpk/9oZbrneo/RmfHk09nD75IEIeRu1y
 e4PR96x5TjKxOFQVe425FaHbkDgv5kNr7pfLWTtwfDwjv64NdtfjwZVgU3fBwluiWB6IR4xPgFq
 cthJtXlsTUmVGSFvLU69Ty5+bGfG1bHAh3jPBcIqV+9FtwenHRdxQ4eRrNPUhFWRgQU+PLKH3PZ
 o5mxU8euojgIqG0Z2URxpSP8lxizj1r5+wF+Yy1USs3KtB6aRk3TQQHoxGS+WO2j4QUKCrgKzBF
 HKzvvk9Z8a48GULyJYteJnohA6yIy+OyKZEBffFecmoNDy+VecwYFzdOG08u3JGGol1bqVudON7
 I2YkoJUgZoD8OIg0BDCT8myapfs0v8676eoqruF0/TYVOQ6E+eoUAE3k1/X6hM71XvbN/iZ6s48
 2yOfvTQ4/GCM/NBPQ/A==
X-Proofpoint-ORIG-GUID: sgHyIZi222PXrW4gF1DF_KDS-MPSCVbP
X-Authority-Analysis: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=6993511b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6sPDMptOXngzVA0SphYZxQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=41PRVchwZf4xR-Uy6oIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: sgHyIZi222PXrW4gF1DF_KDS-MPSCVbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_05,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31890-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshitha.prem@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B9EB146A33
X-Rspamd-Action: no action



On 2/13/2026 3:41 PM, Johannes Berg wrote:
> Hi Harshita,
> 
>>> Should we add a separate netlink attribute for the UHR operation, which
>>> hostapd would fill with the _full_ data like it appears in association
>>> response etc.?
>>>
>>> That way, hostapd doesn't need to build a separate data/attribute
>>> structure but can just use hostapd_eid_uhr_operation(..., false) for it.
>>>
>>> An alternative would be to add more attributes for everything, but it's
>>> probably more complicated on both sides?
> 
>> Thank you for the suggestions.
>>
>> We feel that using separate nested attributes for each feature is the better approach, as this allows us to reuse the attributes for the Enhanced BSS Parameter Critical Update procedure, where similar information is carried in the UHR parameters update element.
> 
> Heh, I'll admit I'm surprised - I'm usually the one advocating for
> finer-grained attributes, and here I didn't ;-)
> 
>> While this approach is slightly more verbose, we believe it offers better extensibility for the future.
> 
> Does it actually, though?
> 
> I had sort of expected hostapd to add the UHR Parameters Update element
> to the beacons, and configure some way of having firmware set the
> countdown ("Countdown Timer"). Turns out this is not only in beacons but
> also in probe response, (re)association response and (UHR? [1]) link
> reconfiguration response frames.
> 
> [1] the spec says "Link Reconfiguration Response" but I think it should
> say "UHR Link Reconfiguration Response"
> 
> But I guess this is going to end up a continuation of the previous wifi7
> discussion from last year [2] which hadn't really completed. And Lorenzo
> just posted another thing on this [3].
> 
> [2] https://lore.kernel.org/linux-wireless/20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com/
> [3] https://lore.kernel.org/linux-wireless/20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org/
> 
> 
> So I think maybe we need to figure out how we will do all of this first?
> 
> Naively, I would've said ... something stupid. I'm reading the spec as
> I'm writing this ;-) The UHR Parameters Update element is actually
> included in all the beacons across the entire AP MLD.
> 
> Maybe we need to take a step back from our previous discussion as well,
> and introduce a broader concept here?
> 
> 
> I could imagine, for example, something where you say in the nl80211 API
> some variation of
> 
>  1) Let's start a new update operation ("NL80211_CMD_START_MLD_BSS_UPDATE"),
>     I guess already with some parameters saying:
>      - the updated affiliated AP (link)
>      - the number of beacon intervals you want to do it for
>      - the post-update UHR operation (?)
>        (or the new channel if it's CSA? etc.?)
> 
>      - maybe - more critical if we use it for CSA - already the beacon
>        templates for all the links? with all the things I say in (2)
>        below, but that's more complex maybe?
> 
>        the reason I say this is that there's a difference here in how
>        the counter is done - for CSA etc. the things have to disappear
>        from the beacon immediately, for UHR updates they stick around
>        and the counter indicates "in the past"
> 
>     returning a cookie for the operation.
> 
>  2) hostapd updates each link's beacon now including the UHR Parameters
>     Update element(s), for each currently ongoing update it includes -
>     indexed by the cookie - a list of offsets where the counters are
>     updated.
> 
>     Thing is that this depends on the operation - CSA will already need
>     the post-switch beacon template so the flow can continue without
>     involving hostapd, hostapd may however need to update the beacon in
>     the interim (both pre- and post-switch ones!) and need to refer
>     again to where the counters are filled in ...
> 
> 


Hi Johannes,

This approach looks well suited to handling overlapping update scenarios.

To make sure I understand it correctly, I’d like to walk through a
concise example where a UHR critical update and a CSA overlap on link 0
of a 3‑link AP MLD.


t1: A UHR critical update is triggered. hostapd sends
NL80211_CMD_START_MLD_BSS_UPDATE with an advanced notification (5
TBTTs), post‑interval (5 TBTTs), and the beacon template with UHR
parameters update element for link 0. Timers start in mac80211, and
hostapd receives cookie X.


t2: hostapd sends NL80211_CMD_UPDATE_AP with cookie X and offset where
the counter is updated for link 1 (and then link 2).

the countdown values would be handled in mac80211 with the offset
mentioned similar to ieee80211_set_beacon_cntdwn().

t3: Before the UHR advanced interval completes, a CSA is triggered (due
to radar or user‑initiated). Another NL80211_CMD_START_MLD_BSS_UPDATE is
issued with CSA countdown 5, including CSA and after beacon templates.
The after template carries cookie X and the offset. Since UHR CU is
already in progress, hostapd could also include an updated parameters
update element. Also, an updated UHR operation element which can be
modified in after beacon template if CSA finishes after the UHR CU
advance interval. (why to provide the UHR operation element separately
is because the advance notification can be before or after the CSA
finalize).
hostapd then receives cookie Y for the CSA.


t4: hostapd issues NL80211_CMD_UPDATE_AP for link 1 with cookie X (UHR
offset) and cookie Y (CSA offset), followed by link 2.


t5: When the UHR advanced notification interval expires, the CSA after
beacon template is updated to reflect the new operation element by
mac80211 or getting it from hostapd.


t6: Once the CSA completes, the driver updates the after beacon template
along with updated counter for UHR parameter update element. (since it
will be in the post notification interval)


t7: When the UHR post‑interval completes, the UHR parameter update
element is removed. Since offsets are known, the driver can remove it
from the latest beacon template.

Please let me know if this sequence aligns with the intended behavior,
or if I’m missing any edge cases.

Also, CSA during NPCA parameter update seems very tricky as the channel
information advertised in NPCA may not be relevant when there is a CSA,
perhaps stop the NPCA CU (still spec has not mentioned any details on
the abort scenario though)

Even, in case of link removal during UHR CU update, we need to stop the
UHR CU.

Furthermore, the UHR capabilities carries the advance notification
interval, post notification  (i guess yet to be added in element as I
see it in "37-8—Enhanced Critical Updates Mechanism") and update
indication in TIM interval, these intervals can be sent in the START_AP.
I assume, these intervals cannot be modified dynamically as these are
exchanged in assoc response (Will reconfirm again).

For beacon offloaded drivers, NL80211_CMD_START_MLD_BSS_UPDATE can be as
a trigger. May be we can add the updated UHR operation element in case
of UHR. So, that firmware/driver handle the timers as well as
constructing the elements since "the encoding of fields in Mode specific
parameters for any feature say DPS/NPCA/DBE etc.. is same as the
corresponding field in operation parameters field for that feature" (but
i see bit variations for NPCA between both)

I guess, this means the proposal of having a separate netlink attribute
for the UHR operation with _full_ data like is much useful.

Still, we are thinking through on all the other cases of wifi-7/CCA etc..

> Either way, it feels like we've reached the end of where the current
> design with CSA and BSS color updates will take us. Lorenzo already gave
> up and put the parsing into the driver to find the offsets, but I
> personally think that's very inflexible.
> 
> Some operations such as link removal may not need to have perfect
> timing, but some others like CSA really do want the updates to happen at
> the precise moment.
> 
> In some way, it's almost good that we haven't completed the WiFi7 part
> since the UHR part throws another curveball with the counters
> decrementing below zero - for past updates - in a sense.
> 
> 
> johannes

Thanks in advance for your time and clarification.

Regards,
Harshitha


