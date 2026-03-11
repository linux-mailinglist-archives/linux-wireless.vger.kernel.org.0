Return-Path: <linux-wireless+bounces-32944-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKcjIjLSsGmLnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32944-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:23:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E877025AE8C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E18E0303B7DF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFA40DFB7;
	Wed, 11 Mar 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="T//OC5eU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07D4A3C;
	Wed, 11 Mar 2026 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195755; cv=none; b=uthQ5jWzAsefiSARU2gITD3dengGC/5E5i0nLm+D0fJFbaps9BHQPMk6I6sfapUjEhJ6W2DfBqdl8HzIv+r8q54+KGfiU2uV8No1pSTed71WMq/2KhjW9tVGqAc+n16qnAAemyHAjzgEE/FItNbTw5CLLFMy1XGpzq8mIOGvtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195755; c=relaxed/simple;
	bh=I7aQxYS3QBMVjw60yFS1mIuLkOnkWYvGi+vECKv7xyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3pmRCOKLNuQ6+iKx0K+vRgHoKJI+EbPi8ZmE/3f3BEfTd4nbOTX8vSUIZ4T1zgircNZYSZgF2QSmoFOy6KbA7Gaq1Pk+FsSerlLD9iJn9Ow+E/pGBoemAqU4ysc/McafwussghoHtcbYwBN5Wnbe9RPvY9vlW2b3Ji1W6gLyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T//OC5eU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62B2MU3o83718373, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773195750; bh=I7aQxYS3QBMVjw60yFS1mIuLkOnkWYvGi+vECKv7xyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=T//OC5eUk80SU6PpluRNiIZB+BvTDbu7VTUqM7FDkKrb5okgKiLZ5F9jMeXOnbuDv
	 8bdf/24nLbhMJLmpevgAguiyt+Mq44sS1ZWtC7YBBqJiJmu1o7hoNcD7HWDbVUQYeh
	 F8LQLSMu33nkp2h9JJk6yUxGJl0DYOA9LT7LAXIN4Bwgk0b67VedyCX/hfp0vVeWrP
	 //svtgZVovDa3FQIGxVhUYEj1zqmM5yHyglAbzwYA9eUxmhhGtVGfTiLpho8NIZLz0
	 rMPbahWdUB2qZgruwsO/bM5CpOfnMh6c+o6HTj5tB+KW1fVqRCftJyKWrw8oFJ2zaz
	 PSo32+TJRjn+Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62B2MU3o83718373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:22:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Mar 2026 10:22:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Mar 2026 10:22:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mA
