Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F040C5D1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhIONDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhIONDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631710920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffaLTFLTMxukcmSGGqoBnsd6QSo763HLuSsxUjAHzOM=;
        b=hBzqMlwFypfoIkbN0fmdc6Kx5d2VzT5RgwPZzLsweqGLXleJYoFmA3WSO4HuAxTWieiMUF
        FmhWqDI3/vqC/R7KwSPQIOJlhpjtXJ983dV9kYF0Rh0ChqJB+aFES8Ksve9XNpqExp4egQ
        L3Fb9iwrHoLolxiDFQj5BjLMgP09Zz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-p0GoI9t8NHarXV0v3qd-uQ-1; Wed, 15 Sep 2021 09:01:58 -0400
X-MC-Unique: p0GoI9t8NHarXV0v3qd-uQ-1
Received: by mail-ed1-f72.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso1573767edb.11
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ffaLTFLTMxukcmSGGqoBnsd6QSo763HLuSsxUjAHzOM=;
        b=N1rTMpfZ7D7bR9XucKGsFSEamQCHVmGiSv6QAl+mijewoPsCbNDKsil+3n0ruDDIep
         UAtcydrVBwmEqgdcBi9Qa4qH7u50cxMqf4dJwTKtN7zTaCDdLDC9artG0dtDhEnokPAn
         +FGx8aUXYcm/EMFWdoFtg1PRn6ZPYlqgLVkRYFZhIBXqJ9u/V2hy4r5ew2+C0j+DQ+vH
         TDR+hOeEpOOq8jQZWe7hPNpBsg+UFeA196F7BtkLj2YKILnJcszRwiQQPEuXEWLzYG2z
         fyJ/J+P6xEZbAy+f0PPpD0JiY40xy5sGqdjBzcQE4skvXD365haMjXmARjgdfvM4+U6Z
         hMvw==
X-Gm-Message-State: AOAM533KmOjzGMjsMXk+e2YTapRd2uRm5pHyDclloJ90OLAPvW7C2dJA
        5eCMoA/drX2vb+yBVZjr6Ep7k+cb/j9JY3bgQhoXqtZc7KTSxs/WDHvFHvkYTKzelOZu4zdMVou
        voD/PhtBbiMOXXIa0KieG839o6Ak=
X-Received: by 2002:a17:906:8608:: with SMTP id o8mr24896219ejx.470.1631710916538;
        Wed, 15 Sep 2021 06:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1yL43OJ7BO2VEntcp+Z3insmaCbigzjREEZqPSUIqijihyYzlJ9n6rfzF3qOb5u9X8Iw0RQ==
X-Received: by 2002:a17:906:8608:: with SMTP id o8mr24896168ejx.470.1631710915941;
        Wed, 15 Sep 2021 06:01:55 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id i6sm6202995ejd.57.2021.09.15.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:01:55 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:01:52 +0200
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
Subject: Re: [PATCH v1 01/16] mt76: mt7921: refactor mac.c to be bus
 independent
Message-ID: <YUHuwOVrlXvDS08a@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <f0d66c706432282ca97156f2d0c514d7c260ec09.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avc4J7JIHHPHavfO"
Content-Disposition: inline
In-Reply-To: <f0d66c706432282ca97156f2d0c514d7c260ec09.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--avc4J7JIHHPHavfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch to introduce mt7921s support.
>=20
> Split out a new pci_mac.c from mac.c to make mac.c reusable between
> mt7921s and mt7921e.

Hi Sean,

mostly fine, just few nitpicks inline.

Regards,
Lorenzo

>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 331 +----------------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  25 +-
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  12 +-
>  .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 345 ++++++++++++++++++
>  5 files changed, 379 insertions(+), 336 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7921/Makefile
> index 3471d82fc265..554202358470 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> @@ -4,5 +4,5 @@ obj-$(CONFIG_MT7921E) +=3D mt7921e.o
> =20
>  CFLAGS_trace.o :=3D -I$(src)
> =20
> -mt7921e-y :=3D pci.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o =
trace.o
> +mt7921e-y :=3D pci.o pci_mac.o mac.o mcu.o dma.o eeprom.o main.o init.o =
debugfs.o trace.o
>  mt7921e-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 27f13228c5a7..d811702a3a2c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -49,7 +49,7 @@ bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int=
 idx, u32 mask)
