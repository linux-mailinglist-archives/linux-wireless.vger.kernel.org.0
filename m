Return-Path: <linux-wireless+bounces-23416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8AAC3BA0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 10:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ACA16DDA4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0E01E3DED;
	Mon, 26 May 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy8xMqda"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB71C3BFC;
	Mon, 26 May 2025 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247938; cv=none; b=l/3Jb95tdfHWJYHMSv4USBvTdiegjSUjMTcVjV1MZeWBg9yZ6vxqffvlI6yASfC4mNRXOf9EkQ1Lz/XpBNuZAOXVVX//FTHcULRSwtUm2a6f6xtMl8LWJOjXh7pGXafJVlvx5gCNfmWfCmO9t8GMfJAVpWAoRgRJsX9carKvWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247938; c=relaxed/simple;
	bh=mrau+5W3Z8JvklmOOYvgbOSIomPEjlwRXbUD0M51bdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lqVVetWpFM+vHJvoOVanyYolpKlKl/ahb0hqFBjcsOCBtyA7nIQ0ElNmgIzCBh9Nx8onrAUiyy4hfzrapgKQndK2GyYo6zVg8Y+B4GXUnFvh2wcIz6azteHwapNrRZqF8u8rxUdQZaBGbq9+Rjc6M1fT6Lh9a6EiI1nApHqWGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy8xMqda; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso11574655e9.1;
        Mon, 26 May 2025 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748247935; x=1748852735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3LtL4dcePRmP7dRZnkQEwm7VTaCE+JP89biT5r/gZE=;
        b=Zy8xMqdadRBi3vYot6elSV+9STHswxJbRLlhziCIeqMfQjsVq8G9+kuycYrXfifSHR
         iC4/F0ibhjKCNf1Ysk/kwauIOxp4oy57+3j0XeqH80TMSb/tXvE+Hhu+3xFVa262zYEx
         yEfjgLRX9mEWD/fIWQsR8MDRp/1FWyIoVcaxZLzmu2aps+mpwiSeOON8X/scELdceDsr
         YwJh884cLM5AfF6Jev9ZjzFjAjKGTnDpDunSgZpVkxPLBj4luvSN1Rx/iJ3MEaERyzU0
         AmYIPzuNBDCz5MmNMIlUkQGcoD13SJNCexsHT6gQ+HCgRSqLGDG5YLscfZcT7R5ss1bL
         kpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748247935; x=1748852735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3LtL4dcePRmP7dRZnkQEwm7VTaCE+JP89biT5r/gZE=;
        b=mEMDFkxzK7gH/es/cOpfpFCtOt4VcUhKqHUC/UI5zdN5LdyMdPxOd2/pDRYmYOKsJm
         5q7OA2teX2GczMh3YAR42xuj1l53tnp8wblpdGTFuH9JIP+9kZ1r3pvYa9ZO2w6xZHQf
         CbMNLeGStKgsDwv/r88pVHhz8rVjj5J+HjCpwG9q3dX8K7wZgrMhebeYxuuvsd0VkkPW
         ozj+bmFgGOIHmZGtD9B1ZU+Yt3V/uiZPAVQiUfgiNAM2fTG209HpY2dV4vq3Jj2cDfAr
         VZWCe9ebOufGlkDm4LEMTCpEISuNs7jPsU9Gf9nHRJQVb7VgHDswQ85Lp49r/yyk71Sp
         +JJA==
X-Forwarded-Encrypted: i=1; AJvYcCUPWP1tgQjs38Kw7fB1b2cSRgiNkZ+sxsKkUrKMK+mg9WSNy8C6ZcKwo3r9JXQ5GqS/ANNyggWx@vger.kernel.org, AJvYcCXl97hRSNlQdqNQ20Xno9Ekvn8xbGtnZ/8RewoyH1HrhaU6b5HiPS9rGtyw8K1ReIcFgIwLtzq+6g/f09s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahXC67vOF2nlB5yGapcp6Ph3jcuDxQ7X8a9sLm9Sw4IRJdv1q
	nYsBZ+Rn3jaSz3uhLGAUKnbKg1r+e0zOtZyTgaaxZ1thecsh6rzqgnUFxgKDnQ==
X-Gm-Gg: ASbGncvCxQNSNkLFr/+DSYR35UEE5NnM+3+f85fdXQ9vnqjYwIQXXtKQQ6qQ9dKFq6y
	Iyt0lA68zGuaaqZlfPIG7mGiLBp08b3GNMQaVIptjVVAcGMfie5mRomaxrw9Oi9W6uXqzJKO4BU
	N2B00e2O2GG4PXGFsUKkYg6DavSvyMTABkDrioYqITj68htYtsw2OpWuOGrjHevc0Z1HZPcCvud
	nxjMMwGSY4szhHiqhN9OA6fDhmBe4RecaLeia6zx66+Kt2MnYRGaSi3FnQTV6BgoLY4F1MYtQS3
	TluKvmeZX4WvqiOxauPmPuutRGKtiZ/ypbo06Kqd6x1Mo76qz/T0V1gKvND6nRClH7Hm4A==
X-Google-Smtp-Source: AGHT+IHONOG2O48qIuY4eklj5S69BfbVICIKGxv25oIduenSsheivugPO42TjE+T9bsPuDinayEQ5A==
X-Received: by 2002:a05:600c:138f:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-44c94c2d54emr65618275e9.33.1748247934614;
        Mon, 26 May 2025 01:25:34 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4481ca9f2d9sm233086655e9.19.2025.05.26.01.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 10:25:33 +0200
Message-Id: <DA5Y65C1FEEX.1YVIUHMANNAYC@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Wentao Liang" <vulab@iscas.ac.cn>, <johannes@sipsolutions.net>,
 <luciano.coelho@intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250525164211.2039-1-vulab@iscas.ac.cn>
In-Reply-To: <20250525164211.2039-1-vulab@iscas.ac.cn>

On Sun May 25, 2025 at 6:42 PM CEST, Wentao Liang wrote:
> The function ieee80211_chsw_switch_vifs() calls the function
> ieee80211_link_get_chanctx(), but does not check its return value.
> The return value is a null pointer if the ieee80211_link_get_chanctx()
> fails. This will lead to a null pointer dereference in the following
> code "&old_ctx->conf". A proper implementation can be found in
> ieee80211_link_use_reserved_assign().
>
> Add a null pointer check and goto error handling path if the
> function fails.
>
> Fixes: 5d52ee811019 ("mac80211: allow reservation of a running chanctx")
> Cc: stable@vger.kernel.org # v3.16
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/mac80211/chan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
> index a442cb667520..9e6235001e0a 100644
> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -1503,6 +1503,10 @@ static int ieee80211_chsw_switch_vifs(struct ieee8=
0211_local *local,
>  				continue;
> =20
>  			old_ctx =3D ieee80211_link_get_chanctx(link);
> +			if (WARN_ON(old_ctx)) {
Don't you mean 'if (WARN_ON(!old_ctx)) {'
> +				err =3D -EINVAL;
> +				goto out;
> +			}
>  			vif_chsw[i].vif =3D &link->sdata->vif;
>  			vif_chsw[i].old_ctx =3D &old_ctx->conf;
>  			vif_chsw[i].new_ctx =3D &ctx->conf;


