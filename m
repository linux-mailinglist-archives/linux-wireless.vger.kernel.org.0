Return-Path: <linux-wireless+bounces-11648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C547957AD3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 03:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC491C20C69
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88533FD;
	Tue, 20 Aug 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HwOn2mo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963E175A6
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116524; cv=none; b=U2RE1zvOkRYKeKFBEmxWEfny52NhFSj72zoSbKpb8FIKHhKQmY60Of4IBdPXCPOD1hxM5wvAxMbhRW5JgERcLEHPfkEcz+wupg6KAJ8jXx0sD3J5Uj/wBpYdlxOLqsNDu17xfhgO+xF4Ep5vkXXf5ZMaTO/9S1hHGO8RgfWFW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116524; c=relaxed/simple;
	bh=FMzg5UF9DRPP5V4qRmiorjiYuWhxvxYrrnfaSDfDvWs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzmMLvGtU4PC2Y781AolBveN7ti/1y2uelSA/sTRB+uH/D+9MH4yGyY7mW+hYY/b6LQX1rH1uyzQ7BLzifljwZlFkynNbt++UyeztdCUpM5A9HXtjk8gyyLZ6ZQrmptaiLYez6ulTM19s8mcfNnARmVmlmykqblPCciEJ+19bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HwOn2mo2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K1FIVO0770049, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724116518; bh=FMzg5UF9DRPP5V4qRmiorjiYuWhxvxYrrnfaSDfDvWs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HwOn2mo2ydKtOtFDu67Hq5GNLq+1AES9Q8WScN/shawXXSWxso9gxxLpJWxGuvPKp
	 e7jthNNG2k9UzmuXBf+E68nkPRwYn/q+eCjf65j3iFcuV5eUmUoYm49kjjEbEccsrf
	 l4u/cFqj4BuGQWDBakmY2qFla27lm+/1ubiK4ymNXEWMeFhWolkKzKS5p0XhqZzBwQ
	 JyJTvekyNnjme4jDfNqjdbYOLomDcMlQOqKvMAVcIJO6AGGkCrB7l658V03My90Umv
	 BbvMF83LJmKaI3xM1FlvAUb9WDvNyHeU+wbDUI1hT33+ogpNJnSR1gcg6cqIGN/NHQ
	 yIDD7X9HkX6sw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K1FIVO0770049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:15:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 09:15:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 09:15:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 09:15:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
Thread-Topic: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to
 be NULL
Thread-Index: AQHa7DEJqrku59fojk68ID9tSyQ5d7In4PoAgAaB8YCAAQCD4A==
Date: Tue, 20 Aug 2024 01:15:18 +0000
Message-ID: <d8684f903e384b598dd69961319a6257@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <6d4194e2-8c8c-4d37-9b44-aada8d1d519f@gmail.com>
 <eb32692b42db48d2a05bd4feac9a814c@realtek.com>
 <a01b31f6-d33d-4763-9742-e22a1f975277@gmail.com>
In-Reply-To: <a01b31f6-d33d-4763-9742-e22a1f975277@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
NS8wOC8yMDI0IDA5OjMzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBSVEw4ODIxQSBkb2Vzbid0
IGhhdmUgdGhpcy4gVHJ5aW5nIHRvIHVzZSBpdCByZXN1bHRzIGluIGVycm9yIG1lc3NhZ2VzLA0K
PiA+PiBzbyBkb24ndCB0cnkgaWYgbHRlY29leF9hZGRyIGlzIE5VTEwuDQo+ID4NCj4gPiBJbiBz
aG9ydCB0ZXJtLCBpdCBpcyBmaW5lIHRvIGF2b2lkIHRoZXNlIG1lc3NhZ2VzLCBidXQgd2UgbmVl
ZCBCVC1jb2V4aXN0ZW5jZQ0KPiA+IGZvciBSVEw4ODIxQSBpZiB3ZSB3YW50IGJldHRlciB1c2Vy
IGV4cGVyaWVuY2Ugd2l0aCBCVC4NCj4gPg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPg0KPiA+DQo+ID4gUmV2
aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4NCj4g
DQo+IEkgd2Fzbid0IGFibGUgdG8gZmluZCB0aGlzIExURSBzdHVmZiBpbiB0aGUgYnRjIGZvbGRl
cjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL21vcnJvd25yLzg4MjFhdS0yMDIxMDcwOC90cmVlL21h
aW4vaGFsL2J0Yw0KPiANCj4gSSBkaWQgd2hhdCBJIGNvdWxkIHRvIG1ha2UgdGhlIGNvZXhpc3Rl
bmNlIHdvcmssIGFuZCBpdCBkb2VzLg0KPiBJIHVzZWQgbXkgQmx1ZXRvb3RoIGhlYWRwaG9uZXMg
Zm9yIHNldmVyYWwgZGF5cywgbGlzdGVuaW5nIHRvDQo+IG11c2ljIGFuZCB3YXRjaGluZyB2aWRl
b3MuIFRoZXJlIGlzIG9ubHkgYSBwcm9ibGVtIHdpdGggdGhlDQo+IHdpZmkgc3BlZWRzIHdpdGgg
b25lIHJvdXRlci4NCj4gDQo+IFdpdGggSVNQJ3MgSEc2NTQ0QyByb3V0ZXI6DQo+IE9mZmljaWFs
IGRyaXZlcjogMy81IE1icHMuDQo+IHJ0dzg4OiBhIGJpdCBtb3JlLCBidXQgbm90IHN0ZWFkeSBh
dCBhbGwuIE5vdCBlbm91Z2ggdG8gd2F0Y2gNCj4gYSAxMDgwcCBZb3V0dWJlIHZpZGVvLg0KPiAN
Cj4gV2l0aCBteSBELUxpbmsgRWFnbGUgUjMyIHJvdXRlciBydW5uaW5nIE9wZW53cnQsIG9uIHRo
ZSBzYW1lDQo+IGNoYW5uZWw6DQo+IE9mZmljaWFsIGRyaXZlcjogNi8xMCBNYnBzLg0KPiBydHc4
ODogZG93bmxvYWQgc3RhcnRzIGFyb3VuZCAzMCwgY2xpbWJzIHRvIDUwIC8gdXBsb2FkIGlzIDEw
DQo+IE1icHMuIEkgY2FuIHdhdGNoIGEgMTA4MHAgWW91dHViZSB2aWRlby4NCj4gDQo+IFRoZSBt
dXNpYyBkb2Vzbid0IGN1dCBvdXQgZHVyaW5nIGFueSBzcGVlZCB0ZXN0cy4NCj4gDQo+IEkgYWxz
byB0ZXN0ZWQgdHJhbnNmZXJyaW5nIGZpbGVzIHRvIGFuZCBmcm9tIG15IHBob25lLiBJIGRvbid0
DQo+IGhhdmUgb3RoZXIgdHlwZXMgb2YgZGV2aWNlcyB0byB0ZXN0Lg0KDQpHcmVhdCEgV2l0aCB0
aGVzZSB0ZXN0aW5nIGFzIGV2aWRlbmNlLCB3ZSBjYW4gYXBwcm92ZSB5b3VyIGNoYW5nZXMgcmVs
YXRlZCB0bw0KQlQtY29leGlzdGVuY2UuIFBsZWFzZSBhZGQgdGhlbSB0byBjb21taXQgbWVzc2Fn
ZXMuDQoNCg0K

