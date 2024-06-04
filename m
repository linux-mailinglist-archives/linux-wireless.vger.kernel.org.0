Return-Path: <linux-wireless+bounces-8500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D260F8FBFAD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 01:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DB1B2446A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572614D2B8;
	Tue,  4 Jun 2024 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmqu/Jb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB214B077
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542733; cv=none; b=WiX3oc/Gvttj1Miz2alFPndL1rx/iPbtBcvYLCT8LTJqqMIt360oALqkZx0FffKYFD6rcv56bgvjr/vFaDzwwm//wq42vG547u4jAaJA9ZnY51UCJgjAScPw6IMs6lMrPVete0oFcN367KSwWZjHJTNTjdfQFx8QHgyzIaA2EDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542733; c=relaxed/simple;
	bh=Nncx+VVQYs0qKAe+KYVC/Kq04OFO3sM0r6o5Yfj4L+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0yU4YTS6Dlp6hoNm9cwmKWC1Or2+4Ku9S8kfy8UvrJtU3D33mlBl92xuQgU8PvO5+3VC3vhWC+1ZhV+wlAexsAZkFAFoGtKdXpwad75YHROviylbQp7NuZNKop6xJBjOoIUFdbstdIFHZiWegSxpWQVCHimIdW4M6IxgmzvqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmqu/Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3FC4AF08
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717542732;
	bh=Nncx+VVQYs0qKAe+KYVC/Kq04OFO3sM0r6o5Yfj4L+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TGmqu/JbAds/BOUP6NJv9uDpQdDc/BI2Phd0s9JNPrcmBLG2b00Ut5yLxZHbL7SSB
	 krisyQgobjXaZorWf4l7kqFMtC+Od9Zts3EgMdfjex8DS3FmGHFvSdyAojCYOrl0ox
	 bW3YgkUNt/eCOBfMRZxWUmcKMDnyOT4z5w42AYSLicrupkQ023phB9VeWrRXzrm5j6
	 bN6d4b4NkRj3xE3WVZWNKCvVIcEtd+0+g2LrdApNE85ph2nWB1gwLoDqzFxTtqBvNH
	 H9oFsM9keKhxve5qd7O18oO+7T0TDa3+pkPg7ZaHuIW4d+tFXpH0QfGBWRyGUK+mk1
	 QAZeW5Wu62EUQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a861f8faaso134060a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 16:12:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqERhc89Orvgs86eUcDFBOAfKloV1Rb6yrSJ3+p7hbEj/2Yg2Op+CuqNRM8s+PjekVcJDkR5OeJ37TvG+bW3o4fhkb1T7w7KZ0VpQZHLg=
X-Gm-Message-State: AOJu0YwMJN8g/CS+f96NMRpyyAzJcjhzqlBREKWWgZ8XttnYItqjhUNt
	ZpnSbzkZFUlEXdmoxWO+bZogSVtM+D/nQY6HRHOyKl0+XBL4tiMbMyQv9ipTo6OPZLcR9OtHBue
	Mzf++i0wje04uLt+OSszohZBDnrg=
X-Google-Smtp-Source: AGHT+IFBy/YLm3dKndSIi0drXsYIFEcFE6IgO+ZhYtbwCYfAKF4s8Yf1d2uOu0EPT0ChXDxKpI637E40N+LOAI1+bGE=
X-Received: by 2002:a17:907:90d5:b0:a68:5676:275d with SMTP id
 a640c23a62f3a-a69a026fc59mr36867566b.6.1717542731220; Tue, 04 Jun 2024
 16:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523112131.31437-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240523112131.31437-1-mingyen.hsieh@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 4 Jun 2024 16:11:58 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrPUUjo8xLNdUddu=GCd2T8PP=Cw_+MKQCw23Emeg=n6Q@mail.gmail.com>
Message-ID: <CAGp9LzrPUUjo8xLNdUddu=GCd2T8PP=Cw_+MKQCw23Emeg=n6Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt792x: fix scheduler interference in drv
 own process
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Michael Lo <michael.lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 23, 2024 at 4:21=E2=80=AFAM Mingyen Hsieh
<mingyen.hsieh@mediatek.com> wrote:
>
> From: Michael Lo <michael.lo@mediatek.com>
>
> Add some time to wait for LP engine to complete its operation
> before polling pmctrl register.
>
> Signed-off-by: Michael Lo <michael.lo@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The new patch is an improvement over v1 as it avoids unnecessary
waiting in specific cases, such as when users are forced to disable
ASPM or when the host doesn't support ASPM as I suggested in v1. Thus,

