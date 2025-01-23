Return-Path: <linux-wireless+bounces-17844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097DAA19BB7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C836A7A2C12
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFD4A23;
	Thu, 23 Jan 2025 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="apFRwOML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A330849C;
	Thu, 23 Jan 2025 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591689; cv=none; b=kSpGFSwpRfukhydWaNtcEoEnRsjYwHl1ZNjsKf4uGAenYgCKK/jSCxXTP/g2TPJrABnlYmyxoIQO5RGXTpR5XgtqGxFBh3qir2mYjUghJzoqAh71waneEDNdpmYxQQ+ZZhvS/hsQdfNq0N96Kd2/ka5if6PYjjzvaf/Nly3/78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591689; c=relaxed/simple;
	bh=QkkJAq3kNikiW+FB1ldrSKWAugEMddDiuPF7sHx2blw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COMh8QZxnAoSXqPZl0j18DPpgkXL3loVUkSBHRkUSnBIgqSyOqUYTVURCpvNho2c6XxGIcPskctTzXLSSTRwgRsBYjpf8/uZcoGbQSdHZsSWGxrBmnmf8yk79AWXUttcLDW1isPwMAgQ+c9uDIQhqdGjvZLBgRpzG04A/7HVofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=apFRwOML; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50N0L8mY43829221, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737591668; bh=QkkJAq3kNikiW+FB1ldrSKWAugEMddDiuPF7sHx2blw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=apFRwOMLgdutoDSG4Uiy1Wq4oNX1kySU+eet/7UEgaIugVhlTa91OS9uq/KiS/Wpt
	 iungejW5kNLYOOpUfaqUwMCCshggeXmov2nix1rJMk9HNmTbDngP4Id/8Wqn/UOtQg
	 +kpgC2th8aYt/I+guoJ8h1uJEhq5/P9wVnyaCEoyAWZpCrbFfCJ/jzBsUZQhfHsR99
	 Y3xKQqPJ5Osr+BxSQm1YzBjrVTiqZO3cQcgLRUVXxOg0Iol1ETOBgMFGv0kbqisR+n
	 GssbK7U2/UqLhTyMexaa+AF1Z7aJcwkq87Lt86oXroR2rNIBeIY1BkwAe4kMUjKsCV
	 w9f5GLYiMezEw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50N0L8mY43829221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:21:08 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 Jan 2025 08:21:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 Jan 2025 08:21:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 23 Jan 2025 08:21:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Soeren Moch <smoch@web.de>, Kalle Valo <kvalo@kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: retry firmware download on error
Thread-Topic: [PATCH] wifi: rtl8xxxu: retry firmware download on error
Thread-Index: AQHbbOLYBY6qgVShikadjNokwHFEw7MjfZHg
Date: Thu, 23 Jan 2025 00:21:08 +0000
Message-ID: <e08051130a124fcfab8d42e6893c581a@realtek.com>
References: <20250122153156.373470-1-smoch@web.de>
In-Reply-To: <20250122153156.373470-1-smoch@web.de>
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

Soeren Moch <smoch@web.de> wrote:
> Occasionally there is an EPROTO error during firmware download.
> This error is converted to EAGAIN in the download function.
> But nobody tries again and so device probe fails.
>=20
> Implement download retry to fix this.
>=20
> Signed-off-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> This error was observed (and fix tested) on a tbs2910 board [1]
> with an embedded RTL8188EU (0bda:8179) device behind a USB hub.
>=20
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts

These can be in formal commit message.=20

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 7891c988dd5f..cd7d904eae62 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -4064,8 +4064,14 @@ static int rtl8xxxu_init_device(struct ieee80211_h=
w *hw)
>          */
>         rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
>=20
> -       ret =3D rtl8xxxu_download_firmware(priv);
> -       dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
> +       for (int retry =3D 5; retry ; retry--) {
> +               ret =3D rtl8xxxu_download_firmware(priv);
> +               dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret)=
;
> +               if (ret !=3D -EAGAIN)
> +                       break;
> +               if (retry)
> +                       dev_info(dev, "retry firmware download\n");

It looks like 'if (retry)' is always true and unnecessary. Also, this messa=
ge
isn't so important to user, so dev_dbg() is more suitable, but already prin=
ting
"%s: download_firmware %i\n" for every retry is enough? Or move it out of l=
oop?

> +       }
>         if (ret)
>                 goto exit;
>         ret =3D rtl8xxxu_start_firmware(priv);
> --
> 2.43.0
>=20