>  			 0, 5000);
>  }
> =20
> -static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
> +void mt7921_mac_sta_poll(struct mt7921_dev *dev)
>  {
>  	static const u8 ac_to_tid[] =3D {
>  		[IEEE80211_AC_BE] =3D 0,
> @@ -836,7 +836,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, _=
_le32 *txwi,
>  	txwi[7] |=3D cpu_to_le32(val);
>  }
> =20
> -static void
> +void

can you please remove new line here?

>  mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
>  		      struct sk_buff *skb, struct mt76_wcid *wcid,
>  		      struct ieee80211_key_conf *key, int pid,
> @@ -922,86 +922,7 @@ mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32=
 *txwi,
>  	}
>  }
> =20
> -static void
> -mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
> -		    void *txp_ptr, u32 id)
> -{
> -	struct mt7921_hw_txp *txp =3D txp_ptr;
> -	struct mt7921_txp_ptr *ptr =3D &txp->ptr[0];
> -	int i, nbuf =3D tx_info->nbuf - 1;
> -
> -	tx_info->buf[0].len =3D MT_TXD_SIZE + sizeof(*txp);
> -	tx_info->nbuf =3D 1;
> -
> -	txp->msdu_id[0] =3D cpu_to_le16(id | MT_MSDU_ID_VALID);
> -
> -	for (i =3D 0; i < nbuf; i++) {
> -		u16 len =3D tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
> -		u32 addr =3D tx_info->buf[i + 1].addr;
> -
> -		if (i =3D=3D nbuf - 1)
> -			len |=3D MT_TXD_LEN_LAST;
> -
> -		if (i & 1) {
> -			ptr->buf1 =3D cpu_to_le32(addr);
> -			ptr->len1 =3D cpu_to_le16(len);
> -			ptr++;
> -		} else {
> -			ptr->buf0 =3D cpu_to_le32(addr);
> -			ptr->len0 =3D cpu_to_le16(len);
> -		}
> -	}
> -}
> -
> -int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
> -			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
> -			  struct ieee80211_sta *sta,
> -			  struct mt76_tx_info *tx_info)
> -{
> -	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
> -	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
> -	struct ieee80211_key_conf *key =3D info->control.hw_key;
> -	struct mt76_txwi_cache *t;
> -	struct mt7921_txp_common *txp;
> -	int id, pid;
> -	u8 *txwi =3D (u8 *)txwi_ptr;
> -
> -	if (unlikely(tx_info->skb->len <=3D ETH_HLEN))
> -		return -EINVAL;
> -
> -	if (!wcid)
> -		wcid =3D &dev->mt76.global_wcid;
> -
> -	t =3D (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
> -	t->skb =3D tx_info->skb;
> -
> -	id =3D mt76_token_consume(mdev, &t);
> -	if (id < 0)
> -		return id;
> -
> -	if (sta) {
> -		struct mt7921_sta *msta =3D (struct mt7921_sta *)sta->drv_priv;
> -
> -		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
> -			info->flags |=3D IEEE80211_TX_CTL_REQ_TX_STATUS;
> -			msta->last_txs =3D jiffies;
> -		}
> -	}
> -
> -	pid =3D mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
> -	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
> -			      pid, false);
> -
> -	txp =3D (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
> -	memset(txp, 0, sizeof(struct mt7921_txp_common));
> -	mt7921_write_hw_txp(dev, tx_info, txp, id);
> -
> -	tx_info->skb =3D DMA_DUMMY_DATA;
> -
> -	return 0;
> -}
> -
> -static void
> +void

can you please remove new line here?

