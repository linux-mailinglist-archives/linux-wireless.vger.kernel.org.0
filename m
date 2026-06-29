Return-Path: <linux-wireless+bounces-38256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VbcpBvQTQmoszwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:43:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EB6D6716
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=J98OyT5C;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DiawTlht;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38256-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38256-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7487303CFBD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C6374E59;
	Mon, 29 Jun 2026 06:36:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158038E8C4
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715003; cv=none; b=plmi6Mbw29lFguRQsI1PJlMy8eDEa22G2d3lFKmn7zXwW09wLLnAsOe2RAVImZhNkxNoECwnnLvYd6+A44gZc5M9by0OF83eoKAOposZTgZEt80IYpMzSWmzK9ZNcWu9qDjKbcKbrYQSzsi74QV+0Uen/C0SFCVsnX2J3aap8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715003; c=relaxed/simple;
	bh=SkTJsjyrUIn1E/V2HysHEq585Qhg3YCQ+POlIVjqdpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmkQYttbnNeJEPka/J4wUGh3PdOFE62ckFPVB8fQlON7nB3+C/BXkUtcch25tKuI1fN0a9tLNoDCZCMr0p1dJvN6t8bXO48zAlmSvMnKsmGv4mySltuFyhKx2V7BOa3Q8BlTK8W2xpcJKuQibOvaBUr1ADEum3/feIio1qExVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J98OyT5C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DiawTlht; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NEwK1729595
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HM8lP8cbt6M1lCvcZau12YSvlKEd24uCMkhWjkkX3l4=; b=J98OyT5C8ZOPMBDy
	y2Ev4mX505ZUot/zWoWdOoi3fn1uQqOZQXpw88o3wlDf2WRf5qWG3G0/l+6/dD10
	nFQ4YAJCBKQVqrsBwMnZjCNDclYa8VEwtm/L9byu659LlfE2x8Qepki4niVv7KO3
	UdhrNsLLqp0eLfZaZ3kacc2Mw4Ny0x0kcbm9px5OkitNVR2ud1cesKX7csw3FVs8
	y/tOx65AvDRJWEc2ldAovJdDktKWqG9NUbMh6q7fqtePDDMw+lbIhFGfta8ih/8K
	dDkMY+Vzdcc2hcGWThpZehSIZS7PrwP6eFmTMYOL8IC319fzabaC5Hw5GvgLbdXv
	m8EAgA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7vtsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:36:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847950bb95cso60416b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782714993; x=1783319793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM8lP8cbt6M1lCvcZau12YSvlKEd24uCMkhWjkkX3l4=;
        b=DiawTlht2iyOAPvnoohb+tuWnQ/v2NxaobhBErxBxMgZ7YjzZ/MvgdJUE4QjRoDJi2
         1+z5JLJ/xvW/TS/WphVhSGUhiDnUhjCbhNCb6Vs8xsBSFGFRRKfzD79qVPqcByaRK172
         36mnkUqsdXlCv8+aeGs73DLmP8mnSUiZ8JSerc235bf+CQpq+VC0kujz6a5LdGMYk/dF
         6iuXWIlSiExkW2YtiNxvqBLGFPhUUVwJlW/wR4rbhfTKRUZ0qlGGrwCwCk24BTpwxVSR
         AQlABVFPyGggxXPJ/7SClT4Ll566Mos72HhvKmaa2eV/peR9pRw+D1Oun4DVED2l8h8f
         IvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714993; x=1783319793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HM8lP8cbt6M1lCvcZau12YSvlKEd24uCMkhWjkkX3l4=;
        b=OZMg/X+xOPULIa64hdLCzaOM/3I71bIHcA8s9Rk7O/NqPxWAKlFW7iRS2lgkqKA9/e
         BnULR3K2q4aDrxHMecQMPheBswb0usnLdOcDxa/jiQX+nrAhjA9xbe8BhRDU22yXMovp
         5/R19hEDssrqnF4CNx23s/rnyGUQgbcPRnn16j70epUj6RGw6gizFKVSgxO68skUsp1Y
         02WoJRX11vvG4lElQL0rYfifJ8yl3zCkUX0pdolh52cc4R7w1gtVkb/EDf5fmDx9l+ZP
         vN8h98HmcYTxSysvGh0oZHYW0nKub8mOIxitGsR7M2p53jptUOKYUctjlgJcatp9S+NG
         gpjQ==
X-Gm-Message-State: AOJu0YzRngvSgEFjIJSEFtc0ZZbKgmrGf3pncHjJ9M/ZTMh+0k04dW0O
	0qBC9GTtGtDPMu7XhVqR4TR9atV26Y3EblLZN8rlOPgPldl+grOsttBEqhoDeJAy5vJOwzG1ES7
	/3lg/nHiZlJ+clXgQGIa52/emS1qfx7vimimRuwlje3Eqb0pICrLMGeX7z7TmBC5rwYVP3Q==
