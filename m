Return-Path: <linux-wireless+bounces-33069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HFoE7FtsmkpMgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:39:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145726E653
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29DB305FFC0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA67324B24;
	Thu, 12 Mar 2026 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="htPghJqA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579252D23B9;
	Thu, 12 Mar 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301156; cv=none; b=CHhzhqh4QX8XZtVr+Wgl3RNSTAafS9J/GDvlGcYJk9nLg3/ndQFbr+oaK/oaGBiCcnyXHxyJQuYt6FYMSzvDPdrU2vt8DI6VOurjhmtTqYLfpcH+Ps9zXKay1cW0B9khk5mav5TIaYxOVqqUyuMepmXoYW+DcbELzlQTyC2MSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301156; c=relaxed/simple;
	bh=0+Q96SNDjksVpmt41ciC3peTaZLC2wn8IuCxnaAkkug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JduL6ojQH3zuPlWX7FrQfKHxt0RZNk6CIjFEbMoZvJDo/pDddOx30i60AVGWkuDKQUVans7E8hItCAD6T/3x6GeHCXeRfLtAzRdnc8vC48ETbA/V0Vrk+sp7t6nEKH9MgGZ81yANPTogjS1OW4wmDW84uxcxG17uVliacbh0mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=htPghJqA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62C7d74F12125883, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773301147; bh=0+Q96SNDjksVpmt41ciC3peTaZLC2wn8IuCxnaAkkug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=htPghJqAUn/M+Fde5FTu7e+jIPITHI5jZzhbO2xNk9v98DjCF28KyFf218AfayXSH
	 qI5DICCsZzyfvJ26l08VIpkXLlEeTBA7HHNIgx275tv75gf9kyCHTEaNVU7Ev017VD
	 iW4UaKTIjZsWQVOyCkIoRihq+4TAELUHbEE+ZoEq+3td8JUvyIPFkHq4ZxxKP/eLHQ
	 Qettvj5YcFkC5MPC5k6sRoCewi6wHmxpvxXn9J5mLmg34uyNAMaa2cX4pH0BeXuN1y
	 bK6rBB2ONhi1F63+x/0Qo1tyK0LH+6erPbvc9kS9Tk9KNC9xgWTeF/kY4gtAg66DtE
	 VwEGjS8mLhiNA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62C7d74F12125883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 15:39:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Mar 2026 15:39:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 12 Mar 2026 15:39:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q//99hoCAAIbrQP//fzIAgAtGLdCAAgS2AIABJ37Q//+R6YAAPhAkoP//vWCA//9gbHA=
Date: Thu, 12 Mar 2026 07:39:08 +0000
Message-ID: <3f072307ed634e878c7d9da152801aec@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
 <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
 <2ab692371ff94a3f960d41b04288a084@realtek.com>
 <B9D5D4CC-0729-4867-AD1B-18D80D78841B@gmail.com>
 <bac9b823342141bb9ed561ac5ccfd71d@realtek.com>
 <62487266-6846-4E3D-9947-33CB6FE408BF@gmail.com>
