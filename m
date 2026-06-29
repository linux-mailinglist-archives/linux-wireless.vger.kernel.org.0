Return-Path: <linux-wireless+bounces-38247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jsquDEn7QWosxwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 793246D5F28
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=iWsdy0+F;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="HqXHE/fk";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38247-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38247-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3216630179C9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C02C11E1;
	Mon, 29 Jun 2026 04:57:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE82BEC3F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:57:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782709055; cv=none; b=a3KS2T+EZXkRjqsy8jV00phnWdZ2Ur4sAMWOHr0P7HTGuroY3kghRcIFLDRAtXOdX1YLooVpFEbgoZX8XPy2XKEwJAYEyM/AEMp5ABYbajgZNhbi6TkVBOF1iWvoRdpFcpIWDPe6FcT0PhlMW27uS37e15/Dh91fjOfbX6hiaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782709055; c=relaxed/simple;
	bh=+yoPpe9fIfcB7MaM+dP2uhzUrsLysVEi//fhtVtbXQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWZWXEpHq/w225/YiKb5jEBrdWYi2IFb2TdZkq5r7RlE189xTEVZScIhYnoCqXJImvGSfP56qqOvNw8iIz25uTosnZSrK3cXhAop4WNcA1y1WqMJ4NH7bmDqKLaWwiqk6Iy+VxQCmV4ZVvqTrEKgBexRQCsRYyVOl/nbC19izc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWsdy0+F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HqXHE/fk; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NHGs1771453
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vf9qngapcjb41EMYs4STog4NK088Mw8MZc/Dzmo7oMA=; b=iWsdy0+FjvuTr905
	QjkjrbLwsssTdXCECpovCCRReHhOLyul93GEfMLmwledZSVhoRhnCjd68iFsdy0X
	k3Npq84py9yVf4Lcu7yZ/jKdMtuKX/r9uXyhwlzuoowhyiKuBwzIbaeukPfkr2TN
	JAaPZPmxuQ3xMX86lk+6EE/gzTIkSpxTSOmEyG8gARyrhDh+jDI4f9DfsxMNzFhq
	B1ZA366cixyDuDD5vzw5Tckvk7Qlig2Ddb2dPeOJWrnFQVPvMTR7/E6th4mt1QpC
	i0csO0EH3dZNUH3Hu5m5B3Mtgthch3IcQWdBiWl9wcm4wqeMg24jzMsErP50s8X+
	bWCLUg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumf2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:57:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139871a52c2so4102225c88.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782709053; x=1783313853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vf9qngapcjb41EMYs4STog4NK088Mw8MZc/Dzmo7oMA=;
        b=HqXHE/fknd/GJ7CLOAs/wuQIQGvF1r4VSdXqOiZr/Uxke4y06M0qpfT6w0cFZc3sLc
         uFfch+efyVankS4ZP5RvxMchjoqtLOvXJaRMDiyyHZ9u8o2hoRpTZ3r/Jnejhn591MaH
         j7qGBKZ8lEVbqsitn7CUFMDIqmF3s8MWGQqxsHyZOh+73RZOm3afY+A4KQy5w8id4DGP
         1pBMQ6DnZkzSI0AL+UpkalmnyQnNyRsnLRDRzyNufGiypaCLjJSwUMTwF0b7QVfoLfGG
         0mBdI6FF1/3+qNEuANuCAogaMl9M/NM7XRBLevTsMgcZQR1kRwQSaxLFThrMzkR08joP
         bYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782709053; x=1783313853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf9qngapcjb41EMYs4STog4NK088Mw8MZc/Dzmo7oMA=;
        b=kEYJIgSzQoocjtFifxHZU9OLVClDTPfnVrCS+fYTzqxj1nyr0psICAh1eQ0WChoh28
         K3GSjCZVd6FIZNLsQwlXbNrGAJA48DQ4FcvHZ/wVMTHoQK2npRTypC3Ql+SszsYq/AJd
         p5Aa6HiSdkZyczwZVXeVTU0soaxDsnysKsqr1jKCc/bL8a8Me0zaaji4Dn7AI11EV8fl
         xPG6NT3uXezZhO/3g1qYVQWeAtNBovzlcglArgdG7mOUn2yFgY7WXClrtBvX2e5nSRSR
         3QBF9Tf/+Kefsjy7Jcz83J66PTNs2vO0F+lkUJOIF0hZ0S/SicpUNvPbIsiayLGftRKA
         bikw==
X-Forwarded-Encrypted: i=1; AFNElJ908JBN0XMy80u5dErv2fAiU6M+4NdBGwjUJ+1FDeZWKCrImF8ke54RX5hHE9mFAm/1+FkBXbqiDfDsJCphcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykmMhtahuto+EZcvaximcdY+/kUl4X7xTlxvwZdNNgxp5A9upb
	UczNonIEhepVJ+FbD6meu25jPT8fQVNWY0EKJ4iaPrvibYxMDVe8+28O2TK6BZzq62JzW4iffoS
	SBctKR4+rQqcfq0+Tt8WsLjHr4aYEEEdDGOf+neh98tiQj9FN89PUGRsH0QhDdQjd64Rzvw==
