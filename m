Return-Path: <linux-wireless+bounces-13486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F098FC87
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 05:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1854B21FF9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E726281;
	Fri,  4 Oct 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BuwX2InT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4B11C92
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728012252; cv=none; b=qyE9f0PBBQrOrsaoTsb0B+EwF8U9uAOwd/UTvNyIH+/L/R/++6rNK6li3odhLKtUHTJsNqs3s2eaIrYOIsexXJYUE9aBUoP4IiInMMcyZoO9SCttgwNiepIhSec4+pvUZohEQKj03b49wlbc6Dns4MoxYE4bcUQS5QoVs0THiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728012252; c=relaxed/simple;
	bh=pAh9gSEiYJ8KidX2qXjORqjXrkNpfu472170SlfXz+E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYGblCfl6ThbbydSq0NErZaVuliAN/YDxUPRJysQukOfAs9+/wcg1a1NrYxECswbxUmu0TYDAuLjgl8htFX64XL+bjLMy+Fy1I6n5fo+eiW7qtAVlg0M/6DOcYgJt0FHy/tdWGo+PMKu0BulEYlHvGX80fFn5PNK3wYiavKU+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BuwX2InT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4943NFwU4765975, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728012195; bh=pAh9gSEiYJ8KidX2qXjORqjXrkNpfu472170SlfXz+E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BuwX2InT8Qhj/tpkG64KOvHneqLGtENzwUqpC/wUNc/SJWguhIXp7x16i12/jvn4s
	 Ltv8w8qBnAv5mzhxUzwisNGrVb2ouRFzGYTw/4Dv5k2iz2Fippin6D3y23rJoQDcMc
	 HdWZqoPBZbTRSVhfeEdnBABIL6iqS2qJel5WRFePwl7Mvauox26U9xCU5ZL5sivQjS
	 lJtxCzCA4SBucxXpDm7Hf6vkcbH+kPHM1U/AkeAWtqdUdssvEaGMRFwAMwK3g8m2Kw
	 RznClkuxz2tS61gdvfoXm8PJh0g8WIndaliGW/WZrgdUadUCfcRkU/78zrXhEoL18I
	 nD5IjKg3B8LYQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4943NFwU4765975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 11:23:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:40:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Oct 2024 08:40:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 4 Oct 2024 08:40:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sanjay Bhattacharya <sanjbh@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Problems with rtw89_8852be driver in 6.11.1.arch1-1 kernel
Thread-Topic: Problems with rtw89_8852be driver in 6.11.1.arch1-1 kernel
Thread-Index: AQHbFZMn1Fy+p/8OAE6jlJF/7eOpc7J1v2Cw
Date: Fri, 4 Oct 2024 00:40:19 +0000
Message-ID: <a8170d8367ff4ddeb6cc62113db022e1@realtek.com>
References: <CAJqS-psO8ykm70VBvi_T05PhOYb4Xvs6MeEUzc2a5uq-EUhM0w@mail.gmail.com>
In-Reply-To: <CAJqS-psO8ykm70VBvi_T05PhOYb4Xvs6MeEUzc2a5uq-EUhM0w@mail.gmail.com>
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

U2FuamF5IEJoYXR0YWNoYXJ5YSA8c2FuamJoQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBIb3dl
dmVyLCBvbiBkb3duZ3JhZGluZyB0aGUga2VybmVsIGJhY2sgdG8gNi4xMC4xMC5hcmNoMS0xLCBt
eSB3aWZpDQo+IGludGVyZmFjZSBzZWVtcyB0byBiZSB3b3JraW5nIGZpbmUuIENhbiB5b3UgcGxl
YXNlIGhlbHA/DQo+IA0KDQpXZSBoYXZlIGZvdW5kIGVhcmx5IGNoaXBzIGhhdmUgMzYtYml0IERN
QSBpbnRlcm9wZXJhYmlsaXR5IHByb2JsZW1zIHdpdGggDQpjZXJ0YWluIHBsYXRmb3Jtcy4gQ291
bGQgeW91IHNoYXJlIHlvdXIgUENJIGhvc3QgdmlkL3BpZCBieSBvdXRwdXRzIG9mDQonbHNwY2kg
LXZ0JyBhbmQgJ2xzcGNpIC14JyA/IA0KDQpBbmQsIHBsZWFzZSB0cnkgcGF0Y2ggWzFdIHRvIHNl
ZSBpZiBpdCBjYW4gd29yayB0byB5b3UuIA0KDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC13aXJlbGVzcy8yMDI0MDkyNDAyMTYzMy4xOTg2MS0xLXBrc2hpaEByZWFsdGVrLmNv
bS8NCg0K

