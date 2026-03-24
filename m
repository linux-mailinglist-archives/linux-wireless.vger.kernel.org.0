Return-Path: <linux-wireless+bounces-33780-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEhpEzKqwmkyggQAu9opvQ
	(envelope-from <linux-wireless+bounces-33780-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:13:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1111317CA1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02B873090CEC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365664035CB;
	Tue, 24 Mar 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Ih6imk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260F405AAE
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364842; cv=pass; b=VYFUl8NKr7C2LTWnFuZPloClhTeMCr3AtB2LHxTcmqaj5Z5wPWLEdV6AQ6U4H89bOauDcuuCU2Rb+/sE9KXpaXKe3Hkq6NaOY6OSosWuxZugCBPgdFYc4pNcO/TggaDishWndZmsa30WLodMFikcb6BRCLiuJ0IDmDOFws77Qdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364842; c=relaxed/simple;
	bh=TpoGWw+v/2jxbHdvDGNJxdMEdB6f7zdrgJHKiONwIpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXs47MA9xgDrOI6YB3ydfuNIwzfnrL7jqwv5HefBaDz2uvc4jXc6xyxGw40VZOpN1Jn7ZjzpOxg9zHyZBce0a9XNsW8LTCNWC23glHgQQy9FzDfZn9CmEokGVdhl1K8Kxc6eadDIFLKH9IREEiLWoWQ5qXXbNQ5PqbO7uWFqH3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9Ih6imk; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so2075239a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 08:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364839; cv=none;
        d=google.com; s=arc-20240605;
        b=KmS15Qp/+HYOvNh+AgKiqOvfU54ulirZYgYrtNtI30TCBsMBge60IWYURjA2VOjLFm
         u9UwaNpNgQCv/iULdjub3ktgNJLREAWZdwJHb6XKdajEsq1DKs0awMjaLrm87FrIImWA
         ioSHSStQhg7t1Qt4s1qOQM1TN+4Qa3RY9GUcopNu3IXbZiRtV738mmu0Jx/c8XXQLaWG
         yEG/4kR1GowkrjxrfseEKhmzrhSoJeaBEshUpPIunMNwupKmuCy/Zf02ojPScCgpnd30
         QCQyTKbZEE7UWN85a/2bCK+e+inVQx+91+XGMyV7kb99dT6/kWS8ejrUhyXkXmxmzUyt
         ypZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        fh=1+nuKYjYlOLSiKH8QFnhtw2ecKu39BKYV+9vUSfPStI=;
        b=XCXS7S86VCH2NZMVC/aPPy8WtN+/zhjDfCUgjb20kn2pmLB9T0vL/4F2QksamQBJOK
         dnGoB3dTPaqo862xbwKd+J8/ZiAHjZI4CPugkwv1sjRa5yZBAVYEDYTbbb3lJNVb49Tf
         yEgKPqde4JxW8dfVu8znG9g1IhBOFW8OsVeyYVEuLIv5VZYf8hjCZGlYBFJCdTUgVV1b
         Ixp5SALPWUqKPQiUIKwYlLnxRC0fpuXRajc5OsiU5iipBkXBijP0xSZHcFmzUELJ633+
         9nW6WXV3XF/bvLeYvMRWcMPw5RBOBBW6hyqLllUJO7Z833vcSuLvGg2k6qEap1sva5cF
         pLPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364839; x=1774969639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        b=I9Ih6imkWgcOcQsRV1XQmXv5RCJP9UKPxpDgb/ajsHsUXBnH4sc9nl2I6ibqhO5KU0
         c3R26X7saSIsg5H1B7FbK7mp+oygTBLuYNPzblTvUhYeFDMOe5PVf+Ab8Wm7bMgZgMwj
         xQTxlY57Guw5RVYOtvZCCNq4FIFksP69R8WTleH6pJjoJ+iJx3xsGX1ROFOIjEmF+PxH
         4jdEJ6X2h5nXuhG3OtIRnrzfh4VEP/iBjZoszXRrzUB9N/QHPPDiumhpAE+yUFco9xyf
         vnQVj9oR4XWzxK3aYOTgiUjFcQWr+Kd3tDl4dbV33vtBh1M5FLdDIDZZEcTczTWVO9Sr
         bcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364839; x=1774969639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgORygUVD3DZVAnZlL9wOEuI4Pcd93v5L/PxzCz3DS4=;
        b=E25ekn7LUXL3YFzKzqAm/bu+ftrEjtENocz4VKSkIc/FBhMONvnleiCm1FoY+b7tbv
         OQm3z+wF8EnEdjuuYmxn0s0V1piAjZiaUi4dvhbYrxe4HyZ7GbVlwgz2bvyp0+6VmgsB
         ObVjybzSs8etaUlzQ4Ig6oi+U45Z1KL97vm+f4lrwmTKiq6GvE/GFcer8zj0VIS5Kv4F
         8oyCPEnvo/1MOwBTHGzrJHOsk5g37i8vo4/OjvmAqxslmkgKbSiIl3o/xQvgTap2PIaP
         0N+xZmy8tp9PIecnISBFEbInYh4iA9qSRh+9IyvbYtRQf/zQLTDBTXP9SPugOIm94gVb
         7j5g==
X-Gm-Message-State: AOJu0Yygsma0iXwJ0LVB+V3jAnXbEgKjt/X4++DxHyWqd7OYRLhbkLeJ
	0Qo/hLWXR3ApOyMVSuWiTl4E+nqzmSK2zBqIseRnVtUdkmbVQqino/vChRcFTscZmsDJmyGtKAZ
	7k7dCz3/4nsi+tnW8mZQ4Yj/aJyDaDpQ=
X-Gm-Gg: ATEYQzyLAH1IhNRJhfzIo20yQBNddzBD53qv5PsPfuTh87q/dg0DgYFm0vjO/2UhxHA
	JPnngNm3fhCu4CceMCBLUaj9qpJf8Z3tPOaITzvp/8IiJF+9dmrv1Rg34TOjh/ClpesyNPZDsrq
	n5+QS0eypdiUpkdFqUeDjjt3HYMrroJpilnKU/A6cVXOedHdfK/58ap/srKrmEilG9daPsfx4q1
	cyIAANXeGyRi0iUnUfTmwN4HD/gqdzgZisJMAnBnITB1Kv6n7M/tDXvNrDYjtOo4ZGdE0JngQU2
	PuI5FAclFyYX51ahoj24QhiFY+ec/FZWDiHHNWMO837DpHJ4Ng==
X-Received: by 2002:a17:906:d293:b0:b97:2a5:8a4d with SMTP id
 a640c23a62f3a-b982f362d97mr846687766b.26.1774364838745; Tue, 24 Mar 2026
 08:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324100624.983458-1-yasuakitorimaru@gmail.com> <accee45c-7cae-48fc-b868-b7404b8c061c@oss.qualcomm.com>
In-Reply-To: <accee45c-7cae-48fc-b868-b7404b8c061c@oss.qualcomm.com>
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Date: Wed, 25 Mar 2026 00:07:07 +0900
X-Gm-Features: AaiRm53hpRCNywt2V51FnaLY0utiY_CyfA6i6OH09VtGrMwZyt9ab5Rg2t3NByA
Message-ID: <CAA2s7u7jpm2Q=18+pAxC2szqUjQ+3xSXokCT85YsAFKOLf4Zsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ajay.kathat@microchip.com, 
	claudiu.beznea@tuxon.dev, kees@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33780-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: E1111317CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 25 Mar 2026, Jeff Johnson wrote:
  > Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
  >
  > Another thing to note is it is very strange that the struct wid that de=
fines
  > the TLV format uses a signed type for both the TLV length and
payload pointer:
  >         s32 size;
  >         s8 *val;
  >
  > I don't think I've ever seen this in a TLV representation!

  Thank you for the review.

  Good point =E2=80=94 signed types for TLV length and payload are indeed u=
nusual
  and could mask subtle sign-extension bugs. I'll look into a follow-up
  cleanup patch for struct wid once this fix lands.

  Thanks,
  Yasuaki

2026=E5=B9=B43=E6=9C=8824=E6=97=A5(=E7=81=AB) 23:50 Jeff Johnson <jeff.john=
son@oss.qualcomm.com>:
>
> On 3/24/2026 3:06 AM, Yasuaki Torimaru wrote:
> > The variable valuesize is declared as u8 but accumulates the total
> > length of all SSIDs to scan. Each SSID contributes up to 33 bytes
> > (IEEE80211_MAX_SSID_LEN + 1), and with WILC_MAX_NUM_PROBED_SSID (10)
> > SSIDs the total can reach 330, which wraps around to 74 when stored
> > in a u8.
> >
> > This causes kmalloc to allocate only 75 bytes while the subsequent
> > memcpy writes up to 331 bytes into the buffer, resulting in a 256-byte
> > heap buffer overflow.
> >
> > Widen valuesize from u8 to u32 to accommodate the full range.
> >
> > Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
>
> Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>
> Another thing to note is it is very strange that the struct wid that defi=
nes
> the TLV format uses a signed type for both the TLV length and payload poi=
nter:
>         s32 size;
>         s8 *val;
>
> I don't think I've ever seen this in a TLV representation!
>
> > ---
> >  drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/ne=
t/wireless/microchip/wilc1000/hif.c
> > index f354b11cb919..944b2a812b63 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/hif.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
> > @@ -163,7 +163,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source,
> >       u32 index =3D 0;
> >       u32 i, scan_timeout;
> >       u8 *buffer;
> > -     u8 valuesize =3D 0;
> > +     u32 valuesize =3D 0;
> >       u8 *search_ssid_vals =3D NULL;
> >       const u8 ch_list_len =3D request->n_channels;
> >       struct host_if_drv *hif_drv =3D vif->hif_drv;
>