Date: Wed, 11 Mar 2026 02:22:28 +0000
Message-ID: <e6720993c8c14245981432cfa4ae902b@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com>
In-Reply-To: <792645eed36041f0b3df951f1b28a08a@realtek.com>
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
X-Rspamd-Queue-Id: E877025AE8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32944-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gTEIgRiA8Z29h
aW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUGluZy1LZSwNCj4gPg0KPiA+IFRo
YW5rIHlvdSBmb3IgdGhlIGluY3JlZGlibHkgZmFzdCByZXNwb25zZSBhbmQgYXNzaXN0YW5jZSEN
Cj4gPg0KPiA+ID4gQ2FuIHlvdSBkaWcga2VybmVsIGxvZyAoYnkgbmV0Y29uc29sZSBvciByYW1v
b3BzKSBpZiBzb21ldGhpbmcgdXNlZnVsPw0KPiA+ID4gSSdkIGxpa2UgdG8ga25vdyB0aGlzIGlz
IGhhcmR3YXJlIGxldmVsIGZyZWV6ZSBvciBrZXJuZWwgY2FuIGNhcHR1cmUgc29tZXRoaW5nDQo+
ID4gd3JvbmcuDQo+ID4NCj4gPiBJIG1hbmFnZWQgdG8gcHVsbCBhIGNhbGwgdHJhY2UgZnJvbSBh
IGhpc3RvcmljIGpvdXJuYWxkIGxvZyBqdXN0DQo+ID4gYmVmb3JlIHRoZSBzeXN0ZW0gaHVuZy4g
VGhlIGtlcm5lbCBnZXRzIHRyYXBwZWQgaW4gYW4gSVJRIHRocmVhZA0KPiA+IGluc2lkZSBgcnR3
X3BjaV9pbnRlcnJ1cHRfdGhyZWFkZm5gLCBjYWxsaW5nIHVwIGludG8gYG1hYzgwMjExYA0KPiA+
IGBpZWVlODAyMTFfcnhfbGlzdGAgYmVmb3JlIGV2ZXJ5dGhpbmcgZnJlZXplcy4gSGVyZSBpcyB0
aGUgcmVsZXZhbnQNCj4gPiBzbmlwcGV0Og0KPiA+DQo+ID4gYGBgdGV4dA0KPiA+IENhbGwgVHJh
Y2U6DQo+ID4gPElSUT4NCj4gPiA/IF9fYWxsb2Nfc2tiKzB4MjNhLzB4MmEwDQo+ID4gPyBfX2Fs
bG9jX3NrYisweDEwYy8weDJhMA0KPiA+ID8gX19wZnhfaXJxX3RocmVhZF9mbisweDEwLzB4MTAN
Cj4gPiBbIC4uLiB0cnVuY2F0ZWQgbW9kdWxlIGxpc3QgLi4uIF0NCj4gPiBUYWludGVkOiBHIFcg
SSA2LjE5LjYtMi1jYWNoeW9zICMxIFBSRUVNUFQoZnVsbCkNCj4gPiBIYXJkd2FyZSBuYW1lOiBI
UCBIUCBOb3RlYm9vay84MUYwLCBCSU9TIEYuNTAgMTEvMjAvMjAyMA0KPiA+IFJJUDogMDAxMDpp
ZWVlODAyMTFfcnhfbGlzdCsweDEwMTIvMHgxMDIwIFttYWM4MDIxMV0NCj4gPiBDUFU6IDIgVUlE
OiAwIFBJRDogNzY1IENvbW06IGlycS81Ni1ydHc4OF9wYw0KPiA+IHJ0d19wY2lfaW50ZXJydXB0
X3RocmVhZGZuKzB4MjM5LzB4MzEwIFtydHc4OF9wY2ldDQo+ID4gYGBgDQo+ID4NCj4gPiBJdCBi
ZWhhdmVzIGV4YWN0bHkgbGlrZSBhIFBDSWUgYnVzIGRlYWRsb2NrIG9yIGEgaGFyZHdhcmUgZmF1
bHQgdGhhdA0KPiA+IGV2ZW50dWFsbHkgYnJpbmdzIGRvd24gdGhlIENQVSBoYW5kbGluZyB0aGUg
SVJRLg0KPiANCj4gSSB3b25kZXIgaWYgdGhlcmUgaXMgYSBtYWxmb3JtZWQgZGF0YSwgY2F1c2lu
ZyB0aGlzIHRyYWNlIGFuZCB0aGUgbGVhZHMNCj4ga2VybmVsIGZyZWV6ZXMuIElmIHdlIGNhbiBk
byB2YWxpZGF0aW9uIG9uIFJYIGRhdGEgYmVmb3JlIGNhbGxpbmcNCj4gaWVlZTgwMjExX3J4X2xp
c3QoKSwgbWF5YmUgdHJhY2UgZGlzYXBwZWFycyBhbmQgZXZlcnl0aGluZyB3aWxsIGJlIGZpbmU/
DQo+IEV2ZW4gbm8gbmVlZCB3b3JrYXJvdW5kLg0KPiANCj4gPg0KPiA+ID4gQXJlIHRoZXNlIHRv
dGFsbHkgbmVlZGVkIHRvIHdvcmthcm91bmQgdGhlIHByb2JsZW0/IE9yIGRpc2FibGVfYXNwbSBp
cyBlbm91Z2g/DQo+ID4gPiBJJ2QgbGlzdCB0aGVtIGluIG9yZGVyIG9mIHBvd2VyIGNvbnN1bXB0
aW9uIGltcGFjdDoNCj4gPiA+IDEuIGRpc2FibGVfYXNwbT15DQo+ID4gPiAyLiBkaXNhYmxlX2xw
c19kZWVwPXkNCj4gPiA+IDMuIGRpc2FibGUgV2lGaSBwb3dlciBzYXZlDQo+ID4NCj4gPiBUbyB2
ZXJpZnkgd2hpY2ggcGFyYW1ldGVycyBhcmUgc3RyaWN0bHkgbmVjZXNzYXJ5LCBJIHBlcmZvcm1l
ZA0KPiA+IGlzb2xhdGVkIHRlc3RpbmcgdG9kYXkuIEkgZW5zdXJlZCBubyBvdGhlciBtb2Rwcm9i
ZSBjb25maWdzIHdlcmUNCj4gPiBhY3RpdmUsIHJlYnVpbHQgdGhlIGluaXRyYW1mcywgYW5kIG1h
bnVhbGx5IGVuZm9yY2VkIHRoYXQNCj4gPiBgd2lmaS5wb3dlcnNhdmVgIHdhcyBhY3RpdmUgdmlh
IGBpdyBkZXYgd2xhbjAgc2V0IHBvd2VyX3NhdmUgb25gDQo+ID4gZHVyaW5nIGFsbCB0ZXN0cyAo
YXMgdGhlIE9TIHBvd2VyIG1hbmFnZW1lbnQgcHJvZmlsZXMgd2VyZSBkZWZhdWx0aW5nDQo+ID4g
aXQgdG8gb2ZmLCB3aGljaCBpbml0aWFsbHkgbWFza2VkIHRoZSBpc3N1ZSkuDQo+ID4NCj4gPiBJ
IHRlc3RlZCBlYWNoIHdvcmthcm91bmQgaW5kaXZpZHVhbGx5IGFjcm9zcyBtdWx0aXBsZSBzbGVl
cC93YWtlDQo+ID4gY3ljbGVzIGFuZCBhY3RpdmUgdXNhZ2U6DQo+ID4NCj4gPiAqKlRlc3QgMSAo
QVNQTSBEaXNhYmxlZCwgTFBTIERlZXAgRW5hYmxlZCk6KioNCj4gPiAtIEtlcm5lbCBwYXJhbWV0
ZXJzOiBgcnR3ODhfcGNpIGRpc2FibGVfYXNwbT15YCAoYW5kIGBydHc4OF9jb3JlDQo+ID4gZGlz
YWJsZV9scHNfZGVlcD1uYCkNCj4gPiAtIFJlc3VsdDogU3RhYmxlLiBObyBmcmVlemVzIHdlcmUg
b2JzZXJ2ZWQgZHVyaW5nIHVzYWdlIG9yIHRyYW5zaXRpb25zDQo+ID4gaW50by9vdXQgb2YgUzMg
c2xlZXAgd2hpbGUgcG93ZXIgc2F2aW5nIHdhcyBlbmZvcmNlZC4NCj4gPg0KPiA+ICoqVGVzdCAy
IChBU1BNIEVuYWJsZWQsIExQUyBEZWVwIERpc2FibGVkKToqKg0KPiA+IC0gS2VybmVsIHBhcmFt
ZXRlcnM6IGBydHc4OF9jb3JlIGRpc2FibGVfbHBzX2RlZXA9eWAgKGFuZCBgcnR3ODhfcGNpDQo+
ID4gZGlzYWJsZV9hc3BtPW5gKQ0KPiA+IC0gUmVzdWx0OiBTdGFibGUuIE5vIGZyZWV6ZXMgd2Vy
ZSBvYnNlcnZlZCB1bmRlciB0aGUgc2FtZSBmb3JjZWQgcG93ZXINCj4gPiBzYXZlIGNvbmRpdGlv
bnMuDQo+ID4NCj4gPiAqKkNvbmNsdXNpb246KiogSXQgYXBwZWFycyB3ZSBkbyBub3QgbmVlZCBi
b3RoIHdvcmthcm91bmRzDQo+ID4gc2ltdWx0YW5lb3VzbHkgZm9yIHRoaXMgc3BlY2lmaWMgaGFy
ZHdhcmUuIFVzaW5nIG9ubHkgYGRpc2FibGVfYXNwbT15YA0KPiA+IHNlZW1zIHRvIGJlIHN1ZmZp
Y2llbnQgdG8gcHJldmVudCB0aGUgc3lzdGVtIGZyZWV6ZS4gR2l2ZW4geW91ciBub3RlDQo+ID4g
YWJvdXQgdGhlIHBvd2VyIGNvbnN1bXB0aW9uIGltcGFjdCByYW5raW5nLCB0aGlzIGxvb2tzIGxp
a2UgdGhlDQo+ID4gb3B0aW1hbCBwYXRoIGZvcndhcmQuDQo+IA0KPiBMZXQncyB0ZXN0IG15IFJG
VCBwYXRjaCB0byBkaXNhYmxlIEFTUE0gdGhlbi4NCj4gDQo+ID4NCj4gPiA+IEJ1dCB3aGF0IGRv
ZXMgJ2RlYWRsb2NrJyBtZWFuPyBBcyBJIGtub3cgTkFQSSBwb2xsIGlzIHNjaGVkdWxlZCBieSBJ
U1IsDQo+ID4gPiBhbmQgZ29pbmcgdG8gcmVjZWl2ZSBwYWNrZXRzLiBUaGUgcnhfbm9fYXNwbSB3
b3JrYXJvdW5kIGlzIHRvIGZvcmNlbHkgdHVybg0KPiA+ID4gb2ZmIEFTUE0gZHVyaW5nIHRoaXMg
cGVyaW9kLg0KPiA+DQo+ID4gQnkgImRlYWRsb2NrIiBJIG1lYW50IGEgaGFyZHdhcmUtbGV2ZWwg
YnVzIGxvY2t1cC4gSXQgc2VlbXMgdGhlDQo+ID4gcGh5c2ljYWwgUlRMODgyMUNFIGNoaXAgaXRz
ZWxmIGNyYXNoZXMgb3IgaGFuZ3MgdGhlIHN5c3RlbSdzIFBDSWUgYnVzDQo+ID4gd2hlbiB0cnlp
bmcgdG8gbmVnb3RpYXRlIHdha2luZyB1cCBmcm9tIEFTUE0gTDEgd2hpbGUgc2ltdWx0YW5lb3Vz
bHkNCj4gPiBleGlzdGluZyBpbiBgTFBTX0RFRVBfTU9ERV9MQ0xLYC4gVGhlIGByeF9ub19hc3Bt
YCB3b3JrYXJvdW5kIGluIE5BUEkNCj4gPiBoZWxwcyBkdXJpbmcgYWN0aXZlIFJ4IGRlY29kaW5n
LCBidXQgdGhlIGxhcHRvcCBvZnRlbiBmcmVlemVzIHdoaWxlDQo+ID4gY29tcGxldGVseSBpZGxl
LCBwcmVzdW1hYmx5IHdoZW4gdGhlIEFQIHNlbmRzIGEgYmFzaWMgYmVhY29uLCB0aGUgY2hpcA0K
PiA+IGF0dGVtcHRzIHRvIGxlYXZlIExQUyBEZWVwICsgTDEsIGFuZCB0aGUgaGFyZHdhcmUgc2lt
cGx5IGdpdmVzIHVwIGFuZA0KPiA+IGhhbHRzIHRoZSBzeXN0ZW0uDQo+IA0KPiBJIHRoaW5rIHRo
aXMgaXMgeW91ciBwZXJzcGVjdGl2ZSBhbmQgaW5kdWN0aW9uLCByaWdodD8gRGlkIHlvdSBtZWFz
dXJlDQo+IHJlYWwgaGFyZHdhcmUgc2lnbmFscz8NCj4gDQo+IE15IHBvaW50IGlzIHRoYXQgaWYg
dGhpcyBpcyBhIGhhcmR3YXJlLWxldmVsIGJ1cyBsb2NrdXAsIGxldCdzIGFwcGx5DQo+IHF1aXJr
LiBJZiBzb21lIG1hbGZvcm1lZCBkYXRhIGNhdXNpbmcga2VybmVsIGhhbmdzLCBJJ2QgYWRkIHNh
bml0eSBjaGVjaw0KPiBvbiBSWCBkYXRhLCBidXQgSSBkb24ndCBhY3R1YWxseSBrbm93IHdoYXQg
d2Ugc2hvdWxkIGNoZWNrIGZvciBub3cuDQo+IA0KPiA+DQo+ID4gPiBXZSBoYXZlIG5vdCBtb2Rp
ZmllZCBSVEw4ODIxQ0UgZm9yIGEgbG9uZyB0aW1lLCBzbyBJJ2QgYWRkIHdvcmthcm91bmQNCj4g
PiA+IHRvIHNwZWNpZmljIHBsYXRmb3JtIGFzIG1lbnRpb25lZCBhYm92ZS4NCj4gPg0KPiA+IEFk
ZGluZyBhIERNSS9wbGF0Zm9ybSBxdWlyayBzcGVjaWZpY2FsbHkgZm9yIHRoaXMgbGFwdG9wIHRv
IGRpc2FibGUNCj4gPiBBU1BNIHdvdWxkIGJlIHdvbmRlcmZ1bCBhbmQgZGVlcGx5IGFwcHJlY2lh
dGVkLiBJIGFncmVlIGl0IGlzIHNhZmVyDQo+ID4gdGhhbiB0b3VjaGluZyB0aGUgZ2xvYmFsIGZs
YWdzIGZvciBoYXJkd2FyZSB0aGF0IGlzIGZ1bmN0aW9uaW5nDQo+ID4gY29ycmVjdGx5IG91dCBp
biB0aGUgd2lsZC4NCj4gPg0KPiA+IEhlcmUgaXMgdGhlIGV4YWN0IGlkZW50aWZ5aW5nIGluZm9y
bWF0aW9uIGZvciBteSBzeXN0ZW06DQo+ID4NCj4gPiBTeXN0ZW0gVmVuZG9yOiBIUA0KPiA+IFBy
b2R1Y3QgTmFtZTogSFAgTm90ZWJvb2sNCj4gPiBTS1UgTnVtYmVyOiBQM1M5NUVBI0FDQg0KPiA+
IEZhbWlseTogMTAzQ181MzM1S1YNCj4gPiBQQ0kgSUQ6IDEwZWM6YzgyMQ0KPiA+IFN1YnN5c3Rl
bSBJRDogMTAzYzo4MzFhDQo+ID4NCj4gPiBJIGFtIGNvbXBsZXRlbHkgcmVhZHkgdG8gdGVzdCBh
bnkgcGF0Y2ggb3IgcXVpcmsgeW91IHNlbmQgbXkgd2F5Lg0KPiA+IFRoYW5rIHlvdSBzbyBtdWNo
IGZvciB5b3VyIHRpbWUgYW5kIGhlbHBpbmcgdHJhY2sgdGhpcyBkb3duIQ0KPiANCj4gSSBzZW50
IGEgUkZUIFsxXSBmb3IgdGVzdC4gUGxlYXNlIGNoZWNrIGlmIGl0IHdvcmtzIG9uIHlvdXIgSFAg
bm90ZWJvb2suDQo+IElmIHlvdSBjaGVjayBydHc4OCBsb2csIHlvdSBjYW4gc2VlIEkgYWRkZWQg
c2ltaWxhciBwYXRjaCA1IHllYXJzIGFnbywNCj4gYW5kIHJlcGxhY2VkIGJ5IHByZWZlcnJlZCB0
aGUgY2hhbmdlIG9mICJydHdwY2ktPnJ4X25vX2FzcG0iLCB3aGljaCBJDQo+IHRoaW5rIGl0IGNh
biBvbmx5IHJlc29sdmUgcHJvYmxlbSBvbiBwYXJ0aWFsIG5vdGVib29rcyB0aG91Z2guLi4uDQo+
IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNjAz
MTEwMjA4MTYuNzA2NS0xLXBrc2hpaEByZWFsdGVrLg0KPiBjb20vVC8jdQ0KDQpGb3Jnb3QgdG8g
c2F5LiBDb3VsZCB5b3Ugc2hhcmUgeW91ciBmdWxsIG5hbWUgZm9yIG1lIGFzIGEgcmVwb3J0ZXIN
CmluIGNvbW1pdCBtZXNzYWdlPw0KDQoNCg==

