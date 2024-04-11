Return-Path: <linux-wireless+bounces-6147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 382678A0A51
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6DB2A929
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22013E05F;
	Thu, 11 Apr 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz6nx0Jl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0A13E051
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821333; cv=none; b=Ah+50hmKuzBtXVOg/6xoW0BpEVa4ncvKuiMN/IOvSD5MGRaXx4eOzXtxVcVmo5tMuMELdcNmMKf1Ur47Lf2dbZz1Niql25/1Ikoc0/FkM0ws4d66lDj0NIDJ5d6WHQkMjbOt9bfTuLp6XfGYDYgGaGbjx9MIBiJWhQBCoZAJKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821333; c=relaxed/simple;
	bh=AGx1wPABO9stePGaw9sCnqMoEvV5TkO+nUsZcmn+0TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXA8wKd5+f3LrsWh5EDjFrLsSmrzYipItycjk2bZqdvlia5cD2TNlDb2M56FkYmIetg0RE8E9oizCbetufH02/f32cTP0UNLzet5qBEy4UTwauzmEViIOiTXvpvTsPV80N3ZH8v5KPO7VQB7/m1fgRx01YltvRTn4J3pnSxms6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz6nx0Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF6BC433C7;
	Thu, 11 Apr 2024 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821332;
	bh=AGx1wPABO9stePGaw9sCnqMoEvV5TkO+nUsZcmn+0TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yz6nx0Jl5W/JWYfWi5Edvyep4ZfBwJ7ejC3Zqo5DpuVE34wC6ANQ6SN4qhjk54tX0
	 m4N2XrwtHHvw7BZ05j72z2oc/ebQXPtM0aBqDoe2v1NORDN63GxDESiHkQhlLjFKjx
	 eSp2X5UIVtAwX3+J/2Mu4WHqvbJTdJjmTHFV+ibNGAz09Ni7XAgnZwIyKFHHJRgrZH
	 UbOEv8OjrmuLxnPsow1CEHlLrWsRn55TYk8AotLHKrd4nUUzxsYBy80RCryvTL7qb2
	 VkmXH8+0Ha3T+Nfd9oKNXwqcUo7KDNJf+bWHeafyGaa7OGAUmEsvdlWw2E1O7JNo6A
	 6WaSozeYucKNw==
Date: Thu, 11 Apr 2024 09:42:08 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Shengxi Xu <shengxi.xu@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: add LED control support
Message-ID: <ZheUUI4NCXCDMsAV@lore-desk>
References: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xXHl8aIz7lW46gqE"
Content-Disposition: inline
In-Reply-To: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>


