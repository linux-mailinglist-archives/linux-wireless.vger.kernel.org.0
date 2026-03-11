Return-Path: <linux-wireless+bounces-32993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIWHI8CVsWnkDAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 17:18:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3AB267328
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCA47306CF58
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FE3E023F;
	Wed, 11 Mar 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O09NTyG0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C673DEFFD
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245704; cv=pass; b=BuwXs8Q4zO/rBSBfecxD/xkpFdR3gbGkMkpcmHfwH+Q8Aqzsx1KvocYKVKjpjwL1zsdGr3TGZUOImL7qjOvFs2hQv/pXonXDThBW5IhoKR+Jjb9byAGvIbv0IBg776koJQcMqy8+6o2cdy2ax9wvsv27YfEZqDlyAJvgBC6nWsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245704; c=relaxed/simple;
	bh=f5SMFqWfUYTCaiNaIPiZttlPh5sNP5Z5fPIqBYGPN1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc0MktHEDECQmYJSRTtQxmmtSfP/Onn2vtJ3QUsZEPsiR5U/m6dofBuMmWg4FlGsSIVj6WaTSkbVJiSzc5XgErA8FrA3FoH4K5U7wz6pxAWTVh1W7/Ur5dwS90Ba5WqYSuNJpY1e0YXSKgV9UzBp3Gov1h+gZQ/3Zy6FnUaEuyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O09NTyG0; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506aa68065eso157641cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 09:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245702; cv=none;
        d=google.com; s=arc-20240605;
        b=OzmWnV7DdQ1P8F4iU2B9fjEdAeQFtD4wMMI8gUcjhhdIQCi1U0G7dfPalff8ubqrG3
         J4BJ4AQimpZRTgbP1KTXil+dFybM8PPEUoRX5Dc8fH3btj3y0uBn1LONrB6RlzVfXGGp
         wcabD0G7p+b/1Hcx25PPsAu6c/IYEYC4LN40j+qZ0CnLo7q0AVmdql6Vfp41qrKMKeVI
         J5db6Rv7esxMpw4KBJfqbMls3rtqq7NHR5DyybR7VsZrIco03kpM3lOCUMrLPg+v5rkI
         gPQhhlYCsprlUoMp4SbUN2BzjVrNDKLsQc2g4b59wE7Vw0RToweaqoRco8psHof0y70i
         3hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        fh=dDPyHPGPLkWWbL2PmjHqREZggPMjC7/FbcWDx8YNeqI=;
        b=DtFAB4ovLmJltmtJlCLgAUJoaU30WGJqxYpZTK4MY0eHI3lGA5Qe4vRdWorIyDQzqU
         bSVs4SPf7Z1H/QDB7Po9YeX8HZca5KASj+766Jiz4OJyVra2/prCYh2hGC35TQGRqCDT
         tFiserH/cj7VBuTvJXo06XVne9SGV5mYyUvsY7Y72Uesq0H0+2q27L9fhLeaLPsgEoYv
         DJfrGLEt8lPAWA6CrKT/E9qUrfeH2aUXAfOAR3U5G64q7Ddb86LmzIYsztOIIXnF974E
         cWJEe1scr76NyT45YTU264l1IGpjsP8gDMOnLzm2X4NH9GXaWOUwnm806tc98Tj8tkgr
         zfqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245702; x=1773850502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        b=O09NTyG0pRzC+S+XbQe+Ztt5cCKq7905HbRZj6Z2kvtw+QVLPcF3s90KN2nAvwOtpn
         pYwKmiM0CCDtZl9nJsjQB5+FIbzalxS58XEHywN4YyfqFW1trRuc4K2O/HLSouWB0eMQ
         DOfqn3KepbALMayJPgbBUBGKNrRdoX6FRbHhml3SGDeDynUW0Hx3p3Zk1gtlrSNNRqrG
         HJkIHzcZJNTWQT4ivx5D9gBBqeUHX7Pfa/KHkG7RxcsG8I+bHzkp/ej/5i9kPHHeuHZv
         QLOIZyzd06ACdIT6qe3VtVP/E/H7VFynIvKRGe3SfbgoZ7Tce1weNgVTjKI1BiLms33e
         JnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245702; x=1773850502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        b=oXhgjU1oxQnErmioRlh2jkuYfU3Wg/IcqZuuaYptTy9Ak9GfklIVp6vfbH/nglwHnP
         xrlk4zJD6rVAVaeg1phMssvR3/aWZuLmca4jyUXw1EAQYE9/ftd9/Slhzl23lEolIliR
         Is+a9L3NfjeiN86jbxbqa+G6Dn06yFrGLpCq3lrwRbR2FqgTrI6SHrzvzmRNigAZ1pLl
         nPIuObJb0Knu5zs/PPgIZyz6kJq/vhLdgFiwYMm9hKMP0uZXoWATzngGiiKC7jO8/FCV
         WjFUqAgavL9ewuGEatUjGHABCMoWj4AF/2HBMWICJLrzl+RKnaIucdbWP0hfOnNSPzYv
         rvfA==
