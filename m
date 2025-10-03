Return-Path: <linux-wireless+bounces-27795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B6BB5CC6
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 04:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3164857C7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026872D24B8;
	Fri,  3 Oct 2025 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UFb4qocw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC42C234E;
	Fri,  3 Oct 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458274; cv=none; b=U6w/pqQ1AmuG5wtRBx5ufDGMC+ITsaohlMzA8VQVbfGlfrpoZ9DHtKWtBO0IhTVlbGvEO64ZohCf5DHA6Xy4CEPWyvy/laP+Ww3b+S1XFNpuGWGGytndedmPU6euvvZ3Znj9wSnta20t8aBlYcI9BqmI6kE05mJ9+swC2N+W370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458274; c=relaxed/simple;
	bh=LBxsDWoJZKDFGEW0UEwCiRBLHOTI5flpTKrab/4SDOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bYz84elCyVSo9VPbgS5YVqsI9oF9VaGA+qhlNNrQq+SNAtM04sMciw30Kv+sZgNZHuB6W/uZ30IWoTKWziuO+/zubIKxR9dNXcm0h7j5lfWOJdWTq2LX4TEtF+VfHsDvEz+d+G+5sd3n3lMWwyIOBq7CsEXnu+CGKqHnWm3Q8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UFb4qocw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5932NsZD21421547, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759458235; bh=rEo3lJ29eQma0YrrqavmNFuqzWsWmYB1/V70J12ZpeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UFb4qocwudRO82GChfeg6uS8yL+Xklox2qWZ5O5pPgCbbzFc2p/Yyy0oUt6R14foh
	 Fjhx4IecErT/ea8b8pq6TXrquJqefDklfXxIpPH+6OMIGmganGg2bU9CzCOxlfAZ7q
	 jqxldV/XphtXRtLjmsPAY2UT/BuqENl3+KYBGh3PzRI5SFpLi3cI0Z2zR/NP/5Yhqz
	 4azvTk4i5pZ2amYfecnPaogiU4PZckR86UlAMNO+cmhVWz4J9PYPlWbgwfDt3HwE/e
	 wRm25uvphvYcoT/4nAWNFkWjbLbV9x1H5EEASjkt+KaADTB7STLzE/yDcSsrQ2EXX5
	 K+P06TWhXYWEg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5932NsZD21421547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 10:23:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 3 Oct 2025 10:23:54 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::4cea:c4d0:d7fe:6f43]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::4cea:c4d0:d7fe:6f43%9]) with mapi id
 15.02.1544.027; Fri, 3 Oct 2025 10:23:54 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for USB via C2H handler
Thread-Topic: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for
 USB via C2H handler
