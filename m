Return-Path: <linux-wireless+bounces-19513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBACFA47082
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 01:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28FC3ADC6E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08727004C;
	Thu, 27 Feb 2025 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rjsSzk7n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF2270042
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617381; cv=none; b=g739ESQrzckEsRUAupVjzyyyd7BvF50oA4QynQOYnBYS6FcCTIO6KEKB4JT7Lu10yth72R+Z9VMwvP6mOj6RFrD+5Vw8b45LbZOLLCYy1oAEVJ6tDEGAZ+2uMERS4fb4oEjom/IVymFmku7vnN7F39U3YNIPhJ12ieP0JosCPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617381; c=relaxed/simple;
	bh=41YwnWzAsosbWZTxu6qsX9TvioeGDzY4xCdFeIpfrE4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyIl7cWB/+XRsu2xv87XKy4zMHbsQfl7ipUrHT04RXXk1W+1Ncdvd66rUs/cSG41lx3fZQIBpWGqAjajexyAOnDSp86/LraRAZ2BDkJqLcDCLFNanTUREGh3c2McAPk6CedOROiAPgl2piJt5V6VdlIIi6fDwg5yR+AHEbdT69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rjsSzk7n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51R0nWSg9814635, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740617372; bh=41YwnWzAsosbWZTxu6qsX9TvioeGDzY4xCdFeIpfrE4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rjsSzk7n0V6xLfG5uoRzyu8PQ2iEkykv5PRERnbBSmwr0BAmcuYHWXr2ua54HUJaT
	 tEaDyTKmuNHhxX+GQ3n3gnUIKw9/fBVFPETFLormUBZcfIFrXTFuuANzZFhbaDAMer
	 /a91IfZXFPiITPZGmP2JPUEktSg0i7zB1kKpLFVUnAGvDLUdgcsW4UIX7y6/kc0lb7
	 rGPGZK7sALduwXJ7+5PNeovDsXROUzv6Z0tsZG78SBBxDwTHLdNrcfsSo1Y73387sE
	 +Q+S+fV6Ju8hoouPVA9HMdrfojdxWRdOKhkgps+ndXwcacKFPRVoZEC72sT7xSTt2E
	 ezLC5o+HLKUuA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51R0nWSg9814635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 08:49:32 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 08:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 27 Feb 2025 08:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Thu, 27 Feb 2025 08:49:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Topic: [PATCH] wifi: rtlwifi: pci: Fix condition to wake the queues
Thread-Index: AQHbgk4F7yF1CrP6lkuUlCsBtIqcQLNOJM3ggAuSEYCAAKPqYA==
Date: Thu, 27 Feb 2025 00:49:33 +0000
Message-ID: <7306830ca082470d80f9a6d04329807c@realtek.com>
References: <0c91ac77-a652-4ab4-b911-e0a2386fb863@gmail.com>
 <1a11b3b765404ab0b64b0e0614e44ac9@realtek.com>
 <609560e0-8393-4feb-8153-0c6147598763@gmail.com>
