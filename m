Return-Path: <linux-wireless+bounces-22223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3BAA3F0A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 02:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B55188BB0C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAB2571D5;
	Wed, 30 Apr 2025 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CKxUxPFQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A37255F36;
	Wed, 30 Apr 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972217; cv=none; b=iOjRlONIdiI30COZaZJ1M1fh05x2ueWg4tskuvFsPXwmkU7lC5GR/Hm8FFb9AkUoFZny0d3jGO1+SC1DPhkvVkttgdEZuJvejyIoH27IJpoQMFaGcMr4YHn19HgVqf03pecV/wHeF9LhAlC2bznWccuuBOUDiC2FOJibuocelpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972217; c=relaxed/simple;
	bh=EuhYMPtN24wFpetIjEk5bJ0wQu/lkgDl2Mh3Emi0/YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGuA0vR6TaKCTVzafxFOgErXB8oJz7QSdsOgLk9ENgqhTyPE1bfEGrCHYKAqtmPQBxbI0zyRTPIx1lowmcZNXnd1Ak4+uDgZNthXvVWgzZMcmPaHhuaJJuMTvtb91Ee/oxy+uEVKHBIvcIAAamySNA6vl1yXQjtopjKdSdahJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CKxUxPFQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53U0GlGI22014676, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745972207; bh=EuhYMPtN24wFpetIjEk5bJ0wQu/lkgDl2Mh3Emi0/YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CKxUxPFQnv21cRUvFBRLhFHcaAAwsbqSjCpzi7jgbZgtn68eBDSkoaBI1xjHsEixG
	 d7E7QtiEtFuBALR63UglMWSpMTfqaX9LLwloShHU69uZjZEtzC2Qn8S4TGzGyQ/GCE
	 gdDjuIc+vnLRZgJw+kghfatRtkxLDDoj+oWTM6w/5/NpbGG29hAmIHm6XegNwhtsTj
	 E11+7H4QsULFh04lIUOU/AaQAHd5FvZ7gcAT3RxfbuZG6+knaE1dC8o6kep2l0jEpd
	 ZrGZPqBrvXz+PncGkGQkEvN3ZRW15os0MpgNPA4s4kqP7RNLDYktijFJ+J12+axUAY
	 JY0S/EQAd43bw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53U0GlGI22014676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 08:16:47 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Apr 2025 08:16:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Apr 2025 08:16:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 30 Apr 2025 08:16:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 2/2] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Thread-Topic: [PATCH rtw-next v3 2/2] wifi: rtw89: Fix inadverent sharing of
 struct ieee80211_supported_band data
Thread-Index: AQHbuQJsTe1wuXvirkCMDKYarBy5Y7O7WAzg
Date: Wed, 30 Apr 2025 00:16:47 +0000
Message-ID: <7b2405f82b8f4b879d10453dde55a7f3@realtek.com>
References: <20250429122916.1734879-1-megi@xff.cz>
 <20250429122916.1734879-3-megi@xff.cz>
In-Reply-To: <20250429122916.1734879-3-megi@xff.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ond=F8ej Jirman <megi@xff.cz> wrote:
>=20
> Internally wiphy writes to individual channels in this structure,
> so we must not share one static definition of channel list between
> multiple device instances, because that causes hard to debug
> breakage.
>=20
> For example, with two rtw89 driven devices in the system, channel
> information may get incoherent, preventing channel use.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for your prompt work. :-)


