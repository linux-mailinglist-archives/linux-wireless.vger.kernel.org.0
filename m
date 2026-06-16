Return-Path: <linux-wireless+bounces-37829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JBEbN2nDMGqrXAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 05:30:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D78C68BB1A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 05:30:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=fm7GE72L;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37829-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37829-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBF173012568
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B222F8EB1;
	Tue, 16 Jun 2026 03:30:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30335A3A4;
	Tue, 16 Jun 2026 03:30:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781580647; cv=none; b=CrQYTDj4pOLbSKrEpIAakH1fGj8N6AgqzqXVDcZBZ81yNd050YfHSWkwyNNxtxfEjclGkFJ8Xy+KZ8nc3SsFbQ5WCCK8qhxu1P9oPoYMBYExNFdHAawOpEWhaczto20HdpwtkY8L5DeOLszBbZ0qccbZJUOtGtLUB5gcgYnA1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781580647; c=relaxed/simple;
	bh=RahWYaljewJp/qZnK16eBE7wmJqB7ZypRBdgdryjDdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMbGyvf3Z1NoIkzXGJ6OD2/wVMPMg56ufw2HTRTDa83OhHA+1fcF6Z1ILlQRmb1PjFu7/Bf9idu84dPu14zcUUCeF7GGiO1ETt1bNyN+b09uw9QHc2C6mrkb8hdgHKTrPRZj+ORuRwTiG65HnnE0UP6roVbQfTo3WJaFprnuzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fm7GE72L; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65G3UcWhA1329604, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781580638; bh=RahWYaljewJp/qZnK16eBE7wmJqB7ZypRBdgdryjDdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fm7GE72L2rKSE4XpdcBLjS/5AWZy0tfMbrUwjnC7ZP+nFsVH6KJ+FanvR5ftLu8GU
	 Pm2JVsQEWUowBrNDVVCvPFPSnk/eaMuaNYFFFx0wVr1JPtToiQU4m/Dk8gtq6xTUs8
	 s4/wWECDKdYkwNa7hSKyr/Clk6Q/h6bQGt78FxaLXh2vocFa0Hldxm3qpzU0V06tDU
	 JEuQ58L/U5W0awH6DBjYY8a+nGcun15XXQ9wWpTsMLnr9895JU/HQgTBtfzt6xcamI
	 WG9JN5zXFeMfP+cNYi2+16LqBRh78iteMz6ndYG/VO1XZm8v4S9DNOKQV8Nsoq2ILG
	 SEjcEL/RpZRxQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65G3UcWhA1329604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 11:30:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Jun 2026 11:30:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 16 Jun 2026 11:30:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucas Tanure <lucas.tanure@neat.no>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Krzysztof
 Opasiak" <krzysztof.opasiak@neat.no>, =?utf-8?B?QW5kZXJzIFLDuG5uaW5nZW4=?=
	<anders@neat.no>, Hilda Wu <hildawu@realtek.com>, Max Chou
	<max.chou@realtek.com>
Subject: RE: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from
 downstream to upstream driver
Thread-Topic: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from
 downstream to upstream driver
Thread-Index: AQHc/M6yNX20ldC4UEmoq6jLtFqOPbZAXPhg
Date: Tue, 16 Jun 2026 03:30:37 +0000
Message-ID: <049000e56f004b4b9d58b74eaed17aef@realtek.com>
References: <CALt7t=EDVdn7eGbXgXWU8rgbek52+frbbeYMHwzbH7J0xGXWzg@mail.gmail.com>
In-Reply-To: <CALt7t=EDVdn7eGbXgXWU8rgbek52+frbbeYMHwzbH7J0xGXWzg@mail.gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37829-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucas.tanure@neat.no,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.opasiak@neat.no,m:anders@neat.no,m:hildawu@realtek.com,m:max.chou@realtek.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,neat.no:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D78C68BB1A

