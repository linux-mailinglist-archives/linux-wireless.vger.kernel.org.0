Return-Path: <linux-wireless+bounces-30111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C860CDE339
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 02:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C77E63000B2A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855B1C862E;
	Fri, 26 Dec 2025 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="m2HSdLRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADE155C97
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766713238; cv=none; b=BYxJRx7UtBPmrVEuZqm2lwTrfIpCg4eDi9VdNaYe8osO8mH+BYN8v+4PoDSnGJFs9Yl0j5RyXvgC1+7lqL3iN8gSA5oyOVD8WsSUzySQ88mwBxtiuWQBwt4APYoyBRzGmrZ7dTQJtQLxPP0nSwTgyNvxEQ4psyM0jpMy/Kva/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766713238; c=relaxed/simple;
	bh=frX7YMwBHI5goR7X0yYJoBA3AJTCYOCD1fFHsOjX3Qc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f6Ll6a6MKkg4x1QajPGenXNEVezX6FNB1Vx9Qe3JfEgFHelvgZU0jY/Q0mjwfLf/TbhRjK6+iUM+e5DlmCKNVGj06YowzbDOausWxUVqEUS5PZEljyJRvV70EnrXCuG7ev/RZG9NatoyOuzhDPEoxFRXacmmJszP238/eSDi1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=m2HSdLRP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ1eXhgD2663691, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766713233; bh=frX7YMwBHI5goR7X0yYJoBA3AJTCYOCD1fFHsOjX3Qc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m2HSdLRPqWAE5+V72HOd5+/5PsijrPoI7iOcNOZZGFLSCIgqY3j/JDOaoF2589412
	 T6IEfdKuMz6KNoR/8p8mUwv5OHqLcBAuwVxn+xJbn3ef1wBxR20GKFWv+pnEjwKhBI
	 7fnVQp/tusBW1vTHyN6LUMv/H1Jv6wd9t94HKvD8llin6TySvqp/TPjCQ4cPftPyBw
	 BKP0gxxE8nxvqGkcwPpntCdtEZWMrXMlhWzbMLJsntIQZ4udSRjaGavEDVAXp+NlUL
	 cTMwvn23xQ9zpj/isMm+boiWGp6tRk1wts5baIWrX5QUcrizKCag3c254HPuvTuntm
	 pL9fizurOcRcg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ1eXhgD2663691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 09:40:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:40:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 26 Dec 2025 09:40:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/3] wifi: rtw88: Use devm_kmemdup() in
 rtw_set_supported_band()
Thread-Topic: [PATCH rtw-next 2/3] wifi: rtw88: Use devm_kmemdup() in
 rtw_set_supported_band()
Thread-Index: AQHcdGNyNNYhNkN5XEuXGcajh5+COrUzKF9w
Date: Fri, 26 Dec 2025 01:40:33 +0000
Message-ID: <26231032df514e0b931fc1c047d0829b@realtek.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
 <1aa7fdef-2d5b-4a31-a4e9-fac8257ed30d@gmail.com>
In-Reply-To: <1aa7fdef-2d5b-4a31-a4e9-fac8257ed30d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTaW1w
bGlmeSB0aGUgY29kZSBieSB1c2luZyBkZXZpY2UgbWFuYWdlZCBtZW1vcnkgYWxsb2NhdGlvbnMu
DQo+IA0KPiBUaGlzIGFsc28gZml4ZXMgYSBtZW1vcnkgbGVhayBpbiBydHdfcmVnaXN0ZXJfaHco
KS4gVGhlIHN1cHBvcnRlZCBiYW5kcw0KPiB3ZXJlIG5vdCBmcmVlZCBpbiB0aGUgZXJyb3IgcGF0
aC4NCj4gDQo+IENvcGllZCBmcm9tIGNvbW1pdCAxNDVkZjUyYTg2NzEgKCJ3aWZpOiBydHc4OTog
Q29udmVydA0KPiBydHc4OV9jb3JlX3NldF9zdXBwb3J0ZWRfYmFuZCB0byB1c2UgZGV2bV8qIiku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQo=

