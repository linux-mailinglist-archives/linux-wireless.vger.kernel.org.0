Return-Path: <linux-wireless+bounces-31718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ5aDw85jGlZjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:08:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3EF1220F9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B9A430065DF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87D2D6407;
	Wed, 11 Feb 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qadET7k+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91B26F288
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797324; cv=none; b=siS+Vb1bOUfyEqg7fzgGcKSVYK4mxjXYwSBCXuiekU5cqmyXu42tETYzr8QnbTj/mURqSWeHqhAvAfwSr/ErBaADICtfW6FqhciEwX8BZyF6MUqJNvlCY3q6+5IkstZERg5+QBiHQZK/K3q37d8iPoO6Uh9gIXS8P7AjD7eEy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797324; c=relaxed/simple;
	bh=b+MOgqkUGDVr/HZL9ztXaiHSeus1VH8p/SWmnL+309s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FjubZaR4HFgXkqyukgdZBtHCWhKm9wa4ipIAgeM+ZqMkC2iDSjPDq0HdZ3F2lzrGg5yjRzovp8Udlijk5dljIc0eA5zNmFvy0YKfLHxh2uZChYwZwsHzqVcZcb1dLEOfRK+RCTfn6d+ITRwiaejPNQvHxUF5uvYzvXa7v1NHwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qadET7k+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61B88albE1373337, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770797316; bh=b+MOgqkUGDVr/HZL9ztXaiHSeus1VH8p/SWmnL+309s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qadET7k+iOl6ntDjuMWS5LjopZTIaLlzT6Yy5h9urtkMvSzC6ODGZbyeHPAMsVcG9
	 WcTZZuPy+a/PcxU+MkxVmU/6SHMj5HEW3k1kJRcOqtOTcbFV5z2NOT9b8hjL9EPnjg
	 1kBMUxJdN6K7Tn5rhosuOJ61a9VwXDGMZLhAcZOF2tURlJ7shYKLoRsluVPrllT+tF
	 HhDtQHajlWbG5xXoY/jfBFcJ3eF+/ENV3NxLFKEX4TBqZZo0aHYF6pyl73TJmebFhn
	 40d6b16g1FQdYB0bviUrNIaejXofBNMK6pkt3UvNOz2tzyJQ3ghH3mgS1mW5b/DDlZ
	 JUi2WPOu/M2ow==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61B88albE1373337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 16:08:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Feb 2026 16:08:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Feb 2026 16:08:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: mac80211: improve station iteration ergonomics
Thread-Topic: [PATCH 2/2] wifi: mac80211: improve station iteration ergonomics
Thread-Index: AQHcgK2+R3yb7dwFmU+rH/x0FQyqUbV9Py0w//+Qm4CAAIeGsA==
Date: Wed, 11 Feb 2026 08:08:35 +0000
Message-ID: <1f97fc3a40304dd49e494f2eaa35973d@realtek.com>
References: <20260108143431.f2581e0c381a.Ie387227504c975c109c125b3c57f0bb3fdab2835@changeid>
	 <20260108143431.d2b641f6f6af.I4470024f7404446052564b15bcf8b3f1ada33655@changeid>
	 <fb7526f0a2e64e229446e3faa03edc3a@realtek.com>
 <ba29951035ed17f666687db24debbb9c2dd6f30f.camel@sipsolutions.net>
