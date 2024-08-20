Return-Path: <linux-wireless+bounces-11645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97867957A81
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 02:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E971F23663
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F24C9A;
	Tue, 20 Aug 2024 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z7dFqTVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F712F52
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113958; cv=none; b=TOnkiq8phCjRGDIMa/Ie3c4z7bVrA2XbC6E2kdpCiij+sH3oqnIRRiUijFOoFE6PcrnEvWqwIIkXhkfgQuQ+/JU9w4aWMPBWsrjSUk7pUrNssnNWnJ/b/euq8g9YI0QFgmIMDEm6l1YIuNTU44sI5AhWoKhk6+SyFX9UUwoUvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113958; c=relaxed/simple;
	bh=G5uRBneJAEFfmbpRJS/MG8WTlh204Yl/JXhC5qHxswg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gr1sR3IhKi24VqsYdKY9sgVqc89f6U+ky+X8PG7BDqoWzaXPCEPkiRDSA7+Z7lt2+vQiQQjS9Nr9nF+GZfoOPYkp1oF+XTJPGwZ+C7Xd5HjeW04XHBfQOHXF+oa3b943YoQC7Sjy3lUOzzR0CzmPCiNR7hCZ3DFnjKKAJ9Z/nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z7dFqTVe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K0WUAC0731427, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724113950; bh=G5uRBneJAEFfmbpRJS/MG8WTlh204Yl/JXhC5qHxswg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z7dFqTVeXEwSG3plp5T49Oo2q3gi3C263idVd8as4SmzIC+ySb4pnoWb2cHtXCBr9
	 7oCUkErJ7Mo+xYtobyAzoLX/a9gNg7cLzyiMkg96TKbt7cYDT1LYWOgANvLD7lNKu3
	 vGH3hBCUt1c4VoPcX2V8nY2nivQlTCpTzHoiCKbV85DF904ETYOHYSMG8FGBWMbf84
	 iuMKtW0VvtbGZTDPZrDvxrE7GZty7lqZMPCWi8t1s9dZm8ZRP3bF7D/rDO2GQnhKWe
	 JShw4A+Y3NYAJGRvsigIWtK8z/4T4bfqwix7nZ5qWWCnZddOxpUK8TxQfn8ab/PcR2
	 UK50t99M8xs4Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K0WUAC0731427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 08:32:30 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 08:32:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 08:32:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 08:32:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: assign mac_id for vif/sta and update to TX desc
Thread-Topic: [PATCH] wifi: rtw88: assign mac_id for vif/sta and update to TX
 desc
Thread-Index: AQHa8eLtFd5VZuT6mkyKNvY0eJ8tEbIuaCqAgADjaWA=
Date: Tue, 20 Aug 2024 00:32:30 +0000
Message-ID: <0bc3bac41fa14377b8f824d1184df4a6@realtek.com>
References: <20240819025248.17939-1-pkshih@realtek.com>
 <4602091e-7093-4f35-b465-7753be8ff02d@gmail.com>
