Return-Path: <linux-wireless+bounces-33261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMr1EkZHt2krPQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 00:56:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A716C293117
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B90300A11F
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7C2C11D6;
	Sun, 15 Mar 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDmf7fc+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F892BE7B6
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619011; cv=pass; b=KIeQ2QkqxhQ+PRDSZ0TS8CaWcB1sm5AAtmikmKjZh9JM/ZY+viv0Gv91GeFyWSjYMMfmX8VD1IUbsg3Fzq6XlQXIITt+2wltkIktbm5Ej1c+/izmh9K24nofSesTeTFK4ZN28adxuxVEW5vdvXcYPICeNMqev2tJjyb4DCJW/0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619011; c=relaxed/simple;
	bh=0v9aYL1OBh/52O29eAqygO95z0sTQ4zRbjxSU2mIdWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efWeQ1yn6SH8M0hhUSn555ssLI4ItuQqJkVXr8gUNMMC4DruEO7UKmqmpissdOKkQNy9do2O/jfJLwEd9BrSDAVIdGaN/88dkcFULS20XFnHMxytZAW5f8FQfTClzw5/BFxuqGdvp882DRnrWt7M42K6UL0sJUeHZqGLEHVCtpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDmf7fc+; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50697d6a69cso20736801cf.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 16:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773619009; cv=none;
        d=google.com; s=arc-20240605;
        b=gfLVZaUXY2JVBMgrAzy6Ss8TmY7ULaJBhkyzI0St37r9rkepTp3peXokbS7DdyXXuU
         pe60PpQK9nRX6OSBfDBDaWH4vyvu+BYiBdeMTgYlYvUDoAUn8g4TYeZYA4YRzD7yjenh
         LSZtV3SZY4iccdqyWRE+rnJ9GcWiZvV3H8L1PRterXQ95AYFjatmNnRPDS7hjCDBoN55
         rm4/lzxgmaF4AkhA8qr7SDBNxdg2dFADM9pdnPlXkD26yMoSRdP+Vg83aXzQA/49AtUP
         yX1lzAoZ9EgquJ8LZzAOJ92xrWHtn5QCp1XRy0VY4TZb6takAzvnGP7nJCXoRPRNU+l1
         OxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zfWc1PVuIaGjEj+v5aaxG4wWyzdFsgkmHQOoNbes2Uc=;
        fh=xvVfPD1O50MjR8HfypDjv/9Dzn2Tjm8/W1c0/DMkGpE=;
        b=j4x8iYn0bzIpgBVk1v79o2Je/kA+dV4htcwKW3a6aFKfbsPXcZmmeVqHfW+21qozJE
         J3DAZBRJKQy4Pm2fvU1vlpWLW6MkzTnsx+goy/U27SqRiIEgTeKMNTQVCyAFKV/9p9Eg
         UHUkyD798SKxVt8fjdS+gLZwVhhAtfPQq74SbYfVdDHr8HHDQEITFK+IHP2YtvvgjQMQ
         FwMp40vT96g8bHXiR2SvcflVVr/9WDmkAaKTgerp7IhonkvoaaXYL5FeYW4H+TPVeK0w
         gKKi4NRLR8CYfqZ3n6g4jkiHIoB7x+/Fs75mNqzdtr/cobXhh53d5oAQ1rV9pQ17p1p1
         jl5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773619009; x=1774223809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfWc1PVuIaGjEj+v5aaxG4wWyzdFsgkmHQOoNbes2Uc=;
        b=jDmf7fc+f9BCgOZW6E7rh3CD7tYKfuiycRK0gyl19AqcMOwc/NY+Eje2wEntYn+HxX
         b0rE1Mtr/3odNc0uiqWboqoTQxoIV5LpOqy8G07Vyfo++8RNJW6Pns/P3Uc27ZsVjiz4
         uUyhneV+z67d+0Jei07+ZMj0Rx+rcjbeZee3EH8Lpj2uZqZ1s31JvxhPOxe0Ubes0Vwp
         AiQjO4Dji53UeL0DhdeebMeDJaxV2A/TnZeOnyLyWF+BMA6SZcHyQ8Sm+Q4UhTGzyYkR
         dQIRhnW0GxqusGP5GhvrGSW4Qpo792Amu+626ux0cCKmMhUQCdNCVjJmNv25byekh247
         Kucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773619009; x=1774223809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfWc1PVuIaGjEj+v5aaxG4wWyzdFsgkmHQOoNbes2Uc=;
        b=PgeNfLUr876S+DJdNGqGZbF/b99iOrUvoSb1RYSuZxaPTnp+2iZy0I5CvzWWmwQ4mf
         odMzvVdxB9AHbnrfFlhQ8CaVGeD0OcQUAGnCvupaghSSAWmQUBXJqcG9+Zoi43aEGcpP
         WcpwzlQOexzrkco41sjieypsoplzfnNyvQKOc97lWTtQPtKso/tgqfYXCHkxAViiezxo
         Ty1J06QiUjfShR54BrxLXAh5rze15BJl6NGW6QcldvIFletPESD6W1v9N+5IrGaHrmR9
         7aX/JzYeFM5eDW1hYiEXV1ZchAPZAIQjKBIsU5UuszoEaWUxoyl7IUbLtW5jIzhleRxr
         /jew==
