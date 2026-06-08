Return-Path: <linux-wireless+bounces-37536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m47iI538JmrzpAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:32:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D88659446
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:32:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CN8pI+VF;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AZYkzQan;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37536-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37536-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 966C63023C7C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472FC3D811B;
	Mon,  8 Jun 2026 17:24:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFA3D092F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 17:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939454; cv=none; b=tYoBtJhlIIk/1lphuheuteKL4YGhT7fOr+kTQfDX/JWgHS72xFLajo2ajAgF4vVNXhAPydwyylusrmCdggi4o4BCbEVn+v5WKIdlUi701ETti8P7jJcq9n41n+apnFihVlNQAWBUQOs3mEuCOUp+zmstr4vB0SWcGDaIZtLoKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939454; c=relaxed/simple;
	bh=5FFoVBEExNYKZz7vEGVYM7wHnO+IsODRKnWMRDLXEQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Djj2/zpKCYI5i73+Dpp84jkAPqvvmhHrulK8RgkIovuXNSPmK4b4633w4kGSN8/ZorMjDNDI2Jbtw5/lho2nQe4rxSDOhGIGgbhvJQp8jXe4NO4pUnbc573wVVYs2W/35zjkgwleZxwiTqkZqgiii4/e+MeHy3oTQaU/Ke5GcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CN8pI+VF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AZYkzQan; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFROC3934196
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 17:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=; b=CN8pI+VFZKtTBZjg
	Cq+3caSimpCLphuXYRweOq0L+SpwoOkTT7DhvHGE61ynYtxsCzKMXMAfZHf8rSVS
	7YjT4j7q0v7Gv4csZy4J9so0EFUXcxiv5dyzb8tIwMmTsSnV/G/3PDerdyGtlB4s
	AzzkigyyPXbk8u3lS70tQl26fqUAWANyZPs7C+1IZ76ZrzQd0wLnncx32C2qJRkP
	RvcaNtTFblLfs5EIZUD0KqF4+vYuibQokVWda1coaocmrMManpwWtKY4b3puIJqM
	EXj1YEFN3l926fUZQWZ2ToODIH4Njjdcydc8NQxsmAhaL52WEb7sKL7jVT/hJ9Le
	7qMdVg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rsdnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 17:24:10 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137f304f564so15437700c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780939450; x=1781544250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=;
        b=AZYkzQanZ9RCdY98KxuFje+QGEP+TyVERHxBS299paoUpMxN+kgAzbT9fevtUoJCKJ
         xSC6BfSbnUlG1kDAEN9hjNmavbSL+ogrVNNCzob1i2omD+x/N1qqApY8b4eatocDLMSz
         bZXk1uZyeIv1VoEEqDcW5doTG4WcBRj9oY7SgyXCmBIEXhj40YR+CQIfpAPk/Ue7FikE
         FR/4UhU/iJuZGq3qP7Nf4x8RxBRR+Y1fyoUqei8dFZ4T16twWe0TWvlgJtJDJEkq6B4v
         c/jJvhjZXPHz+AQdCN7UhzvVuPwBjLcpMnzIQUZvdJzro7F8fyij6Dc2jsgt+bNujsTz
         ok6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939450; x=1781544250;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=;
        b=V2qZS7Sy6Y35aLJvatsUefW0to4MzT3n0T6M/GLKBlmCLCFqz8xvT+p+wsujnq/s/a
         GX/eBUJ0Af0lpFnvdOslG2ZYFZKiYCdtYuQCQAbMIUz7+M5EY/I9qRjjtCknpMvjTQd5
         vIchzktZ/thwyXh6JqLMX3+KNmJydUo8LsPpjADlFGYM58OxxHZGPtfTjIdTCtpS+gbO
         QHaPJAVyDd+dey4MH3tHR1fpnP8rlPOffwOIe+hh8ifzoBroocxxTOBjoKiJT0QaLFAl
         1SD/uz1ZOFMjzIywQYzmq8kgwhjSVfpu2D8whkCgyOAhir/E996EcwCWGN8CVJ8WxUV7
         HrVQ==
X-Gm-Message-State: AOJu0YxiUUZ+xfkjYD/tEOiNmgKAFaR9iredvlTl2eMOV8kqEyJQQd5D
	4M3l8DLpPK5/myQLq+/lGt0njpTIqf/OmdPt6Yw567oY8JBljdFMjlfupJalf+Cqlz58hTWhITQ
	/jvVZsbRm/3W3mbeGBaHaynAzGPsUGnGDBkS65Xa7qUDTGuGUtEfKdv1mCU503oAiRu+cYQ==
