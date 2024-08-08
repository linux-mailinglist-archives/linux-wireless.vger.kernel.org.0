Return-Path: <linux-wireless+bounces-11116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01094B93A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DF2B22560
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03C189910;
	Thu,  8 Aug 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTcrVAdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7F25634
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106913; cv=none; b=WY6SHEQSGAQNl17NVbX+Ds3K3doowXzj64O/0x5qdKizqRYgY18RrwSk+o+Jou+EOO0KI+KX2M6WsTWc7Pi/565LOkOaTEA1Bl94zFzEVIPy35ZCaD5YBalh/J7Jrvt/KPOZpkhsBYYpSGquDAng3pESyzoPvvI1tdRDoNyM+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106913; c=relaxed/simple;
	bh=N1di3AhZq6gC2dNdiXRfIpCMK2P1Do4/oW+HRrn96as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joju5pImFy5p3mpkByPWbzALCryguvwMwSde5poWaO3VB1cZZ1dvgMvjXh5X7P0F5Ggnmv48wpbndehM6ow92y+EGCD8BEjKneGUzAzZujk53oa/+x6ghZ4BKulqQfRaczoULiRrMMNIbRyGg+NNe1eC4VQuY4RiI7LmXOXEJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTcrVAdL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso722269a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723106906; x=1723711706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAeMUrDjoEhhZo3nL2giFaO/j5MNhR5GHBniSOc8n8k=;
        b=ZTcrVAdLEibnwk1dWSK4Hv5Q4wTYuhpzAa1PPFC1J4tyuTy1GnE4vmio04TDcBP4qL
         Paf1FeXx66rDwe8Wzd0rnlVZRaPeVTrWhVGbTrAcO3dEgC6Wibxckeg/+Yj5u3QUeLVf
         O0K1IdqGNfiZeqVYuydzrr4vsDZ2lPW1zIANQpZlA759/zHdKnBMiOcjbB6ZASmTuVfn
         WxfAdm7yNNh0ejswuFzpxyUuHB9KnJ7S/IhjrjC+Eu58IQ1WgOpTVNCPoCE0CXDUlYEr
         xaUqNXmEemTEew+TiRicNmLvQVIZiZNeWgpq97XN0ujEuwDzwGJ8gFXGc1FtI0Ncvju9
         nqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723106906; x=1723711706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAeMUrDjoEhhZo3nL2giFaO/j5MNhR5GHBniSOc8n8k=;
        b=hBWeAU/CjXrC1eeLdrH11mgxPaVv2f5MKdnaJKzgCClnz/CoVFDzp52U1A5+gYYP3J
         4q+Ewaej74/2mZH4GUJZ2VD+wjOX68ty/x4wOnRF5AwIK+3kOg3JQU4vKnqKjTGm4Jcc
         SMQ8ABIdQWZ57pzM0Tiz4WXuFSFgAP6Rn99emE8GHWidNegA0CC608APNm4YYrHO8IW1
         0uKPgCd2uvOgMnt3ZNH3KA1vYlLjGyXk32At0v/2YLxmfTGKjytnvbh5/ZdlYKGy71Qe
         N2SR2Nt0jkCMm7LAeM1owWUpl6x8jZlauMZZqQjo62Oyv28S1lr1ZhBhcscofxHZbH64
         9q9w==
X-Forwarded-Encrypted: i=1; AJvYcCW8uGeK59h6neAo+E7PIW7abOv1ok79qIzVpnutQwEtmbTq+DTTkw2p00WngIjLAlZy9GjdO2QY2yWTdUOmHxIq6WNJUCVMmGAZNSK6Niw=
X-Gm-Message-State: AOJu0YzPHJyGoYPgtDwmTax7Navugbtt47vZEJPfHXvUL9RUs6Or7fYw
	X3NhxMhf7s3gj8kNvJEjLi9fVaKbEtITlvlQVs/FYTDNBY9o7HVy5WgUCqGRS2yBL5tYx1ed3LV
	ZYYP8XvqkpERn0WgDnDmXb+3rZoo=
X-Google-Smtp-Source: AGHT+IHx0SAtxoa2i1deGkKHtyaRmeEqqjISbxbAgFaauQmz54BqKm/uMkXHyMSv/u9bEoiNnKfpkg5htzl6aHw/q8g=
X-Received: by 2002:a05:6402:d08:b0:5a1:3b03:d0cb with SMTP id
 4fb4d7f45d1cf-5bbb23e610dmr953753a12.32.1723106905523; Thu, 08 Aug 2024
 01:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com>
 <910f590eea414eb985a4000536e21800@realtek.com>