X-Forwarded-Encrypted: i=1; AJvYcCW6/N2Bc5dcSsnJAF+WlJcPIaRtnxnYGpKbjXKS0CLzh8ZKDpdoqLrHcDv8Di+gb/d3DIB45lFrhovLg+4qtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuLEJ+ZQdG9Uh7l0wK9RG4DQXJKylihOHUC8b5cKHmKX+hX/D
	kt5plQFM+zxZMKZnPO5UnfBJHsOoIQCEu6L5zW8QuOnQM5FzpiPWDkr54O6UffV77pWEUjkdkQx
	RhbQFOt6FZU7WdnfW67qZudofVl6NEA==
X-Gm-Gg: ATEYQzyY/ZSCWBxariadzowHuCcYxFX6pIyIXYaGqlVOE9U78vz732p0aovtGBFO+Mj
	eYV9qKWooHjsKCGdokHny7sVCW06YyRbide8sicV4yKZILS5ljTwRdTrS30vRnneb0+Bf3S0mDs
	m+s+aKqtLDKEhQudaqq84ypMBBK0LMnextz7Gdqf5q2WUzrzSEG/kOMvaMGC261+MzitoSxmE67
	JZpnctSYjWWUrQfQSH0nbdBx6Gvv/+MWFxk5iL/rLE+u2Ui/YHjdRT8I/M1L/nSygi0IIZUoFky
	ibCr4HiXSaf6fiUSGg==
X-Received: by 2002:a05:622a:1998:b0:509:1260:b138 with SMTP id
 d75a77b69052e-50957e323c0mr131795091cf.58.1773619009394; Sun, 15 Mar 2026
 16:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311002825.15502-1-sean.wang@kernel.org> <20260311002825.15502-2-sean.wang@kernel.org>
 <CAFktD2cbFJrLS4ggc+yf582BYmw=jJsntfbDR65ssMpVGM2BKA@mail.gmail.com>
 <CAFrh3J-PsVQ1u_hGFxTVKK0uOs6KxT=euK+jbGvWCueqvynAgw@mail.gmail.com> <CAFrh3J_4N5j9eZAgbP0gzj5gTGVABat9-4xWZBicKMfgL85LRA@mail.gmail.com>
In-Reply-To: <CAFrh3J_4N5j9eZAgbP0gzj5gTGVABat9-4xWZBicKMfgL85LRA@mail.gmail.com>
From: Nick <morrownr@gmail.com>
Date: Sun, 15 Mar 2026 18:56:23 -0500
X-Gm-Features: AaiRm51Qj5-6K1SxyXtVVXgAPeBMnSu9mdsfs7G65KWz5yr6fupz2hG1vMFQLVU
Message-ID: <CAFktD2cot4QuVSs0_r2p0ajuRSDCL2u8d94Eq5vuVBfZxCsKzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
To: Satadru Pramanik <satadru@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, nbd@nbd.name, lorenzo.bianconi@redhat.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Sean Wang <sean.wang@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33261-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A716C293117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> >> > From: Sean Wang <sean.wang@mediatek.com>
> >> >
> >> > mt7925u uses different reset/status registers from mt7921u. Reusing the
> >> > mt7921u register set causes the WFSYS reset to fail.
> >> >
> >> > Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
> >> > correct registers and fix mt7925u failing to initialize after a warm
> >> > reboot.
> >> >
> >> > Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
> >> > Cc: stable@vger.kernel.org
> >> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> > ---
> >> >  drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
> >> >  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
> >> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> >> > index 7ddde9286861..d2a8b2b0df32 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> >> > @@ -392,6 +392,10 @@
> >> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST     MT_CBTOP_RGU(0x600)
> >> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
> >> >
> >> > +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST 0x70028600
> >> > +#define MT7925_WFSYS_INIT_DONE_ADDR    0x184c1604
> >> > +#define MT7925_WFSYS_INIT_DONE         0x00001d1e
> >> > +
> >> >  #define MT_HW_BOUND                    0x70010020
> >> >  #define MT_HW_CHIPID                   0x70010200
> >> >  #define MT_HW_REV                      0x70010204
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> >> > index a92e872226cf..47827d1c5ccb 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> >> > @@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
> >> >         .need_status_sel = true,
> >> >  };
> >> >
> >> > +static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
> >> > +       .rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
> >> > +       .done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
> >> > +       .done_mask = U32_MAX,
> >> > +       .done_val = MT7925_WFSYS_INIT_DONE,
> >> > +       .delay_ms = 20,
> >> > +       .need_status_sel = false,
> >> > +};
> >> > +
> >> >  int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
> >> >  {
> >> >         int err;
> >> > @@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
> >> >
> >> >  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
> >> >  {
> >> > -       const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
> >> > +       const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
> >> > +                                               &mt7925_wfsys_desc :
> >> > +                                               &mt7921_wfsys_desc;
> >> >         u32 val;
> >> >         int i;
> >> >
> >> > --
> >> > 2.43.0

Sean, I have been testing this series of 2 patches for the last two days. I
am no longer seeing problems with warm boot so:

Tested-by: Nick Morrow <morrownr@gmail.com>

Thanks.

