Return-Path: <linux-wireless+bounces-28168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0810BFA7EC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF003BCFA1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89D2741C9;
	Wed, 22 Oct 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O3YN/Dnb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C2F0696;
	Wed, 22 Oct 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117416; cv=none; b=cxpIJ45+SH34iga3x0l7PwqRcqRPQbfinUaCyS8weiPIUcpUuOiG2MxQlSlqLQaOtDLa0HPofEzgAwtjXbItHl2tABQ7YLhn+ADkttVxCwU6w9BIH+t8neC65EhKjKMz4Yri6XAh0DBbPdIVdZMW/pvyhEbcWOF1wDeR5fUQ00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117416; c=relaxed/simple;
	bh=9KyRLffYZn/1R/j/NrY0Va8P1n70+Q8QudJewXlBKNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bD9GRJs1CzwkbW0He4gC6/7TN+Yv19+RT/nwTpSDGaP2KNB5jL16bzLJKrJkrfo5hNv8MjehzvOx9m5HJvTxCU1ahZ55/nowp0zeSrDL0ADnH9ophCa8ZGrDq/ZqiA2ytGm6wL2aR3svaRib7DTcgP4bym38Y6yKVQQop+h6dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O3YN/Dnb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59M7GaoL6235495, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761117396; bh=/7j7wE2J1uwPHN+kRObPPTkzhTBOQUo2mxff1oyPNeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=O3YN/DnbatKCQgEiw42+2U/O4GoZdpuur9MawxL5In02aCgLtPTEJVhpbY9tsEfkD
	 R6SOijWcqnlDKMntzlKHBpB8E/k6tq64vBASB8aZExz2UrfORX1lBk6kyRi3WpXw7k
	 kpCRlKuwJnL/WK/Jg8gQGlmMOZbaEhRkSwiHAvv5mvr8d8uiBMm5bD8g9Eo07VBmVX
	 QJhXnLGloJ3T2A30iFBKco4ZFfuP4FCs66peS+OkA2ICLnApcmFMHt5pAeCFQK2V5F
	 CEV0GDsoPjDJosf3592jABFbgLTVs4ZjiHWyUX7QNhl8p79vpsZL+Gx4lVo5Dr+vBr
	 hUWuWbqrpp13Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59M7GaoL6235495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:16:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 15:16:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 22 Oct 2025 15:16:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3 7/9] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v3 7/9] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcP03+N98C+NXP40OStTAnFiNodrTNutGw
Date: Wed, 22 Oct 2025 07:16:36 +0000
Message-ID: <f013f65b97a447e2b744a4f3d6aff269@realtek.com>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-8-pchelkin@ispras.ru>
In-Reply-To: <20251017100658.66581-8-pchelkin@ispras.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index abe8eec1d0f5..3aa9a9a28118 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1112,6 +1112,9 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rt=
wdev,
>         if (addr_cam->valid && desc_info->mlo)
>                 upd_wlan_hdr =3D true;
>=20
> +       if (rtw89_is_tx_rpt_skb(tx_req->skb))
> +               rtw89_tx_rpt_init(rtwdev, tx_req);
> +
>         is_bmc =3D (is_broadcast_ether_addr(hdr->addr1) ||
>                   is_multicast_ether_addr(hdr->addr1));
>=20
> @@ -5849,6 +5852,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
>         wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6gh=
z_probe_work);
>         INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
>=20
> +       skb_queue_head_init(&rtwdev->tx_rpt.queue);

not sure if it's worth to initialize tx_rpt.sn to zero?