--xXHl8aIz7lW46gqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Hao Zhang <hao.zhang@mediatek.com>
>=20
> Introduce wifi LED switch control, add flow to Control a wifi
> gpio pin based on the status of WIFI radio, if the pin is connected
> to an LED, the LED will indicate the status of the WiFi radio.
>=20
> Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
> Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

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
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 836cc4d5b1d2..4c2de556dee1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1189,6 +1189,7 @@ enum {
>  	MCU_EXT_CMD_EFUSE_ACCESS =3D 0x01,
>  	MCU_EXT_CMD_RF_REG_ACCESS =3D 0x02,
>  	MCU_EXT_CMD_RF_TEST =3D 0x04,
> +	MCU_EXT_CMD_ID_RADIO_ON_OFF_CTRL =3D 0x05,
>  	MCU_EXT_CMD_PM_STATE_CTRL =3D 0x07,
>  	MCU_EXT_CMD_CHANNEL_SWITCH =3D 0x08,
>  	MCU_EXT_CMD_SET_TX_POWER_CTRL =3D 0x11,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index ca36de34171b..ea6a113b7b36 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -242,6 +242,15 @@ int __mt7921_start(struct mt792x_phy *phy)
> =20
>  	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
>  				     MT792x_WATCHDOG_TIME);
> +	if (mt76_is_mmio(mphy->dev)) {
> +		err =3D mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_LED_CTRL_ENA=
BLE);
> +		if (err)
> +			return err;
> +
> +		err =3D mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_ON_LED);
> +		if (err)
> +			return err;
> +	}
> =20
>  	return 0;
>  }
> @@ -259,6 +268,22 @@ static int mt7921_start(struct ieee80211_hw *hw)
>  	return err;
>  }
> =20
> +static void mt7921_stop(struct ieee80211_hw *hw)
> +{
> +	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +	int err =3D 0;
> +
> +	if (mt76_is_mmio(&dev->mt76)) {
> +		mt792x_mutex_acquire(dev);
> +		err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
> +		mt792x_mutex_release(dev);
> +		if (err)
> +			return;
> +	}
> +
> +	mt792x_stop(hw);
> +}
> +
>  static int
>  mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
>  {
> @@ -1372,7 +1397,7 @@ static void mt7921_mgd_complete_tx(struct ieee80211=
_hw *hw,
>  const struct ieee80211_ops mt7921_ops =3D {
>  	.tx =3D mt792x_tx,
>  	.start =3D mt7921_start,
> -	.stop =3D mt792x_stop,
> +	.stop =3D mt7921_stop,
>  	.add_interface =3D mt7921_add_interface,
>  	.remove_interface =3D mt792x_remove_interface,
>  	.config =3D mt7921_config,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 8b4ce32a2cd1..2ebf0ffe78d5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -606,6 +606,20 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(mt7921_run_firmware);
> =20
> +int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value)
> +{
> +	struct {
> +		u8 ctrlid;
> +		u8 rsv[3];
> +	} __packed req =3D {
> +		.ctrlid =3D value,
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ID_RADIO_ON_OFF_CTRL),
> +				&req, sizeof(req), false);
> +}
> +EXPORT_SYMBOL_GPL(mt7921_mcu_radio_led_ctrl);
> +
>  int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
>  {
>  	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 3016636d18c6..07023eb9e5b5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -27,6 +27,10 @@
>  #define MCU_UNI_EVENT_ROC  0x27
>  #define MCU_UNI_EVENT_CLC  0x80
> =20
> +#define EXT_CMD_RADIO_LED_CTRL_ENABLE   0x1
> +#define EXT_CMD_RADIO_ON_LED            0x2
> +#define EXT_CMD_RADIO_OFF_LED           0x3
> +
>  enum {
>  	UNI_ROC_ACQUIRE,
>  	UNI_ROC_ABORT,
> @@ -196,6 +200,7 @@ int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, =
u8 ctrl);
>  void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
>  int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
>  			    u8 bit_op, u32 bit_map);
> +int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value);
> =20
>  static inline u32
>  mt7921_reg_map_l1(struct mt792x_dev *dev, u32 addr)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 0b69b225bc16..f768e9389ac6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -427,6 +427,10 @@ static int mt7921_pci_suspend(struct device *device)
>  	wait_event_timeout(dev->wait,
>  			   !dev->regd_in_progress, 5 * HZ);
> =20
> +	err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
> +	if (err < 0)
> +		goto restore_suspend;
> +
>  	err =3D mt76_connac_mcu_set_hif_suspend(mdev, true);
>  	if (err)
>  		goto restore_suspend;
> @@ -525,9 +529,11 @@ static int mt7921_pci_resume(struct device *device)
>  		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
> =20
>  	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> +	if (err < 0)
> +		goto failed;
> =20
>  	mt7921_regd_update(dev);
> -
> +	err =3D mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
>  failed:
>  	pm->suspended =3D false;
> =20
> --=20
> 2.18.0
>=20

--xXHl8aIz7lW46gqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZheUUAAKCRA6cBh0uS2t
rCNLAQD2Y2TMwL7ZS79poqfQwDCGFHXoQvASm460VUEhkzwuFwD/SyGjVf0bge+L
1hQ+/fYZZW5HN4v4f4ZhUGJ6H8YQigw=
=k7oE
-----END PGP SIGNATURE-----

--xXHl8aIz7lW46gqE--

