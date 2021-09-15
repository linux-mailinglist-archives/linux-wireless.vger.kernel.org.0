Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33240C5F1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhIONKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233143AbhIONKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631711331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2phkAjAphKXRM2tPIC1Lk+BS1z90dxAXmo20X8nEyKg=;
        b=gK/I6E9sUfFT0hwQEc/QCvSJiPN6k4VkJvgW7R30xaCg7uhsFVdpi7+QCnNvtHgKZKae4H
        IQJLpsumpy1GiWQQzybkMeqVZDvqrmGKIISH+fZYInRKoXZCfIBuwJm3sTxDWts7z6cDP7
        2vXTnK5qGGpj8vkYSoHykhIcluG6GyU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311--hUjQtolNqa4emAK6vFzow-1; Wed, 15 Sep 2021 09:08:49 -0400
X-MC-Unique: -hUjQtolNqa4emAK6vFzow-1
Received: by mail-ej1-f71.google.com with SMTP id o7-20020a170906288700b005bb05cb6e25so1470067ejd.23
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2phkAjAphKXRM2tPIC1Lk+BS1z90dxAXmo20X8nEyKg=;
        b=dp+1hi2r7mMOl+zzZJx+4eHIxG5zfX2psGe8wRPRxCeWiTA5HNzhmAKmo7U2mBufg0
         LHxrUQvTEMWZlH47XWDYnvAE5jd7tmpOiT6BSMZHtsumA4TgWlanURZbRLYanJZBoGVb
         JRVr3gWdo4+lz8N/2fyFERzO9Iu+1PywjcofhMhQfXl7B+NqCU+oO2zy2H1RyhEUMMXM
         Gj05nvo/oUVnfdgXDe51kgGZ2Lk5RswSyAq5fImezw4pLzSgKQDoTlvDZjj92UHSPFhK
         sxvrXyO6XoaTJSQS38yzFFdjAAkJTpF8lqw4XikMm91CWpMSdp54mg96qkve2kCfcJMr
         yVyQ==
X-Gm-Message-State: AOAM530RXjgF1cUL7cVOBEfODZhuLLyI9ah+sQkbqFLGsmFVO/BVcMm6
        BtkguspY18OLyBrZV+ERFJ92f7jrDOlPbT2cNmmizLghw+fD4PyevUNw1n2Qy0LLBNFxIONXuRX
        wMJzNuPC5wdVKUyficMs589ffR4I=
X-Received: by 2002:a17:907:76e7:: with SMTP id kg7mr23752457ejc.344.1631711328376;
        Wed, 15 Sep 2021 06:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnQp+yx8+9YSszs5tKnBh7VsmYwdaWKOZe8vCfj4yK3ENQePIx3w6l9MEDOp5rFCSo+xMn+Q==
X-Received: by 2002:a17:907:76e7:: with SMTP id kg7mr23752423ejc.344.1631711328047;
        Wed, 15 Sep 2021 06:08:48 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id dg18sm4261482edb.44.2021.09.15.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:08:47 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:08:44 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 03/16] mt76: mt7921: refactor mcu.c to be bus
 independent
Message-ID: <YUHwXG5H7EofWhRw@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <37519dafa02723a1fff0ccaea73c8b4f860cad7b.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YA0wuwk9ukjqL77s"
Content-Disposition: inline
In-Reply-To: <37519dafa02723a1fff0ccaea73c8b4f860cad7b.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YA0wuwk9ukjqL77s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch to introduce mt7921s support.
>=20
> Make mcu.c reusable between mt7921s and mt7921e
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7921/Makefile    |  3 +-
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   |  5 +-
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 90 ++---------------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    | 18 +++-
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +
>  .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +
>  .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 97 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt7921/testmode.c  |  2 +-
>  9 files changed, 129 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7921/Makefile
> index 554202358470..4cb0b000cfe1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_MT7921E) +=3D mt7921e.o
> =20
>  CFLAGS_trace.o :=3D -I$(src)
> =20
> -mt7921e-y :=3D pci.o pci_mac.o mac.o mcu.o dma.o eeprom.o main.o init.o =
debugfs.o trace.o
> +mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main=
=2Eo \
> +	     init.o debugfs.o trace.o
>  mt7921e-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 97b931ea07c1..7c7a26102e11 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -304,6 +304,7 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
>  	mt7921_tx_token_put(dev);
>  	mt7921_mcu_drv_pmctrl(dev);
>  	mt7921_dma_cleanup(dev);
> +	mt7921_wfsys_reset(dev);
>  	mt7921_mcu_exit(dev);
>  	mt7921_mcu_fw_pmctrl(dev);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 580a88b7841e..c26d986e08e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1282,12 +1282,9 @@ void mt7921_mac_reset_work(struct work_struct *wor=
k)
>  	cancel_work_sync(&pm->wake_work);
> =20
>  	mutex_lock(&dev->mt76.mutex);
> -	for (i =3D 0; i < 10; i++) {
> -		__mt7921_mcu_drv_pmctrl(dev);
> -
> +	for (i =3D 0; i < 10; i++)
>  		if (!mt7921_dev_reset(dev))
>  			break;
> -	}
>  	mutex_unlock(&dev->mt76.mutex);
> =20
>  	if (i =3D=3D 10)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 6ba431347b3b..0648443eb283 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -160,7 +160,7 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct =
sk_buff *skb)
>  	return 0;
>  }
> =20
> -static int
> +int

