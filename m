Return-Path: <linux-wireless+bounces-36193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+zDqB2AWpGaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:26:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72A508855
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E94F23001597
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF92DA75C;
	Mon, 11 May 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/XsH5Qb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NUAljG2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C22D97B8
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480794; cv=none; b=iqzpvYLQRdO3fS9TpfEtjPJA8bPpyrF5anx2HwAjWt2Tj+9LDIKts/pnW1SPRobbjh91wzEpDyXKujM6TekOISEVEIMFkbcPMVHUB5Tt3uEEA84ZxUBa6AbwvQ7PSPJFHwQmasdiFj0YJJOgksQQWoMOOgEZ0wO1CsWC9CUs0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480794; c=relaxed/simple;
	bh=kX3CvLceGcmhsX9Iwpwq77t088er6+iR2tbalsgYc+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSMfv5pRZCEl/1UrFyGPIHtZZ51/EgQhEFL/8FXqLMsireMZ1Tc/HpAauc7TcXHEaCZMNv2li/34e69VdyhP9RZteriI1ohC/y0AYk23BFciWo4utCR+WHl7L5JAmMQBZ35ObFfrt7KnHmm9nArc465f35N+aO1YqS5vA6b412I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/XsH5Qb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NUAljG2U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B4WPpL2801917
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 06:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QnwcJN7TFAWQlCcGaJF0zyC1doj9FeUakizuNv79wgw=; b=N/XsH5QbTNPLTqpj
	o8FSxPxNnlaZx0/MNFmTB3p1KgunOyfmXJa3kV4nTUL7aj/KSJw7VFa9vZDdvse7
	KC+e7F7pwZUpoHJrFriVWhlx2E17jO+87N1go8T/mku+lbahrSgmCoKw585kyeTx
	m/WuRl+I5aVumWmjtTYbiaj4QegjP9mzAw7b/47JXrTolO1B+hUUi8Uxkh6fpoU5
	t3x7dN3kOMj6kgQJiTn2OU6NxMEqFkIdVAu9o0fNSPsYUgooIpsDFimYXd25CKBH
	tmW7Dm76YPKfIxcLboc0yTevytvX5gWwFi9n/UT0EZjwduedbNR89c/6FVlxihpn
	qC+c6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1vgy4rx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 06:26:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-366122e01fcso4415353a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778480790; x=1779085590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnwcJN7TFAWQlCcGaJF0zyC1doj9FeUakizuNv79wgw=;
        b=NUAljG2UwE7P610EccUSyPKA563j+2mm0TCGJPsrvcrYbPjiYHn+AHh6MA6HHd0V/i
         74LjNK1MpP1yXiInCtR3irXElKrfPohCa9keT6csniYOQpnR3OwCr5+voWnLLNoDOUDR
         vJSvjtMomWI2qAQyuHjC0l/M4x5Ktgd35LuTCnPBZtzbRJMy6eUmv3T+OhKFX1bi9Umt
         muQcT4UhvQqMzNYa2TpZsYt1zkxpasgJBrt1AairdXjmOhTDZs5obvLpMrAbZKEZGhSv
         TbDPuFWUR+hTgPZWCqGNr9OUJkedjUesENmwtiLeXN4L10+APf/ty0IyTMJnbxAPaKzP
         AtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480790; x=1779085590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnwcJN7TFAWQlCcGaJF0zyC1doj9FeUakizuNv79wgw=;
        b=MhFlZSO9bj2iZ4ci3SzLz6U8uUhGBWI6QqQhZuDyhGUDb9bjTOEM5G8Xn5a3da97ZE
         fBCXwSqNO84SaTV0i4/SVQ4/HqpRNVdzy+Hj2L7O7L7SH5PRrquJATtWPCZ/kp7RlMPQ
         d9bFknJwIkKGsNiTeyvyLX8Gr/y6sitY6fUGtmCGvnCJ+dYjUnT1s/aJLcDzdwxALrVx
         yrPMXuhGnMO8uQPppB0gcfH3R2qOK5FjHpC7aMkqM1oHRDI3pAqHOc8NzQr/kAuhtGg9
         ZgYPhb2S3GPU3L2lBtn50NmZwavZNU2oVuBMHkfNBGuwkbjBtPnQQApDuZ9aznHtC1Oc
         PQVA==
