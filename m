Return-Path: <linux-wireless+bounces-11470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF09529FC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6233B20AFD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8E454277;
	Thu, 15 Aug 2024 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qSv9qEJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124F4084D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707103; cv=none; b=OWD03FUu5z6JZRVoAGAQFoW2kpKQpYcmsVV2w4yfk8z/d/0nenONQYD0uG5x/qewO29HR+xDI/YRi30nyGXsSsd8rLsCUVFT8cvTeKbP+RJgk54qe2E73o0E7qncac+I3JjijY6QK0hUDAcGrC7lGlDFk/z/KLSAsaRxy2S9Oeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707103; c=relaxed/simple;
	bh=Rv0p/INujmhOHJWtIBrt3daR1JoafGRFb79pZM3N76c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7FYAdSwQevVe1RwzUxTNZDte+qDhntTt06n0PtcxrNmdO4ucoAeujoRJw+jZs7RVIan4k0ACC5D9aZ2EQubDGtgRejMbzPJYXRNJyMWbz05Rql3FnXt2rOvaDp70CV8X5XCyUb9NRaCIjsR1xOSYvf2l8BXUUhlVvga1xu4zvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qSv9qEJP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7Vbl963740295, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723707097; bh=Rv0p/INujmhOHJWtIBrt3daR1JoafGRFb79pZM3N76c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qSv9qEJP6bHrHI4W/+fGufYEsm88bSHu+il8lt6ji2bCHcn22QBxaHoBPVYJ6DFka
	 iATCRanlBLMaDF+1UTz+mvI0s/cdPaGGMVBFtKYo5pBOoUHVgRGH9Rji8frmz4zPDQ
	 Elekf/dr0w7Fy49utPKQ14EMs/S7mMSPKAvJjy8YXulgsch2WF1a/GaY5FuYoiL4d1
	 QKK1zmADiyO4lFkkpTExCav2s8ZMSzUX/gzY7j+H0WjON9MVC9mcpAwvP8rLGwGfqY
	 Z99KOeUFBhMwBPhwuJ5S1rA2brydja8TB8yhi1p1RSi52LOjhEVdIvVnjBW4DdJ0jj
	 8y/3oEgiXy4kw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7Vbl963740295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:31:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:31:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:31:36 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:31:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 15/20] wifi: rtw88: 8812a: Mitigate beacon loss
Thread-Topic: [PATCH 15/20] wifi: rtw88: 8812a: Mitigate beacon loss
Thread-Index: AQHa7DIxH5eEapOfd0mbHocWgaVkkrIn8c5g
Date: Thu, 15 Aug 2024 07:31:36 +0000
Message-ID: <a7da0317367e4c39923b80e9148d0876@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <d0b834df-801f-4b28-ba6e-d1bcab9801e8@gmail.com>
In-Reply-To: <d0b834df-801f-4b28-ba6e-d1bcab9801e8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UlRMODgxMkFVIGhhcyBhIHJlY2VwdGlvbiBwcm9ibGVtLCBtYXliZSBvbmx5IGluIHRoZSA1IEdI
eiBiYW5kLg0KPiBTb21ldGltZXMsIGluIHNvbWUgcG9zaXRpb25zLCBpdCBzdG9wcyByZWNlaXZp
bmcgYW55dGhpbmcgZXZlbiB0aG91Z2gNCj4gdGhlIGRpc3RhbmNlIHRvIHRoZSBBUCBpcyBvbmx5
IH4zIG1ldGVycyBhbmQgdGhlcmUgYXJlIG5vIG9ic3RhY2xlcy4NCj4gTW92aW5nIGl0IGEgZmV3
IGNlbnRpbWV0ZXJzIGZpeGVzIGl0Lg0KPiANCj4gU3dpdGNoIHRoZSBpbml0aWFsIGdhaW4gdG8g
bWF4aW11bSBjb3ZlcmFnZSB3aGVuIHRoZXJlIGlzIGJlYWNvbiBsb3NzLg0KPiBUaGlzIG9ubHkg
aGVscHMgc29tZXRpbWVzLiBUaGlzIGlzIHNpbWlsYXIgdG8gd2hhdCB0aGUgb2ZmaWNpYWwgZHJp
dmVyDQo+IGRvZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQoNCg0KDQo=