X-Gm-Gg: AfdE7cmMxTvKu6oUMcm8KvVz6scyi5FrSWZzlzHUx138nY1f+ZYkDZHmmdlwrpJDyEY
	OaYZbxEfdVsenVBKKxvSibHQBhAiCggUCXYDzzjd7AXhojjMqNuPk8kWCIi15CCry3vX1NxOghH
	2Fg1oCiELRJZwzhIf2nXYIG78//XeMGu/Zcvmb24fMamumLc2+FywA31ONhtz5o3y4Y990jMYIA
	esCue5n6sFuurqj10VdKfA8ifDr8XSF/x+NzStbGvfEOGMtBQaVc9NqeSh/8/+4iQpRmNTQ+r+7
	/o1SdjmESXmDpRghsj+OupYxn7Xni5gw9cVoQ51tDFPxc9oI13L3V3H/zhpZxIt2cuQ73gwWLGt
	9uyt+zVgipUPwf7EbFLBdLS9AKzfr7GC2R2GoeVw=
X-Received: by 2002:a05:6a00:2291:b0:845:eb88:3d74 with SMTP id d2e1a72fcca58-845eb8863d4mr4183883b3a.29.1782714993432;
        Sun, 28 Jun 2026 23:36:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2291:b0:845:eb88:3d74 with SMTP id d2e1a72fcca58-845eb8863d4mr4183861b3a.29.1782714992971;
        Sun, 28 Jun 2026 23:36:32 -0700 (PDT)
Received: from [10.152.194.17] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847849c842bsm1244667b3a.33.2026.06.28.23.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:36:32 -0700 (PDT)
Message-ID: <07dfdba3-d769-4102-a19f-55086a19cd30@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:06:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Improve dp stats
To: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Content-Language: en-US
From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NCBTYWx0ZWRfX6R/m7mO2BKDh
 /oFdg4dmhBQXJeZOMfXJnVFBF+o/4kGkNohoIS1eTGTdRWDn0LllUGdo2DbGme9kQnsMURNbjqs
 1UPGbL7lfc6ia5dABk9lSge9i2puN4WPPlBWgBpl42fQTxl93KBgOxvFyfNVHwqLZi2zG7l5SQ9
 SKcs/7C51mDrvPEL6Te8ufUNPQaH+tLZzQ3fN41nKtWvK+EEJkUf81P4VHazqVtPGjpCRPOEq56
 PlJS0KlFm1vBwA6oqtUgaCOpvSSCPb7DZUoqUIRHBoXfFuBv8fzMWWC4snFXGQyglpUCMposAls
 evQ9OD895qfjxYNzmd/DtoszoLPW0E3d0juhs0VK8z8ujArLAC1Q+UWCypxgXHrOoiOR1CKc0gO
 xEWl3qJ/nNTP03WVslaImkbqjmRLnBYSm/OKRsCDBtOLN/2LP0YsENZZGsh6GOqAaqPh/4UyVqr
 gX3UwziuaebHyP4lsog==
X-Proofpoint-GUID: 7Kuc7tBBeoA_OP4hrncCADmIUs_0Cmg1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NCBTYWx0ZWRfXx4c5Qg5GNaRG
 p9zWKG1w+k/GOXIm0qTYS1vUJZIykkuFtLhAhR8EcxXKpSQzfHJfo2glRlj9JYOlH3H4pg4pm5b
 VwTpLPYgRa25DHs0VaXjxLh/wZkbzdk=
X-Proofpoint-ORIG-GUID: 7Kuc7tBBeoA_OP4hrncCADmIUs_0Cmg1
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a421276 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=w1hz04t2yJB1brSwPtAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38256-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aishwarya.r@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sreeramya.soratkal@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.r@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 692EB6D6716



On 6/26/2026 2:22 PM, Sreeramya Soratkal wrote:
> This short series improves the device_dp_stats debugfs interface in
> ath12k to produce more useful and accurate diagnostic output in MLO
> configurations.
> 
> Patch 1 fixes a latent correctness issue where the REO Rx and WBM
> release error tables were unconditionally printed for
> ATH12K_MAX_DEVICES columns showing zero-filled entries for device
> slots that have no hardware. Replacing the compile-time constant
> with the runtime device count keeps the output compact and correct.
> 
> Patch 2 prepends a ktime-based millisecond timestamp to the top of
> the dump. In MLO setups the per-device file is to be read
> independently for each ath12k instance, so without a common timestamp
> it is difficult to verify whether two snapshots are contemporaneous,
> making cross-device counter comparisons unreliable.
> 
> Patch 3 extends the existing per-radio section to report the center
> frequency on which each radio is currently operating.  This allows
> the reader to correlate throughput and error counters with the channel
> without having to cross-reference iw/nl80211 output separately.
> 
> ---
> Changes in v2:
> - Rebased the patch series on the latest tip of ath-next
> ---
> 
> Sreeramya Soratkal (3):
>    wifi: ath12k: Use runtime device count in dp stats display
>    wifi: ath12k: Add timestamp to dp stats display
>    wifi: ath12k: Show per-radio center freq in dp stats
> 
>   drivers/net/wireless/ath/ath12k/debugfs.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba

Reviewed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>


