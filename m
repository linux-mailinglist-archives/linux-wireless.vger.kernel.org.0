Return-Path: <linux-wireless+bounces-10540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243F93CC93
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 03:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56721F22199
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 01:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279911802E;
	Fri, 26 Jul 2024 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sCdbpKw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97864AD2C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959097; cv=none; b=nqkCMZD9xubiz1cIfK/df2Up4tMLa+FeQRkNwLMmgKHUk7OKWaAuz7XiCrSEj5Gq3uA2VtposmHncRc5KlvYQcbXuFp70XlknqJRxjWRNziRd9tZABaoLysGP/XB4VXSs0QQkpmcq8UoNAqEL59fxHbs72k7ZhH0C13UvRJpKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959097; c=relaxed/simple;
	bh=D+eTvbZ512xHoSgm2rQYoVChciCSc8flswPRX9ZpruA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gX5ZC99wTNjEWH0HUIePvRD+hEjOFGoDgzbpwgozi56X7oD0L6Pivp0XyXi/P8qF22bc4ABUn4kDrfTwx6V8bAoYRy8H3q4bcXJldsf4X6CJY3vkygkzF1q7RYCmq20l/PGl8KlbzzcjNjX1N/xSlnX6DEnau6mWSQWaEQsHlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sCdbpKw+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46Q1vX5b94122972, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721959053; bh=D+eTvbZ512xHoSgm2rQYoVChciCSc8flswPRX9ZpruA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sCdbpKw+3FRhpOogG225hcWJ+MfhUx2B1b1X/Frzppg2rUedwD/tf+olVErodcx7x
	 78Pn7B6kkuoNauH0PJHADG5fA2RX6dOAipKnv9O2SVD3Jg7m1PmEsz/SXjmmnoms78
	 uGH9cSiiWwbRxpmgI63M0PT2j4oQ8FdH6mpcgC/EAq+LdIDZ0j90MyQzNXiJBV1LDt
	 6Zu5rFop9ZzGRawkPwSwR0G1RtJLH1xYUFdFo7wu/O3jX4D8FH20DUfnmMt9lPXENL
	 qwvNFVYgaTzDpOzPcesL0cxSWhxHdzUx1Z2Sg1QX1bfm0zvZYskSe+MBJVGuRms1kL
	 6GnrBjA1bt9xw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46Q1vX5b94122972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 09:57:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 09:57:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jul 2024 09:57:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Jul 2024 09:57:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        kangyang
	<quic_kangyang@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 11/11] wifi: ath12k: delete mon reap timer
Thread-Topic: [PATCH 11/11] wifi: ath12k: delete mon reap timer
Thread-Index: AQHa3op7dKDzs7rtBUe0esVv8QOyB7IHn1wAgAChFWA=
Date: Fri, 26 Jul 2024 01:57:32 +0000
Message-ID: <52318022dbe745da8b18892c26d78bec@realtek.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-12-quic_kangyang@quicinc.com>
 <2a44b24b-f122-44de-a053-fee07753eb7e@quicinc.com>
In-Reply-To: <2a44b24b-f122-44de-a053-fee07753eb7e@quicinc.com>
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

