Return-Path: <linux-wireless+bounces-22185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5703AA02FF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143CC7A9558
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378628DEE2;
	Tue, 29 Apr 2025 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KOsN9BR6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5C288CB2;
	Tue, 29 Apr 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907373; cv=none; b=AWQZUViSeYfYYxefwgczrY4VSNNjnbpEhA6DLYC43d6xpoZRcruYrLzdxtpd1R02pLm9j+RPNLRt79oS+qp5L3AOhaNRwjRyIktpJ7weSTscywbusezGnok6LkimujSTBvCwFnosB5xuKXSHsZwcxIn7Ab0Vt9C9CLB3wKVMKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907373; c=relaxed/simple;
	bh=hjSDGBDMpJQPYz8STB7s85ztFBwW+FizW4l63DRd5S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itiygFVFHbM/2G7we43HvUVwaxdGATLa00R7mfmaG2oKZIE302/VnTkR1M41HKDXcXsPeUuya7o1/qs5qoYcLffqNvUCVu31Ir4+SGRSxoEbppzUXY2qj7774u6mZJ7/ve00e1oitVt/GwOVEy8XHFIfJ6wWlyAolNL8oYO4jLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KOsN9BR6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T6G4v14214305, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745907364; bh=hjSDGBDMpJQPYz8STB7s85ztFBwW+FizW4l63DRd5S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KOsN9BR6rAfDjvOe9rzuKPKXos9stR844fBMhdQG9gUgJxmmr52lNDk5eE0Qn30tL
	 Eno7j4CpnPepn4m5BwT8TXaSbYaUkK2/v12X87/6I2OUUeR2NNA2R8DfgrjO+4uf7u
	 66K+7GlNm9U9aTkXpeE/X6WwnBhBjciK8axDgrsVSrN+0MXJWX2mVNdJQay+FncEDV
	 lrsXpiuCG4DXzF6zAn8Lw+zIJmW+inwE54wjsj6Sme00tjNJGRsfhyl9gNowsgzNOO
	 6kHvWYHFtQEnDwB6zdvAG7D8KbzMQIqBYRQ+xplVSCrRoEDnN8A6oRbXq+dWKTtjnV
	 itHpYOwH75OCw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T6G4v14214305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 14:16:04 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 14:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 14:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 14:16:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Fix inadverent sharing of struct ieee80211_supported_band data
Thread-Topic: [PATCH v2 0/2] Fix inadverent sharing of struct
 ieee80211_supported_band data
Thread-Index: AQHbuK1smA8zMS1NHESwt0pIpj/QeLO6KnYA
Date: Tue, 29 Apr 2025 06:16:04 +0000
Message-ID: <32a588f367824aa59b35564d8075fd45@realtek.com>
References: <20250429022046.1656056-1-megi@xff.cz>
In-Reply-To: <20250429022046.1656056-1-megi@xff.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ond=F8ej Jirman <megi@xff.cz> wrote:
>=20
> This is a series of patches requested by Ping-Ke Shih in response to
> https://lore.kernel.org/lkml/20250427002414.410791-1-megi@xff.cz/
>=20
> Please take a look.
>=20
> (hw->wiphy->bands[*] are no longer being NULLed when probe fails and on
> remove(), but I guess that should not be an issue? I tried unbinding the
> device and it worked fine without any crash)

The original code set bands[] to NULL, because the error path could call
free function twice, so set NULL to prevent double free. After using
devm_ series, it becomes unnecessary.=20



