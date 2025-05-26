Return-Path: <linux-wireless+bounces-23400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47880AC380D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 04:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC5172698
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52117B425;
	Mon, 26 May 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NNIopRIn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA401624C0
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748227028; cv=none; b=avlwlhx+23pHEpAN+vrWpSxV0pnUaCDQHROvyerbdfMUkh5ULygx1nWftzCbmze9OK/t074+fKo4MNVkTOXy9PkAvvmZTsJvxPEDZ4Vej+L/r0ZnEL6bD/GlqjbfeF69Tn2yfne0OfMJ8bAf13SJnJeqfIeZ5OY3KFxWL9XvoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748227028; c=relaxed/simple;
	bh=pa+faPtTr1qHxLpQlXxDVUBElD88+ZaFGV1n7tH9nvo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rTVWSfMWJHAgg6RkW0zL/2Nhqe6qHwYRSNZOgh4kWvLpTVUF5Pdmxb0kcrRyGoDbFf+eF4+gdc1qo2pg1y2B6ewYgWj4oeQm+wS6u/PnNkw6nEsNRQUYJ4HacMKRv+S66s/HaMZhiB2nQdXz4ewp2nIwThxTlBPEjLMyOmOF5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NNIopRIn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q2b1RW12925887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748227021; bh=pa+faPtTr1qHxLpQlXxDVUBElD88+ZaFGV1n7tH9nvo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NNIopRIns/IHaryh3RLm16mg61RVO0Yi09Cw8KCl/NETBABPYcSGv6RNs/xylaAkf
	 c2XBvu4XLnXlpePNWmmM5BFrK6iMCJ/35IPm7Ooiek69odUSMnXHaXpjXUcuw5qKIf
	 YYqkRwfioPr37BZCZjlbLtecZKY8KK9F6G5f3bN05pChiLUW3YJKY3laWeecmHD2NS
	 OYz1vf5FSsGYjt6F8x0k2huKLFKZvK2/n2e8GgJStJJA/t9ZKooBpG7STTWHux5Jwx
	 nNl//7LNMbHT8iDJgDmUZPQgAmjKl/6iQzRhqXJu0e2/rfM7fdlNnA8RByVN2Qa6SV
	 84JIedKNUZ3YA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q2b1RW12925887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 10:37:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 10:37:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 10:37:00 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 10:36:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving for USB
Thread-Topic: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving
 for USB
Thread-Index: AQHbvTZTFcnEUmzdn0qPTEqBcRqq37PP8FiwgBOPGYCAANHBUA==
Date: Mon, 26 May 2025 02:36:59 +0000
Message-ID: <e717d7bda4644fb4a0a167119f8ea16f@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <c64fe6a4-b48c-4a80-9d6c-5c90fb7f7bbd@gmail.com>
 <8350f850345248b4bcef32204c944168@realtek.com>
 <2ce556de-7ccb-4c6e-be09-da1d3e8d8274@gmail.com>
In-Reply-To: <2ce556de-7ccb-4c6e-be09-da1d3e8d8274@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8wNS8yMDI1IDA2OjI3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBEaXNhYmxlIHJ0dzg5X3Bz
X3Bvd2VyX21vZGVfY2hhbmdlKCkgYW5kIHJ0dzg5X21hY19zZW5kX3Jwd20oKSBmb3INCj4gPj4g
VVNCIGJlY2F1c2UgdGhleSBhcmUgY2FsbGVkIGluIGF0b21pYyBjb250ZXh0IGFuZCBhY2Nlc3Np
bmcgaGFyZHdhcmUNCj4gPj4gcmVnaXN0ZXJzIHJlc3VsdHMgaW4gInNjaGVkdWxpbmcgd2hpbGUg
YXRvbWljIiBlcnJvcnMuDQo+ID4NCj4gPiBJIGZlZWwgcnR3ODlfcHNfcG93ZXJfbW9kZV9jaGFu
Z2UoKSBzaG91bGQgYmUgbm90IGluIGF0b21pYyBjb250ZXh0Lg0KPiA+IFBsZWFzZSBjaGVjayB0
aGlzLg0KPiA+DQo+IA0KPiBJIHRoaW5rIHlvdSdyZSByaWdodCwgb25seSBydHc4OV9tYWNfc2Vu
ZF9ycHdtKCkgaXMgY2FsbGVkIGluIGF0b21pYw0KPiBjb250ZXh0LiBydHc4OV9wc19wb3dlcl9t
b2RlX2NoYW5nZSgpIGlzIGRpc2FibGVkIGZvciBvdGhlciByZWFzb25zOg0KDQpUaGUgcnR3ODlf
cHNfcG93ZXJfbW9kZV9jaGFuZ2UoKSBpcyB0byBlbnRlciBkZWVwIHBvd2VyIHNhdmUgbW9kZSwg
d2hpY2gNCmNhbiBzYXZlIG1vcmUgcG93ZXIgc2F2ZSBidXQgbmVlZCB0byBsZWF2ZSB0aGUgbW9k
ZSBiZWZvcmUgeW91IGFyZSBnb2luZw0KdG8gZG8gSU8vVFgvUlguIFRoYXQgbWVhbnMgaWYgeW91
IHRvdGFsbHkgZGlzYWJsZSBpdCwgY29kZSBmbG93IHdvdWxkDQpiZSBzaW1wbGVyLCBidXQgcG93
ZXIgY29uc3VtcHRpb24gd291bGQgYmUgaGlnaGVyLiBTaW5jZSB0aGlzIGlzIHRoZQ0KZmlyc3Qg
cGF0Y2hlcyB0byBlbmFibGUgVVNCLCBJIHN1Z2dlc3QgeW91IGNhbiBkaXNhYmxlIGl0IHRvdGFs
bHkgZm9yDQpub3csIGFuZCBhZGQgaXQgbGF0ZXIuIA0KDQo+IA0KPiAxKSBJdCBjYWxscyBydHc4
OV9tYWNfcG93ZXJfbW9kZV9jaGFuZ2UoKSwgd2hpY2ggcHJpbnRzIGVycm9ycyB3aGVuDQo+IHJ0
dzg5X21hY19zZW5kX3Jwd20oKSBpcyBkaXNhYmxlZC4NCj4gDQo+IDIpIFdpdGggUlRMODg1MkNV
IGl0IGNhbGxzIHJ0dzg5X3BzX3Bvd2VyX21vZGVfY2hhbmdlX3dpdGhfaGNpKCkNCj4gd2hpY2gg
Y2FsbHMgbmFwaV9zY2hlZHVsZSgpLiBUaGF0IHJlc3VsdHMgaW4gZGVyZWZlcmVuY2luZyBhIG51
bGwNCj4gcG9pbnRlci4NCg0KSSBzZWUuIFlvdXIgaW1wbGVtZW50YXRpb24gZG9lc24ndCB1c2Ug
TkFQSSBmb3IgVVNCIGRldmljZXMuIA0KDQpUaGUgcnR3ODlfcHNfcG93ZXJfbW9kZV9jaGFuZ2Vf
d2l0aF9oY2koKSBpcyB0byBzd2l0Y2ggSU8gYWRkcmVzcyBmb3INClBDSSBkZXZpY2VzIGluIGRl
ZXAgcG93ZXIgc2F2ZSBtb2RlLCBhbmQgVVNCIGRldmljZXMgZG9uJ3QgbmVlZCB0aGlzLg0KSSB0
aGluayB3ZSBjYW4gcnVuIHRoaXMgb25seSBpZiBIQ0kgaXMgUENJLg0KDQoNCg==