SGkgSmVmZiwNCg0KSmVmZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPiB3cm90
ZToNCj4gDQo+IE9uIDcvMjUvMjAyNCA1OjAwIEFNLCBrYW5neWFuZyB3cm90ZToNCj4gPiBGcm9t
OiBLYW5nIFlhbmcgPHF1aWNfa2FuZ3lhbmdAcXVpY2luYy5jb20+DQo+ID4NCj4gPiBDdXJyZW50
bHkgbW9uIHJlYXAgdGltZXIgaXMgbm90IHVzZWQsIGFuZCBpdCBpcyBub3QgbmVlZGVkIGFueW1v
cmUuDQo+ID4NCj4gPiBTbyByZW1vdmUgcmVsYXRlZCBjb2RlLg0KPiA+DQo+ID4gVGVzdGVkLW9u
OiBXQ043ODUwIGh3Mi4wIFBDSSBXTEFOLkhNVC4xLjAuYzUtMDA0ODEtUUNBSE1UU1dQTF9WMS4w
X1YyLjBfU0lMSUNPTlotMw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZyBZYW5nIDxxdWlj
X2thbmd5YW5nQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9hdGgvYXRoMTJrL2NvcmUuaCB8ICAyIC0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0
aC9hdGgxMmsvZHAuYyAgIHwgMjUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDI3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvY29yZS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YXRoL2F0aDEyay9jb3JlLmgNCj4gPiBpbmRleCBkYWY3YzA0YmI3MjguLjgzZWY5MmVjZGMzOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2NvcmUuaA0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvY29yZS5oDQo+ID4gQEAg
LTg4OCw4ICs4ODgsNiBAQCBzdHJ1Y3QgYXRoMTJrX2Jhc2Ugew0KPiA+ICAgICAgIHN0cnVjdCBh
dGgxMmtfZGJyaW5nX2NhcCAqZGJfY2FwczsNCj4gPiAgICAgICB1MzIgbnVtX2RiX2NhcDsNCj4g
Pg0KPiA+IC0gICAgIHN0cnVjdCB0aW1lcl9saXN0IG1vbl9yZWFwX3RpbWVyOw0KPiA+IC0NCj4g
PiAgICAgICBzdHJ1Y3QgY29tcGxldGlvbiBodGNfc3VzcGVuZDsNCj4gPg0KPiA+ICAgICAgIHU2
NCBmd19zb2NfZHJvcF9jb3VudDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYXRoL2F0aDEyay9kcC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kcC5j
DQo+ID4gaW5kZXggNjFhYTc4ZDhiZDhjLi41NDdlY2I0MTk4MDkgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kcC5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kcC5jDQo+ID4gQEAgLTk3NCw4ICs5NzQsNiBAQCB2b2lk
IGF0aDEya19kcF9wZGV2X2ZyZWUoc3RydWN0IGF0aDEya19iYXNlICphYikNCj4gPiAgew0KPiA+
ICAgICAgIGludCBpOw0KPiA+DQo+ID4gLSAgICAgZGVsX3RpbWVyX3N5bmMoJmFiLT5tb25fcmVh
cF90aW1lcik7DQo+ID4gLQ0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBhYi0+bnVtX3JhZGlv
czsgaSsrKQ0KPiA+ICAgICAgICAgICAgICAgYXRoMTJrX2RwX3J4X3BkZXZfZnJlZShhYiwgaSk7
DQo+ID4gIH0NCj4gPiBAQCAtMTAyMCwyNyArMTAxOCw2IEBAIHZvaWQgYXRoMTJrX2RwX2hhbF9y
eF9kZXNjX2luaXQoc3RydWN0IGF0aDEya19iYXNlICphYikNCj4gPiAgICAgICAgICAgICAgIGFi
LT5oYWxfcnhfb3BzLT5yeF9kZXNjX2dldF9kZXNjX3NpemUoKTsNCj4gPiAgfQ0KPiA+DQo+ID4g
LXN0YXRpYyB2b2lkIGF0aDEya19kcF9zZXJ2aWNlX21vbl9yaW5nKHN0cnVjdCB0aW1lcl9saXN0
ICp0KQ0KPiA+IC17DQo+ID4gLSAgICAgc3RydWN0IGF0aDEya19iYXNlICphYiA9IGZyb21fdGlt
ZXIoYWIsIHQsIG1vbl9yZWFwX3RpbWVyKTsNCj4gPiAtICAgICBpbnQgaTsNCj4gPiAtDQo+ID4g
LSAgICAgZm9yIChpID0gMDsgaSA8IGFiLT5od19wYXJhbXMtPm51bV9yeGRtYV9wZXJfcGRldjsg
aSsrKQ0KPiA+IC0gICAgICAgICAgICAgYXRoMTJrX2RwX21vbl9wcm9jZXNzX3JpbmcoYWIsIGks
IE5VTEwsIERQX01PTl9TRVJWSUNFX0JVREdFVCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFUSDEyS19EUF9SWF9NT05JVE9SX01PREUpOw0KPiA+IC0NCj4g
PiAtICAgICBtb2RfdGltZXIoJmFiLT5tb25fcmVhcF90aW1lciwgamlmZmllcyArDQo+ID4gLSAg
ICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoQVRIMTJLX01PTl9USU1FUl9JTlRFUlZBTCkp
Ow0KPiA+IC19DQo+ID4gLQ0KPiA+IC1zdGF0aWMgdm9pZCBhdGgxMmtfZHBfbW9uX3JlYXBfdGlt
ZXJfaW5pdChzdHJ1Y3QgYXRoMTJrX2Jhc2UgKmFiKQ0KPiA+IC17DQo+ID4gLSAgICAgaWYgKGFi
LT5od19wYXJhbXMtPnJ4ZG1hMV9lbmFibGUpDQo+ID4gLSAgICAgICAgICAgICByZXR1cm47DQo+
ID4gLQ0KPiA+IC0gICAgIHRpbWVyX3NldHVwKCZhYi0+bW9uX3JlYXBfdGltZXIsIGF0aDEya19k
cF9zZXJ2aWNlX21vbl9yaW5nLCAwKTsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgaW50IGF0aDEya19k
cF9wZGV2X2FsbG9jKHN0cnVjdCBhdGgxMmtfYmFzZSAqYWIpDQo+ID4gIHsNCj4gPiAgICAgICBz
dHJ1Y3QgYXRoMTJrICphcjsNCj4gPiBAQCAtMTA1MSw4ICsxMDI4LDYgQEAgaW50IGF0aDEya19k
cF9wZGV2X2FsbG9jKHN0cnVjdCBhdGgxMmtfYmFzZSAqYWIpDQo+ID4gICAgICAgaWYgKHJldCkN
Cj4gPiAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+ID4gLSAgICAgYXRoMTJrX2RwX21v
bl9yZWFwX3RpbWVyX2luaXQoYWIpOw0KPiA+IC0NCj4gPiAgICAgICAvKiBUT0RPOiBQZXItcGRl
diByeCByaW5nIHVubGlrZSB0eCByaW5nIHdoaWNoIGlzIG1hcHBlZCB0byBkaWZmZXJlbnQgQUMn
cyAqLw0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBhYi0+bnVtX3JhZGlvczsgaSsrKSB7DQo+
ID4gICAgICAgICAgICAgICBhciA9IGFiLT5wZGV2c1tpXS5hcjsNCj4gDQoNCk5vdCBzdXJlIGlm
IHlvdSBzZW5kIG91dCB0aGlzIG1haWwgaW5jb21wbGV0ZWx5LiBMb3JlIFsxXSBkb2Vzbid0IGhh
dmUgY29tcGxldGUNCm1lc3NhZ2UgbmVpdGhlci4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXdpcmVsZXNzLzJhNDRiMjRiLWYxMjItNDRkZS1hMDUzLWZlZTA3NzUzZWI3ZUBx
dWljaW5jLmNvbS9ULyNtMTAxMWE4OTExMzAwOWExNGM5ZDQ1MGRiYTMxZDhkMTFkMzZiNWI2Yg0K
DQo=

