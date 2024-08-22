Return-Path: <linux-wireless+bounces-11773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3595AAA5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 03:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B74F1F22943
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8A28EF;
	Thu, 22 Aug 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KK1IlqvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C48D299
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291316; cv=none; b=cQqeRYTFUSBx2yk/B9Vm+d1nHQ9avjCdqRx0b6kFpoY/EF8+fgEG8Yf/mURBCKfY2AhlRYfQdWNQ2pbPTb/aDHx+BYiCseiKAxPq4N2Eton8hHLBFNvkISPdLg9RbwLKfcTuBO0Tj5J4QjBBebA399bpvuoh4l7rjzk/OLhjCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291316; c=relaxed/simple;
	bh=/7yiPn7AbB/Ci6ykXZg711b/3EEqnBWJL7VDCax0mc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbiH7oYUbJnRzT3mPox12zKEbH9jF6VLnn0BI2kz3JUJ/G2odiRC1U5Fab9kmKnZpr8qeEIoTt0YD/F827mQgbn+1wvyPqPoam3IzqFpXEhByDFY0YjSwxE8fG2xsZ1UWKEDOA1vpxOCb30iEqVeuzDoldTZ3MDS5ld7i6kpIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KK1IlqvM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M1mOeH53396119, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724291304; bh=/7yiPn7AbB/Ci6ykXZg711b/3EEqnBWJL7VDCax0mc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KK1IlqvM0lgGuqiRQTbVkxHyEVMmdqdQd+KMBMxQxltIu4a9XHiNYVlTh+lMlhlLh
	 DzJS9smXpho6VIPMgaqLO+M9GYerEyz+GIYviK/nU1OMB2WiN9P65/6FXk3DxNsMyy
	 4a+lKwZL8NeYib0X9QDaqsifHBn6BZ5R1ylpoLHia0VrLMJb+Xrd1VkzhXzN/KAZQY
	 hPsP284pkp5N3T9RAti/T5GehQWhCqAGXEDa/wi+pkIiDoKn5+cM0CT4/7qij5+IO3
	 NdKbYUSd8TxvrvVMwNtr/O1KnPPinh0aYpdTCQmPO0aEJCEQtcZVdHqIOeO2noeZbU
	 fkGaPpGR9c85g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M1mOeH53396119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 09:48:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:48:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Aug 2024 09:48:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 22 Aug 2024 09:48:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "pbrobinson@gmail.com" <pbrobinson@gmail.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Thread-Topic: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Thread-Index: AQHa9DSxPPAHrjHHCkiWzpTbPs2zeLIygfOA
Date: Thu, 22 Aug 2024 01:48:25 +0000
Message-ID: <807e1416af114b869da03c44fcfb0931@realtek.com>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
In-Reply-To: <20240822014255.10211-2-pkshih@realtek.com>
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

Hi Peter,

Could you please test v2 again? Thanks.=20

Ping-Ke Shih <pkshih@realtek.com> wrote:
> When removing kernel modules by:
>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
>=20
> Driver uses skb_queue_purge() to purge TX skb, but not report tx status
> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue(=
)
> to correct this.
>=20
> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> between TX work and purge TX queue, flush and destroy TX work in advance.
>=20
>    wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
>      choice (Reason: 3=3DDEAUTH_LEAVING)
>    ------------[ cut here ]------------
>    Have pending ack frames!
>    WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
>        ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
>        6.10.1-200.fc40.aarch64 #1
>    Hardware name: pine64 Pine64 PinePhone Braveheart
>       (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>    pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    sp : ffff80008c1b37b0
>    x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
>    x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
>    x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
>    x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
>    x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
>    x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
>    x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
>    x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
>    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
>    Call trace:
>     ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>     idr_for_each+0x74/0x110
>     ieee80211_free_hw+0x44/0xe8 [mac80211]
>     rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
>     sdio_bus_remove+0x44/0x180
>     device_remove+0x54/0x90
>     device_release_driver_internal+0x1d4/0x238
>     driver_detach+0x54/0xc0
>     bus_remove_driver+0x78/0x108
>     driver_unregister+0x38/0x78
>     sdio_unregister_driver+0x2c/0x40
>     rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
>     __do_sys_delete_module.isra.0+0x190/0x338
>     __arm64_sys_delete_module+0x1c/0x30
>     invoke_syscall+0x74/0x100
>     el0_svc_common.constprop.0+0x48/0xf0
>     do_el0_svc+0x24/0x38
>     el0_svc+0x3c/0x158
>     el0t_64_sync_handler+0x120/0x138
>     el0t_64_sync+0x194/0x198
>    ---[ end trace 0000000000000000 ]---
>=20
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Closes:
> https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_=
hcT=3DOFgmMAb+8MPyA@mail.gmail.
> com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>   - flush and destroy TX work before doing purge_tx_queue
>   - remove "Tested-by: Peter Robinson" since code changed
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 6 +++---
>  drivers/net/wireless/realtek/rtw88/usb.c  | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index 21d0754dd7f6..b67e551fcee3 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1297,12 +1297,12 @@ static void rtw_sdio_deinit_tx(struct rtw_dev *rt=
wdev)
>  	struct rtw_sdio *rtwsdio =3D (struct rtw_sdio *)rtwdev->priv;
>  	int i;
>=20
> -	for (i =3D 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
> -		skb_queue_purge(&rtwsdio->tx_queue[i]);
> -
>  	flush_workqueue(rtwsdio->txwq);
>  	destroy_workqueue(rtwsdio->txwq);
>  	kfree(rtwsdio->tx_handler_data);
> +
> +	for (i =3D 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
> +		ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i]);
>  }
>=20
>  int rtw_sdio_probe(struct sdio_func *sdio_func,
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wirel=
ess/realtek/rtw88/usb.c
> index e83ab6fb83f5..dbc7d8d73494 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -423,10 +423,11 @@ static void rtw_usb_tx_handler(struct work_struct *=
work)
>=20
>  static void rtw_usb_tx_queue_purge(struct rtw_usb *rtwusb)
>  {
> +	struct rtw_dev *rtwdev =3D rtwusb->rtwdev;
>  	int i;
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
> -		skb_queue_purge(&rtwusb->tx_queue[i]);
> +		ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_queue[i]);
>  }
>=20
>  static void rtw_usb_write_port_complete(struct urb *urb)
> @@ -889,9 +890,9 @@ static void rtw_usb_deinit_tx(struct rtw_dev *rtwdev)
>  {
>  	struct rtw_usb *rtwusb =3D rtw_get_usb_priv(rtwdev);
>=20
> -	rtw_usb_tx_queue_purge(rtwusb);
>  	flush_workqueue(rtwusb->txwq);
>  	destroy_workqueue(rtwusb->txwq);
> +	rtw_usb_tx_queue_purge(rtwusb);
>  }
>=20
>  static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
> --
> 2.25.1
>=20


