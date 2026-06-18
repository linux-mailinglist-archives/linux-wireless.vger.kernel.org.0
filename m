Return-Path: <linux-wireless+bounces-37881-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rCmIulpM2qyAgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37881-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 05:45:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148269D5C9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 05:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=mATtiFav;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37881-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37881-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DD883023336
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5581C84A0;
	Thu, 18 Jun 2026 03:45:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E175A89;
	Thu, 18 Jun 2026 03:45:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754340; cv=none; b=qYYn/vA6jxE1PymplDtd6n14TldRZBNvy35CwtGoMLU59Gg7ppAWQeKUL0nfBM8WModA3IWCtpYSRsvadnKC3u39MmQn0uDSbsRqOQNW6yYLtXDQA67qSbEBTkwUtmP6sAGe52qn18BDQtbwFiqsGnyuhDdcCwFbAh7KsHtaC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754340; c=relaxed/simple;
	bh=7MR7u7+dz5Cu4I8GG4Hs3jcng8hQpO42C0RkAWmeQhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klXiGNHiBWUJ0W90jq4t2lOfl2OcIzzVCmSCZeuYYL2/u9JpXSAp9W7hXkg877lozW62QZZtGdMnemyYuc0MfwWykgOMokwpawBE8cI2GOdhf5LNbtiWABFPEoKZSSBwTs22XZNR4yPuQ0uzWyUCoAmgVZ0N0RT0FxLF3Qr8Za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mATtiFav; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65I3jWwS53439965, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781754332; bh=7MR7u7+dz5Cu4I8GG4Hs3jcng8hQpO42C0RkAWmeQhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mATtiFav+eFClyPeiYWIEQmpJTet2DljSkzdmGw8bhPdHx5/TJ2um3zQLGtgv7PkY
	 qWlSiN3E9rwBbOeEM8xHJtJ4rmsFwjE9ypP1h0z5DTbD+ihc2DzgYC88mCzXNySiDn
	 tcn7ia7u8yrZnNLCiI6lbwhltz/jLn8mtc1VGHSvQSK2Z4jy1wFTPD6Zoc1+dZzwRd
	 P2SvgRaLGb+BfZ4dXzLgvgr1pBqXONYETDupo/LIUEovIvnvxtuQVtuEwR76FQ0jr4
	 ZQVULC4UiDj1c2xAoq2xH2bCpDa+/Hg2nRjJAIxFiHsjYyLxf+dLX61DOLDKk6GQbJ
	 plYSv/dgQeAVA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65I3jWwS53439965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jun 2026 11:45:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Jun 2026 11:45:33 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::a2e:aeb4:fa27:c32f%9]) with mapi id
 15.02.2562.017; Thu, 18 Jun 2026 11:45:33 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Matthew Leach <matthew.leach@collabora.com>, Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH] wifi: rtw89: regd: fix ww domain blocking on 6GHz
