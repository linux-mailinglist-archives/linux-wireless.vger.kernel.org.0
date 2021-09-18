Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B74105E6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhIRKO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Sep 2021 06:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235605AbhIRKOX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Sep 2021 06:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631959977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4nMxGpufv2fP7kMhMdjZryaQL1kDu62aKamvxoR1/8=;
        b=Pg3WKO1dZ0xBNSoXtxloFkxAC5h8thC7urkm3dKQ2H0Dl1fdgLwMRddUq+RMLM4Q2hKFsz
        nhZCxeGax3qOaJR+S/pfcB15XkBeU6fC1IalP2p+9kSH52f6wwB9M8Nae+jlnzlgS3OXRK
        iL5BVSuHKuF7t56sHjQFvKHXWksaszc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-HBQHlbM5NDeon1eUiiftKg-1; Sat, 18 Sep 2021 06:12:56 -0400
X-MC-Unique: HBQHlbM5NDeon1eUiiftKg-1
Received: by mail-ed1-f69.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so11402474ede.16
        for <linux-wireless@vger.kernel.org>; Sat, 18 Sep 2021 03:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y4nMxGpufv2fP7kMhMdjZryaQL1kDu62aKamvxoR1/8=;
        b=fF0y8Z/aOABvWl/ZntbkeTOt+q7QDWquNScvYDl1FaQ6ejYEbmBgVXW9XtSSk9FC/A
         O9NBPfAfaMp9+u/SNSw0sQMDTbnrOxOG6elj28Z/Z4Ft/mX8XIYRP6YiVdBnoxsMz2ig
         KY8qAKg0c2vWD2Vbvmo8WSlAK0GMZJLIsgYGtGm5ALAbZoViWGugkmhS4pkp2ceB3zF0
         WktGEjym/FvyMwses6CyQaqtcQFwSeAQfH736LtfbHLBRbmuKsLBYUzre83iAx3HvA+k
         FLDYZUO6IdOVhaAzEFCnG89fF7AN7Wf8Bx2UiQlYLpEjPUDBW0DPvCdHWW8TKyx5ly1X
         phKQ==
X-Gm-Message-State: AOAM531Bzye5WQXJvFQcBAVLLMqtAYsJipXYF1s84BJ0hPft36or4wxa
        BVuucRLjWdEO6y9MUY31zxSq45U4PeaW3Sa91me6OkmJbW+qgA4hRVGa4Y0b+ZT8nfZ0j1Y6Kq0
        m6uiQyZHuKBkO7iH6gBG0yQsuzBM=
X-Received: by 2002:a50:bf0f:: with SMTP id f15mr3760746edk.196.1631959973443;
        Sat, 18 Sep 2021 03:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk2y+IZWFl+IFEx2P5wgxEEDfuVegBJdAy9f72S6DKYgqFmkRuiHjQtlwzmk5BccwUawmX/w==
X-Received: by 2002:a50:bf0f:: with SMTP id f15mr3760722edk.196.1631959973163;
        Sat, 18 Sep 2021 03:12:53 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id u10sm3919626eds.83.2021.09.18.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 03:12:52 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:12:49 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 05/16] mt76: mt7921: add MT7921_COMMON module
Message-ID: <YUW7oRGTgw0wmcsj@lore-desk>
References: <cover.1631918993.git.objelf@gmail.com>
 <23bf9455d505c19fc484de533098b98b08804935.1631918993.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7RoTe2vrW1GvaePU"
