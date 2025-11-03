Return-Path: <linux-wireless+bounces-28480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D4C29E80
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 04:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 732A3345FCF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 03:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32999154BF5;
	Mon,  3 Nov 2025 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RDkToIF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44734D3BE;
	Mon,  3 Nov 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139123; cv=none; b=q2So6HjESpGWa+pqWtWJIL6H/n2u7jmiIJrlwoBCgTbiqU+6qCJlqH++sV/T7ktvfAwGrqe+BHYyKRdYF5xzr98HwJAbVeDFJ9/97X//Xe9Ijt7F3mJte8asRIFd8OcPu9tL/QkOZL2iKR57oKOVnNF08IEFP1Yn9bXUNe+VviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139123; c=relaxed/simple;
	bh=h2on8smZNhSjND6dDV/2OQmdbs3lEHFCbUmsU4mkBno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilNeIlUIPjRwbTEIp5PVLi5XAqQ4pQb7pYa1JJYKg0imnFakJp+bRlqUrJWPGlNZORsIXdv8HmYN4wSLAytO+k1MCaPdEKcPTCWHUwfzGrRbSccMRcFivlmRuT/N3BAv5eM3fycwIRmm3jOt4IhyXDeoHqx7IY7kO+jVc0BIZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RDkToIF1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A3353Ar8687552, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762139103; bh=CDIb0DFGsEfP0VvgpwQqbMHWoefHoMlYMo8jDAfDT8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RDkToIF1xJ9sGZEZZY2zhG5QZ/kZMPMq8cIaVYEEWBRwz0e846CP3sclBjP/Es9Wh
	 zX1ePHkLNvtW7/4FcgFLuDNuSejEtRjm7hAfiTJ+vEVXript5sfv1ss/C7/w3wug1P
	 hU2qqchtwzlQ+s1hz0sx7hyDUtGoNM4KjgqomauPdVGznygiLC3THuag1P8YqBix3q
	 LNIrXf3Fomb+PuLt/8v8GdCI2bh4N3k5hKt4g1zuSduSmdqsf6D1d0bKCET+YuE4Aj
	 Fn4NZ68yXKuek9zNh9tdWzhaEXLnSr2ZN/B7xHIhmZlJINjZFxfsVaFMIW4hIrM9u6
	 OrQSEEWSpN/tQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A3353Ar8687552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 11:05:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 11:05:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 11:05:03 +0800
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
Subject: RE: [PATCH rtw-next v4 08/10] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v4 08/10] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcSQcQXOM7uN/tL0SzUQvbc//iV7TgQVHA
Date: Mon, 3 Nov 2025 03:05:03 +0000
Message-ID: <1f5893398aac4966a2ae2939a6cb7f9c@realtek.com>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
 <20251029190241.1023856-9-pchelkin@ispras.ru>
