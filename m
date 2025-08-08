Return-Path: <linux-wireless+bounces-26220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34322B1E1F7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497175652C7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41F21E0BB;
	Fri,  8 Aug 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EgftgunL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0C21CC63
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633485; cv=none; b=WewhpYTsRrxq/Ay1+13IWu/oVEYbXYUvj8aL28CwRQBPsBRdYkaWY62Al5kfkUnDV0u6xnoTUQvmJHN8x+F5YZHFyF21zc5iqhnthnLn5oluzOylTqdQLEzbyT03ceJmuRvaCyEogLjKiPQwTqYAnzxl2/3ZeA25yq22sqLpZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633485; c=relaxed/simple;
	bh=t/d1/Sxg3mEBNXoQmHVEv6oGI8Xo91WmhAwd535d0Fw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpNVa8H7a33ONgxganyU+YhMl3swXNhU/d7JrL15vY9EBiFg3Wu7rj8iN4tHWtq12KujRs/B+gpKzAn/ckmR5XX74ZEgmd+yUsqsqIpD14u7estWFvf8wez1EQg+jYQAMWBGKps236v25nJBkbYKk6bSnqK3RGQZlEdTPnaoJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EgftgunL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786BK0W02790974, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633480; bh=t/d1/Sxg3mEBNXoQmHVEv6oGI8Xo91WmhAwd535d0Fw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EgftgunLranUhIjERqfrbQR699BrWdIYmn2APBhChHR1osEZTYce3o+3DfNarM5NE
	 V+ZzFKsqeLGnRcHNCYCdbPrksT11k2BaKMam9hlJ7WB63ojmtIOVHt/obZHQ3qC3OY
	 +POqK+jRjRr6m4ByAFYN9P0hVqNod8sBEFRDZy1d7hxwQ7GYpyXoYqEe9YDOCV586K
	 MWKm5QIfD2HIlf1j5lnwIjWfooGuKZv4jGFvc1xwcgkV7b4XyjQMR69xB6iOHNXFCn
	 RYGPFCT+yp3WTjHj4uR/AT5XOEhtkwsKsT0QMswymxTVEjWvtu+BnJ9OeqOuHQLdl2
	 WWZdHAz8eOIMw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786BK0W02790974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:11:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:11:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:11:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:11:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 09/11] wifi: rtw89: 8852c: Accept USB devices and load their MAC address
Thread-Topic: [PATCH rtw-next v2 09/11] wifi: rtw89: 8852c: Accept USB devices
 and load their MAC address
Thread-Index: AQHcAyfdaDD0QrmJFUmOCBsNTYCWvrRYUB2g
Date: Fri, 8 Aug 2025 06:11:19 +0000
Message-ID: <4773b7dd60164b6883f9f2f9d31568ee@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <187182af-ab82-4e1f-86f3-2d49162f668f@gmail.com>
In-Reply-To: <187182af-ab82-4e1f-86f3-2d49162f668f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBTYXR1cmRheSwgQXVndXN0IDIsIDIwMjUgNTowNCBBTQ0KPiBNYWtlIHJ0dzg4NTJjX3JlYWRf
ZWZ1c2UoKSBhY2NlcHQgVVNCIGRldmljZXMgYW5kIGxvYWQgdGhlIE1BQw0KPiBhZGRyZXNzIGZy
b20gdGhlIGNvcnJlY3Qgb2Zmc2V0Lg0KPiANCj4gQWxzbyBmaXggdGhlIG9mZnNldCBvZiB0aGUg
TUFDIGFkZHJlc3MgYmVjYXVzZSBpdCB3YXMgd3JvbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

