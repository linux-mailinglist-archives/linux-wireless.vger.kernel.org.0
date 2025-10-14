Return-Path: <linux-wireless+bounces-27965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BDBD73C3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 06:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E5E3ABF38
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 04:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E30309EF8;
	Tue, 14 Oct 2025 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tv/VyKem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379D309EFE
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415834; cv=none; b=op57EDm5HoUdvwmX90CdO4E+XvMXtgBPcC99IZbnFeRNvkXsbhmct7hlh1yuX1a+7sAanw1JD3aIFOG3cxvnpZVj/33R11UuOtwIDnwVnjyZpNBhPntRq0UQxwDBhCL6uR2EM//EAPysduw//bRp8ECBIE3J8V2s8c1lp+HoBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415834; c=relaxed/simple;
	bh=lNVmhydPCgJ2LUL8u7uKwqpoDYP0zzZsX+JC1JW5MTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+MxFVzB3swpax0tu2OWDrQc+VdisGb/6LDZaSwnowX0Cu/qLURcN5/1qm8Q6Stx5JEatkPcsS2r7yVXLxup+3cHLhZdHJHOZ/OeyoQ9n8mNccOZK+QHCZnuCOiKpDH8+Mc1PsqNI4oKCmwqF492HExNRa4eO75NiWkg1Ute1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tv/VyKem; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59E4NljjE2703959, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760415827; bh=lNVmhydPCgJ2LUL8u7uKwqpoDYP0zzZsX+JC1JW5MTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tv/VyKemBB45sUV6aOSANUEn8bfxHPIMjiTLmnggSZviXCrpa+Xfjfwm4BR7Zh+7U
	 W8uGOWwNeeUY0QFFVlPZNqooZP7HHX+p73/8xzrq/AUpv0yGwCCny3iyfqKaekyLYO
	 lhjPtUvtzwiM0o2ZYUQMk3UIlurfwHldhAYUBrcpoWNMrnKR7WysTD+4vUYQLj7vWP
	 yLMFIx28qwG8IvHNsk5FAQel+MPArXudQDqOAZufO5CGERAWAm5tMlWFpn3nmoIBN/
	 fJLEKz0S1sBUd3NtN4CmPIo/SMXpFQxFGCoP3DAcY5g2HTU+UPxXjG0+rU3inrZY/Z
	 zIDyzPwSOuFrg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59E4NljjE2703959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 12:23:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 14 Oct 2025 12:23:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 14 Oct 2025 12:23:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 3/3] wifi: rtl8xxxu: Use correct power off sequence for RTL8192CU
Thread-Topic: [PATCH rtw-next 3/3] wifi: rtl8xxxu: Use correct power off
 sequence for RTL8192CU
Thread-Index: AQHcOROTFQrJR1IL0U6V5SQ9ch0O4bTBEmVQ
Date: Tue, 14 Oct 2025 04:23:47 +0000
Message-ID: <8ee6d453d265451385b7c4e156c0ecf9@realtek.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
 <b9d3f137-12ce-4bd9-8ada-3b8874bc3615@gmail.com>
In-Reply-To: <b9d3f137-12ce-4bd9-8ada-3b8874bc3615@gmail.com>
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
MTkyQ1UgZGlzYXBwZWFycyBhbmQgcmVhcHBlYXJzIHdoZW4gcnRsOHh4eHUgaXMgdW5sb2FkZWQ6
DQo+IA0KPiB1c2Jjb3JlOiBkZXJlZ2lzdGVyaW5nIGludGVyZmFjZSBkcml2ZXIgcnRsOHh4eHUN
Cj4gd2xwM3MwZjN1MjogZGVhdXRoZW50aWNhdGluZyBmcm9tIC4uLiBieSBsb2NhbCBjaG9pY2Ug
KFJlYXNvbjogMz1ERUFVVEhfTEVBVklORykNCj4gdXNiIDEtMjogcnRsOHh4eHVfYWN0aXZlX3Rv
X2VtdTogRGlzYWJsaW5nIE1BQyB0aW1lZCBvdXQNCj4gdXNiIDEtMjogVVNCIGRpc2Nvbm5lY3Qs
IGRldmljZSBudW1iZXIgNw0KPiB1c2IgMS0yOiBkaXNjb25uZWN0aW5nDQo+IHVzYiAxLTI6IG5l
dyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDggdXNpbmcgeGhjaV9oY2QNCj4gdXNiIDEt
MjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD04MTc4LCBi
Y2REZXZpY2U9IDIuMDANCj4gdXNiIDEtMjogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEs
IFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTMNCj4gdXNiIDEtMjogUHJvZHVjdDogODAyLjExbiBX
TEFOIEFkYXB0ZXINCj4gdXNiIDEtMjogTWFudWZhY3R1cmVyOiBSZWFsdGVrDQo+IHVzYiAxLTI6
IFNlcmlhbE51bWJlcjogMDBlMDRjMDAwMDAxDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgcnRsOHh4
eHUgaXMgdXNpbmcgdGhlIHBvd2VyIG9mZiBzZXF1ZW5jZSBmb3IgUlRMODcyM0FVLg0KPiBBZGQg
dGhlIGNvcnJlY3QgcG93ZXIgb2ZmIHNlcXVlbmNlIGZvciBSVEw4MTkyQ1UuDQo+IA0KPiBydGw4
eHh4dV9wb3dlcl9vZmYoKSwgcnRsOHh4eHVfYWN0aXZlX3RvX2VtdSgpLCBhbmQNCj4gcnRsOHh4
eHVfZW11X3RvX2Rpc2FibGVkKCkgYXJlIG5vdyBvbmx5IHVzZWQgZm9yIFJUTDg3MjNBVSwgc28g
bW92ZQ0KPiB0aGVtIHRvIDg3MjNhLmMgYW5kIHJlbmFtZSB0aGVtIHRvIGhhdmUgdGhlICJydGw4
NzIzYXUiIHByZWZpeC4NCj4gDQo+IFRlc3RlZCBvbmx5IHdpdGggUlRMODE5MkNVLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+
DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

