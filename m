Return-Path: <linux-wireless+bounces-38624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LacWAKBjSWpn1AAAu9opvQ
	(envelope-from <linux-wireless+bounces-38624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A71B7084BF
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SPTLu0Ca;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38624-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38624-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038CF3022602
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF12C0303;
	Sat,  4 Jul 2026 19:48:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0E2E2DD2
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:48:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194525; cv=none; b=l7Zoq1NVXlPHJY6Tyfn5D5ikwTGIcv8SA90E8+zzHjGUI35Z4PBXob1BXsN6d/mm3v9k+w8W/aDzcHlqBJO0pcaWZHzlQnLr3fakBWukBAvARm5Rtb+VVTRI4yxjZ0JlRmTSo+OXGtqK+9xMPPpPxr9hdbYVtSumFqEqi14PxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194525; c=relaxed/simple;
	bh=DjnuPL2bW88foM2JsjICeRBHpRdyyJm2pS00YULmmkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfoSulWlA97pZ1PeTpFNsBw+Xv6uJWDjYm17bGE1fkc+LQcquQXY3XAM9jsuC5wDhMcvktX/TZHz5g7Z7aWq5MbC72/y6AjZdgjAjURXmlO5/vw4X1YabPvQeojc6Wp305WVwl79SVJqNi3qq3x8i9p0/LcbO7+flUISMXmrmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPTLu0Ca; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so17885535e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194522; x=1783799322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jajvi8AVqAQfTHFADtWCFML6DSVMe8XFUK0J1hsMK+M=;
        b=SPTLu0CafzNMLpgd75gJ/8j5hUFQP+S/b0OolPxvK7xQwvSJySBYt365+dTPY3ff/F
         i86gPeaqp9TGiI5bQySk97/O++ZptIFGpWTI9hZ96YdsLG01ki/p7mwqQ99Wb7wRW0sA
         QEyTfBkUPg0tFJiF0DWdLbsAUuIQv6UUN6iWmX/ezNlM1UDc4llB00w0cmVnc1R6ZkPw
         ioKnaCSvHpEzVj3X2BynPMTd9ukYsexVxidfZYs3p8gB5eOwaNnXH+xn3XWojz+G3CHW
         N7rWJhNV7bOOoPhLjMhBM8tSNWHL4NHDl/OAAyYDpMknMsM8LbAjXMfJC/37rO2bQE1h
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194522; x=1783799322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jajvi8AVqAQfTHFADtWCFML6DSVMe8XFUK0J1hsMK+M=;
        b=nOmJ4EVbo6jVnCboHvFjlZrScXe4QALgvjnjNemGx1AGVR1WOR68x8qjITtc3/rHjk
         cdBbwqxv5t/uBN8jouggC+mCLAZ/4WJE1FdgCo1oVT4nbpZwfqfMYQZ3oIGESVh9SKI1
         Fl+Tm6q88l8QvV1cIzwwGZk4GjDMMxOk/GonlOXsw3CoHz62BCQIva+/Lg7whSQJX4vJ
         FiFED4vSfG/xCn4nLmxtJxzlutJMvgvEEnTp807FT+s8KLEyWdotjrSP54ChZ2i4MMTV
         LVduIzKhs/VL9ZZwk0TH3sD+zXQfMq/tSYKBvjrdWIjhKzclS5ZGekay7LO9fQm4hH4r
         c/aA==
X-Forwarded-Encrypted: i=1; AFNElJ8pz/xfhX7Hf6VAtocNIgwRtm05hXLUkYiFru5Sq8M8gBjRquoSAAjauvpetDDDv7L4qVHIzshkOODLoDGB7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGidZA7E4UiyBZD1p2q4I/e98M0C7a2uX9X5CnshrReEzhxiX
	eSkMbOK36wospYy8r+K54mXwENlclWZZpAikQ+RK0dx77iw/agfLpetwysk6AQ==
X-Gm-Gg: AfdE7cle/4vUxLLlutOv1GRoFLajzybht4uiVZMV1NbKSr5IgFjhhlKyStPZhlhoAWq
	VhyaarwFBNig4fl8h1QeETQJuW4qoe1XxvaNMCMORohaVvChDUQcn8DqQGuc6rCT7v24FPWRPRB
	9oPVzbOmKa9q7b9ssrWc9/TOalC8ZYFSsv7qKRTaxRg/SSLt58H47Z0L+xIpDmlgVX8Ao8px9G/
	znmMaKtTDhS6JbbTkuhGpRHKIAyN+lSGJeHRodQwdFptFFv8rzDhBmbB99CeTCEzRvDgnrnjJ9M
	DsZ+B/Xz215Pu1dD038oloeA0HiH6y/XYeBLWqQ7M9OjzP90T0HLzy+l62tNVHlsupY/1zsq7BQ
	tuFrksZ89wOLVCBIAOLdc8zGiUC3sYE252GY/QNwd/lczw+Pxg0RetYwRTFH0Lm5jNMwadtveYL
	wb0Ycbj7NYcCU0Wao1kqx2KQUQGcnMu7h/r8szNpfBLO8W0Qo/gf52VrYrq8nO/yGlE6zlKCo6d
	+7a8fRNzfM=
X-Received: by 2002:a05:600c:5487:b0:493:c389:d436 with SMTP id 5b1f17b1804b1-493d11d7b91mr48863315e9.9.1783194522196;
        Sat, 04 Jul 2026 12:48:42 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae4fsm10649869f8f.18.2026.07.04.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:48:41 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6Lw-00000000Joz-1u1n;
	Sat, 04 Jul 2026 21:48:40 +0200
Message-ID: <fe1630ad-07fa-48cc-8ca1-72dd7a0e088a@gmail.com>
Date: Sat, 4 Jul 2026 21:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: carl9170: fix buffer overflow in rx_stream
 failover path
To: Tristan Madani <tristmd@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
 <20260421134929.325662-4-tristmd@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260421134929.325662-4-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38624-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A71B7084BF

On 4/21/26 3:49 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The failover continuation in carl9170_rx_stream() copies the full tlen
> from the second USB transfer instead of capping at rx_failover_missing
> bytes. When both transfers are near maximum size, the total exceeds the
> 65535-byte failover SKB, triggering skb_over_panic.
> 
> Limit the copy size to the missing byte count.
> 
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Christian Lamparter <chunkeey@gmail.com>


> ---
> Changes in v3:
>    - Regenerated from wireless-next with proper git format-patch.
> 
> Changes in v2:
>    - Use min_t() instead of separate if-check, per Christian Lamparter.
> 
>   drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index f6855efc05c0f..ccadc46385240 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -918,7 +918,9 @@ static void carl9170_rx_stream(struct ar9170 *ar, void *buf, unsigned int len)
>   				}
>   			}
>   
> -			skb_put_data(ar->rx_failover, tbuf, tlen);
> +			skb_put_data(ar->rx_failover, tbuf,
> +			     min_t(unsigned int, tlen,
> +				   ar->rx_failover_missing));
>   			ar->rx_failover_missing -= tlen;
>   
>   			if (ar->rx_failover_missing <= 0) {


