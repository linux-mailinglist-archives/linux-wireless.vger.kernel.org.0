Return-Path: <linux-wireless+bounces-16004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667D9E8988
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E49D164AA2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917631547E0;
	Mon,  9 Dec 2024 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BE+hEJa3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7E74068;
	Mon,  9 Dec 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715040; cv=none; b=qMzpHoIN29lnJgWGSsxMvlXPkhVe560W8A1uvUNxjVKpq9DKAey5s6cw+56kDtZKk5u+w1A605bv92I8TWM5V2hmzh9+FX0A4wgmdGZ/Df81yFzIzuhQsyB0E0e/S+Jz7DxViZCXv6m5N2HOMk8KqiemHJw58+JfqvykuaLwjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715040; c=relaxed/simple;
	bh=D8GYAiVvhXVtSPM8ldPiYLbTFuEgGCe/f/0Iw5oB7yg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pnf6JTS7L+mUovaZzZ2j3PdqO6xP3nE4hps90H1sFBgdL/f9dkTul2MPgGd0YXa1lkrOwaaARiyaNz2FfzYOLWtI2eBpBeh1lNplaMiREuuXyg7cilTUtbxjlQVowStgcky3pGcOHrknrMk5w2BtYc1hYDybA7xgtiSmUY4Z9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BE+hEJa3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B93UO4B04143790, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733715024; bh=D8GYAiVvhXVtSPM8ldPiYLbTFuEgGCe/f/0Iw5oB7yg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BE+hEJa3ucJ+XJptphhqMwRttpI8b4hCnI0f1WM+Z2fwNF6bHMfK3N1iQuX9G3COX
	 tdqzWwk0dBa/Q2JATiopsPE5g1OdVNXg3akBCaIOhs9GdqEIO15QbOIw5IenuTw7g5
	 RXh7wVxZdW7S6anfR0uMDkZJ389m14hsPmfaTwLlpY+LE6RnAJVSFtmol7KXJkxaKg
	 hqx1RZK/+2UUYFfcgDq7XvtdPreSGj+jgLuvVRVynL4mPi6NbMn79h+tunmb4LFeCS
	 IL2KzfJq0xhgwVxxTa7zX/xXVK6wfySpPrjSaxQWksddrU+B3u4Pd/dwD6k4OZauMm
	 vsiqS7BC1WEzQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B93UO4B04143790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:30:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 11:30:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 9 Dec 2024 11:30:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 9 Dec 2024 11:30:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: liujing <liujing@cmss.chinamobile.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "suhui@nfschina.com" <suhui@nfschina.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8188ee: fix spelling error in _rtl88e_phy_set_rfpath_switch()
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: fix spelling error in
 _rtl88e_phy_set_rfpath_switch()
Thread-Index: AQHbSeoMjV6xTj+MWkaJXUOMBiknv7LdQPsA
Date: Mon, 9 Dec 2024 03:30:24 +0000
Message-ID: <c6d8a67ad37f4d0481e3300419b0fdd3@realtek.com>
References: <20241209032548.3100-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241209032548.3100-1-liujing@cmss.chinamobile.com>
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

liujing <liujing@cmss.chinamobile.com> wrote:
>=20
> Fix spelling error in _rtl88e_phy_set_rfpath_switch() function.
>=20
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Please use your real name, not account.=20

Did you send duplicate?=20

>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> index 0fab3a0c7d49..754ca8549c76 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> @@ -1891,7 +1891,7 @@ static void _rtl88e_phy_set_rfpath_switch(struct ie=
ee80211_hw *hw,
>                 rtl_set_bbreg(hw, 0x914, MASKLWORD, 0x0201);
>=20
>                 /* We use the RF definition of MAIN and AUX,
> -                * left antenna and right antenna repectively.
> +                * left antenna and right antenna respectively.
>                  * Default output at AUX.
>                  */
>                 if (bmain) {
> --
> 2.27.0
>=20
>=20


