Return-Path: <linux-wireless+bounces-18804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89232A31E13
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B026188AF56
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE691F5428;
	Wed, 12 Feb 2025 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m6O8zjC/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B4271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338947; cv=none; b=IhPi+daDf3XsaL8DsV1jHaZ7bTB3zP/qE9KncY6KRzouoT3qQUJwqkVHSvGFHvTR8EB2HblSMMa1yQO6sXh7f/MLrnIb9wfVB3oAMk5xbVoVXB2Je+mNhZwotpXdinC7y2A/VWtjKAmjYblwZlPkprvz9pCrpoofZFnSWYS9cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338947; c=relaxed/simple;
	bh=nRA4QGZFqkensPv05YLymmCQZcZ91Lxdm8JZENdCCrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEE72foSYM6wqwxPdDo37gwxKK6JSsJyR3y4OQ0IuqSuvbuZC2+ptqHAYzE9MCsQazVeuHGl8Szm8ksFIMTxcoI66nK0Dr4D271FD9aHNa++VtZlMr5+uy+Hm80qL4vpMRwd1RHGasfypwjmaa2F918/mU47FuVgIjgu8SduWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m6O8zjC/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51C5gGfjD1646226, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739338937; bh=nRA4QGZFqkensPv05YLymmCQZcZ91Lxdm8JZENdCCrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m6O8zjC/cqTqDp7Dt79n2q5PpY6+/h6IMPLy7ZHAE053A+LqQvdO/7IKoq6F8P6rW
	 vbZAXfhDF6B/etmwguXGLUE9Qy+Jc+31MN/kx6JCWuaWYSj3mrh6n58FrYvJywsXEq
	 mhB9ofyU5EVzo/CbNnLQxTbrkC+bXml8MJ/RyceYOmuwmDcPNThWStQdWxvNmkW3JO
	 B/UTHEHOcKBRgViqyojdzOxWqkl3ZnlAYNzFcoZATSC4EdfZn+GdWbpkuQ1dWZdTI9
	 yOtcMNYc2gdF/z1Ah6EIio+f80Fokh3Lc22mTOwTGlbkzVgO7myJI+rQ/9+/CDMsuf
	 pvD6hsKbB5vHg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51C5gGfjD1646226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 13:42:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Feb 2025 13:42:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Feb 2025 13:42:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Wed, 12 Feb 2025 13:42:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Topic: [PATCH 2/2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Index: AQHbfFlRfsbqVknxlEKt5p1SvfD+brNDJ06g
Date: Wed, 12 Feb 2025 05:42:15 +0000
Message-ID: <0b028bab48ab4d64ac82b1228e1ad21c@realtek.com>
References: <20250211073915.648418-1-dmantipov@yandex.ru>
 <20250211073915.648418-2-dmantipov@yandex.ru>
In-Reply-To: <20250211073915.648418-2-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Dmitry Antipov <dmantipov@yandex.ru> wrote:
> Assuming that 'tssi_alimk_time' of 'struct rtw89_tssi_info' is
> in milliseconds,

Checking vendor driver, It intends microseconds.=20

	RF_DBG(rf, DBG_RF_TX_PWR_TRACK, "[TSSI PA K] %s processing time =3D %d.%dm=
s\n",
		__func__,
		HALRF_ABS(finish_time, start_time) / 1000,
		HALRF_ABS(finish_time, start_time) % 1000);

> adjust rtw8852b{t}-specific '_tssi_alimentk()'
> to not mix the former with nanoseconds. Compile tested only.
>=20
> Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw89/core.h          | 2 +-
>  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 9 ++++-----
>  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 9 ++++-----
>  3 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index ff4894c7fa8a..93e41def81b4 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -5135,7 +5135,7 @@ struct rtw89_tssi_info {
>         u32 alignment_backup_by_ch[RF_PATH_MAX][TSSI_MAX_CH_NUM][TSSI_ALI=
MK_VALUE_NUM];
>         u32 alignment_value[RF_PATH_MAX][TSSI_ALIMK_MAX][TSSI_ALIMK_VALUE=
_NUM];
>         bool alignment_done[RF_PATH_MAX][TSSI_ALIMK_MAX];
> -       u32 tssi_alimk_time;
> +       u64 tssi_alimk_time;

This is the accumulated time of doing alimk, so debug message would be=20

	rtw89_debug(rtwdev, RTW89_DBG_RFK,
		        "[TSSI PA K] %s processing time =3D %d.%d ms (acc =3D %d.%d ms)\n=
",