X-Gm-Gg: AfdE7cmmo/bnosmEoOprwF64428vcNDxZ4Npnul6jkTi5MEH1nuqS4oqhMQwZGzzXaR
	R+hkzD2AjlYD4vmM4FuFEpT5HM5jGvJ9h4Xl4EKvUQDGO6hSXH5HEBfbWgvJ3rJJ5RREDrvSbj0
	g0mIooCABzFhPxmYKjf6EzBue9zHs35WwCmHHEex4h/K+xYa7ZkxsfUE5xAZC6PlfhLJQlpF8K/
	cNr9nO64AyqgG1wpfEGH6eDih7LjlRl1EdifOn3lXtpkcmbH/FcjPEzJBz2wE9gkzIZWzW0MCKG
	YTWuARpHpii1EbWUTo4ZgW3szCz+lDMXm61TjHqDbwlySYLLbBUoCXglK+S2DhpJ2bxu6RAt9oC
	XyxAOd2tSfUdpx3KreL/DlMxdBv/QOp6C463VmeaOhWOz4ZFWTW4g9VxVaxBO
X-Received: by 2002:a05:7022:69a7:b0:139:d910:ac58 with SMTP id a92af1059eb24-139dbaa5be1mr12555707c88.20.1782709053335;
        Sun, 28 Jun 2026 21:57:33 -0700 (PDT)
X-Received: by 2002:a05:7022:69a7:b0:139:d910:ac58 with SMTP id a92af1059eb24-139dbaa5be1mr12555703c88.20.1782709052838;
        Sun, 28 Jun 2026 21:57:32 -0700 (PDT)
Received: from [10.168.91.130] ([106.211.250.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6acf9sm41454685c88.6.2026.06.28.21.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:57:32 -0700 (PDT)
Message-ID: <34ad2c6a-b9c3-4f99-97a7-e58fb22e2e78@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:27:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath6kl: fix OOB access from firmware ADDBA
 window size
To: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristan@talencesecurity.com>
References: <178243229402.3653332.17576562809691611363@talencesecurity.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <178243229402.3653332.17576562809691611363@talencesecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EeTrhAzfmlC5T99ackuLWlGJsee2x3U3
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41fb3e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=piOy77Qi3eXCa7Kn6a748g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J_-Nd1mkAAAA:8 a=ZtkLO85gcAc21UMs6qIA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: EeTrhAzfmlC5T99ackuLWlGJsee2x3U3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzOSBTYWx0ZWRfX2jWnCxucCQiq
 VhH9Nk3icUp8JUwV0JkECaaPNLyJ/d5PusRJ0cSQqbZyXeTYAW71oDuS135+MUkifnt5t6dhcfT
 wxiSRBe+vW/DhxHTGEsOF5njwAxTYxzET8K/uJFYFOlGtZfnsW+3MawXutLNNT8AJQclVyoaIvK
 Q1+ocZkmALeghKJUjeNT7ToL3wYJWBoOdyD4+Tk6+Il4oj/mD5iinORJZwzwdXipzJa1BDPlx+V
 F51SEngIJgIbmMBHSoABSLjbkP2YKuz/U0sAL3WK3sxhP88eUKOfZw6DDOTlA/i6C7ek9oE2RX6
 nYAQ9rzmlEiqc6xhautDLNz6BR8JHRmNL9Zs+EURQcZmX/AMh+oWasmuV3nvJFdmMK6tG/5XPbr
 vkZYGSy8zWqT8BSzeuc42N4+UGin2ovVh7bz2ufJya4b0GiNOdu8c4fbyssY+ij6fIRTknI83+Q
 xsU3GECmtp/SlCEc2NA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzOSBTYWx0ZWRfX6T4Vf1VCXUW6
 zQzzMRWOdDfBrJ5f/GnJuftMpHsxGkB2b3lr89P3wD+oaDOMitnpqqK2Jhf6jjR4KBcu7S07A3I
 kwD/iBqplDmSkystPNhJkLQoJ5hM0Lw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290039
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38247-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,m:johannes@sipsolutions.net,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,talencesecurity.com:email];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 793246D5F28



On 6/26/2026 5:34 AM, Tristan Madani wrote:
> aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
> win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
> return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
> compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
> zero-size or overflowed allocations and subsequent out-of-bounds access.
> 
> Clean up any previously active aggregation session for the TID first,
> then return early when win_sz is out of the valid range, instead of
> proceeding with a broken allocation size.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Suggested-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

You can remove my suggested-by as I only provided review comments on your patch.

> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

With the above comment addressed,

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

