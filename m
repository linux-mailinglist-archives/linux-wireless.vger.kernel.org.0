Return-Path: <linux-wireless+bounces-26217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C6B1E1EB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A061890C61
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E671E25F9;
	Fri,  8 Aug 2025 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qshOWIFB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECF367
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633062; cv=none; b=NByjZ6Tv8qMepJTmlLYt7kjGkNb804x7ioRUFIDQrxEUTm7UTH+SIRxeeD/cjex9o5dJFKd047Ku4c68Rog00jsAVP7xbcyfCRxXERs7E8HhoZKXm+Q5lExH6VjWhiUvUFBGhGdhNndV01lc9r/w1jJPRk+d8J7HMratLGoP4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633062; c=relaxed/simple;
	bh=K3voUTc9EAbnvXw6N6N1KMGJHJhHrOY6X/vvMx86GkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZiOuEYxY2/Cui5Kh96hH0YPhwl44DsdxrRJucI3jgBIwjjPrmd5bZVy3lvCwK3ZL4SPsMvZsKgSP0kzsia3NxboHEaA9YKWJfNYPFBbDKxM5fZZayqyESsZsABkb7MlurDq3OFtdTM1B6aUNX5UaE0KiqOa7Oax5/uIJFiZX5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qshOWIFB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57864HOz82786334, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633057; bh=K3voUTc9EAbnvXw6N6N1KMGJHJhHrOY6X/vvMx86GkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qshOWIFB8Q3WK2ejtqfj8VaEDxUysrm33VD0QNxirXdiEYzRdhci7vjbJDWKXSS7D
	 gxn01qHiQLsbFz4cD6KgJbxRBIbWpcGfqGNPhmQOa5XZ3cniObgMY66yDOOD06XcY0
	 +/QgXeoLZlsX9IiL1JWVDsnWnkoDuyi6ZRvoM0ZJhLp8x02HGhbnh9HkjBFjgmTje5
	 1R1POtd2hHMg/QaovZ0NgP15Uy0j7As5redPeNq4Py62mPk0IM9kyKZ/q2V5BVyN4L
	 Nzo/OC4Dk9yKahpJxmFun1CH4uswQxbL8Vl6YMK/YAjuGhpEQbHOxpF83DOAgij0I9
	 nwo8E4Jbzf8VA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57864HOz82786334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:04:17 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:04:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:04:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:04:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 06/11] wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
Thread-Topic: [PATCH rtw-next v2 06/11] wifi: rtw89: 8852c: Fix
 rtw8852c_pwr_{on,off}_func() for USB
Thread-Index: AQHcAyaCa0NBCc3EUEiXBc8MuRwCrrRYTiRA
Date: Fri, 8 Aug 2025 06:04:16 +0000
Message-ID: <01c3667ff8704a4c8357967d86fed601@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <17cd1b2c-d4a0-4a60-80a7-2d23b97a2375@gmail.com>
In-Reply-To: <17cd1b2c-d4a0-4a60-80a7-2d23b97a2375@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVy
ZSBhcmUgYSBmZXcgZGlmZmVyZW5jZXMgaW4gdGhlIHBvd2VyIG9uL29mZiBmdW5jdGlvbnMgYmV0
d2VlbiBQQ0lFDQo+IGFuZCBVU0IuIFRoZSBjaGFuZ2VzIGluIHRoZSBwb3dlciBvZmYgZnVuY3Rp
b24gaW4gcGFydGljdWxhciBhcmUgbmVlZGVkDQo+IGZvciB0aGUgUlRMODgzMkNVIHRvIGJlIGFi
bGUgdG8gcG93ZXIgb24gYWdhaW4gYWZ0ZXIgaXQncyBwb3dlcmVkIG9mZi4NCj4gDQo+IFdoaWxl
IHRoZSBSVEw4ODMyQ1UgYXBwZWFycyB0byB3b3JrIHdpdGhvdXQgdGhlIGNoYW5nZXMgaW4gdGhl
IHBvd2VyIG9uDQo+IGZ1bmN0aW9uLCBpdCdzIHByb2JhYmx5IGJlc3QgdG8gaW1wbGVtZW50IHRo
ZW0sIGluIGNhc2UgdGhleSBhcmUgbmVlZGVkDQo+IGluIHNvbWUgc2l0dWF0aW9ucy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

