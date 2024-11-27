Return-Path: <linux-wireless+bounces-15742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF89DA1B9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 06:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1F283513
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 05:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A40364A9;
	Wed, 27 Nov 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QwWjgfoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76728E8
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685745; cv=none; b=PM5DyfzVtCAQCvpt03hxfGE+RcGBGLRx5XeLc1xPvRJk0FD2Hxw0sLJ/BnHRrrpbs59s6qoKSBbl90m4uZjLpb4odtL9Nr/X9oRFl/ItgTDH1Wl0cmWrGrYAKT9NhPOf9Wt4HJAxwID0OaFZ0ui4/9y2scYVTbbd5XI4lUf91RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685745; c=relaxed/simple;
	bh=k3Kz4Lw6nvI0jS9Ohrg6pT+iwc1ekUf1VKg58CUSbf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WldVb9pJFD+Nmp/g6JYNnfigHVaceS3zpxwSPEpT2py9B0jfRsrNdydjeiPpMqa/Awv/Nrr7DiVvGHhYTp2mtzq7XCPAt+dq44jRNje7itN8Bnxx/MXShtyncUjelV+iwHeNGUCWMS9JqYQI8TeekIYR0glHgeVMQnjJ73ZJGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QwWjgfoT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR5ZNxH42231406, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732685723; bh=k3Kz4Lw6nvI0jS9Ohrg6pT+iwc1ekUf1VKg58CUSbf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QwWjgfoTBHiNajzsUwXDEh2ym1hXsxLKHSk20zvgqfJtg7gvxL5oI92XKO/3ckcyP
	 zWaD25EoA0IZzPDbyACYVOak0yDPM92LLttdfT0n6Ok5w4fw2Hrbp/62C+2Jfb2Xto
	 74yAaf3P8jT6mqB91cskaLnxMN3e6xVJpriYpRuM7FOuaehcW5TvFP2tuxnfFtnWph
	 OG92XlBjj4VG8JRGmi3jOUI+BAvRdkroQA96k/oBqjBI1uZeLC2gwbuEgLj75UFFez
	 qmsBd5ZcxRwln7GZjBzRsmiGT6a7jotaSCbb5M3qXildEPpL/1JLdwAMv9N2HIFfxI
	 DXDiihXwQhc7g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR5ZNxH42231406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 13:35:23 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 13:35:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 13:35:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 13:35:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Thread-Topic: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Thread-Index: AQHbPQPtuhSVOKRI70Kht440h06pSrLKoYkg
Date: Wed, 27 Nov 2024 05:35:23 +0000
Message-ID: <3b967b62f2954e799a856140aa4b0796@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-3-cascardo@igalia.com>
In-Reply-To: <20241122172718.465539-3-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>=20
> rtl_wq is allocated at rtl_init_core, so it makes more sense to destroy i=
t
> at rtl_deinit_core. In the case of USB, where _rtl_usb_init does not
> require anything to be undone, that is fine. But for PCI, rtl_pci_init,
> which is called after rtl_init_core, needs to deallocate data, but only i=
f
> it has been called.
>=20
> That means that destroying the workqueue needs to be done whether
> rtl_pci_init has been called or not. And since rtl_pci_deinit was doing i=
t,
> it has to be moved out of there.
>=20
> It makes more sense to move it to rtl_deinit_core and have it done in bot=
h
> cases, USB and PCI.
>=20
> Since this is a requirement for a followup memory leak fix, mark this as
> fixing such memory leak.
>=20
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")

Like patch 1/3, this is a cleanup patch, so I don't think a Fixes is needed=
.=20

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

"rtlwifi" is a typo in subject.

> ---
>  drivers/net/wireless/realtek/rtlwifi/base.c | 5 +++++
>  drivers/net/wireless/realtek/rtlwifi/pci.c  | 2 --
>  drivers/net/wireless/realtek/rtlwifi/usb.c  | 5 -----
>  3 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wi=
reless/realtek/rtlwifi/base.c
> index fd28c7a722d8..062d5a0a4c11 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/base.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> @@ -575,9 +575,14 @@ static void rtl_free_entries_from_ack_queue(struct i=
eee80211_hw *hw,
>=20
>  void rtl_deinit_core(struct ieee80211_hw *hw)
>  {
> +       struct rtl_priv *rtlpriv =3D rtl_priv(hw);

A blank line between declarations and statements.=20

>         rtl_c2hcmd_launcher(hw, 0);
>         rtl_free_entries_from_scan_list(hw);
>         rtl_free_entries_from_ack_queue(hw, false);
> +       if (rtlpriv->works.rtl_wq) {
> +               destroy_workqueue(rtlpriv->works.rtl_wq);
> +               rtlpriv->works.rtl_wq =3D NULL;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(rtl_deinit_core);
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index 4388066eb9e2..e60ac910e750 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -1656,8 +1656,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
>         synchronize_irq(rtlpci->pdev->irq);
>         tasklet_kill(&rtlpriv->works.irq_tasklet);
>         cancel_work_sync(&rtlpriv->works.lps_change_work);
> -
> -       destroy_workqueue(rtlpriv->works.rtl_wq);
>  }
>=20
>  static int rtl_pci_init(struct ieee80211_hw *hw, struct pci_dev *pdev)
> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wir=
eless/realtek/rtlwifi/usb.c
> index 0368ecea2e81..f5718e570011 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -629,11 +629,6 @@ static void _rtl_usb_cleanup_rx(struct ieee80211_hw =
*hw)
>         tasklet_kill(&rtlusb->rx_work_tasklet);
>         cancel_work_sync(&rtlpriv->works.lps_change_work);
>=20
> -       if (rtlpriv->works.rtl_wq) {
> -               destroy_workqueue(rtlpriv->works.rtl_wq);
> -               rtlpriv->works.rtl_wq =3D NULL;
> -       }
> -
>         skb_queue_purge(&rtlusb->rx_queue);
>=20
>         while ((urb =3D usb_get_from_anchor(&rtlusb->rx_cleanup_urbs))) {
> --
> 2.34.1


