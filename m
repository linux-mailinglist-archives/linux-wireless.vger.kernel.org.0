Return-Path: <linux-wireless+bounces-34293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAquL/y8zWlmgQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 02:49:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26153382139
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 02:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAA2300F511
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CBD40DFB5;
	Thu,  2 Apr 2026 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tHjdOcJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F3C2EA
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090937; cv=none; b=pdqalUaxL0SOCGn5FB3W9kv6ClAPDEHYV0YbZxbIakJEkQiSNSmMtHRSqJc8JyVNeofc81uvWssPluAxq/apiqoF7QA6cimRW8aGSNVDH/d4fwvKmMqKUEUb+9Xrng5P6nLHXXtmnPaC7xCGbPabTTXz2knqEh3Jl4OBqlDub+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090937; c=relaxed/simple;
	bh=2e11vw7heASB9a+qAnHzvlpAnP4SF7SPY6wdG7WiSFs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyWFKUH27j0Z8ipRx/V3VOE1x23iIpv/KKh5zZzRta9XylGylD0Ofo0VC/HafbXWVEpWCM8zMXwo1X06PEk8fcspmvWA8cmmSLXE+cAutGXOSde1xaXivQUBcoNrY/9SCukon7L9A/3vn6u+ro9YKHm5RFvhNxyxio2HY/a1agY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tHjdOcJP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6320mpoR72101883, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775090931; bh=2e11vw7heASB9a+qAnHzvlpAnP4SF7SPY6wdG7WiSFs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tHjdOcJPErDGG2W8SFHFbxC9+RshQquJ7rQP2HXnlmZoCRKAiBu96sA43k0XQe+tU
	 28WI/6yTmajyxB/OCsG1pthGHIXcn21UG+xuPgrLvf6FJYuVuG2PmkDS0lg9b50SPp
	 4yIhajnleVm9wpnTl9HRDHUOBcsmna2PwEIfJUeg67DxuhcEwywXidamZE1zQPOy9Y
	 K2D+d1cCHg+FZStfj1k1ycNFnCnF3zgRFYxbPJqHgbZbLR7kOs/4upr4J+irTba8Fv
	 417O0bTaS9hCajbWnfO5P8EXx7aoQzfPV2zuQcUm1uhI7zJUIu3Nrq0xV2eY/qNFlW
	 nvATVz2d9KTBg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6320mpoR72101883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:48:51 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 08:48:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 08:48:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292%10]) with mapi id
 15.02.1748.010; Thu, 2 Apr 2026 08:48:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHcvUJaf1EFq86SyU2PseRbtxmFrLXGZTQggAOYQoCAAPmSUA==
Date: Thu, 2 Apr 2026 00:48:50 +0000
Message-ID: <0cbfd38ffd0b46e899885c83889d060b@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <25781f4aa6cc427caf396374ca46d380@realtek.com>
 <a90f22d6-bac0-4c76-86fb-517e7e7bf441@gmail.com>