X-Gm-Gg: Acq92OGydnnI6bjYSKUa+mjHY6KDe8M3KlaYexM6lLmMNPH8ZxqPtTUibI8x3YLNzTK
	dae8OTCa3lGJNOH1NgH9T1poflgIPrkMyFO/BQm23KCrLzPi5g4u4Tmb5jkPxjFYO32oOXzz0QH
	zqpU0vBE/6m8rFAkqOtK7B4erfHVy77NxtYc1f4y/PgsnqTgJHLjvApR6aQLUowwFrVh1WV6Ksj
	wEhQzXeHYucIqn9wDPrQtwJbUw20/6RSmMLu7s/Aqy/DReEoCHJYUFSuRhpyDfUiftS4yUDET9V
	AIsmWZPNauhya53mMm+0PKy7lPjk3FT2jE+cuzaFOTLNauHzNW9dkDbggat1P+Cdc969JKljfzz
	gJ5wtydBbID/XSM9cCCIdP0lv52iT+bUO77TuW8oRozYPjorzwHod0QleVMfjYHuiDCdSsi/GU7
	HjWpg/qkOcDpZ5l90tItD/K55G
X-Received: by 2002:a05:7022:390:b0:137:6bdb:5842 with SMTP id a92af1059eb24-138065bad3dmr7705747c88.0.1780939449755;
        Mon, 08 Jun 2026 10:24:09 -0700 (PDT)
X-Received: by 2002:a05:7022:390:b0:137:6bdb:5842 with SMTP id a92af1059eb24-138065bad3dmr7705716c88.0.1780939448974;
        Mon, 08 Jun 2026 10:24:08 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm12449060c88.0.2026.06.08.10.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:24:08 -0700 (PDT)
Message-ID: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:24:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in
 ieee80211_register_hw()
To: Dawei Feng <dawei.feng@seu.edu.cn>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
        Zilin Guan <zilin@seu.edu.cn>
References: <20260608145543.3443390-1-dawei.feng@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260608145543.3443390-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AlJO7EOvK06-5toK3cWqroODHa_69XBz
X-Proofpoint-ORIG-GUID: AlJO7EOvK06-5toK3cWqroODHa_69XBz
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26faba cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=ceM9LITnlY0sHtZh5UYA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NCBTYWx0ZWRfX7Umx+AbcCEH3
 R6b05EMTwukUVQti95Mv+Wqv14vX0T7S4aVJPJ63sBngYPQIHg6/JR2KO99ZajIUXRPitMu6Wlf
 M5tWZRzDzAkkva5H2OTxc1UPVBak7DrO4sxjn0iisY1F9KubqlG9yqCD8jde4gXK7mFt/9un/Jx
 vYud4zMSg3eE2HHViTPXu138zJl9q9OSxpZXGWs71rjZv7VItl0hDQAqF83qv5MkrRo2nqMTeZg
 KdKodOqQxNeC87kxKNUxHYZfQIhYgMLU9SwW3QoNKfA9dEakTuqqHmhFPwIjhTrXGlwsY/658Ws
 Mv0R+PHzeyu3sDpTFzWSPONF9F+obANayrJDCezpvKu4egRyLL5fYvHEhhX8kxiH+NyU7gZaAWn
 7U+S9TzcOEGqCH+ZVV1Wi9slIuHPJ81lzx8bsr6M2fKYoysv8eYzRp8NVP1UYWCF5Qm1b72cHdn
 5HeEJGbrtrQdhQ+erXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080164
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37536-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,seu.edu.cn:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3D88659446

On 6/8/2026 7:55 AM, Dawei Feng wrote:
> If kmemdup() fails while copying supported band structures, the error
> path jumps to fail_rate. This skips rate_control_deinitialize() and
> leaks the initialized local->rate_ctrl.
> 
> Fix this by redirecting the error path to fail_wiphy_register to
> ensure proper cleanup.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc7.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> suitable mac80211 device/driver combination to test with, no runtime
> testing was able to be performed.
> 
> Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

why is this SOB here?

> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

this is the posted author of the patch, and this patch hasn't been posted
previously, so it is unclear why there is an additional S-o-b

> ---
>  net/mac80211/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index f47dd58770ad..9306e0af3b5f 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1599,7 +1599,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  		sband = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
>  		if (!sband) {
>  			result = -ENOMEM;
> -			goto fail_rate;
> +			goto fail_wiphy_register;

I'm wondering if it would be more logical to have another label at the same
place, i.e. fail_band, since it is illogical to goto fail_wiphy_register when
you aren't performing the wiphy_register function

>  		}
>  
>  		wiphy_dbg(hw->wiphy, "copying sband (band %d) due to VHT EXT NSS BW flag\n",




