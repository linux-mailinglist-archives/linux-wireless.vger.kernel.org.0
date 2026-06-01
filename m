Return-Path: <linux-wireless+bounces-37223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC6bJSTgHGrTTgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 03:28:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 354FE618A14
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 03:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88E3C3003D28
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007E1A6815;
	Mon,  1 Jun 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E4nArSQF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC85B1EB
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277280; cv=none; b=dDtEVnnDKgtIWurqiUf2I2J8x5KvJhPSnlhzhZNu9myPWFDMI8o/066H3L4BfR1bfmUe+OlztIJqWiDQc8inWaUY65gOHb7yAASqfvJvZ5jsPEybxOIPi/3crQDonF6Zh47C3m9+gp6Vmyn8hc4if2HZRxyArXDwA+VpKKDHcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277280; c=relaxed/simple;
	bh=FWLmikSFOPFxI6Oa+72jmWWy5sc7rpCod5kP14uHuyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNFRP8kws5aOIjuC29pfvs849M6s1vxWQCUm/UCLeGuk8yjdyN/l5d3j5bfueH7Y0xXtaIKw7xeY/kRkzELpH1DsjELHis2FmKFUlX7yf8tdNIQRtNaWwCKTG3W9bzIwdV1lVJrGyd9T76gN/8x0+OeZGmvLBDQC78QaN5j6jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E4nArSQF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6511Rk6921706365, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780277266; bh=FWLmikSFOPFxI6Oa+72jmWWy5sc7rpCod5kP14uHuyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E4nArSQFP95RAqYyNqKOFLXDx/qFppKLUry/ezM3bcRbARSy7qrUukKqtFXOqECUE
	 Emf5kg33xEYeeDjkRUUHCS6b8UVTDtZxiFyibh6OChEUGx1xOMw/kkYsmigen9UE38
	 7iwdo5JimU3AKkxBkFlTA8yX+hgRsbW4GThkPkVMGHRvrBnl/A0N5+2FoA17buurB9
	 y5geeN38hAxe1HYOpfNBNX2YhLsVRiXglBBMCCR5ORzdozVeXqoFy2cL9vItEtDg7K
	 Tq/N37+60gSxKS23D9LU53hxxaeqoDw9bqbfbH0qcmJmx/OozZPw/BZp6i51a466cn
	 WKhncWaHmSnbw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6511Rk6921706365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 09:27:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 09:27:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 09:27:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 1 Jun 2026 09:27:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, VolcomIlluminated
	<volcomilluminated@tuta.com>
CC: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: usb: retry control message on -EPROTO error
Thread-Topic: [PATCH] rtw88: usb: retry control message on -EPROTO error
Thread-Index: AQHc7tz+Z+dcBepZBku/0c4Rq/9FiLYkLHcQgABSoACABG2cQA==
Date: Mon, 1 Jun 2026 01:27:46 +0000
Message-ID: <cc86f466e1e24166be243be36b2e2837@realtek.com>
References: <Otk9l6D--F-9@tuta.com>
 <c3e40e8b0a3f4b1e96ca76072700175f@realtek.com>
 <b434e6cb-fe51-49a7-ae66-d6ec833d5b8b@gmail.com>
