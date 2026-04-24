Return-Path: <linux-wireless+bounces-35265-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPWGIjou62mBJgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35265-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 10:47:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13145BAFC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CE4830022E8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724D31A7E4;
	Fri, 24 Apr 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwmeQZhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73A2874FA
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020471; cv=pass; b=ImAv2P6QlsAVq8mXbh8zXHHY3IQXqZWDKVbfMDTmiKORedHNQAyZ9Dzum4fpQMUt9ylgxyGv0LWEvToVwFNh38jBEiZHuTdT8rc712RAHZr2xRzRGztacq1QqGmxZB9Xa36/INiHLpo9FVPo89pWSWwvw+jwBBLD4nbcmKTkWKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020471; c=relaxed/simple;
	bh=E1kQr2KYle8iRZ9+CzOqMvN/GhEwBvQfkY5p7Jo7O0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9vW+A2T36bP5AVWXaJO6+H0rAE7ehCifXD+3pK7gACERCSIgeL6iT9YVbsqvr6u5WExjzAHpQeuoa/RKXJ2Dm4MgyNFwPZXTQFye5zEu4pbI5JDe34vHIzD69V9ljqQ+4Cw4C3C2J60udLhAal4GCwKf+w7nD/ZJSSdNQ+SRGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwmeQZhx; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-652f220595fso7908403d50.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 01:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020469; cv=none;
        d=google.com; s=arc-20240605;
        b=AuOrBl2qBmS3mh9RrNqe8Vh5Ahp+CsT1650KeZqM0Fv6v7YuDSXwoUXdc8QXs8dl6S
         nyR74qbasQSUKTAD1XFGcmteuqH6QW8cpJyFNoAeOIIHiRKWZo8R5ms6dK8+zFZlSNBj
         Ok4tbV3ROVKOs7mfb/02Q207cDN9+TwyACnCrDgrQkWxLAgXgioRL2LWKPE1aHNUhJ0G
         idhoLe2w1qAv7fVVURk792fEvAmB8S+kotjFN5ZW04lakGbVviK6zYtuH/tWLVyltt8Y
         3N50itdQXxIw2JPCO0xKEFt25nySJlZRBM5MNRKCVWK//LfM15c57X7qWlJYhqQRLMYj
         XF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        fh=uRuHliaEiK/zeJecLfmwvY6j3wXJPwujGJzZZasrIsA=;
        b=dErBNbnWyu2XNdnOOQAZ+Bv8jt/5GcPz2COMBL7UGmMkLndjeEyZLm1C5xPytBC+84
         72orlkz55I5cJH2PNAdgK4Bdxd+J9WVUal05LsJSB/wpm3wJX5HsOy0M6Eyu4iCU94Na
         i/MJQsSMmwisbVQyY5iH3obVP8LbnolXrr4QdSDgdu6XRUQ9+zAtKHVji++MuXsO7TQW
         h0A1oHjsbWYWp5zCgtFDO/p5GlmqEezq5o0thXNmtT4XmJpcX1X3Gg5iZ1U3oKZsHlpv
         ut4jluG9DZY/FXswLY7N7vcXp5WSpEGXmGDpy+QgJxpGTvaqFmctOgOinbMjlf5l7jKT
         Ob8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020469; x=1777625269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        b=HwmeQZhx0yqwcgLuju2WmoAVFWO2p2xApQsFSurNZFHPRRX2NJkm9vxOn8DdQMRA4J
         mXBmBkV9iCSBibbREbOgGV+t/0Vshm4PmuRNO1ocpMPJpUdxorYuGPXBxkQl5roJm1ES
         F4wwmjTJMGCKJTUOcv+Y6l4z7PeLELNBW6quiFxPXK6GKx/k8tn03DTQbLjlFVPwXquy
         lgkwkoecvK8qlV+ygdq4pZuObU42jrtwICe8rlz9jd5U0iBuAcN5cL7ehU7ToAqTJJZx
         KMWqnjzJFa75XtV02ZBuXvUKkxwOTs0vlgs7jRe1V7rfmbdssRDvlUYDkUuryWDFoKZP
         blaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020469; x=1777625269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X6FBpevR2jJBvwlKJsxHMc/LW+LNuSmstjH4HhlZlE=;
        b=ldaYQKQ68MVQr9AMaUKCWerjUggMXk/Jv6c9doqJNW03RFrvMZqhMdXmdDOCQ76Gik
         NZXUYb39ZsOVsVOwcd/YxF029gb6jJowz6X8VtGkgMYKhtFdlAEYoesBpRGPIac7nld8
         +ZXLdf+i5uwixvvA/Z9EYKl2qbRw/kcXb5emFL2cl+Bf1MaymrupwKkBX8RLN0nam9Zs
         EASZsVJSUHeUklvV5Q4XbHzGTbQcZVVLzcEUr8mUnRCK1fJLun/2DKbtRI2h0NHzbt4Z
         nQNlqVSrFwmc1fX+kKKHETGxghIrbFF6CuB94IOqDtg8/sjvBGLJg4Fh+mjjIn1Roy51
         3mDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KByCplvXTINol2B16tDgn+gjrkM+MOIZe0IMt8EwTHdGarzy8ZKc9TiUYpPl0i9Jp3JRx1VgghGRkmyksMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7mpaowHyeFZLEu1s21/uCn4pJ39g9Gro68YNdC7NsJmK0Oeq
	iIfhtR1uSrj+Aw8hb/Rswjql2SjNhbQdUt6zEcg5ArHUEOm/GwhFBu6VhBIAq4JeHreEdhpEemI
	fw3GayNlWEsr0VfAcuVuackW4MhOVgq4=