no new-line here

>  mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
>  			  struct sk_buff *skb, int seq)
>  {
> @@ -224,7 +224,7 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int =
cmd,
>  	return ret;
>  }
> =20
> -static int
> +int

no new-line here

>  mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
>  			int cmd, int *wait_seq)
>  {
> @@ -590,7 +590,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
>  				      enable, false);
>  }
> =20
> -static int mt7921_mcu_restart(struct mt76_dev *dev)
> +int mt7921_mcu_restart(struct mt76_dev *dev)
>  {
>  	struct {
>  		u8 power_mode;
> @@ -603,20 +603,6 @@ static int mt7921_mcu_restart(struct mt76_dev *dev)
>  				 sizeof(req), false);
>  }
> =20
> -static int mt7921_driver_own(struct mt7921_dev *dev)
> -{
> -	u32 reg =3D mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
> -
> -	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
> -	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
> -			    0, 500)) {
> -		dev_err(dev->mt76.dev, "Timeout for driver own\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> -}
> -
>  static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
>  {
>  	u32 mode =3D DL_MODE_NEED_RSP;
> @@ -883,7 +869,6 @@ static int mt7921_load_firmware(struct mt7921_dev *de=
v)
>  	}
> =20
>  fw_loaded:
> -	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
> =20
>  #ifdef CONFIG_PM
>  	dev->mt76.hw->wiphy->wowlan =3D &mt76_connac_wowlan_support;
> @@ -911,10 +896,6 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
>  {
>  	int err;
> =20
> -	err =3D mt7921_driver_own(dev);
> -	if (err)
> -		return err;
> -
>  	err =3D mt7921_load_firmware(dev);
>  	if (err)
>  		return err;
> @@ -925,23 +906,8 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
>  	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
>  }
> =20
> -int mt7921_mcu_init(struct mt7921_dev *dev)
> -{
> -	static const struct mt76_mcu_ops mt7921_mcu_ops =3D {
> -		.headroom =3D sizeof(struct mt7921_mcu_txd),
> -		.mcu_skb_send_msg =3D mt7921_mcu_send_message,
> -		.mcu_parse_response =3D mt7921_mcu_parse_response,
> -		.mcu_restart =3D mt7921_mcu_restart,
> -	};
> -
> -	dev->mt76.mcu_ops =3D &mt7921_mcu_ops;
> -
> -	return mt7921_run_firmware(dev);
> -}
> -
>  void mt7921_mcu_exit(struct mt7921_dev *dev)
>  {
> -	mt7921_wfsys_reset(dev);
>  	skb_queue_purge(&dev->mt76.mcu.res_q);
>  }
> =20
> @@ -1231,35 +1197,6 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, =
struct ieee80211_sta *sta,
>  	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
>  }
> =20
> -int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
> -{
> -	struct mt76_phy *mphy =3D &dev->mt76.phy;
> -	struct mt76_connac_pm *pm =3D &dev->pm;
> -	int i, err =3D 0;
> -
> -	for (i =3D 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> -		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
> -		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
> -				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
> -			break;
> -	}
> -
> -	if (i =3D=3D MT7921_DRV_OWN_RETRY_COUNT) {
> -		dev_err(dev->mt76.dev, "driver own failed\n");
> -		err =3D -EIO;
> -		goto out;
> -	}
> -
> -	mt7921_wpdma_reinit_cond(dev);
> -	clear_bit(MT76_STATE_PM, &mphy->state);
> -
> -	pm->stats.last_wake_event =3D jiffies;
> -	pm->stats.doze_time +=3D pm->stats.last_wake_event -
> -			       pm->stats.last_doze_event;
> -out:
> -	return err;
> -}
> -
>  int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
>  {
>  	struct mt76_phy *mphy =3D &dev->mt76.phy;
> @@ -1271,7 +1208,7 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
>  	if (!test_bit(MT76_STATE_PM, &mphy->state))
>  		goto out;
> =20
> -	err =3D __mt7921_mcu_drv_pmctrl(dev);
> +	err =3D mt7921_drv_own(dev);
>  out:
>  	mutex_unlock(&pm->mutex);
> =20
> @@ -1285,29 +1222,14 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
>  {
>  	struct mt76_phy *mphy =3D &dev->mt76.phy;
>  	struct mt76_connac_pm *pm =3D &dev->pm;
> -	int i, err =3D 0;
> +	int err =3D 0;
> =20
>  	mutex_lock(&pm->mutex);
> =20
>  	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
>  		goto out;
> =20
> -	for (i =3D 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> -		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
> -		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
> -				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
> -			break;
> -	}
> -
> -	if (i =3D=3D MT7921_DRV_OWN_RETRY_COUNT) {
> -		dev_err(dev->mt76.dev, "firmware own failed\n");
> -		clear_bit(MT76_STATE_PM, &mphy->state);
> -		err =3D -EIO;
> -	}
> -
> -	pm->stats.last_doze_event =3D jiffies;
> -	pm->stats.awake_time +=3D pm->stats.last_doze_event -
> -				pm->stats.last_wake_event;
> +	err =3D mt7921_fw_own(dev);
>  out:
>  	mutex_unlock(&pm->mutex);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 4c1c7c4eafac..dbace154bfa5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -134,8 +134,14 @@ struct mt7921_phy {
>  };
> =20
>  #define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
> +#define mt7921_mcu_init(dev)	((dev)->hif_ops->mcu_init(dev))
> +#define mt7921_drv_own(dev)	((dev)->hif_ops->drv_own(dev))
> +#define mt7921_fw_own(dev)	((dev)->hif_ops->fw_own(dev))

mt7921_drv_own and mt7921_fw_own seems a bit misleading, why not something
like:

mt7921_mcu_drv_pmctrl and mt7921_mcu_fw_pmctrl

are they already used?

>  struct mt7921_hif_ops {
>  	int (*reset)(struct mt7921_dev *dev);
> +	int (*mcu_init)(struct mt7921_dev *dev);
> +	int (*drv_own)(struct mt7921_dev *dev);
> +	int (*fw_own)(struct mt7921_dev *dev);
>  };
> =20
>  struct mt7921_dev {
> @@ -250,7 +256,6 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool f=
orce);
>  int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
>  void mt7921_dma_cleanup(struct mt7921_dev *dev);
>  int mt7921_run_firmware(struct mt7921_dev *dev);
> -int mt7921_mcu_init(struct mt7921_dev *dev);
>  int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
>  		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
>  		       enum set_key_cmd cmd);
> @@ -359,7 +364,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
>  			 bool enable);
>  void mt7921_scan_work(struct work_struct *work);
>  int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *=
vif);
> -int __mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
>  void mt7921_pm_wake_work(struct work_struct *work);
> @@ -378,7 +382,17 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, _=
_le32 *txwi,
>  			   bool beacon);
>  void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
>  void mt7921_mac_sta_poll(struct mt7921_dev *dev);
> +int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
> +			    int cmd, int *wait_seq);
> +int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
> +			      struct sk_buff *skb, int seq);
> +int mt7921_mcu_restart(struct mt76_dev *dev);
> +
>  void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
>  			  struct sk_buff *skb);
>  int mt7921e_mac_reset(struct mt7921_dev *dev);
> +int mt7921e_mcu_init(struct mt7921_dev *dev);
> +int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
> +int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
> +
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index b01b9b7c42b4..b16bcee08cd7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -117,6 +117,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> =20
>  	static const struct mt7921_hif_ops mt7921_pcie_ops =3D {
>  		.reset =3D mt7921e_mac_reset,
> +		.mcu_init =3D mt7921e_mcu_init,
> +		.drv_own =3D mt7921e_mcu_drv_pmctrl,
> +		.fw_own =3D mt7921e_mcu_fw_pmctrl,
>  	};
> =20
>  	struct mt7921_dev *dev;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index f211dafa311c..f0734be57dce 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -286,6 +286,8 @@ mt7921e_mac_reset(struct mt7921_dev *dev)
>  {
>  	int i, err;
> =20
> +	mt7921e_mcu_drv_pmctrl(dev);
> +
>  	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
> =20
>  	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> new file mode 100644
> index 000000000000..9ac3bc25f067
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2021 MediaTek Inc. */
> +
> +#include "mt7921.h"
> +#include "mcu.h"
> +
> +static int mt7921e_driver_own(struct mt7921_dev *dev)
> +{
> +	u32 reg =3D mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
> +
> +	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
> +	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
> +			    0, 500)) {
> +		dev_err(dev->mt76.dev, "Timeout for driver own\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +int mt7921e_mcu_init(struct mt7921_dev *dev)
> +{
> +	static const struct mt76_mcu_ops mt7921_mcu_ops =3D {
> +		.headroom =3D sizeof(struct mt7921_mcu_txd),
> +		.mcu_skb_send_msg =3D mt7921_mcu_send_message,
> +		.mcu_parse_response =3D mt7921_mcu_parse_response,
> +		.mcu_restart =3D mt7921_mcu_restart,
> +	};
> +	int err;
> +
> +	dev->mt76.mcu_ops =3D &mt7921_mcu_ops;
> +
> +	err =3D mt7921e_driver_own(dev);
> +	if (err)
> +		return err;
> +
> +	err =3D mt7921_run_firmware(dev);
> +
> +	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_FWDL], false);
> +
> +	return err;
> +}
> +
> +int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> +{
> +	struct mt76_phy *mphy =3D &dev->mt76.phy;
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> +		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
> +		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
> +				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
> +			break;
> +	}
> +
> +	if (i =3D=3D MT7921_DRV_OWN_RETRY_COUNT) {
> +		dev_err(dev->mt76.dev, "driver own failed\n");
> +		err =3D -EIO;
> +		goto out;
> +	}
> +
> +	mt7921_wpdma_reinit_cond(dev);
> +	clear_bit(MT76_STATE_PM, &mphy->state);
> +
> +	pm->stats.last_wake_event =3D jiffies;
> +	pm->stats.doze_time +=3D pm->stats.last_wake_event -
> +			       pm->stats.last_doze_event;
> +out:
> +	return err;
> +}
> +
> +int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
> +{
> +	struct mt76_phy *mphy =3D &dev->mt76.phy;
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> +		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
> +		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
> +				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
> +			break;
> +	}
> +
> +	if (i =3D=3D MT7921_DRV_OWN_RETRY_COUNT) {
> +		dev_err(dev->mt76.dev, "firmware own failed\n");
> +		clear_bit(MT76_STATE_PM, &mphy->state);
> +		err =3D -EIO;
> +	}
> +
> +	pm->stats.last_doze_event =3D jiffies;
> +	pm->stats.awake_time +=3D pm->stats.last_doze_event -
> +				pm->stats.last_wake_event;
> +
> +	return err;
> +}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/testmode.c
> index 8bd43879dd6f..d22bbd9da58f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
> @@ -57,7 +57,7 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_=
cmd *req)
>  		pm->enable =3D false;
>  		cancel_delayed_work_sync(&pm->ps_work);
>  		cancel_work_sync(&pm->wake_work);
> -		__mt7921_mcu_drv_pmctrl(dev);
> +		mt7921_drv_own(dev);
> =20
>  		mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
>  		phy->test.state =3D MT76_TM_STATE_ON;
> --=20
> 2.25.1
>=20

--YA0wuwk9ukjqL77s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHwWQAKCRA6cBh0uS2t
rAJcAQDbIFQn+lBHFfe7bRLOhiO/7+AImXhGU/KDyRqT66XEbwEAp+nr/UfIznR3
U9MQ0N9/rw1IgkuWkjkaTINVcbWEOgs=
=H5X+
-----END PGP SIGNATURE-----

--YA0wuwk9ukjqL77s--

