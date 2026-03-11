Return-Path: <linux-wireless+bounces-32942-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF07J0bQsGmLnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32942-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:15:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569A25AD35
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2697F3066CF3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF3275114;
	Wed, 11 Mar 2026 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XcCGZk/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC6230BD9;
	Wed, 11 Mar 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195323; cv=none; b=F4JotDkXgPUdzWg72u5C/sWxIjN7Homp9uAhbJHDovYFM29iuLR6jVQpFh4/MplPSt70g4M0zkgnZ/NM51axbjcJ6fUnuyescrcHsbyCxnpCw1t9jdxLTDwNjOWT7qNG7gEI1LoygmPNwc6HmuYpD3YOPmKhSljTSB74j2jOs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195323; c=relaxed/simple;
	bh=ZhQJnz7q3G15MqbiGu1sYp13eUahdBQbRUgZwZxAjWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbdw6QFNaKaIkRwnwNa5PlhVne3egA1Cqwi5rsOvGjBF28UlY5XHcuVG5E/dtvdNgopBzkqsEBhT2/hhyOGDK4afOJf251KWUUVj/F/beqoxdqdaliwyhFiZN23P1VZ3nuLq47JQlDqEj7+NTWRxNYYU1E9HSBbPE8NdZw+CNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XcCGZk/u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62B2FIpI43711022, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773195318; bh=ZhQJnz7q3G15MqbiGu1sYp13eUahdBQbRUgZwZxAjWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XcCGZk/umM0GpOPFclgPH9ABA2ffRcZGnOlCUcdBkZ5VIJLmNnHXtfgzlX/91ERfO
	 vmNiTg699/3u42ttuSRFq4fd0wjG/fMUpmximDf/6DHA9nziMTJ9tpdvQXr0ZchsAk
	 I7uIMO/CMQU0pKji7O1mow6Y8pvOe8JXl2gWvgP7bk2zWRvU8KAG5Nk5m/LYn7+IRI
	 DBUHcTH21626pSMEq+3uAPTKi/aaLVfv3ZaOIVdJZrufNs9Cb4ToXKFKV4k0kigP8d
	 uPX9LSxmx1T1+fepGh4FG0kM5r4qQIuKI4+5sobRoIiCzUTtFHONufm2Kszb/kvsEc
	 +F7yri9qSnfyA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62B2FIpI43711022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:15:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Mar 2026 10:15:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Mar 2026 10:15:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAA==
