Return-Path: <linux-wireless+bounces-37471-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v2MQBXocJmq0SQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37471-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 03:35:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDA6521B8
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 03:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=XN1rLv4r;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37471-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37471-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63683302F426
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6C3033E8;
	Mon,  8 Jun 2026 01:33:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BD16A395;
	Mon,  8 Jun 2026 01:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882387; cv=none; b=tD0x1EYmFwxcxyXEa/figlN9O8k2mwMKy9LfZRh8Ha1ASjOHnacAGdG4SeQKth3WPcopgAGGEAcVvK7a4zHu1OAeO6TyKCoO/olkcKKG8VUxMTGbJJS24AqxqeG1/yE0vWYn1Nx7/ML3lB280R9v6KjD3phnV5SiMesyPWAkjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882387; c=relaxed/simple;
	bh=IRAXd5QTmF7gOvt55lmEu3hNBA86Qsolc+fvbcMghd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHzsiElKBJ0aUo/p4RPJxFDp8kh+DcKrT5cCrUZbj9JJhzbnN3bhx7AwyfhXXralweEHnUWOv2Xg0ZO7VME/UdqVxE1iietnlwDE2WlHz/mOuK/FcZduNNsrLFcgV7iaMC0Wk+iBa/KRPscVK6a1Jf1JBK/UUL4Dd4w9a7w8lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XN1rLv4r; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6581X1crC3192656, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780882381; bh=IRAXd5QTmF7gOvt55lmEu3hNBA86Qsolc+fvbcMghd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XN1rLv4rA1RFugFgGtvkrxO15w0aLnNKOEXXiUGpxb2x6QgKTmXod/tpz+2eLtF7a
	 leFjCl9shp1d1Ds3Cv4QegVnD5ZJM0A85rJ4vyFOkCnmgnY7v1So0Ncl3cixnMMpSh
	 biMJN6ivVgpuZycF9Z+Lbtbmdzld1o0nyGFZWpgaecHLBbKueTdVSv9cKBla7jpnHr
	 TFPTeKgHkE3NZ3bxeyMWDdCj30npodIgZYeoTsw1fTYKPntBi14cBvjbZ56ctS1zi2
	 WJ7GjIdV94JcFbg3Xnfu1AxTxcDNqNBWgK9Gyure5XmiSE5DywprGBuiFxOozrz4zu
	 cT2JUxPdBAy3g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6581X1crC3192656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jun 2026 09:33:01 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Jun 2026 09:33:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Jun 2026 09:32:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 8 Jun 2026 09:32:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Giovanni Santini <giovannisantini93@yahoo.it>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: RE: rtw88: WiFi card is not offloaded properly when suspending the OS
Thread-Topic: rtw88: WiFi card is not offloaded properly when suspending the
 OS
Thread-Index: AQHc9MfBVY8tNqpB4kyHWDTYuLp5JLYzXc0g
Date: Mon, 8 Jun 2026 01:32:59 +0000
Message-ID: <efae0a4db2ab4b6193922b393d3dcdd6@realtek.com>
References: <10da4c45-74ed-4deb-8c88-6d0b803465ba.ref@yahoo.it>
 <10da4c45-74ed-4deb-8c88-6d0b803465ba@yahoo.it>
In-Reply-To: <10da4c45-74ed-4deb-8c88-6d0b803465ba@yahoo.it>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:giovannisantini93@yahoo.it,m:stable@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37471-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,yahoo.it:email];
	FREEMAIL_TO(0.00)[yahoo.it,vger.kernel.org];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77EDA6521B8

