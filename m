Return-Path: <linux-wireless+bounces-33911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEcxOiSUxGnH0gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:04:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18132E2D0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0556301D31A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8723183C;
	Thu, 26 Mar 2026 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QEt9csIc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10919CD0A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490341; cv=none; b=TDt/NbCoo2y5QQtj8Ftd81ACPkVPcME9tb2qge/tiAAzEsPo5xBtDRyhDoatpL/q4mbig+igV9T79S5gQa8Yeq7bQ0Vkj3yVZg5phEK4B5tuQz5IOQLAKaha1wv/C5QSni8OHEbjjtuK8u/vgusMN2IiRf3YN9BvNuZmYCl0GMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490341; c=relaxed/simple;
	bh=JvTpsI0w3hzGDywz9u9zWjiaseRvUee8YN9GinM1u/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nL7+Npikh2aF10g9lNG5EqlNrXE81lFjtpiL6gUZPvqy9hiHUjGG1Z4q0ScihdD2kvbf0BmriWBmEu5nMN687hkSVYCZsofWukkZbBajdTWYAsrsYbTcEta/D300TADhBtZ5XSvA+VW1UqEgJEGt6CwKNRIFiAXYxd4GxAlleiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QEt9csIc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62Q1wuKJ3542623, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774490336; bh=JvTpsI0w3hzGDywz9u9zWjiaseRvUee8YN9GinM1u/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QEt9csIcwFGODzIvSlKVbUnsPlvIAwTFlxNhypyv37jmwr32ArzcDGapcaDT3Xs7a
	 OZ9F3c2gXx4+M6V+9+bXMSVndv0MUi4OzcRgmUB36Zuz36eBRRykGIM8BDmypgGEf4
	 +AjcpGiKovhmZ2wv8p261yxlWqhLHTCstV+UnqLSCA7vzeoprAEyLwNOrvSdPtw98K
	 39kX27/sJ2k7jukS0KHJD4z4Ez6hmKsqaaBGaJJSK2uAdihrF2/ZviZZQGitYUs9qJ
	 mkT6VYHJnm5G/NtV6Av+RBaODraubUKFkpFkyutzuUb+0vKC2qHyqW3fBXTgKPloxB
	 kV47NazUINEIw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62Q1wuKJ3542623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 09:58:56 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 09:58:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Mar 2026 09:58:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 09:58:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
Thread-Topic: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
Thread-Index: AQHcl5KLHCE4H4O1KEKTrTKhNQ84N7V6Ax0wgEWe0gCAALa1MA==
Date: Thu, 26 Mar 2026 01:58:55 +0000
Message-ID: <6e49be57199f4db788b02c70626f20d5@realtek.com>
References: <98129317-7e88-4654-910b-630aa992bfa3@gmail.com>
 <946684847bb0463aa794828d3e1a3e83@realtek.com>
 <491d5140-f16d-44a6-bf01-8f35e43e2fdf@gmail.com>
In-Reply-To: <491d5140-f16d-44a6-bf01-8f35e43e2fdf@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-33911-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C18132E2D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMDkvMDIvMjAyNiAxMDowMSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4gVGhpcyBmdW5jdGlv
biBXQVJOcyB3aGVuIHRoZSB3aWZpIGJhbmQsIGNoYW5uZWwgbnVtYmVyLCBjaGFubmVsIHdpZHRo
LA0KPiA+PiByYXRlLCBvciBSRiBwYXRoIGFyZSBpbnZhbGlkLiBUd28gb3IgdGhyZWUgcGVvcGxl
IGhhdmUgcmVwb3J0ZWQgdGhhdCBpdA0KPiA+PiBmbG9vZHMgdGhlIGtlcm5lbCBsb2cgd2l0aCB3
YXJuaW5ncyBiZWNhdXNlIHRoZXkgdHJ5IHRvIHN3aXRjaCB0bw0KPiA+PiBpbnZhbGlkIGNoYW5u
ZWwgbnVtYmVycywgbGlrZSAxMzAuDQo+ID4+DQo+ID4+IE9uZSB3YXJuaW5nIGlzIHByb2JhYmx5
IGVub3VnaCwgc28gdHVybiBXQVJOIGludG8gV0FSTl9PTkNFLg0KPiA+Pg0KPiA+PiBDbG9zZXM6
IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OC9pc3N1ZXMvNDI4DQo+ID4NCj4gPiBB
cyB0aGUgaXNzdWUgc2F5cyAiaW52YWxpZCBhcmd1bWVudHMsIGJhbmQ9MSwgYnc9MiwgcGF0aD0x
LCByYXRlPTgzLCBjaD0xMzAiLA0KPiA+IEkgdGhpbmsgaXQgb3BlcmF0ZXMgb24gYmFuZHdpZHRo
IDgwTUh6IGFuZCBwcmltYXJ5IGNoYW5uZWwgMTMwLg0KPiA+IEJ1dCBJIGRvbid0IHNlZSAyME1I
eiBwcmltYXJ5IGNoYW5uZWwsIGZvciBleGFtcGxlIFsxXS4NCj4gPg0KPiA+IENhbiB3ZSBzdG9w
IHVzaW5nIHRoaXMgY2hhbm5lbCBhdCBzZXRfY2hhbm5lbCgpIGFoZWFkIHRvIGF2b2lkIHRoaXMg
ZXJyb3I/DQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvTGlzdF9v
Zl9XTEFOX2NoYW5uZWxzDQo+ID4NCj4gDQo+IElzIHRoZXJlIGEgc3RhbmRhcmQgd2hpY2ggc2F5
cyB3aGF0IGNoYW5uZWxzIGFyZSBhbGxvd2VkPw0KPiANCj4gU2l4IHdlZWtzIGFnbyBJIGFza2Vk
IHBlb3BsZSB0byB0ZXN0IGFub3RoZXIgcGF0Y2ggd2hpY2ggYWRkcyBhIGNoZWNrDQo+IGluIHJ0
d19zZXRfY2hhbm5lbCgpIGxpa2UgeW91IHNhaWQsIGJ1dCBubyBvbmUgcmVwbGllZC4gSSBndWVz
cyBJIHdpbGwNCj4gc2VuZCBpdCBhcyB2Mi4NCg0KV2UgYXJlIHdvcmtpbmcgb24gYSBwYXRjaCB0
byBzdG9wIHRoaXMga2luZCBvZiBjaGFubmVscy4gSSdkIHNlbmQgYSBSRkMNCmluIGNvbWluZyB3
ZWVrLiANCg0KPiANCj4gQnkgdGhlIHdheSwgdGhlcmUgaXMgYW5vdGhlciBwYXRjaCByZWxhdGVk
IHRvIHRoaXMgcHJvYmxlbToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdp
cmVsZXNzLzIwMjYwMzA2LXJ0dzg4X2NoYW5uZWwxMzAtdjEtMS1mZjI1YTUNCj4gYmM5MzBhQGln
YWxpYS5jb20vDQo+IA0KDQpJIHNlZS4NCg0KUGluZy1LZQ0KDQo=

