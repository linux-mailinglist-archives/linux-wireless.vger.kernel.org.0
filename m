Return-Path: <linux-wireless+bounces-26913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E53B3F1CF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 03:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DAE7A7D08
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1D2820B6;
	Tue,  2 Sep 2025 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qzUjbZxE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1932274B31
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756775568; cv=none; b=Vbm4FpfurOUO6vj0unpV58+M28RlqvsjaR1DAlnold8646HsxhJLtXy/dqMhQVI9mSLteNwtFwCMlI3hqu6gK+I5OOmUK0Jd3C8QDfqRurXKPZgIcW3lY1ERwpDArSSVMii8rn/NQCws8t4b8XVSguicSRyk3repMek0hnmjfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756775568; c=relaxed/simple;
	bh=bFT0tya8i+Os43iUxO86oDzq0bxNCHbsHRFckk3n300=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nspAusEFgUW7A1zTDSuzmuHQrIerfwvLGIYi4/Z4MkmD9tIPwgYZ3OO9lgYKs7b6ypLMYf3679ucdkB7tDkgGaLjdI3JbSUmKrkDgN5R99TPKA2PW7vYaztBPmHxfUP8OuyggoDNMdfXQzt/0gbWoH9MHaDIBEugHVrU4tSBM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qzUjbZxE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5821CCTY02283977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756775533; bh=IKL7whj21GUUN/r0yJOFIsGb72ulk30ElM3+xx+VUDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qzUjbZxEzdsY64NLLBHJPooJ0znvkA2LPiSuSwQ1PDBkNJtFX4qrIMk8oevSuaEQr
	 jg0+o5XhvLmC43n0zeh3DoagtbuSY9AkUY+tZVmmpE3XlJzB8216OeeOOX+P7akWg/
	 ysR5tHK0P0UwXCiAgpV381FaL179aPaUCKH8pXZvsSoPnU/+45KgLQPqQEhMmFFMj+
	 mRV8djMrD+JebSYaNznY9SP9uD1P8YtcvUatYkDXiJrx09Q2hQpVN4XtKWyTPDC74L
	 RTZGnKItxcN7dKIKGTxTpMEO4L3V4fgyVcdUUs2jDKOcaLFy0XYwO4v4aBRr3f2HO/
	 AZwNWqv+UN6bw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5821CCTY02283977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 09:12:13 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 09:12:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 09:12:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 2 Sep 2025 09:12:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Topic: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Index: AQHcGzo8qOIpbQ+8S06Pa/OAUmY/8LR/FiDw
Date: Tue, 2 Sep 2025 01:12:10 +0000
Message-ID: <a2bc752666524249b19dfafb7912f6cc@realtek.com>
References: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
In-Reply-To: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
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
> Changes in v2:
> - remove unnecessary comment
> - use debugfs_short_fops
>=20
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 831b5025c6349..aea706f0251d8 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -1901,6 +1901,27 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_pr=
iv *priv)
>                        priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
>  }
>=20
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
> +static const struct debugfs_short_fops fops_efuse =3D {
> +       .read =3D read_file_efuse,
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

Could you please try if this would encounter build error without
CFG80211_DEBUGFS?

Otherwise, looks good to me.

>  void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
>  {
>         u8 val8;
> @@ -7974,6 +7995,7 @@ static int rtl8xxxu_probe(struct usb_interface *int=
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


