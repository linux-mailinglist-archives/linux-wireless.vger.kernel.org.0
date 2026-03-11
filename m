Return-Path: <linux-wireless+bounces-32946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgmC0HcsGmHnwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 04:06:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0E25B45E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 04:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CF6230832E9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD73542F3;
	Wed, 11 Mar 2026 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dK7vN+US"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423D156F45;
	Wed, 11 Mar 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198361; cv=none; b=hNU9r2OlDV+PN5FjiBez6Dq181CG53fo7WLBRsXVP9OAwD89pDylX1bv2biN7pX1D/S7G2WbnntYZSsvcTAJ7v+7I9MUnPXtbDfr1X5yfy1Vc7UuTY3cS28kBJ7Ug9PHibx/lvoLnvgASFOG/KRMbcDeiLvEcqy/uFW+CJ4ftzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198361; c=relaxed/simple;
	bh=oT6ajNsWeEfP/Ksn8sitllj1pKLz+4MSr55sEaUa39E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSi44bvMq1NmPEnAnIMpzSuVn097lN9lal3RrVqFetLWhdAlEyiEtOTFsPLFrnoajHAA12VGGs2hgirf/eLNEiafiV0IUPGmtU4lDFu/dV6KN4VTiIWuazit2jHAyK0EH5iCWpo9xhRniUI2Y0L+JqSB41OHLfhwdrIf3S+lbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dK7vN+US; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62B35smyE3798119, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773198355; bh=oT6ajNsWeEfP/Ksn8sitllj1pKLz+4MSr55sEaUa39E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dK7vN+USgQA8HeDKGT4YsiAviWOOaSxIrUAKK68j6gODuJncO8hG13tXKDxP4P7M8
	 EfBN7H/zcKsjgVGwRO1z83bBMJql4hU6SOPipwQcFBz0KbMKoMyBQVAe3HanwhPRgh
	 QQI+2YbLcIAmN4sod+kSmZfe3xdvWj3oo6R6E+bCSQtWUJ18NUAmRuQrtUrSNYs0Gn
	 KzGn15EUkZP/mLSauh9fVYZzye9JdtUcMSEhNHf2lO0lN0knmTQiZ09/IrrypS1eP4
	 HGPytOT0CB73Bcs+QIi4i7bSSfx6fp12CZkE3zJHPSVauykeCFpKu2Hs9pxSoAD7kT
	 wN0wJ9f+6U5Bg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62B35smyE3798119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 11:05:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Mar 2026 11:05:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Mar 2026 11:05:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q//99hoCAAIbrQP//fzIAgAtGLdCAAgS2AIABJ37Q
Date: Wed, 11 Mar 2026 03:05:54 +0000
Message-ID: <2ab692371ff94a3f960d41b04288a084@realtek.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
 <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
 <c764f16a880a400686c8c5f639fa98c3@realtek.com>
 <903C7E52-033F-455E-89DC-B78C67C0C732@gmail.com>
 <5ad1b7d20d1745bab0638d15731e7ccd@realtek.com>
 <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
In-Reply-To: <CC1F2CDA-830F-4351-A855-8C921B148F8D@gmail.com>
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
X-Rspamd-Queue-Id: 90A0E25B45E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32946-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,libreelec.tv:url]
X-Rspamd-Action: no action