In-Reply-To: <4602091e-7093-4f35-b465-7753be8ff02d@gmail.com>
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
OS8wOC8yMDI0IDA1OjUyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQSBtYWNfaWQgYXMgYW4g
aW5zdGFuY2UgaW4gZmlybXdhcmUgaGFzIHRvIGJlIGFzc2lnbmVkIGZvciBlYWNoIHN0YXRpb24N
Cj4gPiBpbmNsdWRpbmcgQVAgYW5kIGNvbm5lY3RlZCBzdGF0aW9ucy4gRmlybXdhcmUgd2lsbCB1
c2UgdGhlIG1hY19pZCB0bw0KPiA+IGNvbnRyb2wgVFggcmF0ZSBhbmQgZG8gc3RhdGlzdGljcy4N
Cj4gPg0KPiA+IEFzc2lnbm1lbnQgcnVsZSBpcyB0byBhc3NpZ24gbWFjX2lkIHRvIGVhY2ggdmlm
IHdoZW4gYWRkaW5nIHZpZi4NCj4gPiBGb3Igc3RhdGlvbiBtb2RlLCBzdGEtPm1hY19pZCB3aWxs
IHJldXNlIHZpZi0+bWFjX2lkLiBGb3IgQVAgbW9kZSwNCj4gPiBkeW5hbWljYWxseSBhbGxvY2F0
ZSBhbiBzdGEtPm1hY19pZCB0byBhIHN0YXRpb24sIGFuZCB2aWYtPm1hY19pZCBpcw0KPiA+IHVz
ZWQgdG8gc2VuZCBicm9hZGNhc3QvbXVsdGljYXN0IHBhY2tldHMgd2hpY2ggYXJlIG5vdCBiZWxv
bmcgdG8NCj4gPiBhIHN0YXRpb24uIEZvciBleGFtcGxlLA0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgICAgdmlmLT5tYWNfaWQgICAgICBzdGEtPm1hY19pZA0KPiA+IHZpZjAgKFNUQSBtb2RlKSAg
ICAgICAgMCAgICAgICAgICAgICAgIDANCj4gPiB2aWYxIChBUCBtb2RlKSAgICAgICAgIDEgICAg
ICAgICAgICAgICAyLi4uDQo+ID4NCj4gPiBCeSB0aGUgd2F5LCByZW1vdmUgdW51c2VkIFJUV19C
Q19NQ19NQUNJRCwgd2hpY2ggd2FzIHBsYW5lZCB0byBzZW5kDQo+ID4gYnJvYWRjYXN0L211bHRp
Y2FzdCBwYWNrZXRzIG9uIGZpeGVkIG1hY19pZC4NCj4gPg0KPiANCj4gSSB0ZXN0ZWQgdGhpcyB3
aXRoIFJUTDg4MjJDRSBpbiBBUCBtb2RlIHdpdGggYSBzaW5nbGUgdmlmLiBJdCBzYXlzOg0KPiAN
Cj4gQXVnIDE5IDIxOjMyOjQ3IGlkZWFwYWQyIGtlcm5lbDogcnR3Xzg4MjJjZSAwMDAwOjAyOjAw
LjA6IGNoYW5nZSB2aWYgMDA6NDU6ZTI6YTE6NjU6YWIgKDIpLT4oMyksIHAycA0KPiAoMCktPigw
KQ0KPiBBdWcgMTkgMjE6MzI6NDcgaWRlYXBhZDIga2VybmVsOiBydHdfODgyMmNlIDAwMDA6MDI6
MDAuMDogc3RvcCB2aWYgMDA6NDU6ZTI6YTE6NjU6YWIgbWFjX2lkIDAgb24gcG9ydCAwDQo+IEF1
ZyAxOSAyMTozMjo0NyBpZGVhcGFkMiBrZXJuZWw6IHJ0d184ODIyY2UgMDAwMDowMjowMC4wOiBz
dGFydCB2aWYgMDA6NDU6ZTI6YTE6NjU6YWIgbWFjX2lkIDAgb24gcG9ydCAwDQo+IEF1ZyAxOSAy
MTozMzo1NCBpZGVhcGFkMiBrZXJuZWw6IHJ0d184ODIyY2UgMDAwMDowMjowMC4wOiBzdGEgYjY6
YmQ6M2M6YzA6Mzk6ODcgam9pbmVkIHdpdGggbWFjaWQgMQ0KPiANCj4gVGhlbiBJIGFkZGVkIGFu
b3RoZXIgdmlmOg0KPiANCj4gIyBpdyBkZXYgd2xwMnMwIGludGVyZmFjZSBhZGQgbXlfaW50ZXJm
YWNlIHR5cGUgbWFuYWdlZA0KPiANCj4gQXVnIDE5IDIxOjM2OjQ1IGlkZWFwYWQyIGtlcm5lbDog
cnR3Xzg4MjJjZSAwMDAwOjAyOjAwLjA6IHN0YXJ0IHZpZiAzZTo2MDpjYzowYjpmYToxNyBtYWNf
aWQgMiBvbiBwb3J0IDENCj4gDQo+IFNvIGluIHRoaXMgY2FzZSB0aGUgQVAgdmlmJ3MgcnR3dmlm
LT5tYWNfaWQgaXMgMCwgYW5kIHRoZSBmaXJzdA0KPiBzdGF0aW9uIGdldHMgMS4gVGhlIG1hbmFn
ZWQgdmlmJ3MgcnR3dmlmLT5tYWNfaWQgaXMgMi4gSXMgaXQgb2theQ0KPiBpZiB0aGUgbnVtYmVy
cyBhcmUgbm90IGFzc2lnbmVkIGxpa2UgaW4geW91ciBleGFtcGxlPw0KDQpBbGwgbWFjX2lkIGFy
ZSBhc3NpZ25lZCBkeW5hbWljYWxseS4gSSB0aGluayB5b3VyIGNhc2Ugc2hvdWxkIGJlIHN0aWxs
IGZpbmUuDQpJcyB0aGVyZSBhbnkgcHJvYmxlbSB5b3UgbWV0Pw0KDQpJIGNhbiBjaGFuZ2UgdGhl
IHJlYWwgbnVtYmVyIHRvIGFsZ2VicmENCg0KICAgICAgICAgICAgICAgICAgIHZpZi0+bWFjX2lk
ICAgICAgc3RhLT5tYWNfaWQNCiB2aWYwIChTVEEgbW9kZSkgICAgICAgIG4gICAgICAgICAgICAg
ICBuDQogdmlmMSAoQVAgbW9kZSkgICAgICAgICBtICAgICAgICAgICAgICAgYSwgYiwgYyAuLi4N
Cg0KV2hlcmUsIG4sIG0sIGEsIGIsIGMsIC4uLiBhcmUgYWxsIGRpZmZlcmVudCBudW1iZXIuIFRo
ZSBzcGVjaWFsIG51bWJlciBpcyBvbmx5ICduJw0KcHJlc2VudHMgb24gdHdvIHBsYWNlcy4NCg0K
VGhlIGxpbWl0IG9mIGhhcmR3YXJlIGlzIEFQIG1vZGUgc2hvdWxkIHdvcmsgb24gcG9ydCAwLCBz
byB5b3UgY2FuIGZpbmQgdGhlDQpjb25kaXRpb24gdG8gc3dpdGNoIHBvcnQgaW4gcnR3X2NvcmVf
cG9ydF9zd2l0Y2goKToNCg0KCWlmICh2aWYtPnR5cGUgIT0gTkw4MDIxMV9JRlRZUEVfQVAgfHwg
cnR3dmlmLT5wb3J0ID09IFJUV19QT1JUXzApDQoJCXJldHVybjsNCg0KUGluZy1LZSANCg0K

