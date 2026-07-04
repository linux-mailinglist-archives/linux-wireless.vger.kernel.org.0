Return-Path: <linux-wireless+bounces-38622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzXfF41jSWpe1AAAu9opvQ
	(envelope-from <linux-wireless+bounces-38622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F297084AF
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Piy9M9z2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38622-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38622-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C5523009175
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BE2C0303;
	Sat,  4 Jul 2026 19:48:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31F2264CA
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:48:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194505; cv=none; b=IyaGEyACcf1Pto8U+b6YLwIp5pTtXGEvr23CGRMqnJnfpQTk07zAhaLiAU3PE4qQBKSNJu0SHJoC5fmU1at5zyeDp6YyoZcsczUC2pRnvDqUuIoGBVf3w6iqqZm6JlYdjubLD3I98IIXIA531FhtK+MuPTbCh3Ltos3lz9yY/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194505; c=relaxed/simple;
	bh=IwJ+wvk7kB5TZLk4OyHhlW2Zy1qE0t2FKImu1jcru8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxLUt51u/MriExn1GTSdFf0scOmS3nV+9yT6T/f0haz5lf1/pwTdozM+Bvs0Ig4alolw0xjOIqxhwrimIqaAnXHNUCLWbwMFFUx430AzYSqWij9z7YvIUdhoUDS+jwxs2P/KRh4MW1xY9apr1rEBwMQEgopuUMB2rID9QYdAIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Piy9M9z2; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b779003fso7865545e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194502; x=1783799302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kREsOPDfNFErk1qJgbzlZaBpqgqmcQBNj8RDdAgPTJo=;
        b=Piy9M9z2bpltvMf9cn/dYf4mkfKZifW3mZx9s6YeApHO5jdmFLcglxTrOgsR7Qq6sO
         DPzH3A+FgX/6Ydx/3mlce2haBmcbKeGxQFx3FLgWDU4SrIFpX1Xw2QUHOIcaUCr7Z5DK
         6C8u+bZRyoN5fSCIDj5LPrIxapKW6lvpqHB0+uGk2gdlhW9AJfcoGZ+twltfS4P9i3Yx
         /ILutTD4PzqoBnlH26HfQT6lGiVb3Tja+oUAg5dhP6/i8m+lhHbiehB8PSlcNvl/QFGJ
         +LogO61WonKfncHbIQLEH/FKcWJXYYGGzd3w3WcEzZaNLDzhCYn0zvHzl4gp8J4lwPbT
         XKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194502; x=1783799302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kREsOPDfNFErk1qJgbzlZaBpqgqmcQBNj8RDdAgPTJo=;
        b=oo88QfB3A8Aqmwbsq3ogsArDVEcYy32Ye7uUcTP+2Qu+zL8b0Klkgluoz+yLx+lRbs
         njxuKqjjxZbTReEQnuaHX+ZFSvSNcEk31KgrcBquNUq/+/G6yNZwYSXe9/dn4DfvIHnS
         5PsJlw0ei1EmH+ad8vxRgIhYdZA3AeHv2ucPW7+FbsfmEoe0aqAd909tj2D2QM+1Rah5
         DjFPwTsS4UqzfvaAh8KJythHSMSiUEk+Aiimq9GYJO/b1HehvIET6P+0FiYDFqJjtWi1
         CtoNrZcG2Zn3jIJATJ7ZdqN3VDyeSBtbO8lNec09NPSPc74dAnPA652f+DQyBB/r0JPW
         HMow==
X-Forwarded-Encrypted: i=1; AFNElJ9Zw79cmoRkrg9idtgD72obzJ8cW7Avn/PjPWma2RZ4BUTBNKHVwvcyXcgRRxEiXXVtC/zAnsGEehgzi2kzqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvu4PZ7Rpugf7o2AilDUZ13cF/dS1Yxl78U+JZDt5sd3706kn2
	M0JvrX+gbKqnR8fZISWKLfaXbw+nbDuBdpDzuVzZcNisdRZVVzE3qlCj
X-Gm-Gg: AfdE7cknMrVa3XAw1kwQ7i294tShhH/WsqHrLlTMoaWrdvgWqRZQzWra2qHGKFE1rgd
	p9KRi6x/xuAN11484MYUZTpGZPFxeNPycoPUg+hunA/OmNE2QGkn4eqsiXSDWJrwRz7V9oHJa54
	Ve9h1b21EYCs/t4aWYdlMY8ch2Cy3cIsqS06lD3O/kc6OQ18yFVAo+KQMD+P76rbX1Mf0yq9lsg
	dLlkzDk5VO1SP5UaJd6Kbgu88OwgsSf/VfP22B2Agmwax1jidV0yMh4khuAVQSZ/cSX4N6SYl7E
	t3W628JTfy95MiXnbbzUHXRB2e4t3dUsmAz6ifJXaQeHeyn1cbUpW0sRxxTwpLSSuT12tf1Jphk
	lJYXBn4kjA5YaDcctpjm7WvN4SPfmjB20jCIMXjyf4IkDlLvHxb6Hxm24LRj6OJeK8odTNs3+Fq
	zWos9GQK+dtFQOSZb1Yp7zwoR63PEpDWCaMXO8nWSTJCIc9m2W0CHGZk/RytqUe7xeo7xPe111X
	fEgor/V3jo=
X-Received: by 2002:a05:600c:8708:b0:492:4911:8a with SMTP id 5b1f17b1804b1-493d11db676mr45087455e9.12.1783194502227;
        Sat, 04 Jul 2026 12:48:22 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm404118485e9.0.2026.07.04.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:48:21 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6Lc-00000000Jo5-0gFR;
	Sat, 04 Jul 2026 21:48:20 +0200
Message-ID: <9800b46a-1d24-472c-8f94-eb54386c2605@gmail.com>
Date: Sat, 4 Jul 2026 21:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] wifi: carl9170: bound memcpy length in cmd
 callback to prevent OOB read
To: Tristan Madani <tristmd@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
 <20260421134929.325662-2-tristmd@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260421134929.325662-2-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-38622-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E4F297084AF

On 4/21/26 3:49 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When the firmware sends a command response with a length mismatch,
> carl9170_cmd_callback() logs the mismatch and calls carl9170_restart()
> but then falls through to memcpy(ar->readbuf, buffer + 4, len - 4).
> Since len comes from the firmware and can exceed ar->readlen, this
> copies more data than the readbuf was allocated for.
> 
> Bound the memcpy to min(len - 4, ar->readlen) so that the response
> is still completed -- avoiding repeated restarts from queued garbage --
> while preventing an overread past the response buffer.
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
>   drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 6833430130f4c..f6855efc05c0f 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   	spin_lock(&ar->cmd_lock);
>   	if (ar->readbuf) {
>   		if (len >= 4)
> -			memcpy(ar->readbuf, buffer + 4, len - 4);
> +			memcpy(ar->readbuf, buffer + 4,
> +			       min_t(u32, len - 4, ar->readlen));
>   
>   		ar->readbuf = NULL;
>   	}