In-Reply-To: <609560e0-8393-4feb-8153-0c6147598763@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OS8wMi8yMDI1IDA4OjIwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGUgVFggcXVldWVzIHNo
b3VsZCBiZSB3b2tlbiB3aGVuIHRoZXJlIGFyZSBhdCBsZWFzdCA0IGF2YWlsYWJsZQ0KPiA+PiBl
bnRyaWVzLCBub3Qgd2hlbiB0aGVyZSBhcmUgYXQgbW9zdCA0Lg0KPiA+Pg0KPiA+PiBUZXN0ZWQg
d2l0aCBSVEw4ODIxQUUuDQo+ID4+DQo+ID4+IEZpeGVzOiBkMDMxMTMxNGQwMDIgKCJydGx3aWZp
OiBydGw4MTkyZWU6IEZpeCBoYW5kbGluZyBvZiBuZXcgc3R5bGUgZGVzY3JpcHRvcnMiKQ0KPiA+
DQo+ID4gSSBhZ3JlZSB5b3VyIGNoYW5nZSBsb29rcyBtb3JlIHJlYXNvbmFibGUuIERpZCB5b3Ug
cmVhbGx5IG1lZXQgdGhlIGNhc2UNCj4gPiBhbmQgdGhpcyBwYXRjaCBzb2x2ZXMgaXQ/DQo+ID4N
Cj4gPiBCeSB0aGUgY2hhbmdlcyBvZiBkMDMxMTMxNGQwMDIsIEkgY2FuJ3QgcmVhbGx5IHVuZGVy
c3RhbmQgd2h5IHRoZSBpbml0aWFsDQo+ID4gdmVyc2lvbiBhbmQgdGhlIGNvbW1pdCBkby4gQ29u
c2lkZXJpbmcgdGhlIGNvbW1pdCAiZml4IiBzb21lIHNpdHVhdGlvbnMsDQo+ID4gSSBkb24ndCBr
bm93IGlmIHRoaXMgcGF0Y2ggd291bGQgYnJlYWsgdGhlbSBhZ2Fpbi4gQ291bGQgeW91IGxvb2sg
aW50bw0KPiA+IHJ0bHdpZmkgUENJIGZsb3cgZGVlcGVyIGFuZCBzaGFyZSB5b3VyIGlkZWFzPw0K
PiA+DQo+IA0KPiBJIHNhdyBzZXZlcmFsIHByb2JsZW1zIHdpdGggcnRsODgyMWFlIGJ1dCBJIGNh
bid0IHNheSBpZiB0aGlzDQo+IHBhdGNoIGZpeGVzIGFueSBvZiB0aGVtOg0KPiANCj4gLSBBZnRl
ciBhIGZldyBob3VycyBpdCByYW5kb21seSBzdG9wcyByZWNlaXZpbmcgYmVhY29ucyBhbmQgZGF0
YQ0KPiAgIGZyYW1lcyBmb3IgYXQgbGVhc3QgMTAgc2Vjb25kcyAoIkFQIG9mZiwgdHJ5IHRvIHJl
Y29ubmVjdCBub3ciDQo+ICAgaW4gZG1lc2cpLiBUaGVuIGl0IG1heSBvciBtYXkgbm90IGJlIGFi
bGUgdG8gcmVjb25uZWN0Lg0KDQpJcyBpbnRlcnJ1cHQgY291bnRlciBpbmNyZWFzaW5nIGluIC9w
cm9jL2ludGVycnVwdD8NCklmIG5vdCwgY2hlY2sgaWYgZHJpdmVyIElTUiAoaW50ZXJydXB0IHN0
YXR1cyByZWdpc3RlcikgbWFudWFsbHkgdG8gc2VlDQppZiBpdCByZWNlaXZlZCBkYXRhIGJ1dCBu
b3QgaXNzdWUgaW50ZXJydXB0IHRvIGhvc3QgcHJvcGVybHkuDQpIb3dldmVyLCBpZiBubyBhbnkg
b2YgdGhlc2UsIGl0IHdpbGwgYmUgV2lGaSBwcm9ibGVtLCBub3QgUENJLg0KDQpUbyBiaXNlY3Qg
V2lGaSBwcm9ibGVtLCB3ZSBtYXkgc3RvcCBkb2luZyBydGxfd2F0Y2hkb2dfd3FfY2FsbGJhY2so
KSB0bw0KYXZvaWQgY2hhbmdpbmcgcmVnaXN0ZXJzIGR5bmFtaWNhbGx5LiANCg0KPiANCj4gLSBT
b21ldGltZXMgdGhlIFRYIHNwZWVkIG1lYXN1cmVkIGJ5IGlwZXJmMyBpcyBsaW1pdGVkIHRvIH44
MCBNYnBzLg0KPiAgIE5vcm1hbGx5IGl0J3Mgb3ZlciAyNTAuDQoNCkkgc3VnZ2VzdCB0byBjaGVj
ayBQSFkgcmF0ZSBmaXJzdCBhbmQgTVNEVSBhZ2dyZWdhdGlvbiBieSBzbmlmZmVyLg0KTm90IHN1
cmUgaWYgcnRsd2lmaSBjYW4gYmUgbW9uaXRvciBtb2RlLCBidXQgdmVyeSBzdXJlIHJ0dzg4IGRv
ZXMuIA0KDQo+IA0KPiAtIFNvbWV0aW1lcyB0aGVyZSBhcmUgZHVwbGljYXRlIHBpbmdzOg0KPiAg
ICAgICAxOSBwYWNrZXRzIHRyYW5zbWl0dGVkLCAxNCByZWNlaXZlZCwgKzE1MSBkdXBsaWNhdGVz
LCAyNi4zMTU4JSBwYWNrZXQgbG9zcywgdGltZSAxODA5OG1zDQoNCkkgaGF2ZSBuZXZlciBkdWcg
dGhpcyBraW5kIG9mIHByb2JsZW0sIGJ1dCBJIHN1Z2dlc3QgdG8gY2hlY2sgc25pZmZlcg0KZmly
c3QuICANCg0KPiANCj4gLSBUZXN0aW5nIHRoZSBSWCBzcGVlZCB3aXRoIGlwZXJmMyBzb21ldGlt
ZXMgbWFrZXMgdGhlIG1vdXNlIGN1cnNvcg0KPiAgIHN0dXR0ZXIuIChJdCdzIHVzdWFsbHkgfjMw
MCBNYnBzLikNCg0KSWYgaGVyZSBpcyBCbHVldG9vdGggbW91c2UsIGl0IHdpbGwgYmUgYSBCVC1j
b2V4aXN0ZW5jZSBwcm9ibGVtLiBJZiBub3QsDQpJIGZlZWwgQ1BVIGJlY29tZXMgZXhoYXVzdGVk
IG9yIGh1Z2UgYW1vdW50IG9mIGludGVycnVwdHMgYXQgdGhhdCB0aW1lLg0KDQo+IA0KPiBJIGRv
bid0IGtub3cgaG93IHRvIHJlcHJvZHVjZSBhbnkgb2YgdGhlc2UuDQoNCklmIHVzZXJzIHdhbnQv
Y2FuIGhlbHAgdG8gZGlnIHByb2JsZW0sIHBsZWFzZSB0cnkgYWJvdmUgc3VnZ2VzdGlvbnMuIA0K
DQoNCg==

