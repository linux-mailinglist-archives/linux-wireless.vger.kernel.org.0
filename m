Return-Path: <linux-wireless+bounces-6235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208768A2B2D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02FC28D9EC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCC53392;
	Fri, 12 Apr 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn4yLZ2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12753378
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914078; cv=none; b=ke5+OxG26G0J5MWWn9hbVUXFmrBq6BQ6EN1CUdQx22yE0a9xDdBNK0RzxLDDzUD7aDxcqHAu3ci3k3wJq6aYOZurvavtHJQaIn07rCXjFhpP8ou/8mZVnjxsOZUlVOhHM9fuE+qWIxgN36ZjNK4I52Ka8/n999qbWVAC00ghp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914078; c=relaxed/simple;
	bh=is5THqoH+3+MI28rem/n/EiXF8DHvGr/JlSxn3OnzEg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kznoKLMEmIQeylLauyv8xEI9uD0wJw1yZOKn0rkjhKgwcZeogWC7d7CjVa3s9KFZ6vURfPGnJRDzQ35/Xaq7HTramtVQK9E+VjJ2O4Srs1Fiq5Q3t5ojKIMiWmwyrkItygAvyHmN35awRFSEfVrmBZMSisCVVNuE12lrlDpWmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn4yLZ2o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d4d80d00so944126e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914075; x=1713518875; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OReUEDN2frbNEsMpeetqUaCFfc7dipywbbMjiR36/E=;
        b=Cn4yLZ2o9cJ93E6h+PEOJe02eaDM+TWS8CYGazHZ08Aw4umZyEtvypocxmWniwDcjA
         P+q8C6nVMEKwrGPs1umipojg+xBvQg4RT7AnqOHkQjSbE+Pms798EN2i4SZ9nmZvJSnl
         67DJ4mmI30miF+nj+aZJe4Yt3LcLWjU1Ki79/CPsx0RdOc/PhJB/MnMj1/dYFo3WBGAO
         Y6IGWJoXnEOqUN59lVLJryPtaMZiXsph6EMwNKMil2ES53NCit4xakqZnGeY1wWRVKqt
         RvLbVhrEEZx8B8uQnZWdUDbHJBScZ6UW7ZF6zX1TwM20ioUPyTNwUun/cxZIfWVvg7RH
         NqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914075; x=1713518875;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OReUEDN2frbNEsMpeetqUaCFfc7dipywbbMjiR36/E=;
        b=iSMRF9n6cDV008ahs/OE0K+v7G4UnOG0ic2xmofahBH0rZK9q0zAImGZHxA3z+pnzL
         70M8VW0jLoIfwcq9E5lEOvxOgC9pQrNN0jOeowcZ91agCdN8v28NoJZKm/Dpm6qtzeH1
         0NlpyRXgHomKOpWgBSyc3zW783Lkml0PgegKx4+Uvc79WmWezufoIPOexZlnUEo49PUp
         nTF1HWSMxJbRmLI9na+x+8czD0sL2mG0+je6IL/3PBVDn0g/G+nmRt3gagM2+qGVag8v
         FyMAbn8ukds349ajepB5TWs8O0Rpvc2rmDboE4pHZ4BstuWPcjPmagAPpQYnQstvoyd/
         q+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpIiMGppXKXzaIzaYouh720rIWRs4EkM1Ra2XGYKbkX/xf45kEXcX8TGcB+lA27opTyH984oMyhzrn5v3xCIao8qCeRqkWG5M2Lsucsrs=
X-Gm-Message-State: AOJu0YxCDIz01H85K1WGbr1KznNrQ+1GLNLSZHLQ5bN0eA+PUh3MGRYJ
	lVSXgMeT/3Eachral6lw/N2lApFRsK8Zh9uXrx2E1mV60tCKp8mhB/Roce1R
X-Google-Smtp-Source: AGHT+IEDzAhghf3BkO/RgZqY7va47me9gidgqhOpwVjCxTStASj/0/EN3dB/L+Y1I2Zc2CAZ0pv1BQ==
X-Received: by 2002:a05:6512:60b:b0:518:6f95:1a37 with SMTP id b11-20020a056512060b00b005186f951a37mr1182850lfe.33.1712914075122;
        Fri, 12 Apr 2024 02:27:55 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d6aca000000b0033e9d9f891csm3825825wrw.58.2024.04.12.02.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 11:27:54 +0200
Message-Id: <D0I1D2J8EB1L.2DPV9W79YKN2C@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Mingyen Hsieh" <mingyen.hsieh@mediatek.com>, <nbd@nbd.name>,
 <lorenzo@kernel.org>
Cc: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
 <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
 <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
 <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
 <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
 <Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>, "Leon Yen" <leon.yen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the
 preset regulatory domain
X-Mailer: aerc 0.17.0
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>

On Fri Apr 12, 2024 at 10:53 AM CEST, Mingyen Hsieh wrote:
> From: Leon Yen <leon.yen@mediatek.com>
>
> Some countries have strict RF restrictions where changing the regulatory
> domain dynamically based on the connected AP is not acceptable.
> This patch disables Beacon country IE hinting when a valid country code
> is set from usersland (e.g., by system using iw or CRDA).

I always had trouble fully understanding the regulation but isn't the count=
ry
code IE sole purpose to adapt the regulatory of the client ?=20

>
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index ef0c721d26e3..3c9a5fcd6924 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -135,6 +135,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
>  	dev->mt76.region =3D request->dfs_region;
>  	dev->country_ie_env =3D request->country_ie_env;
> =20
> +	if (request->initiator =3D=3D NL80211_REGDOM_SET_BY_USER) {
> +		if (dev->mt76.alpha2[0] =3D=3D '0' && dev->mt76.alpha2[1] =3D=3D '0')
> +			wiphy->regulatory_flags &=3D ~REGULATORY_COUNTRY_IE_IGNORE;
> +		else
> +			wiphy->regulatory_flags |=3D REGULATORY_COUNTRY_IE_IGNORE;
> +	}
> +
>  	if (pm->suspended)
>  		return;
> =20