SGksDQoNCkx1Y2FzIFRhbnVyZSA8bHVjYXMudGFudXJlQG5lYXQubm8+IHdyb3RlOg0KPiBIaSBQ
aW5nLUtlLA0KPiANCj4gV2UgYXJlIGJyaW5naW5nIHVwIGFuIFJUTDg4MjJCUyAvIFJUTDg4MjJD
UyBjb21ibyBvbiBhIFJvY2tjaGlwIFBYMzANCj4gYm9hcmQgKGtlcm5lbCA2LjEuMTE4KSwgV2kt
Rmkgb3ZlciBTRElPLCBCVCBvbiB0aGUgc2FtZSBkaWUgb3ZlciBVQVJUDQo+IHZpYSBidHJ0bCAr
IGhjaV9oNS4NCj4gDQo+IFdlJ3JlIGRlbGliZXJhdGVseSBtaWdyYXRpbmcgb2ZmIFJlYWx0ZWsn
cyBvdXQtb2YtdHJlZSBTRElPIHZlbmRvcg0KPiBkcml2ZXIgdG8gbWFpbmxpbmUgcnR3ODg6IHRo
ZSB2ZW5kb3IgZHJpdmVyIGhpdHMgbWVtb3J5LWNvcnJ1cHRpb24NCj4gYnVncyB3ZSd2ZSBiZWVu
IHVuYWJsZSB0byBnZXQgc3VwcG9ydCBvbiwgYW5kIG1haW5saW5lIGlzIHRoZSBiZXR0ZXINCj4g
bG9uZy10ZXJtIHBhdGguDQo+IFRoYXQgbWlncmF0aW9uIGxlYXZlcyB1cyB0d28gZ2FwcyBJJ2Qg
YXBwcmVjaWF0ZSB5b3VyIGd1aWRhbmNlIG9uOg0KPiANCj4gMSkgUG93ZXItcGFyYW1ldGVyIHRh
Ymxlcy4gTWFpbmxpbmUgY2FycmllcyB0aGUgVFgtcG93ZXIgZGF0YSBhcyBnZW5lcmF0ZWQNCj4g
ICAgQyBhcnJheXMgaW4gcnR3ODh4eGNfdGFibGUuYywgd2hpbGUgdGhlIHZlbmRvciBkcml2ZXIg
c2hpcHMgdGhlIHNhbWUNCj4gICAgZGF0YSBhcyB0ZXh0IGZpbGVzLg0KPiANCj4gICAgVGhlIFRY
LXBvd2VyIGxpbWl0cyBsb29rIGxpa2UgdGhpcyAoVFhQV1JfTE1ULnR4dCk6DQo+IA0KPiAgICAg
ICAgIyMgIDIuNEcsIDIwTSwgMVQsIENDSywgLy8oMU07Mk07NS41TTsxMU0pDQo+ICAgICAgICAj
IyAgU1RBUlQNCj4gICAgICAgICMjICAjMyMgIEZDQyAgRVRTSSAgTUtLDQo+ICAgICAgICBDSDAx
ICAxNiAgMTUgIDE1DQo+ICAgICAgICBDSDAyICAxNiAgMTUgIDE1DQo+ICAgICAgICAjIyAgRU5E
DQoNClRoZSB0b29sIGZyb20gLnR4dCB0byBDIGFycmF5cyBmb3IgdmVuZG9yIGRyaXZlciBpcyBu
b3QgbWFpbnRhaW5lZCBieSBteSB0ZWFtLA0KYnV0IEkgdGhpbmsgaXQgaXNuJ3QgdG9vIGhhcmQg
dG8gdXNlIEFJIHRvb2wgdG8gY29udmVydCB0aGUgZm9ybWF0LiANCg0KVGhlIEMgYXJyYXkgZnJv
bSB2ZW5kb3IgZHJpdmVyIHRvIHJ0dzg4IHN0cnVjdCBpcyBhbHNvIGEgc2ltcGxlIGNvbnZlcnNp
b24NCnlvdSBjYW4gdXNlIEFJIHRvIGFzc2lzdCB0aGlzLg0KDQpJZiB5b3UgaGF2ZSB0cmFjZWQg
cnR3ODgsIHRoZSBzdHJ1Y3QgZm9yIFRYIHBvd2VyIGxpbWl0IGlzOg0KDQpzdHJ1Y3QgcnR3X3R4
cHdyX2xtdF9jZmdfcGFpciB7DQoJdTggcmVnZDsNCgl1OCBiYW5kOw0KCXU4IGJ3Ow0KCXU4IHJz
Ow0KCXU4IGNoOw0KCXM4IHR4cHdyX2xtdDsNCn07DQoNCj4gDQo+ICAgIGFuZCB0aGUgcG93ZXIt
YnktcmF0ZSBsaWtlIHRoaXMgKFBIWV9SRUdfUEcudHh0KToNCj4gDQo+ICAgICAgICAjWzIuNEdd
W0FdIw0KPiAgICAgICAgWzFUeF0gMHhjMjAgIDB4ZmZmZmZmZmYgIDE4IDE5IDE5IDE5ICAvLyB7
MTFNIDUuNU0gMk0gMU19DQo+ICAgICAgICBbMVR4XSAweGMyNCAgMHhmZmZmZmZmZiAgMTggMTgg
MTggMTggIC8vIHsxOE0gMTJNIDlNIDZNfQ0KDQpUWCBwb3dlciBieSByYXRlIGlzOg0KDQpzdHJ1
Y3QgcnR3X3BoeV9wZ19jZmdfcGFpciB7DQoJdTMyIGJhbmQ7DQoJdTMyIHJmX3BhdGg7DQoJdTMy
IHR4X251bTsNCgl1MzIgYWRkcjsNCgl1MzIgYml0bWFzazsNCgl1MzIgZGF0YTsNCn07DQoNCj4g
DQo+ICAgIElzIHRoZXJlIGFueSB3YXkgdG8gY29udmVydCB0aGVzZSAuVFhUIGZpbGVzIGludG8g
dGhlIEMgdGFibGVzPyBJdA0KPiBzZWVtcyB0aGUgdmVuZG9yIGRyaXZlciBhbmQgdGhlIG1haW5s
aW5lIGRyaXZlciBwb3dlciBjb25maWd1cmF0aW9uDQo+IGRvbid0IGhhdmUgYW55dGhpbmcgaW4g
Y29tbW9uLg0KDQpUaGUgcHVycG9zZSBpcyBkaWZmZXJlbnQuIFRoZSAuVFhUIGlzIGZyb20gaHVt
YW4gcG9pbnQgb2YgdmlldyB0byBiZSBlYXNpZXINCnRvIGZpbGwgY2FsaWJyYXRpb24gZGF0YSBv
bmUgYnkgb25lLiBUaGUgZGVzaWduIG9mIEMgYXJyYXlzIGlzIHRvIGxvb2sgdXAgdGFibGUNCnF1
aWNrbHkgKGl0IGlzbid0IHNvIHF1aWNrbHkgdGhvdWdoKS4NCg0KPiANCj4gMikgSXMgdGhlcmUg
YW4gdXBzdHJlYW0gKGxpbnV4LWZpcm13YXJlKSBSVEw4ODIyQlMgZmlybXdhcmUgdGhhdA0KPiBz
dXBwb3J0cyB0aGUgVUFSVCB0cmFuc3BvcnQgKHJ0bF9idC9ydGw4ODIyYnNfZncuYmluICsgY29u
ZmlnKSwgb3INCj4gZG9lcyB0aGUgODgyMkJTIGZpcm13YXJlIHN0aWxsIGhhdmUgdG8gY29tZSBm
cm9tIHRoZSB2ZW5kb3IgQlNQPw0KDQpDdXJyZW50bHksIG5vLiANCg0KPiAgICBJcyB0aGVyZSBh
IHByb2JsZW0gdXNpbmcgdmVuZG9yIGZpcm13YXJlIChub3QgcmVsZWFzZWQgYXQNCj4gbGludXgt
ZmlybXdhcmUpIHdpdGggdGhlIG1haW5saW5lIGRyaXZlcj8NCg0KRm9yIEJUIHBhcnQsIEkgdGhp
bmsgaXQgY2FuIHdvcmsuIEJ1dCB0byB3b3JrIHdpdGggV2lGaSwgaXQgbmVlZHMNCkJULWNvZXhp
c3RlbmNlIGltcGxlbWVudGVkIGluIFdpRmkgZHJpdmVyIHRvIHN1cHBvcnQgVUFSVCBCVC4gVW5m
b3J0dW5hdGVseSANCmN1cnJlbnQgaXMgb25seSBwYXJ0aWFsbHkgc3VwcG9ydCBVQVJUIEJULg0K
DQpQaW5nLUtlDQoNCg==

