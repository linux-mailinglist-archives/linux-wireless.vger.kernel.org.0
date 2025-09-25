Return-Path: <linux-wireless+bounces-27642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B7B9D558
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 05:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7877384B53
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 03:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A01BC9E2;
	Thu, 25 Sep 2025 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c5rUKeBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F9DF49;
	Thu, 25 Sep 2025 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772256; cv=none; b=Rxv5x2tWGdBfpCQnCEORkSWzYqJTKon6AiuwBMWgUxZNYC8jp15k9bXBOaFotBvQDis2rdKVQmwHUdzqUyBDMY9UY28sQ+o2WeyqGqqDrgnP9EjN9JGAM/EfpnFWs4Q0U94Nm0+80ezzBUCgiFDHsivXdv+Ji6yPbRHQ09OTVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772256; c=relaxed/simple;
	bh=u+YG2r1SNvMdS8TBEwU5LGMaEoPJiBDgeoIbB7TL2cI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sn0EV/WMnOpD72lq3VRlqyEpPrFn5onRsbmNtVGlyv7vanKsbU/4uI8zVjyrJueDkpNNysE8jkVC7T7KzQrXqHjZ3NGcQJQNtmM3lo28yqJmZzCGn/qfIXHRSpo06tF2sADkeHJBFCtG5G9bbv+R19E0xhd7bU+/ADQgIQvf1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c5rUKeBP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58P3obscF598126, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758772237; bh=Nv+QKKiTdimLoBy6nI6TipBmRe22MP8UB9z+42n3ScI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=c5rUKeBPJlfsyA978VIMPYlw/7yCME6vNsb3WxqxsJzDC8JJNBa3w7fTsIvhlsmJ9
	 re3eCkdPj3oDFnOkFXlltYUwQF7ZP4XlTf+YtoZz1XzDGUIO2O8aVnoQ/Yhu8PlhSZ
	 irmp4kZdEoYDcsOFxMPx1bA0nBqV6SCykilDMTOpijxc0+p1nUGk3mHcSov197XCs/
	 E29WFg6xd72Xv0P43kkcrDVHuZD0fzbJ+Y6jT0XyOsnAj4XvRrvwCb6d5sOxLwNq6E
	 TnVX3h3x9wvwmACNJNVJTF0R0cuFFKjHHZwXW+/9S0cU4dr3tksVWDAClzN6jwm4lL
	 gMvlF7eY9VhJA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58P3obscF598126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 11:50:37 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 11:50:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 11:50:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 25 Sep 2025 11:50:37 +0800
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
Subject: RE: [PATCH rtw-next 6/6] wifi: rtw89: forcefully clear TX wait list on HCI reset
Thread-Topic: [PATCH rtw-next 6/6] wifi: rtw89: forcefully clear TX wait list
 on HCI reset
Thread-Index: AQHcKjJ745QK2h3rIEmncWsot8cSj7SjSEhg
Date: Thu, 25 Sep 2025 03:50:37 +0000
Message-ID: <0c30dbd0d1d243d1a9e4336b979ecb9a@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-7-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-7-pchelkin@ispras.ru>
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
> TX status reporting based on firmware messages does not necessarily happe=
n
> when an HCI reset occurs, in contrast to RPP based one where pending skbs
> are forcefully flushed, see rtw89_pci_release_txwd_skb().

Is it possible that USB implement HCI reset as the same behavior? So flow c=
an
be common and people can be easier to understand the driver.

Any limitation of USB subsystem in TX path?

>=20
> So for the former case, if completion from the firmware doesn't happen, T=
X
> wait objects are wastefully piled up in the list and not released.
> Forcefully clear TX wait list on HCI reset then.
>=20
> It's okay since wiphy lock is held during HCI reset.  For the RPP case,
> all pending completions were done just before in ->reset callback and no
> new ones can appear.  For the C2H message case, RCU access to the list
> helps.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
>  drivers/net/wireless/realtek/rtw89/core.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index e76f04736502..3a0388d3acbf 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1140,7 +1140,7 @@ static void rtw89_tx_wait_work(struct wiphy *wiphy,=
 struct wiphy_work *work)
>         struct rtw89_dev *rtwdev =3D container_of(work, struct rtw89_dev,
>                                                 tx_wait_work.work);
>=20
> -       rtw89_tx_wait_list_clear(rtwdev);
> +       rtw89_tx_wait_list_clear(rtwdev, false);
>  }
>=20
>  void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index e7948bd0bdf6..0ad871472e79 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -6282,14 +6282,14 @@ static inline void rtw89_tx_wait_release(struct r=
tw89_tx_wait_info *wait)
>         kfree_rcu(wait, rcu_head);
>  }
>=20
> -static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
> +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev, bo=
ol force)
>  {
>         struct rtw89_tx_wait_info *wait, *tmp;
>=20
>         lockdep_assert_wiphy(rtwdev->hw->wiphy);
>=20
>         list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> -               if (!completion_done(&wait->completion))
> +               if (!force && !completion_done(&wait->completion))
>                         continue;
>                 list_del_rcu(&wait->list);
>                 rtw89_tx_wait_release(wait);
> @@ -6305,7 +6305,7 @@ static inline int rtw89_hci_tx_write(struct rtw89_d=
ev *rtwdev,
>  static inline void rtw89_hci_reset(struct rtw89_dev *rtwdev)
>  {
>         rtwdev->hci.ops->reset(rtwdev);
> -       rtw89_tx_wait_list_clear(rtwdev);
> +       rtw89_tx_wait_list_clear(rtwdev, true);
>         skb_queue_purge(&rtwdev->tx_rpt_queue);
>  }
>=20
> --
> 2.51.0
>=20


