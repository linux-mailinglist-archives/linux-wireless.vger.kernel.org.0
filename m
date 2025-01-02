Return-Path: <linux-wireless+bounces-16973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677D9FF568
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 02:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A5D1881D20
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111BE634;
	Thu,  2 Jan 2025 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RF6JNQ6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A11392
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735780220; cv=none; b=RitSkbLHSUe6aqszLzvjNwVi1CQr+bXZ3en3wpP9LIGK87QpO7Mn1ubghF6VXExOTpfN/CYtwbn1irtjRZG5I65d4tED9/hlUW1pGyqdyPMXHtlxVwevYwNP4Nr4dXE5i5kHDvNNokC2sfeLbuK/BUBW14+013FkNT8lUvlY+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735780220; c=relaxed/simple;
	bh=zSOVpFKHCfXLYMkBNfYUiTJiKQpLEnMUSebghOI03Xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qO3f9ptS8KHsoRjtto+YU2WqVVpN/6YQ6kWL/+809jEy/0ncOhWIBU57PND0KZ73+Tua4bN+mr3h9JneyDwh4j3DlgO7U4Fx5DMoYY4KCElzdpIHNihjYSqX2jFr1YBn5rNJbIyYPSVRk3f/epKzZzNAKbwIHyHWcKRexZpGqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RF6JNQ6+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50219rhzE3799048, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735780193; bh=zSOVpFKHCfXLYMkBNfYUiTJiKQpLEnMUSebghOI03Xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RF6JNQ6+QpQIyJsl+rgSensT6R7JyuVPQ2LWjx1bvG4iU5TsoVuF8KbDbI/mN90in
	 T1IK2p5KxasCV0oX5NpW+GcDYQEZAkH/sgG5OAJIEd9ZcyETqiKNv5zBbqKZ3N35Vh
	 ttVxrtY8ZHST52B2Y7XQQWYuBqqc4q+BrG8U0GKM+p5OdsoM8CqkfDWr6n/JrfqeA1
	 Qp2/hHnRcz71l/pFz6rmTy0wmivMYdqx0UVtK/UPi7IZZv4zulzE1LtdbI7zt46lZE
	 dxlbOWt53M9bTfPmSAkvNzGHuKr5e6dkTLs9+pGtsjGbQhSiS5ELKnU+M6e0/NMSvQ
	 evgm5+40KXosQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50219rhzE3799048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jan 2025 09:09:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 2 Jan 2025 09:09:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 Jan 2025 09:09:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 2 Jan 2025 09:09:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2] wifi: rtw88: Add USB PHY configuration
Thread-Topic: [PATCH v2] wifi: rtw88: Add USB PHY configuration
Thread-Index: AQHbXGiKVA9qqrpLn0CLtO8lkqxuAbMCrRhw
Date: Thu, 2 Jan 2025 01:09:53 +0000
Message-ID: <a776e4ba61634fcf9b20b5df3d2b55c5@realtek.com>
References: <9d312b14-0146-4be8-9c50-ef432234db50@gmail.com>
In-Reply-To: <9d312b14-0146-4be8-9c50-ef432234db50@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
c29tZSBleHRyYSBjb25maWd1cmF0aW9uIGZvciBVU0IgZGV2aWNlcy4gQ3VycmVudGx5IG9ubHkg
UlRMODgyMkJVDQo+IHZlcnNpb24gKGN1dCkgRCBuZWVkcyB0aGlzLiBUaGUgbmV3IGNvZGUgbWFr
ZXMgdXNlIG9mIHRoZSBleGlzdGluZw0KPiB1c2IzX3BhcmFtXzg4MjJiIGFycmF5IGZyb20gcnR3
ODgyMmIuYy4NCj4gDQo+IEEgdXNlciByZXBvcnRlZCB0aGF0IFRQLUxpbmsgQXJjaGVyIFQzVSBp
biBVU0IgMyBtb2RlIHdhcyByYW5kb21seQ0KPiBkaXNjb25uZWN0aW5nIGZyb20gVVNCOg0KPiAN
Cj4gWyAyNi4wMzY1MDJdIHVzYiAyLTI6IG5ldyBTdXBlclNwZWVkIFVTQiBkZXZpY2UgbnVtYmVy
IDMgdXNpbmcgeGhjaV9oY2QNCj4gLi4uDQo+IFsgMjcuNTc2NDkxXSB1c2IgMi0yOiBVU0IgZGlz
Y29ubmVjdCwgZGV2aWNlIG51bWJlciAzDQo+IFsgMjguNjIxNTI4XSB1c2IgMi0yOiBuZXcgU3Vw
ZXJTcGVlZCBVU0IgZGV2aWNlIG51bWJlciA0IHVzaW5nIHhoY2lfaGNkDQo+IC4uLg0KPiBbIDQ1
Ljk4NDUyMV0gdXNiIDItMjogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgNA0KPiAuLi4N
Cj4gWyA0Ni44NDU1ODVdIHVzYiAyLTI6IG5ldyBTdXBlclNwZWVkIFVTQiBkZXZpY2UgbnVtYmVy
IDUgdXNpbmcgeGhjaV9oY2QNCj4gLi4uDQo+IFsgOTQuNDAwMzgwXSB1c2IgMi0yOiBVU0IgZGlz
Y29ubmVjdCwgZGV2aWNlIG51bWJlciA1DQo+IC4uLg0KPiBbIDk1LjU5MDQyMV0gdXNiIDItMjog
bmV3IFN1cGVyU3BlZWQgVVNCIGRldmljZSBudW1iZXIgNiB1c2luZyB4aGNpX2hjZA0KPiANCj4g
VGhpcyBwYXRjaCBmaXhlcyB0aGF0Lg0KPiANCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2x3
ZmluZ2VyL3J0dzg4L2lzc3Vlcy8yNjINCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0K

