Return-Path: <linux-wireless+bounces-37878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5tRXAjxJM2pR/AUAu9opvQ
	(envelope-from <linux-wireless+bounces-37878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 03:26:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8569D009
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 03:26:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="NVh/m3B5";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kWTcrxxd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37878-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37878-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 123BA302BEFD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587F296BA9;
	Thu, 18 Jun 2026 01:26:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8C285CB4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:26:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745976; cv=none; b=CubWfktT3lQDuQWQ+WGdMC1zE6fry0ww7SXesUQuM0kIH/IsjINiv22t5JpMGgVv7G+wNbinCo0E27NbmYLKPPo3UEFS6snRUQS3aJS1CI0/yyaS9eXPu+XSiYrPWbe6Zn5OvatTU0c3yXtOf1jFBAeDA9Og+p1+xCG19GeCk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745976; c=relaxed/simple;
	bh=po1VNmaGNeX8hpKAsE+zWftJGH3ZFExeT2TRvt4SRNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbdaF/LIvUGcEjZe93h4nNDBQvQvpgarQ1FXz05hNgFINB5Hm+3hH8OvRCbZK99po5a/smWq8szmYKMSlT7VdYjiKCi6xzv3SlisvQWnItICGxPuKGdkStzUBlAbAj3Xd8Ocp287zRODZGFYDw/DMiHolq2qm+KZZ216XIRFDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVh/m3B5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWTcrxxd; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HI1B6e3577418
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=; b=NVh/m3B5qSwJXP+5
	wGkAniDjt0DrcHTtUnpNa4ifFphSmOUjq936UBsgHuvd3K7YLHIOi8IkI+O6r5NO
	kAxXoBrkngon19Wj5+TGYTcDTw2dwgXiXx+AWwEWf5wKGNN1fv+284U2gpD7qEIt
	LmqibM+qINxSlRQljFlSjK5AAwYPfXYaOpSguCF+JrkK25FHMvs7UnTWzcIEDJQc
	SILFNbw3wE79CX6inKzaETsdTyz/8mTEMbaa3Tfba8mMSvcQBhsgQR3t44P8Qk2h
	h+3dKpkvYTXr2IpkK39XwxFY5dq9wEqpZRHhHbhL1iS0ue/XePfstp276Skypjoz
	rZ1Yyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7hfh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 01:26:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ba395b047so1695882eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781745973; x=1782350773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=;
        b=kWTcrxxdHe+hGCk9mZ0LVmvCpkz3E6a9AMedpsyu2ICni3Ap6NoBbxzImjMPJiIcas
         V+gBPu8e44GzLXev5nExrzkfAYLNGxG7lDtJl8SgCgbdfZk0suzpXNfDCbi+gdmmwDvq
         ejYoeTQwytiELV1U32P8W74wyhPkJ3QnsgIXxogl03ai4O6DzMmGyJabeSVRo8BQLO+E
         UDU53GW8ASWZZ9leHpkp11FCNBZdK1BlWm4EsEoQIfnU8xbhnic7uy9+iHV4Fev4JjnO
         dXeBYoVjPzK0wKFTO+/fuXq3TO5kLM+OjjC0VIC0AFY1YrwbrZW0a90HM67zWVQ6XMlx
         6TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781745973; x=1782350773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XKu0UYunFj/QEVwO21dV2lkrJPY7vJQuRxaCwuzOeE=;
        b=KC87tSj9kXCl21lElw2kEXbD10DsRDKWi4T9l2u6DlYb2nyW6+F7u3V4eI5XxiG4Mw
         RhJ6rBWPeHE8nn21HT7qsZ35sJRTgdvpwN5ytdpeVJA/ihhiTV8z7NRtCr+w93YeYIbE
         5H08iwVUlSHe/L7++poBlhAm+5GOL+xIQoUvrb+Vs/ahoeMsV4RsAQeaBscWpO7ZvXgL
         Lg0LrfkejcvpYf3OFwEejJbkTNGuwN7HRbO0i+Pcz7tWi02IoNKHhNCGssHPIfk8HWNU
         yYlGqt54jrQsaXq7CWNlX+sxshLqXAH/QSM6u7sFM37eJLyusxw7N5Z+tFfXv6Ch7B5O
         tbOA==
X-Forwarded-Encrypted: i=1; AFNElJ/dcA0ZWGj5WLmlxvUG+L/IEK10SSQMLPAzM9A5saOzruFyxWAVcAy0W5PY6YFOGkKUlnlcQ9xunDa31EOA+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJhy5w88o/Z5Qp2/zdJn74YVumdwIqvso7zNw+eVGFt+VIIOY
	W0F94zFjgTmUkFGYLIFD6fo0nBAti6HQrHqj4D4E1MTd49rTX0CL2zTjX7Ta9R6PD3/X5LxARiD
	WYzJTH/cmw06LKeo566j8BwjKVooZngKiX0YJ2UxpIqBTBQn9+AVqlQ9R9A2u0pBqtmX7Jg==
X-Gm-Gg: AfdE7ckNwkVlTvj710HGqj5RKuHZMggtbWVHpE6+aHYOeTURVdtIZWKrvXX3pSJe2Oj
	z7eoIvM6FiAJNbvFDjCnm8zKms4/XyJmYDmM/Kbt4DRPFpLhrkklzBmE4rFra9+PPhjbkhKY1q1
	IFKAQqBcD1TGrP1UecHX2UDBnd0wLe9TjAvLRPxHgKbCKAIo6WAhAhHJmqTgiwtWv/rqreCcmU1
	kJjJmKsCObRGOferPvgLiHBTxeTVx1N7irnD7iPkiuk2H/dYq9hyIrXcDzzzEu0ILcj+iOLTR4U
	PxQo6o7hfSl0sANh71d2vU/80/5VxGLGdP4wOFyMoWTqpUfPSpOxQVMKxcZ9z9iT3lHPCsETPw1
	INYm48uKtFd9aXSE/iXkPsybI4VlBaLUrkg9MOfEAs2g7K9O0IiOm18VIcMdICpK+gumXSPGHM1
	XviF0=
X-Received: by 2002:a05:7300:df0b:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-30bf0a45b07mr1072463eec.35.1781745972835;
        Wed, 17 Jun 2026 18:26:12 -0700 (PDT)
X-Received: by 2002:a05:7300:df0b:b0:2ed:e15:c927 with SMTP id 5a478bee46e88-30bf0a45b07mr1072429eec.35.1781745972223;
        Wed, 17 Jun 2026 18:26:12 -0700 (PDT)
Received: from [192.168.1.31] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bd8ab412fsm3953303eec.31.2026.06.17.18.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:26:11 -0700 (PDT)
Message-ID: <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:26:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAxMCBTYWx0ZWRfX0/FGjc03e3wA
 S2ILWPFQRpvsznLpjWMl6cb2Ixqg3BWIVfSCkHBbAAN1J00jweETV0kQwyshvHEoGEXwk2r0DsM
 JFEEAM4+A57L9oYGaAhIMPJPa0/m/W2ge0m4t0fAeIwbLxroXDpaVLy+9MRyWBEr/iS9VVdqNXJ
 0n8Q1JMq7iEz3Wjq6dTRaxeq/D5+QU8ciesKB6m4HwWj2PJ/tXQ1/4YNLn9+5CAIdgFMikLuqgc
 ahvdZtrcqD/5vVsx6H6ERndOaeii7jk+qq8IP7ZL6SL+63fKOdR46J7mueqjZeUL20kPGMl1kUs
 pEIx63/BzO5+Gu3AceWhtKBWiH/t/MpJwo66+YfQ5Orgmcb7h8oati+Td4jGNQ1OHvBP+UI1Cp5
 H9QmrsbEk8W7daolY54RdabCQbB3HCCVXOiO0ibNEJpXOTl3maTEO4mWOVIAwHjoR+tqRQAsjSz
 gsHEQxGsoO/r/XzS0Tw==
X-Proofpoint-GUID: QhMiyc2mAdZ8Gc9vqR8wNTemRcvTxNOK
X-Proofpoint-ORIG-GUID: QhMiyc2mAdZ8Gc9vqR8wNTemRcvTxNOK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAxMCBTYWx0ZWRfX9Up4Gmw3YEyu
 oPtPgVr/48wUPgK5lqjTwApCMPo9kiIL+UEITl1C8BG+a2qgZwSx0wK3TOFkXd9ruymphl7f1Jo
 YN3q8EJoOFPmX8s0VYosun/sNEI6AXE=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a334935 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=yrwDRl_2H5AUk312M7UA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180010
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37878-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:git@danielhodges.dev,m:linux-wireless@vger.kernel.org,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,danielhodges.dev:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98E8569D009

On 2/6/2026 10:52 AM, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> Additionally, the timer callback can re-arm itself via mod_timer() while
> aggr_reset_state() is running, creating a more complex race condition.
> 
> Use timer_delete_sync() instead to ensure any running timer callback
> has completed before returning.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index c3b06b515c4f..25ff5dec221c 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>  		return;
>  
>  	if (aggr_conn->timer_scheduled) {
> -		timer_delete(&aggr_conn->timer);
> +		timer_delete_sync(&aggr_conn->timer);

My review agent claims this still doesn't fix the UAF since aggr_timeout() can
call mod_timer() to rearm itself and hence the timer can fire again.
Instead it suggests timer_shutdown_sync() should be used since that prevents
any rearm from taking effect.

But I'm not familiar with this driver so I don't know if there are reasons to
not use timer_shutdown_sync(), i.e. if the timer will be reused again then
timer_setup() will need to be called again.

>  		aggr_conn->timer_scheduled = false;
>  	}
>  


