Return-Path: <linux-wireless+bounces-11463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46634952986
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B9C2825C7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4F17A595;
	Thu, 15 Aug 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qPklhPyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258017A58C
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704778; cv=none; b=tx7PnqOfm38J4Nl+Sc+4MK6t2h6FRytNKnE5/eHhOoc2UW6GbWfSRDN5N6VzU8kAqYQ/PdDfjGfk9WquFyoZD0uQNYKf30Sx9VH+1POrEQvis/gMabKWeA4kn38x35t3VXcSI+g4iHwGyQ7LKODLmrSgMBn8HjlKFo7bJzuWkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704778; c=relaxed/simple;
	bh=l+Qt19iTTAXx/4RyB//e86xX+3onbX+DlzAH4pFYKOI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ3zGYaTynLLyeKGb/v2/o8IgFVSpf0TCrVa+XWdniW1olkIdJGAmUObRrezW43MurvV0xV6aRap/Hv0vjmAEqq0dNj59iF6x5gqCdCYcmxUoh5JLjgidid+FT9Yng0u9VBo5FGT/3JklriLiQE8F6KTy97PR4fwowctgHFtl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qPklhPyY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6qrIuB3714038, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723704773; bh=l+Qt19iTTAXx/4RyB//e86xX+3onbX+DlzAH4pFYKOI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qPklhPyYbHnnY4wYhYGK43OKtudY49Rq25gO65jfJdc+p/wYEW9gFSvM9WtMFDaSW
	 Vo/YKfeJMT5sYXP0aLbGUdmXN9OGWk5nVJjaDtzvS/uXBK3DZJMHRTIO+A55XzYQoY
	 QC/UXFXUBmQwrcD4Y1JdOpvBWGsXfPX72WD/GZojB/mgaOvy9F8GoeBqqthMw0Vrlp
	 lqSRm2F+WJoSSek0Yx17YH17djoBEbKcKu3M9kXZhuUb/uDnoIqzOecBCXtE+0nJfn
	 OagLmULlYsVMdyowwsNDVZw3ku8E5ygqPVVydPLfGV3cvN4/g59uWh9Oe2xA/Z9QvF
	 n1l2ge6je32vA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6qrIuB3714038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:52:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:52:53 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:52:53 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:52:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 09/20] wifi: rtw88: Support TX page sizes bigger than 128
Thread-Topic: [PATCH 09/20] wifi: rtw88: Support TX page sizes bigger than 128
Thread-Index: AQHa7DGPCim1rUKUPE6RD0hAGkiA3LIn5wWw
Date: Thu, 15 Aug 2024 06:52:53 +0000
Message-ID: <6b488ee757964c3080a8de89f61c125f@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <3d35cd9c-3625-40ae-806e-dacb2fe0039a@gmail.com>
In-Reply-To: <3d35cd9c-3625-40ae-806e-dacb2fe0039a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBbGwg
dGhlIGNoaXBzIHN1cHBvcnRlZCBzbyBmYXIgaGF2ZSBhIFRYIHBhZ2Ugc2l6ZSBvZiAxMjggYnl0
ZXMuDQo+IA0KPiBDaGFuZ2UgdGhlIHR5cGUgb2YgdGhlIHBhZ2Vfc2l6ZSBtZW1iZXIgb2Ygc3Ry
dWN0IHJ0d19jaGlwX2luZm8gZnJvbSB1OA0KPiB0byB1MTYgaW4gb3JkZXIgdG8gc3VwcG9ydCBS
VEw4ODIxQVUgKHBhZ2Ugc2l6ZSBvZiAyNTYgYnl0ZXMpIGFuZA0KPiBSVEw4ODEyQVUgKHBhZ2Ug
c2l6ZSBvZiA1MTIgYnl0ZXMpLiBBbHNvIGNoYW5nZSB0aGUgdHlwZXMgb2Ygc2V2ZXJhbA0KPiBy
ZWxhdGVkIHZhcmlhYmxlcyBhbmQgZnVuY3Rpb24gcGFyYW1ldGVycyBmcm9tIHU4IHRvIHUxNi4N
Cj4gDQo+IFRoZSBUWCBwYWdlIHNpemUgaXMgdXNlZCwgYW1vbmcgb3RoZXIgdGhpbmdzLCB0byBj
b25zdHJ1Y3QgdGhlIGJlYWNvbiwNCj4gbnVsbCBkYXRhLCBRT1MgbnVsbCBkYXRhLCBhbmQgUFMg
cG9sbCB0ZW1wbGF0ZXMgd2hpY2ggYXJlIHVwbG9hZGVkIHRvDQo+IHRoZSBjaGlwJ3MgcmVzZXJ2
ZWQgcGFnZS4gRWFjaCB0ZW1wbGF0ZSBuZWVkcyB0byBiZSBhbGlnbmVkIG9uIGENCj4gbXVsdGlw
bGUgb2YgdGhlIFRYIHBhZ2Ugc2l6ZS4gUG93ZXIgc2F2aW5nIGNhbid0IHdvcmsgaWYgdGhlIFRY
IHBhZ2UNCj4gc2l6ZSBpcyB3cm9uZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

