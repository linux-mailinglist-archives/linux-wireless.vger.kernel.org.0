Return-Path: <linux-wireless+bounces-38230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t8mNKrvNQWqHugkAu9opvQ
	(envelope-from <linux-wireless+bounces-38230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:43:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAC6D56CC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:43:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=rJyow4h5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38230-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38230-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AF9300C02F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12165246770;
	Mon, 29 Jun 2026 01:43:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC631C5D59
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:43:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697401; cv=none; b=Tu5epvP93Uyk2aSKfYlvcqVe43kLzsyT0pposwrlKtZcDHRQ+1OZ1WoxbH/TxnVIdsiF3ZnFABy/3aaLvzlU8g9xj5AmQ48gx/6OY3s6qbs9B9qPLWUm+hJzCLihDx3DfV2WeMWP38E1MAZmMv46pR/0O9iW0nsSnz0nS2qqH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697401; c=relaxed/simple;
	bh=2m1aWKVqoZCUaa0abg7iLGE9q0O6Rs0NypUNpOuDfYE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tl6zBnx4xFXXahv1pT62SBf/rj0FSSmY438U0bT7lQk8l0ru8/uWiipA3WRhi0wR+fKG5QFX+U6HhMs31Qgc6t2e9rEcXaX9h8Y/+zV+GgGGADeaZbDl05ykUVS7TTuyRlur/d1bDJxjSHsDp6+bsqhrG8BhjHFKZxcE4O1RiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rJyow4h5; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T1gti673298593, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782697375; bh=2m1aWKVqoZCUaa0abg7iLGE9q0O6Rs0NypUNpOuDfYE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rJyow4h5Su1+HdCll+0JZMD21R3abjMCmZ2bBTTMDhkRv61oCcKP5nlrhIuTkJeA/
	 86LYicNbcKd+ggcU3TkZWskZ4dkYcNqEdoDv65ii0UJWzLquiwS0aR2dZoWLBChgbJ
	 Na7hwrEmkk8ArxkKLkts0Sz5ZQ+K4GjbaU/isiMUp907IxfgolvUdd+s2nHs2G4Ms9
	 XZJfGbPyoOGQEZ5cTAcek9GPp+6kTJQ9PUNGEAcz80Ean0Tw0phrIf1nfiWjbiSVPo
	 fZ5aMepMkjC4lc2irNqRzHnmseUW4o5IaNFXXpVIC1AvA0gR9YfFJVjvgl6h8NBemR
	 Lj1kdwVT7U9Ng==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T1gti673298593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 09:42:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 09:42:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 09:42:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 29 Jun 2026 09:42:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: NIPA/wifibot disappeared
Thread-Topic: NIPA/wifibot disappeared
Thread-Index: AQHc7ceiWUwUmh0QVECGXfEz9ei6c7ZDz64AgAaJOxCACpqm8A==
Date: Mon, 29 Jun 2026 01:42:56 +0000
Message-ID: <81f7ed6a1dc3418a956b7941ca8742d0@realtek.com>
References: <a5615f2658fe31a32836d02aa0f2d69027782bea.camel@sipsolutions.net>
 <8f08a690242483a0c1026e7b006f48c9c01c6f30.camel@sipsolutions.net>
 <c7363a78c6324d519651c7729617b725@realtek.com>
In-Reply-To: <c7363a78c6324d519651c7729617b725@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38230-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2CAC6D56CC

DQpQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBKb2hh
bm5lcywNCj4gDQo+IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+IHdy
b3RlOg0KPiA+IEl0J3Mgb24gdGhlIG5ldGRldiBjb25maWcsIHNvIHBlcmhhcHMgYSBsaXR0bGUg
cGlja2llciB0aGFuIGl0IHVzZWQgdG8NCj4gPiBiZS4NCj4gDQo+IE5vdCBzdXJlIGhvdyBpdCBj
b25zaWRlcnMgLW5leHQgdHJlZS4gTXkgcGF0Y2ggd2l0aCBzdWJqZWN0DQo+ICJbUEFUQ0ggcnR3
LW5leHRdIHdpZmk6IHJ0bDh4eHh1OiA4NzIzYnU6IC4uLiIgaXMgdHJlYXRlZCBhcyBub24tbmV4
dCB0cmVlIFsxXS4NCj4gDQo+IENvdWxkIHlvdSBoZWxwIHRvIHVwZGF0ZSBOSVBBIGNvbmZpZ3Vy
YXRpb24/IE9yIHNob3VsZCBJIGNoYW5nZSB0byBvdGhlcg0KPiBwcm9wZXIgdHJlZSBzZWxlY3Rp
b24gb2Ygc3ViamVjdCBwcmVmaXg/DQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjYwNjIyMDE1NDM5Ljk2MjEt
MS1wa3NoaWhAcmVhbHRlay5jb20NCj4gLw0KDQpJdCBsb29rcyBsaWtlIE5JUEEgbWlzcmVhZCAi
cnR3LW5leHQiIGFzICJydHciIGF0IHRoZSBzdGVwIG9mIHRyZWUgc2VsZWN0aW9uLg0KICAgIHdp
Zmlib3QvdHJlZV9zZWxlY3Rpb24gLS0+IENsZWFybHkgbWFya2VkIGZvciBydHcNCg0KQ3VycmVu
dGx5LCB3ZSB1c2UgInJ0dyIgZm9yIGN1cnJlbnQgZml4LCBhbmQgInJ0dy1uZXh0IiBmb3IgLW5l
eHQuIEhvd2V2ZXIsDQoicnR3IiBpcyBzdWJzdHJpbmcgb2YgInJ0dy1uZXh0Ii4gSWYgdGhpcyBp
c24ndCBhIGdvb2QgY2hvaWNlLCB3ZSBjYW4gY2hhbmdlDQoicnR3IiB0byAicnR3LWN1cnJlbnQi
IG9yICJydHctZml4Ii4gDQoNClRoYW5rcw0KUGluZy1LZQ0KDQo=

