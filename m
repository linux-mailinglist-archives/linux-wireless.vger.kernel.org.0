Return-Path: <linux-wireless+bounces-31015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJjQDKc0cGlzXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 03:06:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADB4F7FB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6856A72156A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7A33E356;
	Tue, 20 Jan 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLTsLSsB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723D39C627
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904778; cv=pass; b=KvNbPQpkewg6UsqBEzAjXvf5VTX8PA3MLv5UxBVlVmsW2L8fzzyVV1vmVP9aGQymfc9s9JtLQGJYpq5WCc2ulm2Vym3xlT830gTk0se/RDsU+Z/MuADVEjuT+gl/NOShnny5b3+FxqHYU6R7gnseCNbpQr0KCnxxghfiYcYaLoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904778; c=relaxed/simple;
	bh=2voIFGn6SR1MogbmE3kR3Vdr38x74Nd/URKdq4hbHvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ail2teDB1t1PExP5kCOnR2MbpjruaW+AKIQBev2bA2a7NIoUNjp7MJJGcBDRSaU/DzmmRlbAxIisYi+smYnVpkDeOLpSlMVMe/lr7B7Xr84yguL2CVBiB8rsY3DRYgVn9h2tAKnKdWK7CQI7gPIS5AY155ZJGZpAPZCa7Kt7QXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLTsLSsB; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b7bb3b913so6049289e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:26:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904775; cv=none;
        d=google.com; s=arc-20240605;
        b=j9p4ZWtcUk4u8sCWjUXD3wjAxlufI5oPFA3K99sth/49qrQtsTN8aWYMCt84yolfvf
         XaVRXDDg62ilaE+H6YUMxKFYu2tqKNQY9HIyRS+LUkB6xESCT0nINmidSSc9dfbvGtO3
         7qKco9PyUz86YULxOeGuAfKuN6YajVcT2utLBETaI7XtE+iXjL5Cvjm+KeTA6RdHR19v
         yihrVPraxHTl0fWGE7E0uKbztV7qdR8rVeTa3yrUtPeZdnNXlTIkEybC+1ACN36bFoyT
         eBrOfetFym4BDxBdJXi6Dv52vcHZNV/OKwMb+p3KoZ3OfgtRKltYT49NMJF4gwYrE+Uq
         Ya1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        fh=vusxz18HG9ypf4BioMslmopMbGr25xwfEsVGSIYd1+8=;
        b=kTGRHFJjGhHbkNPiSPK7nHydFH2QKC4A+1ouhhcb4CDuntSF/rLeh0Xd/+tjOYv6rt
         Dao0THHcGchrzHwxX143PzBqRPsTlh0RwdkTs6Js5iGXQvsmS3bG7mOFz8rrTx+CJOF3
         /VdfQN+CHAmKpk98k5sF+RLpeGNqMfW2Sl8lkND4StBCGzKzzXa4eld3CCegDfwhyTMR
         SySZqbVrMZ/FBuiSVOCxTqpq18fxgPvoC6grwEj0pxQCd/XPz4SUaGdKycD4Yid/MUt8
         NI/AKXwjpkjZfENocdFcfLF41zBhpnfk1dnRf7x0Q775UF6ebBHchOtq7aYTUOFr10oo
         LBmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768904775; x=1769509575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        b=SLTsLSsBmNdCC6K0hs7UxMOpWLLNe9OnzkqQV35PejWHCxehhZfZXrGQaaFNpWCCY+
         l0L8EXAZFZAjj7irvRlZeBB/rnX8X66H6vhKX2vCnu7Y/t09c3YTPRIatosRiBJlZ/AJ
         2N+RGPgPuByZlhxAYLoWMY7TliBGbTvCGYrKkXlN9tB6aNdrF13XETDOIA98huKqMGd6
         XVuoo2J7A+peDjrap3bp4j2UOXkmPnHtmDh5y9L5fSwcNaoJ+UAnbNYDQXrUuP4q0MvZ
         kCaXu3EF9rUqaS/igwsnpbbbZ/wvfFeb6LEY6M98PkPAhOjkjXfc26v0qwSOmkVEgwE6
         QzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904775; x=1769509575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dc4uOSwQ2vBzThtTBXaWxDon+kZapkB4rooEPiZwsE=;
        b=JX5Uqtp8Csbbbui14vF7QYzkJsxKkVVvpEapr9X1id1qXbdeWdjmIyBl5VJXNCqKID
         j6iBhGp/NbN7cbUqcHEhQA0MXGFExGt3hNlKDyZ14IGGKxaXZV7LlGZ6jb5DTfbIur0x
         IH7JQ1K8Zu0DRgiD0zIn6vZkVxSiyVApFyK9HVfWr+Rk8HWWAUIFNCyOgHF5UGdGZHfO
         rBB2bIJ449v5/mjAdSRMylfS62NamEWJ81pbb4c/PCep/Tr19uz7H6TGRnQZPhaPFuia
         hJZiBO2Ax1V159WtE1n2v7Oq3t7N+nF50f+mW7e5HHAnGcjBzfLRJQoBzeTcIfd/ajz4
         ZtQA==
