Return-Path: <linux-wireless+bounces-14286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1C9A9706
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9141F22EE2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276EA136E01;
	Tue, 22 Oct 2024 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="R5wBhoMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9D41760;
	Tue, 22 Oct 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567636; cv=none; b=sE8z3JAHHoXM7hpc6+bGNAu+A2HQiWg/A3GPMzxrloiVXS+x+m7S19K7YWI28QETgInq7/7HJpTzWqOmZbmR4cIUfvQ1B4LRVgWknXaZ7rPTNm8P2IGO6//S4lLGjjFnq29WjuCnmolYn6rQUX1dKXDyP5PnaLOWRbkA73WT6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567636; c=relaxed/simple;
	bh=hrY7tzDzi1hxTikHoxdyBsPWJkSbxVPjxhhl6c+35V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GJNtE0YcNUMsMJoKAxaxilqz/upmIAg+seiHQRSM83SvpURc3E6FIdlPA7hJj04aMBEDdzyDOK1dB/q3Rj7xOfmIKDH5z4nQya1A4hpyu3fTSfRVwaCi/YMX3PpruddPeIVpqNuYdMDJ/RMw6soQCaBun/jQGntZ/pQ3HnuQQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=R5wBhoMl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M3R3rE43442082, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729567623; bh=hrY7tzDzi1hxTikHoxdyBsPWJkSbxVPjxhhl6c+35V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=R5wBhoMlUptSa2yRFEUDuLIKtf+11zzhmtn9WP5rmRLpH8f04K1mzP2q4fxlxnYps
	 i3nBV/S/njdQr6vVDLmA1JU3S7jttvWluD/u/BaGVJbtpFnZ3zv39zeqap7pUIv5d8
	 cPK2TExtliU7Fwyarqy1WZ3es3beijX9oblc/EZfGOGoAmTHmG55wh/68NobdOsQ3J
	 jiXfE9a5p7ct6Umox1os3L/ljXoB2Rdo/9b8AK1aNo4cELD1DPOnqelZFgb2zUCUXk
	 dfHSRSL+TMm/HS91C/Epc6+WkuHok5VOAXVG7MKE68hmFb/sdnvrYU0lQfA/fOPUPG
	 ono0z2riL+N5Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M3R3rE43442082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 11:27:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 11:27:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Oct 2024 11:27:03 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Tue, 22 Oct 2024 11:27:03 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()
Thread-Topic: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Thread-Index: AQHbI5mv2pwOn3Ho/kejuy2RYL9sTrKSGuGQ
Date: Tue, 22 Oct 2024 03:27:03 +0000
Message-ID: <6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
In-Reply-To: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> [...]
>
> @@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct i=
eee80211_hw
> *hw,
>=20
>         rtwvif_link =3D rtwvif->links[link_conf->link_id];
>         if (unlikely(!rtwvif_link)) {
> +               mutex_unlock(&rtwdev->mutex);
>                 rtw89_err(rtwdev,
>                           "%s: rtwvif link (link_id %u) is not active\n",
>                           __func__, link_conf->link_id);
>

Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>

Thanks

