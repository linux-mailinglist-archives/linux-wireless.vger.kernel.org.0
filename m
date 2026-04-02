Return-Path: <linux-wireless+bounces-34294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDbTEh7WzWn1iAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:36:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AB382BCA
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DFC3018098
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 02:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BCE2C029F;
	Thu,  2 Apr 2026 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M4cNDqF8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6A2459C6
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097371; cv=none; b=fj0rpZ1qqUFgYLTPOBuG77l8fkAhPkCyEtH0BwDfUxxDHKfs6ia7w73mt8d+1tRUjRMzrhngPX9WEr2twYatMUcgSuUeWFGVkxIpl9Lk9Ik93An1ovxKYbHQggkr9LatKK/4i+k0vhRcYYoUI0Rhr4UyhhY8QETwTxI9svbEfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097371; c=relaxed/simple;
	bh=7DNRyHTIpa+JJR/3SZeDMkwGNlcFeNbpGDH4RXnuI2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2ZHwdoFeGZat0VEPkXp14QcTN/tY8JO5ZNVNCGP3Uxtf0io23LpAiGUbD2spbhc+Nxik9OURZWqQi4KXl4f2Hp5a/ashVb7Gy1DtL7veYA6978bhXmfdDnErXUi7Qf2UgFRB0RKi2MLCAeNn+wmIT7iswwuPg+Ps8SDMQZpsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M4cNDqF8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6322a3u352269185, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775097363; bh=7DNRyHTIpa+JJR/3SZeDMkwGNlcFeNbpGDH4RXnuI2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M4cNDqF8+ADvE8x6O7XALYvgxFgGbeadzCKDR4xAKpc3w3FkVd8mStNcMtA/y2qsF
	 XVQ1FtNsNzjrVxjEb18lUUfjsXiFf529zkLcfrdbrsqLr4brLjuuPdJmKTBg1Zt79p
	 cSsJCk3JSFURFXxGp4cA3gYnf3g5YJar7pZauPSYCv3qwHZkAw1/GTXjmyhQunQcvb
	 BbP7bmvDMBoZ3+eRP0sA5lRWTsKaCU4Jyo53bAwTU8nWAw5sqOo+0xojIFQVss81e0
	 kjx4goOqOhQzm4dt2we5iLMk7QLsQC367qrpX3yarrtS/SD1Nf+9bP1+Xu/JaGzmgN
	 sBA2ic3F48msA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6322a3u352269185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 10:36:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 10:36:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 10:36:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292%10]) with mapi id
 15.02.1748.010; Thu, 2 Apr 2026 10:36:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?SmVmZnJleSBXw6RsdGk=?= <jeffrey@waelti.dev>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Topic: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration
 on AP bandwidth change
Thread-Index: AQHcurr3ssaqHgvFgEq3QbzjT47FFLW87FxAgAIyVoCAANiPoIAJoX6AgAGDxQA=
Date: Thu, 2 Apr 2026 02:36:01 +0000
Message-ID: <4b0f77fcdaf74da5a1c5e77b83f972df@realtek.com>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev>
 <8bf447cc627746cca6eb30ae283bbbe6@realtek.com>
 <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev>
 <f387614466ce497fb59d4ad98ef641f5@realtek.com>
 <JSFJ7Do8YsCSMLsXH6KLXADJ0-z0Dh-y99PpaSCHiCwp6aikxldPnTr9mXpEAifNezf2gFyPPiHIaobekBeqiM4XVpO8hYKyXvuei4lKVc0=@waelti.dev>
