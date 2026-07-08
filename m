Return-Path: <linux-wireless+bounces-38772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1hVFOqfTWqh3AEAu9opvQ
	(envelope-from <linux-wireless+bounces-38772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 02:55:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92178720BC9
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 02:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="VS9cvEY/";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38772-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38772-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9373007E3E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00B3A63FB;
	Wed,  8 Jul 2026 00:55:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FC37A827
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 00:55:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472103; cv=none; b=Jcrh84TuWeGX6mKhz0n3iehKXKyhr63wXjGlz4PVlZFoMjmrsy0bJGBUe8omUVQIUOeu8i5wNZqq/hZtZ45m4Ko1SqrO968mSKmHBgkvDogfDmM2Vo9Lo1cMYb01VD0pFvB2dK1RiSsWRaFnCsKKdz1naA1UxTap0jV/CNGerVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472103; c=relaxed/simple;
	bh=trVZBm7iIt0Qb/CBlGZmDYfjv3pGu99p/IVebEbIgN4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgYsvLbVPjwqU1+2bTmspgkOrvBntMIM4lKvQo0Dm6eLlNrS7ZNiU7Xv8LhVVyzAQkGQeoovYq3kvSg00xANv1GzC0Ps/hy8Vsq9P8aTVAVZKrEV7AoROO+gANBqtO6jGn0B5wJqqyRxGJNTNmuT7AmewRLdQg3EUqF6NXgkOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VS9cvEY/; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6680sql771894038, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783472092; bh=trVZBm7iIt0Qb/CBlGZmDYfjv3pGu99p/IVebEbIgN4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VS9cvEY/BCqXHf1JCdp/kwIvk+ZdB6u08DYySqboib0U+pY7JE0eDXk1Kk72JXE/I
	 zurXZZ5wjGxjIWKaxunMSftcmYCEi4crtWLRdh7txRLAWkTJre76+euONmOKEsOFZE
	 nmXTlSrzzL4cZn0NGhWtwcRD3vHX0+9yuisuQokJB+mkaXg9XBxdc+eXLxpz2lF/BT
	 DRWJ8WtuWyqhYi1vZKuQvpAqAvRXNLQuoryNU+eRrHXN8Vn5E/NAeCPyVzlH3OKT8T
	 mjev5rFr+x/FIFSGi6YpXzuCsUA/cLU0TTIlFNK6H/0IZA0a4oGu/o+26SXVeQGuZT
	 Au6AU2t80TacQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6680sql771894038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Jul 2026 08:54:52 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Jul 2026 08:54:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Jul 2026 08:54:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 8 Jul 2026 08:54:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: or1k <tixzit@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>
Subject: RE: [BUG] rtw89: RTL8852CE RX_DCK timeout + Bluetooth A2DP
 coexistence failures (fw-2.bin 0.27.129.4)
Thread-Topic: [BUG] rtw89: RTL8852CE RX_DCK timeout + Bluetooth A2DP
 coexistence failures (fw-2.bin 0.27.129.4)
Thread-Index: AQHdDlvZDJN6KtcAY0OAWVZw7x50ALZiyn2A
Date: Wed, 8 Jul 2026 00:54:52 +0000
Message-ID: <1cbb8e8573b14f689654b7e361f110c2@realtek.com>
References: <OduUSxVfSVayC9OVEeIrxw@gmail.com>
In-Reply-To: <OduUSxVfSVayC9OVEeIrxw@gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tixzit@gmail.com,m:linux-wireless@vger.kernel.org,m:kvalo@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38772-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92178720BC9

b3IxayA8dGl4eml0QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEhpLA0KPiANCj4gUmVwb3J0aW5nIGEg
V2ktRmkvQmx1ZXRvb3RoIGNvZXhpc3RlbmNlIGlzc3VlIG9uIFJUTDg4NTJDRSB0aGF0IGFsc28g
aGFzIGFuDQo+IG9wZW4gRmVkb3JhL1JlZCBIYXQgdHJhY2tlciAoYnVnemlsbGEucmVkaGF0LmNv
bSAjMjM0OTY3NSksIGJ1dCB0aGF0IHJlcG9ydA0KPiB3YXMgZmlsZWQgYWdhaW5zdCBhbiBvbGRl
ciBmaXJtd2FyZSAocnR3ODg1MmNfZnctMS5iaW4sIDAuMjcuOTcuMCkuIEknbQ0KPiBzZWVpbmcg
d2hhdCBsb29rcyBsaWtlIHRoZSBzYW1lIGNsYXNzIG9mIGZhaWx1cmUgb24gdGhlIG5ld2VyDQo+
IHJ0dzg4NTJjX2Z3LTIuYmluLCBmaXJtd2FyZSB2ZXJzaW9uIDAuMjcuMTI5LjQgKDNmMWE1MzAy
KSwgc28gaXQgbWF5IG5vdCBiZQ0KPiBmdWxseSBmaXhlZCBieSB3aGF0ZXZlciBjaGFuZ2VkIGJl
dHdlZW4gdGhvc2UgZmlybXdhcmUgcmV2aXNpb25zLg0KDQpXZSBhcmUgd29ya2luZyBvbiBkcml2
ZXIgdG8gc3VwcG9ydCB0aGUgbmV3IGZpcm13YXJlICgwLjI3LjEyOS40KSwgYW5kIA0KSSBleHBl
Y3RlZCB0byBsYW5kIHRoZSBwYXRjaGVzIG9uIDcuMy4gDQoNCkknZCBjbGFyaWZ5IHRoYXQgZG9l
cyAwLjI3Ljk3LjAgd29yayB0byB5b3U/DQoNCj4gDQo+IEhhcmR3YXJlOg0KPiAgIFdpLUZpOiAg
ICAgIFJlYWx0ZWsgUlRMODg1MkNFIFsxMGVjOmM4NTJdIHJldiAwMSwgTGVub3ZvIHN1YnN5c3Rl
bQ0KPiBbMTdhYTo1ODUyXQ0KPiAgICAgICAgICAgICAgIFBDSSAwMDAwOjAyOjAwLjAsIGRyaXZl
ciBydHc4OV84ODUyY2UNCj4gICBCbHVldG9vdGg6ICBzYW1lIGNvbWJvIGNoaXAsIFVTQiAwYmRh
OjU4NTIgIlJlYWx0ZWsgQmx1ZXRvb3RoIFJhZGlvIiwNCj4gICAgICAgICAgICAgICBkcml2ZXIg
YnR1c2IvYnRydGwsIEJUIGZpcm13YXJlIHJ0bDg4NTJjdV9md192Mi5iaW4gKDB4MDQwZDcyMjUp
DQo+ICAgUGxhdGZvcm06ICAgTGVub3ZvIGxhcHRvcCwgQU1EIFJ5emVuIEFQVSAodW5yZWxhdGVk
IHRvIHRoaXMgYnVnLCBqdXN0IGZvcg0KPiAgICAgICAgICAgICAgIGNvbnRleHQg4oCUIHJ1bGVk
IG91dCBhcyBhIGZhY3RvcikNCj4gDQo+IFNvZnR3YXJlOg0KPiAgIEtlcm5lbCA3LjEuMy0yMDAu
ZmM0NC54ODZfNjQgKEZlZG9yYSA0NCksIGxpbnV4LWZpcm13YXJlLTIwMjYwNjIyLTEuZmM0NA0K
PiANCj4gU3ltcHRvbTogaW50ZXJtaXR0ZW50IFdpLUZpIGRpc2Nvbm5lY3RzL3JlYXV0aCB0b2dl
dGhlciB3aXRoIEJsdWV0b290aCBBMkRQDQo+IGF1ZGlvIHRyYW5zcG9ydCBmYWlsdXJlcywgYm90
aCB0cmFjZWQgdG8gdGhlIHNhbWUgcGh5c2ljYWwgY29tYm8gY2hpcC4NCj4gDQo+IGRtZXNnIChX
aS1GaSBzaWRlKSwgcmVjdXJyaW5nIHNldmVyYWwgdGltZXMvZGF5IGluIHNob3J0IGNsdXN0ZXJz
Og0KPiANCj4gICBydHc4OV84ODUyY2UgMDAwMDowMjowMC4wOiBbUlhfRENLXSBTMSBSWERDSyB0
aW1lb3V0DQo+ICAgcnR3ODlfODg1MmNlIDAwMDA6MDI6MDAuMDogdGltZWQgb3V0IHRvIGZsdXNo
IHF1ZXVlcw0KPiANCj4gam91cm5hbGN0bCAoQmx1ZXRvb3RoIHNpZGUpLCBzYW1lIHRpbWUgZnJh
bWUsIGRldmljZSA4NTo0MjozNjo1MTpCMTpEMQ0KPiAoQmx1ZXRvb3RoIGhlYWRwaG9uZXMsIEEy
RFAgc2luayk6DQo+IA0KPiAgIHdpcmVwbHVtYmVyOiBzcGEuYmx1ZXo1LnNpbmsubWVkaWE6IE1p
c3Nja2V0DQo+ICAgICAoMCBzdXBwcmVzc2VkKTogQmx1ZXRvb3RoIGFkYXB0ZXIgZmlybQ0KPiAg
IGJsdWV0b290aGQ6IHNyYy9wcm9maWxlLmM6ZXh0X2lvX2Rpc2Nvbm4gZm9yDQo+ICAgICBIYW5k
cy1GcmVlIFZvaWNlIGdhdGV3YXk6IGdldHBlZXJuYW1lOg0KPiAgICAgY29ubmVjdGVkICgxMDcp
DQo+ICAgd2lyZXBsdW1iZXI6IHNwYS5ibHVlejU6IEZhaWx1cmUgaW4gQmx1ZXRvb3RoIGF1ZGlv
IHRyYW5zcG9ydA0KPiAgICAgL29yZy9ibHVlei9oY2kwL2Rldl84NV80Ml8zNl81MV9CMV9EMS8N
Cj4gDQo+IERpcmVjdCBjb3JyZWxhdGlvbiBjYXB0dXJlZCB3aXRoIG10cjogYSBXaXJlR3VhcmQt
dHVubmVsZWQgcGluZyB0ZXN0DQo+ICh1bHRpbWF0ZWx5IHJvdXRlZCBvdmVyIHdscDJzMCkgc2hv
d2VkIDUuOSB0aGUNCj4gc2FtZSB+NjBzIHdpbmRvdyBhcyA4IGNvbnNlY3V0aXZlICJNaXNzaW5n
aW5lcw0KPiBmb3IgdGhlIHNhbWUgZGV2aWNlICgwMDoxMjo1MSkgYW5kIGFuIEhGUCAxKS4NCj4g
Qm90aCByYWRpb3MgZGVncmFkZWQgdG9nZXRoZXIsIHdoaWNoIHBvaW50bXdhcmUNCj4gZmF1bHQg
cmF0aGVyIHRoYW4gdHdvIHVucmVsYXRlZCBidWdzLg0KPiANCj4gV29ya2Fyb3VuZHMgdHJpZWQs
IHBhcnRpYWwgZWZmZWN0IG9ubHk6DQo+ICAgLSBVU0IgYXV0b3N1c3BlbmQgZGlzYWJsZWQgZm9y
IHRoZSBCVCBhZA0KPiAgIC0gcnR3ODlfY29yZS5kaXNhYmxlX3BzX21vZGU9MSwgcnR3ODlfcGMN
Cj4gICAtIEEyRFAgY29kZWMgZm9yY2VkIHRvIFNCQyBpbnN0ZWFkIG9mIEFBDQo+IA0KPiBJcyB0
aGlzIGV4cGVjdGVkIHRvIGJlIGNvdmVyZWQgYnkgdGhlIHNhbWUgZml4IHBhdGggYXMgUkgjMjM0
OTY3NSwgb3IgaXMgaXQNCj4gd29ydGggdHJhY2tpbmcgc2VwYXJhdGVseSBzaW5jZSBpdCByZXBy
b2R1Pw0KDQpDYW4geW91IGV4cGxhaW4gd2hhdCBSSCMyMzQ5Njc1IGlzPw0KDQo+IEhhcHB5IHRv
IHRlc3QgY2FuZGlkYXRlIGZpcm13YXJlL3BhdGNoZXMgbw0KDQpJIHdpbGwgc2hhcmUgdGhlIHBh
dGNoZXMgd2hlbiB0aGV5IGdldCByZWFkeSAoSSBzdXBwb3NlIGl0IHdpbGwgYmUNCmluIG9uZSBv
ciB0d28gd2Vla3MpLg0KDQpQaW5nLUtlDQoNCg0K

