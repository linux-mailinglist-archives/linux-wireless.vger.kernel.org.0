Return-Path: <linux-wireless+bounces-6465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD858A8EB7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D84284626
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A380C14;
	Wed, 17 Apr 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKfqMEhj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DE4C62E
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391607; cv=none; b=Ig9k8FPiI8d0EuEyOjdoQXF2hAs/J9/TUqgrX8Oe7YJzuFo6BghwBlb2/HjgIpkJIPgnG9aWCxSWPHHu7dgkB3vcObKIU2dBDPCPJkXNEAiHSQq8rBn5Ijngi007uVUrpEbD8y+aQey5K6Qzx5Rtaq5CnEhcWPi3UNEQoB5nspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391607; c=relaxed/simple;
	bh=5XaeWxA4Jl5FBChMeTzKurhmldZUlFGw1XdsqOV+zX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZT/0Kz7yaQE11TeRlwGdkegogBdYzIqQiV1Mq4qiEz3qdZHGHzipzwKQo3tV+etDPqfS9I3jo2ZHlPHRsb5FEzD9awg/mfWt2/DZp5e2VzT2s1ia8kbmS3KHpm3QJ7W7jAjaf3PpPlO6q1+idB1rlUPg/4dbUy5ri+G+ZdS7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKfqMEhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B97C32781
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713391606;
	bh=5XaeWxA4Jl5FBChMeTzKurhmldZUlFGw1XdsqOV+zX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fKfqMEhjWoDwvLSpUD1cWB7YIf+LJEKHxvASNjKDRDiPiR0TZOqxmH/6CYMSVUv1T
	 /acJMtTHNb2IM8JgHnha20vlY21DudZPi4jIKNx8cSMpU2sp3FpyQXSdrs4mYjhwd9
	 03GnfYJTumNkAEeQzHbOSHq5NX9CWhbiuQRVSTLDw/O5DnLYaSmbUP4r1z8ejhk9I9
	 85WfNqZJwZjYnenvNCRC4YdMi1HgyHhc0UUNDRBCD1E0NH/+H5uzN4Q4c26Qw/9kQc
	 gSeUUV2JwvvnVicDGz+ngFfBSimQQq+Ppd2NLOnPQqyPkDMo7AYrZCENAtN9k+cNpT
	 uevTC2vznGkFA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57051f83be3so36627a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 15:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfjDJY8A9PcCvpmjjOo2VvCriCFvF0yp9qMOgLl8X5VEZmrT/HCD1ZqJZjmUfgJcZEUHbX1sXK68nhhRU/s/A53VDvbdT5Ojzpr6WEQvY=
X-Gm-Message-State: AOJu0YyemECVstGpLD7/C7B4FgtUJx4IY+cCClj7xbndUP8vSaHnEVUH
	iiwdRlkYky3YOhizs8hmF/9zxqrfG20Sh/8tDKRtNN5DFlGbu9OdsDMwFpmdz5mMHX3xT2BVcwW
	z6UAC32WwjSGiOpMHOKodyndXEik=
X-Google-Smtp-Source: AGHT+IGYUftK0j7Vm9dBPhmoznJc4AxgNaVX+GcamySNv0VrWTPeTbrdM9zdn+sAZn9mOxITNiG5I09RbKHOvqeLqbg=
X-Received: by 2002:a17:906:4916:b0:a51:cc51:7931 with SMTP id
 b22-20020a170906491600b00a51cc517931mr416508ejq.5.1713391605272; Wed, 17 Apr
 2024 15:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>
In-Reply-To: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 17 Apr 2024 15:06:32 -0700
X-Gmail-Original-Message-ID: <CAGp9LzqVGHGriqpC-NTnOtvNNz5o-hXD=HcTCptHfXBD9bnfPQ@mail.gmail.com>
Message-ID: <CAGp9LzqVGHGriqpC-NTnOtvNNz5o-hXD=HcTCptHfXBD9bnfPQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: add LED control support
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Shengxi Xu <shengxi.xu@mediatek.com>, 
	Hao Zhang <hao.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Quan,

On Wed, Apr 10, 2024 at 11:00=E2=80=AFPM Quan Zhou <quan.zhou@mediatek.com>=
 wrote:
>
> From: Hao Zhang <hao.zhang@mediatek.com>
>
> Introduce wifi LED switch control, add flow to Control a wifi
> gpio pin based on the status of WIFI radio, if the pin is connected
> to an LED, the LED will indicate the status of the WiFi radio.
>
> Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
> Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> ---
> v2:
>  fix to avoid wake device when Hardware interface not pcie
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 27 ++++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 14 ++++++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  5 ++++
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  8 +++++-
>  5 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 836cc4d5b1d2..4c2de556dee1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1189,6 +1189,7 @@ enum {
>         MCU_EXT_CMD_EFUSE_ACCESS =3D 0x01,
>         MCU_EXT_CMD_RF_REG_ACCESS =3D 0x02,
>         MCU_EXT_CMD_RF_TEST =3D 0x04,
> +       MCU_EXT_CMD_ID_RADIO_ON_OFF_CTRL =3D 0x05,
>         MCU_EXT_CMD_PM_STATE_CTRL =3D 0x07,
>         MCU_EXT_CMD_CHANNEL_SWITCH =3D 0x08,
>         MCU_EXT_CMD_SET_TX_POWER_CTRL =3D 0x11,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index ca36de34171b..ea6a113b7b36 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -242,6 +242,15 @@ int __mt7921_start(struct mt792x_phy *phy)
>
>         ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
>                                      MT792x_WATCHDOG_TIME);
> +       if (mt76_is_mmio(mphy->dev)) {

I guess the led control MCU command is not limited to PCIe devices,
they should be able to be extended even on MT7921 USB and SDIO
devices, right ? if so, I think we can drop the MMIO limitation
condition to support more scenarios and to make it easier to
understand.

> +               err =3D mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO=
_LED_CTRL_ENABLE);
> +               if (err)
> +                       return err;
> +
> +               err =3D mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO=
_ON_LED);
> +               if (err)
> +                       return err;
> +       }
>
>         return 0;
>  }
> @@ -259,6 +268,22 @@ static int mt7921_start(struct ieee80211_hw *hw)
>         return err;
>  }
>
> +static void mt7921_stop(struct ieee80211_hw *hw)
> +{
> +       struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +       int err =3D 0;
> +
> +       if (mt76_is_mmio(&dev->mt76)) {
> +               mt792x_mutex_acquire(dev);
> +               err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_=
LED);
> +               mt792x_mutex_release(dev);
> +               if (err)
> +                       return;
> +       }
> +
> +       mt792x_stop(hw);
> +}
> +
>  static int
>  mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
>  {
> @@ -1372,7 +1397,7 @@ static void mt7921_mgd_complete_tx(struct ieee80211=
_hw *hw,
>  const struct ieee80211_ops mt7921_ops =3D {
>         .tx =3D mt792x_tx,
>         .start =3D mt7921_start,
> -       .stop =3D mt792x_stop,
> +       .stop =3D mt7921_stop,
>         .add_interface =3D mt7921_add_interface,
>         .remove_interface =3D mt792x_remove_interface,
>         .config =3D mt7921_config,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 8b4ce32a2cd1..2ebf0ffe78d5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -606,6 +606,20 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(mt7921_run_firmware);
>
> +int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value)
> +{
> +       struct {
> +               u8 ctrlid;
> +               u8 rsv[3];
> +       } __packed req =3D {
> +               .ctrlid =3D value,
> +       };
> +
> +       return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ID_RADIO_ON_OFF_=
CTRL),
> +                               &req, sizeof(req), false);
> +}
> +EXPORT_SYMBOL_GPL(mt7921_mcu_radio_led_ctrl);
> +
>  int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
>  {
>         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 3016636d18c6..07023eb9e5b5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -27,6 +27,10 @@
>  #define MCU_UNI_EVENT_ROC  0x27
>  #define MCU_UNI_EVENT_CLC  0x80
>
> +#define EXT_CMD_RADIO_LED_CTRL_ENABLE   0x1
> +#define EXT_CMD_RADIO_ON_LED            0x2
> +#define EXT_CMD_RADIO_OFF_LED           0x3
> +
>  enum {
>         UNI_ROC_ACQUIRE,
>         UNI_ROC_ABORT,
> @@ -196,6 +200,7 @@ int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, =
u8 ctrl);
>  void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
>  int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
>                             u8 bit_op, u32 bit_map);
> +int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value);
>
>  static inline u32
>  mt7921_reg_map_l1(struct mt792x_dev *dev, u32 addr)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 0b69b225bc16..f768e9389ac6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -427,6 +427,10 @@ static int mt7921_pci_suspend(struct device *device)
>         wait_event_timeout(dev->wait,
>                            !dev->regd_in_progress, 5 * HZ);
>
> +       err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
> +       if (err < 0)
> +               goto restore_suspend;
> +
>         err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
>         if (err)
>                 goto restore_suspend;
> @@ -525,9 +529,11 @@ static int mt7921_pci_resume(struct device *device)
>                 mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
>
>         err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> +       if (err < 0)
> +               goto failed;
>
>         mt7921_regd_update(dev);
> -
> +       err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
>  failed:
>         pm->suspended =3D false;
>
> --
> 2.18.0
>
>

