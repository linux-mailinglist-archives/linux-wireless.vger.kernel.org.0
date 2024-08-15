Return-Path: <linux-wireless+bounces-11466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885495299F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E81F218BB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44983BA20;
	Thu, 15 Aug 2024 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="E84VFA0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668715E5D3
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705638; cv=none; b=cyeFqsSZEkaxGxzzvalVhSVBnWN7GwNZ2TW3aC8BKw0HGkqaOb6U3Hmei1sovwlZbCnZHvvqN+0G9ILADl59lV+BtOhIhT7T47GPLrMLh71rGxIe9kDCQfMqu4wYPnXMuhTIFF6UYnoVfcV5RWdpVYQQyRNrstuqc7gx7VCc39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705638; c=relaxed/simple;
	bh=1JjZaRS5Gj6Kd9LGumW7amNM5MFLLMU+KP6TDJ71oc4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pCjA27o2auEmrJee64h22MOwzhni88uukqMHztXG17yNxXJUBU+7wzdcwUMzofo7+tb9ENcDLuhmoyVAArrqTeJfjeUeSY4KoTUG5spjHwY5Lxs6lSD5oUULa/lrHKRojCJgvJDKpysSLtIbBw1Q83CEmk4DgEYL1IlG6mrn/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=E84VFA0E; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F77BeR43725318, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723705631; bh=1JjZaRS5Gj6Kd9LGumW7amNM5MFLLMU+KP6TDJ71oc4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E84VFA0EMe9aTTaMgloeyO1Jc6snYKHrYzlrHfU3EWtTDRTcQT+jw4C897jDb0rwd
	 O+MYVrm+v4EhUGHrv/VmczxS1i+3YKwVu54U5Nr3pg6WvrADVpkJMUZjke7bRR9hjt
	 YLhQji2+uXUVTS6kcmL61EpxV+EPRlCsDcg3oqwRXKDOczYOEWkiUBRI5iN0TRgrTU
	 yrzDv85Y2Zy4tXoeQqCdm/KvX8C2l5R3XKwDjFEfKNOt66CYiVOr6njYBzwSymDITg
	 zCWylf1O288BYKBqNA7pohzcthl3TdTXr/gxkMp4rKTbGewVOTlKdAf/JrtvGRZblC
	 1OG+CDSs8NAXQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F77BeR43725318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:07:11 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:07:12 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:07:11 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:07:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 11/20] wifi: rtw88: usb: Set pkt_info.ls for the reserved page
Thread-Topic: [PATCH 11/20] wifi: rtw88: usb: Set pkt_info.ls for the reserved
 page
Thread-Index: AQHa7DHHf57B7ERYqEqOaD4MJVor8rIn6wbA
Date: Thu, 15 Aug 2024 07:07:11 +0000
Message-ID: <7583d3d84ffc4cdea8309d4a6adf7d5e@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <b4bd2f17-1a4a-4b1e-b858-7f8b1cd37dfd@gmail.com>
In-Reply-To: <b4bd2f17-1a4a-4b1e-b858-7f8b1cd37dfd@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAibHMi
IG1lYW5pbmcgImxhc3Qgc2VnbWVudCIuIFdpdGhvdXQgdGhpcyBSVEw4ODEyQVUgY2FuJ3QgdXBs
b2FkIHRoZQ0KPiByZXNlcnZlZCBwYWdlIGluIFVTQiAyIG1vZGUuIChTb21laG93IGl0J3MgZmlu
ZSBpbiBVU0IgMyBtb2RlLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