Thread-Index: AQHcM9itLdwkfiWn4kG/V75NxkouT7SvsPlg
Date: Fri, 3 Oct 2025 02:23:54 +0000
Message-ID: <c84a9b8853f64b9e868102126b013074@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-8-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-8-pchelkin@ispras.ru>
Accept-Language: zh-TW, en-US
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
>=20
> TX wait skbs need to be completed when they are done.  PCIe part does thi=
s inside
> rtw89_pci_tx_status() during RPP processing.  Other HCIs use a mechanism =
based on C2H
> firmware messages.
>=20
> Store TX wait skbs inside TX report queue so that it'll be possible to id=
entify completed items
> inside C2H handler via private driver data of skb.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>=20
> v2: store TX wait skbs in tx_rpt_queue (Ping-Ke)
>=20
>  drivers/net/wireless/realtek/rtw89/core.c |  6 ++++--
> drivers/net/wireless/realtek/rtw89/core.h | 15 +++++++++++++++
> drivers/net/wireless/realtek/rtw89/mac.c  |  3 ++-
> drivers/net/wireless/realtek/rtw89/mac.h  | 15 +++++++++++++--
> drivers/net/wireless/realtek/rtw89/usb.c  |  3 ++-
>  5 files changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 214924f8bee0..1457a5fe7320 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1108,7 +1108,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rt=
wdev,
>                 if (addr_cam->valid && desc_info->mlo)
>                         upd_wlan_hdr =3D true;
>=20
> -               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
> +               if (tx_req->wait || (info->flags &
> + IEEE80211_TX_CTL_REQ_TX_STATUS))
>                         rtw89_tx_rpt_enable(rtwdev, tx_req);
>         }
>         is_bmc =3D (is_broadcast_ether_addr(hdr->addr1) || @@ -1173,7 +11=
73,8 @@ int
> rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff =
*sk
>=20
>         if (time_left =3D=3D 0) {
>                 ret =3D -ETIMEDOUT;
> -               list_add_tail(&wait->list, &rtwdev->tx_waits);
> +               if (!rtwdev->hci.tx_rpt_enable)
> +                       list_add_tail(&wait->list, &rtwdev->tx_waits);
>                 wiphy_delayed_work_queue(rtwdev->hw->wiphy,
> &rtwdev->tx_wait_work,
>                                          RTW89_TX_WAIT_WORK_TIMEOUT);
>         } else {
> @@ -1242,6 +1243,7 @@ static int rtw89_core_tx_write_link(struct rtw89_de=
v *rtwdev,
>         tx_req.skb =3D skb;
>         tx_req.vif =3D vif;
>         tx_req.sta =3D sta;
> +       tx_req.wait =3D wait;
>         tx_req.rtwvif_link =3D rtwvif_link;
>         tx_req.rtwsta_link =3D rtwsta_link;
>         tx_req.desc_info.sw_mld =3D sw_mld; diff --git
> a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realte=
k/rtw89/core.h
> index 3940e54353d3..c13465e2730a 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -1201,6 +1201,7 @@ struct rtw89_core_tx_request {
>         struct sk_buff *skb;
>         struct ieee80211_vif *vif;
>         struct ieee80211_sta *sta;
> +       struct rtw89_tx_wait_info *wait;
>         struct rtw89_vif_link *rtwvif_link;
>         struct rtw89_sta_link *rtwsta_link;
>         struct rtw89_tx_desc_info desc_info; @@ -7387,6 +7388,20 @@ stati=
c inline struct
> sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
>         return dev_alloc_skb(length);
>  }
>=20
> +static inline bool rtw89_core_is_tx_wait(struct rtw89_dev *rtwdev,
> +                                        struct rtw89_tx_skb_data
> +*skb_data) {
> +       struct rtw89_tx_wait_info *wait;
> +
> +       guard(rcu)();
> +
> +       wait =3D rcu_dereference(skb_data->wait);
> +       if (!wait)
> +               return false;
> +
> +       return true;
> +}
> +

Look like using rcu_access_pointer() is enough for here.

>  static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
>                                                struct rtw89_tx_skb_data
> *skb_data,
>                                                u8 tx_status) diff --git
> a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek=
/rtw89/mac.c
> index 75d9efac452b..3406c8b01eb8 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5484,7 +5484,8 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, stru=
ct sk_buff
> *c2h, u32 len)
>                         continue;
>=20
>                 __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> -               rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
> +               if (!rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_sta=
tus))
> +                       rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
>                 break;
>         }
>         spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags); diff -=
-git
> a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek=
/rtw89/mac.h
> index 1f7d3734d15f..2d647d3b0852 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1647,16 +1647,27 @@ void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtw=
dev, struct
> sk_buff *skb, u8 tx  static inline  void rtw89_tx_rpt_queue_purge(struct =
rtw89_dev *rtwdev)
> {
> +       struct rtw89_tx_skb_data *skb_data;
> +       struct rtw89_tx_wait_info *wait;
>         struct sk_buff_head q;
>         struct sk_buff *skb;
>         unsigned long flags;
>=20
> +       lockdep_assert_wiphy(rtwdev->hw->wiphy);
> +
>         __skb_queue_head_init(&q);
>         spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
>         skb_queue_splice_init(&rtwdev->tx_rpt_queue, &q);
>         spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
>=20
> -       while ((skb =3D __skb_dequeue(&q)))
> -               rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACID_DROP);
> +       while ((skb =3D __skb_dequeue(&q))) {
> +               skb_data =3D RTW89_TX_SKB_CB(skb);
> +               wait =3D wiphy_dereference(rtwdev->hw->wiphy,
> + skb_data->wait);
> +
> +               if (wait)
> +                       rtw89_tx_wait_release(wait);
> +               else
> +                       rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACI=
D_DROP);
> +       }
>  }
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c
> b/drivers/net/wireless/realtek/rtw89/usb.c
> index f53ab676e9a8..adbadb2783f0 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -216,7 +216,8 @@ static void rtw89_usb_write_port_complete(struct urb =
*urb)
>                 skb_pull(skb, txdesc_size);
>=20
>                 info =3D IEEE80211_SKB_CB(skb);
> -               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> +               if (rtw89_core_is_tx_wait(rtwdev, RTW89_TX_SKB_CB(skb)) |=
|
> +                   (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)) {
>                         /* sn is passed to rtw89_mac_c2h_tx_rpt() via dri=
ver data */
>                         skb_queue_tail(&rtwdev->tx_rpt_queue, skb);
>                         wiphy_delayed_work_queue(rtwdev->hw->wiphy,
> --
> 2.51.0
>=20