Thread-Topic: [PATCH] wifi: rtw89: regd: fix ww domain blocking on 6GHz
Thread-Index: AQHc/kLFbyzUGD3AnEyhLNPMXon1H7ZDo/4A
Date: Thu, 18 Jun 2026 03:45:32 +0000
Message-ID: <810df7528fc6425b97da759e0b0bd669@realtek.com>
References: <20260617-rtw89-6ghz-regd-fixes-v1-1-33d744a07d16@collabora.com>
In-Reply-To: <20260617-rtw89-6ghz-regd-fixes-v1-1-33d744a07d16@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.leach@collabora.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[kevin_yang@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37881-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin_yang@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:mid,realtek.com:from_mime,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0148269D5C9

TWF0dGhldyBMZWFjaCA8bWF0dGhldy5sZWFjaEBjb2xsYWJvcmEuY29tPiB3cm90ZToNCj4gDQo+
IFRoZSBjdXJyZW50IGNvZGUga2VlcHMgYSBzZXBhcmF0ZSBpbnN0YW5jZSBmb3IgdGhlIHd3IHJl
ZyBkb21haW4gb3V0c2lkZQ0KPiB0aGUgc3RhdGljIG1hcCwgYW5kIHRyZWF0cyBydHc4OV9yZWdk
X2dldF9pbmRleCgpIHJldHVybmluZw0KPiBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05VTSBhcyB0
aGUgaW5kZXggZm9yIHRoZSB3dyBkb21haW4uIFRoaXMNCj4gY29uZmxhdGVzIHRoZSAibm90IGZv
dW5kIiBzZW50aW5lbCB3aXRoIGEgcmVhbCBpbmRleCBhbmQgY2F1c2VzIHRoZQ0KDQpXZSBlbnN1
cmUgcmVnZF9tYXAgc2l6ZSA8PSBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05VTS4NCkFuZCB3ZSB0
cmVhdCAibm90IGZvdW5kIiBhcyBXVy1saWtlIGNhc2UuDQoNCj4gYmxvY2tfKiBiaXRtYXAgbG9v
a3VwcyB0byBza2lwIHd3IGVudGlyZWx5LCBleHBsaWNpdGx5IGJsb2NraW5nIDZHSHogb24NCj4g
dGhlIHd3IGRvbWFpbiByYXRoZXIgdGhhbiBkZWZlcnJpbmcgdG8gdGhlIGtlcm5lbCByZWd1bGF0
b3J5IHBvbGljeS4NCg0KSW4gZmFjdCwgd2UgbWVhbnQgdG8gYmxvY2sgNkdIeiBvbiBXVyBmb3Ig
bm93Lg0KQW5kIEkgZGlkbid0IHNlZSB3aXJlbGVzcy1yZWdkYiBlbmFibGVzIDZHSHogb24gV1cg
ZWl0aGVyLg0KDQo+IA0KPiBGb2xkIHRoZSBzdGFuZGFsb25lIHJ0dzg5X3d3X3JlZ2QgaW50byBy
dHc4OV9yZWdkX21hcFswXSBhbmQgZHJvcCB0aGUNCj4gc3BlY2lhbCBjYXNlIGluIHJ0dzg5X3Jl
Z2RfZ2V0X2luZGV4KCkgdGhhdCByZXR1cm5lZA0KPiBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05V
TSBmb3Igd3cuIHJ0dzg5X3JlZ2RfZmluZF9yZWdfYnlfbmFtZSgpDQo+IG5vdw0KPiByZXR1cm5z
IE5VTEwgb24gbWlzcywgYW5kIGl0cyBjYWxsZXJzIGVpdGhlciB0cmFuc2xhdGUgdGhhdCBpbnRv
IHRoZQ0KPiBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05VTSBzZW50aW5lbA0KPiAocnR3ODlfcmVn
ZF9nZXRfaW5kZXhfYnlfbmFtZSgpKSBvcg0KPiBmYWxsIGJhY2sgdG8gdGhlIHd3IGVudHJ5IGV4
cGxpY2l0bHkgKHJ0dzg5X3JlZ2Rfbm90aWZpZXJfYXBwbHkoKSkuIFdpdGgNCg0KQSBiaWcgcHJv
YmxlbSBoZXJlOg0KTm90ZSB0aGF0IHJlZ2RfbWFwIHdpbGwgYmUgZ2VuZXJhdGVkL3VwZGF0ZWQg
YmFzZWQgb24gY2VydGlmaWNhdGlvbiBkb2N1bWVudA0KcHJvdmlkZWQgYnkgb3VyIFJGIHRlYW0s
IGJ1dCBpdCB3b24ndCBpbmNsdWRlIFdXLiAobm8gc28tY2FsbGVkIFdXIGNlcnRpZmljYXRpb24p
DQoNClRoZXJlIGFyZSB0d28ga2luZHMgb2YgY2hpcHNldHM6DQoxLiByZWdkX21hcCBpcyBsb2Fk
ZWQgZnJvbSBidWlsdC1pbiBhcnJheQ0KMi4gcmVnZF9tYXAgaXMgbG9hZGVkIGZyb20gZncgZWxl
bWVudA0KDQpGb3IgY2FzZSAyLCByZWdkX21hcFswXSB3b24ndCBzdGFuZCBmb3IgV1cuDQpTbywg
eW91ciBmYWxsYmFjayB3b24ndCB3b3JrIGNvcnJlY3RseS4NCg0KPiB3dyBsaXZpbmcgYXQgYSBy
ZWFsIGluZGV4LCB0aGUgYmxvY2stbGlzdCBjaGVja3MgYXBwbHkgYW5kIDZHSHogaXMgbm8NCj4g
bG9uZ2VyIHVuY29uZGl0aW9uYWxseSBibG9ja2VkIGZvciB3dy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1hdHRoZXcgTGVhY2ggPG1hdHRoZXcubGVhY2hAY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3JlZ2QuYyB8IDI4ICsrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L3JlZ2QuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvcmVnZC5jDQo+IGluZGV4IDI4NDY2Y2IzNWVhMi4uNjk4YjhiN2Y2MTI5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3JlZ2QuYw0KPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3JlZ2QuYw0KPiBAQCAtMjEsMTAg
KzIxLDggQEAgdm9pZCBydHc4OV9yZWdkX25vdGlmaWVyKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0
cnVjdA0KPiByZWd1bGF0b3J5X3JlcXVlc3QgKnJlcXVlc3QNCj4gDQo+ICBzdGF0aWNfYXNzZXJ0
KEJJVFNfUEVSX1RZUEUodW5zaWduZWQgbG9uZykgPj0NCj4gTlVNX09GX1JUVzg5X1JFR0RfRlVO
Qyk7DQo+IA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBydHc4OV9yZWdkIHJ0dzg5X3d3X3JlZ2Qg
PQ0KPiAtICAgICAgIENPVU5UUllfUkVHRCgiMDAiLCBSVFc4OV9XVywgUlRXODlfV1csIFJUVzg5
X1dXLCAweDApOw0KPiAtDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0dzg5X3JlZ2QgcnR3ODlf
cmVnZF9tYXBbXSA9IHsNCj4gKyAgICAgICBDT1VOVFJZX1JFR0QoIjAwIiwgUlRXODlfV1csIFJU
Vzg5X1dXLCBSVFc4OV9XVywNCj4gMHgwKSwNCj4gICAgICAgICBDT1VOVFJZX1JFR0QoIkFSIiwg
UlRXODlfTUVYSUNPLCBSVFc4OV9NRVhJQ08sDQo+IFJUVzg5X0ZDQywgMHgwKSwNCj4gICAgICAg
ICBDT1VOVFJZX1JFR0QoIkJPIiwgUlRXODlfRkNDLCBSVFc4OV9GQ0MsIFJUVzg5X05BLCAweDAp
LA0KPiAgICAgICAgIENPVU5UUllfUkVHRCgiQlIiLCBSVFc4OV9GQ0MsIFJUVzg5X0ZDQywgUlRX
ODlfRkNDLCAweDApLA0KPiBAQCAtMzE2LDEyICszMTQsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBydHc4OV9yZWdkDQo+ICpydHc4OV9yZWdkX2ZpbmRfcmVnX2J5X25hbWUoc3RydWN0IHJ0dzg5
X2RldiAqcnQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuICZyZWdkX2N0cmwtPm1h
cFtpXTsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIHJldHVybiAmcnR3ODlfd3dfcmVnZDsN
Cj4gKyAgICAgICByZXR1cm4gTlVMTDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgYm9vbCBydHc4OV9y
ZWdkX2lzX3d3KGNvbnN0IHN0cnVjdCBydHc4OV9yZWdkICpyZWdkKQ0KPiAgew0KPiAtICAgICAg
IHJldHVybiByZWdkID09ICZydHc4OV93d19yZWdkOw0KPiArICAgICAgIC8qIEluZGV4IDAgaW4g
dGhlIHN0YXRpYyBtYXAgY29udGFpbnMgdGhlIFdXIGRvbWFpbiBlbnRyeS4gKi8NCj4gKyAgICAg
ICByZXR1cm4gcmVnZCA9PSAmcnR3ODlfcmVnZF9tYXBbMF07DQo+ICB9DQo+IA0KPiAgc3RhdGlj
IHU4IHJ0dzg5X3JlZ2RfZ2V0X2luZGV4KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgY29uc3Qg
c3RydWN0DQo+IHJ0dzg5X3JlZ2QgKnJlZ2QpDQo+IEBAIC0zMzEsOSArMzMwLDYgQEAgc3RhdGlj
IHU4IHJ0dzg5X3JlZ2RfZ2V0X2luZGV4KHN0cnVjdCBydHc4OV9kZXYNCj4gKnJ0d2RldiwgY29u
c3Qgc3RydWN0IHJ0dzg5X3JlZ2QNCj4gDQo+ICAgICAgICAgQlVJTERfQlVHX09OKEFSUkFZX1NJ
WkUocnR3ODlfcmVnZF9tYXApID4NCj4gUlRXODlfUkVHRF9NQVhfQ09VTlRSWV9OVU0pOw0KPiAN
Cj4gLSAgICAgICBpZiAocnR3ODlfcmVnZF9pc193dyhyZWdkKSkNCj4gLSAgICAgICAgICAgICAg
IHJldHVybiBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05VTTsNCj4gLQ0KPiAgICAgICAgIHJldHVy
biByZWdkIC0gcmVnZF9jdHJsLT5tYXA7DQo+ICB9DQo+IA0KPiBAQCAtMzQyLDYgKzMzOCwxMCBA
QCBzdGF0aWMgdTggcnR3ODlfcmVnZF9nZXRfaW5kZXhfYnlfbmFtZShzdHJ1Y3QNCj4gcnR3ODlf
ZGV2ICpydHdkZXYsIGNvbnN0IGNoYXIgKmFscA0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBydHc4
OV9yZWdkICpyZWdkOw0KPiANCj4gICAgICAgICByZWdkID0gcnR3ODlfcmVnZF9maW5kX3JlZ19i
eV9uYW1lKHJ0d2RldiwgYWxwaGEyKTsNCj4gKw0KPiArICAgICAgIGlmICghcmVnZCkNCj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBSVFc4OV9SRUdEX01BWF9DT1VOVFJZX05VTTsNCj4gKw0KPiAg
ICAgICAgIHJldHVybiBydHc4OV9yZWdkX2dldF9pbmRleChydHdkZXYsIHJlZ2QpOw0KPiAgfQ0K
PiANCj4gQEAgLTcyMSw3ICs3MjEsNyBAQCBpbnQgcnR3ODlfcmVnZF9pbml0X2hpbnQoc3RydWN0
IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
IA0KPiAgICAgICAgIGNoaXBfcmVnZCA9IHJ0dzg5X3JlZ2RfZmluZF9yZWdfYnlfbmFtZShydHdk
ZXYsDQo+IHJ0d2Rldi0+ZWZ1c2UuY291bnRyeV9jb2RlKTsNCj4gLSAgICAgICBpZiAoIXJ0dzg5
X3JlZ2RfaXNfd3coY2hpcF9yZWdkKSkgew0KPiArICAgICAgIGlmIChjaGlwX3JlZ2QgJiYgIXJ0
dzg5X3JlZ2RfaXNfd3coY2hpcF9yZWdkKSkgew0KPiAgICAgICAgICAgICAgICAgcnR3ZGV2LT5y
ZWd1bGF0b3J5LnJlZ2QgPSBjaGlwX3JlZ2Q7DQo+ICAgICAgICAgICAgICAgICBydHdkZXYtPnJl
Z3VsYXRvcnkucHJvZ3JhbW1lZCA9IHRydWU7DQo+IA0KPiBAQCAtODU5LDcgKzg1OSwxNSBAQCBz
dGF0aWMgdm9pZCBydHc4OV9yZWdkX25vdGlmaWVyX2FwcGx5KHN0cnVjdA0KPiBydHc4OV9kZXYg
KnJ0d2RldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
d2lwaHkgKndpcGh5LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCByZWd1bGF0b3J5X3JlcXVlc3QNCj4gKnJlcXVlc3QpDQo+ICB7DQo+IC0gICAgICAgcnR3
ZGV2LT5yZWd1bGF0b3J5LnJlZ2QgPSBydHc4OV9yZWdkX2ZpbmRfcmVnX2J5X25hbWUocnR3ZGV2
LA0KPiByZXF1ZXN0LT5hbHBoYTIpOw0KPiArICAgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9yZWdk
ICpyZWdkID0NCj4gcnR3ODlfcmVnZF9maW5kX3JlZ19ieV9uYW1lKHJ0d2RldiwgcmVxdWVzdC0+
YWxwaGEyKTsNCj4gKw0KPiArICAgICAgIGlmICghcmVnZCkgew0KPiArICAgICAgICAgICAgICAg
LyogRmFsbGJhY2sgdG8gV1cgZG9tYWluIGlmIG5hbWUgbm90IGZvdW5kLiAqLw0KPiArICAgICAg
ICAgICAgICAgcmVnZCA9ICZydHc4OV9yZWdkX21hcFswXTsNCj4gKyAgICAgICB9DQo+ICsNCj4g
KyAgICAgICBydHdkZXYtPnJlZ3VsYXRvcnkucmVnZCA9IHJlZ2Q7DQo+ICsNCj4gICAgICAgICAv
KiBUaGlzIG5vdGlmaWNhdGlvbiBtaWdodCBiZSBzZXQgZnJvbSB0aGUgc3lzdGVtIG9mIGRpc3Ry
b3MsDQo+ICAgICAgICAgICogYW5kIGl0IGRvZXMgbm90IGV4cGVjdCB0aGUgcmVndWxhdG9yeSB3
aWxsIGJlIG1vZGlmaWVkIGJ5DQo+ICAgICAgICAgICogY29ubmVjdGluZyB0byBhbiBBUCAoaS5l
LiBjb3VudHJ5IGllKS4NCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogOGNkOTUyMGQzNWE2YzM4
ZGI2NTY3ZTk3ZGQ5M2IxZjExZjE4NWRjNg0KPiBjaGFuZ2UtaWQ6IDIwMjYwNjE2LXJ0dzg5LTZn
aHotcmVnZC1maXhlcy1kOGY4MTY4ODBiZDANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4g
TWF0dA0KPiANCg0K

