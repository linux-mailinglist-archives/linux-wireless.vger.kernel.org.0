Return-Path: <linux-wireless+bounces-22161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F0A9FECC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 03:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5198A1886A75
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 01:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0654D8C8;
	Tue, 29 Apr 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K660JOJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C8367
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888979; cv=none; b=ajzFFHyfAH5Ux0MpePcJInjgpyiXY/D0vsPw5aQg9rJAPG+lVK/9eDChOT1+WaGiV0ry2gJ6m1TZ1sp3JBqWoIx3cBrQU3PAnvJIg1ZtS3JtZf8hVgh+gncVbzudu2pDJv4cW/EcskbP1Ag1ZEpkUsjYep8Rwkw6EcX7tbRTi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888979; c=relaxed/simple;
	bh=eI+/gEqRvNhqWsI4jeGvfSrS80hGbm1Hb1/IDoiTEXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h3LTPTMoECQtQri7wpbAohF0B41/36rXvj2gVDvQ9HLYeFsnFQqRdktAc0ji5Y1q7IVWWkJdVIi8XWTGVTW0hwUufvNiqliQM0gOv6uaE+jRXEIRXAC6t91BPYVlKB7M/NSmVx0hy/ylzw8W4zy9qu1h30pODJ6FOiDJK9wyItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K660JOJn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T19X8Q03786667, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745888973; bh=eI+/gEqRvNhqWsI4jeGvfSrS80hGbm1Hb1/IDoiTEXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=K660JOJnVNmBNNTQenfs9bxd+oWiRoAPCCJVJNtVfGDhZAO1VluBLscgNvDMLFtS6
	 VFO6/MQfVxGoYpEf/N4yGTZkmBHN/J95L++4jKzwfJYCuuuhJpUA57opErkdsupP30
	 b3ANLW9/wULVewjnBmd0zeaJVp7TJNwVh1dAodkBY6p0Sp/PnUZvB4IpnuQ6PnlGSk
	 8RV0NBT+PuXMcZfXHJobNEuN+iFPKYzStaiul+u1djdD6WnESsVBCXvV2iqkfwPmq3
	 AIyD3DmRf7851Du7M3yRF6Dcpdt9KIXfX+tmqdQ8p0VXlceFlQK0z+sT8Rg3scveRp
	 ikRmtqrfCmEBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T19X8Q03786667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 09:09:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 09:09:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 09:09:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 09:09:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw88: Handle RTL8723D(S) with blank efuse
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw88: Handle RTL8723D(S) with blank
 efuse
Thread-Index: AQHbuIRsoS2Lmo5FaEuNvJmRE0jD67O51Wmg
Date: Tue, 29 Apr 2025 01:09:33 +0000
Message-ID: <62deb82499574f3f801d4207be3569ad@realtek.com>
References: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
 <43cedb70-64ae-4126-820d-a55b038e3ab2@gmail.com>
In-Reply-To: <43cedb70-64ae-4126-820d-a55b038e3ab2@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
IHVzZXJzIGhhdmUgUlRMODcyM0RTIGNoaXBzIHdpdGggbmVhcmx5IGJsYW5rIGVmdXNlLiBDdXJy
ZW50bHkgdGhlc2UNCj4gY2hpcHMgY2Fubm90IGNvbm5lY3Qgd2hlbiB1c2luZyBydHc4OCwgYnV0
IHRoZXkgZG8gd29yayB1c2luZyB0aGUgb2xkDQo+IG91dC1vZi10cmVlIGRyaXZlci4NCj4gDQo+
IFVzZSByZWFzb25hYmxlIGRlZmF1bHQgdmFsdWVzIGZvciBUWCBwb3dlciwgYW50ZW5uYSBjb25m
aWd1cmF0aW9uLCBhbmQNCj4gY3J5c3RhbCBjYXAgaWYgdGhlIGNoaXAncyBlZnVzZSBpcyBtaXNz
aW5nIHRoZXNlIHRoaW5ncy4NCj4gDQo+IFJUTDg3MjNEIGNhbiB1c2UgdGhlIHNhbWUgZGVmYXVs
dCB2YWx1ZXMgYXMgUlRMODcwM0IsIHNvIHNpbXBseSBtb3ZlDQo+IHRoZSBjb2RlIGZyb20gcnRs
ODcwM2JfcmVhZF9lZnVzZSgpIHRvIHRoZSBzaGFyZWQgZnVuY3Rpb24NCj4gX19ydGw4NzIzeF9y
ZWFkX2VmdXNlKCkuDQo+IA0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnR3
ODgvaXNzdWVzLzE1Nw0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KDQo=

