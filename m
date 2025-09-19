Return-Path: <linux-wireless+bounces-27508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF60B87890
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 02:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDB13B22A4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744E246770;
	Fri, 19 Sep 2025 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bjZoENgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8901F5617;
	Fri, 19 Sep 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242807; cv=none; b=dscXKF2GjUZI3+Vb7X3bqDnlGbOMcTOeTtBOGIAtFKKOKPLsahCrtr2F0mpzJ6BjalquZb1gOn6SZ17QmVaMBYAh+O98/SYllPyA0epE1oA4xw82rsZEmroC2Nnjs85UDfRj6NOu4Xr8uwFfA+WnFCC8tdpqu9Z0kQlQxbV/hQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242807; c=relaxed/simple;
	bh=8yaAOfZHYPbBo3J4hiMPq5/F3Yv4VMOpxaY4skpRWfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rX5KsFvgH5tylF4BOX4DoYECHgPisNKWc8D+7mfNO6a3GxmKEGNLXMFrxri5O4dOS3nGJjDh8Krdb+c7ffGa01D4oOxFHa7UPDtWEKikZfYfkHTqXBCxtTkz+xHqed8RyqzCGB1ouih5FFI69Vac7u4OsvpyqRMUL8+jgDE0SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bjZoENgN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58J0kSbxD2867417, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758242788; bh=8yaAOfZHYPbBo3J4hiMPq5/F3Yv4VMOpxaY4skpRWfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bjZoENgNhMvCF0hu5uDufWWKpBKnLAOtcNk4SnLhTFp8pLFH3XuJDfjzpce8u1jao
	 cy2SkndNbP1MKLU3RQELlnhgUhTWMrSW6VkLSbqHVu7WC4hmcZhkLCW0bth/uq5rbK
	 19f6lz3Yr0iVTpcU0yitUgSZofJMHjsmQ07B6iyNnx8xYLMszWYlLU4O/XJIhaokh/
	 g1vSz3QzUwP6h+AoXPyulAUv9Q2K3/gbdnbsLomaTz5HL61xBiaZB1rrGALrkMWHWz
	 qDFyf3drNA++jAGneW4/4cpUhfO9Qtzw3kwQf3Y6XzMslovF0+Jqqdxu/KW3IZNEqT
	 9fE69DErlVO+A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58J0kSbxD2867417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 08:46:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 08:46:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 19 Sep 2025 08:46:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking dependency in ser_state_run()
Thread-Topic: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking
 dependency in ser_state_run()
Thread-Index: AQHcJ7kTTR/KBtdLoUaQE6OfgOgcSbSYcHzwgAAcKwCAAR5KYA==
Date: Fri, 19 Sep 2025 00:46:28 +0000
Message-ID: <bb36bb617cef49d7973ba92d4bd094d8@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-5-pchelkin@ispras.ru>
 <0b56e5a8cd7048a19625764bc323ba46@realtek.com>
 <20250918182202-29915c8fb7da60280f86084d-pchelkin@ispras>
In-Reply-To: <20250918182202-29915c8fb7da60280f86084d-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IE9uIFRodSwgMTgu
IFNlcCAwNTo1MiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEZlZG9yIFBjaGVsa2luIDxwY2hl
bGtpbkBpc3ByYXMucnU+IHdyb3RlOg0KPiA+IEJ5IHRoZSB3YXksIHlvdSBtYXJrIHRoaXMgcGF0
Y2hzZXQgYXMgJ3J0dycuIERvZXMgaXQgbWVhbiB0aGlzIHBhdGNoc2V0IGlzDQo+ID4gdXJnZW50
IHRvIHlvdT8gSWYgbm90LCBpdCB3aWxsIGJlIG1vcmUgc21vb3RoIChhdm9pZCBwb3NzaWJsZSBt
ZXJnZSBjb25mbGljdCkNCj4gPiBpZiBpdCBnb2VzIHZpYSAncnR3LW5leHQnLiBMZXQgbWUga25v
dyB5b3VyIHByZWZlcmVuY2UuDQo+IA0KPiBUaGUgZmlyc3QgcGF0Y2ggb2YgdGhlIHNlcmllcyBp
cyByYXRoZXIgdXJnZW50IGNvbXBhcmVkIHRvIHRoZSBvdGhlcnMNCj4gYmVjYXVzZSBpdCBhZGRy
ZXNzZXMgdGhlIGlzc3VlIG9jY2FzaW9uYWxseSBiYW5naW5nIG9uIGEgd29ya2luZyBzeXN0ZW0u
DQo+IFRoZSBvdGhlciBvbmVzIGFyZSBsZXNzIHVyZ2VudC4NCj4gDQo+IFRCSCBJJ20gbm90IGF3
YXJlIG9mIHlvdXIgZGV2ZWxvcG1lbnQgcHJvY2VzcyBpbiBkZXRhaWxzLiAgSXQncyB2Ni4xNy1y
YzYNCj4gYXQgdGhlIG1vbWVudC4gIElmIEkgdGFyZ2V0IGFsbCBwYXRjaGVzIGF0IHJ0dy1uZXh0
LCBhcmUgdGhleSB0byBsYW5kIGluDQo+IHVwY29taW5nIG1lcmdlIHdpbmRvdyBmb3IgdjYuMTgg
cmVsZWFzZSAoYSBjb3VwbGUgb2Ygd2Vla3MgZnJvbSBub3cpPw0KPiBJZiB5ZXMgdGhlbiBubyBo
dXJyaWVzIGZyb20gbWUsIHJ0dy1uZXh0IGlzIG9rLg0KDQpJdCdzIHY2LjE3LXJjNiAoLXJjIGV2
ZSksIHNvIEkgZG9uJ3QgcGxhbiB0byBzZW5kIGEgcHVsbC1yZXF1ZXN0Lg0KDQpPcmlnaW5hbGx5
IEkgcGxhbiB0byBzZW5kIHRoZSBsYXN0IHB1bGwtcmVxdWVzdCB0byB2Ni4xOCB0b2RheSwgc28g
SSBkaWQNCnJldmlldyB0aGlzIHBhdGNoc2V0IHllc3RlcmRheSB0byBzZWUgaWYgSSBjYW4gbWVy
Z2UgaXQgYmVmb3JlIHNlbmRpbmcuIA0KU2luY2Ugb25seSB0d28gb3IgdGhyZWUgbWlub3IgY2hh
bmdlcyBhcmUgbmVlZGVkLCBJIGNhbiB3YWl0IGEgd2hpbGUgYW5kDQpzZW5kIHRoZSBwdWxsLXJl
cXVlc3QgbmV4dCBNb25kYXkgaWYgeW91IGNhbiByZS1zcGluIHRoZSBwYXRjaHNldCB0aGlzDQp3
ZWVrZW5kLiANCg0KSWYgbm90LCBJIGNhbiBzdGlsbCBtZXJnZSB0aGlzIHBhdGNoc2V0IGluIHY2
LjE4LXJjIGN5Y2xlIHRvIHJ0dyB0cmVlLg0KSG93ZXZlciwgdGhpcyBtaWdodCBjYXVzZSBtZXJn
ZSBjb25mbGljdCB3aXRoIC1uZXh0LCBzbyBJIGRvbid0IHByZWZlcg0KdGhpcy4gVXBwZXIgbWFp
bnRhaW5lcnMgbmVlZCB0byBzcGVuZCBleHRyYSB0aW1lIHRvIHJlc29sdmUgY29uZmxpY3RzLg0K
DQo=

