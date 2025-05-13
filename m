Return-Path: <linux-wireless+bounces-22891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12EBAB4A3F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D51E19E393F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8B17A31D;
	Tue, 13 May 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vlb4pxvc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978678F4B
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108352; cv=none; b=ZJaRIi2xPn/4C8guyFQiJYeJac8EQnF13ZL5IjnSxSzJd/m5VW8tT4RlxPCzmv4eMUZj8uLz1VzS9Yo2SSk36RK5X6TGi+oV2/QRUoPrQ0VbU6iUqfaaHv7TFg5ErbRfmGtvAMNlMH8s0n1IWCbsvkmInU/Ptz1bY6LYxWO1npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108352; c=relaxed/simple;
	bh=No3St6E2kpA5Rn27XK45JpX+VS16YWa48RB2X6x5B4Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QUYFqa9pH/UZFHSYKWh9w+W+CvXy8Ur7n8TZvylhK5+u4biRmyGg+W8raumalREDXowsP+/3Cbv7XbTJ+6oNEZgCgQuJJk9MDD0vHY/ECmBbVv2IJCXLtKPy3D7Q5Bb2aLxwST2EIodoZg8Cgl2y9zOqZ43jTZin/xbWET8qMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vlb4pxvc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3qQ3x93629366, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747108346; bh=No3St6E2kpA5Rn27XK45JpX+VS16YWa48RB2X6x5B4Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vlb4pxvc4E53l0dzZzGkQrTNSJRHHdeC6k407KVbwzNrdaoEiJFYySdck8JUjxZZh
	 NKxo3PjMMg5qLBs1diey4Q2q8EqniqJlOUiuB1EwxiN+lwzVVzor0pn8Qc2kmbhvA8
	 VPFBVQI8Hhv2rGIFxna5TdUolf4mXDR0Dn+4qNW/SiaLcnfrBCTheP3qB7Eqv35m8/
	 z59s6cSVX28Kf+4xtmfXQGtE5gDYwD6cxg/wOn6RiL4mksvJD7HVEPR8P1vpFMJNdC
	 uTd81ypYHsogqMiaNXKGzPWXKgPbSZVxlLYO7yWf2PLS2Dv0a1c3a/d1kJpAtnZa6i
	 0Ojuu59NmbrtQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3qQ3x93629366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:52:26 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:52:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:52:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:52:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 10/13] wifi: rtw89: Add some definitions for USB
Thread-Topic: [PATCH rtw-next v1 10/13] wifi: rtw89: Add some definitions for
 USB
Thread-Index: AQHbvTaXfxIJnbVMGE+se3XJA/hbirPP+lZA
Date: Tue, 13 May 2025 03:52:26 +0000
Message-ID: <3e038555fe57431eac02ad825aca0543@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <5be206e0-a8b1-4500-ba65-6e6427f84bc0@gmail.com>
In-Reply-To: <5be206e0-a8b1-4500-ba65-6e6427f84bc0@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
dmFyaW91cyByZWdpc3RlciBhbmQgYml0IGRlZmluaXRpb25zIHdoaWNoIHdpbGwgYmUgdXNlZCBi
eSB0aGUgbmV3DQo+IFVTQiBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

