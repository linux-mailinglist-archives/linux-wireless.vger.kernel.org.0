Return-Path: <linux-wireless+bounces-10604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB71693EF0B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6980E1F20FCA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459312C54D;
	Mon, 29 Jul 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DTiKy8PE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7F84A2F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239527; cv=none; b=gXjrs+yv7Wx0EAIFSvCl/FF1r8g7C2UFTZMq26Q+sWvOPsxjsTFnpL+u/XpWxJzMmx8N7VFu4IHoijtvUo1xSeVCFPuwdg0v7vnzeFoxbMSspIadeUFluTjDg6NgLDaJEu7D0IStAjqRpqo5NDL/8Xj3C1cSWezV0P9j42F98AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239527; c=relaxed/simple;
	bh=oaPmRQiGzFM8RA34vsSgf1NTfBHm2j98GhbID1Hxrp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTkpDWl0IbjpQxpcvGiOVbiKzeRsBj+dDMFMKdWM39vm74tLtF8LNevKaCw73yll1x+mIGN8QRH1zv+ZmR+qCKN6Ce31SAabgmzSHXe5HIgtSMRM6NOudj9Qirv+6S/0MCRMXjq8OxuOOwuskIPtIDuyq59Mw2VWN6kJlaiq4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DTiKy8PE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46T7ptY033675174, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722239515; bh=oaPmRQiGzFM8RA34vsSgf1NTfBHm2j98GhbID1Hxrp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DTiKy8PEwFPZqSS2GsjuFj1dlzWgTMTPUks5b56O6k+SB8S0BmWIWf7r7nq4y0+Eu
	 MZVKhwAGFWzj+mdMQT2W0dEqZA0D/hooh0tShjD6SAa/E7z0aYubgWxfGNXuKx3taj
	 JWUQP+PiqYuBTxCPM45MVJZqX5ZnqWShv+4SzWtSsbwfLrUaHe30vSWlQrcIR5+43w
	 ggUmXL8f3T8sFnv5Mp6YoQSx4yJvf5Ddmv9k012qZI2C9ibD/UqfmtfPUPv6kxnDt0
	 2X0adkJbKA6eBulLY6Ujdun3btu+74q7jJ4dy3nJbCD2OXfrReikcPjYR84H4NOoW/
	 8C2SxP3s8rlHg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46T7ptY033675174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 15:51:55 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 15:51:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jul 2024 15:51:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Jul 2024 15:51:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: avoid warning of no supported legacy rate if empty rate mask for rate control
Thread-Topic: [PATCH] wifi: mac80211: avoid warning of no supported legacy
 rate if empty rate mask for rate control
Thread-Index: AQHa3wodvsNMT0kZSkKHsJ1CctHN8rIISVgAgAUQETA=
Date: Mon, 29 Jul 2024 07:51:55 +0000
Message-ID: <b04e7512dee64995bf5388288bdc08e3@realtek.com>
References: <20240726031520.7616-1-pkshih@realtek.com>
 <6ab2dc9c3afe753ca6fdcdd1421e7a1f47e87b84.camel@sipsolutions.net>
In-Reply-To: <6ab2dc9c3afe753ca6fdcdd1421e7a1f47e87b84.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IA0KPiBX
ZSBoYWQgdGhpcyBwcmVjaXNlIGRpc2N1c3Npb24gcHJldmlvdXNseSBmb3Igc2Nhbm5pbmcsIGFu
ZCBqdXN0IGxpa2UNCj4gdGhlcmUsIGZpeGVkIGluIGFiOTE3N2Q4M2MwNCAoIndpZmk6IG1hYzgw
MjExOiBkb24ndCB1c2UgcmF0ZSBtYXNrIGZvcg0KPiBzY2FubmluZyIpLCBJIGZlZWwgdGhlIHJp
Z2h0IHdheSB0byBhcHByb2FjaCB0aGlzIGlzc3VlIGhlcmUgd291bGQgYmUgdG8NCj4gc2ltaWxh
cmx5IG5vdCB1c2UgdGhlIHJhdGUgbWFzayBmb3Igb2ZmY2hhbm5lbCBUWCwgd2hpY2ggaXMgSSB0
aGluaw0KPiBwcmV0dHkgbXVjaCB0aGUgc2FtZSBzaXR1YXRpb24sIHlvdSBjb3VsZCBoYXZlIGEg
cmF0ZSBtYXNrIHNldCBmb3Igb25seQ0KPiAyLjQgR0h6IHdoZXJlIHRoZSBjb25uZWN0aW9uIGlz
IChhbmQgZW1wdHkgZm9yIG90aGVyIGJhbmRzKSwgd2hpY2ggaXMNCj4gYWNjZXB0ZWQgYnkgY2Zn
ODAyMTEgYW5kIG1hYzgwMjExLCBidXQgdGhlbiBkbyBvZmZjaGFubmVsIFRYIG9uIDUgR0h6DQo+
IGFueXdheS4NCj4gDQo+IFNvIEkgdGhpbmsgdGhlIHJpZ2h0IHdheSB0byBhcHByb2FjaCB0aGlz
IHdvdWxkIGJlIHRvIGRvIHNvbWV0aGluZyBsaWtlDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L21h
YzgwMjExL29mZmNoYW5uZWwuYyBiL25ldC9tYWM4MDIxMS9vZmZjaGFubmVsLmMNCj4gaW5kZXgg
MjhkMDMxOTZlZjc1Li4zMzM2MWI0ZDlhY2YgMTAwNjQ0DQo+IC0tLSBhL25ldC9tYWM4MDIxMS9v
ZmZjaGFubmVsLmMNCj4gKysrIGIvbmV0L21hYzgwMjExL29mZmNoYW5uZWwuYw0KPiBAQCAtODMw
LDYgKzgzMCw4IEBAIGludCBpZWVlODAyMTFfbWdtdF90eChzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBz
dHJ1Y3Qgd2lyZWxlc3NfZGV2ICp3ZGV2LA0KPiAgICAgICAgICAgICAgICAgZmxhZ3MgPSBJRUVF
ODAyMTFfVFhfSU5URkxfTkw4MDIxMV9GUkFNRV9UWCB8DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIElFRUU4MDIxMV9UWF9DVExfUkVRX1RYX1NUQVRVUzsNCj4gDQo+ICsgICAgICAgZmxhZ3Mg
fD0gSUVFRTgwMjExX1RYX0NUUkxfU0NBTl9UWDsNCj4gKw0KPiAgICAgICAgIGlmIChwYXJhbXMt
Pm5vX2NjaykNCj4gICAgICAgICAgICAgICAgIGZsYWdzIHw9IElFRUU4MDIxMV9UWF9DVExfTk9f
Q0NLX1JBVEU7DQo+IA0KPiANCj4gdGhvdWdoIGF0IHRoYXQgcG9pbnQgd2UgbmVlZCB0byByZW5h
bWUgdGhhdCBmbGFnIHRvbywgSSBndWVzcy4NCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbnMu
IEkgbWFkZSBhbmQgc2VudCBhIHBhdGNoIFsxXSB0aGF0IHdvcmtzIHdlbGwgaW4NCm15IHNpZGUg
dXNpbmcgc3l6Ym90J3MgcmVwcm9kdWNlciBjb2RlLiANCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjQwNzI5MDc0ODE2LjIwMzIzLTEtcGtzaGloQHJlYWx0
ZWsuY29tL1QvI3UNCg0KDQo=

