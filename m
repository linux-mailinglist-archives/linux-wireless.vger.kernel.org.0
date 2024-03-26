Return-Path: <linux-wireless+bounces-5263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5B88B726
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 02:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE4C1F3F1F5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5A288DB;
	Tue, 26 Mar 2024 01:57:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4D208A0
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418248; cv=none; b=J68reDXvV+9YsYrzNhCyeNcJYOW0Xmj2ts/xGodH5zrt8QVa310Kemz4vJ7ps8wHuuLPc+P6f1kSrxL2pHAxL1YkqNi8cVwrAtvpvdBZ8R/288JeUm0gpv/T7wRKZz3tGQ53eBWoaapfcJm9YQRFOwL7zCX6nplFFpWBPTmUrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418248; c=relaxed/simple;
	bh=/meIt6/ILgiPiCeLc6QOTs6Mrd9GlFjNMYkr8EjqNoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DstcIKlzkChxTCS7pAy1bErDM3r39mqfdneOLBHL4GZTXvo0gzegWKBdzE/62ETMJTr1EZ9snfQf91GgKK61g7nIBtvISkyyrt5QqaIL8dOC2RftF29cO/QkLNS12SvrRm//QUn0rn0KYwxjeW0p9IQMCfOyblvviQkkiGjHjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42Q1v6Ik93449858, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42Q1v6Ik93449858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 09:57:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:57:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:57:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Tue, 26 Mar 2024 09:57:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "konstantin.kletschke@inside-m2m.de" <konstantin.kletschke@inside-m2m.de>
Subject: Re: AP mode on RTW88 8821cs
Thread-Topic: AP mode on RTW88 8821cs
Thread-Index: AQHae35fCRVxvatxIEuwJVdovXZIBbFC5F0wgAECKbCABN3eAA==
Date: Tue, 26 Mar 2024 01:57:05 +0000
Message-ID: <2fcab17428576577cbf47bc9551c44f5bac0ea95.camel@realtek.com>
References: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
	 <be67119238e14fa09b3d9dc848d8edd9@realtek.com> <87wmpu1do6.fsf@kernel.org>
In-Reply-To: <87wmpu1do6.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <364408E031E77048B3D6CD2EEC1EC4ED@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDE3OjM2ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gV2Ug
aGFkIHNpbWlsYXIgZGlzY3Vzc2lvbiBiZWZvcmUgWzFdLiBJIHRoaW5rIE1hcnRpbiB3aWxsIHRh
a2UgaGlzIHRpbWUgdG8NCj4gPiBpbnZlc3RpZ2F0ZSBob3cgdG8gZW5hYmxlIEFQIG1vZGUgb24g
U0RJTyBXaUZpIGNhcmRzLg0KPiA+IA0KPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC13aXJlbGVzcy8zNjk3MmZmNS0wYzQ4LTRiZDItOGY5YS05NjQ5YmZhMjQyMjVAbGV4aW5h
LmluLw0KPiANCj4gSWYgQVAgbW9kZSBpcyBicm9rZW4gb24gU0RJTyBkZXZpY2VzIGl0IHdvdWxk
IGJlIHVzZXIgZnJpZW5kbHkgdG8NCj4gZGlzYWJsZSBBUCBtb2RlIHN1cHBvcnQgKE5MODAyMTFf
SUZUWVBFX0FQIGluIHdpcGh5LT5pbnRlcmZhY2VfbW9kZXMpIG9uDQo+IFNESU8gdW50aWwgdGhl
IGlzc3VlcyBhcmUgZml4ZWQuIEluIG90aGVyIHdvcmRzLCB0aGUgZHJpdmVyIHNob3VsZCBvbmx5
DQo+IGVuYWJsZSBmZWF0dXJlcyB3aGljaCB3b3JrIHJlbGlhYmx5Lg0KPiANCg0KSSBtYWRlIGEg
cGF0Y2ggWzFdIHRvIHNldCBzdGF0aW9uIG1vZGUgb25seSBmb3IgU0RJTyBkZXZpY2VzLiBNZWFu
d2hpbGUsDQpJIHdvdWxkIGxpa2UgdG8gcmVtb3ZlIG1lc2ggcG9pbnQgc3VwcG9ydCBmcm9tIHJ0
dzg4IGJlY2F1c2UgSSBkb24ndCBoYXZlDQppbXByZXNzaW9uIHRoYXQgaXQgY2FuIHdvcmsgYW5k
IHNvbWVvbmUgdXNlcyB0aGF0LiBPdGhlcndpc2UsIHdoZW4gU0RJTw0KZGV2aWNlcyBjYW4gc3Vw
cG9ydCBBUCBtb2RlLCB3ZSBuZWVkIGFub3RoZXIgcGF0Y2ggdG8gZGVjbGFyZSAiU0RJTw0KZG9l
c24ndCBzdXBwb3J0IG1lc2ggcG9pbnQiLCBidXQgYWN0dWFsbHkgbm8gY2hpcCBjYW4gc3VwcG9y
dCB0aGF0IGZlYXR1cmUuIA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2ly
ZWxlc3MvMjAyNDAzMjYwMTQ3MDcuMTc0NTgtMS1wa3NoaWhAcmVhbHRlay5jb20vVC8jdQ0KDQoN
Cg==