In-Reply-To: <910f590eea414eb985a4000536e21800@realtek.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 8 Aug 2024 09:48:14 +0100
Message-ID: <CALeDE9O3Rh75jvV7rgUO24HDpZs0dhbWkvH7_yPXPCqbv1kPfg@mail.gmail.com>
Subject: Re: Crash when rmmod the rtw88_8723cs driver
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>, Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping-Ke,

On Wed, 7 Aug 2024 at 04:49, Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> Hi Peter,
>
> >
> > # rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> > [ 3698.067354] wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
> > choice (Reason: 3=3DDEAUTH_LEAVING)
> > [ 3698.300937] ------------[ cut here ]------------
> > [ 3698.305987] Have pending ack frames!
>
> I think that is because TX skb isn't acked to mac80211. Please apply belo=
w
> changes to see if it can fix the problem.
>
>
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index 763aa8212a4b..7b1ec5ba80e6 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1297,7 +1297,7 @@ static void rtw_sdio_deinit_tx(struct rtw_dev *rtwd=
ev)
>         int i;
>
>         for (i =3D 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
> -               skb_queue_purge(&rtwsdio->tx_queue[i]);
> +               ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i=
]);
>
>         flush_workqueue(rtwsdio->txwq);
>         destroy_workqueue(rtwsdio->txwq);
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wirel=
ess/realtek/rtw88/usb.c
> index 9145c11a063e..e6b244135ca3 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -423,10 +423,11 @@ static void rtw_usb_tx_handler(struct work_struct *=
work)
>
>  static void rtw_usb_tx_queue_purge(struct rtw_usb *rtwusb)
>  {
> +       struct rtw_dev *rtwdev =3D rtwusb->rtwdev;
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
> -               skb_queue_purge(&rtwusb->tx_queue[i]);
> +               ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_queue[i]=
);
>  }

The USB bit doesn't compile because rtwdev is undeclared:

drivers/net/wireless/realtek/rtw88/usb.c: In function
=C3=A2=E2=82=AC=CB=9Crtw_usb_tx_queue_purge=C3=A2=E2=82=AC=E2=84=A2:
drivers/net/wireless/realtek/rtw88/usb.c:424:42: error: =C3=A2=E2=82=AC=CB=
=9Crtwdev=C3=A2=E2=82=AC=E2=84=A2
undeclared (first use in this function); did you mean =C3=A2=E2=82=AC=CB=9C=
rtw_dev=C3=A2=E2=82=AC=E2=84=A2?
  424 |                 ieee80211_purge_tx_queue(rtwdev->hw,
&rtwusb->tx_queue[i]);
      |                                          ^~~~~~
      |                                          rtw_dev
drivers/net/wireless/realtek/rtw88/usb.c:424:42: note: each undeclared
identifier is reported only once for each function it appears in

I dropped that snippet of the patch as the sdio bit doesn't have that
problem so I could still test and provide feedback.

With just the sdio piece on the Pinephone I no longer get a crash with
6.11.-rc2 when testing with the wifi not connected to an AP as well as
connected and doing a few cycles with different bits works fine
without issue and the wifi still works so apart from a fix for the USB
piece I can give a:

Tested-by: Peter Robinson <pbrobinson@gmail.com> # Pinephone

Regards,
Peter

>  static void rtw_usb_write_port_complete(struct urb *urb)
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 0a04eaf5343c..f11844f0c80f 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -3180,6 +3180,17 @@ ieee80211_get_alt_retry_rate(const struct ieee8021=
1_hw *hw,
>   */
>  void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
>
> +/**
> + * ieee80211_purge_tx_queue - purge TX skb queue
> + * @hw: the hardware
> + * @skbs: the skbs
> + *
> + * Free a set of transmit skbs. Use this function when device is going t=
o stop
> + * but some transmit skbs without TX status are still queued.
> + */
> +void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
> +                             struct sk_buff_head *skbs);
> +
>  /**
>   * DOC: Hardware crypto acceleration
>   *
> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> index dd8f857a1fbc..d1cf987de13b 100644
> --- a/net/mac80211/status.c
> +++ b/net/mac80211/status.c
> @@ -1301,3 +1301,4 @@ void ieee80211_purge_tx_queue(struct ieee80211_hw *=
hw,
>         while ((skb =3D __skb_dequeue(skbs)))
>                 ieee80211_free_txskb(hw, skb);
>  }
> +EXPORT_SYMBOL(ieee80211_purge_tx_queue);
>
>

