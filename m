Return-Path: <linux-wireless+bounces-10066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B4929C8B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 08:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64C3B20ED5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD71864C;
	Mon,  8 Jul 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v69MZKZp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE331862A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421661; cv=none; b=Q/T2dmW8YWPb+c0H5AEjJBkuzKbTtJeSueYo2u5o9wJhLHuTZfHn/BbNzvGBHvFd3fGeQWgZ/aPxcpPmCF3w5dCMKTgFwl7VB7OUb3q//TOnAzA+tnMoIG63NA9a5WgL+rq2XeRT+rMzdb98gr9yfnda71hG8nvhH+vZBbdUNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421661; c=relaxed/simple;
	bh=PkfOb/upGhZI05DB2PvPAjRQtP+kc5VCJGrqpy2do6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQkjval0WxCDxdeaTCMzWqYrKNBtFlh/hcKWFpmy8PcWA8hBu7uHLllz9+hE31I4Bo8EStG89kBfWJYI9lAJvolzha5tVjfxk4ktuli7hjx8BOTkT5W+Ys9lUp3OR9EAV6U7BhYafeCSrJrZ562HdRp0YDevU4OHJuruSZYr0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v69MZKZp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4686sCGS13349418, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720421652; bh=PkfOb/upGhZI05DB2PvPAjRQtP+kc5VCJGrqpy2do6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v69MZKZpd8k/gmxgxoc3jXv7IjuIKvTydcUmpgLRlBpidYaFJvRg9FARooNtoER+F
	 QCF63r3k6r/slY9779tkyMKxjQ/TZOicRdkAyOwSze0EG2Qa8dqJTt4GqnJBBR7EES
	 HYJwP+iBw2y+2brNcYt2SE3u5fUjUq3657i2Un3qoPDZfoOc/bfO1zYubiMKc8u6hQ
	 HlhCw0wMT3poaKHVDJRMHIMVrqkSfnUm9yF3uVROZSkR4/IARwTl7N5w5mWXIiOL5B
	 3OVvoqz1oo9SUGsIZKFFFdlJqn7eSDwPdL+vVBBrYKlnX3XCGj59e+b5fwh8KI6byU
	 tUzBEVF3yUrIQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4686sCGS13349418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 14:54:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 14:54:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jul 2024 14:54:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 8 Jul 2024 14:54:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Set efuse->ext_lna_5g - fix typo
Thread-Topic: [PATCH] wifi: rtw88: Set efuse->ext_lna_5g - fix typo
Thread-Index: AQHazyxru5eSjigdl0GFbr6YlRChFLHsaNAQ
Date: Mon, 8 Jul 2024 06:54:13 +0000
Message-ID: <ce285c5694db42c58c03777962ca2e5b@realtek.com>
References: <8ccc9e13-0d45-417d-8f88-93a0ad294f77@gmail.com>
In-Reply-To: <8ccc9e13-0d45-417d-8f88-93a0ad294f77@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBlZnVz
ZS0+ZXh0X2xuYV8yZyBpcyBzZXQgdHdpY2UgYW5kIGVmdXNlLT5leHRfbG5hXzVnIGlzIG5vdCBz
ZXQgYXQgYWxsLg0KPiBTZXQgZWFjaCBvbmUgb25jZS4NCj4gDQo+IE5vdGhpbmcgdXNlcyB0aGVz
ZSBtZW1iZXJzIHJpZ2h0IG5vdy4gVGhleSB3aWxsIGJlIHVzZWQgYnkgdGhlIFJUTDg4MjFBVQ0K
PiBhbmQgUlRMODgxMkFVIGRyaXZlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