R2lvdmFubmkgU2FudGluaSA8Z2lvdmFubmlzYW50aW5pOTNAeWFob28uaXQ+IHdyb3RlOg0KPiAN
Cj4gSnVuIDAyIDE3OjI1OjMzIGFyY2hsaW51eC10dWcga2VybmVsOiBydHc4OF84ODIyY2UgMDAw
MDowMzowMC4wOiBmYWlsZWQNCj4gdG8gc2VuZCBoMmMgY29tbWFuZA0KPiBKdW4gMDIgMTc6MjU6
MzMgYXJjaGxpbnV4LXR1ZyBrZXJuZWw6IHJ0dzg4Xzg4MjJjZSAwMDAwOjAzOjAwLjA6IGZhaWxl
ZA0KPiB0byBzZW5kIGgyYyBjb21tYW5kDQo+IEp1biAwMiAxNzoyNTozMyBhcmNobGludXgtdHVn
IGtlcm5lbDogcnR3ODhfODgyMmNlIDAwMDA6MDM6MDAuMDogZmFpbGVkDQo+IHRvIHNlbmQgaDJj
IGNvbW1hbmQNCj4gSnVuIDAyIDE3OjI1OjMzIGFyY2hsaW51eC10dWcga2VybmVsOiBydHc4OF84
ODIyY2UgMDAwMDowMzowMC4wOiBmYWlsZWQNCj4gdG8gc2VuZCBoMmMgY29tbWFuZA0KPiBKdW4g
MDIgMTc6MjU6MzYgYXJjaGxpbnV4LXR1ZyBrZXJuZWw6IHJ0dzg4Xzg4MjJjZSAwMDAwOjAzOjAw
LjA6IGZhaWxlZA0KPiB0byBwb2xsIG9mZnNldD0weDUgbWFzaz0weDIgdmFsdWU9MHgwDQo+IEp1
biAwMiAxNzoyNTozNiBhcmNobGludXgtdHVnIGtlcm5lbDogLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQo+IEp1biAwMiAxNzoyNTozNiBhcmNobGludXgtdHVnIGtlcm5lbDog
ZmFpbGVkIHRvIHJlYWQgREJJIHJlZ2lzdGVyLA0KPiBhZGRyPTB4MDcxOQ0KDQpBZGQgdGhlc2Ug
YmVsb3cgdG8gc2VlIGlmIGl0IGNhbiBoZWxwLiANCg0Kc3VkbyBuYW5vIC9ldGMvbW9kcHJvYmUu
ZC9ydHc4OC5jb25mDQpvcHRpb25zIHJ0dzg4X2NvcmUgZGlzYWJsZV9scHNfZGVlcD15DQpvcHRp
b25zIHJ0dzg4X3BjaSBkaXNhYmxlX2FzcG09eQ0KDQpBZnRlciBjb2xkIHJlYm9vdCwgY2hlY2sg
L3N5cy9tb2R1bGVzL3J0dzg4XyovcGFyYW10ZXJzLyogdG8gc2VlIGlmDQp0aGUgbW9kaWZpY2F0
aW9uIHRha2VzIGVmZmVjdC4NCg0KPiANCj4gSSdtIGF0dGFjaGluZyB0aGUgZnVsbCBib290IGxv
ZywgaWYgeW91IG5lZWQgYSBmcmVzaCBvbmUgSSBjYW4gcHJvdmlkZSBpdC4NCg0KQmVmb3JlICJm
YWlsZWQgdG8gcG9sbCAuLi4iIGxvZywgSSBhbHNvIHNlZSANCg0KSnVuIDAyIDE3OjI1OjAyIGFy
Y2hsaW51eC10dWcga2VybmVsOiBydHc4OF84ODIyY2UgMDAwMDowMzowMC4wOiBBTUQtVmk6DQog
RXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGUgYWRkcmVzcz0weGFlOTY2
OGJjIGZsYWdzPTB4MDAwMF0NCg0KUGxlYXNlIHRyeSB0byB0dXJuIG9mZiBJT01NVSBieSBlZGl0
aW5nIC9ldGMvZGVmYXVsdC9ncnViDQpHUlVCX0NNRExJTkVfTElOVVhfREVGQVVMVD0icXVpZXQg
c3BsYXNoIGFtZF9pb21tdT1vZmYgaW9tbXU9b2ZmIg0KDQpBbmQgdGhlbiB1cGRhdGUtZ3J1Yg0K
DQo+IA0KPiBJIHJ1biBBcmNoTGludXggd2l0aCBLREUgUGxhc21hLCBmb3IgbmV0d29ya2luZyBJ
IHVzZSBOZXR3b3JrTWFuYWdlciBhbmQNCj4gd3BhX3N1cHBsaWNhbnQuDQo+IA0KPiBJZiB5b3Ug
d291bGQgbGlrZSBtZSB0byBydW4gdGVzdHMgd2l0aCBlLmcuIGp1c3QgaXdkIEkgY2FuIGRvIHNv
LCBqdXN0DQo+IGxldCBtZSBrbm93IHdoYXQgc2V0dXAgeW91IHdvdWxkIGxpa2UgbWUgdG8gaGF2
ZS4NCj4gDQo+IEkgZG8gbm90IGhhdmUgdGhpcyBpc3N1ZSB3aXRoIHRoZSBMVFMga2VybmVsIDYu
MTguMzQuIFRoaXMgYWZmZWN0cyA3LjANCj4gYW5kIDcuMS4NCj4gSSBiZWxpZXZlIHRoaXMgaXNz
dWUgd2FzIG5vdCBwcmVzZW50IGluIDwgNyBrZXJuZWxzLCBidXQgSSBjYW5ub3QgZ3VhcmFudGVl
Lg0KPiBJIGNhbiBob3dldmVyIGRvd25ncmFkZSB0byBwcmV2aW91cyBrZXJuZWxzIHRvIHVuZGVy
c3RhbmQgd2hlcmUgdGhlDQo+IGlzc3VlIHdhcyBpbnRyb2R1Y2VkLg0KDQpUaGUgY29tbWl0cyBi
ZXR3ZWVuIDYuMTguMzQgfiA3LjAuMTAgYXJlIHF1aXRlIGZldywgYW5kIEkgY2FuJ3QgZmluZCB0
aGUgDQpvbmUgdGhhdCBjYW4gYWZmZWN0IHRoZSBiZWhhdmlvci4gUGxlYXNlIHN3aXRjaCB5b3Vy
IGtlcm5lbCBiYWNrIHRvIDYuMTguMzQsDQphbmQgYXBwbHkgcnR3ODgncyBwYXRjaGVzIGFkZGVk
IHVudGlsIDcuMC4xMC4NCg0KU2luY2UgdGhlIGxhc3QgY29tbWl0IG9mIDYuMTggaXMgZmNlNmZl
ZTA4MTdiODg5OWUwZWUzOGFiNmI5OGYwZDdlOTM5Y2VlZA0KDQpQbGVhc2UgdXNlIGJlbG93IGNv
bW1hbmRzIHRvIGdldCB0aGUgKDIwKSBwYXRjaGVzOg0KZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OCQgZ2l0IGZvcm1hdC1wYXRjaCB2Ny4wLjEwLi4uZmNlNmZlZTA4MTdiODg5OWUw
ZWUzOGFiNmI5OGYwZDdlOTM5Y2VlZCAtLSAuLw0KDQpUaGVuIHlvdSBjYW4gYWRkIHRoZW0gb25l
IGJ5IG9uZSB0byBzZWUgd2hpY2ggb25lIGlzIHRoZSBjYXVzZS4NCg0KVGhlIGdpdCByZXBvc2l0
b3J5IHlvdSBuZWVkIGlzOg0KZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUuZ2l0DQoNCg0KUGluZy1LZQ0KDQoNCg==

