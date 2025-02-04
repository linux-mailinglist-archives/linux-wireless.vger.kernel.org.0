Return-Path: <linux-wireless+bounces-18332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4BA2688A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 01:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B318188639F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE918EB0;
	Tue,  4 Feb 2025 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZcLzzrqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C341862A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628861; cv=none; b=FPo3hsd3yE72iPJJkuAMtT+ghi2uT8XKLGAPmr8jVtRzgYka5M5QhSP2kSbRg44LVmtnmOR4MaiA60s4aT9r5xs7xXF1YQHsV9QO9O6Qx3G1gz356wCURqYrtw6g26pMQuUOrwNG41CyE529YKy5kE/BtgDzCkEU8Y28lCQ9z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628861; c=relaxed/simple;
	bh=P4Hu060AS7bqr3atD7otamrI1MViLNAqhZlLFotATUQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BWsJhG+mYAUlPVVj4AzRJETN+zeljXFw2A1rGTJjgOO0go0GD7J+PilHMylRN8APwQAXSiPs0pvYabK7Z+Nkj4TK+z01VDZ4lfkrpClvx48WkZ5HvZ8zda6wWFLUYUNFwQKDk/wwPz3CvH0oOwvEUobhTXjptlDk2sQDC650xJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZcLzzrqp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5140RUaV42624755, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738628850; bh=P4Hu060AS7bqr3atD7otamrI1MViLNAqhZlLFotATUQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZcLzzrqpd//d76KrwadOM2Ng890y3V9QQEDuwijgCkUC+LOP1/sVBYnp+/R6ZpdRT
	 x9oqGyk30CdVT+ncHOtdYCQsm4s1RAbUlIy8LuwaOjaBVfeXEhW8z4Go6g5KvK6ZYQ
	 Gx/m1qtHRf0AmtT7F5e/qVrBzguCUyCCygvXlWc8l3G6ZKdtac6Ow060PUlnt8Tw/4
	 wGUAtpLE2Zw64tdqaOX8BlO9Ax2THfE/y+QEgG/4S/+Vv06hMAFJtISh9IpICE/cG3
	 g9kwedsfWU4SCOyHceFwc+WOSLq1OL49vHFRyqbbprs4nUvK/jXekQ4t0oxtAKYrox
	 DOhTzGBjK1/5g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5140RUaV42624755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 08:27:30 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Feb 2025 08:27:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Feb 2025 08:27:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 4 Feb 2025 08:27:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tistou MOITA <tistou@syngate.fr>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: wifi radom disconnects
Thread-Topic: wifi radom disconnects
Thread-Index: AQHbdkYhi+DCpSTEeUSJPfPVpOpGsLM2SU2g
Date: Tue, 4 Feb 2025 00:27:30 +0000
Message-ID: <6cec5730b4414f7999e4af92ae306389@realtek.com>
References: <PR0P264MB2968C37DBDB24BD8151F8162B3F52@PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PR0P264MB2968C37DBDB24BD8151F8162B3F52@PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM>
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

VGlzdG91IE1PSVRBIDx0aXN0b3VAc3luZ2F0ZS5mcj4gd3JvdGU6DQo+IEhpLA0KPiANCj4gV2lG
aSByYW5kb21seSBpcyBkaXNjb25uZWN0ZWQgb24gdWJ1bnR1IDI0LjA0DQo+IA0KPiB1bmFtZSAt
YQ0KPiBMaW51eCBQQ1AtUVVJTVBFUi0wNCA2LjguMC01Mi1nZW5lcmljICM1My1VYnVudHUgU01Q
IFBSRUVNUFRfRFlOQU1JQyBTYXQgSmFuIDExIDAwOjA2OjI1IFVUQyAyMDI1IHg4Nl82NA0KPiB4
ODZfNjQgeDg2XzY0IEdOVS9MaW51eA0KPiANCj4gT24gc2V2ZXJhbCBzYW1lIFBDcyA6DQo+IOKA
guKAguKAguKAguKAguKAgk1hbnVmYWN0dXJlcjogTEVOT1ZPDQo+IOKAguKAguKAguKAguKAguKA
glByb2R1Y3QgTmFtZTogODNBMQ0KPiDigILigILigILigILigILigIJWZXJzaW9uOiBMZW5vdm8g
VjE1IEc0IElSVQ0KPiANCj4gV2lmaSBDaGlwc2V0IDoNCj4gUmVhbHRlayBSVEw4ODIyQ0UNCj4g
DQo+IEVycm9ycyA6DQo+IA0KPiBNb2RlbU1hbmFnZXJbMTg4OF06IDxtc2c+IFtiYXNlLW1hbmFn
ZXJdIGNvdWxkbid0IGNoZWNrIHN1cHBvcnQgZm9yIGRldmljZQ0KPiAnL3N5cy9kZXZpY2VzL3Bj
aTAwMDA6MDAvMDAwMDowMDoxZC4wLzAwMDA6MDI6MDAuMCc6IG5vdCBzdXBwb3J0ZWQgYnkgYW55
IHBsdWdpbg0KPiANCj4gd3BhX3N1cHBsaWNhbnRbMTgzNF06IFRETFM6IEludmFsaWQgZnJhbWUg
LSBwYXlsb2FkdHlwZT0xIGNhdGVnb3J5PTI0MCBhY3Rpb249MjYNCj4gDQo+IFsgIDMwMi42MjM0
MjddIHJ0d184ODIyY2UgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gZG8gZHBrIGNhbGlicmF0aW9u
DQo+IA0KPiB3cGFfc3VwcGxpY2FudFsxMzMxXTogd2xwMnMwOiBDVFJMLUVWRU5ULVNJR05BTC1D
SEFOR0UgYWJvdmU9MCBzaWduYWw9LTY0IG5vaXNlPTk5OTkgdHhyYXRlPTIxNjAwMA0KPiANCj4g
WyAzMjAzLjU2Nzk3MV0gcnR3Xzg4MjJjZSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBnZXQgdHgg
cmVwb3J0IGZyb20gZmlybXdhcmUNCj4gWyAzMjMzLjkyOTA3Nl0gcnR3Xzg4MjJjZSAwMDAwOjAy
OjAwLjA6IGZpcm13YXJlIGZhaWxlZCB0byByZXBvcnQgZGVuc2l0eSBhZnRlciBzY2FuDQo+IA0K
PiBBbHJlYWR5IHRyaWVkIHRvIGFkZCBvcHRpb25zIHRvIHJ0dzg4IG1vZHVsZSA6DQo+IA0KPiBk
aXNhYmxlX2xwc19kZWVwPXkNCj4gZGlzYWJsZV9hc3BtPXkNCg0KTm90IGNsZWFyIHRvIG1lIGlm
IHRoZXNlIGVycm9ycyBhcmUgcmVsYXRlZCB0byBkaXNjb25uZWN0LiBQbGVhc2Ugc2hhcmUNCmZ1
bGwgbG9nICh2aWEgcHJpdmF0ZSBtYWlsIGlmIHByaXZhY3kgaXNzdWUpLiBJIGFsc28gd2FudCB0
byBjaGVjayB0aGUNCmZpcm13YXJlIHZlcnNpb24geW91IGFyZSB1c2luZy4gDQoNCkFub3RoZXIg
dHJ5IGlzIHRvIHR1cm4gb2ZmIHBvd2VyIHNhdmluZyBlbnRpcmVseSBieQ0KICBzdWRvIGl3IHds
YW4wIHNldCBwb3dlciBzYXZlIG9mZg0KDQpQaW5nLUtlDQoNCg==