Q2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBPbiA5IE1hciAyMDI2LCBhdCA2OjM14oCvYW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IENocmlzdGlhbiBIZXdpdHQgPGNocmlzdGlhbnNo
ZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IE9uIDIgTWFyIDIwMjYsIGF0IDEw
OjA04oCvYW0sIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPj4+
DQo+ID4+PiBDaHJpc3RpYW4gSGV3aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3Jv
dGU6DQo+ID4+Pj4+IE9uIDIgTWFyIDIwMjYsIGF0IDk6NDfigK9hbSwgUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBDaHJpc3RpYW4gSGV3
aXR0IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+PiBPbiBSYWR4
YSBSb2NrIDVCIHdpdGggYSBSVEw4ODUyQkUgY29tYm8gV2lGaS9CVCBjYXJkLCB0aGUgZWZ1c2UN
Cj4gPj4+Pj4+IHBoeXNpY2FsIG1hcCBkdW1wIGludGVybWl0dGVudGx5IGZhaWxzIHdpdGggLUVC
VVNZIGR1cmluZyBwcm9iZS4NCj4gPj4+Pj4+IFRoZSBmYWlsdXJlIG9jY3VycyBpbiBydHc4OV9k
dW1wX3BoeXNpY2FsX2VmdXNlX21hcF9kZHYoKSB3aGVyZQ0KPiA+Pj4+Pj4gcmVhZF9wb2xsX3Rp
bWVvdXRfYXRvbWljKCkgdGltZXMgb3V0IHdhaXRpbmcgZm9yIHRoZSBCX0FYX0VGX1JEWQ0KPiA+
Pj4+Pj4gYml0IGFmdGVyIDEgc2Vjb25kLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJJ20gY2hlY2tpbmcg
aW50ZXJuYWxseSBob3cgd2UgaGFuZGxlIHRoaXMgY2FzZS4NCj4gPg0KPiA+IFNvcnJ5IGZvciB0
aGUgbGF0ZS4NCj4gPg0KPiA+IFdlIGVuY291bnRlcmVkIFdpRmkvQlQgcmVhZGluZyBlZnVzZSBh
dCB0aGUgc2FtZSB0aW1lIGNhdXNpbmcgc2ltaWxhcg0KPiA+IHByb2JsZW0gYXMgeW91cnMuIFRo
ZSB3b3JrYXJvdW5kIGlzIGxpa2UgeW91cnMsIHdoaWNoIGFkZHMgdGltZW91dA0KPiA+IHRpbWUu
DQo+ID4NCj4gPj4+Pj4NCj4gPj4+Pj4gWy4uLl0NCj4gPj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBGb3IgY29udGV4dCwgZmlybXdhcmUgYWxzbyBmYWlscyAoYW5kIHJlY292ZXJzKSBzb21ldGlt
ZXM6DQo+ID4+Pj4+DQo+ID4+Pj4+IERpZCB5b3UgbWVhbiB0aGlzIGRvZXNuJ3QgYWx3YXlzIGhh
cHBlbj8gc29tZXRpbWVzPw0KPiA+Pj4+DQo+ID4+Pj4gSXTigJlzIGFub3RoZXIgaW50ZXJtaXR0
ZW50IGJlaGF2aW91ciBvYnNlcnZlZCBvbiB0aGlzIGJvYXJkIChhbmQgbm90DQo+ID4+Pj4gcmVs
YXRlZCB0byB0aGUgaXNzdWUgdGhpcyBwYXRjaCB0YXJnZXRzKS4gSXQgb2NjdXJzIGxlc3MgZnJl
cXVlbnRseQ0KPiA+Pj4+IHRoYW4gdGhlIGVmdXNlIGlzc3VlIGFuZCB0aGUgZXhpc3RpbmcgcmV0
cnkgbWVjaGFuaXNtIGluIHRoZSBkcml2ZXINCj4gPj4+PiBlbnN1cmVzIGZpcm13YXJlIGxvYWQg
YWx3YXlzIHN1Y2NlZWRzLg0KPiA+DQo+ID4gVGhpcyBtaWdodCBiZSB0aGUgc2FtZSBjYXVzZSBk
dWUgdG8gcmVhZGluZyBlZnVzZSBpbiBmaXJtd2FyZS4NCj4gPg0KPiA+IFRob3VnaCB3ZSBjYW4g
YWRkIG1vcmUgdGltZW91dCBhbmQgcmV0cnkgdGltZXMgYXMgd29ya2Fyb3VuZCwgSSB3b25kZXIN
Cj4gPiBpZiB5b3UgY2FuIGNvbnRyb2wgbG9hZGluZyB0aW1lIG9mIFdpRmkgYW5kIEJUIGtlcm5l
bCBtb2R1bGVzPw0KPiA+DQo+ID4gTW9yZSwgY2FuIHlvdSBkbyBleHBlcmltZW50IHRoYXQgeW91
IGxvYWQgQlQgbW9kdWxlIGZpcnN0LCBhbmQgdGhlbiBsb2FkDQo+ID4gV2lGaSBtb2R1bGUgYWZ0
ZXIgMTAgc2Vjb25kcyAoY2hvb3NlIGEgbGFyZ2UgbnVtYmVyIGludGVudGlvbmFsbHksIG9yDQo+
ID4gZXZlbiBsYXJnZXIpPw0KPiANCj4gaHR0cHM6Ly9wYXN0ZS5saWJyZWVsZWMudHYvY2hhcm1l
ZC10dXJrZXkuc2gNCj4gDQo+IEnigJl2ZSBydW4gdGhlIGFib3ZlIHNjcmlwdCBeIHdoaWNoIHJl
bW92ZXMgdGhlIHdpZmkgYW5kIGJ0IG1vZHVsZXMgaW4NCj4gc2VxdWVuY2UgdGhlbiByZWxvYWRz
IHRoZW0gaW4gdGhlIHJldmVyc2Ugb3JkZXIgd2l0aCBhIGRlbGF5IGJldHdlZW4NCj4gYnQgYW5k
IHdpZmkgbW9kdWxlcyBsb2FkaW5nLCB0aGVuIGNoZWNrcyBmb3IgZXJyb3IgbWVzc2FnZXMuIE92
ZXIgMjAwDQo+IHRlc3QgY3ljbGVzIHdpdGggYSAxMHMgZGVsYXkgYWxsIHdlcmUgY2xlYW4gKG5v
IGVycm9ycykuIEkgYWxzbyByYW4NCj4gY3ljbGVzIHdpdGggYSAyIHNlY29uZCBkZWxheSBhbmQg
MCBzZWNvbmQgZGVsYXkgYmVmb3JlIHN0YXJ0aW5nIHdpZmkNCj4gbW9kdWxlIGxvYWQgYW5kIHRo
b3NlIHdlcmUgY2xlYXIgdG9vLiBJIGd1ZXNzIHRoYXQgcHJvdmVzIHNlcXVlbmNpbmcNCj4gYXZv
aWRzIHRoZSBlZnVzZSBjb250ZW50aW9uIGlzc3VlPyAtIGFsdGhvdWdoIGl04oCZcyBub3QgcG9z
c2libGUgaW4NCj4gdGhlIHJlYWwtd29ybGQgc28gbm90IHN1cmUgdGhlcmXigJlzIGh1Z2UgdmFs
dWUgaW4ga25vd2luZyB0aGF0IDopDQoNClRoYW5rcyBmb3IgdGhlIGV4cGVyaW1lbnRzLiANCg0K
U3RpbGwgd2FudCB0byBrbm93IGlzIGl0IHBvc3NpYmxlIHRvIGNoYW5nZSBzZXF1ZW5jZS90aW1l
IG9mIGxvYWRpbmcNCmtlcm5lbCBtb2R1bGVzIGF0IGJvb3QgdGltZSBmcm9tIHN5c3RlbSBsZXZl
bD8gSSBtZWFuIGNhbiB5b3UgYWRqdXN0DQp0aGUgc2VxdWVuY2UgaW4gdGhlIFJvY2sgNUIgYm9h
cmQ/DQoNCkluIGFkZGl0aW9uLCBkaWQgYmVsb3cgbWVzc2FnZXMgbm90IGFwcGVhciBpbiB0aGVz
ZSBleHBlcmltZW50cz8gDQoNClsgICAgNy44NjQxNDhdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIxOjAw
LjA6IGZ3IHNlY3VyaXR5IGZhaWwNClsgICAgNy44NjQxNTRdIHJ0dzg5Xzg4NTJiZSAwMDAyOjIx
OjAwLjA6IGRvd25sb2FkIGZpcm13YXJlIGZhaWwNCg0KUGluZy1LZQ0KDQo=

