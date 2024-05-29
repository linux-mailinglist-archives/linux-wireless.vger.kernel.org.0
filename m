Return-Path: <linux-wireless+bounces-8247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF38D2B89
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87181C21DB2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F938DFC;
	Wed, 29 May 2024 03:42:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B5273DC
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716954149; cv=none; b=bgGGWSz5OlCEHmqwttbilV/LqueGEKOKc55uzMMdqDoxhMxYTqMx8R3v+YknAQisqPkne9giMeNPPaWvApLz9tUyTa2+m7jxjXZRDaXb6KAKyBuogyrkkyBoPv9fpY99QvoFWKGmRf3EOLbyOclAviTWfqp6LrB/jQurt/rFU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716954149; c=relaxed/simple;
	bh=Mi5K1RT7p26VgOS+G6XO/943bkY/DIPjc+uCiFm1YDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VN6OU+zN0o8Em1hcrzUQ24tbxeTEc32Iggy4w9WqyA4PqvxfWJR+CCgc+FOBwqDwjIy9EVf2IbpMWOiwmLI4NP6cmjSOfhxxtqqPFfTaF/Ntzc1G6vFIFrKEuIF+CZvRxof0gB43ElN/Mg3qJ1OOvFLlBzibmF0DUjTXpnMdB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44T3gJPE13131998, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44T3gJPE13131998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 11:42:19 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 11:42:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 11:42:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 29 May 2024 11:42:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
Thread-Topic: [PATCH v2] wireless-regdb: Update regulatory info for Thailand
 (TH) on 6GHz
Thread-Index: AQHasWCceVdlZvB+lkSF1cMglH7G4rGtCkCAgACGoDA=
Date: Wed, 29 May 2024 03:42:19 +0000
Message-ID: <9003c216a95e4f7ea9d278b8ec4dff75@realtek.com>
References: <20240529003843.4285-1-pkshih@realtek.com>
 <CAGb2v65+scSTuK5Q-m8kAfbXKFgfpSB3k0BNFAsCeXAF4EO0qg@mail.gmail.com>
In-Reply-To: <CAGb2v65+scSTuK5Q-m8kAfbXKFgfpSB3k0BNFAsCeXAF4EO0qg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiBPbiBXZWQsIE1heSAyOSwg
MjAyNCBhdCA4OjM44oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gVGhlIEJyb2FkY2FzdGluZyBDb21taXNzaW9uIFRlbGV2aXNpb24gYnVzaW5l
c3MgYW5kIHRoZSBOYXRpb25hbA0KPiA+IFRlbGVjb21tdW5pY2F0aW9ucyBDb21taXNzaW9uIGFu
bm91bmNlZCBUZWNobmljYWwgc3RhbmRhcmRzIGZvcg0KPiA+IHRlbGVjb21tdW5pY2F0aW9ucyBl
cXVpcG1lbnQgYW5kIGVxdWlwbWVudCBmb3IgcmFkaW9jb21tdW5pY2F0aW9uIGVxdWlwbWVudA0K
PiA+IHRoYXQgdXNlcyB0aGUgZnJlcXVlbmN5IDUuOTI1IC0gNi40MjUgR0h6IFsyXSwgd2hpY2gg
c2VjdGlvbiAyLjEgZGVzY3JpYmVzDQo+ID4gZS5pLnIucC4gKEVxdWl2YWxlbnQgSXNvdHJvcGlj
YWxseSBSYWRpYXRlZCBQb3dlcikgaXMgMjUwbVcgYW5kIDI1bVcgZm9yDQo+ID4gaW5kb29yIGFu
ZCBpbmRvb3Ivb3V0ZG9vciByZXNwZWN0aXZlbHkuDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9yYXRj
aGFraXRjaGEuc29jLmdvLnRoL2RvY3VtZW50cy8xNDBEMTAwUzAwMDAwMDAwMDQwMDAucGRmDQo+
ID4gWzJdIGh0dHBzOi8vcmF0Y2hha2l0Y2hhLnNvYy5nby50aC9kb2N1bWVudHMvMTQwRDEwMFMw
MDAwMDAwMDA0MjAwLnBkZg0KPiA+IFszXSBodHRwczovL3JhdGNoYWtpdGNoYS5zb2MuZ28udGgv
ZG9jdW1lbnRzLzE0MEQxMDBTMDAwMDAwMDAwNDMwMC5wZGYNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBh
ZG9wdCBpbmRvb3IgcG93ZXIgMjUwbVcgaW5zdGVhZC4NCj4gDQo+IENhbiB5b3UgcmVzZW5kIHdp
dGggdGhlIHdpcmVsZXNzLXJlZ2RiIG1haWxpbmcgbGlzdCBDQy1lZD8NCj4gDQoNCkkgcmVjZWl2
ZWQgZmFpbGVkIHRvIGRlbGl2ZXIgZnJvbSBtYWlsIHNlcnZlciBmb3Igd2lyZWxlc3MtcmVnZGJA
bGlzdHMuaW5mcmFkZWFkLm9yZywNCnNvIEkgdGhvdWdodCB0aGUgbWFpbGluZyBsaXN0IGhhcyBi
ZWVuIG9ic29sZXRlZC4gDQpJIHdpbGwgdHJ5IHYzIHRvIHJlLWFkZCBpdC4gDQoNCg0K

