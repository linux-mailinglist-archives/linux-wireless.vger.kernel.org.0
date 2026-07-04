Return-Path: <linux-wireless+bounces-38623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E7BCEpRjSWpl1AAAu9opvQ
	(envelope-from <linux-wireless+bounces-38623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA27084B7
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="elEA/Ldl";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38623-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38623-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FBCB300915B
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479C2264CA;
	Sat,  4 Jul 2026 19:48:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78887282F01
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:48:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194513; cv=none; b=eTf9xP73LUq4SeekXCNj+XfyfFuojc04H8CUL6MAnF/YQ863I/Idw6krI/EW8Lc9mNYS9nt0Fo3uYEIM1GbwCVZLX55xYOlRDrW1A1hcjWliXvMmxU0tXe8vLBKIPVwTUMTqB0/nLwNoyUhMpV/NpHohcP8zgtAmCETjXz7uZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194513; c=relaxed/simple;
	bh=+TO/qNl/0FdIFuKVmQ+xVp/v9nqEpZkPw4eUZgFqTbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKgc3mNuvzAc6WRdO4GfyApmkK6cCu/C8N9V8PCR0nP4juIEoLEzEy2uFa7b9/C4FfGoqfqEtjU96CrIXNshl7S/lcmlRy1KjPIoNwZhwc2h6eI4arhMS0KcCsZD7S6DC1ZsFEC/OfEW+ALXmVVmuwHawrZBcR1cX/DCN/RCU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elEA/Ldl; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c19bad03so14658785e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194511; x=1783799311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEyqJwfyH2jgv+Eu0NdsBWQhxvi9pBURuWdxLLJyU20=;
        b=elEA/Ldlqs3ZSefXbR+6alF5CrW4gbGw4WXoVOe/ejRJwAI+MGxpgRkEq2F406VQK/
         ssrKgOwVKx/4Vb8ArzibwspQS0KjHL/j8rkShaWu5N5aonpuMd8F+WVsvmniV9GXmqHd
         Zi1Cj2/aESkp49KDXiZ/oLl8OI62RVYJnr+9lL9H7AiCIZnihPBG0Nt3UrOkGw6YQlpb
         Wg5OrM+kv0+emd5wmiAjo7Vq0R4C7OAGzbkkV+JBAWkt4g8fuSt11h3ughJmY30sRgvg
         g3ORp3QffDgWM+f7wfbEq/PysPph8TVLKWSC2w/SMAJ0Eo6Jvyz6dVNrW7Bhwtu4h2I1
         Mpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194511; x=1783799311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEyqJwfyH2jgv+Eu0NdsBWQhxvi9pBURuWdxLLJyU20=;
        b=UHDKRqhcoZGShg8CZ5bLhSlT5ISRCZBQrC4v8sS2J6YJGMpq4FFxkgRovzZQvnIdZj
         yRnXyQmdvF4FFVUrf2ck6U9Ad6xtHqzL2WTzwZW2sMMuc9lYEoLZ8lOpuEe+5n+JptTC
         t/G+8mcD0Av5ujUyuDx/4uRAm0H7hAAfsrb5D9ERkcjcKf0tmqmYC6ewKIH26fRl88NL
         u2vooIQzLJJzc2nPdHG/R38dMq5Cx8h41ceuEg3ufVy8COciF+YUZNQJoFelTm5NhiOI
         NbuPkMYK2Clk/Uz3fmZ8nd0ccYPDJAL7ExuTUtTwaG00Oz9zVwCwqHOrh00bHj3sVV8e
         1QOw==
X-Forwarded-Encrypted: i=1; AFNElJ8BcxVmFt5RTab9wp6SFLCNMGV2DK+Tc62JWIUJuL2uUpvxFogJTRwv/dz3LvvAvuR88HYUjti3fHQ0Xwdv2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8F2EMPNSe96ZCunVRpT+v7CknqcZBPc3/QI1EcZgo8abp5uE
	LCIQL2ZoErgxgtti2Ey0RDd5ht6aI7AbvNPn0z+hhcqTIxF/2XVO+EPf
X-Gm-Gg: AfdE7clyHJtc6qyZuJiVa9OMsUoQNAR9+uHXiPKvSkAKk31W6WySn28rhuTaLbeTO8x
	tmLZ7V/tIAtXN5qHzrpJLvvpaiStFoNtbyZk81rg+0HAox1Y//DGlV16fYrnay1yjgwdNxsHmZL
	RSPyST1jkefWIelmWJvu4JQaQIpfVO+w1ZJVqxRsONi65CgHWEqHprC7wwyzkIKC9CknvE6pszB
	KE85kKWYFlEDmFviatr3fwX1KvkdDj3nvvAfS/10AOrK7RFzJvds1yuoXqvHKYhHQPVWTgQwSGC
	IFTKpOJik8LpJF4wDRm+42RsendzWPYi2oyHUK+b3KEYXa3RfjOreh0GVuIscpuRWVcrZ5gNCLv
	JEl2ud7I88xhkVVSfxzpqDMjIvv6bpynmMH5MD8bzl38R577nso3HdUWZAW7dJYv3tQ20R8m+IW
	ogb0EPf+taqNCfMNhUR78KZ3RZXdmNUDiZhDvZI02ZVL7MBpWA9nfP3wytRXpYidbHdATpPSHoX
	KPTAgZqPgQ=
X-Received: by 2002:a05:600c:8711:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493d11f15c6mr45985435e9.22.1783194510915;
        Sat, 04 Jul 2026 12:48:30 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm264034355e9.15.2026.07.04.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:48:30 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6Ll-00000000JoV-1nGR;
	Sat, 04 Jul 2026 21:48:29 +0200
Message-ID: <e6cd0ff1-a715-4a6e-b5b7-175ddbc9b2d5@gmail.com>
Date: Sat, 4 Jul 2026 21:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: carl9170: fix OOB read from off-by-two in TX
 status handler
To: Tristan Madani <tristmd@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
 <20260421134929.325662-3-tristmd@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260421134929.325662-3-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38623-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20AA27084B7

On 4/21/26 3:49 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The bounds check in carl9170_tx_process_status() uses
> `i > ((cmd->hdr.len / 2) + 1)` which is off by two, allowing
> 2 extra iterations past valid _tx_status entries when the firmware-
> controlled hdr.ext exceeds hdr.len/2. Fix by using the correct
> comparison `i >= (cmd->hdr.len / 2)`.
> 
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
> Changes in v3:
>    - Regenerated from wireless-next with proper git format-patch to
>      produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>    - No code changes from v1.
> 
>   drivers/net/wireless/ath/carl9170/tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
> index 59caf1e4b1589..06aaf281655b1 100644
> --- a/drivers/net/wireless/ath/carl9170/tx.c
> +++ b/drivers/net/wireless/ath/carl9170/tx.c
> @@ -692,7 +692,7 @@ void carl9170_tx_process_status(struct ar9170 *ar,
>   	unsigned int i;
>   
>   	for (i = 0;  i < cmd->hdr.ext; i++) {
> -		if (WARN_ON(i > ((cmd->hdr.len / 2) + 1))) {
> +		if (WARN_ON(i >= (cmd->hdr.len / 2))) {
>   			print_hex_dump_bytes("UU:", DUMP_PREFIX_NONE,
>   					     (void *) cmd, cmd->hdr.len + 4);
>   			break;