In-Reply-To: <a90f22d6-bac0-4c76-86fb-517e7e7bf441@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34293-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26153382139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAz
MC8wMy8yMDI2IDA1OjUzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPZnRlbiBvbmUgb3IgbW9y
ZSBvZiB0aGVzZSBtZXNzYWdlcyBhcHBlYXJzIHdoZW4gdGhlIGNoaXAgcG93ZXJzIG9uOg0KPiA+
Pg0KPiA+PiBbICArMi4xNjcwMzddIHJ0dzg5Xzg5MjJhdSAxLTI6MS4wOiBmYWlsZWQgdG8gd2Fp
dCBSRiBEQUNLDQo+ID4+DQo+ID4+IFsgICsyLjk0Mjc0OV0gcnR3ODlfODkyMmF1IDEtMjoxLjA6
IGZhaWxlZCB0byB3YWl0IFJGIFRTU0kNCj4gPj4NCj4gPj4gWyAgKzAuMDE5MDA2XSBydHc4OV84
OTIyYXUgMi00OjEuMDogZmFpbGVkIHRvIHdhaXQgUkYgUFJFX05URlkNCj4gPj4NCj4gPj4gWyAg
KzUuOTg1OTAwXSBydHc4OV84OTIyYXUgMi00OjEuMDogZmFpbGVkIHRvIHdhaXQgUkYgRFBLDQo+
ID4+DQo+ID4+IEl0J3MgdW5jbGVhciB3aHkuDQo+ID4NCj4gPiBSVEw4OTIyRCBkb25lIFJGIGNh
bGlicmF0aW9ucyBieSBmaXJtd2FyZSBvbmUgYnkgb25lLCBzbyBkcml2ZXIgc2hvdWxkDQo+ID4g
d2FpdCBmb3IgcHJldmlvdXMgb25lIGRvbmUsIGFuZCB0cmlnZ2VyIG5leHQgb25lLiBIb3dldmVy
LCBpdCdkIGJlDQo+ID4gd2VsbCB0byBqdXN0IGRvIHdhaXRpbmcgYXQgdGhlIGxhc3QgdG8gd2Fp
dCBmb3IgYWxsIGNhbGlicmF0aW9ucy4NCj4gPg0KPiA+IFRyeSB0byBlbmxhcmdlIHdhaXRpbmcg
dGltZSBpbiBydHc4OTIyYV9yZmtfY2hhbm5lbCgpLg0KPiA+DQo+IA0KPiBJIHdhcyBjb252aW5j
ZWQgSSB0cmllZCB0aGF0IGFscmVhZHksIGJ1dCBuby4NCj4gDQo+IEFmdGVyIGluY3JlYXNpbmcg
YWxsIGRlbGF5cyBhIGJpdCB0aGUgd2FybmluZ3MgYXJlIG11Y2ggbW9yZSByYXJlLg0KDQpUdXJu
IG9mIGRlYnVnIG1hc2sgUlRXODlfREJHX1JGSyBhbmQgc2V0IGEgdmVyeSBsYXJnZSB0aW1lb3V0
IHRpbWUsIGFuZA0KZG8gY29ubmVjdGlvbiA+MjAgdGltZXMgYW5kIHRoZW4gY2hlY2sgIlJGICVz
IHRha2VzICVsbGQgbXMgdG8gY29tcGxldGUiDQp0byBzZWUgdGhlIG1heGltdW0gdmFsdWUgaW4g
eW91ciBlbnZpcm9ubWVudC4NCg0KUGxlYXNlIHNoYXJlIHRoZSBudW1iZXIgZm9yIGVhY2ggUkYg
Y2FsaWJyYXRpb24gYWZ0ZXIgeW91ciBleHBlcmltZW50cy4NCg0KPiANCj4gPj4NCj4gPj4gSXQg
c2VlbXMgdG8gd29yayB3ZWxsIGFueXdheS4NCj4gPj4NCj4gPg0KPiA+IElmIHlvdSBjYW4geWll
bGQgdGhlIGhpZ2hlc3QgcmF0ZSAoTUNTMTMpLCBJJ2Qgc2F5IGl0IGlzIGZpbmUuDQo+ID4NCj4g
PiBQaW5nLUtlDQo+ID4NCj4gDQo+IFRlc3Rpbmcgd2l0aCBSVEw4ODMyQ1UgKEJyb3N0cmVuZCBB
WDgpIGluIEFQIG1vZGUsIHRoZSBSVEw4OTEyQVUgY2FuDQo+IHJlYWNoIDEuNSBHYnBzIChNQ1Mx
MCkgUlgsIDEgR2JwcyBUWC4NCj4gDQo+IEkgdXNlZCB0aGUgUlRMODgzMkNVIGJlY2F1c2UgbXkg
cm91dGVyIGlzIG5vdCB3b3JraW5nIHdlbGwgd2l0aCAxNjANCj4gTUh6Lg0KDQpTaW5jZSBydHc4
OSBvbmx5IHN1cHBvcnQgYmVhbWZvcm1lZSAobm8gYmVhbWZvcm1lciksIGJlYW1mb3JtaW5nIGNh
bid0DQp3b3JrIGJldHdlZW4gdHdvIHJ0dzg5IGRldmljZXMuIE1vcmUsIHR3byBhbnRlbm5hIGNh
bid0IGhhdmUgZ29vZA0KYmVhbWZvcm1pbmcgcGVyZm9ybWFuY2UuIEkgdGhpbmsgdGhpcyBpcyBh
IHBvaW50IHRoYXQgaXQgaXMgaGFyZCB0bw0KeWllbGQgdGhlIGhpZ2hlc3QgcmF0ZS4gDQoNCkFu
b3RoZXIgcG9pbnQgbWF5IGJlIHRoZSBSRiBwZXJmb3JtYW5jZS4gSWYgdGhlIHdhcm5pbmcgbWVz
c2FnZXMgb2YNClJGIGNhbGlicmF0aW9uIGRpc2FwcGVhcmVkLCBJJ2Qgc2F5IHRoaXMgbWlnaHQg
bm90IGEgcHJvYmxlbS4NCg0KTGV0J3MgbWVudGlvbiB0aGlzIGluIGNvbW1pdCBtZXNzYWdlIG9m
IDEyLzEyLg0KDQpQaW5nLUtlDQoNCg==