X-Gm-Message-State: AOJu0Yyy9KUYlDbGqleghp3pXVA7jLXIMnTDdUOjg8ASGspXC97zKg5h
	U5TTX/eu6mp4QTNZZSvI/EfM6PUR1KeChd4BUx/XgLWXVBl0vIike4B4XWFpgqbbZql9R10s+u5
	y+BN7+Exp5tpxpRvRQ1xIeDxkMA/7YhbPvhp6eeKlrymgPLKDH5etgV6R/vxD6XTm1rsefA==
X-Gm-Gg: Acq92OFYvAi1nKO7Z88g2wg5LHw46Uhui/fduHVxBu88NlDqDC8WLbQre7KmCYys7JI
	yiIGZ15MxtnIw8jETt16v2YqudQYQsGDoDY9AwJ3uB8bw0wM4iVuFc1QJlxwHTo0u/02WxkGYGP
	VSzM3du++oW1sHwJWgGz8ZZOijbiDHiRVAHxlMYyrkcEVpogJ6BxVzUb3XnwX+9x9GwpTbkbcL/
	psFcktEXEbM2gqcWxdHu8JHDufqGgTF2ekH0JpImY++XLJo68Lv8GXvz/CPR7Jj+qC1+9k9i4Tz
	VUjXBeSippq6UxTzhRgCmaOzW2vssIZjmWWGoHvtoLjsa/F/Tnz4OhJWBtXuKG4Fy9asfwUBE8l
	C4aHfdjhb/soBo4IAYcRefHl/g12IuwOO2TNlT5mU3m6ISRV+FEQM0QjtlfpK+94=
X-Received: by 2002:a17:90b:4f85:b0:368:5367:d67e with SMTP id 98e67ed59e1d1-368536812b4mr2940601a91.10.1778480790399;
        Sun, 10 May 2026 23:26:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4f85:b0:368:5367:d67e with SMTP id 98e67ed59e1d1-368536812b4mr2940581a91.10.1778480789885;
        Sun, 10 May 2026 23:26:29 -0700 (PDT)
Received: from [10.152.207.30] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fa7asm7709102a91.10.2026.05.10.23.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 23:26:29 -0700 (PDT)
Message-ID: <dbb28e3e-5022-4915-93e3-dd428ea59507@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:56:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request rejection
 after MLD link removal
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>
References: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
 <1f57207139c3fb955459425deda4d06c374ae212.camel@sipsolutions.net>
 <1d06b2a3-66d8-4c27-b965-6c21f80b7539@oss.qualcomm.com>
 <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
Content-Language: en-US
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
In-Reply-To: <a5b6798819178dd2995c34ec817457e90985708e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fpHsol4f c=1 sm=1 tr=0 ts=6a017697 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=RVt_A0WLtHSgIvxD3YEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: XwLBvjitywe-uDsP-BtyI0ldDPe1ZX7M
X-Proofpoint-GUID: XwLBvjitywe-uDsP-BtyI0ldDPe1ZX7M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA2OSBTYWx0ZWRfXypvCT3QCu6TG
 epDCyBnfHnTuodypbvmc9k0o0e+6ORhU9FQ5R83hPqxVFcgof0yFsadJPkBh7jHzeWQ1UYjjTej
 TAWkl26wCFQF/rb6+L7pnz2G7fcI1VqtN03+NjhwQtGx9/Cdseiv7cEBAmc1uWhbeJ9VCWw6FFE
 WqrAwngU6QXLlfZnXQIgNsYXmHjiYZNojQn/qrD8x+DaK9Ql84E9wGPw7T7fo4AM8qg4uV7vi5t
 1lMRIz5EoyQVCFu3RyMkIMMtVbiyVkP8VlkJtzaSrX2mbZW1Ajr2LIOglPQ6HmR3DS36WlNxX4W
 7v+VQ0lKJZU7i0BXMzwbm2sR/KaOX/gluLg7NcdXrxKn1w6XsS8kkPml09tgqCGBMdxgFHq/AoE
 SGYE3SanR7xSkqXbn71wi8mAKX2tOmlPuQTwT1KEXg0xHW4XtNYurb7QdGRdE5vytqAEjNTTs/l
 HM0sXDDvq4q6b95e6BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110069
