Return-Path: <linux-wireless+bounces-8286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6F8D43FD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 05:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074521F24109
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD681CAB7;
	Thu, 30 May 2024 03:13:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4DF9F7
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038828; cv=none; b=Lk0we2yiSgnN4Hb5jZ8dC4DEFD/E5mcH5yH6GofG/nUILDV7nOfI2nEbiD2hSB2WAnlQ/3mB1WBf/+kp/Jpc4GzxUSJx67E/U/u9rmZ/iswvTtlbWaMbr2UjJd0tYBTy42KA/iT0GuybsPjqAtJB1qWvmgFY7TcR6y2V07nALgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038828; c=relaxed/simple;
	bh=IkWUQMtYKF4POaGOQlUv2HYTyxhTd9z8FbDsnbA7y2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gczg1ERRLXJToGj8YjGDYV5qomLkiQbO27J95WThkMYtOL4w7d19L+zqdmGxWs/EJej5sNPRzvMC8b8PkZxRZ+6NMyXVYYnqWeq0FqlUYMMJjo7K/dArP8+DgWNrHXGRakPlNOCbCnX8E5sVOgryAwFZSPPpJMs4Mc7HdympmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44U3DUJA0239268, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44U3DUJA0239268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 11:13:30 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:13:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 May 2024 11:13:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 30 May 2024 11:13:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
Thread-Topic: [PATCH] wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
Thread-Index: AQHasexsCsyMQCs/rkaQ2/umN9yNTbGufuHogABpXjA=
Date: Thu, 30 May 2024 03:13:30 +0000
Message-ID: <9aaaee6266474945b6278c56f3ee3fec@realtek.com>
References: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com>
 <87o78omrk4.fsf@kernel.org>
In-Reply-To: <87o78omrk4.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>=20
> > Since commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx
> > drivers") ieee80211_hw_config() is no longer called with changed =3D ~0=
.
> > rtlwifi relied on ~0 in order to ignore the default retry limits of
> > 4/7, preferring 48/48 in station mode and 7/7 in AP/IBSS.
> >
> > RTL8192DU has a lot of packet loss with the default limits from
> > mac80211. Fix it by ignoring IEEE80211_CONF_CHANGE_RETRY_LIMITS
> > completely, because it's the simplest solution.
> >
> > Link: https://lore.kernel.org/linux-wireless/cedd13d7691f4692b2a2fa5a24=
d44a22@realtek.com/
> > Cc: stable@vger.kernel.org # 6.9.x
> > Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

>=20
> Ping, should this go to v6.10? If you agree, ack and assign it to me on
> patchwork. I'll then take it to wireless tree.
>=20
> But feel free to take it to rtw-next as well, your call.
>=20

Please take it to v6.10, and assign it to you. Thanks.