X-Gm-Gg: AeBDieuoHiQAmaD+R8YHmUONI5wtyY5vpQirLfl4wXN15jzHVLX4PhPVexF83K68CGV
	PAv4S+Gw4scFq/6YM3xf6juTZwhllc5ZBfWlgn/srCtETFXaL5WV+rtkvF5zIbojZF8wHUsn4WS
	Wqk9axF56l3Pjc5u/1m+JDx54VQyqiSTUOS02ESlLwaEy1hrZbl6KVvnJLGbWo2k07p1kAmTIrL
	bNSy5mt1dydfHvWk7TgHvityXhc2N2xDbPai65vYvzbYq2ob9NMJ/zD8++O6HxuNAzbgx0JtWCF
	2rdjgVhrH07TsSA+FOuW
X-Received: by 2002:a05:690e:e89:b0:654:2838:7789 with SMTP id
 956f58d0204a3-65428387dd5mr19457117d50.19.1777020469629; Fri, 24 Apr 2026
 01:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183002.3752935-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415183002.3752935-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:47:35 +0800
X-Gm-Features: AQROBzD9VPB99_HUqxe3kJ_u1LM7fMxeQL-UyLgjQtz5raXvqgz8yQ5xH6CNAas
Message-ID: <CANUHTR_rbojBBZhq2qp+6ZHJsL8gXu=-s+iSp94BCya_srSR1g@mail.gmail.com>
Subject: Re: [PATCH] ssb: fix reference leaks on failed flash device registration
To: Michael Buesch <m@bues.ch>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	"John W. Linville" <linville@tuxdriver.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2B13145BAFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35265-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[bues.ch,gmail.com,tuxdriver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:30, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in ssb_devices_register(), the
> embedded struct device in ssb_pflash_dev or ssb_sflash_dev has already
> been initialized by device_initialize(), but the failure paths only
> report the error and do not drop the device reference for the current
> platform device:
>
>   ssb_devices_register()
>     -> platform_device_register(&ssb_pflash_dev)
>        -> device_initialize(&ssb_pflash_dev.dev)
>        -> setup_pdev_dma_masks(&ssb_pflash_dev)
>        -> platform_device_add(&ssb_pflash_dev)
>
>   ssb_devices_register()
>     -> platform_device_register(&ssb_sflash_dev)
>        -> device_initialize(&ssb_sflash_dev.dev)
>        -> setup_pdev_dma_masks(&ssb_sflash_dev)
>        -> platform_device_add(&ssb_sflash_dev)
>
> This leads to reference leaks when platform_device_register() fails.
> Fix this by calling platform_device_put() after reporting the error.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: c7a4a9e3880cc ("ssb: register platform device for parallel flash")
> Fixes: 7b5d6043de312 ("ssb: register serial flash as platform device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/ssb/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index b2d339eb57d5..5cdf612a8516 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -535,16 +535,20 @@ static int ssb_devices_register(struct ssb_bus *bus)
>  #ifdef CONFIG_SSB_DRIVER_MIPS
>         if (bus->mipscore.pflash.present) {
>                 err = platform_device_register(&ssb_pflash_dev);
> -               if (err)
> +               if (err) {
>                         pr_err("Error registering parallel flash\n");
> +                       platform_device_put(&ssb_pflash_dev);
> +               }
>         }
>  #endif
>
>  #ifdef CONFIG_SSB_SFLASH
>         if (bus->mipscore.sflash.present) {
>                 err = platform_device_register(&ssb_sflash_dev);
> -               if (err)
> +               if (err) {
>                         pr_err("Error registering serial flash\n");
> +                       platform_device_put(&ssb_sflash_dev);
> +               }
>         }
>  #endif
>
> --
> 2.43.0
>

After re-checking it, ssb_pflash_dev and ssb_sflash_dev are global
platform_device objects and they do not provide dev.release callbacks.
Therefore calling platform_device_put() on the platform_device_register()
failure paths is not appropriate here and can trigger the missing release
callback warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