>  mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
>  {
>  	struct mt7921_sta *msta;
> @@ -1026,143 +947,6 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __=
le32 *txwi)
>  		ieee80211_start_tx_ba_session(sta, tid, 0);
>  }
> =20
> -static void
> -mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
> -{
> -	struct mt7921_txp_common *txp;
> -	int i;
> -
> -	txp =3D mt7921_txwi_to_txp(dev, t);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
> -		struct mt7921_txp_ptr *ptr =3D &txp->hw.ptr[i];
> -		bool last;
> -		u16 len;
> -
> -		len =3D le16_to_cpu(ptr->len0);
> -		last =3D len & MT_TXD_LEN_LAST;
> -		len &=3D MT_TXD_LEN_MASK;
> -		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
> -				 DMA_TO_DEVICE);
> -		if (last)
> -			break;
> -
> -		len =3D le16_to_cpu(ptr->len1);
> -		last =3D len & MT_TXD_LEN_LAST;
> -		len &=3D MT_TXD_LEN_MASK;
> -		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
> -				 DMA_TO_DEVICE);
> -		if (last)
> -			break;
> -	}
> -}
> -
> -static void
> -mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
> -		 struct ieee80211_sta *sta, bool clear_status,
> -		 struct list_head *free_list)
> -{
> -	struct mt76_dev *mdev =3D &dev->mt76;
> -	__le32 *txwi;
> -	u16 wcid_idx;
> -
> -	mt7921_txp_skb_unmap(mdev, t);
> -	if (!t->skb)
> -		goto out;
> -
> -	txwi =3D (__le32 *)mt76_get_txwi_ptr(mdev, t);
> -	if (sta) {
> -		struct mt76_wcid *wcid =3D (struct mt76_wcid *)sta->drv_priv;
> -
> -		if (likely(t->skb->protocol !=3D cpu_to_be16(ETH_P_PAE)))
> -			mt7921_tx_check_aggr(sta, txwi);
> -
> -		wcid_idx =3D wcid->idx;
> -	} else {
> -		wcid_idx =3D FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
> -	}
> -
> -	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
> -
> -out:
> -	t->skb =3D NULL;
> -	mt76_put_txwi(mdev, t);
> -}
> -
> -static void
> -mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
> -{
> -	struct mt7921_tx_free *free =3D (struct mt7921_tx_free *)skb->data;
> -	struct mt76_dev *mdev =3D &dev->mt76;
> -	struct mt76_txwi_cache *txwi;
> -	struct ieee80211_sta *sta =3D NULL;
> -	LIST_HEAD(free_list);
> -	struct sk_buff *tmp;
> -	bool wake =3D false;
> -	u8 i, count;
> -
> -	/* clean DMA queues and unmap buffers first */
> -	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
> -	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
> -
> -	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PL=
E,
> -	 * to the time ack is received or dropped by hw (air + hw queue time).
> -	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
> -	 */
> -	count =3D FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
> -	for (i =3D 0; i < count; i++) {
> -		u32 msdu, info =3D le32_to_cpu(free->info[i]);
> -		u8 stat;
> -
> -		/* 1'b1: new wcid pair.
> -		 * 1'b0: msdu_id with the same 'wcid pair' as above.
> -		 */
> -		if (info & MT_TX_FREE_PAIR) {
> -			struct mt7921_sta *msta;
> -			struct mt7921_phy *phy;
> -			struct mt76_wcid *wcid;
> -			u16 idx;
> -
> -			count++;
> -			idx =3D FIELD_GET(MT_TX_FREE_WLAN_ID, info);
> -			wcid =3D rcu_dereference(dev->mt76.wcid[idx]);
> -			sta =3D wcid_to_sta(wcid);
> -			if (!sta)
> -				continue;
> -
> -			msta =3D container_of(wcid, struct mt7921_sta, wcid);
> -			phy =3D msta->vif->phy;
> -			spin_lock_bh(&dev->sta_poll_lock);
> -			if (list_empty(&msta->poll_list))
> -				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> -			spin_unlock_bh(&dev->sta_poll_lock);
> -			continue;
> -		}
> -
> -		msdu =3D FIELD_GET(MT_TX_FREE_MSDU_ID, info);
> -		stat =3D FIELD_GET(MT_TX_FREE_STATUS, info);
> -
> -		txwi =3D mt76_token_release(mdev, msdu, &wake);
> -		if (!txwi)
> -			continue;
> -
> -		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
> -	}
> -
> -	if (wake)
> -		mt76_set_tx_blocked(&dev->mt76, false);
> -
> -	napi_consume_skb(skb, 1);
> -
> -	list_for_each_entry_safe(skb, tmp, &free_list, list) {
> -		skb_list_del_init(skb);
> -		napi_consume_skb(skb, 1);
> -	}
> -
> -	mt7921_mac_sta_poll(dev);
> -	mt76_worker_schedule(&dev->mt76.tx_worker);
> -}
> -
>  static bool
>  mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, i=
nt pid,
>  		       __le32 *txs_data)
> @@ -1330,9 +1114,6 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enu=
m mt76_rxq_id q,
>  		type =3D PKT_TYPE_NORMAL_MCU;
> =20
>  	switch (type) {
> -	case PKT_TYPE_TXRX_NOTIFY:
> -		mt7921_mac_tx_free(dev, skb);
> -		break;
>  	case PKT_TYPE_RX_EVENT:
>  		mt7921_mcu_rx_event(dev, skb);
>  		break;
> @@ -1354,33 +1135,6 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, en=
um mt76_rxq_id q,
>  	}
>  }
> =20
> -void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_ent=
ry *e)
> -{
> -	struct mt7921_dev *dev;
> -
> -	if (!e->txwi) {
> -		dev_kfree_skb_any(e->skb);
> -		return;
> -	}
> -
> -	dev =3D container_of(mdev, struct mt7921_dev, mt76);
> -
> -	/* error path */
> -	if (e->skb =3D=3D DMA_DUMMY_DATA) {
> -		struct mt76_txwi_cache *t;
> -		struct mt7921_txp_common *txp;
> -		u16 token;
> -
> -		txp =3D mt7921_txwi_to_txp(mdev, e->txwi);
> -		token =3D le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
> -		t =3D mt76_token_put(mdev, token);
> -		e->skb =3D t ? t->skb : NULL;
> -	}
> -
> -	if (e->skb)
> -		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
> -}
> -
>  void mt7921_mac_reset_counters(struct mt7921_phy *phy)
>  {
>  	struct mt7921_dev *dev =3D phy->dev;
> @@ -1496,20 +1250,6 @@ void mt7921_update_channel(struct mt76_phy *mphy)
>  	mt76_connac_power_save_sched(mphy, &dev->pm);
>  }
> =20
> -void mt7921_tx_token_put(struct mt7921_dev *dev)
> -{
> -	struct mt76_txwi_cache *txwi;
> -	int id;
> -
> -	spin_lock_bh(&dev->mt76.token_lock);
> -	idr_for_each_entry(&dev->mt76.token, txwi, id) {
> -		mt7921_txwi_free(dev, txwi, NULL, false, NULL);
> -		dev->mt76.token_count--;
> -	}
> -	spin_unlock_bh(&dev->mt76.token_lock);
> -	idr_destroy(&dev->mt76.token);
> -}
> -
>  static void
>  mt7921_vif_connect_iter(void *priv, u8 *mac,
>  			struct ieee80211_vif *vif)
> @@ -1524,69 +1264,6 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
>  	mt7921_mcu_set_tx(dev, vif);
>  }
> =20
> -static int
> -mt7921_mac_reset(struct mt7921_dev *dev)
> -{
> -	int i, err;
> -
> -	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
> -
> -	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
> -	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
> -
> -	set_bit(MT76_RESET, &dev->mphy.state);
> -	set_bit(MT76_MCU_RESET, &dev->mphy.state);
> -	wake_up(&dev->mt76.mcu.wait);
> -	skb_queue_purge(&dev->mt76.mcu.res_q);
> -
> -	mt76_txq_schedule_all(&dev->mphy);
> -
> -	mt76_worker_disable(&dev->mt76.tx_worker);
> -	napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
> -	napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
> -	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
> -	napi_disable(&dev->mt76.tx_napi);
> -
> -	mt7921_tx_token_put(dev);
> -	idr_init(&dev->mt76.token);
> -
> -	mt7921_wpdma_reset(dev, true);
> -
> -	mt76_for_each_q_rx(&dev->mt76, i) {
> -		napi_enable(&dev->mt76.napi[i]);
> -		napi_schedule(&dev->mt76.napi[i]);
> -	}
> -
> -	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
> -
> -	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
> -		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
> -		MT_INT_MCU_CMD);
> -	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> -
> -	err =3D mt7921_run_firmware(dev);
> -	if (err)
> -		goto out;
> -
> -	err =3D mt7921_mcu_set_eeprom(dev);
> -	if (err)
> -		goto out;
> -
> -	err =3D mt7921_mac_init(dev);
> -	if (err)
> -		goto out;
> -
> -	err =3D __mt7921_start(&dev->phy);
> -out:
> -	clear_bit(MT76_RESET, &dev->mphy.state);
> -
> -	napi_enable(&dev->mt76.tx_napi);
> -	napi_schedule(&dev->mt76.tx_napi);
> -	mt76_worker_enable(&dev->mt76.tx_worker);
> -
> -	return err;
> -}
> -
>  /* system error recovery */
>  void mt7921_mac_reset_work(struct work_struct *work)
>  {
> @@ -1608,7 +1285,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>  	for (i =3D 0; i < 10; i++) {
>  		__mt7921_mcu_drv_pmctrl(dev);
> =20
> -		if (!mt7921_mac_reset(dev))
> +		if (!mt7921_dev_reset(dev))
>  			break;
>  	}
>  	mutex_unlock(&dev->mt76.mutex);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index e14b86b1c6d1..70c0f41180a1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -133,6 +133,11 @@ struct mt7921_phy {
>  	struct delayed_work scan_work;
>  };
> =20
> +#define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
> +struct mt7921_hif_ops {
> +	int (*reset)(struct mt7921_dev *dev);
> +};
> +
>  struct mt7921_dev {
>  	union { /* must be first */
>  		struct mt76_dev mt76;
> @@ -156,6 +161,7 @@ struct mt7921_dev {
> =20
>  	struct mt76_connac_pm pm;
>  	struct mt76_connac_coredump coredump;
> +	const struct mt7921_hif_ops *hif_ops;
>  };
> =20
>  enum {
> @@ -325,13 +331,13 @@ void mt7921_mac_reset_work(struct work_struct *work=
);
>  void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
>  void mt7921_reset(struct mt76_dev *mdev);
>  void mt7921_tx_cleanup(struct mt7921_dev *dev);
> -int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
> -			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
> -			  struct ieee80211_sta *sta,
> -			  struct mt76_tx_info *tx_info);
> +int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
> +			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
> +			   struct ieee80211_sta *sta,
> +			   struct mt76_tx_info *tx_info);
> =20
>  void mt7921_tx_worker(struct mt76_worker *w);
> -void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_ent=
ry *e);
> +void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_en=
try *e);
>  int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
>  void mt7921_tx_token_put(struct mt7921_dev *dev);
>  void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
> @@ -366,4 +372,13 @@ int mt7921_testmode_cmd(struct ieee80211_hw *hw, str=
uct ieee80211_vif *vif,
>  			void *data, int len);
>  int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
>  			 struct netlink_callback *cb, void *data, int len);
> +void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
> +			   struct sk_buff *skb, struct mt76_wcid *wcid,
> +			   struct ieee80211_key_conf *key, int pid,
> +			   bool beacon);
> +void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
> +void mt7921_mac_sta_poll(struct mt7921_dev *dev);
> +void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
> +			  struct sk_buff *skb);
> +int mt7921e_mac_reset(struct mt7921_dev *dev);
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index cd710360d180..b01b9b7c42b4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -104,9 +104,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  				SURVEY_INFO_TIME_RX |
>  				SURVEY_INFO_TIME_BSS_RX,
>  		.token_size =3D MT7921_TOKEN_SIZE,
> -		.tx_prepare_skb =3D mt7921_tx_prepare_skb,
> -		.tx_complete_skb =3D mt7921_tx_complete_skb,
> -		.rx_skb =3D mt7921_queue_rx_skb,
> +		.tx_prepare_skb =3D mt7921e_tx_prepare_skb,
> +		.tx_complete_skb =3D mt7921e_tx_complete_skb,
> +		.rx_skb =3D mt7921e_queue_rx_skb,
>  		.rx_poll_complete =3D mt7921_rx_poll_complete,
>  		.sta_ps =3D mt7921_sta_ps,
>  		.sta_add =3D mt7921_mac_sta_add,
> @@ -114,6 +114,11 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  		.sta_remove =3D mt7921_mac_sta_remove,
>  		.update_survey =3D mt7921_update_channel,
>  	};
> +
> +	static const struct mt7921_hif_ops mt7921_pcie_ops =3D {
> +		.reset =3D mt7921e_mac_reset,
> +	};
> +
>  	struct mt7921_dev *dev;
>  	struct mt76_dev *mdev;
>  	int ret;
> @@ -147,6 +152,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	}
> =20
>  	dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +	dev->hif_ops =3D &mt7921_pcie_ops;
> =20
>  	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
>  	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> new file mode 100644
> index 000000000000..f211dafa311c
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2021 MediaTek Inc. */
> +
> +#include "mt7921.h"
> +#include "../dma.h"
> +#include "mac.h"
> +
> +static void
> +mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
> +		    void *txp_ptr, u32 id)
> +{
> +	struct mt7921_hw_txp *txp =3D txp_ptr;
> +	struct mt7921_txp_ptr *ptr =3D &txp->ptr[0];
> +	int i, nbuf =3D tx_info->nbuf - 1;
> +
> +	tx_info->buf[0].len =3D MT_TXD_SIZE + sizeof(*txp);
> +	tx_info->nbuf =3D 1;
> +
> +	txp->msdu_id[0] =3D cpu_to_le16(id | MT_MSDU_ID_VALID);
> +
> +	for (i =3D 0; i < nbuf; i++) {
> +		u16 len =3D tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
> +		u32 addr =3D tx_info->buf[i + 1].addr;
> +
> +		if (i =3D=3D nbuf - 1)
> +			len |=3D MT_TXD_LEN_LAST;
> +
> +		if (i & 1) {
> +			ptr->buf1 =3D cpu_to_le32(addr);
> +			ptr->len1 =3D cpu_to_le16(len);
> +			ptr++;
> +		} else {
> +			ptr->buf0 =3D cpu_to_le32(addr);
> +			ptr->len0 =3D cpu_to_le16(len);
> +		}
> +	}
> +}
> +
> +int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
> +			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
> +			   struct ieee80211_sta *sta,
> +			   struct mt76_tx_info *tx_info)
> +{
> +	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
> +	struct ieee80211_key_conf *key =3D info->control.hw_key;
> +	struct mt76_txwi_cache *t;
> +	struct mt7921_txp_common *txp;
> +	int id, pid;
> +	u8 *txwi =3D (u8 *)txwi_ptr;
> +
> +	if (unlikely(tx_info->skb->len <=3D ETH_HLEN))
> +		return -EINVAL;
> +
> +	if (!wcid)
> +		wcid =3D &dev->mt76.global_wcid;
> +
> +	t =3D (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
> +	t->skb =3D tx_info->skb;
> +
> +	id =3D mt76_token_consume(mdev, &t);
> +	if (id < 0)
> +		return id;
> +
> +	if (sta) {
> +		struct mt7921_sta *msta =3D (struct mt7921_sta *)sta->drv_priv;
> +
> +		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
> +			info->flags |=3D IEEE80211_TX_CTL_REQ_TX_STATUS;
> +			msta->last_txs =3D jiffies;
> +		}
> +	}
> +
> +	pid =3D mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
> +	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
> +			      pid, false);
> +
> +	txp =3D (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
> +	memset(txp, 0, sizeof(struct mt7921_txp_common));
> +	mt7921_write_hw_txp(dev, tx_info, txp, id);
> +
> +	tx_info->skb =3D DMA_DUMMY_DATA;
> +
> +	return 0;
> +}
> +
> +static void
> +mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
> +{
> +	struct mt7921_txp_common *txp;
> +	int i;
> +
> +	txp =3D mt7921_txwi_to_txp(dev, t);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
> +		struct mt7921_txp_ptr *ptr =3D &txp->hw.ptr[i];
> +		bool last;
> +		u16 len;
> +
> +		len =3D le16_to_cpu(ptr->len0);
> +		last =3D len & MT_TXD_LEN_LAST;
> +		len &=3D MT_TXD_LEN_MASK;
> +		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
> +				 DMA_TO_DEVICE);
> +		if (last)
> +			break;
> +
> +		len =3D le16_to_cpu(ptr->len1);
> +		last =3D len & MT_TXD_LEN_LAST;
> +		len &=3D MT_TXD_LEN_MASK;
> +		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
> +				 DMA_TO_DEVICE);
> +		if (last)
> +			break;
> +	}
> +}
> +
> +static void
> +mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
> +		 struct ieee80211_sta *sta, bool clear_status,
> +		 struct list_head *free_list)
> +{
> +	struct mt76_dev *mdev =3D &dev->mt76;
> +	__le32 *txwi;
> +	u16 wcid_idx;
> +
> +	mt7921_txp_skb_unmap(mdev, t);
> +	if (!t->skb)
> +		goto out;
> +
> +	txwi =3D (__le32 *)mt76_get_txwi_ptr(mdev, t);
> +	if (sta) {
> +		struct mt76_wcid *wcid =3D (struct mt76_wcid *)sta->drv_priv;
> +
> +		if (likely(t->skb->protocol !=3D cpu_to_be16(ETH_P_PAE)))
> +			mt7921_tx_check_aggr(sta, txwi);
> +
> +		wcid_idx =3D wcid->idx;
> +	} else {
> +		wcid_idx =3D FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
> +	}
> +
> +	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
> +
> +out:
> +	t->skb =3D NULL;
> +	mt76_put_txwi(mdev, t);
> +}
> +
> +static void
> +mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
> +{
> +	struct mt7921_tx_free *free =3D (struct mt7921_tx_free *)skb->data;
> +	struct mt76_dev *mdev =3D &dev->mt76;
> +	struct mt76_txwi_cache *txwi;
> +	struct ieee80211_sta *sta =3D NULL;
> +	LIST_HEAD(free_list);
> +	struct sk_buff *tmp;
> +	bool wake =3D false;
> +	u8 i, count;
> +
> +	/* clean DMA queues and unmap buffers first */
> +	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
> +	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
> +
> +	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PL=
E,
> +	 * to the time ack is received or dropped by hw (air + hw queue time).
> +	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
> +	 */
> +	count =3D FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
> +	for (i =3D 0; i < count; i++) {
> +		u32 msdu, info =3D le32_to_cpu(free->info[i]);
> +		u8 stat;
> +
> +		/* 1'b1: new wcid pair.
> +		 * 1'b0: msdu_id with the same 'wcid pair' as above.
> +		 */
> +		if (info & MT_TX_FREE_PAIR) {
> +			struct mt7921_sta *msta;
> +			struct mt7921_phy *phy;
> +			struct mt76_wcid *wcid;
> +			u16 idx;
> +
> +			count++;
> +			idx =3D FIELD_GET(MT_TX_FREE_WLAN_ID, info);
> +			wcid =3D rcu_dereference(dev->mt76.wcid[idx]);
> +			sta =3D wcid_to_sta(wcid);
> +			if (!sta)
> +				continue;
> +
> +			msta =3D container_of(wcid, struct mt7921_sta, wcid);
> +			phy =3D msta->vif->phy;
> +			spin_lock_bh(&dev->sta_poll_lock);
> +			if (list_empty(&msta->poll_list))
> +				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> +			spin_unlock_bh(&dev->sta_poll_lock);
> +			continue;
> +		}
> +
> +		msdu =3D FIELD_GET(MT_TX_FREE_MSDU_ID, info);
> +		stat =3D FIELD_GET(MT_TX_FREE_STATUS, info);
> +
> +		txwi =3D mt76_token_release(mdev, msdu, &wake);
> +		if (!txwi)
> +			continue;
> +
> +		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
> +	}
> +
> +	if (wake)
> +		mt76_set_tx_blocked(&dev->mt76, false);
> +
> +	napi_consume_skb(skb, 1);
> +
> +	list_for_each_entry_safe(skb, tmp, &free_list, list) {
> +		skb_list_del_init(skb);
> +		napi_consume_skb(skb, 1);
> +	}
> +
> +	mt7921_mac_sta_poll(dev);
> +	mt76_worker_schedule(&dev->mt76.tx_worker);
> +}
> +
> +void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
> +			  struct sk_buff *skb)
> +{
> +	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +	__le32 *rxd =3D (__le32 *)skb->data;
> +	enum rx_pkt_type type;
> +
> +	type =3D FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
> +
> +	switch (type) {
> +	case PKT_TYPE_TXRX_NOTIFY:
> +		mt7921_mac_tx_free(dev, skb);
> +		break;
> +	default:
> +		mt7921_queue_rx_skb(mdev, q, skb);
> +		break;
> +	}
> +}
> +
> +void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_en=
try *e)
> +{
> +	struct mt7921_dev *dev;
> +
> +	if (!e->txwi) {
> +		dev_kfree_skb_any(e->skb);
> +		return;
> +	}
> +
> +	dev =3D container_of(mdev, struct mt7921_dev, mt76);
> +
> +	/* error path */
> +	if (e->skb =3D=3D DMA_DUMMY_DATA) {
> +		struct mt76_txwi_cache *t;
> +		struct mt7921_txp_common *txp;
> +		u16 token;
> +
> +		txp =3D mt7921_txwi_to_txp(mdev, e->txwi);
> +		token =3D le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
> +		t =3D mt76_token_put(mdev, token);
> +		e->skb =3D t ? t->skb : NULL;
> +	}
> +
> +	if (e->skb)
> +		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
> +}
> +
> +void mt7921_tx_token_put(struct mt7921_dev *dev)
> +{
> +	struct mt76_txwi_cache *txwi;
> +	int id;
> +
> +	spin_lock_bh(&dev->mt76.token_lock);
> +	idr_for_each_entry(&dev->mt76.token, txwi, id) {
> +		mt7921_txwi_free(dev, txwi, NULL, false, NULL);
> +		dev->mt76.token_count--;
> +	}
> +	spin_unlock_bh(&dev->mt76.token_lock);
> +	idr_destroy(&dev->mt76.token);
> +}
> +
> +int

