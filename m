Return-Path: <linux-wireless+bounces-24165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85AADBE81
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 03:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B83B5C46
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9C74BE1;
	Tue, 17 Jun 2025 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jfqHDNsV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526EBE4A;
	Tue, 17 Jun 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750123182; cv=none; b=U7TrMeoe0/iMYSXX1rW9MAtVfsDc/zpNQcn2tSr7TsyYtCJ83DlaOupVk84iPrzjSw4LpEE6Vb2YnrD7RYilUYWMDGhOzUT+zsA16z1Q43lNw6FtXoukIRUbCkTyTNmclS9/sZIgZDHkcspB0S3jTSWte629TVY4Vu7wHbE69Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750123182; c=relaxed/simple;
	bh=DA6NbZ1em8IUBv8N+cHNb3cLSGN5iij1bpuMZeqKCm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYSku04fEGES/8X368I4Kiat0gu73m4taOACUwbmZSTzCDmVdDPvQdFmYqOwr+8GgIF/F0lVYXvPQYHOdt+2ZAQZpXvM29UUPckViHn3boYWFHegJIVdjBveBLodA3Q8IiJ0ETQ7HnJF6NtUuFo1WA00mngwNimhsY8NXSc/PI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jfqHDNsV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55H1ITh941355397, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750123109; bh=o/1UOAP2Hwox+w4gqzPebqcdOXSO0WpJAYav/KaZ4XI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jfqHDNsVulIoNPrQa0MIBSpLP2x6YzDKX8dBRX5DIW0bbintUfT0IhvMO2ONMPZIP
	 sPQilm7DSzU2nt8xg34XuNUamTeB/4RnesmWB3kakVGtnl2n9BwjMSqRhFdVD356N/
	 2tLpT/4QaVf4gh5PFDdDMSr92fB1DkXOdxDK95w8upPwyLffQQzz9yXVpjaMXVJdiO
	 kQ5wsPIKBAyWanN1B1MA8/0++w/16w4z8iZDSMYM1iheVH6TsGYDWXQlhYa1nPglIj
	 5OK5dUbjw/qrpwnrFPBlExR0hBFHFwZIGcSylZ7OwuUOqDCgmCKAU1vVxi3sXKUC2E
	 2dZASUm+yj0TQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55H1ITh941355397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 09:18:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 09:18:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 17 Jun 2025 09:18:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 17 Jun 2025 09:18:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Hin-Tak Leung <hintak.leung@gmail.com>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        "John W. Linville"
	<linville@tuxdriver.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH 2/2] rtl818x: Kill URBs before clearing tx status queue
Thread-Topic: [PATCH 2/2] rtl818x: Kill URBs before clearing tx status queue
Thread-Index: AQHb3qlL7VN9vAfXfk29Z5DedKzs4LQGjOug
Date: Tue, 17 Jun 2025 01:18:34 +0000
Message-ID: <1db5e917fd08403cbddb99a5495fe78e@realtek.com>
References: <20250616101050.6911-1-d.dulov@aladdin.ru>
 <20250616101050.6911-3-d.dulov@aladdin.ru>
In-Reply-To: <20250616101050.6911-3-d.dulov@aladdin.ru>
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

Daniil Dulov <d.dulov@aladdin.ru> wrote:
> In rtl8187_stop() move the call of usb_kill_anchored_urbs() before cleari=
ng
> b_tx_status.queue. This change prevents callbacks from using already free=
d
> skb due to anchor was not killed before freeing such skb.

Oh. This is my question in patch 1/2. Seemingly, with this patch, it can
safely flush rtl8187_tx_cb() and stop, no? I mean just this one is enough,
no need patch 1/2.=20

>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Same question as patch 1/2. Do you have a real hardware and test?

>=20
> Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> index 8fe6fdc32e56..12e2042ee2d0 100644
> --- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> +++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> @@ -1050,10 +1050,10 @@ static void rtl8187_stop(struct ieee80211_hw *dev=
, bool suspend)
>         rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4=
_VCOOFF);
>         rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD=
_NORMAL);
>=20
> +       usb_kill_anchored_urbs(&priv->anchored);

nit: an empty line.=20

>         while ((skb =3D skb_dequeue(&priv->b_tx_status.queue)))
>                 dev_kfree_skb_any(skb);
>=20
> -       usb_kill_anchored_urbs(&priv->anchored);
>         mutex_unlock(&priv->conf_mutex);
>=20
>         if (!priv->is_rtl8187b)
> --
> 2.34.1
>=20


