Return-Path: <linux-wireless+bounces-38871-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pTIAO6lVUmoGOgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38871-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 16:39:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F8741CDF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 16:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kZm3DDMD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZXVE6Dke;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38871-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38871-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835693024A58
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CF2C21F2;
	Sat, 11 Jul 2026 14:39:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629832797AC
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 14:39:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780767; cv=none; b=E328LeNU6Ku7uptSv32rS0CbM2LeVDZasYEXcC3vJACFz3qQ5YrAg9/7JC1QKfWuGxopTW3jDjecJdQ/5ylm7/gBGkKn0GFiYY/xZ7UjK5NlDfHrZiYjnbs8APyz2m27ekPr/rnaai/dzINKaXZ051t10IZdakZbvgz0BrAa8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780767; c=relaxed/simple;
	bh=bHJSREHLOyeJy4p6jBRHOGdQGuFnsieQsfyomvA9tug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBpZxxIfoD+wUhSlyjEutPkTRTJB/JSUhePake/9iVx1lwoS8M6F3/a60yE6Ut+PIPwoRWeXblwxla+ksswSYDiSvU94v+qLs24flplTTJmUBNLUxUVqPd5UdQFy4fGq74mj3ryRoPtIgekY9CLHQ36d9UHXdTqnDv7PXWJwH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZm3DDMD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZXVE6Dke; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEO7u63980326
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 14:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=; b=kZm3DDMDw6zlPf8G
	+52iH2A4kfZ+Y20FnRemYz572E319RGziefo+z9NRV2jvM/1Y7t49jOOuUM30GXn
	g/4lL/p/wLMgP3/PJRxCxIjq+rsCNNcyHTzjsnrSuoi7pAZIz5tbbHY8+s1H7yg9
	1E1aQgKcMy0TtL/va+D/DTEHro8vXnm+3l63vQ8SizjjNXJFV3jE8o4EkcTVV1xJ
	oRvxEYwx/n8mh2lSBhsEEdm1ZByHCj+UlW8fpADqE9S3znKr5Ps8bQcCGDA+941y
	8LdnEJHH0EDfAtQl4ju+Nkwt/U4irjVBi0roGJync+yehisIkGNrftdJbWzOjPuv
	kZgp6Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcgy5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 14:39:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c890bac374eso3736189a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783780762; x=1784385562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=;
        b=ZXVE6DkeX6ARqvfuPqiP0M5tT78+SkSCvzNWOLnMO4810cKdowqZz4FQ37x3+3lWzd
         uWetNk2tzi+x7FPe0uwHR2vGVh37KLf33o2TXYamsuS891ftDynHTQm4AflIt+FJi28q
         VjTXp3LqcN3BHqe3Mxuh6/SvSzvSEUK4IFOrGcmTiKIVgjYEyYHXUBOeDYndPe8YrB3T
         lS+oFPOMjfFLz2oj04DvtWZi+KJe0KmnhRuDNrB6WNmwNbp1DTHaUHWfijnHRBey9nnB
         N/cLWvLaJxjoGBXGC5JsyhZVoQmlyGQcwTpIor9xhdoKh3jtcYGNAEzwayfrHVF5GRe3
         Zt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780762; x=1784385562;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=;
        b=WqrtOmRRgBkQtEBJm/2WUiRoYIMatmjTiEp7nvcvHCEFpR1n9CXVdijdHFf0yEAb4g
         bXaY7nyKMDD024mtAY2focM52Z+HsP9AU77fWZVBQcFqf1A1NyR3kv7n2kUde5t8ef5Q
         PIA6/oy/xhval/DQNqzp8zaUpQVLa3nfqH0fy/+66ylmDs1yz2n2mQ1KefEWCDZQGRSC
         CNm5ZplcfsqHrlbXtp9Cd1m4BTG8Tg6Bl2h9FAx7yUuLomXRMLST0Zm0xKZD1S5NZ/tb
         Kp9egE2Hq10dckElZ7iC0I7bT6/y82yT10jFq/5a6czkBPycv+abGJRvW4AWyA5L/IH6
         35ug==
X-Forwarded-Encrypted: i=1; AHgh+Rob16FWgvoJP/meZSH9diJ6N4dEAAtgeUUG1CA3XDzvZy3mQDLYRmoPTuG44q68DSxkZB311G9EIuY1mIqYqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzesKvl8TLQ3E4xgfexJgEZjz7uIh9HeQ+tpshmyBXg8OkIRo
	nhQYRIxExVncKg3gFLWxy6vMMLMFJ6tA1rEL7kRSrotrRJ3psVIF6knM0z4ysMDgFzKBjaS428G
	mrMe8qTu8j0e5qad2K6NG5ogXkxKWzDnCEv4hxnVf2MYYJz+EIFJGsU3eBR7Kzgp6AKnNiw==
