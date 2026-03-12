Return-Path: <linux-wireless+bounces-33072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH5nAnd5sml/MwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:29:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91426EF45
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A40308661A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37234B1A4;
	Thu, 12 Mar 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Tqzjqs3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250332C937;
	Thu, 12 Mar 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304095; cv=none; b=J64DVt9CNq4GbAeqPwl7Kgt0ODLYV9lpEpqms1X/KfOUJVnlPWsPscdL4XSRL5SmL46zidJxQWDffyp4Ld/liVC7AKKVlOfr5vsmDDTn0sHIrQ3DFz5ApuBDZdm76V/HJub72oU3oonZ+sS+91/kmrpF1XSvEHRbZnstScuaZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304095; c=relaxed/simple;
	bh=15ijwmR4QO3vXp9uKbYKPFBHNj3YuYCCob0yi5GarGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rnKvDQqLB0jgsMF4sdOp8CmAvTZMuC673PV8hSg1Y3PdtJiTEAeyzI6eJatzN7W/YQWCm5WmFZC2AX7ug8DrIIMlOtV9ywfot+vpcx6uvz5scZDBZnyXm+Xz8ky+BonFmPl+QqyA57m/ppoMsq7fB8/HNCIkyRToTYT4CBHI4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Tqzjqs3J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62C8S9RS02218320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773304089; bh=15ijwmR4QO3vXp9uKbYKPFBHNj3YuYCCob0yi5GarGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Tqzjqs3Je0ddTOPJyolNMPg/jn/DzmLsSBdv3zOGgiYsftULXo/pEnLPyvv0P0le6
	 w2HRAyUOgjfwiT4sfqm1zknmMcKiOuY3DA0Fhu+SonYuGMFzJq1Ue33NxSlooaL+RE
	 +zUXYOtbDQiqUPysx+pwrK/zrp5nOWBdJfvpbuB/g14anZ2Nh/tsZx1lxIUA7euLZE
	 AxcJyfJCILhT4hi2I1O6SXKQitbgMm58VEPdjVcnEJRD6a31BzpPwbXrlIOixvu0ef
	 KXca6qV8tnDA83AVgbSp+y3rHDDT96o2tHqZxxqCeWvaiXNrhHWxjRU2Z3TJGTYcQ7
	 Gxfpov5Brs/fg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62C8S9RS02218320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 16:28:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 12 Mar 2026 16:28:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 12 Mar 2026 16:28:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christian Hewitt <christianshewitt@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Topic: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
Thread-Index: AQHcqTNMihHWcqnNfk6dLicVJRRJxLWavE1Q//99hoCAAIbrQP//fzIAgAtGLdCAAgS2AIABJ37Q//+R6YAAPhAkoP//vWCA//9gbHCAAMSZgP//dsQg
Date: Thu, 12 Mar 2026 08:28:08 +0000
Message-ID: <3dbffdd1086f48b58eff048c3fa99db9@realtek.com>
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
 <3f072307ed634e878c7d9da152801aec@realtek.com>
 <70E90B9D-4C33-46B0-92B7-46969F6AF7B0@gmail.com>