In-Reply-To: <b434e6cb-fe51-49a7-ae66-d6ec833d5b8b@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-37223-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,tuta.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tuta.com:email];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 354FE618A14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
OS8wNS8yMDI2IDA0OjA5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPiBWb2xjb21JbGx1
bWluYXRlZCA8dm9sY29taWxsdW1pbmF0ZWRAdHV0YS5jb20+IHdyb3RlOg0KPiA+PiAtLS0gL3Rt
cC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMgMjAy
NS0xMS0zMCAxNzo0MjoxMC4wMDAwMDAwMDAgLTA1MDANCj4gPj4gKysrIC9ob21lL3B0cHg4Nm1t
MS9rZXJuZWxidWlsZC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvdXNiLmMgIDIwMjYtMDUtMjQNCj4gMjA6MDY6MjcuNzk4MzM3MjM3IC0wNDAwDQo+ID4NCj4g
PiBZb3VyIGdpdCByZXBvc2l0b3J5IGxvb2tzIHdlaXJkLg0KPiA+DQo+ID4gUGxlYXNlIGNsb25l
IGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvcnR3LmdpdCBhbmQgc3dpdGNoIHRvIHJ0dy1uZXh0
IGJyYW5jaC4NCj4gPg0KPiA+IEJ5IHRoZSB3YXksIHRoZSBzdWJqZWN0IHByZWZpeCBzaG91bGQg
YmUgIltQQVRDSCBydHctbmV4dF0gd2lmaTogcnR3ODg6IC4uLiIuDQo+ID4NCj4gPj4gQEAgLTE0
MCw2ICsxNDAsMTYgQEANCj4gPj4gICAgICByZXQgPSB1c2JfY29udHJvbF9tc2codWRldiwgdXNi
X3NuZGN0cmxwaXBlKHVkZXYsIDApLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
VFdfVVNCX0NNRF9SRVEsIFJUV19VU0JfQ01EX1dSSVRFLA0KPiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhZGRyLCAwLCBkYXRhLCBsZW4sIDUwMCk7DQo+ID4+ICsgICAgaWYgKHJldCA9
PSAtRVBST1RPKSB7DQo+ID4+ICsgICAgICAgICAgICBpbnQgcmV0cnk7DQo+ID4+ICsNCj4gPj4g
KyAgICAgICAgICAgIGZvciAocmV0cnkgPSAwOyByZXRyeSA8IDMgJiYgcmV0ID09IC1FUFJPVE87
IHJldHJ5KyspIHsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgbXNsZWVwKDEwKTsNCj4gPj4g
KyAgICAgICAgICAgICAgICAgICAgcmV0ID0gdXNiX2NvbnRyb2xfbXNnKHVkZXYsIHVzYl9zbmRj
dHJscGlwZSh1ZGV2LCAwKSwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFJUV19VU0JfQ01EX1JFUSwgUlRXX1VTQl9DTURfV1JJVEUsDQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyLCAwLCBkYXRhLCBsZW4s
IDUwMCk7DQo+ID4NCj4gPiBEb24ndCBkdXBsaWNhdGUgdGhlIGNvZGUgb2YgaWRlbnRpY2FsIHVz
Yl9jb250cm9sX21zZyguLi4pLg0KPiA+DQo+ID4gSnVzdA0KPiA+DQo+ID4gZm9yIChyZXRyeSA9
IDA7IHJldHJ5IDwgMzsgcmV0cnkrKykgew0KPiA+ICAgICAgIHJldCA9IHVzYl9jb250cm9sX21z
ZyguLi4pOw0KPiA+ICAgICBpZiAocmV0ICE9IC1FUFJPVE8pDQo+ID4gICAgICAgICAgICAgICBi
cmVhazsNCj4gPg0KPiA+ICAgICAgIG1zbGVlcCgxMCk7IC8qIGRlbGF5IGJlZm9yZSByZXRyeWlu
ZyAqLw0KPiA+IH0NCj4gPg0KPiA+IEJpdHRlcmJsdWUsIGNvdWxkIHlvdSBoYXZlIHNvbWUgaW5w
dXRzIGFib3V0IHRoaXMgcmV0cnksIHNpbmNlIEkgZG9uJ3QgaGF2ZQ0KPiA+IG11Y2gga25vd2xl
ZGdlIGFib3V0IFVTQj8NCj4gPg0KPiANCj4gSSB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIHJl
dHJ5IGluIGNhc2Ugb2YgZXJyb3JzLiBUaGUgdmVuZG9yIGRyaXZlcnMNCj4gdHJ5IHRoZSBjb250
cm9sIG1lc3NhZ2VzIHVwIHRvIDEwIHRpbWVzLCBib3RoIHJlYWRzIGFuZCB3cml0ZXMsIGFuZCBu
b3QNCj4ganVzdCBpbiBjYXNlIG9mIC1FUFJPVE8uDQo+IA0KPiBFeGNlcHQgd2hlbiB3cml0aW5n
IHRoZSBmaXJtd2FyZSBmb3IgdGhlIDgwNTEgY2hpcHMgKGFkZHJlc3MgcmFuZ2UNCj4gMHgxMDAw
Li4weDFmZmYpLiBUaG9zZSB3cml0ZXMgYXJlIG5vdCByZXRyaWVkLCBpbnN0ZWFkIHRoZSBlbnRp
cmUNCj4gZmlybXdhcmUgZG93bmxvYWQgcHJvY2VzcyBpcyByZXRyaWVkIGlmIGl0IGZhaWxzLg0K
PiANCj4gQWxzbywgdGhleSBkb24ndCBzbGVlcCBiZXR3ZWVuIGF0dGVtcHRzLg0KDQpUaGFua3Mg
Zm9yIHRoZSBpbmZvLiANCg0KVm9sY29tSWxsdW1pbmF0ZWQsIHBsZWFzZSBmb2xsb3cgQml0dGVy
Ymx1ZSdzIHN1Z2dlc3Rpb25zIGFzIHZlbmRvciBkcml2ZXIgZG9lcy4NCg0KPiANCj4gQnV0IEkg
d291bGQgbGlrZSB0byBrbm93IG1vcmUgYWJvdXQgdGhlIHByb2JsZW0gZml4ZWQgYnkgdGhpcyBw
YXRjaC4NCj4gV2hhdCByZWdpc3RlciB3cml0ZXMgZmFpbCB3aXRoIC1FUFJPVE8/IEhvdyBvZnRl
biBkb2VzIGl0IGhhcHBlbj8NCj4gSG93IG1hbnkgdGltZXMgd2FzIHRoaXMgcGF0Y2ggdGVzdGVk
Pw0KPiANCj4gSSB3b25kZXIgaWYgdGhlIHByb2JsZW0gaXMgc2ltcGx5IHRoZSB3cml0ZSB0byBy
ZWdpc3RlciAweGM0DQo+IChSRUdfUEFEX0NUUkwyKSB3aGljaCB0cmlnZ2VycyB0aGUgc3dpdGNo
IHRvIFVTQiAzPyBMaWtlIHdpdGggdGhlDQo+IHdpZmkgNiBhbmQgNyBjaGlwcywgdGhhdCBjYWxs
IHRvIHVzYl9jb250cm9sX21zZygpIGFsd2F5cyByZXR1cm5zDQo+IC1FUFJPVE8uIEkgYXNzdW1l
IGl0J3MgYmVjYXVzZSBpdCBtYWtlcyB0aGUgVVNCIGRldmljZSBkaXNhcHBlYXIuDQoNClRoZSBj
b21taXQgbWVzc2FnZSBvZiBvcmlnaW5hbCBwYXRjaCBkb2Vzbid0IHBvaW50IG91dCAid3JpdGUg
cmVnaXN0ZXIgMHgleCIuDQpWb2xjb21JbGx1bWluYXRlZCwgcGxlYXNlIHNoYXJlIHRoaXMgaW5m
byB0b28uIA0KDQo+IA0KPiA+PiArICAgICAgICAgICAgfQ0KPiA+PiArICAgIH0NCj4gPj4gICAg
ICBpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVOT0RFViAmJiBjb3VudCsrIDwgNCkNCj4gPj4gICAg
ICAgICAgICAgIHJ0d19lcnIocnR3ZGV2LCAid3JpdGUgcmVnaXN0ZXIgMHgleCBmYWlsZWQgd2l0
aCAlZFxuIiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgYWRkciwgcmV0KTsNCj4gPg0KDQo=