Acked-by: Sean Wang <sean.wang@mediatek.com>

> ---
> v2: change funcion and variable naming.
> ---
>
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +++
>  .../net/wireless/mediatek/mt76/mt7925/pci.c   |  3 +++
>  drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
>  .../net/wireless/mediatek/mt76/mt792x_core.c  |  4 ++++
>  drivers/net/wireless/mediatek/mt76/pci.c      | 23 +++++++++++++++++++
>  6 files changed, 35 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 11b9f22ca7f3..4168104fa141 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -1081,6 +1081,7 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 o=
ffset, u32 mask, u32 val,
>
>  void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
>  void mt76_pci_disable_aspm(struct pci_dev *pdev);
> +bool mt76_pci_aspm_supported(struct pci_dev *pdev);
>
>  static inline u16 mt76_chip(struct mt76_dev *dev)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index f768e9389ac6..ca54ae7deb54 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -339,6 +339,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>         bus_ops->rmw =3D mt7921_rmw;
>         dev->mt76.bus =3D bus_ops;
>
> +       if (!mt7921_disable_aspm && mt76_pci_aspm_supported(pdev))
> +               dev->aspm_supported =3D true;
> +
>         ret =3D mt792xe_mcu_fw_pmctrl(dev);
>         if (ret)
>                 goto err_free_dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index 07b74d492ce1..2449b3e6c396 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -373,6 +373,9 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
>         bus_ops->rmw =3D mt7925_rmw;
>         dev->mt76.bus =3D bus_ops;
>
> +       if (!mt7925_disable_aspm && mt76_pci_aspm_supported(pdev))
> +               dev->aspm_supported =3D true;
> +
>         ret =3D __mt792x_mcu_fw_pmctrl(dev);
>         if (ret)
>                 goto err_free_dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wi=
reless/mediatek/mt76/mt792x.h
> index 20578497a405..c2c42e5d650a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> @@ -190,6 +190,7 @@ struct mt792x_dev {
>         bool fw_assert:1;
>         bool has_eht:1;
>         bool regd_in_progress:1;
> +       bool aspm_supported:1;
>         wait_queue_head_t wait;
>
>         struct work_struct init_work;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/n=
et/wireless/mediatek/mt76/mt792x_core.c
> index a405af8d9052..588b24edfdd9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -766,6 +766,10 @@ int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev)
>
>         for (i =3D 0; i < MT792x_DRV_OWN_RETRY_COUNT; i++) {
>                 mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
> +
> +               if (dev->aspm_supported)
> +                       usleep_range(2000, 3000);
> +
>                 if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
>                                         PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1=
))
>                         break;
> diff --git a/drivers/net/wireless/mediatek/mt76/pci.c b/drivers/net/wirel=
ess/mediatek/mt76/pci.c
> index 4c1c159fbb62..b5031ca7f73f 100644
> --- a/drivers/net/wireless/mediatek/mt76/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/pci.c
> @@ -45,3 +45,26 @@ void mt76_pci_disable_aspm(struct pci_dev *pdev)
>                                            aspm_conf);
>  }
>  EXPORT_SYMBOL_GPL(mt76_pci_disable_aspm);
> +
> +bool mt76_pci_aspm_supported(struct pci_dev *pdev)
> +{
> +       struct pci_dev *parent =3D pdev->bus->self;
> +       u16 aspm_conf, parent_aspm_conf =3D 0;
> +       bool result =3D true;
> +
> +       pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &aspm_conf);
> +       aspm_conf &=3D PCI_EXP_LNKCTL_ASPMC;
> +       if (parent) {
> +               pcie_capability_read_word(parent, PCI_EXP_LNKCTL,
> +                                         &parent_aspm_conf);
> +               parent_aspm_conf &=3D PCI_EXP_LNKCTL_ASPMC;
> +       }
> +
> +       if (!aspm_conf && (!parent || !parent_aspm_conf)) {
> +               /* aspm already disabled */
> +               result =3D false;
> +       }
> +
> +       return result;
> +}
> +EXPORT_SYMBOL_GPL(mt76_pci_aspm_supported);
> --
> 2.18.0
>
>

