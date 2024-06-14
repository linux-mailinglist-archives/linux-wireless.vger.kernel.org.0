Return-Path: <linux-wireless+bounces-9009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE294908AE6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ACA1C2149C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC61186E5D;
	Fri, 14 Jun 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL470l5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4D14D29B
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364932; cv=none; b=JVl5gXQFEGdV+2UWORJH19l73QjPlBxKcJ/eXfgQ/l41W8jykW7p8uIpBVZ4l0Uzwajfa+6+NdXuIWzgWfhXjrgwgFa9yCJek/x3lTYySMFFYiL93figQ66rJkJ4SvazSjUCTbAHgyWIOTcTowa9Z69BJmIVQFHVE6d9TiBNGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364932; c=relaxed/simple;
	bh=gx0fcpwfWFHcsEZ1H/x1sQo/vSIDp8bKXfJiPHrzFKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFwfn/2dHUEu3r3crZ2bipL9RS2sS5kcTT7yLJ+pV1JmUTMh1XzhfoJdelf2ARzXt8RD3nvMRjrx7ktwCCXdirumfOYShaLQP/E4YKYIQyHD0WagQm8NXrC+M/aU5AGbIqQfrBMxEZpwt0MeeCBp48PSFPK25BiQqJxpKongy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL470l5L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso493995b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718364930; x=1718969730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXQRdYkaAIA5e5P/IZNXmqC6c8pMTH7xW4+jQBnuqFY=;
        b=mL470l5LXk+yclKwuEjkywLaHqL69aZrK/jVGzV3Nj7wu89e0D0+cdamldPERfbskV
         X2uFYYcf3PfLiUywAwHo73+hLhoakDnZrghpSkThOHojNfoZLwImtrUIHruvuYBLtebj
         jL/4iAKtXm8TUfwKH1oGnW3YQcpP8YOAd60MA+WnHrOzFltWt0LFqe+VHg/g/Gb/03Ph
         DCs1IfOtyJ6LLADwhbImHJJGsvUvK6du05d+jomvCoRQ9uJq1/Bd8my7aRW4076AHNVG
         88yxTOOdAo0zKCUAs//0rYl07cZQH1e/7b5dE4i3DvLPlDNhRqIvgVHqmWNbbTRB45kF
         de8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718364930; x=1718969730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXQRdYkaAIA5e5P/IZNXmqC6c8pMTH7xW4+jQBnuqFY=;
        b=rnKa0t5cbVayHB1vdz0TD2tKvIbPHD6QnFtHDIzNZ7WlNAHb7oGoSp8CWXKShQOy/X
         BVlBhX6jk+dOrr6uQbm63VFwl2LTl/3DMUGmZM2CNSVkx3WFuhNBBzGKKSI34EUC1Aik
         W+ndZ1+2RVyLjk01DhAZgBGqqdPiHGOEEbg15cn38D+TK++V9dKWk5y9pQ+rd0yyQN3z
         zOuAjc7GG0iApvAU8BwPYZb3eA6fO/EKAHmrA2SVy6YaIW92zGKPvocQAPgy29waRoVA
         it/GvGbPWIF/Y5oRnu6loa4bTRWhT9W8NCpQVxlbHVzk2MS5VXB+0hSgvNqapsVaNHO0
         RocA==
X-Gm-Message-State: AOJu0Yx8j9s6lTt6PYfuAb56A+pFvpeOGgziRZX7ekfGJsDDGeO5/eS2
	Qk6svXoCkX0Aaz1QsrbX7q1cMTu2a6n0if3aHzQA0oOCy2VGlCLRDnk0E1DKdAdRWuGTrb8Mj++
	JYr7w5WIRgfEpCqEiHiZ3qQcQK7E=
