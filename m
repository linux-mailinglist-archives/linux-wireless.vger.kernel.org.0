Return-Path: <linux-wireless+bounces-26215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC10B1E1E8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E88F18909A2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E45367;
	Fri,  8 Aug 2025 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c1AC2b6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DB1DDC00
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632943; cv=none; b=hNLBI4Xfg4c1zMTIL7SNZOyHCHHyXSxPT82Lj+0o1oyXHKa3WBZwHLHluFNVR1yJBejXnn/QO5j3fQzbU5Yp8MHPkYg5AzjQ6M+dSEChW/yzyUIm3JrTS5c1tBBPcNMYgprmJzCb6aXdiMkpPXhnZAaWA0bxTxafhHKEWccsxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632943; c=relaxed/simple;
	bh=Ju5x+ySx94qEywOlJMNplLQzawaZMExgIeGwEN9I1vM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RaQzhtATToukb/Z2ysR8mzZs9b51P5QwkiRtwT+ByPBsx8SWDIo+kDGzDOWD/mIhNIJM/wODqsN38KKJbZKkX0vmM+krNKN0mDjzfyZ1Po+mUYEgo6LUOUtyG+N9U1IwJkXo8vDoVXuch+AMlAVNm5GV2F6h9JxIinTW6jZTqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c1AC2b6G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57862GWq82782990, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754632936; bh=Ju5x+ySx94qEywOlJMNplLQzawaZMExgIeGwEN9I1vM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=c1AC2b6GT+T2u9kgO9fQkHdsdDCwdubZrY0nPcyRq9BMyYbO3PzFEfsRFk1Yuywlh
	 jHsyMnenVaGhxtzdDHUS1nA92RxEjgnJtM4igm5bDbhkk6Ll4rWKT6Y3nBeuOWXQm/
	 K//+Z+NhNJO00+uYK2kboAE2zuoNkb7AuDe05GCjAGWfOb2VZaa2zi/9mrMKmPE10j
	 An85UbL0nxQwXDIL3lF9rYsF6Tfm1XCEYr2ZbdhhhCBrLiWBzpSMyCRYzy/K8pNsR3
	 og2GT2cGEEi+LHjX5ve2KbXduAc8CQQWC38SqT/hFBEijTnMMjKimPdg2Y5aUUG2BK
	 h75o8VBdn2hyw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57862GWq82782990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:02:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:02:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:02:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 04/11] wifi: rtw89: usb: Fix rtw89_usb_ops_mac_post_init() for RTL8852CU
Thread-Topic: [PATCH rtw-next v2 04/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_post_init() for RTL8852CU
Thread-Index: AQHcAyZZeBPw0jY8a0Wvpw8gahTTU7RYTZkw
Date: Fri, 8 Aug 2025 06:02:16 +0000
Message-ID: <843591f3e27d44ba8638e2f8a1c76e94@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <2e628a7b-5548-434c-860b-ddeefe3fa4e1@gmail.com>
In-Reply-To: <2e628a7b-5548-434c-860b-ddeefe3fa4e1@gmail.com>
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
cmVnaXN0ZXJzIHVzZWQgaW4gdGhpcyBmdW5jdGlvbiBhcmUgbG9jYXRlZCBhdCBkaWZmZXJlbnQg
b2Zmc2V0cyBpbg0KPiBSVEw4ODUyQ1UgY29tcGFyZWQgdG8gb3RoZXIgY2hpcHMuIFVzZSB0aGUg
cmlnaHQgcmVnaXN0ZXJzIGZvciBlYWNoDQo+IGNoaXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