X-Gm-Gg: AfdE7ckGLzdDURs+IIYqApKovTolVaAEFgNjDGaWRvCvUOK9AAwYi1a10KJG7jApgw1
	Hf3YrywJcjEniR6tx6usWQlf3Ckz+xFBjGmf93HNQntL4r4+t2TKd6EgQUffy068ok1mXk7bIMV
	JN5lZa6e9cDyuy038kYFN8GA5ZpVzFCA6lIlNwRUSZPygFBmOvHeAg3ZgYkPnbmN2ITdxRv6doB
	BLSb/J4JkIAOIM2xwthlF1ogeP6vxTHAN/IgEWmKq/AxdqCO7kJZk6xhuwNmUDUCK7di56I3Ucd
	9yPok7pagZlDImVg5rU1Y1+VoWNsTw63+mI1QVhTUs6prBzFXJx/WjfKG/mVUU1nmCqvaHjJd/g
	WEmdhoyZfe+TyP/zJRYP2mEGIb2k7BBumWhKT/MPqvqtrg9oxl2Yktg8xwSAaaaMNJf7j
X-Received: by 2002:a05:6a21:d83:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c110a1b5b6mr3074874637.57.1783780761702;
        Sat, 11 Jul 2026 07:39:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:d83:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c110a1b5b6mr3074849637.57.1783780761218;
        Sat, 11 Jul 2026 07:39:21 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm11166393c88.4.2026.07.11.07.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 07:39:20 -0700 (PDT)
Message-ID: <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 07:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: Doruk Tan Ozturk <doruk@0sec.ai>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711071336.58324-1-doruk@0sec.ai>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711071336.58324-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfX3b801QAHESKm
 j79/l44TIttns1UFTJJ2t4kc0fPyt4YI+GLOEtP619bQFm+lfFvCQdDMAt9aLPMBW9ixSn+srbx
 JpE7/W+t57WLANmkJjHUYf35CUxN3PhP5+GFDysKT5ngJYkVjrLCPy+TsdUUmmGMWcYRW2vbkJk
 BX5V4dU2nFxBx17E5enOcWB3qAZyUlSM94I8EXlTCNptFvBBYVGu8/8CAolXBUBHWxzI/dyeEIS
 OLAryRJhijMbx5o3bwaGhhg6/oQE7cs4q8xBeT27kX3AbtNQe0/3UpEIFasVaB04U7SS37rtGBN
 PGJGt1LloE5Rkt5+3QZulxuwNIDHIHbIUT27xFvwMUy8OAljGVO904vXwE/MnuHxPN4EelqHA9A
 bAigZ7RSULnAp1A3MI1FgY0AghKxQKyaNXTV2gneX8b+7f5/nrBTwcjTwDUhCZ92bdwnyAKgrwj
 pTA4Rs/HyBdDEh3mqAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfX2Y5yWqeUhbN8
 RpMPCWN8m+NWwLyCNmtnuQlO64oiRPdBjSBf/O/rlficTKz9/oZsxSOd/h59WaaPCu8h/8iJhGm
 5mU0xvsyBEB9ES1UtCdyEUbgW98EbPI=
X-Proofpoint-GUID: CP75C0YQeHxG2_Lc8g1CGQH65_wGsCMB
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a52559d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=skqKI5o7AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=XR8jsSC4JSa_CXHFb9AA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=Cs8KYam2t1nZR3VcZU7f:22
X-Proofpoint-ORIG-GUID: CP75C0YQeHxG2_Lc8g1CGQH65_wGsCMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38871-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:peddolla.reddy@oss.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 928F8741CDF

On 7/11/2026 12:13 AM, Doruk Tan Ozturk wrote:
> ath6kl_wmi_connect_event_rx() only checks that the received event is at
> least sizeof(struct wmi_connect_event); it never checks that the trailing
> beacon_ie_len + assoc_req_len + assoc_resp_len fields fit within the
> received buffer. Those attacker/AP-influenced lengths then drive two
> out-of-bounds accesses:
> 
>   - The WMM information-element scan builds
>     peie = assoc_info + beacon_ie_len + assoc_req_len + assoc_resp_len
>     and walks up to it, reading past the end of the event buffer when the
>     declared lengths exceed the buffer. The walk also dereferences
>     pie[1..6] and pie[1] (for the advance) without checking they stay
>     within peie.
> 
>   - ath6kl_cfg80211_connect_event() subtracts fixed offsets from
>     assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
>     bound. A short assoc request/response underflows the length to ~250,
>     which cfg80211_connect_result() / cfg80211_roamed() then treat as the
>     IE length and copy out of bounds from the small assoc_info buffer,
>     disclosing adjacent slab memory to user space via nl80211.
> 
> Bound the declared IE lengths against the received buffer, bound the WMM
> element reads against peie, and clamp the assoc request/response lengths
> before the subtraction. The sibling wil6210 driver already performs the
> equivalent length check for the same WMI connect event.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing bounds are evident from source and cross-checked against the
> sibling wil6210 driver. Compile-tested.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Some aspects of your patch are already addressed by:
https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com

So you will need to rebase once that lands.

/jeff