X-Google-Smtp-Source: AGHT+IFZg8O9gdQo7mNw5/EZCAc0TEJRpKjEWRvH4GIntDnmae8M7+kKJ/hMisZhYvpQzFE8fbtOadv0ZEuxvTR8IV0=
X-Received: by 2002:a05:6a20:6a26:b0:1b3:fa57:647f with SMTP id
 adf61e73a8af0-1bae7f01b72mr2827321637.31.1718364929815; Fri, 14 Jun 2024
 04:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
 <20240603145535.1858856-1-marcin.slusarz@gmail.com> <0063cfc3468f4203a2e5db43d949b10b@realtek.com>
In-Reply-To: <0063cfc3468f4203a2e5db43d949b10b@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Fri, 14 Jun 2024 13:35:18 +0200
Message-ID: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88/usb: stop rx work before potential power off
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 4 cze 2024 o 02:57 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > From: Marcin =C5=9Alusarz <mslusarz@renau.com>
> >
> > Avoids WARN_ON(!local->started) in ieee80211_rx_list, after
> > the patch that disables power management of 8821CU.
>
> Please describe how/what you do in this patch.
>
> >
> > Signed-off-by: Marcin =C5=9Alusarz <mslusarz@renau.com>
> > ---
> >  drivers/net/wireless/realtek/rtw88/hci.h  | 12 +++++++
> >  drivers/net/wireless/realtek/rtw88/main.c |  7 +++-
> >  drivers/net/wireless/realtek/rtw88/pci.c  |  6 ++++
> >  drivers/net/wireless/realtek/rtw88/sdio.c |  6 ++++
> >  drivers/net/wireless/realtek/rtw88/usb.c  | 40 +++++++++++++++--------
> >  drivers/net/wireless/realtek/rtw88/usb.h  |  1 +
> >  6 files changed, 58 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wir=
eless/realtek/rtw88/hci.h
> > index 830d7532f2a3..d1b38b34fdd0 100644
> > --- a/drivers/net/wireless/realtek/rtw88/hci.h
> > +++ b/drivers/net/wireless/realtek/rtw88/hci.h
> > @@ -18,6 +18,8 @@ struct rtw_hci_ops {
> >         void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
> >         void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
> >         void (*interface_cfg)(struct rtw_dev *rtwdev);
> > +       void (*stop_rx)(struct rtw_dev *rtwdev);
> > +       void (*start_rx)(struct rtw_dev *rtwdev);
> >
> >         int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u3=
2 size);
> >         int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size=
);
> > @@ -57,6 +59,16 @@ static inline void rtw_hci_stop(struct rtw_dev *rtwd=
ev)
> >         rtwdev->hci.ops->stop(rtwdev);
> >  }
> >
> > +static inline void rtw_hci_start_rx(struct rtw_dev *rtwdev)
> > +{
>
> For PCI/SDIO nop, I would like to give them NULL, so here can be
>
> if (rtwdev->hci.ops->start_rx)
>         rtwdev->hci.ops->start_rx(rtwdev);

Sure

>
> > +       rtwdev->hci.ops->start_rx(rtwdev);
> > +}
> > +
> > +static inline void rtw_hci_stop_rx(struct rtw_dev *rtwdev)
> > +{
> > +       rtwdev->hci.ops->stop_rx(rtwdev);
> > +}
> > +
> >  static inline void rtw_hci_deep_ps(struct rtw_dev *rtwdev, bool enter)
> >  {
> >         rtwdev->hci.ops->deep_ps(rtwdev, enter);
> > diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wi=
reless/realtek/rtw88/main.c
> > index a48e919adddb..bb0122d19416 100644
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -1357,7 +1357,7 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
> >         int ret;
> >
> >         if (rtwdev->always_power_on && test_bit(RTW_FLAG_POWERON, rtwde=
v->flags))
> > -               return 0;
> > +               goto success;
>
> rtw_hci_start_rx(rtwdev) is only needed by this case, so
>
> if (rtwdev->always_power_on && test_bit(RTW_FLAG_POWERON, rtwdev->flags))=
 {
>         rtw_hci_start_rx(rtwdev);
>         return 0;
> }

Yes, strictly speaking, it's needed only in the always_power_on case,
but doing that in the common code path ensures that it's tested and
still works.

>
> >
> >         ret =3D rtw_hci_setup(rtwdev);
> >         if (ret) {
> > @@ -1407,6 +1407,9 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
> >         rtw_coex_power_on_setting(rtwdev);
> >         rtw_coex_init_hw_config(rtwdev, wifi_only);
> >
> > +success:
> > +       rtw_hci_start_rx(rtwdev);
> > +
> >         return 0;
> >
> >  err_off:
> > @@ -1509,6 +1512,8 @@ int rtw_core_start(struct rtw_dev *rtwdev)
> >
> >  static void rtw_power_off(struct rtw_dev *rtwdev)
> >  {
> > +       rtw_hci_stop_rx(rtwdev);
> > +
>
> Similarly here can be
>
> if (rtwdev->always_power_on) {
>         rtw_hci_stop_rx(rtwdev);
>         return;
> }

Ditto

>
>
> >         if (rtwdev->always_power_on)
> >                 return;
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wir=
eless/realtek/rtw88/pci.c
> > index 7a093f3d5f74..0a3ec94f6ab2 100644
> > --- a/drivers/net/wireless/realtek/rtw88/pci.c
> > +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> > @@ -1590,6 +1590,10 @@ static void rtw_pci_destroy(struct rtw_dev *rtwd=
ev, struct pci_dev *pdev)
> >         rtw_pci_io_unmapping(rtwdev, pdev);
> >  }
> >
> > +static void rtw_pci_nop(struct rtw_dev *rtwdev)
> > +{
> > +}
> > +
> >  static struct rtw_hci_ops rtw_pci_ops =3D {
> >         .tx_write =3D rtw_pci_tx_write,
> >         .tx_kick_off =3D rtw_pci_tx_kick_off,
> > @@ -1600,6 +1604,8 @@ static struct rtw_hci_ops rtw_pci_ops =3D {
> >         .deep_ps =3D rtw_pci_deep_ps,
> >         .link_ps =3D rtw_pci_link_ps,
> >         .interface_cfg =3D rtw_pci_interface_cfg,
> > +       .stop_rx =3D rtw_pci_nop,
> > +       .start_rx =3D rtw_pci_nop,
> >
> >         .read8 =3D rtw_pci_read8,
> >         .read16 =3D rtw_pci_read16,
> > diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wi=
reless/realtek/rtw88/sdio.c
> > index 0cae5746f540..4a7923851c81 100644
> > --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> > +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> > @@ -1147,6 +1147,10 @@ static void rtw_sdio_declaim(struct rtw_dev *rtw=
dev,
> >         sdio_release_host(sdio_func);
> >  }
> >
> > +static void rtw_sdio_nop(struct rtw_dev *rtwdev)
> > +{
> > +}
> > +
> >  static struct rtw_hci_ops rtw_sdio_ops =3D {
> >         .tx_write =3D rtw_sdio_tx_write,
> >         .tx_kick_off =3D rtw_sdio_tx_kick_off,
> > @@ -1156,6 +1160,8 @@ static struct rtw_hci_ops rtw_sdio_ops =3D {
> >         .deep_ps =3D rtw_sdio_deep_ps,
> >         .link_ps =3D rtw_sdio_link_ps,
> >         .interface_cfg =3D rtw_sdio_interface_cfg,
> > +       .stop_rx =3D rtw_sdio_nop,
> > +       .start_rx =3D rtw_sdio_nop,
> >
> >         .read8 =3D rtw_sdio_read8,
> >         .read16 =3D rtw_sdio_read16,
> > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wir=
eless/realtek/rtw88/usb.c
> > index e1b66f339cca..d5cf3eb51c8a 100644
> > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > @@ -716,6 +716,30 @@ static void rtw_usb_interface_cfg(struct rtw_dev *=
rtwdev)
> >         /* empty function for rtw_hci_ops */
> >  }
> >
> > +static void rtw_usb_stop_rx(struct rtw_dev *rtwdev)
> > +{
> > +       struct rtw_usb *rtwusb =3D rtw_get_usb_priv(rtwdev);
>
> Do we really need a ' rtwusb->rx_enabled' to maintain symmetric calling o=
f
> start/stop_rx? If yes, here should add
>
>         if (!rtwusb->rx_enabled)
>                 return;

Sure

> But, I don't like that flag if it isn't strongly required.

It's required because start_rx is called twice initially - from
rtw_usb_probe and rtw_core_start (via rtw_power_on).

>
> > +       rtw_usb_cancel_rx_bufs(rtwusb);
> > +       rtwusb->rx_enabled =3D false;
> > +}
> > +
> > +static void rtw_usb_start_rx(struct rtw_dev *rtwdev)
> > +{
> > +       struct rtw_usb *rtwusb =3D rtw_get_usb_priv(rtwdev);
> > +       int i;
> > +
> > +       if (rtwusb->rx_enabled)
> > +               return;
> > +
> > +       for (i =3D 0; i < RTW_USB_RXCB_NUM; i++) {
> > +               struct rx_usb_ctrl_block *rxcb =3D &rtwusb->rx_cb[i];
> > +
> > +               rtw_usb_rx_resubmit(rtwusb, rxcb);
> > +       }
> > +
> > +       rtwusb->rx_enabled =3D true;
> > +}
> > +
> >  static struct rtw_hci_ops rtw_usb_ops =3D {
> >         .tx_write =3D rtw_usb_tx_write,
> >         .tx_kick_off =3D rtw_usb_tx_kick_off,
> > @@ -725,6 +749,8 @@ static struct rtw_hci_ops rtw_usb_ops =3D {
> >         .deep_ps =3D rtw_usb_deep_ps,
> >         .link_ps =3D rtw_usb_link_ps,
> >         .interface_cfg =3D rtw_usb_interface_cfg,
> > +       .stop_rx =3D rtw_usb_stop_rx,
> > +       .start_rx =3D rtw_usb_start_rx,
> >
> >         .write8  =3D rtw_usb_write8,
> >         .write16 =3D rtw_usb_write16,
> > @@ -754,18 +780,6 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
> >         return 0;
> >  }
> >
> > -static void rtw_usb_setup_rx(struct rtw_dev *rtwdev)
> > -{
> > -       struct rtw_usb *rtwusb =3D rtw_get_usb_priv(rtwdev);
> > -       int i;
> > -
> > -       for (i =3D 0; i < RTW_USB_RXCB_NUM; i++) {
> > -               struct rx_usb_ctrl_block *rxcb =3D &rtwusb->rx_cb[i];
> > -
> > -               rtw_usb_rx_resubmit(rtwusb, rxcb);
> > -       }
> > -}
> > -
> >  static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
> >  {
> >         struct rtw_usb *rtwusb =3D rtw_get_usb_priv(rtwdev);
> > @@ -903,7 +917,7 @@ int rtw_usb_probe(struct usb_interface *intf, const=
 struct usb_device_id *id)
> >                 goto err_destroy_rxwq;
> >         }
> >
> > -       rtw_usb_setup_rx(rtwdev);
> > +       rtw_usb_start_rx(rtwdev);
> >
> >         return 0;
> >
> > diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wir=
eless/realtek/rtw88/usb.h
> > index 86697a5c0103..a6b004d4f74e 100644
> > --- a/drivers/net/wireless/realtek/rtw88/usb.h
> > +++ b/drivers/net/wireless/realtek/rtw88/usb.h
> > @@ -82,6 +82,7 @@ struct rtw_usb {
> >         struct rx_usb_ctrl_block rx_cb[RTW_USB_RXCB_NUM];
> >         struct sk_buff_head rx_queue;
> >         struct work_struct rx_work;
> > +       bool rx_enabled;
> >  };
> >
> >  static inline struct rtw_usb_tx_data *rtw_usb_get_tx_data(struct sk_bu=
ff *skb)
> > --
> > 2.25.1
> >
>