Date: Wed, 11 Mar 2026 02:15:18 +0000
Message-ID: <792645eed36041f0b3df951f1b28a08a@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
In-Reply-To: <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 2569A25AD35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32942-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Action: no action

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGkgUGluZy1LZSwNCj4gDQo+
IFRoYW5rIHlvdSBmb3IgdGhlIGluY3JlZGlibHkgZmFzdCByZXNwb25zZSBhbmQgYXNzaXN0YW5j
ZSENCj4gDQo+ID4gQ2FuIHlvdSBkaWcga2VybmVsIGxvZyAoYnkgbmV0Y29uc29sZSBvciByYW1v
b3BzKSBpZiBzb21ldGhpbmcgdXNlZnVsPw0KPiA+IEknZCBsaWtlIHRvIGtub3cgdGhpcyBpcyBo
YXJkd2FyZSBsZXZlbCBmcmVlemUgb3Iga2VybmVsIGNhbiBjYXB0dXJlIHNvbWV0aGluZw0KPiB3
cm9uZy4NCj4gDQo+IEkgbWFuYWdlZCB0byBwdWxsIGEgY2FsbCB0cmFjZSBmcm9tIGEgaGlzdG9y
aWMgam91cm5hbGQgbG9nIGp1c3QNCj4gYmVmb3JlIHRoZSBzeXN0ZW0gaHVuZy4gVGhlIGtlcm5l
bCBnZXRzIHRyYXBwZWQgaW4gYW4gSVJRIHRocmVhZA0KPiBpbnNpZGUgYHJ0d19wY2lfaW50ZXJy
dXB0X3RocmVhZGZuYCwgY2FsbGluZyB1cCBpbnRvIGBtYWM4MDIxMWANCj4gYGllZWU4MDIxMV9y
eF9saXN0YCBiZWZvcmUgZXZlcnl0aGluZyBmcmVlemVzLiBIZXJlIGlzIHRoZSByZWxldmFudA0K
PiBzbmlwcGV0Og0KPiANCj4gYGBgdGV4dA0KPiBDYWxsIFRyYWNlOg0KPiA8SVJRPg0KPiA/IF9f
YWxsb2Nfc2tiKzB4MjNhLzB4MmEwDQo+ID8gX19hbGxvY19za2IrMHgxMGMvMHgyYTANCj4gPyBf
X3BmeF9pcnFfdGhyZWFkX2ZuKzB4MTAvMHgxMA0KPiBbIC4uLiB0cnVuY2F0ZWQgbW9kdWxlIGxp
c3QgLi4uIF0NCj4gVGFpbnRlZDogRyBXIEkgNi4xOS42LTItY2FjaHlvcyAjMSBQUkVFTVBUKGZ1
bGwpDQo+IEhhcmR3YXJlIG5hbWU6IEhQIEhQIE5vdGVib29rLzgxRjAsIEJJT1MgRi41MCAxMS8y
MC8yMDIwDQo+IFJJUDogMDAxMDppZWVlODAyMTFfcnhfbGlzdCsweDEwMTIvMHgxMDIwIFttYWM4
MDIxMV0NCj4gQ1BVOiAyIFVJRDogMCBQSUQ6IDc2NSBDb21tOiBpcnEvNTYtcnR3ODhfcGMNCj4g
cnR3X3BjaV9pbnRlcnJ1cHRfdGhyZWFkZm4rMHgyMzkvMHgzMTAgW3J0dzg4X3BjaV0NCj4gYGBg
DQo+IA0KPiBJdCBiZWhhdmVzIGV4YWN0bHkgbGlrZSBhIFBDSWUgYnVzIGRlYWRsb2NrIG9yIGEg
aGFyZHdhcmUgZmF1bHQgdGhhdA0KPiBldmVudHVhbGx5IGJyaW5ncyBkb3duIHRoZSBDUFUgaGFu
ZGxpbmcgdGhlIElSUS4NCg0KSSB3b25kZXIgaWYgdGhlcmUgaXMgYSBtYWxmb3JtZWQgZGF0YSwg
Y2F1c2luZyB0aGlzIHRyYWNlIGFuZCB0aGUgbGVhZHMNCmtlcm5lbCBmcmVlemVzLiBJZiB3ZSBj
YW4gZG8gdmFsaWRhdGlvbiBvbiBSWCBkYXRhIGJlZm9yZSBjYWxsaW5nIA0KaWVlZTgwMjExX3J4
X2xpc3QoKSwgbWF5YmUgdHJhY2UgZGlzYXBwZWFycyBhbmQgZXZlcnl0aGluZyB3aWxsIGJlIGZp
bmU/DQpFdmVuIG5vIG5lZWQgd29ya2Fyb3VuZC4NCg0KPiANCj4gPiBBcmUgdGhlc2UgdG90YWxs
eSBuZWVkZWQgdG8gd29ya2Fyb3VuZCB0aGUgcHJvYmxlbT8gT3IgZGlzYWJsZV9hc3BtIGlzIGVu
b3VnaD8NCj4gPiBJJ2QgbGlzdCB0aGVtIGluIG9yZGVyIG9mIHBvd2VyIGNvbnN1bXB0aW9uIGlt
cGFjdDoNCj4gPiAxLiBkaXNhYmxlX2FzcG09eQ0KPiA+IDIuIGRpc2FibGVfbHBzX2RlZXA9eQ0K
PiA+IDMuIGRpc2FibGUgV2lGaSBwb3dlciBzYXZlDQo+IA0KPiBUbyB2ZXJpZnkgd2hpY2ggcGFy
YW1ldGVycyBhcmUgc3RyaWN0bHkgbmVjZXNzYXJ5LCBJIHBlcmZvcm1lZA0KPiBpc29sYXRlZCB0
ZXN0aW5nIHRvZGF5LiBJIGVuc3VyZWQgbm8gb3RoZXIgbW9kcHJvYmUgY29uZmlncyB3ZXJlDQo+
IGFjdGl2ZSwgcmVidWlsdCB0aGUgaW5pdHJhbWZzLCBhbmQgbWFudWFsbHkgZW5mb3JjZWQgdGhh
dA0KPiBgd2lmaS5wb3dlcnNhdmVgIHdhcyBhY3RpdmUgdmlhIGBpdyBkZXYgd2xhbjAgc2V0IHBv
d2VyX3NhdmUgb25gDQo+IGR1cmluZyBhbGwgdGVzdHMgKGFzIHRoZSBPUyBwb3dlciBtYW5hZ2Vt
ZW50IHByb2ZpbGVzIHdlcmUgZGVmYXVsdGluZw0KPiBpdCB0byBvZmYsIHdoaWNoIGluaXRpYWxs
eSBtYXNrZWQgdGhlIGlzc3VlKS4NCj4gDQo+IEkgdGVzdGVkIGVhY2ggd29ya2Fyb3VuZCBpbmRp
dmlkdWFsbHkgYWNyb3NzIG11bHRpcGxlIHNsZWVwL3dha2UNCj4gY3ljbGVzIGFuZCBhY3RpdmUg
dXNhZ2U6DQo+IA0KPiAqKlRlc3QgMSAoQVNQTSBEaXNhYmxlZCwgTFBTIERlZXAgRW5hYmxlZCk6
KioNCj4gLSBLZXJuZWwgcGFyYW1ldGVyczogYHJ0dzg4X3BjaSBkaXNhYmxlX2FzcG09eWAgKGFu
ZCBgcnR3ODhfY29yZQ0KPiBkaXNhYmxlX2xwc19kZWVwPW5gKQ0KPiAtIFJlc3VsdDogU3RhYmxl
LiBObyBmcmVlemVzIHdlcmUgb2JzZXJ2ZWQgZHVyaW5nIHVzYWdlIG9yIHRyYW5zaXRpb25zDQo+
IGludG8vb3V0IG9mIFMzIHNsZWVwIHdoaWxlIHBvd2VyIHNhdmluZyB3YXMgZW5mb3JjZWQuDQo+
IA0KPiAqKlRlc3QgMiAoQVNQTSBFbmFibGVkLCBMUFMgRGVlcCBEaXNhYmxlZCk6KioNCj4gLSBL
ZXJuZWwgcGFyYW1ldGVyczogYHJ0dzg4X2NvcmUgZGlzYWJsZV9scHNfZGVlcD15YCAoYW5kIGBy
dHc4OF9wY2kNCj4gZGlzYWJsZV9hc3BtPW5gKQ0KPiAtIFJlc3VsdDogU3RhYmxlLiBObyBmcmVl
emVzIHdlcmUgb2JzZXJ2ZWQgdW5kZXIgdGhlIHNhbWUgZm9yY2VkIHBvd2VyDQo+IHNhdmUgY29u
ZGl0aW9ucy4NCj4gDQo+ICoqQ29uY2x1c2lvbjoqKiBJdCBhcHBlYXJzIHdlIGRvIG5vdCBuZWVk
IGJvdGggd29ya2Fyb3VuZHMNCj4gc2ltdWx0YW5lb3VzbHkgZm9yIHRoaXMgc3BlY2lmaWMgaGFy
ZHdhcmUuIFVzaW5nIG9ubHkgYGRpc2FibGVfYXNwbT15YA0KPiBzZWVtcyB0byBiZSBzdWZmaWNp
ZW50IHRvIHByZXZlbnQgdGhlIHN5c3RlbSBmcmVlemUuIEdpdmVuIHlvdXIgbm90ZQ0KPiBhYm91
dCB0aGUgcG93ZXIgY29uc3VtcHRpb24gaW1wYWN0IHJhbmtpbmcsIHRoaXMgbG9va3MgbGlrZSB0
aGUNCj4gb3B0aW1hbCBwYXRoIGZvcndhcmQuDQoNCkxldCdzIHRlc3QgbXkgUkZUIHBhdGNoIHRv
IGRpc2FibGUgQVNQTSB0aGVuLg0KDQo+IA0KPiA+IEJ1dCB3aGF0IGRvZXMgJ2RlYWRsb2NrJyBt
ZWFuPyBBcyBJIGtub3cgTkFQSSBwb2xsIGlzIHNjaGVkdWxlZCBieSBJU1IsDQo+ID4gYW5kIGdv
aW5nIHRvIHJlY2VpdmUgcGFja2V0cy4gVGhlIHJ4X25vX2FzcG0gd29ya2Fyb3VuZCBpcyB0byBm
b3JjZWx5IHR1cm4NCj4gPiBvZmYgQVNQTSBkdXJpbmcgdGhpcyBwZXJpb2QuDQo+IA0KPiBCeSAi
ZGVhZGxvY2siIEkgbWVhbnQgYSBoYXJkd2FyZS1sZXZlbCBidXMgbG9ja3VwLiBJdCBzZWVtcyB0
aGUNCj4gcGh5c2ljYWwgUlRMODgyMUNFIGNoaXAgaXRzZWxmIGNyYXNoZXMgb3IgaGFuZ3MgdGhl
IHN5c3RlbSdzIFBDSWUgYnVzDQo+IHdoZW4gdHJ5aW5nIHRvIG5lZ290aWF0ZSB3YWtpbmcgdXAg
ZnJvbSBBU1BNIEwxIHdoaWxlIHNpbXVsdGFuZW91c2x5DQo+IGV4aXN0aW5nIGluIGBMUFNfREVF
UF9NT0RFX0xDTEtgLiBUaGUgYHJ4X25vX2FzcG1gIHdvcmthcm91bmQgaW4gTkFQSQ0KPiBoZWxw
cyBkdXJpbmcgYWN0aXZlIFJ4IGRlY29kaW5nLCBidXQgdGhlIGxhcHRvcCBvZnRlbiBmcmVlemVz
IHdoaWxlDQo+IGNvbXBsZXRlbHkgaWRsZSwgcHJlc3VtYWJseSB3aGVuIHRoZSBBUCBzZW5kcyBh
IGJhc2ljIGJlYWNvbiwgdGhlIGNoaXANCj4gYXR0ZW1wdHMgdG8gbGVhdmUgTFBTIERlZXAgKyBM
MSwgYW5kIHRoZSBoYXJkd2FyZSBzaW1wbHkgZ2l2ZXMgdXAgYW5kDQo+IGhhbHRzIHRoZSBzeXN0
ZW0uDQoNCkkgdGhpbmsgdGhpcyBpcyB5b3VyIHBlcnNwZWN0aXZlIGFuZCBpbmR1Y3Rpb24sIHJp
Z2h0PyBEaWQgeW91IG1lYXN1cmUNCnJlYWwgaGFyZHdhcmUgc2lnbmFscz8NCg0KTXkgcG9pbnQg
aXMgdGhhdCBpZiB0aGlzIGlzIGEgaGFyZHdhcmUtbGV2ZWwgYnVzIGxvY2t1cCwgbGV0J3MgYXBw
bHkNCnF1aXJrLiBJZiBzb21lIG1hbGZvcm1lZCBkYXRhIGNhdXNpbmcga2VybmVsIGhhbmdzLCBJ
J2QgYWRkIHNhbml0eSBjaGVjaw0Kb24gUlggZGF0YSwgYnV0IEkgZG9uJ3QgYWN0dWFsbHkga25v
dyB3aGF0IHdlIHNob3VsZCBjaGVjayBmb3Igbm93LiANCg0KPiANCj4gPiBXZSBoYXZlIG5vdCBt
b2RpZmllZCBSVEw4ODIxQ0UgZm9yIGEgbG9uZyB0aW1lLCBzbyBJJ2QgYWRkIHdvcmthcm91bmQN
Cj4gPiB0byBzcGVjaWZpYyBwbGF0Zm9ybSBhcyBtZW50aW9uZWQgYWJvdmUuDQo+IA0KPiBBZGRp
bmcgYSBETUkvcGxhdGZvcm0gcXVpcmsgc3BlY2lmaWNhbGx5IGZvciB0aGlzIGxhcHRvcCB0byBk
aXNhYmxlDQo+IEFTUE0gd291bGQgYmUgd29uZGVyZnVsIGFuZCBkZWVwbHkgYXBwcmVjaWF0ZWQu
IEkgYWdyZWUgaXQgaXMgc2FmZXINCj4gdGhhbiB0b3VjaGluZyB0aGUgZ2xvYmFsIGZsYWdzIGZv
ciBoYXJkd2FyZSB0aGF0IGlzIGZ1bmN0aW9uaW5nDQo+IGNvcnJlY3RseSBvdXQgaW4gdGhlIHdp
bGQuDQo+IA0KPiBIZXJlIGlzIHRoZSBleGFjdCBpZGVudGlmeWluZyBpbmZvcm1hdGlvbiBmb3Ig
bXkgc3lzdGVtOg0KPiANCj4gU3lzdGVtIFZlbmRvcjogSFANCj4gUHJvZHVjdCBOYW1lOiBIUCBO
b3RlYm9vaw0KPiBTS1UgTnVtYmVyOiBQM1M5NUVBI0FDQg0KPiBGYW1pbHk6IDEwM0NfNTMzNUtW
DQo+IFBDSSBJRDogMTBlYzpjODIxDQo+IFN1YnN5c3RlbSBJRDogMTAzYzo4MzFhDQo+IA0KPiBJ
IGFtIGNvbXBsZXRlbHkgcmVhZHkgdG8gdGVzdCBhbnkgcGF0Y2ggb3IgcXVpcmsgeW91IHNlbmQg
bXkgd2F5Lg0KPiBUaGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciB0aW1lIGFuZCBoZWxwaW5nIHRy
YWNrIHRoaXMgZG93biENCg0KSSBzZW50IGEgUkZUIFsxXSBmb3IgdGVzdC4gUGxlYXNlIGNoZWNr
IGlmIGl0IHdvcmtzIG9uIHlvdXIgSFAgbm90ZWJvb2suDQpJZiB5b3UgY2hlY2sgcnR3ODggbG9n
LCB5b3UgY2FuIHNlZSBJIGFkZGVkIHNpbWlsYXIgcGF0Y2ggNSB5ZWFycyBhZ28sDQphbmQgcmVw
bGFjZWQgYnkgcHJlZmVycmVkIHRoZSBjaGFuZ2Ugb2YgInJ0d3BjaS0+cnhfbm9fYXNwbSIsIHdo
aWNoIEkNCnRoaW5rIGl0IGNhbiBvbmx5IHJlc29sdmUgcHJvYmxlbSBvbiBwYXJ0aWFsIG5vdGVi
b29rcyB0aG91Z2guLi4uIA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2ly
ZWxlc3MvMjAyNjAzMTEwMjA4MTYuNzA2NS0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNClBp
bmctS2UNCg0KDQo=