X-Forwarded-Encrypted: i=1; AJvYcCX3u3pPXOlcsbX3umiDhXO0zXELxydV1BvZrkAQZcMZ1XkxSUnQEMPZ0mbxJaY6swsbGnvhRSabnM6MIvPm8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/j8HN/R7O++vS37JrD0R3ya7U3MKnoGCJg5Me2iV9KxA7PMa
	KN5SqixCAJX+wvYuDKjkGgfm+7i7IpZYzMU3knN+Zs+110pIRrFfT/PPyER9K0oU8TPBBygLOq5
	EBugfvJ+GPDfrwTlcP0F+A1FlEw6rQrXKi2X6bhl8TmcfaZgF95IWt4Q=
X-Gm-Gg: AZuq6aJKiG3S95E9FWM+E78EoEBYqw63T8mQm8YJ3K6X0ez6I4hEeaqNRuVF+bjGTnu
	TbyxuFRhfLwwBQg3PQRmtkguVod60kQ8GRkbrQ+N5J+ekUR5zmCI8qGwVI1OZ1bnpuxFzFhhhcH
	796l9nwt/FqXpnSZ0kguSrvyxB4ApPRANAh5kG8Mp1jgklMuW2mCOgiUWPm9S7+/32n74yUjgtl
	GK+IsqamGsYptNrugmAnpHsSD3JyaLMs2nPNVxxkZy1UqZPLO5/al6V05GgYgli6K2USps=
X-Received: by 2002:a05:6512:68e:b0:59b:9a12:8902 with SMTP id
 2adb3069b0e04-59ba719c7f9mr6571686e87.23.1768904774640; Tue, 20 Jan 2026
 02:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
 <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com> <v5jqdtpdj3zpuyo5owlujvifphjjxyygfrgqnmql664ck6vpc4@yvihqvp4lgka>
In-Reply-To: <v5jqdtpdj3zpuyo5owlujvifphjjxyygfrgqnmql664ck6vpc4@yvihqvp4lgka>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2026 11:25:38 +0100
X-Gm-Features: AZwV_Qioo1xVJnMg6rdq9cvpXXwdbJnFq0ihxCbSVN1OxJlswmdZiRgfxeUuarE
Message-ID: <CAPDyKFpzB82-pHwr+RtdiXcHPDDXyVh2xD+BVM635hP3bSJ8AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31015-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,linaro.org:dkim,baylibre.com:email]
X-Rspamd-Queue-Id: 94ADB4F7FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 19 Jan 2026 at 19:25, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Ulf,
>
> On Mon, Jan 19, 2026 at 04:00:48PM +0100, Ulf Hansson wrote:
> > On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *d=
rv, struct module *owner)
> > >         drv->drv.bus =3D &sdio_bus_type;
> > >         drv->drv.owner =3D owner;
> > >
> > > +       /*
> > > +        * This driver needs updating. Note that driver_register() wa=
rns about
> > > +        * this, so we're not adding another warning here.
> > > +        */
> > > +       if (!drv->shutdown && drv->drv.shutdown)
> > > +               drv->shutdown =3D sdio_legacy_shutdown;
> > > +
> >
> > Is this added only to keep the series bisectable or are there other
> > (except those you fix in the series) sdio func drivers that make use
> > of the shutdown callback?
>
> It's kept because I don't know if there are any other sdio driver in
> flight and these would break silently when they are applied between this
> series and the removal of the callbacks from struct device_driver.
>
> > In any case, when are you planning to remove this?
>
> So my plan is to remove this in a series where the last patch is the
> modification to struct driver.

Okay, thanks for clarifying!

Kind regards
Uffe

