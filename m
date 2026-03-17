Return-Path: <linux-wireless+bounces-33321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GwtAHmwuGl5hwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:38:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A42A296E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6882D301451A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC0341050;
	Tue, 17 Mar 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qwHpdRJS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DC33F392;
	Tue, 17 Mar 2026 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711477; cv=none; b=PSOYP4PNUmIF32K1weX26f+/YF94iQnUsPnGF+hSUxiDW/u4Ob8aqfcgFb2jnDM+CRy/SIMyY6Tfg93WHa1fgOi5iFo6ebDlOClUDTeecVKpiQ68i434KW0kmitYyL+Tga523zxni2TzAyhefZht9napOssDgB1gsc/iF8mZACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711477; c=relaxed/simple;
	bh=+Z8PXTpJCZhtFrpVbxGuFnPBDuzCQQISLWDuAYS2+RI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9wJVJj45XkF+t3WCBdlE03y6oZ8p56eAeJnebMDocwD1EObYlDQwpsj5aU/y1cL7SBdF0HaDhDpN1bLSKVHbVyvsm+WGB9ref1cUtj48T4K9agm7IBpIreYfpggmLtcZik7iAoeU2rxHSdJEOei//sUGIG5Kjh9dnasenv3cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qwHpdRJS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H1bpfX72996170, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773711471; bh=+Z8PXTpJCZhtFrpVbxGuFnPBDuzCQQISLWDuAYS2+RI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qwHpdRJSzsoNwcTgHHWsl1CCtNxE+Tv+8nFqteUThoM36LQIjnSsi5dY9kA0sYaYn
	 dOSbswg6GrsAZWWhQ58V0uigVd76CXD844hubwmVxqSRndzjaGh4balPQwLQpOUJGV
	 cYidQOlGCcGQYbi9BbwsIOuqr3RBUlqzloQvWwLAPpdZk0hfu2H7pFtFBeCdIw6CvN
	 i1Gr7J+MhEy2e2a0TvEupF1Re3ZjdDzbxvYeqV4oDGDkYdkpWqiYY1v47ZWWyO2uZq
	 uhDc0I2XMSrgN3FWulGWiEMiQ1bkV42dpRnt8a6n9xbarzBREnxmoGwP1xZrwwIzSS
	 wEiBTayKAwWVw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H1bpfX72996170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:37:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 09:37:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 17 Mar 2026 09:37:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWwuJTw///X3wCAAXjIQA==
Date: Tue, 17 Mar 2026 01:37:51 +0000
Message-ID: <43c8229cbe284b25bd1fd6b3a66a753d@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <a7d421b1d3074a00968f2902c9debb42@realtek.com>
 <86F91944-A4B0-46D6-B2DE-7391EB5B38A7@gmail.com>
