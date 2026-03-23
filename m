Return-Path: <linux-wireless+bounces-33710-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFYINoQewWmTQwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33710-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6502F0CEF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C4F30440A4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0A3859CD;
	Mon, 23 Mar 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5XHFQqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661632D7C7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263227; cv=none; b=AEktuwLD3IAEC1Ov2u24flxCo09ARB+zV/ghviTt788PjXQTXVVEhRCl/vExzo03/D83isxHH78GYHJya+AgSfi2JUyHB3aDR1M/b1dJ3vqn4OEY+lFUAvsBZEgQ9dyzxKQbqFrX/8RZ/M6cTrGNS5zRfTf8Kh1sLn+6y0UuvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263227; c=relaxed/simple;
	bh=qif1PcSdEiN22JOb2hmbQ9m9c3bCcMaTWtYbFqXBtTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUAj1g4qzDhKTNE9LqwA/1pOMa6qSqQA4/ZF1T6PlkjUnE8ZC0sqQdOWAnz2Opla45fI1ftZ7rGfExyJRPeZZPXNkmdLdcKOWvJqmxeC81BUHWqSTUhj5ltJEtjAy6YDY89dgWuQXMon4o1eZPWqXyrq1ZbdTWmmAg8uKI+gWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5XHFQqf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fda2a389so21651375e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774263224; x=1774868024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NsPir38d8G3e0m5A6wQsAL7tMHUqCuvOTWNS0Pg1OE=;
        b=I5XHFQqfevLbD3VvmX3XNu+vHbvoRyavLToju6v9cDhOekw1F+fupDtMxtwxijhsRq
         6SRnJkPK9Hme6P/d099JJI7T+cMGtEcTc37+RtQYYjf64R7dr5xn595ac5xSrhRjooSy
         XY+wfUUJXT+G1WwkaKPZdTYBZ8Nr+VwMaf3uxB+skuOKazbMUboj6YOfRd/UFUMrQwPf
         i4+V45jgl/K2k4xxMbObCR8Y1Y14bXk848Pf+brAVGhZQq99ztvEgIykJhe4wkUq7RKf
         3sKsIClGiNGhTuHKakTb+JUAjYpWIYf77FiV/03l7ViPVeBrLYu8XBX+Coc7PUD/SlbF
         D0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263224; x=1774868024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NsPir38d8G3e0m5A6wQsAL7tMHUqCuvOTWNS0Pg1OE=;
        b=iySFi9GBoWcPyqAF4pEM/uBRomKW1cZvEBWJlVYXjEbJejpRMbJuEcXSlTjqC2k+Mq
         wwmefvtpxuBvuz4xXIfmIuGsJKmvSW29SNmpQdxEWJOCruh4M+FYrH9+uQz45xxj6qdw
         sdIHvEM14H0YEvyk0hdpmHTsBAX4Ldq49DRfdLNcWCNq5ypXMNcn/CFUOTAVYRqZyTAG
         boZ7ysWI8ajPazoKiVODJ2EODxn2qOsNY3EeIohUTlJucj6fsuKNLQc4WHswcqBKv03n
         clDkuJR/xj886VpLxP6ji5mTh+tTNp4mDkFLidFjzQdR46gKTOmVxr8WAGB3J6p/UCJt
         GJnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJNCyQigUZi3w87AU58Cl2K+0w4Mlb0pb7cu2y9orGNxJK5hg8D6zzzVQ0jTULPmsgh4ZLcl78yJHLA08n5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHh6SIKCfquM14unExALUbpMvdUcPQFkHgkqvTylLNzLD1NjV
	XLcMDe0RhITlYVU/qHkh45TEDYW84nKYJN+fp/n8YBqqBJZ37CzkIiCA
X-Gm-Gg: ATEYQzzJxNKhpsKaUhYmO9qiKbwloMZG8o+W7R9enIxTCYI1zM0NMXYX4D5l+gGoIUR
	4YeQMz4G+x1FZDtB3An3qNBLqEK18dXdFXEIhthS8nZQ6UCQhWnQXMPFNNRS7beMw+u6kwrWNVS
	26IbTqL8r5Sm2m8H1vYpC1eE1VeTA5t91sOHNuChYHZ4rbDc9ZLvW6jaivG/Z2UMRJuhnNgr6rm
	yXWGTjS94QyWyRBZeQtgwZAzVkCI83rSUhJn5tJPFo8jQrnyaplB9kg/5djjGDX8IskEizhamAG
	8WofDr/7GgVHL7wb5drvcMmT5L+UsqzKkOxEpuXudbK8yVKTqjwbckjoKK0lbZH0Ro85XV+22mi
	VbCfthde325zLVZhNaFk4D/wN4yuFlAKtODnZgVWsTJIo4948gWxk3K9LE8uqTzhm0+hjpqPXod
	CO5iTq1ITw7bnTT2oLsKmqJT1rKxagEg==
X-Received: by 2002:a05:600c:34d2:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-486ff029163mr143534995e9.18.1774263223834;
        Mon, 23 Mar 2026 03:53:43 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff19d452sm79302145e9.19.2026.03.23.03.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:53:43 -0700 (PDT)
Message-ID: <897a086c-437b-44d7-8433-8c0feea814f3@gmail.com>
Date: Mon, 23 Mar 2026 12:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 6/7] wifi: rtw89: 8922d: add set channel of BB
 part
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20260323032556.19825-1-pkshih@realtek.com>
 <20260323032556.19825-7-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260323032556.19825-7-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33710-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 3A6502F0CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 05:25, Ping-Ke Shih wrote:
> The set channel of BB part is the main part, which according to channel
> and bandwidth to configure CCK SCO, RX gain of LNA and TIA programmed
> in efuse for CCK and OFDM rate, and spur elimination of CSI and NBI tones.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/core.h     |   2 +
>  drivers/net/wireless/realtek/rtw89/reg.h      |  64 +-
>  drivers/net/wireless/realtek/rtw89/rtw8922d.c | 820 ++++++++++++++++++
>  3 files changed, 885 insertions(+), 1 deletion(-)
> 

[..]

> +
> +static const struct rtw89_nbi_reg_def rtw8922d_nbi_reg_def[] = {
> +	[RF_PATH_A] = {
> +		.notch1_idx = {0x241A0, 0xFF},
> +		.notch1_frac_idx = {0x241A0, 0xC00},
> +		.notch1_en = {0x241A0, 0x1000},
> +		.notch2_idx = {0x241AC, 0xFF},
> +		.notch2_frac_idx = {0x241AC, 0xC00},
> +		.notch2_en = {0x241AC, 0x1000},
> +	},
> +	[RF_PATH_B] = {
> +		.notch1_idx = {0x245A0, 0xFF},
> +		.notch1_frac_idx = {0x241A0, 0xC00},

Is that supposed to be 0x245A0 ?

> +		.notch1_en = {0x245A0, 0x1000},
> +		.notch2_idx = {0x245AC, 0xFF},
> +		.notch2_frac_idx = {0x245AC, 0xC00},
> +		.notch2_en = {0x245AC, 0x1000},
> +	},
> +};
> +

[...]

