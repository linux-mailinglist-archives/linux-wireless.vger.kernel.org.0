Return-Path: <linux-wireless+bounces-27847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A60BBC08D0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9C4189D3FD
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF9223708;
	Tue,  7 Oct 2025 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="J84tE/sC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFED288AD;
	Tue,  7 Oct 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824464; cv=none; b=CHqOSpW87NotLGjpZ1LfCWwKwg3izZL1isZIfsiPEjiNeeduML4hZIn6ZNssx9si0jpt11ijhYXhRBkqnUU4pl02IvBFUEnpiUp+sYw9ytbCOggD0erAo/dju3RMx6n/s8zoemCKkC4NluEWYBTJiXaS2YWoLTvtUTRsnBGSxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824464; c=relaxed/simple;
	bh=pIxhPGLBhnFaiVzsjXy4P0p2fuzC5L0HB8TGi0u2Ssg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RvTwkXP6xeyznLZ3Ig6lTX39lEq6MrM5IsrTqDKRmwrBFWa6Cah+ViwT/MrpVIcnMROiRSMG06bdTPFTS/RuF9/tub1sLUrs2YBBTcp7t58yT/oyxqWpZMa5wOVbN2qo8el9nlg1zva9K79eB52TEXywYgws7nFqFX3xbmD6i4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=J84tE/sC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59787J2V03747530, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759824439; bh=uuHdzx6LzwNzZ4/Av2MKPj89yJkkQruxKP7LWFT7yxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=J84tE/sC0Qdj1BZvG51K5CFrWRT4dVtkdQZaqaZFisiNCBueYBMoeYUZOkdxVKf33
	 /36SgWw7EgjRuI2HvxAXgf4D806S8/UBkcjODr8jJ7Fb2xAqPj+LF9z9lTPNdqy66r
	 BgaZu6nSgKY01IuvF9ASREKGqJu5BRs59d7EXgfI1Gd9rJBSJmi5cIFcb11t7W3FTb
	 0oQlz3iA39iRvMcQpqOVfb55Ps0AxDuhqcXVaJ02R4tghUmwE5Z0/78C3Jms/Pbhdp
	 8gwdZD+gTl6Oew2MZORY10Ztvpq9QprJ/HZfVdMkLMC2c8j/iOxEgNqpPc3trznkTw
	 J8uBJ2aMJKI6Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59787J2V03747530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 16:07:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 16:07:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 16:07:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 16:07:18 +0800
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
Subject: RE: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for USB via C2H handler
Thread-Topic: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for
 USB via C2H handler