>         skb_queue_head_init(&rtwdev->c2h_queue);
>         rtw89_core_ppdu_sts_init(rtwdev);
>         rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index 66b7bfa5902e..8641e3a8d36d 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3516,6 +3516,11 @@ struct rtw89_phy_rate_pattern {
>  #define RTW89_TX_LIFE_TIME             0x2
>  #define RTW89_TX_MACID_DROP            0x3
>=20
> +struct rtw89_tx_rpt {
> +       struct sk_buff_head queue;
> +       atomic_t sn;
> +};
> +
>  #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
>  struct rtw89_tx_wait_info {
>         struct rcu_head rcu_head;
> @@ -3527,6 +3532,8 @@ struct rtw89_tx_wait_info {
>=20
>  struct rtw89_tx_skb_data {
>         struct rtw89_tx_wait_info __rcu *wait;
> +       u8 tx_rpt_sn;
> +       u8 tx_pkt_cnt_lmt;
>         u8 hci_priv[];
>  };
>=20
> @@ -3696,6 +3703,7 @@ struct rtw89_hci_info {
>         u32 rpwm_addr;
>         u32 cpwm_addr;
>         bool paused;
> +       bool tx_rpt_enabled;
>  };
>=20
>  struct rtw89_chip_ops {
> @@ -6015,6 +6023,8 @@ struct rtw89_dev {
>         struct list_head tx_waits;
>         struct wiphy_delayed_work tx_wait_work;
>=20
> +       struct rtw89_tx_rpt tx_rpt;
> +
>         struct rtw89_cam_info cam_info;
>=20
>         struct sk_buff_head c2h_queue;
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index 2fe239f18534..26c7476afdec 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5460,7 +5460,11 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h, u32
>  static void
>  rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
>  {
> +       struct rtw89_tx_rpt *tx_rpt =3D &rtwdev->tx_rpt;
>         u8 sw_define, tx_status, data_txcnt;
> +       struct rtw89_tx_skb_data *skb_data;
> +       struct sk_buff *skb, *tmp;
> +       unsigned long flags;
>=20
>         if (rtwdev->chip->chip_id =3D=3D RTL8922A) {
>                 const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
> @@ -5484,6 +5488,26 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, str=
uct sk_buff *c2h, u32 len)
>         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
>                     "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
>                     sw_define, tx_status, data_txcnt);
> +
> +       spin_lock_irqsave(&tx_rpt->queue.lock, flags);
> +       skb_queue_walk_safe(&tx_rpt->queue, skb, tmp) {
> +               skb_data =3D RTW89_TX_SKB_CB(skb);
> +
> +               /* skip if sequence number doesn't match */
> +               if (sw_define !=3D skb_data->tx_rpt_sn)
> +                       continue;
> +               /* skip if TX attempt has failed and retry limit has not =
been
> +                * reached yet
> +                */
> +               if (tx_status !=3D RTW89_TX_DONE &&
> +                   data_txcnt !=3D skb_data->tx_pkt_cnt_lmt)
> +                       continue;
> +
> +               __skb_unlink(skb, &tx_rpt->queue);
> +               rtw89_tx_rpt_tx_status(rtwdev, skb, tx_status);

Would it be better to run rtw89_tx_rpt_tx_status() after this loop outside
spin_lock()?

> +               break;
> +       }
> +       spin_unlock_irqrestore(&tx_rpt->queue.lock, flags);
>  }
>=20
>  static void
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wirel=
ess/realtek/rtw89/mac.h
> index 15c5c7e4033c..e8bd92223497 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1616,4 +1616,60 @@ int rtw89_mac_scan_offload(struct rtw89_dev *rtwde=
v,
>=20
>         return ret;
>  }
> +
> +static inline
> +void rtw89_tx_rpt_init(struct rtw89_dev *rtwdev,
> +                      struct rtw89_core_tx_request *tx_req)
> +{
> +       struct rtw89_tx_rpt *tx_rpt =3D &rtwdev->tx_rpt;
> +
> +       if (!rtwdev->hci.tx_rpt_enabled)
> +               return;
> +
> +       tx_req->desc_info.report =3D true;
> +       /* firmware maintains a 4-bit sequence number */
> +       tx_req->desc_info.sn =3D atomic_inc_return(&tx_rpt->sn) & 0xF;
> +       tx_req->desc_info.tx_cnt_lmt_en =3D true;
> +       tx_req->desc_info.tx_cnt_lmt =3D 8;
> +}
> +
> +static inline
> +bool rtw89_is_tx_rpt_skb(struct sk_buff *skb)
> +{
> +       struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +
> +       return info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS;
> +}
> +
> +static inline
> +void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtwdev, struct sk_buff *sk=
b, u8 tx_status)
> +{
> +       struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> +
> +       ieee80211_tx_info_clear_status(info);
> +       if (tx_status =3D=3D RTW89_TX_DONE)
> +               info->flags |=3D IEEE80211_TX_STAT_ACK;
> +       else
> +               info->flags &=3D ~IEEE80211_TX_STAT_ACK;
> +
> +       ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
> +}
> +
> +static inline
> +void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
> +{
> +       struct rtw89_tx_rpt *tx_rpt =3D &rtwdev->tx_rpt;
> +       struct sk_buff_head q;
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +
> +       __skb_queue_head_init(&q);
> +
> +       spin_lock_irqsave(&tx_rpt->queue.lock, flags);
> +       skb_queue_splice_init(&tx_rpt->queue, &q);
> +       spin_unlock_irqrestore(&tx_rpt->queue.lock, flags);
> +
> +       while ((skb =3D __skb_dequeue(&q)))
> +               rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
> +}
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index 655e8437d62e..22994c3501f8 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -216,6 +216,14 @@ static void rtw89_usb_write_port_complete(struct urb=
 *urb)
>                 skb_pull(skb, txdesc_size);
>=20
>                 info =3D IEEE80211_SKB_CB(skb);
> +               if (rtw89_is_tx_rpt_skb(skb)) {
> +                       /* sequence number is passed to rtw89_mac_c2h_tx_=
rpt() via

nit: The 'via' is over 80 characters a little bit. Move to next line.

> +                        * driver data
> +                        */
> +                       skb_queue_tail(&rtwdev->tx_rpt.queue, skb);
> +                       continue;
> +               }
> +
>                 ieee80211_tx_info_clear_status(info);
>=20
>                 if (urb->status =3D=3D 0) {

Should we move this checking upward? Enqueue skb into tx_rpt_skb only if
urb->status =3D=3D 0?

> @@ -372,6 +380,7 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *r=
twdev,
>  {
>         struct rtw89_tx_desc_info *desc_info =3D &tx_req->desc_info;
>         struct rtw89_usb *rtwusb =3D rtw89_usb_priv(rtwdev);
> +       struct rtw89_tx_skb_data *skb_data;
>         struct sk_buff *skb =3D tx_req->skb;
>         struct rtw89_txwd_body *txdesc;
>         u32 txdesc_size;
> @@ -398,6 +407,9 @@ static int rtw89_usb_ops_tx_write(struct rtw89_dev *r=
twdev,
>=20
>         le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE)=
;
>=20
> +       skb_data =3D RTW89_TX_SKB_CB(skb);
> +       skb_data->tx_rpt_sn =3D tx_req->desc_info.sn;

Shouldn't set skb_data->tx_pkt_cnt_lmt?=20

skb_data->tx_pkt_cnt_lmt =3D tx_req->desc_info.tx_cnt_lmt;

Also, should we check desc_info.{report, tx_cnt_lmt_en} individually before=
=20
setting?


> +
>         skb_queue_tail(&rtwusb->tx_queue[desc_info->ch_dma], skb);
>=20
>         return 0;
> @@ -678,7 +690,7 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtw=
dev)
>=20
>  static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
>  {
> -       /* TODO: anything to do here? */
> +       rtw89_tx_rpt_queue_purge(rtwdev);

Have you consider the SKB that has been rtw89_usb_write_port() but
has not yet rtw89_usb_write_port_complete()?

Since we call rtw89_mac_pwr_off() before rtw89_hci_reset() in=20
rtw89_core_stop(), it should be not more C2H at rtw89_hci_reset().
It seems to be safe, right?

Also, all are dropped, can't we just call ieee80211_purge_tx_queue()?

>  }
>=20
>  static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
> @@ -962,6 +974,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
>=20
>         rtwdev->hci.ops =3D &rtw89_usb_ops;
>         rtwdev->hci.type =3D RTW89_HCI_TYPE_USB;
> +       rtwdev->hci.tx_rpt_enabled =3D true;
>=20
>         ret =3D rtw89_usb_intf_init(rtwdev, intf);
>         if (ret) {
> --
> 2.51.0
>=20


