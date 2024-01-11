Return-Path: <linux-wireless+bounces-1683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6892482A587
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 02:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B96285CD5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278A10FC;
	Thu, 11 Jan 2024 01:22:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE210F8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40B1LZpR41342111, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40B1LZpR41342111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 09:21:35 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 11 Jan 2024 09:21:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Jan 2024 09:21:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Thu, 11 Jan 2024 09:21:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
Thread-Index: AQHaQ7FJIRSod+cmIUG5nhwVhackgrDTz7Xw
Date: Thu, 11 Jan 2024 01:21:35 +0000
Message-ID: <cf31e4c5e1a04230891e5bbbff5d24ff@realtek.com>
References: <20240110103909.240514-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240110103909.240514-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Wednesday, January 10, 2024 6:39 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
>=20
> The CSA countdown in the beacon frames, which are sent out by firmware,
> needs to get updated by the driver. To achieve this, convert
> update_beacon_work to delayed_work and schedule it with the beacon
> interval in case CSA is active and the countdown is not complete.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
> changes v1->v2: use delayed_work instead of usleep_range
> v1: https://lore.kernel.org/linux-wireless/20240108111103.121378-1-martin=
.kaistra@linutronix.de/
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  2 +-
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>=20

[...]

> @@ -7764,7 +7772,7 @@ static int rtl8xxxu_probe(struct usb_interface *int=
erface,
>         spin_lock_init(&priv->rx_urb_lock);
>         INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
>         INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback)=
;
> -       INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_=
callback);
> +       INIT_DELAYED_WORK(&priv->update_beacon_work, rtl8xxxu_update_beac=
on_work_callback);

It seems like we missed cancel priv->update_beacon_work work at rtl8xxxu_st=
op().
Because that isn't introduced by this patch, you can decide to do it in thi=
s
patch or not. Also, 'struct work_struct c2hcmd_work;' has similar problem.=
=20

This could be a problem theoretically, but not easy to see the problem thou=
gh. =20


>         skb_queue_head_init(&priv->c2hcmd_queue);
>=20
>         usb_set_intfdata(interface, hw);

[...]


