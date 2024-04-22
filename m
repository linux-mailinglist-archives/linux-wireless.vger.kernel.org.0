Return-Path: <linux-wireless+bounces-6625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12F8AC321
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B2C1C2088F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3DBDDAB;
	Mon, 22 Apr 2024 03:40:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662F4C97
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757212; cv=none; b=pXNjER/vTRCU16yOpp2pecMnDrmQWSbGwuJDY0mmbwQxhuE3BO3Gye5Ff78c0ydN2OduYsLnmtkYp4565yISXBkp8D9b4DI2eOFBnQlYF1bOfJ8UtWHQZss9cV0pyPGNZmqQdWg7CPH6NpPqeKzPR0lwAarzSdrIIrp9hyNjMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757212; c=relaxed/simple;
	bh=n31BrM4opCye6AKclAAN6fkgZSJocmywKvWTlxszywo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxxGXANcFvEhnx9gvseZzNPtAl7nx7yWNzQpN1ay6Hdkyr0AtJKGWMj/1xrzqgMK6KudnCd6wnflsEsal42OLu5xg+Ig6chErvsev1bpcFqrgYyeRLNn55fYlE22fMGs0sfGVsu38QoTEw1MrtSm5vBZM6bAdQmBxo4+6A3BfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M3dhoA73832563, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M3dhoA73832563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 11:39:43 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 11:39:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 11:39:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 22 Apr 2024 11:39:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Topic: [PATCH v6 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Index: AQHakl8Bv/1fe7z9OEWLOZXO7sHZsbFzpzDQ
Date: Mon, 22 Apr 2024 03:39:43 +0000
Message-ID: <f080fd27b21147869e8b923891d5dcff@realtek.com>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <45848eb2-9c52-4aac-b7b0-b584955e41d7@gmail.com>
In-Reply-To: <45848eb2-9c52-4aac-b7b0-b584955e41d7@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBIGZl
dyBvZiB0aGUgc2hhcmVkIGZ1bmN0aW9ucyBuZWVkIHNtYWxsIGNoYW5nZXMgZm9yIHRoZSBVU0Ig
ZHJpdmVyOg0KPiAgLSBmaXJtd2FyZSBsb2FkaW5nDQo+ICAtIGVmdXNlIHJlYWRpbmcNCj4gIC0g
cmF0ZSBtYXNrIHVwZGF0aW5nDQo+ICAtIHJmIHJlZ2lzdGVyIHJlYWRpbmcNCj4gIC0gaW5pdGlh
bCBnYWluIGZvciBzY2FubmluZw0KPiANCj4gQWxzbywgYWRkIGEgZmV3IG1hY3JvcyB0byB3aWZp
LmggYW5kIGluaXRpYWxpc2UgcnRsaGFsLmludGVyZmFjZWluZGV4DQo+IGZvciBVU0IgZGV2aWNl
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJA
Z21haWwuY29tPg0KDQpbLi4uXQ0KDQo+IEBAIC05NjUsMTIgKzk4MywyMCBAQCBzdGF0aWMgdm9p
ZCBydGw5MmRlX3VwZGF0ZV9oYWxfcmF0ZV9tYXNrKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0K
PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICB2YWx1
ZVswXSA9IChyYXRyX2JpdG1hcCAmIDB4MGZmZmZmZmYpIHwgKHJhdHJfaW5kZXggPDwgMjgpOw0K
PiAtICAgICAgIHZhbHVlWzFdID0gbWFjaWQgfCAoc2hvcnRnaSA/IDB4MjAgOiAweDAwKSB8IDB4
ODA7DQo+ICsgICAgICAgbGUzMnBfcmVwbGFjZV9iaXRzKCZyYXRlX21hc2sucmF0ZV9tYXNrX2Fu
ZF9yYWlkLCByYXRyX2JpdG1hcCwgUkFURV9NQVNLX01BU0spOw0KPiArICAgICAgIGxlMzJwX3Jl
cGxhY2VfYml0cygmcmF0ZV9tYXNrLnJhdGVfbWFza19hbmRfcmFpZCwgcmF0cl9pbmRleCwgUkFJ
RF9NQVNLKTsNCj4gKyAgICAgICB1OHBfcmVwbGFjZV9iaXRzKCZyYXRlX21hc2subWFjaWRfYW5k
X3Nob3J0X2dpLCBtYWNpZCwgTUFDSURfTUFTSyk7DQo+ICsgICAgICAgdThwX3JlcGxhY2VfYml0
cygmcmF0ZV9tYXNrLm1hY2lkX2FuZF9zaG9ydF9naSwgc2hvcnRnaSwgU0hPUlRfR0lfTUFTSyk7
DQo+ICsgICAgICAgdThwX3JlcGxhY2VfYml0cygmcmF0ZV9tYXNrLm1hY2lkX2FuZF9zaG9ydF9n
aSwgMSwgQklUKDcpKTsNCj4gKw0KPiAgICAgICAgIHJ0bF9kYmcocnRscHJpdiwgQ09NUF9SQVRS
LCBEQkdfRE1FU0csDQo+IC0gICAgICAgICAgICAgICAicmF0cl9iaXRtYXAgOiV4IHZhbHVlMDol
eCB2YWx1ZTE6JXhcbiIsDQo+IC0gICAgICAgICAgICAgICByYXRyX2JpdG1hcCwgdmFsdWVbMF0s
IHZhbHVlWzFdKTsNCj4gLSAgICAgICBydGw5MmRfZmlsbF9oMmNfY21kKGh3LCBIMkNfUkFfTUFT
SywgNSwgKHU4ICopdmFsdWUpOw0KPiArICAgICAgICAgICAgICAgIlJhdGVfaW5kZXg6JXgsIHJh
dHJfdmFsOiV4LCAlNXBoQ1xuIiwNCj4gKyAgICAgICAgICAgICAgIHJhdHJfaW5kZXgsIHJhdHJf
Yml0bWFwLCAmcmF0ZV9tYXNrKTsNCj4gKyAgICAgICBtZW1jcHkocnRscHJpdi0+cmF0ZV9tYXNr
LCAmcmF0ZV9tYXNrLCBzaXplb2YocnRscHJpdi0+cmF0ZV9tYXNrKSk7DQo+ICsgICAgICAgLyog
cnRsOTJkX2ZpbGxfaDJjX2NtZCgpIGRvZXMgVVNCIEkvTyBhbmQgd2lsbCByZXN1bHQgaW4gYQ0K
PiArICAgICAgICAqICJzY2hlZHVsZWQgd2hpbGUgYXRvbWljIiBpZiBjYWxsZWQgZGlyZWN0bHkN
Cj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBzY2hlZHVsZV93b3JrKCZydGxwcml2LT53b3Jrcy5m
aWxsX2gyY19jbWQpOw0KDQpUaGlzIGZ1bmN0aW9uIHdpbGwgYmUgdXNlZCBieSBib3RoIFBDSSBh
bmQgVVNCLCByaWdodD8gQnV0LCANCm9ubHkgVVNCIGluaXRpYWxpemUvY2FuY2VsIHJ0bHByaXYt
PndvcmtzLmZpbGxfaDJjX2NtZC4gDQoNCg0K

