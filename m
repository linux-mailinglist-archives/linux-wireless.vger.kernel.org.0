Return-Path: <linux-wireless+bounces-29348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F4AC879DD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 01:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C77A34D2B1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 00:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF126F2A7;
	Wed, 26 Nov 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XnNvaP+b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D126E165;
	Wed, 26 Nov 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117851; cv=none; b=YHyBDtE/u7gJtXrksMr8+QiMYMyvGgi51MyhJtxsON+lYUBzRsC33lyombEdtSyJRhKeFrvaqMBVpqcXfMpLTSOFrShXrXraVGtRYdAIN+coY6JakK/uR1cXgSOEmxa4IDyHsEH3uRDNeP+SMJaggvSn0f5jNYR9zzn/6l/5RRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117851; c=relaxed/simple;
	bh=SbQW/2SrX/53D57hVfQUFwUUJB0GsGk4SqoIgv/OXVc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxgtvwX/qWCTBkipc6vDATUZKRwEEprOzJn3ySPA2aXKouooC7s7RQYpUohf7Y+NwiSSi4guaISRQz2bodOnoLLx9gL8cxGusc7BTWBBjn0jZeEmx2MsaMpBHoDd3CnMywdN60iDMT0GoiDZuZomneCMbrQ+z8Z3XHh/l7goM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XnNvaP+b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ0hxEdB4026226, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764117839; bh=B7F6heSPveLUys5MlItH4MNaIZo5dP7CEHf0cfKkjUo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XnNvaP+bodJI4oEpxxLNMEHWuKZg00wTkdOO1VXI6kIw7CoXUIXYCWQ2+Zot1RUcE
	 EFOnAht2cL1Y4zLvFj8yYNlC9XVJm9g5OjWOFdaLH1xY0qVp7TZbGIgmSsNYaeDPtb
	 7at99Cw4qJb0Jn17/RVng2ztCZoTUbHdjF5K7vievIy3Nz4WotjUz2nDAJJRHO/hK6
	 +vtBovs6ojUtXxEzccLnSWpDxbCP8bYJwxE+oZUpqQmzKaBVl5px+zPCAsJLgMeyts
	 Pd2h+ougIBCVyuXixjFof8CRBWYuEH6S2nQtZdut0BkldkfhdzHbFISGEUzH7x1kEz
	 ov0keCkBQwF2g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ0hxEdB4026226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 08:43:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 08:44:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 08:44:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8922a: set random mac if efuse contains
 zeroes
Thread-Topic: [PATCH] wifi: rtw89: 8922a: set random mac if efuse contains
 zeroes
Thread-Index: AQHcXgOamn0alQr6b0K7vDjq69c4zbUEHQFg
Date: Wed, 26 Nov 2025 00:43:59 +0000
Message-ID: <25d22682d36444cf8093076bf551a50e@realtek.com>
References: <20251125120350.228288-1-jtornosm@redhat.com>
In-Reply-To: <20251125120350.228288-1-jtornosm@redhat.com>
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

Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:
> I have some rtl8952ae devices with no permanent mac stored in efuse.

I think rtl8952ae is NOT a typo, but it is surprising me that this driver c=
an
bring it up. Does it really work well? And where did you get the hardware?

>=20
> It could be properly saved and/or configured from user tools like
> NetworkManager, but it would be desirable to be able to initialize it
> somehow to get the device working by default.
>=20
> So, in the same way as with other devices, if the mac address read from
> efuse contains zeros, a random mac address is assigned to at least allow
> operation, and the user is warned about this in case any action needs to
> be considered.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
> b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
> index 6aa19ad259ac..050307fa16d2 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
> @@ -636,16 +636,30 @@ static int rtw8922a_read_efuse_rf(struct rtw89_dev =
*rtwdev, u8 *log_map)
>  static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
>                                enum rtw89_efuse_block block)
>  {
> +       struct rtw89_efuse *efuse =3D &rtwdev->efuse;
> +       int ret;
> +
>         switch (block) {
>         case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
> -               return rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
> +               ret =3D rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
> +               break;
>         case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
> -               return rtw8922a_read_efuse_usb(rtwdev, log_map);
> +               ret =3D rtw8922a_read_efuse_usb(rtwdev, log_map);
> +               break;
>         case RTW89_EFUSE_BLOCK_RF:
> -               return rtw8922a_read_efuse_rf(rtwdev, log_map);
> +               ret =3D rtw8922a_read_efuse_rf(rtwdev, log_map);
> +               break;
>         default:
> -               return 0;
> +               ret =3D 0;
> +               break;
> +       }
> +
> +       if (!ret && is_zero_ether_addr(efuse->addr)) {
> +               rtw89_warn(rtwdev,"efuse mac address is zero, using rando=
m mac");

I think rtw89_info() is more suitable.

Need a '\n' at end of the message, and you missed a space after comma.=20

> +               eth_random_addr(efuse->addr);
>         }
> +
> +       return ret;
>  }
>=20
>  #define THM_TRIM_POSITIVE_MASK BIT(6)
> --
> 2.51.1