Thread-Index: AQHcM9il/GZvLLVcMUW99DlZMhOcmbS2QTFA
Date: Tue, 7 Oct 2025 08:07:18 +0000
Message-ID: <d72c6bf8618b4245939fd73cd9e24acd@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-8-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-8-pchelkin@ispras.ru>
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
> TX wait skbs need to be completed when they are done.  PCIe part does thi=
s
> inside rtw89_pci_tx_status() during RPP processing.  Other HCIs use a
> mechanism based on C2H firmware messages.
>=20
> Store TX wait skbs inside TX report queue so that it'll be possible to
> identify completed items inside C2H handler via private driver data of
> skb.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>=20
> v2: store TX wait skbs in tx_rpt_queue (Ping-Ke)
>=20
>  drivers/net/wireless/realtek/rtw89/core.c |  6 ++++--
>  drivers/net/wireless/realtek/rtw89/core.h | 15 +++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.c  |  3 ++-
>  drivers/net/wireless/realtek/rtw89/mac.h  | 15 +++++++++++++--
>  drivers/net/wireless/realtek/rtw89/usb.c  |  3 ++-
>  5 files changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 214924f8bee0..1457a5fe7320 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1108,7 +1108,7 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *rt=
wdev,
>                 if (addr_cam->valid && desc_info->mlo)
>                         upd_wlan_hdr =3D true;
>=20
> -               if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS)
> +               if (tx_req->wait || (info->flags & IEEE80211_TX_CTL_REQ_T=
X_STATUS))
>                         rtw89_tx_rpt_enable(rtwdev, tx_req);
>         }
>         is_bmc =3D (is_broadcast_ether_addr(hdr->addr1) ||
> @@ -1173,7 +1173,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_de=
v *rtwdev, struct sk_buff *sk
>=20
>         if (time_left =3D=3D 0) {
>                 ret =3D -ETIMEDOUT;
> -               list_add_tail(&wait->list, &rtwdev->tx_waits);
> +               if (!rtwdev->hci.tx_rpt_enable)
> +                       list_add_tail(&wait->list, &rtwdev->tx_waits);

Oh. You avoid using rtwdev->tx_waits for USB. But I'd like to have the same
behavior as PCIE.

        rtw89_pci_release_txwd_skb() -->
            rtw89_pci_tx_status() -->
		        rtw89_core_tx_wait_complete()
		        ieee80211_tx_status_ni()

    rtw89_usb_write_port_complete() (rtwdev->tx_rpt_queue) -->
        rtw89_mac_c2h_tx_rpt() -->
            rtw89_tx_rpt_tx_status() -->
                rtw89_core_tx_wait_complete()
                ieee80211_tx_status_irqsafe()


As noted by Zong-Zhe before, an important point is that rtwdev->hci.ops->re=
set()
must release all TX packets (rtwdev->tx_rpt_queue), and then it will be saf=
e
to call rtw89_tx_wait_list_clear().

>                 wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_w=
ait_work,
>                                          RTW89_TX_WAIT_WORK_TIMEOUT);
>         } else {
> @@ -1242,6 +1243,7 @@ static int rtw89_core_tx_write_link(struct rtw89_de=
v *rtwdev,
>         tx_req.skb =3D skb;
>         tx_req.vif =3D vif;
>         tx_req.sta =3D sta;
> +       tx_req.wait =3D wait;

Can we move ' rcu_assign_pointer(skb_data->wait, wait);' here, and
callee use rtw89_core_is_tx_wait()? Then, no need rtw89_core_tx_request::wa=
it.


>         tx_req.rtwvif_link =3D rtwvif_link;
>         tx_req.rtwsta_link =3D rtwsta_link;
>         tx_req.desc_info.sw_mld =3D sw_mld;
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
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
>         struct rtw89_tx_desc_info desc_info;
> @@ -7387,6 +7388,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for_=
rx(struct rtw89_dev *rtwdev,
>         return dev_alloc_skb(length);
>  }
>=20
> +static inline bool rtw89_core_is_tx_wait(struct rtw89_dev *rtwdev,
> +                                        struct rtw89_tx_skb_data *skb_da=
ta)
> +{
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
>  static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
>                                                struct rtw89_tx_skb_data *=
skb_data,
>                                                u8 tx_status)
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index 75d9efac452b..3406c8b01eb8 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5484,7 +5484,8 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, stru=
ct sk_buff *c2h, u32 len)
>                         continue;
>=20
>                 __skb_unlink(cur, &rtwdev->tx_rpt_queue);
> -               rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);
> +               if (!rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_sta=
tus))
> +                       rtw89_tx_rpt_tx_status(rtwdev, cur, tx_status);

Can't we use the same style as PCIE?

rtw89_pci_tx_status()
{
	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status))
		return;

   ...
}

>                 break;
>         }
>         spin_unlock_irqrestore(&rtwdev->tx_rpt_queue.lock, flags);
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wirel=
ess/realtek/rtw89/mac.h
> index 1f7d3734d15f..2d647d3b0852 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1647,16 +1647,27 @@ void rtw89_tx_rpt_tx_status(struct rtw89_dev *rtw=
dev, struct sk_buff *skb, u8 tx
>  static inline
>  void rtw89_tx_rpt_queue_purge(struct rtw89_dev *rtwdev)
>  {
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
> +               wait =3D wiphy_dereference(rtwdev->hw->wiphy, skb_data->w=
ait);
> +
> +               if (wait)
> +                       rtw89_tx_wait_release(wait);

As mentioned above, can we just use the same flow as PCIE. Here only call
rtw89_tx_rpt_tx_status(), and callers or rtwdev->tx_wait_work call
rtw89_tx_wait_release().

> +               else
> +                       rtw89_tx_rpt_tx_status(rtwdev, skb, RTW89_TX_MACI=
D_DROP);
> +       }
>  }
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
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


