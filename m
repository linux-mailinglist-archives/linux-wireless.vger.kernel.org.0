Return-Path: <linux-wireless+bounces-3760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38A859D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5032812C0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA172210F2;
	Mon, 19 Feb 2024 07:38:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0F20DF1
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328280; cv=none; b=RrjNhz5CDqJlh2E0R/q+4cwg6PnFklhRpcaViiHYz8HgoK0eJE2+HO/Yq8r2ShHG8Zmkx2uGyrJ6TlD0OwJrTXqBGAPiezGSXR8tATUBD4UvqFEwjvsQFWNDbvxhzDK96cM5FHPM0nk4Th+CAdr9+4iEbR2gFCCyQY2fNM5kBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328280; c=relaxed/simple;
	bh=IIKdLSHI4w7QA2JinsGm5sAbjhLU6UYYoJoFfGlyvFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAd39LyVWif8z+IY3CaYG8HmxQ3G2Sxa/KiUWT7e163yEgzUtuvBFoWiYWH1LUu71z5D/t8O5ObVLwCMFMBgvF6vju4g1b9ISJE3RKY4yHaQJ/roFMU7h2zkvz/B6i7rG1EKaJaXbUngpC+7B4H2em5w/kj3iQ05vpQLUqot6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41J7bkkD73902347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41J7bkkD73902347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 15:37:46 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 19 Feb 2024 15:37:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 15:37:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 19 Feb 2024 15:37:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: Fix setting the basic rates
Thread-Topic: [PATCH] wifi: rtlwifi: Fix setting the basic rates
Thread-Index: AQHaYd6p9MFJopYdqEyEhDzoYDfrTLERRPeQ
Date: Mon, 19 Feb 2024 07:37:47 +0000
Message-ID: <afded3d1768247cca613f55943a013aa@realtek.com>
References: <35165caf-337c-4da0-b55c-c1a7081a1456@gmail.com>
In-Reply-To: <35165caf-337c-4da0-b55c-c1a7081a1456@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgRmVicnVhcnkgMTgs
IDIwMjQgNDoyMCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IExhcnJ5IEZpbmdlciA8TGFycnku
RmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gU3ViamVjdDogW1BBVENIXSB3aWZpOiBydGx3aWZpOiBG
aXggc2V0dGluZyB0aGUgYmFzaWMgcmF0ZXMNCg0KVGhvdWdoIGRyaXZlciBzZXRzIHJlZ2lzdGVy
IHZpYSBlbnVtIEhXX1ZBUl9CQVNJQ19SQVRFLCBidXQgYWN0dWFsbHkgaXQgdXNlcw0Kc3VwcG9y
dGVkIHJhdGVzIGFzIEFDSyBhbmQgUlRTIHJhdGVzLCBzbyBJIHRoaW5rIGl0IHdvdWxkIGJlIGNs
ZWFyZXIgdG8NCm1lbnRpb24gImZpeCBzZXR0aW5nIG9mIFJUUyByYXRlIiBpbiBzdWJqZWN0Lg0K
DQpPdGhlcnMgbG9vayBnb29kIHRvIG1lLiANCg0KPiANCj4gUlRMODE5MkNVIHRyYW5zbWl0cyBS
VFMgZnJhbWVzIGF0IDQ4TSBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCAyNE0uDQo+IFRoaXMgaXMg
YmVjYXVzZSBydGx3aWZpIG5ldmVyIHdyaXRlcyBSRUdfSU5JUlRTX1JBVEVfU0VMLCBiZWNhdXNl
IHdoZW4NCj4gcnRsX29wX2Jzc19pbmZvX2NoYW5nZWQoKSBpcyBjYWxsZWQgd2l0aCBCU1NfQ0hB
TkdFRF9CQVNJQ19SQVRFUyAoYW5kDQo+IEJTU19DSEFOR0VEX0JTU0lEKSBpdCBjYWxscyBpZWVl
ODAyMTFfZmluZF9zdGEoKSwgd2hpY2ggcmV0dXJucyBOVUxMLA0KPiBhbmQgdGhlIGNvZGUgc2tp
cHMgb3ZlciB0aGUgcGFydCB0aGF0IGhhbmRsZXMgQlNTX0NIQU5HRURfQkFTSUNfUkFURVMuDQo+
IA0KPiBBIGJpdCBsYXRlciBydGxfb3BfYnNzX2luZm9fY2hhbmdlZCgpIGlzIGNhbGxlZCB3aXRo
IEJTU19DSEFOR0VEX0FTU09DLg0KPiBBdCB0aGlzIHBvaW50IGllZWU4MDIxMV9maW5kX3N0YSgp
IHdvcmtzLCBzbyBzZXQgdGhlIGJhc2ljIHJhdGVzIGZyb20NCj4gaGVyZS4NCj4gDQo+IFNvbWUg
b2YgdGhlIGNvZGUgZnJvbSBCU1NfQ0hBTkdFRF9CU1NJRCB3aGljaCBuZWVkcyBpZWVlODAyMTFf
ZmluZF9zdGEoKQ0KPiB3YXMgYWxyZWFkeSBkdXBsaWNhdGVkIHVuZGVyIEJTU19DSEFOR0VEX0FT
U09DLCBzbyBkZWxldGUgaXQgZnJvbQ0KPiBCU1NfQ0hBTkdFRF9CU1NJRC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAt
LS0NCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIGVub3VnaC4gU2hvdWxkIHdlIGFsc28g
aGFuZGxlDQo+IEJTU19DSEFOR0VEX0JBU0lDX1JBVEVTPyBCdXQgYnNzX2NvbmYtPmJhc2ljX3Jh
dGVzIGlzIG9ubHkgMHhmIChDQ0sNCj4gcmF0ZXMgb25seSkgYW5kIHRoZSBvdXQtb2YtdHJlZSBS
ZWFsdGVrIGRyaXZlcnMgd2FudCB0byB1c2UgdGhlIDYsIDEyLA0KPiBhbmQgMjRNIHJhdGVzIGFz
IHdlbGwuIElmIGllZWU4MDIxMV9maW5kX3N0YSgpIHJldHVybnMgTlVMTCwgaG93IGNhbiB3ZQ0K
PiBrbm93IGlmIE9GRE0gcmF0ZXMgYXJlIHN1cHBvcnRlZD8NCj4gDQo+IEknbSBhbHNvIG5vdCBz
dXJlIGlmIGl0J3Mgb2theSB0byBzZXQgdGhlIGJhc2ljIHJhdGVzIGxhdGVyIHRoYW4NCj4gb3Jp
Z2luYWxseSBpbnRlbmRlZCwgYnV0IGl0J3Mgc3RpbGwgYmV0dGVyIHRoYW4gbmV2ZXIuDQoNCmJz
c19jb25mLT5iYXNpY19yYXRlcyBpcyBmcm9tIEFQIGJlYWNvbiBiYXNpY2FsbHksIGFuZCBvbmx5
IHRoZSBzdXBwb3J0ZWQgcmF0ZXMNCndpdGggMHg4MCBiaXQgYXJlIGJhc2ljIHJhdGVzLCB3aGlj
aCBpcyBtaW5pbXVtIHJhdGVzIHJlcXVpcmVtZW50IHRvIHRoZSBBUC4NClRodXMsIEkgdGhpbmsg
aXQgaXMgbm90IHN1aXRhYmxlIHRvIGNvbnNpZGVyIGJhc2ljIHJhdGVzIGFzIFJUUyByYXRlLiAN
Cg0KUGluZy1LZSANCg0K

