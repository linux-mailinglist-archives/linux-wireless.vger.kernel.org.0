Return-Path: <linux-wireless+bounces-19682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0BA4B6F9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 04:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B16189127A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 03:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1881D9A70;
	Mon,  3 Mar 2025 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o63zSsIl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1081DE2DC
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973598; cv=none; b=BOMNohUKpngA7YmINuwx0ctjvSALOS6cF/HesGAg74AsRpAG9FlEUThWOAFRoVLc9g2Of3xP32z+3gUIXKMrvqrKCN9k/aPAzlTyOkWwHKWic2ILAjjC1RWiuBnVG78ouarDnjb6ySsHW5ptWTFDB/ZpTj0d8DVgX9t+QwLwQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973598; c=relaxed/simple;
	bh=FFepReDu5H/CyVDao2q+qrqog3VG1fTWdOisn23HLSc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XG3wWDd7R0L0/TnvS1Q5t1YpDNntp3oqxbeAQc0D7FuSTqQaTC4sVK5KL110myTWtlAgJ+VMbvYeBU5HlUTZ4i6kH1F/28RCYZs19LdztIi+uBlVV9ftRBVS4zuGL19xhsHwrPkzeCjU05+xe5bPMsYjWhqI6WrKPHqI9baT/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o63zSsIl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5233kV9c9557055, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740973591; bh=FFepReDu5H/CyVDao2q+qrqog3VG1fTWdOisn23HLSc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=o63zSsIl3KNk6zfeoxOcmqAW5Ghxp6tyFM1W73OtKS7EAaR2+VPtyfn2uRhht+zTc
	 FxSL4LvSBh75UVHlveCogFvUBO9QryfHmN1wrKxC7QS04X6+EOMWWgVgiV788uPnfE
	 g8813NgpozGA/rn4NlhO54dVd2RTjLgMReSJdXbo3PuQAPUyUy6rD6Rqn25nvxBddh
	 JeRzxnyCO+jDfs98T+lhVh0XqBluk0N0zGT3orKvLvjvV10KA0kFjJ1MbwzITRnHjK
	 3sliF/cN0iog4m6bk7uQQmDeA/pGDDbbMuwpoLMq6QCCO2ZeGGDRvYEqxxR3+7JOIO
	 BnBY/s63jxzYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5233kV9c9557055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:46:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 11:46:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 11:46:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 11:46:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 7/7] wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers
Thread-Topic: [PATCH rtw-next 7/7] wifi: rtw88: Enable the new
 RTL8814AE/RTL8814AU drivers
Thread-Index: AQHbiLCsysYTQOyJmUGb7hQgRJzCObNgzDyA
Date: Mon, 3 Mar 2025 03:46:31 +0000
Message-ID: <811f5101191c45ed9f4fd8f5a4787a13@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <b5628573-87c7-4f0e-bb1c-5652f81fb801@gmail.com>
In-Reply-To: <b5628573-87c7-4f0e-bb1c-5652f81fb801@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODE0QSBpcyBhIHdpZmkgNSBjaGlwIHdpdGggNCBSRiBwYXRocyAoY2hhaW5zKSwgMyBzcGF0aWFs
IHN0cmVhbXMsDQo+IGFuZCBwcm9iYWJseSBubyBCbHVldG9vdGguDQo+IA0KPiBUaGUgVVNCLWJh
c2VkIFJUTDg4MTRBVSBjYW4gcmVhY2ggODAwIE1icHMgaW4gdGhlIDUgR0h6IGJhbmQgaW4gVVNC
IDMNCj4gbW9kZS4gSW4gVVNCIDIgbW9kZSBpdCBvbmx5IHVzZXMgMiBzcGF0aWFsIHN0cmVhbXMu
DQo+IA0KPiBUaGUgUENJLWJhc2VkIFJUTDg4MTRBRSBpcyBub3QgYXMgcG9wdWxhciBhbmQgZGlk
bid0IGdldCBhcyBtdWNoDQo+IHRlc3Rpbmcgc28gaXQncyB1bmNsZWFyIGhvdyBmYXN0IGl0IGdv
ZXMuIEl0J3MgbW9yZSBsaWtlIGEgYm9udXMgb24gdG9wDQo+IG9mIHRoZSBSVEw4ODE0QVUgc3Vw
cG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNCg==