In-Reply-To: <20251029190241.1023856-9-pchelkin@ispras.ru>
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
> Frames flagged with IEEE80211_TX_CTL_REQ_TX_STATUS mean the driver has to
> report to mac80211 stack whether AP sent ACK for the null frame/probe
> request or not.  It's not implemented in USB part of the driver yet.
>=20
> PCIe HCI has its own way of getting TX status incorporated into RPP
> feature, and it's always enabled there.  Other HCIs need a different
> scheme based on processing C2H messages.
>=20
> Thus define a .tx_rpt_enabled flag indicating which HCIs need to enable a
> TX report feature.  Currently it is USB only.
>=20
> Toggle a bit in the TX descriptor and place flagged skbs in a fix-sized
> queue to wait for a message from the firmware.  Firmware maintains a 4-bi=
t
> sequence number for required frames hence the queue can contain just 16
> elements simultaneously.  That's enough for normal driver / firmware
> communication.  If the firmware crashes for any reason and doesn't provid=
e
> TX reports in time, driver will handle this and report the obsolete frame=
s
> as dropped.
>=20
> rtw89 also has a new feature providing a TX report for each transmission
> attempt.  Ignore a failed TX status reported by the firmware until retry
> limit is reached or successful status appears.  When there is no success
> and the retry limit is reached, report the frame up to the wireless stack
> as failed eventually.
>=20
> HCI reset should stop all pending TX activity so forcefully flush the
> queue there.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Thanks for your work. I have only some minor suggestions for v4.

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index 9372e30a0039..015d7833841f 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3517,6 +3517,14 @@ struct rtw89_phy_rate_pattern {
>  #define RTW89_TX_LIFE_TIME             0x2
>  #define RTW89_TX_MACID_DROP            0x3
>=20
> +#define RTW89_MAX_TX_RPTS              16
> +#define RTW89_MAX_TX_RPTS_MASK         (RTW89_MAX_TX_RPTS - 1)
> +struct rtw89_tx_rpt {
> +       struct sk_buff *skbs[RTW89_MAX_TX_RPTS];
> +       spinlock_t skb_lock;

I think we should add a comment to describe how/where this lock can be used=
.
At least checkpatch will complain this.=20

> +       atomic_t sn;
> +};
> +
>  #define RTW89_TX_WAIT_WORK_TIMEOUT msecs_to_jiffies(500)
>  struct rtw89_tx_wait_info {
>         struct rcu_head rcu_head;

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index e4e126a4428b..a6642c5761cb 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5463,7 +5463,10 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h, u32
>  static void
>  rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
>  {
> +       struct rtw89_tx_rpt *tx_rpt =3D &rtwdev->tx_rpt;
> +       struct rtw89_tx_skb_data *skb_data;
>         u8 sw_define, tx_status, txcnt;
> +       struct sk_buff *skb;
>=20
>         if (rtwdev->chip->chip_id =3D=3D RTL8922A) {
>                 const struct rtw89_c2h_mac_tx_rpt_v2 *rpt_v2;
> @@ -5492,6 +5495,29 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, str=
uct sk_buff *c2h, u32 len)
>         rtw89_debug(rtwdev, RTW89_DBG_TXRX,
>                     "C2H TX RPT: sn %d, tx_status %d, txcnt %d\n",
>                     sw_define, tx_status, txcnt);

To claim sw_define is not over size of tx_rpt->skbs[], we can add below:

	static_assert(hweight32(RTW89_MAX_TX_RPTS_MASK) =3D=3D
		      hweight32(RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2) &&
		      hweight32(RTW89_MAX_TX_RPTS_MASK) =3D=3D
		      hweight32(RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE));


> +
> +       scoped_guard(spinlock_irqsave, &tx_rpt->skb_lock) {
> +               skb =3D tx_rpt->skbs[sw_define];
> +
> +               /* skip if no skb (normally shouldn't happen) */
> +               if (!skb) {
> +                       rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> +                                   "C2H TX RPT: no skb found in queue\n"=
);
> +                       return;
> +               }
> +
> +               skb_data =3D RTW89_TX_SKB_CB(skb);
> +
> +               /* skip if TX attempt has failed and retry limit has not =
been
> +                * reached yet
> +                */
> +               if (tx_status !=3D RTW89_TX_DONE &&
> +                   txcnt !=3D skb_data->tx_pkt_cnt_lmt)
> +                       return;
> +
> +               tx_rpt->skbs[sw_define] =3D NULL;
> +               rtw89_tx_rpt_tx_status(rtwdev, skb, tx_status);
> +       }
>  }
>=20
>  static void

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wirel=
ess/realtek/rtw89/usb.c
> index c359b469aabe..5e587c93268e 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -216,6 +216,15 @@ static void rtw89_usb_write_port_complete(struct urb=
 *urb)
>                 skb_pull(skb, txdesc_size);
>=20
>                 info =3D IEEE80211_SKB_CB(skb);

Since newly added chunk doesn't use 'info', just do it before
ieee80211_tx_info_clear_status().

> +               if (rtw89_is_tx_rpt_skb(skb)) {
> +                       if (urb->status =3D=3D 0)
> +                               rtw89_tx_rpt_skb_add(rtwdev, skb);
> +                       else
> +                               rtw89_tx_rpt_tx_status(rtwdev, skb,
> +                                                      RTW89_TX_MACID_DRO=
P);
> +                       continue;
> +               }
> +
>                 ieee80211_tx_info_clear_status(info);
>=20
>                 if (urb->status =3D=3D 0) {

[...]