In-Reply-To: <62487266-6846-4E3D-9947-33CB6FE408BF@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33069-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,libreelec.tv:url]
X-Rspamd-Queue-Id: 9145726E653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Q2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
IE9uIDEyIE1hciAyMDI2LCBhdCA2OjIy4oCvYW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IENocmlzdGlhbiBIZXdpdHQgPGNocmlzdGlhbnNoZXdp
dHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+IE9uIDExIE1hciAyMDI2LCBhdCA3OjA14oCvYW0s
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+PiBD
aHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+
Pj4NCj4gPj4+Pj4gT24gOSBNYXIgMjAyNiwgYXQgNjozNeKAr2FtLCBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+IENocmlzdGlhbiBIZXdp
dHQgPGNocmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+DQo+ID4+Pj4+
Pj4gT24gMiBNYXIgMjAyNiwgYXQgMTA6MDTigK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gQ2hyaXN0aWFuIEhld2l0dCA8
Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pj4gT24gMiBNYXIg
MjAyNiwgYXQgOTo0N+KAr2FtLCBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3Jv
dGU6DQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gQ2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFu
c2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pj4+IE9uIFJhZHhhIFJvY2sgNUIg
d2l0aCBhIFJUTDg4NTJCRSBjb21ibyBXaUZpL0JUIGNhcmQsIHRoZSBlZnVzZQ0KPiA+Pj4+Pj4+
Pj4+IHBoeXNpY2FsIG1hcCBkdW1wIGludGVybWl0dGVudGx5IGZhaWxzIHdpdGggLUVCVVNZIGR1
cmluZyBwcm9iZS4NCj4gPj4+Pj4+Pj4+PiBUaGUgZmFpbHVyZSBvY2N1cnMgaW4gcnR3ODlfZHVt
cF9waHlzaWNhbF9lZnVzZV9tYXBfZGR2KCkgd2hlcmUNCj4gPj4+Pj4+Pj4+PiByZWFkX3BvbGxf
dGltZW91dF9hdG9taWMoKSB0aW1lcyBvdXQgd2FpdGluZyBmb3IgdGhlIEJfQVhfRUZfUkRZDQo+
ID4+Pj4+Pj4+Pj4gYml0IGFmdGVyIDEgc2Vjb25kLg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+
IEknbSBjaGVja2luZyBpbnRlcm5hbGx5IGhvdyB3ZSBoYW5kbGUgdGhpcyBjYXNlLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBTb3JyeSBmb3IgdGhlIGxhdGUuDQo+ID4+Pj4+DQo+ID4+Pj4+IFdlIGVuY291
bnRlcmVkIFdpRmkvQlQgcmVhZGluZyBlZnVzZSBhdCB0aGUgc2FtZSB0aW1lIGNhdXNpbmcgc2lt
aWxhcg0KPiA+Pj4+PiBwcm9ibGVtIGFzIHlvdXJzLiBUaGUgd29ya2Fyb3VuZCBpcyBsaWtlIHlv
dXJzLCB3aGljaCBhZGRzIHRpbWVvdXQNCj4gPj4+Pj4gdGltZS4NCj4gPj4+Pj4NCj4gPj4+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+PiBbLi4uXQ0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pg0KPiA+Pj4+
Pj4+Pj4+IEZvciBjb250ZXh0LCBmaXJtd2FyZSBhbHNvIGZhaWxzIChhbmQgcmVjb3ZlcnMpIHNv
bWV0aW1lczoNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBEaWQgeW91IG1lYW4gdGhpcyBkb2Vz
bid0IGFsd2F5cyBoYXBwZW4/IHNvbWV0aW1lcz8NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gSXTi
gJlzIGFub3RoZXIgaW50ZXJtaXR0ZW50IGJlaGF2aW91ciBvYnNlcnZlZCBvbiB0aGlzIGJvYXJk
IChhbmQgbm90DQo+ID4+Pj4+Pj4+IHJlbGF0ZWQgdG8gdGhlIGlzc3VlIHRoaXMgcGF0Y2ggdGFy
Z2V0cykuIEl0IG9jY3VycyBsZXNzIGZyZXF1ZW50bHkNCj4gPj4+Pj4+Pj4gdGhhbiB0aGUgZWZ1
c2UgaXNzdWUgYW5kIHRoZSBleGlzdGluZyByZXRyeSBtZWNoYW5pc20gaW4gdGhlIGRyaXZlcg0K
PiA+Pj4+Pj4+PiBlbnN1cmVzIGZpcm13YXJlIGxvYWQgYWx3YXlzIHN1Y2NlZWRzLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBUaGlzIG1pZ2h0IGJlIHRoZSBzYW1lIGNhdXNlIGR1ZSB0byByZWFkaW5nIGVm
dXNlIGluIGZpcm13YXJlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaG91Z2ggd2UgY2FuIGFkZCBtb3Jl
IHRpbWVvdXQgYW5kIHJldHJ5IHRpbWVzIGFzIHdvcmthcm91bmQsIEkgd29uZGVyDQo+ID4+Pj4+
IGlmIHlvdSBjYW4gY29udHJvbCBsb2FkaW5nIHRpbWUgb2YgV2lGaSBhbmQgQlQga2VybmVsIG1v
ZHVsZXM/DQo+ID4+Pj4+DQo+ID4+Pj4+IE1vcmUsIGNhbiB5b3UgZG8gZXhwZXJpbWVudCB0aGF0
IHlvdSBsb2FkIEJUIG1vZHVsZSBmaXJzdCwgYW5kIHRoZW4gbG9hZA0KPiA+Pj4+PiBXaUZpIG1v
ZHVsZSBhZnRlciAxMCBzZWNvbmRzIChjaG9vc2UgYSBsYXJnZSBudW1iZXIgaW50ZW50aW9uYWxs
eSwgb3INCj4gPj4+Pj4gZXZlbiBsYXJnZXIpPw0KPiA+Pj4+DQo+ID4+Pj4gaHR0cHM6Ly9wYXN0
ZS5saWJyZWVsZWMudHYvY2hhcm1lZC10dXJrZXkuc2gNCj4gPj4+Pg0KPiA+Pj4+IEnigJl2ZSBy
dW4gdGhlIGFib3ZlIHNjcmlwdCBeIHdoaWNoIHJlbW92ZXMgdGhlIHdpZmkgYW5kIGJ0IG1vZHVs
ZXMgaW4NCj4gPj4+PiBzZXF1ZW5jZSB0aGVuIHJlbG9hZHMgdGhlbSBpbiB0aGUgcmV2ZXJzZSBv
cmRlciB3aXRoIGEgZGVsYXkgYmV0d2Vlbg0KPiA+Pj4+IGJ0IGFuZCB3aWZpIG1vZHVsZXMgbG9h
ZGluZywgdGhlbiBjaGVja3MgZm9yIGVycm9yIG1lc3NhZ2VzLiBPdmVyIDIwMA0KPiA+Pj4+IHRl
c3QgY3ljbGVzIHdpdGggYSAxMHMgZGVsYXkgYWxsIHdlcmUgY2xlYW4gKG5vIGVycm9ycykuIEkg
YWxzbyByYW4NCj4gPj4+PiBjeWNsZXMgd2l0aCBhIDIgc2Vjb25kIGRlbGF5IGFuZCAwIHNlY29u
ZCBkZWxheSBiZWZvcmUgc3RhcnRpbmcgd2lmaQ0KPiA+Pj4+IG1vZHVsZSBsb2FkIGFuZCB0aG9z
ZSB3ZXJlIGNsZWFyIHRvby4gSSBndWVzcyB0aGF0IHByb3ZlcyBzZXF1ZW5jaW5nDQo+ID4+Pj4g
YXZvaWRzIHRoZSBlZnVzZSBjb250ZW50aW9uIGlzc3VlPyAtIGFsdGhvdWdoIGl04oCZcyBub3Qg
cG9zc2libGUgaW4NCj4gPj4+PiB0aGUgcmVhbC13b3JsZCBzbyBub3Qgc3VyZSB0aGVyZeKAmXMg
aHVnZSB2YWx1ZSBpbiBrbm93aW5nIHRoYXQgOikNCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHRo
ZSBleHBlcmltZW50cy4NCj4gPj4+DQo+ID4+PiBTdGlsbCB3YW50IHRvIGtub3cgaXMgaXQgcG9z
c2libGUgdG8gY2hhbmdlIHNlcXVlbmNlL3RpbWUgb2YgbG9hZGluZw0KPiA+Pj4ga2VybmVsIG1v
ZHVsZXMgYXQgYm9vdCB0aW1lIGZyb20gc3lzdGVtIGxldmVsPyBJIG1lYW4gY2FuIHlvdSBhZGp1
c3QNCj4gPj4+IHRoZSBzZXF1ZW5jZSBpbiB0aGUgUm9jayA1QiBib2FyZD8NCj4gPj4NCj4gPj4g
SeKAmW0gbm90IGEga2VybmVsIGV4cGVydCwgYnV0IEnigJl2ZSBhbHdheXMgdW5kZXJzdG9vZCBt
b2R1bGUgcHJvYmUgYW5kDQo+ID4+IGxvYWQgb3JkZXJpbmcgdG8gbm90IGJlIGd1YXJhbnRlZWQ7
IGFzIG1hbnkgdGhpbmdzIHJ1biBpbiBwYXJhbGxlbCBhbmQNCj4gPj4gYXJlIGhpZ2hseSBzdWJq
ZWN0aXZlIHRvIHRoZSBzcGVjaWZpYyBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgYW5kIGtlcm5lbA0K
PiA+PiBjb25maWcgYmVpbmcgdXNlZC4NCj4gPg0KPiA+IEkgaGF2ZSBoZWFyZCBwZW9wbGUgYWJv
dXQgY2hhbmdpbmcgc2VxdWVuY2UvdGltZSBvZiBrZXJuZWwgbW9kdWxlcywgc28NCj4gPiBJJ2Qg
bGlrZSB5b3UgY2FuIHRyeSB0aGlzIG1ldGhvZC4NCj4gPg0KPiA+IEkgZGlkIGFzayBBSSwgaXQg
c2FpZCBpdCBpcyBwb3NzaWJsZSB0byBjcmVhdGUgYSAuY29uZiBmaWxlIHVuZGVyDQo+ID4gL2V0
Yy9tb2Rwcm9iZS5kLyBhbmQgdXNlIGBzb2Z0ZGVwYCBzeW50YXggdG8gZW5zdXJlIGxvYWRpbmcg
c2VxdWVuY2UuDQo+ID4gQ291bGQgeW91IHRyeSB0aGlzPw0KPiANCj4gSSBjYW4gdGVzdCB0aGlz
LCBidXQgZXZlbiBpZiBpdCB3b3JrcyBpdOKAmXMgbm90IGEgZml4IGJlY2F1c2UgbW9kcHJvYmUN
Cj4gY29uZnMgY29uZmlndXJlZCBpbiB1c2Vyc3BhY2UgYXJlIG9ubHkgdXNlZCB3aXRoIGxvYWRh
YmxlIG1vZHVsZXMgdGhhdA0KPiBoYXZlIGJlZW4gY29tcGlsZWQgd2l0aCA9bSwgbm90IGJ1aWxk
LWluIG1vZHVsZXMgdGhhdCBhcmUgcmVzaWRlbnQgaW4NCj4ga2VybmVsIG1lbW9yeSBhbmQgY29t
cGlsZWQgd2l0aCA9eTsgYW5kIGRpc3Ryb3MgYXJlIGZyZWUgdG8gY2hvb3NlIGhvdw0KPiB0aGVp
ciBrZXJuZWwgaXMgY29uZmlndXJlZC4gTkI6IEnigJltIG5vdCBzdXJlIGlmIHRoZXJlIGFyZSBh
bnkgZ2VuZXJhbA0KPiBrZXJuZWwgcnVsZXMgZm9yIHRoaXMsIGJ1dCBJ4oCZZCBleHBlY3QgdGhl
cmUgdG8gYmUgZ2VuZXJhbCBwcmluY2lwbGUgb2YNCj4gbW9kdWxlcyBiZWluZyByZXNpbGllbnQg
dG8gdHJhbnNpZW50IGhvc3Qgc3RhdGVzIGFuZCBub3QgZGVwZW5kaW5nIG9uDQo+IHVzZXJzcGFj
ZSBwYWNrYWdpbmcgdG8gbG9hZCBjb3JyZWN0bHk/DQoNCkkgdGhpbmsgYnVpbHQtaW4gbW9kdWxl
cyB3aWxsIGJlIGxvYWRlZCBzZXF1ZW50aWFsbHkgKG5vdCBpbiBwYXJhbGxlbCkNCmJ5IGRldmlj
ZV9pbml0aWNhbGwoKSwgc28gQlQgYW5kIFdpRmkgZHJpdmVycyB3aWxsIG5vdCByZWFkIGVmdXNl
IA0KYXQgdGhlIHNhbWUgdGltZS4NCg0KPiANCj4gPj4gSW4gYWRkaXRpb24sIGRpZCBiZWxvdyBt
ZXNzYWdlcyBub3QgYXBwZWFyIGluIHRoZXNlIGV4cGVyaW1lbnRzPw0KPiA+Pj4NCj4gPj4+IFsg
ICAgNy44NjQxNDhdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IGZ3IHNlY3VyaXR5IGZhaWwN
Cj4gPj4+IFsgICAgNy44NjQxNTRdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IGRvd25sb2Fk
IGZpcm13YXJlIGZhaWwNCj4gPj4NCj4gPj4gTm8sIGJlY2F1c2UgZXZlbiBpZiB3ZSBoYXZlIGEg
MHMgZGVsYXkgYmV0d2VlbiBlYWNoIGdyb3VwIG9mIG1vZHVsZXMNCj4gPj4gYmVpbmcgbG9hZGVk
LCB0aGV5IGFyZSBsb2FkZWQgaW4gc2VyaWVzLCBzbyB3ZSB3b3JrYXJvdW5kIHRoZSBpc3N1ZS4N
Cj4gPj4gVHdlYWtpbmcgdGhlIHNjcmlwdCB0byBiYWNrZ3JvdW5kIHRoZSBtb2R1bGUgbG9hZCBs
b29wcyBzbyBib3RoIHJ1bg0KPiA+PiBpbiBwYXJhbGxlbCB3b3VsZCBiZSBjbG9zZXIgdG8gbm9y
bWFsIGNvbmRpdGlvbnMsIGFuZCBJIHdvdWxkIGV4cGVjdA0KPiA+PiB0byBzdGFydCBzZWVpbmcg
ZmFpbHVyZXMgYW5kIHRoZSByZXRyeSBtZWNoYW5pc21zIHdpdGhpbiB0aGUgbW9kdWxlcw0KPiA+
PiAoYXMgYWRkZWQgaW4gdGhpcyBwYXRjaCkgYmVpbmcgdHJpZ2dlcmVkLg0KPiA+DQo+ID4gQWRk
aXRpb25hbCBxdWVzdGlvbiBmb3IgZG93bmxvYWRpbmcgZmlybXdhcmUuIEFzIHlvdSByZXBvcnRl
ZCB0aGlzDQo+ID4gaXNzdWUgaW5pdGlhbGx5IChsb2FkIG1vZHVsZXMgYXQgYm9vdCB0aW1lIGlu
IHBhcmFsbGVsKSwgaXQgc2VlbXMNCj4gPiBhcHBlYXIgdGhpcyBtZXNzYWdlIGJ5IGNoYW5jZS4g
U2luY2UgdGhpcyBkcml2ZXIgd2lsbCByZXRyeSB0byBkb3dubG9hZA0KPiA+IGZpcm13YXJlLCB3
aWxsIGl0IHN1Y2Nlc3NmdWxseSBkb3dubG9hZHMgZmlybXdhcmUgZmluYWxseT8gT3IgaXQgc3Rp
bGwNCj4gPiBmYWlscyB0byBkb3dubG9hZCBhZnRlciA1IHRpbWVzIHJldHJ5Pw0KPiANCj4gSSBo
YXZlIG9ubHkgc2VlbiBmaXJtd2FyZSBsb2FkIGZhaWwgYSBoYW5kZnVsIG9mIHRpbWVzIGluIG1h
bnkgaHVuZHJlZHMNCj4gb2YgYm9vdHMgYW5kIGVhY2ggdGltZSBvbmUgcmV0cnkgYXR0ZW1wdCBy
ZXN1bHRlZCBpbiBzdWNjZXNzLiBUbyBiZQ0KPiBjbGVhcjsgSSBoYXZlIGFtIG5vdCByZXBvcnRp
bmcgZmlyd21hcmUgbG9hZGluZyBhcyBhIHByb2JsZW0sIGl0IGlzIG5vdA0KPiBhbiBpc3N1ZSBm
b3IgbWUuIEnigJl2ZSBtZW50aW9uZWQgaXQgb25seSBmb3IgY29udGV4dCwgaS5lLiBpdCBzaG93
cyB0aGF0DQo+IGEgc2ltcGxlIHJldHJ5IG1lY2hhbmlzbSBpcyBlZmZlY3RpdmUgYXQgaGFuZGxp
bmcgdGhlIHNpbWlsYXIgaXNzdWUgd2l0aA0KPiBlZnVzZSBtYXAuDQoNCkkgaGF2ZSB0aGlzIHF1
ZXN0aW9uIGJlY2F1c2UgSSB3b25kZXIgZG93bmxvYWRpbmcgZmlybXdhcmUgaXNzdWUgbWlnaHQg
YmUNCmFsc28gYSByZWFkaW5nIGVmdXNlIGlzc3VlLiBJZiBzbywgcmV0cnkgbWlnaHQgcmVzb2x2
ZSBhcyB3ZWxsLg0KDQpBcyB5b3VyIHJlc3VsdHMsIGl0IGxvb2tzIGxpa2UgdG8gcmV0cnkgcmVh
ZGluZyBlZnVzZSBjYW4gcmVzb2x2ZSBhbGwNCmlzc3VlcyB5b3UgZm91bmQuIFdoYXQgZG8geW91
IHRoaW5rPw0KDQpQaW5nLUtlDQoNCg==

