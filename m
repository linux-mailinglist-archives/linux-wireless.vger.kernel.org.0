Return-Path: <linux-wireless+bounces-33116-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAFBBIDksmkcQwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33116-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:06:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CA2752D8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D14327EB2B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447573CE4A7;
	Thu, 12 Mar 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSr5f8B4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E63B4EB7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331115; cv=none; b=AJ4t2KeMriDZ4UKuwE6wkKup/jOij5VxIEmP8/6J+ke6KOSFJHRKt0uz/PwiLKTEJksxXMVIa29Sn2TEBR+PlHSalAMfAZ4tfaOhd7g4Q/fIly2wd7//F/Ss7LzLs0j+rp7lGNH8umlWMInH2d2rLKL0f74AhxCahVGYhDwvpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331115; c=relaxed/simple;
	bh=UtkPyiM0qjSDYksdAePF3Gkj6P/TR40CDidU7dMuST4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkfenKLwvBXc/qH9DUNBxYi0StSGOwUC8SwNroL1XPFO9uHMxIDRU9awG9aSkL1HPiN8ISAD9rNqdHjYxE2rlhK1MNZ9u2lWcfl5BvlKQ9OYT+UPG8zaRAxKkC7ak/h23AcT6VcfAphey0W4xZ+Y1bgch24vYAxYWcYQVe+cdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSr5f8B4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so10190885e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773331112; x=1773935912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tf5XICc0pqCkCMcmIU3Tt+2b6ONuUK4iukoxAokiTaA=;
        b=MSr5f8B4eM6yGqsjII7a9YvnHDqslCaWL59xmtolKheHYoXD9xzLVpEKNMO0318ase
         Xo/5B36BHN69C8PTR29HW832ELrDS4CdF8yaF0uKdKx9RViafxCD8IAu9L7VNnGzKWg9
         zgqwsdpgWHlyNbe6L/i9znLJvMkHMp8QoAF4rCNA6Yk1gWDxTOaL+/9Z2IwfBj1WWRsZ
         8Z0iZtFnWL+3db+ZCMp0FPUSm4w1mtujk6OwVWDaRfihuUGeLwXUMhIT2+JONwttsnGv
         F62P9gDklH0iU6MNuBSSjRKumkc7tMeAj1wY3VOQZjIUQEbR0RpR1KCDuFju1kJyLdr0
         9X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331112; x=1773935912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf5XICc0pqCkCMcmIU3Tt+2b6ONuUK4iukoxAokiTaA=;
        b=e+F8pa8K1bJkTcD0SdQY3VX6OYbBzPTp8j9oY9+0I71MrYlih98YxfigDo6z+19k+/
         ugfltYFganVyrmNEmV9q54PjFJAW1ynN5h3o8TTI9f1kiJSys3AgU10sSqp4T+DgZ3cW
         y7B6czQkXb8Zpqlud38/5wIPrrbaQiuRte69dFgGE3hwweR1YR66rhvvGtdNkZQ8PsC0
         g0Jamw9DgbijL6sP/LlRHjSJc1WVfskNZhtsM5dbIMtMvu/qIgyX/caoQl9p832mLMYu
         vuTZEBBVElNahDfeW/jd6z9rLgEPej65mbxZGCbrdVtAfct5/u6Dmr6Nn0ZkSgKvIiGs
         Bpyw==
X-Gm-Message-State: AOJu0Yxlw//puD/0YprRwXfr1OqXRhNGOpyciyRz8U2zWX2xMG4C8jGR
	p+H6cEjRMttAG+PWGG1wOPb8SkErO6pDBzPBHc0k0m6d4Y4IG3mhn0Ys
X-Gm-Gg: ATEYQzxJyUfpAb5I+znuWNRWqAQEN5fFNonW7PQ8IcZBtgjmsOIH/odMudJZc/nszAi
	UiHpzPQMHJepx0EKLR+wJTmk7Y3wTYG97QqXSNRChYEmton7IKfTkk7v+ypR5m3S4krUtXBEpm2
	6QwiXVWTIqSoUUhvk1z3NOtYbMBQvJhgZ7iKns0qZhCQsz+0vBtMexDa8d1S7mvju0KPIU1LaM1
	5fdCnT6Ou/NlsM68Uy5aIqpKwUkr3egQY9tAuHhgp5J7/xe8ACLCzws23e+R8QiJfIZ+OxZ2s6V
	YliLN7mV1V0UqY3IrxVMln/15//471Pqwe7MMoEb/4TwUGZbpPXwBp/3DpvA0DKHyXouebKKQbU
	NBYUqL7xrBM0K03Pcrzy14IxbQdCKx/Bp9u/q+PELz7EId6VwGmwyhxXQKVPCHgHz7b9sn7XoXj
	oJIdEwJkMyEi+dVkTt7KDKaVsiA28oB26zlhnXl/fb
X-Received: by 2002:a05:600c:1f14:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4854b100afamr121279535e9.20.1773331112001;
        Thu, 12 Mar 2026 08:58:32 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f255sm243928405e9.12.2026.03.12.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 08:58:31 -0700 (PDT)
Message-ID: <093ad0f2-8265-4560-a51f-397eb34f7f1c@gmail.com>
Date: Thu, 12 Mar 2026 17:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
To: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312142155.2642993-1-georgmueller@gmx.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260312142155.2642993-1-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33116-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 910CA2752D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 16:21, Georg Müller wrote:
> Allow devices with this driver to be used as a wireless access point.
> 
> I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.
> 
> Experiments two years ago failed, but some other improvements to the
> driver seemed to have resolved theses issues.
> 

The rate control code still doesn't handle more than one station.
It's not going to work right.

It shouldn't be too complicated. The ra_info member of rtl8xxxu_priv
needs to become an array.

> The max_macid_num is conservative. The old driver used 32 [1], some
> other sources said 64. I have not enough adapters to test any of the
> higher values. Given the usage of this chipset in nano dongles, I think
> the 16 might be high enough.
> 
> Signed-off-by: Georg Müller <georgmueller@gmx.net>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
> index 766a7a7c7d28..c6aecb28d28b 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
> @@ -1867,6 +1867,8 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
>  	.init_reg_pkt_life_time = 1,
>  	.gen2_thermal_meter = 1,
>  	.max_sec_cam_num = 32,
> +	.supports_ap = 1,
> +	.max_macid_num = 16,
>  	.adda_1t_init = 0x0b1b25a0,
>  	.adda_1t_path_on = 0x0bdb25a0,
>  	/*