In-Reply-To: <ba29951035ed17f666687db24debbb9c2dd6f30f.camel@sipsolutions.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31718-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: CE3EF1220F9
X-Rspamd-Action: no action

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IE9uIFdl
ZCwgMjAyNi0wMi0xMSBhdCAwNjo0OSArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEhp
IEpvaGFubmVzLA0KPiA+DQo+ID4gPiArLyoqDQo+ID4gPiArICogZm9yX2VhY2hfc3RhdGlvbiAt
IGl0ZXJhdGUgc3RhdGlvbnMgdW5kZXIgd2lwaHkgbXV0ZXgNCj4gPiA+ICsgKiBAc3RhOiB0aGUg
aXRlcmF0b3IgdmFyaWFibGUNCj4gPiA+ICsgKiBAaHc6IHRoZSBIVyB0byBpdGVyYXRlIGZvcg0K
PiA+ID4gKyAqLw0KPiA+ID4gKyNkZWZpbmUgZm9yX2VhY2hfc3RhdGlvbihzdGEsIGh3KSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gKyAgICAgICBmb3IgKHN0
YSA9IF9faWVlZTgwMjExX2l0ZXJhdGVfc3RhdGlvbnMoaHcsIE5VTEwpOyAgICAgICAgICAgICAg
XA0KPiA+ID4gKyAgICAgICAgICAgIHN0YTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gKyAgICAgICAgICAgIHN0YSA9IF9faWVl
ZTgwMjExX2l0ZXJhdGVfc3RhdGlvbnMoaHcsIHN0YSkpDQo+ID4gPiArDQo+ID4NCj4gPiBJJ20g
Z29pbmcgdG8gdXNlIGZvcl9lYWNoX3N0YXRpb24oKSBpbiBydHc4OSBkcml2ZXIsIGFuZCB0aGUg
Y29kZSBpbiBkcml2ZXIgc2lkZQ0KPiA+IGxvb2tzIHZlcnkgc2ltcGxlISBUaGFua3MgZm9yIHRo
aXMgbmV3IEFQSS4NCj4gPg0KPiA+IEhvd2V2ZXIsIHdpdGhvdXQgb3RoZXIgY2FsbGVycyByYXRo
ZXIgdGhhbiBpZWVlODAyMTFfaXRlcmF0ZV94eHgoKSwgSSdkIGxpa2UNCj4gPiB0byBrbm93IGlm
IGl0IGlzIGV4cGVjdGVkIHRoYXQgZHJpdmVyIHVzZXMgZm9yX2VhY2hfc3RhdGlvbigpPyBTaW5j
ZSBoZWxwDQo+ID4gdGV4dCBpcyBhZGRlZCwgSSB0aGluayBpdCBjYW4gYmUsIHJpZ2h0Pw0KPiAN
Cj4gWWVhaCBkZWZpbml0ZWx5LCBJIHdvdWxkbid0IGhhdmUgYWRkZWQgaXQgdG8gbWFjODAyMTEu
aCBvdGhlcndpc2UuIEknbQ0KPiBhbHJlYWR5IHVzaW5nIGl0IGluIG91ciBkcml2ZXIsIHRob3Nl
IHBhdGNoZXMganVzdCBoYXZlbid0IGdvbmUgdXBzdHJlYW0NCj4geWV0Lg0KPiANCj4gPiBBbm90
aGVyIHF1ZXN0aW9uIGlzIHRoYXQgYWRkaW5nIGllZWU4MDIxMV8gcHJlZml4IHdvdWxkIGJlIGNv
bnNpc3RlbnQgd2l0aA0KPiA+IG90aGVyIEFQST8gSWYgeW91IGFncmVlLCBJIGNhbiBtYWtlIHBh
dGNoZXMuDQo+ID4NCj4gPiBBcyB3ZWxsIGFzIGZvcl9lYWNoX2ludGVyZmFjZSgpLg0KPiANCj4g
WWVhaCB0aGF0J3MgYSBnb29kIHF1ZXN0aW9uIEkgZ3Vlc3MuIFRoZXJlJ3Mgc29tZSBwcmVjZWRl
bnQgZWl0aGVyIHdheSwNCj4gZS5nLiBmb3JfZWFjaF9uZXRkZXYoKSBhbmQgbmV0ZGV2X2Zvcl9l
YWNoX3VjX2FkZHIoKSwgdGhvdWdoIGl0J3MgYSBiaXQNCj4gbW9yZSBhbG9uZyB0aGUgbGluZXMg
b2YgIm9iamVjdF9mb3JfZWFjaF9tZW1iZXIoKSIgcmF0aGVyIHRoYW4NCj4gInN1YnN5c3RlbV9m
b3JfZWFjaF9zb21ldGhpbmcoKSIgLSB3aGljaCB3b3VsZCBiZSBtb3JlIGxpa2UNCj4gaWVlZTgw
MjExX2h3X2Zvcl9lYWNoX3N0YXRpb24oKSBoZXJlPyBUaGUgbm90YWJsZSBleGNlcHRpb24gdG8g
dGhpcw0KPiBiZWluZyBkYW1vbl8qLiBBbmQgb2JqZWN0cyBhcmUgYWxzbyBtaXNzaW5nLCB3ZSBo
YXZlIGZvcl9lYWNoX25ldGRldigpLA0KPiBub3QgbmV0bnNfZm9yX2VhY2hfbmV0ZGV2KCkuDQo+
IA0KPiBPaCBhbmQgdGhlIG9yZGVyIG9mIGFyZ3VtZW50cyBpcyBhbHNvIG5vdCBjb25zaXN0ZW50
IGFueXdoZXJlIGl0IHNlZW1zLg0KPiBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkgaXMgIml0ZXIsIGxp
c3QsIG1lbWJlciIsIHdoZXJlYXMgZm9yX2VhY2hfbmV0ZGV2KCkNCj4gaXMgIm5ldCwgaXRlciIu
DQo+IA0KPiBJIHN1cHBvc2UgSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uIGFib3V0IGl0LCB0aGVy
ZSBkb2Vzbid0IHJlYWxseSBzZWVtDQo+IHRvIGJlIF9hbnlfIGNvbnNpc3RlbmN5IGFyb3VuZCBp
dC4gTWF5YmUgd2Ugc2hvdWxkIGJlIGNvbnNpc3RlbnQgb3ZlcmFsbA0KPiB3aXRoIHRoZW0gdGhv
dWdoIGluIG1hYzgwMjExLmgsIGFuZCBpZiByZW5hbWluZyBub3QganVzdCBkbyB0aGUgbmV3DQo+
IG9uZXM/IEFuZCBtYXliZSB0aGF0J3Mgbm90IHdvcnRoIHRoZSBjaHVybj8NCj4gDQo+IFllYWgg
SSBkb24ndCBrbm93IHdoYXQgdG8gc2F5IEkgZ3Vlc3MsIEkgc3VwcG9zZSB0aGF0IG1lYW5zIGlm
IHlvdSBmZWVsDQo+IHN0cm9uZ2x5IG9uZSBvciB0aGUgb3RoZXIgaXMgYmV0dGVyIEknbSBoYXBw
eSB0byBhZGp1c3QgOikNCg0KSSBkb24ndCBoYXZlIHN0cm9uZyBvcGluaW9uIHRvIGVpdGhlciBv
bmUuIExldCdzIGtlZXAgYXMgaXQgd2FzLiA6KQ0KDQpQaW5nLUtlDQoNCg==

