Return-Path: <linux-wireless+bounces-37085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPkEE1LnGGruoggAu9opvQ
	(envelope-from <linux-wireless+bounces-37085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 03:09:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E472A5FBD56
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 03:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B261F301C678
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426D1C84DE;
	Fri, 29 May 2026 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SkkA5PA9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5D1DDC37
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016974; cv=none; b=bzPBbHw9YuLvWgkic77gKaZ5y5lQ+V/o/XPYEc8hGnI53MhjUOLYg2Tos664k7QAh3SSp6yKGJ4eDJ2LNwaD3Kbm4FJXy6qyLXVh8fdGJ+TerHpdlIH33Adx9uQNpbF2n2r8o2uxET/tRjNfPtKF83b9BJScGFZwu5MWfzLIPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016974; c=relaxed/simple;
	bh=oXga0y0icuidudiAD/PPcAQI5Sloe2EWGoit3w9u9Wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NC7T+wc/mEuFWABQ4kMcjGJoitemgRXw89w7TRKqRsOLlReIogD/DnKMN4Kbo6Tmros2d8ccBXxWJcS8mvDNh35WSTZLI4cWzaVic1iHYb7n/ohG2wGy/yXCO+tGEY8nhV9SfBEs2GDgrEotMWAa8tppHQhCcIs1kCi1929eIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SkkA5PA9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T19NFK03769972, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780016963; bh=oXga0y0icuidudiAD/PPcAQI5Sloe2EWGoit3w9u9Wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SkkA5PA9sbY/MrP6eX0wq5WLSSvCI6g+lucDMlZK/p6M8A1G4xY8LQrKxjihD9VLu
	 O8ArQ3Ic4fNjXdXImA2ucQQM6nL07zx84gJtcidf0LWJDX05t8wgaBu7iIDeAaZV5S
	 4GRC162PhmrtQ2W/9JVxlA/88Ho8DHwyQLkockPjisPRnISqXo6xd9cBH2U9DsH7Zd
	 JTBf3F6Snuj19hJGZeOGhNo9aVvk04iHLJfWbMz7HBZUpYCwPKm0gfYcRs/OAduazD
	 Vjj3PdGt85bNYnrjIxXYJA0I8Zft2J3EGmEu4xTAjtugURw81LYTJTBfw68FfYzeLj
	 yd0kp8AzQ1DAg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T19NFK03769972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 09:09:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 09:09:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 29 May 2026 09:09:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: VolcomIlluminated <volcomilluminated@tuta.com>, Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: usb: retry control message on -EPROTO error
Thread-Topic: [PATCH] rtw88: usb: retry control message on -EPROTO error
Thread-Index: AQHc7tz+Z+dcBepZBku/0c4Rq/9FiLYkLHcQ
Date: Fri, 29 May 2026 01:09:22 +0000
Message-ID: <c3e40e8b0a3f4b1e96ca76072700175f@realtek.com>
References: <Otk9l6D--F-9@tuta.com>
In-Reply-To: <Otk9l6D--F-9@tuta.com>
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
	TAGGED_FROM(0.00)[bounces-37085-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tuta.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:mid,realtek.com:dkim,tuta.com:email]
X-Rspamd-Queue-Id: E472A5FBD56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpWb2xjb21JbGx1bWluYXRlZCA8dm9sY29taWxsdW1pbmF0ZWRAdHV0YS5jb20+IHdyb3RlOg0K
PiAtLS0gL3RtcC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
dXNiLmMJMjAyNS0xMS0zMCAxNzo0MjoxMC4wMDAwMDAwMDAgLTA1MDANCj4gKysrIC9ob21lL3B0
cHg4Nm1tMS9rZXJuZWxidWlsZC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvdXNiLmMJMjAyNi0wNS0yNCAyMDowNjoyNy43OTgzMzcyMzcgLTA0MDANCg0KWW91
ciBnaXQgcmVwb3NpdG9yeSBsb29rcyB3ZWlyZC4NCg0KUGxlYXNlIGNsb25lIGh0dHBzOi8vZ2l0
aHViLmNvbS9wa3NoaWgvcnR3LmdpdCBhbmQgc3dpdGNoIHRvIHJ0dy1uZXh0IGJyYW5jaC4NCg0K
QnkgdGhlIHdheSwgdGhlIHN1YmplY3QgcHJlZml4IHNob3VsZCBiZSAiW1BBVENIIHJ0dy1uZXh0
XSB3aWZpOiBydHc4ODogLi4uIi4NCg0KPiBAQCAtMTQwLDYgKzE0MCwxNiBAQA0KPiAgCXJldCA9
IHVzYl9jb250cm9sX21zZyh1ZGV2LCB1c2Jfc25kY3RybHBpcGUodWRldiwgMCksDQo+ICAJCQkg
ICAgICBSVFdfVVNCX0NNRF9SRVEsIFJUV19VU0JfQ01EX1dSSVRFLA0KPiAgCQkJICAgICAgYWRk
ciwgMCwgZGF0YSwgbGVuLCA1MDApOw0KPiArCWlmIChyZXQgPT0gLUVQUk9UTykgew0KPiArCQlp
bnQgcmV0cnk7DQo+ICsNCj4gKwkJZm9yIChyZXRyeSA9IDA7IHJldHJ5IDwgMyAmJiByZXQgPT0g
LUVQUk9UTzsgcmV0cnkrKykgew0KPiArCQkJbXNsZWVwKDEwKTsNCj4gKwkJCXJldCA9IHVzYl9j
b250cm9sX21zZyh1ZGV2LCB1c2Jfc25kY3RybHBpcGUodWRldiwgMCksDQo+ICsJCQkJCSAgICAg
IFJUV19VU0JfQ01EX1JFUSwgUlRXX1VTQl9DTURfV1JJVEUsDQo+ICsJCQkJCSAgICAgIGFkZHIs
IDAsIGRhdGEsIGxlbiwgNTAwKTsNCg0KRG9uJ3QgZHVwbGljYXRlIHRoZSBjb2RlIG9mIGlkZW50
aWNhbCB1c2JfY29udHJvbF9tc2coLi4uKS4NCg0KSnVzdCANCg0KZm9yIChyZXRyeSA9IDA7IHJl
dHJ5IDwgMzsgcmV0cnkrKykgew0KCXJldCA9IHVzYl9jb250cm9sX21zZyguLi4pOw0KICAgIGlm
IChyZXQgIT0gLUVQUk9UTykNCgkJYnJlYWs7DQoNCgltc2xlZXAoMTApOyAvKiBkZWxheSBiZWZv
cmUgcmV0cnlpbmcgKi8NCn0NCg0KQml0dGVyYmx1ZSwgY291bGQgeW91IGhhdmUgc29tZSBpbnB1
dHMgYWJvdXQgdGhpcyByZXRyeSwgc2luY2UgSSBkb24ndCBoYXZlDQptdWNoIGtub3dsZWRnZSBh
Ym91dCBVU0I/DQoNCj4gKwkJfQ0KPiArCX0NCj4gIAlpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVO
T0RFViAmJiBjb3VudCsrIDwgNCkNCj4gIAkJcnR3X2VycihydHdkZXYsICJ3cml0ZSByZWdpc3Rl
ciAweCV4IGZhaWxlZCB3aXRoICVkXG4iLA0KPiAgCQkJYWRkciwgcmV0KTsNCg0K