Content-Disposition: inline
In-Reply-To: <23bf9455d505c19fc484de533098b98b08804935.1631918993.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7RoTe2vrW1GvaePU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch to introduce mt7921s support.
>=20
> MT7921_COMMON module grouping bus independent objects the both mt7921e and
> mt7921s can share with and have to rely on.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  | 8 ++++++--
>  drivers/net/wireless/mediatek/mt76/mt7921/Makefile | 7 ++++---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 2 ++
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 6 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 7 +++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 9 +++++++++
>  6 files changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/=
net/wireless/mediatek/mt76/mt7921/Kconfig
> index 001f2b9cec26..071746809b1c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
> @@ -1,8 +1,12 @@
>  # SPDX-License-Identifier: ISC
> -config MT7921E
> -	tristate "MediaTek MT7921E (PCIe) support"
> +config MT7921_COMMON
> +	tristate
>  	select MT76_CONNAC_LIB
>  	select WANT_DEV_COREDUMP
> +
> +config MT7921E
> +	tristate "MediaTek MT7921E (PCIe) support"
> +	select MT7921_COMMON
>  	depends on MAC80211
>  	depends on PCI
>  	help
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7921/Makefile
> index 4cb0b000cfe1..8cea896d5965 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: ISC
> =20
> +obj-$(CONFIG_MT7921_COMMON) +=3D mt7921-common.o
>  obj-$(CONFIG_MT7921E) +=3D mt7921e.o
> =20
>  CFLAGS_trace.o :=3D -I$(src)
> =20
> -mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main=
=2Eo \
> -	     init.o debugfs.o trace.o
> -mt7921e-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> +mt7921-common-y :=3D mac.o mcu.o eeprom.o main.o init.o debugfs.o trace.o
> +mt7921-common-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> +mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o dma.o
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index f0fd32c424c6..d310d6e1e566 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -145,6 +145,7 @@ int mt7921_mac_init(struct mt7921_dev *dev)
> =20
>  	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_init);
> =20
>  static int __mt7921_init_hardware(struct mt7921_dev *dev)
>  {
> @@ -285,3 +286,4 @@ int mt7921_register_device(struct mt7921_dev *dev)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(mt7921_register_device);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 24f24a2d8395..5812b518a571 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -39,6 +39,7 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt79=
21_dev *dev,
>  void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, boo=
l ps)
>  {
>  }
> +EXPORT_SYMBOL_GPL(mt7921_sta_ps);
> =20
>  bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
>  {
> @@ -169,6 +170,7 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
> =20
>  	rcu_read_unlock();
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_sta_poll);
> =20
>  static void
>  mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
> @@ -920,6 +922,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __=
le32 *txwi,
>  		txwi[3] |=3D cpu_to_le32(MT_TXD3_BA_DISABLE);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_write_txwi);
> =20
>  void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
>  {
> @@ -944,6 +947,7 @@ void mt7921_tx_check_aggr(struct ieee80211_sta *sta, =
__le32 *txwi)
>  	if (!test_and_set_bit(tid, &msta->ampdu_state))
>  		ieee80211_start_tx_ba_session(sta, tid, 0);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_tx_check_aggr);
> =20
>  static bool
>  mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, i=
nt pid,
> @@ -1132,6 +1136,7 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enu=
m mt76_rxq_id q,
>  		break;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
> =20
>  void mt7921_mac_reset_counters(struct mt7921_phy *phy)
>  {
> @@ -1247,6 +1252,7 @@ void mt7921_update_channel(struct mt76_phy *mphy)
> =20
>  	mt76_connac_power_save_sched(mphy, &dev->pm);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_update_channel);
> =20
>  static void
>  mt7921_vif_connect_iter(void *priv, u8 *mac,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index c51266e40cb4..cbffa8478329 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -237,6 +237,7 @@ int __mt7921_start(struct mt7921_phy *phy)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(__mt7921_start);
> =20
>  static int mt7921_start(struct ieee80211_hw *hw)
>  {
> @@ -646,6 +647,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_sta_add);
> =20
>  void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *v=
if,
>  			  struct ieee80211_sta *sta)
> @@ -667,6 +669,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, stru=
ct ieee80211_vif *vif,
> =20
>  	mt7921_mutex_release(dev);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
> =20
>  void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *=
vif,
>  			   struct ieee80211_sta *sta)
> @@ -698,6 +701,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
> =20
>  	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
> =20
>  void mt7921_tx_worker(struct mt76_worker *w)
>  {
> @@ -1250,3 +1254,6 @@ const struct ieee80211_ops mt7921_ops =3D {
>  	.flush =3D mt7921_flush,
>  	.set_sar_specs =3D mt7921_set_sar_specs,
>  };
> +EXPORT_SYMBOL_GPL(mt7921_ops);
> +
> +MODULE_LICENSE("Dual BSD/GPL");

is MODULE_AUTHOR defined?

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 5553221b7f5c..866b8797f16e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -222,6 +222,8 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, =
int cmd,
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
> +

nit: drop new line here

> =20
>  int mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
>  			    int cmd, int *wait_seq)
> @@ -319,6 +321,7 @@ int mt7921_mcu_send_message(struct mt76_dev *mdev, st=
ruct sk_buff *skb,
> =20
>  	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_send_message);
> =20
>  static void
>  mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
> @@ -600,6 +603,7 @@ int mt7921_mcu_restart(struct mt76_dev *dev)
>  	return mt76_mcu_send_msg(dev, MCU_CMD_NIC_POWER_CTRL, &req,
>  				 sizeof(req), false);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_restart);
> =20
>  static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
>  {
> @@ -903,11 +907,13 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
> =20
>  	return mt76_connac_mcu_get_nic_capability(&dev->mphy);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_run_firmware);
> =20
>  void mt7921_mcu_exit(struct mt7921_dev *dev)
>  {
>  	skb_queue_purge(&dev->mt76.mcu.res_q);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_exit);
> =20
>  int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
>  {
> @@ -1033,6 +1039,7 @@ int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
>  	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
>  				 &req, sizeof(req), true);
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
> =20
>  int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
>  {
> @@ -1215,6 +1222,7 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
> =20
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_drv_pmctrl);
> =20
>  int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
>  {
> @@ -1236,6 +1244,7 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
> =20
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(mt7921_mcu_fw_pmctrl);
> =20
>  int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
>  				 struct ieee80211_vif *vif,
> --=20
> 2.25.1
>=20

--7RoTe2vrW1GvaePU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUW7nwAKCRA6cBh0uS2t
rI1AAQDYLvi9s4bHKRQTo6iR1+h3pHYCFhVjOjGIybLgzf+iZAD+OYs3y0R8+PnM
vzkKBLaoliTePfQjdK5x5Xqff0GyUQM=
=PK9U
-----END PGP SIGNATURE-----

--7RoTe2vrW1GvaePU--

