Return-Path: <linux-wireless+bounces-25660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019EB0A536
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EC13A369D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C02557A;
	Fri, 18 Jul 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AOoTo1gT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068163595C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845498; cv=none; b=bAiM/tdWiocT85NbrBVq/fM6Tba9jm8N6+q39O00n3fN4xz4kQn4mZTwFnZQ1sTie+fV8db20Uik+o1x8UTZa0tUutwQPVxqSuAxAkS/nJ0pPRQfsIPV8P9gvU0C1EjR1MpQTRpm87Iudbd1BKZkYRUYdM7XrXZCvHMEnLA0Ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845498; c=relaxed/simple;
	bh=i3mgiUfpQ/xaPnLC4K3hLo5hOgm9e46yG4f/JpDWoX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtD6J9gFzQtXeHCF2IHZ4cR1/LRce5KNHDhCug9jkOWByx045qK+gfTYituYzQH1VfRnGo8e8f8BhQTSVWITl/NwAsRdv1VsL5rP3R6afyA0Pbp5GDoAvRgHuJLoe8zDU7N5lbVmfVBgGguZKsE8fQQEfRK0ra/pPgF1rkI0xnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AOoTo1gT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56IDST0N01654907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752845309; bh=i3mgiUfpQ/xaPnLC4K3hLo5hOgm9e46yG4f/JpDWoX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AOoTo1gTlA55Z9gUYZ/JKy5EE9NsWScrWEAe127EK+g/WQm56v3Q6HspyjnS/BfJb
	 1h7uLdbsAi9EFlSzvy2PrlG0DS5kxrrqXvYUDvhNQdve6Loe/Fj63IxGtO3w/vBT+2
	 DLhGKc0JC4O5yyBxyWHGE/srsFj/F9FFn7cPvu53PVCImspPC557fpp1A1aYg7vrl7
	 PYL926KSy7/WUCaUAzQamWC+1cMBUoBesbOn8tcPDzLDCWWq+0798AK6v4B8J4bQHD
	 E+IACJvwxWLwrciz5BV9jQVeTOzF3dWPEQtpdtjlfMGflKBfCJ/2guL7Nhn59gj6oE
	 gyG+4SEFnN9ig==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56IDST0N01654907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:28:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 21:28:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Jul 2025 21:28:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Fri, 18 Jul 2025 21:28:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
CC: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
Thread-Topic: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
Thread-Index: AQHb9490SpnHrcjKUkyO9X2R+DBAhLQ3mHNw//+5N4CAAI685w==
Date: Fri, 18 Jul 2025 13:28:29 +0000
Message-ID: <7859082aeea642e2a3fa3a2829404b55@realtek.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
 <1ae4000edd954cf492e95bdb059c89b2@realtek.com>,<CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
In-Reply-To: <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

DQpOaXRoeWFuYW50aGFtIFBhcmFtYXNpdmFtIDxuaXRoeWFuYW50aGFtLnBhcmFtYXNpdmFtQG9z
cy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPiBPbiBGcmksIEp1bCAxOCwgMjAyNSBhdCAyOjQ14oCv
UE0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBA
QCAtNTc4LDYgKzU3OSw4IEBAIGF0aDEya19kcF90eF9odHRfdHhfY29tcGxldGVfYnVmKHN0cnVj
dCBhdGgxMmtfYmFzZSAqYWIsDQo+ID4gPiAgICAgICAgIHN0cnVjdCBhdGgxMmsgKmFyOw0KPiA+
ID4gICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqbXNkdSA9IGRlc2NfcGFyYW1zLT5za2I7DQo+ID4g
PiAgICAgICAgIHMzMiBub2lzZV9mbG9vcjsNCj4gPiA+ICsgICAgICAgc3RydWN0IGllZWU4MDIx
MV90eF9zdGF0dXMgc3RhdHVzID0geyAwIH07DQo+ID4NCj4gPiBXaXRoICc9IHt9Jywgbm8gbWF0
dGVyIGhvdyB0aGUgc3RydWN0IGNoYW5nZXMsIHlvdSBkb24ndCBuZWVkIHRvIGNoYW5nZSB0aGUN
Cj4gPiBjb2RlIGFjY29yZGluZ2x5Lg0KPiA+DQo+IA0KPiBCb3RoID17fSBhbmQgPSB7MH0gYWNo
aWV2ZSB0aGUgc2FtZSByZXN1bHQsIHJpZ2h0Pw0KDQpZZXMuIA0KDQpIb3dldmVyLCBpbiBzb21l
IGNhc2VzLCBpdCBtaWdodCBjYXVzZSBjb21waWxlciBlcnJvci4gQnV0IEkgZm9yZ290IHRoZSBj
YXNlcywNCmV2ZW4gSSBjYW4ndCByZXByb2R1Y2UgdGhlIGVycm9yIG5vdy4gU29ycnkgZm9yIHRo
ZSBub2lzZS4NCg0K

