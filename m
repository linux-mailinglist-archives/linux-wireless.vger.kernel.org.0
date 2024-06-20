Return-Path: <linux-wireless+bounces-9302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACA91033C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C2A1C21FBA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CE51ABCA6;
	Thu, 20 Jun 2024 11:42:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B211AAE2E;
	Thu, 20 Jun 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883726; cv=none; b=ZBAJaNTsytHNiIye2QVlBu6iImxI76LPEam8m2GFXdvyMVCw+mMdl0RhMoHtyxGJuuMtd3IkFocv0B1hqgzNGMqC/vDnhICIW5WQNH5DTjTH/PsWtmgH5Z5wgNoce2+2poH1LJ67Cx2iC75+uFiz6lostqV5TJQDEN9kLpvNyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883726; c=relaxed/simple;
	bh=e9thnruLT95MQXFVgB7en6nCs/OUxpcV01fJi/7bqhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYutV4nfe7Y1w24O6VX4SA+vD25NkqfkK6DpSvQ6XfFO2NymIBAI/0qOKyyyZVRUmIE+KaytwA/wFUYe9yQXKYsr6jgWSPYNY6dYWJimxmMDxSM+vCAjwSjz9lFh2eDTNM/KihYLoazkWeBkacgp0n8esPGAzQYujhpYd2HCNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45KBfrBoB2858893, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45KBfrBoB2858893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 19:41:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 19:41:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Jun 2024 19:41:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 20 Jun 2024 19:41:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "mathewegeorge@gmail.com" <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDAgAALtgCAAakyAP//jZeAgACItrD//4RSgIAAGvGA
Date: Thu, 20 Jun 2024 11:41:53 +0000
Message-ID: <a60692b7a0ec4caa5db64d369bebf18910102656.camel@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
	 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
	 <6970398610c546b1b62e599902c67572@realtek.com>
	 <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
	 <342b6b95d97a4bf09afee15c09481efc@realtek.com>
	 <CFB0314C-AE45-4563-BF41-F5D635BFCF86@gmail.com>
In-Reply-To: <CFB0314C-AE45-4563-BF41-F5D635BFCF86@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBC4230D26467D4D81D759EAD94409E4@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTA2LTIwIGF0IDE1OjM1ICswNTMwLCBNYXRoZXcgR2VvcmdlIHdyb3RlOg0K
PiANCj4gPiBJIGZlZWwgdGhpcyBwcm9ibGVtIG1heSBiZSBlYXNpZXIgdG8gcmVwcm9kdWNlIG9u
IEFyY2ggTGludXgsIHNvIEkgd291bGQgbGlrZQ0KPiA+IHRvIGtub3cgQXJjaCBMaW51eCBpc28g
ZmlsZSB5b3UgaW5zdGFsbGVkLg0KPiANCj4gSSBkb24ndCByZW1lbWJlciB0aGUgaXNvIHZlcnNp
b24gdGhhdCBJIHVzZWQgKGl0IHdhcyB5ZWFycyBhZ28pLCBhbmQgSSBkb24ndCBrbm93IG9mIGFu
eQ0KPiB3YXkgdG8gY2hlY2ssIGJ1dCBpdCBzaG91bGRuJ3QgbWF0dGVyLiBBRkFJSyB0aGUgQXJj
aCBpc28gaXMgb25seSB1c2VkIHRvIGJvb3RzdHJhcCB0aGUNCj4gc3lzdGVtLCBzbyBpdHMgdmVy
c2lvbiBzaG91bGQgbm90IGJlIG9mIGFueSBjb25zZXF1ZW5jZSB0byBteSBjdXJyZW50IGNvbmZp
Z3VyYXRpb24uDQo+IFlvdSBtaWdodCB3YW50IHRvIGxvb2sgYXQgaHR0cHM6Ly93aWtpLmFyY2hs
aW51eC5vcmcvdGl0bGUvSW5zdGFsbGF0aW9uX2d1aWRlDQo+IHRvIGdldCBhbiBpZGVhIG9mIHdo
YXQgdGhlIHByb2Nlc3MgaXMgbGlrZTsgYXMgeW91J2xsIHNlZSBpdCdzIHZlcnkgbWFudWFsIGFu
ZCB0YWtlcyBhIGZhaXIgYml0DQo+IG9mIGVmZm9ydC4NCg0KUGxlYXNlIHByb3ZpZGUgb3V0cHV0
IG9mICdjYXQgL2V0Yy9sc2ItcmVsZWFzZScsIHdoaWNoIEFyY2ggTGludXggdmVyc2lvbg0Kc2hv
dWxkIGJlIHRoZXJlLCB0byBtZS4gDQoNCkkgaG9wZSB1c2luZyB0aGUgc2FtZSB2ZXJzaW9uIGFz
IHlvdXJzIG1ha2VzIHRoZSBzeW1wdG9tIHJlcHJvZHVjaWJsZS4gDQoNCg0K

