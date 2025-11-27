Return-Path: <linux-wireless+bounces-29373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E2C8D41E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73AAA4E7A42
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B103242A7;
	Thu, 27 Nov 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JfZUcVom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6C322C7F;
	Thu, 27 Nov 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229875; cv=none; b=aNywkykKvadtPSc4R3vV4FHXGcZCYr0On7+N9UBqQrte/CISC82QjfJJWLfB3WJWgT05rz41LkEJLfXiEI12F5OfnB91thQAZqfszR2meJa+8gOlJN6ypa66xC2duMokriXptg66MKgoOoPeQkeOKFJBIyXGItL0b8PYT5Lhy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229875; c=relaxed/simple;
	bh=F+OYe1UVhLgKflH7EaqcQTuyJKI4NI5cEFMUz+aAL1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RdgU/0pDQK1ZmxC/6ehpo2YAbaBsITnl+8m89PywTko0YhUHEtZYZgHwKcInDvffWi9jVHBsZ1W2C81cDN7PCDVP54S+B6N6b3MdD/W6TD1sZezOeyCYH20R/dF+w9+VEbX6ffOGZ4jbgU/gFw3r+iaumb1m6rWJLekYz5LvguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JfZUcVom; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AR7oMZR12472947, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764229822; bh=F+OYe1UVhLgKflH7EaqcQTuyJKI4NI5cEFMUz+aAL1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JfZUcVom5s/scrFbAzUqRTWXk4BQkXKMhuFq6EiktqW3dMgdo6nNIBlMmi44e7qYU
	 fOC1pS1HZVx95vrPrbv4wOJU6pGK4Tea0X4/K73VCa1p2jv8ABpNeel/ANsD7jlLeT
	 hGpSPqjiVFkRfuTBH69CKjwXYFH0rMMFaP8JiQvHzxAw+PVKh7vK+970Cc+RKFxE5Y
	 D2iqWBs16Cxo86nzPZpKI3FrRfwx9PdRf8mNxHa4Q+EdqovpCEOK8nwG2x8F4w/Hsh
	 IiOpPHurVj0wKZqSh+ciM6ikrrJaGRebQA0cQ3IppZdxgPGwP6OcNPnbUgDya37m18
	 sz4mIaetUSq6Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AR7oMZR12472947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 15:50:22 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 15:50:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 15:50:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 27 Nov 2025 15:50:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: alex bestoso <alexbestoso@bestosotech.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Bug Report - Rtlwifi
Thread-Topic: Bug Report - Rtlwifi
Thread-Index: AQHcX2aCIrWXMHkLVU+2neUA3tknNrUGEIuQ//+AMoCAAJUHEA==
Date: Thu, 27 Nov 2025 07:50:22 +0000
Message-ID: <4e2592fe3ec242ba9a8d380ed4e16cc3@realtek.com>
References: <85517aee-6e2a-4524-a5e2-6b48d05facbe@bestosotech.com>
 <0b376fdcc68442f7b41268bb26cce73e@realtek.com>
 <fcd02348-804c-459b-aa03-de61931516be@bestosotech.com>
In-Reply-To: <fcd02348-804c-459b-aa03-de61931516be@bestosotech.com>
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

PiANCj4gTmV2ZXIgbWFkZSBhIHBhdGNoIGJlZm9yZTsgYnV0IEkgYmVsaWV2ZSB0aGF0IHRoaXMg
aXMgY29ycmVjdCwgbWFkZSB3aXRoIGdpdA0KPiANCj4gU2VudCBhcyBhdHRhY2htZW50IGFuZCBw
YXN0ZWQgYmVsb3c6DQo+IA0KDQpJIGNhbiBzZW5kIGEgcGF0Y2ggYmFzZWQgb24geW91cnMuDQoN
Cg==

