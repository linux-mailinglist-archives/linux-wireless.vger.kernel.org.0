Return-Path: <linux-wireless+bounces-26662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16465B37616
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277A21B6845E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85409145A1F;
	Wed, 27 Aug 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E/N5qCSw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB6219EB
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254360; cv=none; b=MUqJkJcO5WbQlfUQxvdsuhqTWJanbhh9GDTfh/lYYRCBsSQdexDWNWmxZkLJYA2fvMJccFepG73f3rBsUH2hNRRPSZUM2rro1ratFGKhtLXMmDSfm02JORuc1LlRFtglzsZfxdxMrxPXLPlAUjyLC+48ovpDxGsjn2Edu745e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254360; c=relaxed/simple;
	bh=SMoAw0ac/dn2eVF7kkxUqB6DveHrGsMC4Z62LWwJ7gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJ4WB1L8Ia/5v+cBRnmBiJ1wzPwvjMrcTJ/IXtQsG7/PP0BPW25NZn8Ev7iU2XGqU5C6F+ebL4ByzIRAmCweaYAmV8OnDFFhVkU0YP0/Lgwkyd3mfHHiK+E2aIvImFdFqghWiFF5O6eB648QqcVIh7b+TTJKEKZwjT1St4bjKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E/N5qCSw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57R0PQN402549311, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756254326; bh=zqxYZ4rsNm4rUpJCOPD1IoE0uI3Ar2MZ1mx/R16KzlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E/N5qCSw8TKb3Y0FWUkyiaZJrDpRv/9wC2HZNTuVH0CxBgBKY/dFKvDkiNaS6vpV1
	 31GDT4/ZdYXYT62ijgwldKw9WExWp6aGHPAU+LKwRggUj/NPUtxSOWwnSCcyhCl+1w
	 l8K8Q3FfDksxQ9ZmVX9Rqy+wNBvgRpoPfuxc5BhuAyhevL8IavNfwB4t0EknN4iIcA
	 Dxi3BIwJGJEkiFZsTjoN1hu1DC61bm7b/UXiiIFEOYW3JOE0unyCpmt7VN2zce+vys
	 6eUIfaEkk7BA43tBAlCBldlUGBX3YHyFz4CEP/OrAb2Q6bHSOIzSx2dO1DfGGPIeku
	 vtbHpWfXvDD5w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57R0PQN402549311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 08:25:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 08:25:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 08:25:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 27 Aug 2025 08:25:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Index: AQHcFmfebQOziZeAkUu/Xp6RP/ccI7R1pKxA
Date: Wed, 27 Aug 2025 00:25:24 +0000
Message-ID: <b51c0383511d4bcca88a12029ac441e2@realtek.com>
References: <20250826090015.1552939-1-martin.kaistra@linutronix.de>
In-Reply-To: <20250826090015.1552939-1-martin.kaistra@linutronix.de>
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

Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> The efuse contains the mac address and calibration data. During
> manufacturing and testing it can be necessary to read and check this
> data.
>=20
> Add a debugfs interface to make it available to userspace.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 831b5025c6349..b45010c93ad72 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -1901,6 +1901,29 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_pr=
iv *priv)
>                        priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
>  }
>=20
> +/* debugfs: efuse */

Not sure if this comment is worth? If you want to emphasize 'debugfs', just
add it to function name.

> +static ssize_t read_file_efuse(struct file *file, char __user *user_buf,
> +                              size_t count, loff_t *ppos)
> +{
> +       struct rtl8xxxu_priv *priv =3D file_inode(file)->i_private;
> +
> +       return simple_read_from_buffer(user_buf, count, ppos,
> +                                      priv->efuse_wifi.raw, EFUSE_MAP_LE=
N);
> +}
> +
> +static const struct file_operations fops_efuse =3D {

Use debugfs_short_fops to save spaces.=20

> +       .read =3D read_file_efuse,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static void rtl8xxxu_debugfs_init(struct rtl8xxxu_priv *priv)
> +{
> +       struct dentry *phydir;
> +
> +       phydir =3D debugfs_create_dir("rtl8xxxu", priv->hw->wiphy->debugf=
sdir);
> +       debugfs_create_file("efuse", 0400, phydir, priv, &fops_efuse);
> +}
> +
>  void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
>  {
>         u8 val8;
> @@ -7974,6 +7997,7 @@ static int rtl8xxxu_probe(struct usb_interface *int=
erface,
>         }
>=20
>         rtl8xxxu_init_led(priv);
> +       rtl8xxxu_debugfs_init(priv);
>=20
>         return 0;
>=20
> --
> 2.39.5