can you please remove new line here?

> +mt7921e_mac_reset(struct mt7921_dev *dev)
> +{
> +	int i, err;
> +
> +	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
> +
> +	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
> +	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
> +
> +	set_bit(MT76_RESET, &dev->mphy.state);
> +	set_bit(MT76_MCU_RESET, &dev->mphy.state);
> +	wake_up(&dev->mt76.mcu.wait);
> +	skb_queue_purge(&dev->mt76.mcu.res_q);
> +
> +	mt76_txq_schedule_all(&dev->mphy);
> +
> +	mt76_worker_disable(&dev->mt76.tx_worker);
> +	napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
> +	napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
> +	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
> +	napi_disable(&dev->mt76.tx_napi);
> +
> +	mt7921_tx_token_put(dev);
> +	idr_init(&dev->mt76.token);
> +
> +	mt7921_wpdma_reset(dev, true);
> +
> +	mt76_for_each_q_rx(&dev->mt76, i) {
> +		napi_enable(&dev->mt76.napi[i]);
> +		napi_schedule(&dev->mt76.napi[i]);
> +	}
> +
> +	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
> +
> +	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
> +		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
> +		MT_INT_MCU_CMD);
> +	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> +
> +	err =3D mt7921_run_firmware(dev);
> +	if (err)
> +		goto out;
> +
> +	err =3D mt7921_mcu_set_eeprom(dev);
> +	if (err)
> +		goto out;
> +
> +	err =3D mt7921_mac_init(dev);
> +	if (err)
> +		goto out;
> +
> +	err =3D __mt7921_start(&dev->phy);
> +out:
> +	clear_bit(MT76_RESET, &dev->mphy.state);
> +
> +	napi_enable(&dev->mt76.tx_napi);
> +	napi_schedule(&dev->mt76.tx_napi);
> +	mt76_worker_enable(&dev->mt76.tx_worker);
> +
> +	return err;
> +}
> --=20
> 2.25.1
>=20

--avc4J7JIHHPHavfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHuvQAKCRA6cBh0uS2t
rC/EAQCT0Ip4X1q6km8iYQj0F4WAIeXCHyYywPeE3LEvW/7DQwD7BLuCBfr14v8S
uKIhXPrAVUrO4qfE7akjdbKSXjrHnwc=
=CX7q
-----END PGP SIGNATURE-----

--avc4J7JIHHPHavfO--