X-Rspamd-Queue-Id: 3B72A508855
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36193-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/7/2026 11:56 PM, Johannes Berg wrote:
> Hi,
> 
> Sorry, I've definitely fallen behind on some topics.
> 
No problem :)

>> With link reconfiguration, not handling the update requests sent on the
>> remaining links causes throughput drop, that's why went with handling
>> the update requests even-though the session is valid.
> 
> I'm not sure I see the relation right now, how does link reconfiguration
> relate to AddBA re-negotiation? Are there implementations that
> necessarily combine the two somehow?
> 

No, there is no implementations that combine these two, but there are 
cases where the update AddBA request can be received from the station 
with link reconfiguration.

For instance, if a station associated in 2 GHz, later with link 
reconfiguration station can either move to 5 GHz or it can add 5 GHz (as 
MLD). Station then can send a AddBA request to update the window size or 
other related parameters. Current change tries to address this by 
treating the request as START and ath12k driver internally takes care of 
updating the existing session. But, as you mentioned, we feel that it 
should be treated as an UPDATE instead of START.

>> Please let us know if we need to clear the old session and then proceed
>> with the update request to avoid breaking the other drivers.
> 
> I'm not sure what you're trying to achieve, so I'm not entirely sure
> what to say. I thought we were starting from "we should accept no-op
> updates".
> 
>>>> Note: A similar fix has been proposed in [1]. This patch also fixes the
>>>> issue mentioned there. The difference in approach is to keep a similar
>>>> flow when the dialog_token matches. Previously only the timeout value
>>>> is checked, updated that to check the timeout only for the hardware that
>>>> doesn't set SUPPORT_REORDERING_BUFFER. In [1], it was changed to invoke
>>>> driver unconditionally when SUPPORT_REORDERING_BUFFER is set.
>>>>
>>>> https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt/
>>>>
>>> What was wrong with the approach we discussed there, other than nobody
>>> implementing it?
>>>
>>> johannes
>>
>> Not a major different between the other change, thought of keeping the
>> similar version that we validated in the internal tree.
> 
> I don't think it _is_ that similar though? Or maybe it is, but I didn't
> think the other patch was correct (either).
> 
> Basically I'm concerned that calling drv_ampdu_action() with
> IEEE80211_AMPDU_RX_START when the session is already active may break
> things depending on the driver.
> 
> If you think there's a need to _really_ update parameters, then we
> should probably add a IEEE80211_AMPDU_RX_UPDATE operation, and implement
> it in drivers, and of course in some drivers that might just be
> equivalent to IEEE80211_AMPDU_RX_START (though that seems unlikely in
> general, given you may have to allocate reorder buffers etc.)
> 
Agree.

> Regardless of that, if you think we need to accept no-op updates (I
> don't think we've seen the need so far), then the code shouldn't really
> (need to) call the driver at all, since things don't really change. For
> that I'd argue we should go with the approached discussed in the thread
> of [1], but not really that change itself.
> 
> [1] https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt/
> 
We believe that a no-op update is not required (or at-least we couldn't 
think of a case in which that is actually needed) as there can might be 
an actual change in the subsequent AddBA request.

> I'm perfectly willing to believe the need for both, but I'd argue that
>   - no-op updates can be handled by mac80211 entirely by itself, as
>     discussed in that thread, just someone needs to implement it
>   - updates with changes need a separate call to the driver, which might
>     fail (either because of the change, or because it's not implemented)
> 
> As is, I don't think the code is safe in general. It may be that you
> validated it against your driver, but then I'd argue that it worked for
> your driver only because a new IEEE80211_AMPDU_RX_UPDATE would be
> equivalent to IEEE80211_AMPDU_RX_START for that driver for some reason,
> not because there's a general reason that this should work.
> 
> johannes

Yes, based on the case that we encountered, IEEE80211_AMPDU_RX_UPDATE is 
the right approach for the handling those requests safely for other 
driver(s) as well instead of relying on IEEE80211_AMPDU_RX_START

Regards
Manish Dharanenthiran

