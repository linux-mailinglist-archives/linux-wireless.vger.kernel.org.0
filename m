Return-Path: <linux-wireless+bounces-32728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOc0KRYyrmlrAQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 03:36:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C614233532
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 03:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5352F3007BBD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15179155326;
	Mon,  9 Mar 2026 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GosIe82Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F6217659;
	Mon,  9 Mar 2026 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023764; cv=none; b=GaIMmQ7VafOfd//eIc3z2sVp9LSx/GSpaL7P/S3wtd1U1SVtVqOekIXB1UO920TU1GtkQEwhnVta/ZmJgvPWr+Gg1/wadPbJIZZfb8ob70lt+xGIj6i0ASmWnAYbA5Ui7lsQLHgpq8K72tUyjoKE69xj7Q/A6gw3/ePbOWPiR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023764; c=relaxed/simple;
	bh=nD1kyR4QAtPsmTD3QkZy97z5Z4Smh82BSXEUNOyU2uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhyZnfPfUtcXyHyug8nSdZlGbspy/3kHjoF3ZKy3CkiE/hIilxpZxkxX3hIgPHTpT3GjQQ8SR7IEAyPpaoGo0kHPQNDXAlOF6pbi1T/DcZsYjjzNKkC3/o5wceAX4iGVpbWhtatF1VNzs9yelFan3jr+3cvukJsEUNC5MQDS4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GosIe82Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6292ZwrM63904008, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773023758; bh=nD1kyR4QAtPsmTD3QkZy97z5Z4Smh82BSXEUNOyU2uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GosIe82Y1ESi97ne1Vs+0uAmzlyuQZKvjKUGUjh0csgLrFNLsaoXUGlo0jsV736lM
	 jGu2+8wkJ4P+aQKXV7Y29ci4FtEKaEd39LFwDPJ3Tmcg56tyanNSpPfccKykU19DUq
	 5Pldpb2rXuVr+tgykJieurekYRSLcmCm+h8VriNgrh0ysb9z1GeBLIKl2LhGKf07o8
	 RYNvWdKgXZ5XzfPWgxjk+fSZ3l4Zxp2XfjGf6YTF60p5Mx7XOjeD+MV/Lohp4jct1f
	 wd9Bia1Kzzdoelp+wnCdPSXukcOqfbSpKZaCc8/AXXmdtZskTmbgwoVA7IYNfDTnaL
	 xVM0sVZ6ck1LQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6292ZwrM63904008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 10:35:58 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Mar 2026 10:35:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Mar 2026 10:35:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Mar 2026 10:35:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q//99hoCAAIbrQP//fzIAgAtGLdA=
Date: Mon, 9 Mar 2026 02:35:56 +0000
Message-ID: <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
In-Reply-To: <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
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
X-Rspamd-Queue-Id: 4C614233532
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32728-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Q2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBPbiAyIE1hciAyMDI2LCBhdCAxMDowNOKAr2FtLCBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5z
aGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+PiBPbiAyIE1hciAyMDI2LCBhdCA5OjQ34oCv
YW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+
PiBDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4+Pj4gT24gUmFkeGEgUm9jayA1QiB3aXRoIGEgUlRMODg1MkJFIGNvbWJvIFdpRmkvQlQgY2Fy
ZCwgdGhlIGVmdXNlDQo+ID4+Pj4gcGh5c2ljYWwgbWFwIGR1bXAgaW50ZXJtaXR0ZW50bHkgZmFp
bHMgd2l0aCAtRUJVU1kgZHVyaW5nIHByb2JlLg0KPiA+Pj4+IFRoZSBmYWlsdXJlIG9jY3VycyBp
biBydHc4OV9kdW1wX3BoeXNpY2FsX2VmdXNlX21hcF9kZHYoKSB3aGVyZQ0KPiA+Pj4+IHJlYWRf
cG9sbF90aW1lb3V0X2F0b21pYygpIHRpbWVzIG91dCB3YWl0aW5nIGZvciB0aGUgQl9BWF9FRl9S
RFkNCj4gPj4+PiBiaXQgYWZ0ZXIgMSBzZWNvbmQuDQo+ID4+Pg0KPiA+Pj4gSSdtIGNoZWNraW5n
IGludGVybmFsbHkgaG93IHdlIGhhbmRsZSB0aGlzIGNhc2UuDQoNClNvcnJ5IGZvciB0aGUgbGF0
ZS4gDQoNCldlIGVuY291bnRlcmVkIFdpRmkvQlQgcmVhZGluZyBlZnVzZSBhdCB0aGUgc2FtZSB0
aW1lIGNhdXNpbmcgc2ltaWxhcg0KcHJvYmxlbSBhcyB5b3Vycy4gVGhlIHdvcmthcm91bmQgaXMg
bGlrZSB5b3Vycywgd2hpY2ggYWRkcyB0aW1lb3V0IA0KdGltZS4NCg0KPiA+Pj4NCj4gPj4+IFsu
Li5dDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4gRm9yIGNvbnRleHQsIGZpcm13YXJlIGFsc28gZmFp
bHMgKGFuZCByZWNvdmVycykgc29tZXRpbWVzOg0KPiA+Pj4NCj4gPj4+IERpZCB5b3UgbWVhbiB0
aGlzIGRvZXNuJ3QgYWx3YXlzIGhhcHBlbj8gc29tZXRpbWVzPw0KPiA+Pg0KPiA+PiBJdOKAmXMg
YW5vdGhlciBpbnRlcm1pdHRlbnQgYmVoYXZpb3VyIG9ic2VydmVkIG9uIHRoaXMgYm9hcmQgKGFu
ZCBub3QNCj4gPj4gcmVsYXRlZCB0byB0aGUgaXNzdWUgdGhpcyBwYXRjaCB0YXJnZXRzKS4gSXQg
b2NjdXJzIGxlc3MgZnJlcXVlbnRseQ0KPiA+PiB0aGFuIHRoZSBlZnVzZSBpc3N1ZSBhbmQgdGhl
IGV4aXN0aW5nIHJldHJ5IG1lY2hhbmlzbSBpbiB0aGUgZHJpdmVyDQo+ID4+IGVuc3VyZXMgZmly
bXdhcmUgbG9hZCBhbHdheXMgc3VjY2VlZHMuDQoNClRoaXMgbWlnaHQgYmUgdGhlIHNhbWUgY2F1
c2UgZHVlIHRvIHJlYWRpbmcgZWZ1c2UgaW4gZmlybXdhcmUuIA0KDQpUaG91Z2ggd2UgY2FuIGFk
ZCBtb3JlIHRpbWVvdXQgYW5kIHJldHJ5IHRpbWVzIGFzIHdvcmthcm91bmQsIEkgd29uZGVyDQpp
ZiB5b3UgY2FuIGNvbnRyb2wgbG9hZGluZyB0aW1lIG9mIFdpRmkgYW5kIEJUIGtlcm5lbCBtb2R1
bGVzPyANCg0KTW9yZSwgY2FuIHlvdSBkbyBleHBlcmltZW50IHRoYXQgeW91IGxvYWQgQlQgbW9k
dWxlIGZpcnN0LCBhbmQgdGhlbiBsb2FkDQpXaUZpIG1vZHVsZSBhZnRlciAxMCBzZWNvbmRzIChj
aG9vc2UgYSBsYXJnZSBudW1iZXIgaW50ZW50aW9uYWxseSwgb3INCmV2ZW4gbGFyZ2VyKT8NCg0K
UGluZy1LZQ0KDQo=

