Return-Path: <linux-wireless+bounces-16581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C39F7497
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 07:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A786167ABF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C878F4C;
	Thu, 19 Dec 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hsbvqwwy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083B41760
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589172; cv=none; b=cGc9bwkTVISCbUt2okhgxnggLZk3hyCyVttgFTsEpcTF/YUgnWe8EM/4D0OvokY43kFWosSFuUgv0TGiNRMW6QUJ4KxDSyG4pnyC1sGbO87eOWaA839rft7RaEJrWmZ+dNU/yC1TajKa0lUwlBrRDnmREg+RsgLcz2QYpeI0SiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589172; c=relaxed/simple;
	bh=E8oMQZQSDdnj5/yXiLCzyLiTGneE9gnpVVUnFDbH+3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifxxmZ7MNJXHN1I6qNkDZwmP3VPVfdHIxp4lZqUSA8T4ySyehKvhDeY1xyX1RsoTXNCQwMekHSNi3wj7wwe9UbBaIbrgJPg9aDkiRD7QOQSyXh8a9TOyo5F4hZkFHqDyPEYjJLFxgDfVlyoMhgg7sGxb/i7RGK9WEGBMnYxdHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hsbvqwwy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ6JMW603545605, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734589162; bh=E8oMQZQSDdnj5/yXiLCzyLiTGneE9gnpVVUnFDbH+3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HsbvqwwyxJ3+b/xrlHZnThtmhf5A2fBdmfI26bouRQ6iHDI6x3aarID/Za1/DYd2t
	 EUX0xLfsMfkwdDFPQ7WNesKv1h1WKn4d+GUIBoGBWTq0J6bCOsUbvP+0yCjK0Ypg9U
	 yy4Fwy3vdL3h659VlwTe79T1mLFE5eH87enfYUVwBHUjmBZrmUfaISIigVya5c1wLl
	 EW412gyygDp0hHd7ErDUGzcYSuA3foanpmp1VpfASdvfq/jKAEVcefdW3uhZQ3U4/H
	 vpYOGXDgJhnW5N5yZGCgCkzCkX3N/vwCLjZ+Kgbqi8u1+cgnYXEAuky75gAN2u7oFX
	 u4dKZ70Bw96Hg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ6JMW603545605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 14:19:22 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 14:19:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 14:19:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 14:19:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 2/3] wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()
Thread-Topic: [PATCH v2 2/3] wifi: rtw88: Handle C2H_ADAPTIVITY in
 rtw_fw_c2h_cmd_handle()
Thread-Index: AQHbUZ0M2x6zf+fmrkKTSSl5t4H6QrLtGJAQ
Date: Thu, 19 Dec 2024 06:19:22 +0000
Message-ID: <a5d37be29d444e7caa87b39416638725@realtek.com>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
 <96e52b03-be8d-4050-ae71-bfdb478ff42f@gmail.com>
In-Reply-To: <96e52b03-be8d-4050-ae71-bfdb478ff42f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
ZmlybXdhcmUgbWVzc2FnZSBDMkhfQURBUFRJVklUWSBpcyBjdXJyZW50bHkgaGFuZGxlZCBpbg0K
PiBydHdfZndfYzJoX2NtZF9yeF9pcnFzYWZlKCksIHdoaWNoIHJ1bnMgaW4gdGhlIFJYIHdvcmtx
dWV1ZSwgYnV0IGl0J3MNCj4gbm90ICJpcnFzYWZlIiB3aXRoIFVTQiBiZWNhdXNlIGl0IHNsZWVw
cyAocmVhZHMgaGFyZHdhcmUgcmVnaXN0ZXJzKS4NCj4gVGhpcyBiZWNvbWVzIGEgcHJvYmxlbSBh
ZnRlciB0aGUgbmV4dCBwYXRjaCwgd2hpY2ggd2lsbCBjcmVhdGUgdGhlIFJYDQo+IHdvcmtxdWV1
ZSB3aXRoIHRoZSBmbGFnIFdRX0JILg0KPiANCj4gVG8gYXZvaWQgc2xlZXBpbmcgd2hlbiBpdCdz
IG5vdCBhbGxvd2VkLCBoYW5kbGUgQzJIX0FEQVBUSVZJVFkgaW4NCj4gcnR3X2Z3X2MyaF9jbWRf
aGFuZGxlKCksIHdoaWNoIHJ1bnMgaW4gdGhlIGMyaCB3b3JrcXVldWUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNr
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

