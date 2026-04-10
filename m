Return-Path: <linux-wireless+bounces-34622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLClNUch2WkqmggAu9opvQ
	(envelope-from <linux-wireless+bounces-34622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 18:11:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864A3DA299
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C0613078B16
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CB3D75C8;
	Fri, 10 Apr 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckyRqDmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3233B95C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835903; cv=none; b=cp9mpHlif8uN8bJWdeJIuJZXxMk7O+c0oiAG6msNgl9H44qagVoqGDyurktdSR6yzqxjNvwZodE0IsZGYdeoOct6R4eNEvN7IvxuuwiHvb0PIyQTk8g1BS5OgFhrbIUoA9px3jQkBlrE7EfDX390S8f0b7oRK2F2q+0W9t6Gd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835903; c=relaxed/simple;
	bh=5dQ14TpX83yMuix7ETGAa+xFTk9n/q/DglxMZSrgVag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxNTk2xSnXuisLB0Hvr1F8BlOWvGzcspmmisApzTzsIa25o4iHeBda2PFqrOEakyX2qdHfMzZvMNKLYio1RDFInnSz/HCf5N8cCpuRNN85ZxAp1U22FneZNStF90jKDCSiadl6u00SK7X5G476KyQZ2ZNso2mPaLgodWhYcdP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckyRqDmZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1467975f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835900; x=1776440700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYqxfdb/7dtU74U2+9kACdSLnHjF8QaN9+ocpmLbaV8=;
        b=ckyRqDmZyyQG5CjKrmllhqm9mTQLI4GRimTbZNYGn9jhFS4jrl8VP9H4anG4AHlto9
         yaIASinMqsvXpBzLKtlsdC2zKPiqIjc+UkRLQ/nVe6vzVZBXDWJ6CspIfnIhBi0u4B6i
         X3XDEqYVF90KULGeuJqa4ZsfbNrwxU+CMjgI9pXiowQL7LihWVqM55LlPoxzT8lDwxOX
         fsdH1mXrB8ZgN/BHl0QbgKy+/XKQCOIlW9U6D4qdAD8fCJG9Xzxc1yFTlIvczaS1icDo
         cfoEnQVyuU6TlHuXU70+rmig6r6SpJiOPEwLcuc9VS0zHsO+mX1GpL8KwBRt7uS/AGCI
         aCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835900; x=1776440700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYqxfdb/7dtU74U2+9kACdSLnHjF8QaN9+ocpmLbaV8=;
        b=lcsqmCXmTWrEwtiNJ9pSJgHcTNkTRj33AlvliFoiqL1lNOJiYBPm9OAxA0ScZtzDc+
         P9LbuOsaakewt2ttpVw0AguUFPbjuGEitiiAyUZ2jW4h0l7asCEJlZrPqo3mtUP3Ovr1
         hsP461J6iI40fl9AybArScZUMjeZ7zfFRq6W7uKJewBd/T8ikMkcF/Y6X87ZJB9BCpg3
         /HmOVLlewSvMUBV1ZdQd1ebys82Zyixmue8hH68wS4dm8DqmVUAPZ6T1QcxGlk3onzZr
         xI2NjAqjVnVaPJm5GV6cBYEWa/2ljjfdoxx/a4UkNkxn9uy5kVx9p2nVqmE/K0T+vOfp
         caQA==
X-Forwarded-Encrypted: i=1; AJvYcCUiDfd0BAUlRdK5C81BZ3syoIsWGpctlU+BHlwbLafQKLjJ7iW8SNbWmLYWRFa0kfzvddBVYwb5lCdnhYqamQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyurr48H0FJ0MAA9zDn8B7IySZp2TgGpx6ivzxB1+09Kb70ojKF
	pDct69xH5xf03rXpaultV8FdpgKIUQoJmVimzMZtqzQeT3oKJ+5imhbJ
X-Gm-Gg: AeBDieuCmHiP3kI6gJvnrdN/xTi5Mi3L4XGxbJiV9KLpcxQ7oSA/w4TxzIIGkWRxkUn
	pMUQ4grj0F4fo7x0i6N7VP4CKGHOIz51ICiBAKiPSl71VeCyuyJbwxUP142R0lYVcV4mi0PGA50
	0zsU2PoMA2Q5D/PUVfV1F6eWY6PYn2nE+ucmZH+nyOUUWZ2SbAo0R9/eyZD3tDPjyQG0/3JhIpG
	q44IZY4Qf9rDLhdg/ZlowLoTxj9Hb8jW6JjYHNrualAx30wqzIKL6DSBKXRwLtnodCAAQHgyzNM
	X4W51Vw03W4S1jZPTPaWp4hT8+l01OdjdczVNGJHHilgRGODqfpYjhMFcrKghLC1iLE7NI292aS
	NKcsjon/uwhtHwRjZFe4viizZh8VafgsHPl5gsmJi1/JrCtuTjLR1zS74yCigLFATXOFNHMo81E
	xUPn+eplKGRW1Ar/tsvW6yxUtE6+k+LQ==
X-Received: by 2002:adf:e98f:0:b0:43d:6787:9933 with SMTP id ffacd0b85a97d-43d67879a46mr2165747f8f.13.1775835899867;
        Fri, 10 Apr 2026 08:44:59 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm6974826f8f.37.2026.04.10.08.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:44:59 -0700 (PDT)
Message-ID: <7c65e315-5a2e-455e-87ee-8fc6d60ed807@gmail.com>
Date: Fri, 10 Apr 2026 18:44:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: 8814a: add __packed to ensure efuse
 map size
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: lkp@intel.com
References: <20260410131353.1550803-1-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260410131353.1550803-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34622-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5864A3DA299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/04/2026 16:13, Ping-Ke Shih wrote:
> All nested sture/union used by efuse map should be packed. Otherwise, a
> arm-linux-gnueabi-gcc compiler might throw errors due to size assertion.
> 
>    In file included from include/linux/bitfield.h:10,
>                     from include/linux/fortify-string.h:5,
>                     from include/linux/string.h:389,
>                     from include/linux/uuid.h:11,
>                     from include/linux/mod_devicetable.h:14,
>                     from include/linux/usb.h:5,
>                     from drivers/net/wireless/realtek/rtw88/rtw8814a.c:5:
>>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct rtw8814a_efuse) == 512"
>     #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>                                             ^~~~~~~~~~~~~~
> 
> Fixes: 1a7545784642 ("wifi: rtw88: Add rtw8814a.{c,h}")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604101721.fsv5XmCX-lkp@intel.com/
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/main.h     | 2 +-
>  drivers/net/wireless/realtek/rtw88/rtw8814a.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Thank you for taking care of this. Actually, every chip's efuse struct
has a union like this missing __packed, not just RTL8814A. Most of them
don't have a static_assert.

> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
> index 9c0b746540b0..3cc7c2666c1c 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -471,7 +471,7 @@ struct rtw_2g_txpwr_idx {
>  	struct rtw_2g_ns_pwr_idx_diff ht_2s_diff;
>  	struct rtw_2g_ns_pwr_idx_diff ht_3s_diff;
>  	struct rtw_2g_ns_pwr_idx_diff ht_4s_diff;
> -};
> +} __packed;
>  
>  struct rtw_5g_ht_1s_pwr_idx_diff {
>  #ifdef __LITTLE_ENDIAN
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.h b/drivers/net/wireless/realtek/rtw88/rtw8814a.h
> index c57c7c8f915e..a0d9446e2043 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8814a.h
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.h
> @@ -51,7 +51,7 @@ struct rtw8814a_efuse {
>  	union {
>  		struct rtw8814au_efuse u;
>  		struct rtw8814ae_efuse e;
> -	};
> +	} __packed;
>  	u8 res5[0x122];			/* 0xde */
>  } __packed;
>  
> 
> base-commit: 929298742bb5dfacd53ea99cf989cc81210f90a3


