Return-Path: <linux-wireless+bounces-24397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E7AE5C08
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375853A2138
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BA8227E82;
	Tue, 24 Jun 2025 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cZMLob0O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE2CCC1
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744229; cv=none; b=RGlYLJvoEmFrVPpaeAZKDm601UWow3wmrwhZA616vo/9D0yCuFQoqwa1rLjmbu7mL7VcAr5qJ5etN0PeKG5/stNznMHDRIpaoV8T779j9MgN8dytbaq9c1M+DhT9+Ov89cCDIcwqJx3VmbP/NGJEEsxiL84WhpAIwqYCrP9CfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744229; c=relaxed/simple;
	bh=qYJq43P5rZnGj4c8uGIOcw3dYwDjJ6oaYibiEkhQMOA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmxI25Ax9+WSrPzn6opb6sHXva+B2qPSIvvR98fuqjdyJINXf+xS9IZpMTNR7roOdXPZNUmwgPbsVuy00haxY5tX/tcfPLlKf+FWfnwdUTF+Dw15A1ot1sgRWNZV+ha732ikp5bUlejZzweudBp8sl8q5JOY2o6rJP+GTqZYf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cZMLob0O; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O5oNTM13102604, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750744223; bh=qYJq43P5rZnGj4c8uGIOcw3dYwDjJ6oaYibiEkhQMOA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cZMLob0Od4PsElZhtty30TwdV+5P/B3vjEtGt4+rQDuQYt67S1+UNiQ7tKpftRREg
	 vu+z7goyHpi2UqAfEo+XV33/j0gwMxC9Vi7LGci/aaXxoJhi+5irKdAT/rUbM3Ovya
	 vWdEiW0W2Cr9dW689KUsTCSjLkCvdCDLSHxBSKVLkyZj5XP3e5kLYvjg3Gn7JNFv/c
	 qAocyGQ/5qffxT5nnI2DSFrTBgcYSGtAnDwXYJNp6ZgZdK2ZVeS47Ph0r1bVyY8lY/
	 mYaNQQF7BiFD3/ZpFCcISltRi0bjr3xTYwtBqdTD74txeQpotUv7rY5cs3SQ5HT4Sf
	 42q99jpcchlMw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O5oNTM13102604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:50:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 13:50:36 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 13:50:35 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 13:50:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 06/14] wifi: rtw89: Disable deep power saving for USB/SDIO
Thread-Topic: [PATCH rtw-next v3 06/14] wifi: rtw89: Disable deep power saving
 for USB/SDIO
Thread-Index: AQHb4hVjbURUl9sUA0OlQ+D3dakCALQR0mFw
Date: Tue, 24 Jun 2025 05:50:35 +0000
Message-ID: <f30bd8f1813e44a89f6a6941bf66396a@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <c637fa22-d4ab-4462-9ef8-c04eee4bb27b@gmail.com>
In-Reply-To: <c637fa22-d4ab-4462-9ef8-c04eee4bb27b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEaXNh
YmxlIGRlZXAgcG93ZXIgc2F2aW5nIGZvciBVU0IgYW5kIFNESU8gYmVjYXVzZSBydHc4OV9tYWNf
c2VuZF9ycHdtKCkNCj4gaXMgY2FsbGVkIGluIGF0b21pYyBjb250ZXh0IGFuZCBhY2Nlc3Npbmcg
aGFyZHdhcmUgcmVnaXN0ZXJzIHJlc3VsdHMgaW4NCj4gInNjaGVkdWxpbmcgd2hpbGUgYXRvbWlj
IiBlcnJvcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KDQo+ICAtIExlYXZlIHJ0dzg5X3BzX3Bvd2VyX21vZGVfY2hhbmdlX3dpdGhfaGNp
KCkgZm9yIGxhdGVyLg0KDQpBcyBJIGNoZWNrZWQgaW50ZXJuYWxseSwgdGhpcyBpcyBvbmx5IHVz
ZWQgYnkgUENJRSBkZXZpY2VzLiBQbGVhc2UgYWRkDQpjb25kaXRpb25zIGFjY29yZGluZ2x5IGJ5
IGZ1dHVyZSBwYXRjaCB0aGF0IHlvdSBlbmFibGUgZGVlcCBQUyBmb3INClVTQi9TRElPLiANCg0K