In-Reply-To: <70E90B9D-4C33-46B0-92B7-46969F6AF7B0@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-33072-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 5F91426EF45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Q2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBPbiAxMiBNYXIgMjAyNiwgYXQgMTE6MznigK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ2hyaXN0aWFuIEhld2l0dCA8Y2hyaXN0aWFu
c2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4gT24gMTIgTWFyIDIwMjYsIGF0IDY6MjLi
gK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+Pj4NCj4g
Pj4+IENocmlzdGlhbiBIZXdpdHQgPGNocmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToN
Cj4gPj4+Pj4gT24gMTEgTWFyIDIwMjYsIGF0IDc6MDXigK9hbSwgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBDaHJpc3RpYW4gSGV3aXR0
IDxjaHJpc3RpYW5zaGV3aXR0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4+
IE9uIDkgTWFyIDIwMjYsIGF0IDY6MzXigK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gQ2hyaXN0aWFuIEhld2l0dCA8Y2hy
aXN0aWFuc2hld2l0dEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4g
T24gMiBNYXIgMjAyNiwgYXQgMTA6MDTigK9hbSwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IENocmlzdGlhbiBIZXdpdHQg
PGNocmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+Pj4+Pj4gT24gMiBN
YXIgMjAyNiwgYXQgOTo0N+KAr2FtLCBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4g
d3JvdGU6DQo+ID4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+IENocmlzdGlhbiBIZXdpdHQgPGNo
cmlzdGlhbnNoZXdpdHRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+Pj4+Pj4+IE9uIFJhZHhh
IFJvY2sgNUIgd2l0aCBhIFJUTDg4NTJCRSBjb21ibyBXaUZpL0JUIGNhcmQsIHRoZSBlZnVzZQ0K
PiA+Pj4+Pj4+Pj4+Pj4gcGh5c2ljYWwgbWFwIGR1bXAgaW50ZXJtaXR0ZW50bHkgZmFpbHMgd2l0
aCAtRUJVU1kgZHVyaW5nIHByb2JlLg0KPiA+Pj4+Pj4+Pj4+Pj4gVGhlIGZhaWx1cmUgb2NjdXJz
IGluIHJ0dzg5X2R1bXBfcGh5c2ljYWxfZWZ1c2VfbWFwX2RkdigpIHdoZXJlDQo+ID4+Pj4+Pj4+
Pj4+PiByZWFkX3BvbGxfdGltZW91dF9hdG9taWMoKSB0aW1lcyBvdXQgd2FpdGluZyBmb3IgdGhl
IEJfQVhfRUZfUkRZDQo+ID4+Pj4+Pj4+Pj4+PiBiaXQgYWZ0ZXIgMSBzZWNvbmQuDQo+ID4+Pj4+
Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+IEknbSBjaGVja2luZyBpbnRlcm5hbGx5IGhvdyB3ZSBoYW5k
bGUgdGhpcyBjYXNlLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gU29ycnkgZm9yIHRoZSBsYXRlLg0K
PiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gV2UgZW5jb3VudGVyZWQgV2lGaS9CVCByZWFkaW5nIGVmdXNl
IGF0IHRoZSBzYW1lIHRpbWUgY2F1c2luZyBzaW1pbGFyDQo+ID4+Pj4+Pj4gcHJvYmxlbSBhcyB5
b3Vycy4gVGhlIHdvcmthcm91bmQgaXMgbGlrZSB5b3Vycywgd2hpY2ggYWRkcyB0aW1lb3V0DQo+
ID4+Pj4+Pj4gdGltZS4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+PiBb
Li4uXQ0KPiA+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4+IEZvciBj
b250ZXh0LCBmaXJtd2FyZSBhbHNvIGZhaWxzIChhbmQgcmVjb3ZlcnMpIHNvbWV0aW1lczoNCj4g
Pj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4gRGlkIHlvdSBtZWFuIHRoaXMgZG9lc24ndCBhbHdh
eXMgaGFwcGVuPyBzb21ldGltZXM/DQo+ID4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+PiBJdOKAmXMg
YW5vdGhlciBpbnRlcm1pdHRlbnQgYmVoYXZpb3VyIG9ic2VydmVkIG9uIHRoaXMgYm9hcmQgKGFu
ZCBub3QNCj4gPj4+Pj4+Pj4+PiByZWxhdGVkIHRvIHRoZSBpc3N1ZSB0aGlzIHBhdGNoIHRhcmdl
dHMpLiBJdCBvY2N1cnMgbGVzcyBmcmVxdWVudGx5DQo+ID4+Pj4+Pj4+Pj4gdGhhbiB0aGUgZWZ1
c2UgaXNzdWUgYW5kIHRoZSBleGlzdGluZyByZXRyeSBtZWNoYW5pc20gaW4gdGhlIGRyaXZlcg0K
PiA+Pj4+Pj4+Pj4+IGVuc3VyZXMgZmlybXdhcmUgbG9hZCBhbHdheXMgc3VjY2VlZHMuDQo+ID4+
Pj4+Pj4NCj4gPj4+Pj4+PiBUaGlzIG1pZ2h0IGJlIHRoZSBzYW1lIGNhdXNlIGR1ZSB0byByZWFk
aW5nIGVmdXNlIGluIGZpcm13YXJlLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gVGhvdWdoIHdlIGNh
biBhZGQgbW9yZSB0aW1lb3V0IGFuZCByZXRyeSB0aW1lcyBhcyB3b3JrYXJvdW5kLCBJIHdvbmRl
cg0KPiA+Pj4+Pj4+IGlmIHlvdSBjYW4gY29udHJvbCBsb2FkaW5nIHRpbWUgb2YgV2lGaSBhbmQg
QlQga2VybmVsIG1vZHVsZXM/DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBNb3JlLCBjYW4geW91IGRv
IGV4cGVyaW1lbnQgdGhhdCB5b3UgbG9hZCBCVCBtb2R1bGUgZmlyc3QsIGFuZCB0aGVuIGxvYWQN
Cj4gPj4+Pj4+PiBXaUZpIG1vZHVsZSBhZnRlciAxMCBzZWNvbmRzIChjaG9vc2UgYSBsYXJnZSBu
dW1iZXIgaW50ZW50aW9uYWxseSwgb3INCj4gPj4+Pj4+PiBldmVuIGxhcmdlcik/DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gaHR0cHM6Ly9wYXN0ZS5saWJyZWVsZWMudHYvY2hhcm1lZC10dXJrZXkuc2gN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBJ4oCZdmUgcnVuIHRoZSBhYm92ZSBzY3JpcHQgXiB3aGljaCBy
ZW1vdmVzIHRoZSB3aWZpIGFuZCBidCBtb2R1bGVzIGluDQo+ID4+Pj4+PiBzZXF1ZW5jZSB0aGVu
IHJlbG9hZHMgdGhlbSBpbiB0aGUgcmV2ZXJzZSBvcmRlciB3aXRoIGEgZGVsYXkgYmV0d2Vlbg0K
PiA+Pj4+Pj4gYnQgYW5kIHdpZmkgbW9kdWxlcyBsb2FkaW5nLCB0aGVuIGNoZWNrcyBmb3IgZXJy
b3IgbWVzc2FnZXMuIE92ZXIgMjAwDQo+ID4+Pj4+PiB0ZXN0IGN5Y2xlcyB3aXRoIGEgMTBzIGRl
bGF5IGFsbCB3ZXJlIGNsZWFuIChubyBlcnJvcnMpLiBJIGFsc28gcmFuDQo+ID4+Pj4+PiBjeWNs
ZXMgd2l0aCBhIDIgc2Vjb25kIGRlbGF5IGFuZCAwIHNlY29uZCBkZWxheSBiZWZvcmUgc3RhcnRp
bmcgd2lmaQ0KPiA+Pj4+Pj4gbW9kdWxlIGxvYWQgYW5kIHRob3NlIHdlcmUgY2xlYXIgdG9vLiBJ
IGd1ZXNzIHRoYXQgcHJvdmVzIHNlcXVlbmNpbmcNCj4gPj4+Pj4+IGF2b2lkcyB0aGUgZWZ1c2Ug
Y29udGVudGlvbiBpc3N1ZT8gLSBhbHRob3VnaCBpdOKAmXMgbm90IHBvc3NpYmxlIGluDQo+ID4+
Pj4+PiB0aGUgcmVhbC13b3JsZCBzbyBub3Qgc3VyZSB0aGVyZeKAmXMgaHVnZSB2YWx1ZSBpbiBr
bm93aW5nIHRoYXQgOikNCj4gPj4+Pj4NCj4gPj4+Pj4gVGhhbmtzIGZvciB0aGUgZXhwZXJpbWVu
dHMuDQo+ID4+Pj4+DQo+ID4+Pj4+IFN0aWxsIHdhbnQgdG8ga25vdyBpcyBpdCBwb3NzaWJsZSB0
byBjaGFuZ2Ugc2VxdWVuY2UvdGltZSBvZiBsb2FkaW5nDQo+ID4+Pj4+IGtlcm5lbCBtb2R1bGVz
IGF0IGJvb3QgdGltZSBmcm9tIHN5c3RlbSBsZXZlbD8gSSBtZWFuIGNhbiB5b3UgYWRqdXN0DQo+
ID4+Pj4+IHRoZSBzZXF1ZW5jZSBpbiB0aGUgUm9jayA1QiBib2FyZD8NCj4gPj4+Pg0KPiA+Pj4+
IEnigJltIG5vdCBhIGtlcm5lbCBleHBlcnQsIGJ1dCBJ4oCZdmUgYWx3YXlzIHVuZGVyc3Rvb2Qg
bW9kdWxlIHByb2JlIGFuZA0KPiA+Pj4+IGxvYWQgb3JkZXJpbmcgdG8gbm90IGJlIGd1YXJhbnRl
ZWQ7IGFzIG1hbnkgdGhpbmdzIHJ1biBpbiBwYXJhbGxlbCBhbmQNCj4gPj4+PiBhcmUgaGlnaGx5
IHN1YmplY3RpdmUgdG8gdGhlIHNwZWNpZmljIGhhcmR3YXJlIGNhcGFiaWxpdGllcyBhbmQga2Vy
bmVsDQo+ID4+Pj4gY29uZmlnIGJlaW5nIHVzZWQuDQo+ID4+Pg0KPiA+Pj4gSSBoYXZlIGhlYXJk
IHBlb3BsZSBhYm91dCBjaGFuZ2luZyBzZXF1ZW5jZS90aW1lIG9mIGtlcm5lbCBtb2R1bGVzLCBz
bw0KPiA+Pj4gSSdkIGxpa2UgeW91IGNhbiB0cnkgdGhpcyBtZXRob2QuDQo+ID4+Pg0KPiA+Pj4g
SSBkaWQgYXNrIEFJLCBpdCBzYWlkIGl0IGlzIHBvc3NpYmxlIHRvIGNyZWF0ZSBhIC5jb25mIGZp
bGUgdW5kZXINCj4gPj4+IC9ldGMvbW9kcHJvYmUuZC8gYW5kIHVzZSBgc29mdGRlcGAgc3ludGF4
IHRvIGVuc3VyZSBsb2FkaW5nIHNlcXVlbmNlLg0KPiA+Pj4gQ291bGQgeW91IHRyeSB0aGlzPw0K
PiA+Pg0KPiA+PiBJIGNhbiB0ZXN0IHRoaXMsIGJ1dCBldmVuIGlmIGl0IHdvcmtzIGl04oCZcyBu
b3QgYSBmaXggYmVjYXVzZSBtb2Rwcm9iZQ0KPiA+PiBjb25mcyBjb25maWd1cmVkIGluIHVzZXJz
cGFjZSBhcmUgb25seSB1c2VkIHdpdGggbG9hZGFibGUgbW9kdWxlcyB0aGF0DQo+ID4+IGhhdmUg
YmVlbiBjb21waWxlZCB3aXRoID1tLCBub3QgYnVpbGQtaW4gbW9kdWxlcyB0aGF0IGFyZSByZXNp
ZGVudCBpbg0KPiA+PiBrZXJuZWwgbWVtb3J5IGFuZCBjb21waWxlZCB3aXRoID15OyBhbmQgZGlz
dHJvcyBhcmUgZnJlZSB0byBjaG9vc2UgaG93DQo+ID4+IHRoZWlyIGtlcm5lbCBpcyBjb25maWd1
cmVkLiBOQjogSeKAmW0gbm90IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBnZW5lcmFsDQo+ID4+IGtl
cm5lbCBydWxlcyBmb3IgdGhpcywgYnV0IEnigJlkIGV4cGVjdCB0aGVyZSB0byBiZSBnZW5lcmFs
IHByaW5jaXBsZSBvZg0KPiA+PiBtb2R1bGVzIGJlaW5nIHJlc2lsaWVudCB0byB0cmFuc2llbnQg
aG9zdCBzdGF0ZXMgYW5kIG5vdCBkZXBlbmRpbmcgb24NCj4gPj4gdXNlcnNwYWNlIHBhY2thZ2lu
ZyB0byBsb2FkIGNvcnJlY3RseT8NCj4gPg0KPiA+IEkgdGhpbmsgYnVpbHQtaW4gbW9kdWxlcyB3
aWxsIGJlIGxvYWRlZCBzZXF1ZW50aWFsbHkgKG5vdCBpbiBwYXJhbGxlbCkNCj4gPiBieSBkZXZp
Y2VfaW5pdGljYWxsKCksIHNvIEJUIGFuZCBXaUZpIGRyaXZlcnMgd2lsbCBub3QgcmVhZCBlZnVz
ZQ0KPiA+IGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBFdmVuIGlmIGJ1aWx0LWluIG1vZHVsZXMg
YXJlIGxvYWRlZCBzZXF1ZW50aWFsbHksIHRoZSBrZXJuZWwgc3RpbGwgaGFzDQo+IG1hbnkgZHlu
YW1pY2FsbHkgbG9hZGVkIG1vZHVsZXM7IGFuZCBkaXN0cm9zIGNhbiBjb25maWd1cmUgdGhhdCBt
aXggYXMNCj4gdGhleSBsaWtlLCBzbyB5b3Ugc3RpbGwgY2Fubm90IHByZWRpY3Qgb3IgZ3VhcmFu
dGVlIHRoZSBvdXRjb21lLiBUaGF0DQo+IGNvdWxkIGJlIGNoYW5nZWQgYnkgcmVxdWlyaW5nIHJ0
dzg5IG1vZHVsZXMgdG8gYmUgPXksIGJ1dCB0aGF0IGdvZXMNCj4gYWdhaW5zdCB0aGUgcHJpbmNp
cGxlcyBvZiBhIG1vZHVsYXIga2VybmVsIGFuZCBJ4oCZZCBleHBlY3QgYXBwcm9wcmlhdGVseQ0K
PiBydWRlIGNvbW1lbnRzIHRvIHRoZSBpZGVhIGlmIHN1Ym1pdHRlZCA6KQ0KDQpBcyBJIGtub3cs
IGR5bmFtaWNhbCBtb2R1bGVzIGFyZSBleGVjdXRlZCBhZnRlciBpbml0IHByb2Nlc3MsIGJ1dCB0
aGF0J3MNCm5vdCB5b3VyIGNhc2UuIExldCdzIGNsYXJpZnkgaWYgL2V0Yy9tb2Rwcm9iZS5kLyB3
aXRoIGBzb2Z0ZGVwYCBvcHRpb24NCmNhbiByZXNvbHZlIHlvdXIgcHJvYmxlbS4gSSdkIGxpa2Ug
dG8ga25vdyB0aGUgcmVzdWx0LiA6KQ0KDQo+IA0KPiA+Pj4+IEluIGFkZGl0aW9uLCBkaWQgYmVs
b3cgbWVzc2FnZXMgbm90IGFwcGVhciBpbiB0aGVzZSBleHBlcmltZW50cz8NCj4gPj4+Pj4NCj4g
Pj4+Pj4gWyAgICA3Ljg2NDE0OF0gcnR3ODlfODg1MmJlIDAwMDI6MjE6MDAuMDogZncgc2VjdXJp
dHkgZmFpbA0KPiA+Pj4+PiBbICAgIDcuODY0MTU0XSBydHc4OV84ODUyYmUgMDAwMjoyMTowMC4w
OiBkb3dubG9hZCBmaXJtd2FyZSBmYWlsDQo+ID4+Pj4NCj4gPj4+PiBObywgYmVjYXVzZSBldmVu
IGlmIHdlIGhhdmUgYSAwcyBkZWxheSBiZXR3ZWVuIGVhY2ggZ3JvdXAgb2YgbW9kdWxlcw0KPiA+
Pj4+IGJlaW5nIGxvYWRlZCwgdGhleSBhcmUgbG9hZGVkIGluIHNlcmllcywgc28gd2Ugd29ya2Fy
b3VuZCB0aGUgaXNzdWUuDQo+ID4+Pj4gVHdlYWtpbmcgdGhlIHNjcmlwdCB0byBiYWNrZ3JvdW5k
IHRoZSBtb2R1bGUgbG9hZCBsb29wcyBzbyBib3RoIHJ1bg0KPiA+Pj4+IGluIHBhcmFsbGVsIHdv
dWxkIGJlIGNsb3NlciB0byBub3JtYWwgY29uZGl0aW9ucywgYW5kIEkgd291bGQgZXhwZWN0DQo+
ID4+Pj4gdG8gc3RhcnQgc2VlaW5nIGZhaWx1cmVzIGFuZCB0aGUgcmV0cnkgbWVjaGFuaXNtcyB3
aXRoaW4gdGhlIG1vZHVsZXMNCj4gPj4+PiAoYXMgYWRkZWQgaW4gdGhpcyBwYXRjaCkgYmVpbmcg
dHJpZ2dlcmVkLg0KPiA+Pj4NCj4gPj4+IEFkZGl0aW9uYWwgcXVlc3Rpb24gZm9yIGRvd25sb2Fk
aW5nIGZpcm13YXJlLiBBcyB5b3UgcmVwb3J0ZWQgdGhpcw0KPiA+Pj4gaXNzdWUgaW5pdGlhbGx5
IChsb2FkIG1vZHVsZXMgYXQgYm9vdCB0aW1lIGluIHBhcmFsbGVsKSwgaXQgc2VlbXMNCj4gPj4+
IGFwcGVhciB0aGlzIG1lc3NhZ2UgYnkgY2hhbmNlLiBTaW5jZSB0aGlzIGRyaXZlciB3aWxsIHJl
dHJ5IHRvIGRvd25sb2FkDQo+ID4+PiBmaXJtd2FyZSwgd2lsbCBpdCBzdWNjZXNzZnVsbHkgZG93
bmxvYWRzIGZpcm13YXJlIGZpbmFsbHk/IE9yIGl0IHN0aWxsDQo+ID4+PiBmYWlscyB0byBkb3du
bG9hZCBhZnRlciA1IHRpbWVzIHJldHJ5Pw0KPiA+Pg0KPiA+PiBJIGhhdmUgb25seSBzZWVuIGZp
cm13YXJlIGxvYWQgZmFpbCBhIGhhbmRmdWwgb2YgdGltZXMgaW4gbWFueSBodW5kcmVkcw0KPiA+
PiBvZiBib290cyBhbmQgZWFjaCB0aW1lIG9uZSByZXRyeSBhdHRlbXB0IHJlc3VsdGVkIGluIHN1
Y2Nlc3MuIFRvIGJlDQo+ID4+IGNsZWFyOyBJIGhhdmUgYW0gbm90IHJlcG9ydGluZyBmaXJ3bWFy
ZSBsb2FkaW5nIGFzIGEgcHJvYmxlbSwgaXQgaXMgbm90DQo+ID4+IGFuIGlzc3VlIGZvciBtZS4g
SeKAmXZlIG1lbnRpb25lZCBpdCBvbmx5IGZvciBjb250ZXh0LCBpLmUuIGl0IHNob3dzIHRoYXQN
Cj4gPj4gYSBzaW1wbGUgcmV0cnkgbWVjaGFuaXNtIGlzIGVmZmVjdGl2ZSBhdCBoYW5kbGluZyB0
aGUgc2ltaWxhciBpc3N1ZSB3aXRoDQo+ID4+IGVmdXNlIG1hcC4NCj4gPg0KPiA+IEkgaGF2ZSB0
aGlzIHF1ZXN0aW9uIGJlY2F1c2UgSSB3b25kZXIgZG93bmxvYWRpbmcgZmlybXdhcmUgaXNzdWUg
bWlnaHQgYmUNCj4gPiBhbHNvIGEgcmVhZGluZyBlZnVzZSBpc3N1ZS4gSWYgc28sIHJldHJ5IG1p
Z2h0IHJlc29sdmUgYXMgd2VsbC4NCj4gDQo+IEhhcmQgdG8ga25vdywgYnV0IGl0J3MgYW4gaW5m
cmVxdWVudCBldmVudCBhbmQgdGhlIGV4aXN0aW5nIHJldHJ5IG1lY2hhbmlzbQ0KPiBhcHBlYXJz
IHRvIHdvcmsgZmluZS4NCj4gDQo+ID4gQXMgeW91ciByZXN1bHRzLCBpdCBsb29rcyBsaWtlIHRv
IHJldHJ5IHJlYWRpbmcgZWZ1c2UgY2FuIHJlc29sdmUgYWxsDQo+ID4gaXNzdWVzIHlvdSBmb3Vu
ZC4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBUaGUgcGF0Y2ggc3VibWl0dGVkIHJlc29sdmVz
IHRoZSBlZnVzZSBtYXAgZHVtcCBmb3IgbWUuIElmIHRoZXJlIGFyZSBtb3JlDQo+IGVmdXNlIGFj
Y2Vzc2VzIHRoYXQgbmVlZCB0byBiZSBhZGRyZXNzZWQgSSBoYXZlbuKAmXQgc2VlbiB0aGVtIGlu
IHRlc3RzLiBJZg0KPiB5b3UgYXJlIGhpbnRpbmcgdG8gYWJzdHJhY3QgdGhpbmdzIGZ1cnRoZXIg
SeKAmWQgYXNrIHlvdSB0byBwbGVhc2UgcHJvcG9zZQ0KPiBhbiBhbHRlcm5hdGl2ZSBwYXRjaCB0
aGF0IEkgY2FuIHRlc3QgZm9yIHlvdTsgSeKAmW0gZmlybWx5IGF0IHRoZSBub3ZpY2UgZW5kDQo+
IG9mIGtlcm5lbCBjb250cmlidXRvcnMgYW5kIHVubGlrZWx5IHRvIHNwb3Qgd2hlcmUgY2hhbmdl
cyBtaWdodCBiZSBuZWVkZWQNCj4gd2l0aG91dCBiZWluZyBzcG9vbi1mZWQgcmF0aGVyIGV4cGxp
Y2l0IGluc3RydWN0aW9ucyA6KQ0KDQpJIHdpbGwgc3RhcnQgdG8gcmV2aWV3IHRoaXMgcGF0Y2gg
aW4gZGV0YWlsIGFuZCBjb25zaWRlciBpZiBhbm90aGVyDQphbHRlcm5hdGl2ZSBtZXRob2QuDQoN
ClBpbmctS2UNCg0K