X-Forwarded-Encrypted: i=1; AJvYcCUW5pBIHqXhUhYBA0R5hJKHbKF0fDS1DUqo83olYspJGihRQE+uUfp/8PSbYyB9ymC9Hx4aDIvNIIlA2YB2lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVfIDNhHheGED5v1S8WpBwgY7/S6tpUcK+O9zRSLgLg8aIDss
	W8cVyJwi/PqeqxUf0DOLkLyjDokeJjqApO+tvu7zOKI30lZIVeJC3sLtxjz2ax/kYIaKAnF1oB/
	BMy1gSc9hGL2qzFkpA9O3wgICmbpGng==
X-Gm-Gg: ATEYQzzxgOQF/dPhEpH+joYt324J63iNrRWYkyU2Cp5FfmeMoeviPJv+UOcROwIaKg7
	xQdozG3RTxy5YRauS49VCFKSZ45uYCclxKao4nc3xTpxRoExSzlWVF1X8a3WuLy5yGPZo1S3q5B
	JkQl+NOy1i0Vlpm0KLOAuJccw0DPuHaN+FWRWOltz2RJVO74VQAaakMRMWmR19ZbwqJnrikCIgE
	LA7no+nr5u90dQFumfmsbGHq07+W2YpdzZYZIWcgwAkFYJ33xfQKHcD9l0iAtWvBdNmDFaL4vKb
	zdcx1yhC19TZ8ABvpw==
X-Received: by 2002:ac8:5f8f:0:b0:509:2222:4201 with SMTP id
 d75a77b69052e-5093a1c2b09mr36139601cf.69.1773245701913; Wed, 11 Mar 2026
 09:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311002825.15502-1-sean.wang@kernel.org> <20260311002825.15502-2-sean.wang@kernel.org>
In-Reply-To: <20260311002825.15502-2-sean.wang@kernel.org>
From: Nick <morrownr@gmail.com>
Date: Wed, 11 Mar 2026 11:14:35 -0500
X-Gm-Features: AaiRm50riU_uOb2IzOgK4aB6NSrm2_y0b6pNwKh9O2M9Qcys0qvy4wS0pXJ7QU8
Message-ID: <CAFktD2cbFJrLS4ggc+yf582BYmw=jJsntfbDR65ssMpVGM2BKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
To: Sean Wang <sean.wang@kernel.org>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>, 
	stable@vger.kernel.org, Satadru Pramanik <satadru@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32993-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,vger.kernel.org,lists.infradead.org,mediatek.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4F3AB267328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Sean Wang <sean.wang@mediatek.com>
>
> mt7925u uses different reset/status registers from mt7921u. Reusing the
> mt7921u register set causes the WFSYS reset to fail.
>
> Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
> correct registers and fix mt7925u failing to initialize after a warm
> reboot.
>
> Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
>  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> index 7ddde9286861..d2a8b2b0df32 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> @@ -392,6 +392,10 @@
>  #define MT_CBTOP_RGU_WF_SUBSYS_RST     MT_CBTOP_RGU(0x600)
>  #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
>
> +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST 0x70028600
> +#define MT7925_WFSYS_INIT_DONE_ADDR    0x184c1604
> +#define MT7925_WFSYS_INIT_DONE         0x00001d1e
> +
>  #define MT_HW_BOUND                    0x70010020
>  #define MT_HW_CHIPID                   0x70010200
>  #define MT_HW_REV                      0x70010204
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> index a92e872226cf..47827d1c5ccb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> @@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
>         .need_status_sel = true,
>  };
>
> +static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
> +       .rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
> +       .done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
> +       .done_mask = U32_MAX,
> +       .done_val = MT7925_WFSYS_INIT_DONE,
> +       .delay_ms = 20,
> +       .need_status_sel = false,
> +};
> +
>  int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
>  {
>         int err;
> @@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
>
>  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>  {
> -       const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
> +       const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
> +                                               &mt7925_wfsys_desc :
> +                                               &mt7921_wfsys_desc;
>         u32 val;
>         int i;
>
> --
> 2.43.0
>

Sean, testing results from: Satadru Pramanik <satadru@gmail.com>

"The updated patches from
https://patchwork.kernel.org/project/linux-wireless/list/?series=1064695
do NOT work. I get the -110 error with them on a warm reboot.
Reverting to the kernel with the older patch restores my adapter
connection on a warm reboot."

You are welcome to stop by the Github issue where this issue is being discussed:

https://github.com/morrownr/USB-WiFi/issues/688#

Nick