In-Reply-To: <JSFJ7Do8YsCSMLsXH6KLXADJ0-z0Dh-y99PpaSCHiCwp6aikxldPnTr9mXpEAifNezf2gFyPPiHIaobekBeqiM4XVpO8hYKyXvuei4lKVc0=@waelti.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34294-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[waelti.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A09AB382BCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SmVmZnJleSBXw6RsdGkgPGplZmZyZXlAd2FlbHRpLmRldj4gd3JvdGU6DQo+IA0KPiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEplZmZyZXkgV8OkbHRp
IDxqZWZmcmV5QHdhZWx0aS5kZXY+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IDxwa3NoaWhAcmVhbHRl
ay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUGxlYXNlIHRyeSB0byBkaXNh
YmxlIHBvd2VyIHNhdmUgYW5kIEFTUE0gYnkNCj4gPiA+ID4gMSkgaXcgd2xhbjAgc2V0IHBvd2Vy
X3NhdmUgb2ZmDQo+IA0KPiBJJ20gc29ycnksIHRoaXMgaXMgbXkgZmlyc3QgdGltZSBpbnRlcmFj
dGluZyB3aXRoIHRoZSBtYWlsaW5nIGxpc3QgYW5kIEkgb3Zlcmxvb2tlZCB0aGUgb3RoZXIgaW5z
dHJ1Y3Rpb25zLg0KPiBJdCBzZWVtcyBsaWtlIGRpc2FibGluZyBwb3dlciBzYXZlIGdldHMgcmlk
IG9mIHRoZSBpc3N1ZSBvZiBXaS1GaSB0aW1lb3V0cy4gSSBoYXZlbid0IGJlZW4gYWJsZSB0bw0K
PiByZXByb2R1Y2UgdGhlIGlzc3VlIHdpdGggYGl3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZmAg
eWV0LCBldmVuIHdpdGhvdXQgYW55IG9mIHRoZSBvdGhlciBmaXhlcyBvbiBrZXJuZWwNCj4gNi4x
OS4xMCBhbmQgNy4wLXJjNi4NCj4gDQo+ID4gPiA+IDIpIHJlZmVyZW5jZSBhbmQgaW5zdGFsbA0K
PiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5L2Jsb2IvbWFpbi83MC1ydHc4
OS5jb25mDQo+ID4gPiA+ICAgIGFuZCB0aGVuIGNvbGQgcmVib290Lg0KPiA+DQo+ID4gSGF2ZSB5
b3UgdGVzdGVkIHdpdGggdGhlc2UgY29uZGl0aW9ucz8NCj4gDQo+IFVzaW5nIHRoaXMgcGF0Y2gg
ZWxpbWluYXRlcyB0aGUgaXNzdWUgb2YgQmx1ZXRvb3RoIGRldmljZXMgZGlzY29ubmVjdGluZywg
d2hlbiBzd2l0Y2hpbmcgYmV0d2Vlbg0KPiBuZXR3b3Jrcy4NCj4gDQo+ID4gWy4uLl0NCj4gPg0K
PiA+ID4gPg0KPiA+ID4gPiBQbGVhc2UgaGVscCB0byB0ZXN0IHRoZSBsYXRlc3Qga2VybmVsIDcu
MC1yYyB3aXRoIGFkZGl0aW9uYWwgcGF0Y2ggWzFdLg0KPiA+ID4gPg0KPiA+ID4gPiBbMV0NCj4g
PiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjYwMzEwMDgwMTQ2
LjMxMTEzLTQtcGtzaGloQHJlYWx0ZWsNCj4gPiA+IC5jb20vDQo+ID4NCj4gPiBIYXZlIHlvdSBh
bHNvIGFwcGxpZWQgdGhpcyBwYXRjaD8NCj4gDQo+IEkgdGVzdGVkIGtlcm5lbCA3LjAtcmM2IHdp
dGggdGhpcyBwYXRjaCBhcHBsaWVkIG9uIHRvcCBmb3IgfjEgZGF5IG5vdyBhbmQgaGF2ZW4ndCBi
ZWVuIGFibGUgdG8gcmVwcm9kdWNlLA0KPiBldmVuIHdpdGggcG93ZXIgc2F2ZSBlbmFibGVkLiBI
b3dldmVyLCBpdCBpcyBhIGJpdCBkaWZmaWN1bHQgdG8gcmVsaWFibHkgdHJpZ2dlciB0aGUgaXNz
dWUgYXMgaXQgc2VlbXMNCj4gdG8gdHJpZ2dlciBtb3JlIG9uIGNlcnRhaW4gbmV0d29ya3MgdGhh
biBvdGhlcnMgZXRjLg0KPiANCj4gPiA+ID4NCj4gPiA+ID4gUGluZy1LZQ0KPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSBmb3IgY29taW5nIGJhY2sgdG8gbWUgc28gcXVp
Y2tseSwgSSBqdXN0IGVuY291bnRlcmVkIHRoZSBzYW1lIHRoaW5nDQo+ID4gPiB3aXRoIGtlcm5l
bCA3LjAtcmM1Lg0KPiA+ID4NCj4gPg0KPiA+IFBsZWFzZSBjb25maXJtIG15IHF1ZXN0aW9ucyBh
Ym92ZS4NCj4gPg0KPiA+IFBpbmctS2UNCj4gPg0KPiA+DQo+IA0KPiBJbiBzdW1tYXJ5Og0KPiAt
IERpc2FibGluZyBwb3dlciBzYXZlIHNlZW1zIHRvIHN0b3AgdGhlIHRpbWVvdXRzIGJ1dCBCbHVl
dG9vdGggaXNzdWVzIHJlbWFpbg0KPiAtIERpc2FibGluZyBBU1BNIGZlYXR1cmVzIGZpeGVzIHRo
ZSBCbHVldG9vdGggaXNzdWUNCj4gLSBrZXJuZWwgNy4wLXJjNiB3aXRoIHRoZSBhZGRpdGlvbmFs
IHBhdGNoIGZpeGVzIFdpLUZpIHRpbWVvdXRzIGJ1dCBub3QgdGhlIEJsdWV0b290aCBkaXNjb25u
ZWN0cw0KPiANCj4gSSBob3BlIHRoYXQgYW5zd2VycyB5b3VyIHF1ZXN0aW9ucy4NCg0KSXQgbG9v
a3MgbGlrZSBhZGRpdGlvbmFsIHBhdGNoIGNhbiBmaXggdGhlIFdpRmkgdGltZW91dHMgcHJvYmxl
bSwgYW5kDQpkaXNhYmxpbmcgQVNQTSBmZWF0dXJlIGNhbiBmaXggQmx1ZXRvb3RoIGlzc3VlLiBJ
IHRoaW5rIHlvdSBjYW4ga2VlcA0KKDIpICsgKDMpIHNldHRpbmcgYXMgd29ya2Fyb3VuZC4NCg0K
SSdkIHRhbGsgd2l0aCBCVCBjb2V4aXN0ZW5jZSB0ZWFtIGludGVybmFsbHkgdG8gZmlndXJlIG91
dCB0aGUgY2F1c2UNCm9mIEJsdWV0b290aCBkaXNjb25uZWN0aW9uLiANCg0KUGluZy1LZQ0KDQo=