In-Reply-To: <86F91944-A4B0-46D6-B2DE-7391EB5B38A7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33321-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4A42A296E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4gT24gMTYgTWFyIDIwMjYsIGF0IDk6MzLigK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hl
d2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiBSYWR4YSBSb2NrIDVCIHdpdGggYSBSVEw4
ODUyQkUgY29tYm8gV2lGaS9CVCBjYXJkLCB0aGUgZWZ1c2UNCj4gPj4gcGh5c2ljYWwgbWFwIGR1
bXAgaW50ZXJtaXR0ZW50bHkgZmFpbHMgd2l0aCAtRUJVU1kgZHVyaW5nIHByb2JlLg0KPiA+PiBU
aGUgZmFpbHVyZSBvY2N1cnMgaW4gcnR3ODlfZHVtcF9waHlzaWNhbF9lZnVzZV9tYXBfZGR2KCkg
d2hlcmUNCj4gPj4gcmVhZF9wb2xsX3RpbWVvdXRfYXRvbWljKCkgdGltZXMgb3V0IHdhaXRpbmcg
Zm9yIHRoZSBCX0FYX0VGX1JEWQ0KPiA+PiBiaXQgYWZ0ZXIgMSBzZWNvbmQuDQo+ID4+DQo+ID4+
IFRoZSByb290IGNhdXNlIGlzIGEgdGltaW5nIHJhY2UgZHVyaW5nIGJvb3Q6IHRoZSBXaUZpIGRy
aXZlcidzDQo+ID4+IGNoaXAgaW5pdGlhbGl6YXRpb24gKGZpcm13YXJlIGRvd25sb2FkIHZpYSBQ
Q0llKSBvdmVybGFwcyB3aXRoIHRoZQ0KPiA+PiBCbHVldG9vdGggZmlybXdhcmUgZG93bmxvYWQg
dG8gdGhlIHNhbWUgY29tYm8gY2hpcCBvdmVyIFVTQi4gVGhpcw0KPiA+PiBjYW4gbGVhdmUgdGhl
IGVmdXNlIGNvbnRyb2xsZXIgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUgd2hlbiB0aGUNCj4gPj4g
V2lGaSBkcml2ZXIgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgZWZ1c2UgbWFwLg0KPiA+Pg0KPiA+PiBB
ZGQgYSByZXRyeSBsb29wICh1cCB0byAzIGF0dGVtcHRzIHdpdGggNTAwbXMgZGVsYXlzKSBhcm91
bmQgdGhlDQo+ID4+IHBoeXNpY2FsIGVmdXNlIG1hcCBkdW1wIGluIHJ0dzg5X3BhcnNlX2VmdXNl
X21hcF9heCgpLiBUaGUgZmlybXdhcmUNCj4gPj4gZG93bmxvYWQgcGF0aCBhbHJlYWR5IHJldHJp
ZXMgdXAgdG8gNSB0aW1lcywgYnV0IHRoZSBlZnVzZSByZWFkDQo+ID4+IHRoYXQgZm9sbG93cyBo
YXMgbm8gcmV0cnkgbG9naWMsIG1ha2luZyBpdCB0aGUgd2VhayBsaW5rIGluIHRoZQ0KPiA+PiBw
cm9iZSBzZXF1ZW5jZS4NCj4gPg0KPiA+IEknZCBwcmVmZXIgYWRkaW5nIGEgd3JhcHBlciB0byBy
ZXRyeSA1IHRpbWVzIHdpdGhvdXQgZGVsYXkgYXMgYm90dG9tDQo+ID4gY2hhbmdlcyBmb3IgcmVm
ZXJlbmNlLiBJZiB5b3Ugd2FudCB0byBsaW1pdCByZXRyeSBvbmx5IGZvcg0KPiA+ICdkYXYgPT0g
ZmFsc2UnIGNhc2UsIGl0IGlzIGFsc28gZmluZSB0byBtZS4NCj4gPg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4N
Cj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPj4NCj4gPj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS9lZnVzZS5jIHwgMTMgKysrKysrKysrKysrLQ0KPiA+PiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9lZnVzZS5jDQo+ID4+IGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9lZnVzZS5jDQo+ID4+IGluZGV4IGEyNzU3
YTg4ZDU1ZC4uZDUwNmYwNGZmZDZjIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L2VmdXNlLmMNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9lZnVzZS5jDQo+ID4+IEBAIC0yNzAsNiArMjcwLDcgQEAgaW50IHJ0
dzg5X3BhcnNlX2VmdXNlX21hcF9heChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4+ICAg
ICAgICB1OCAqbG9nX21hcCA9IE5VTEw7DQo+ID4+ICAgICAgICB1OCAqZGF2X3BoeV9tYXAgPSBO
VUxMOw0KPiA+PiAgICAgICAgdTggKmRhdl9sb2dfbWFwID0gTlVMTDsNCj4gPj4gKyAgICAgICBp
bnQgcmV0cnk7DQo+ID4+ICAgICAgICBpbnQgcmV0Ow0KPiA+Pg0KPiA+PiAgICAgICAgaWYgKHJ0
dzg5X3JlYWQxNihydHdkZXYsIFJfQVhfU1lTX1dMX0VGVVNFX0NUUkwpICYNCj4gQl9BWF9BVVRP
TE9BRF9TVVMpDQo+ID4+IEBAIC0yODksNyArMjkwLDE3IEBAIGludCBydHc4OV9wYXJzZV9lZnVz
ZV9tYXBfYXgoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiA+PiAgICAgICAgICAgICAgICBn
b3RvIG91dF9mcmVlOw0KPiA+PiAgICAgICAgfQ0KPiA+Pg0KPiA+PiAtICAgICAgIHJldCA9IHJ0
dzg5X2R1bXBfcGh5c2ljYWxfZWZ1c2VfbWFwKHJ0d2RldiwgcGh5X21hcCwgMCwgcGh5X3NpemUs
DQo+ID4+IGZhbHNlKTsNCj4gPj4gKyAgICAgICBmb3IgKHJldHJ5ID0gMDsgcmV0cnkgPCAzOyBy
ZXRyeSsrKSB7DQo+ID4+ICsgICAgICAgICAgICAgICBpZiAocmV0cnkpIHsNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcnR3ODlfd2FybihydHdkZXYsICJlZnVzZSBkdW1wIGZhaWxlZCwg
cmV0cnlpbmcNCj4gPj4gKCVkKVxuIiwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXRyeSk7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGZzbGVlcCg1MDAw
MDApOw0KPiA+PiArICAgICAgICAgICAgICAgfQ0KPiA+PiArICAgICAgICAgICAgICAgcmV0ID0g
cnR3ODlfZHVtcF9waHlzaWNhbF9lZnVzZV9tYXAocnR3ZGV2LCBwaHlfbWFwLCAwLA0KPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGh5X3Np
emUsIGZhbHNlKTsNCj4gPj4gKyAgICAgICAgICAgICAgIGlmICghcmV0KQ0KPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPj4gKyAgICAgICB9DQo+ID4+ICAgICAgICBpZiAo
cmV0KSB7DQo+ID4+ICAgICAgICAgICAgICAgIHJ0dzg5X3dhcm4ocnR3ZGV2LCAiZmFpbGVkIHRv
IGR1bXAgZWZ1c2UgcGh5c2ljYWwgbWFwXG4iKTsNCj4gPj4gICAgICAgICAgICAgICAgZ290byBv
dXRfZnJlZTsNCj4gPj4gLS0NCj4gPj4gMi40My4wDQo+ID4NCj4gPiBIb3cgYWJvdXQgcmV0cnlp
bmcgNSB0aW1lcyB3aXRob3V0IGZzbGVlcCg1MDAwMDApPw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZWZ1c2UuYw0KPiBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZWZ1c2UuYw0KPiA+IGluZGV4IGEyNzU3YTg4ZDU1
ZC4uODlkNGIxYjg2NWY4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvZWZ1c2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvZWZ1c2UuYw0KPiA+IEBAIC0xODUsOCArMTg1LDggQEAgc3RhdGljIGludCBydHc4
OV9kdW1wX3BoeXNpY2FsX2VmdXNlX21hcF9kYXYoc3RydWN0DQo+IHJ0dzg5X2RldiAqcnR3ZGV2
LCB1OCAqbWFwLA0KPiA+ICAgICAgICByZXR1cm4gMDsNCj4gPiB9DQo+ID4NCj4gPiAtc3RhdGlj
IGludCBydHc4OV9kdW1wX3BoeXNpY2FsX2VmdXNlX21hcChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdk
ZXYsIHU4ICptYXAsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1MzIgZHVtcF9hZGRyLCB1MzIgZHVtcF9zaXplLCBib29sDQo+IGRhdikNCj4gPiArc3RhdGlj
IGludCBfX3J0dzg5X2R1bXBfcGh5c2ljYWxfZWZ1c2VfbWFwKHN0cnVjdCBydHc4OV9kZXYgKnJ0
d2RldiwgdTgNCj4gKm1hcCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTMyIGR1bXBfYWRkciwgdTMyIGR1bXBfc2l6ZSwNCj4gYm9vbCBkYXYpDQo+ID4g
ew0KPiA+ICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gQEAgLTIwOCw2ICsyMDgsMjUgQEAgc3Rh
dGljIGludCBydHc4OV9kdW1wX3BoeXNpY2FsX2VmdXNlX21hcChzdHJ1Y3QgcnR3ODlfZGV2DQo+
ICpydHdkZXYsIHU4ICptYXAsDQo+ID4gICAgICAgIHJldHVybiAwOw0KPiA+IH0NCj4gPg0KPiA+
ICtzdGF0aWMgaW50IHJ0dzg5X2R1bXBfcGh5c2ljYWxfZWZ1c2VfbWFwKHN0cnVjdCBydHc4OV9k
ZXYgKnJ0d2RldiwgdTggKm1hcCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHUzMiBkdW1wX2FkZHIsIHUzMiBkdW1wX3NpemUsIGJvb2wNCj4gZGF2KQ0KPiA+
ICt7DQo+ID4gKyAgICAgICBpbnQgcmV0cnk7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsN
Cj4gPiArICAgICAgIGZvciAocmV0cnkgPSAwOyByZXRyeSA8IDU7IHJldHJ5KyspIHsNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0ID0gX19ydHc4OV9kdW1wX3BoeXNpY2FsX2VmdXNlX21hcChydHdk
ZXYsIG1hcCwNCj4gZHVtcF9hZGRyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGR1bXBfc2l6ZSwgZGF2KTsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKCFyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBydHc4OV93YXJuKHJ0d2RldiwgImVmdXNlIGR1bXAg
KGRhdj0lZCkgZmFpbGVkLCByZXRyeWluZw0KPiAoJWQpXG4iLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRhdiwgcmV0cnkpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAg
ICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gI2RlZmluZSBpbnZhbGlkX2VmdXNl
X2hlYWRlcihoZHIxLCBoZHIyKSBcDQo+ID4gICAgICAgICgoaGRyMSkgPT0gMHhmZiB8fCAoaGRy
MikgPT0gMHhmZikNCj4gPiAjZGVmaW5lIGludmFsaWRfZWZ1c2VfY29udGVudCh3b3JkX2VuLCBp
KSBcDQo+IA0KPiBJ4oCZdmUgcnVuIHNvbWUgYm9vdCB0ZXN0cyBhbmQgdGhpcyBhbHNvIHJlc29s
dmVzIG15IGVmdXNlIG1hcCB1c2UtY2FzZSwgZS5nLg0KPiANCj4gUk9DSzVCOn4gIyBkbWVzZyB8
IGdyZXAgcnR3ODkNCj4gWyAgICA2LjUwNjM3NV0gcnR3ODlfODg1MmJlIDAwMDI6MjE6MDAuMDog
bG9hZGVkIGZpcm13YXJlDQo+IHJ0dzg5L3J0dzg4NTJiX2Z3LTEuYmluDQo+IFsgICAgNi41MDY1
MzldIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAw
MDAzKQ0KPiBbICAgIDYuNTE2MDY5XSBydHc4OV84ODUyYmUgMDAwMjoyMTowMC4wOiBGaXJtd2Fy
ZSB2ZXJzaW9uIDAuMjkuMjkuMTUNCj4gKDZmYjNlYzQxKSwgY21kIHZlcnNpb24gMCwgdHlwZSA1
DQo+IFsgICAgNi41MTYwODNdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IEZpcm13YXJlIHZl
cnNpb24gMC4yOS4yOS4xNQ0KPiAoNmZiM2VjNDEpLCBjbWQgdmVyc2lvbiAwLCB0eXBlIDMNCj4g
WyAgIDEwLjE1MzczMV0gcnR3ODlfODg1MmJlIDAwMDI6MjE6MDAuMDogZWZ1c2UgZHVtcCAoZGF2
PTApIGZhaWxlZCwgcmV0cnlpbmcNCj4gKDApDQo+IFsgICAxMC40MDUzNDddIHJ0dzg5Xzg4NTJi
ZSAwMDAyOjIxOjAwLjA6IGNoaXAgaW5mbyBDSUQ6IDAsIENWOiAxLCBBSUQ6IDAsIEFDVjoNCj4g
MSwgUkZFOiAxDQo+IFsgICAxMC40MDgzMTFdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAwLjA6IHJm
a2lsbCBoYXJkd2FyZSBzdGF0ZSBjaGFuZ2VkIHRvDQo+IGVuYWJsZQ0KPiANCj4gU28gZmFyIEkg
aGF2ZW7igJl0IG9ic2VydmVkIG1vcmUgdGhhbiAxeCByZXRyeSBiZWluZyByZXF1aXJlZCwgYW5k
IHRoZXJlIGFyZSBubw0KPiBpc3N1ZXMgd2l0aCBsb2FkaW5nIHRoZSBCVCBtb2R1bGUuDQoNCk15
IGNoYW5nZXMgZG8gcmV0cnkgZm9yIDUgdGltZXMsIGJlY2F1c2UgeW91ciBwYXRjaCBkb2VzIDMg
dGltZXMgcmV0cnkgcGx1cw0KYWRkaXRpb25hbCA1MDBtcyBkZWxheS4gSSBmZWVsIHlvdSB3YW50
IGFyb3VuZCA1IHNlY29uZHMgZm9yIGxvYWRpbmcgQlQgbW9kdWxlLg0KDQpEaWQgeW91IG1lYW4g
Zm9yIG5vdyB5b3UgY2FuJ3QgcmVwcm9kdWNlIHRoZSBzaXR1YXRpb24gdGhhdCBsb25nIGxvYWRp
bmcNCnRpbWUgb2YgQlQgbW9kdWxlPyAoQnV0IGl0IHRvb2sgbG9uZyB0aW1lIGRheXMgYWdvPykN
Cg0KPiANCj4gV291bGQgeW91IGxpa2UgbWUgdG8gc2VuZCBhIHYyIHVzaW5nIHlvdXIgcmV2aXNl
ZCB2ZXJzaW9uPyAtIG9yPw0KDQpZZXMsIHBsZWFzZSBoZWxwIHYyLg0KDQpQaW5nLUtlDQoNCg==

