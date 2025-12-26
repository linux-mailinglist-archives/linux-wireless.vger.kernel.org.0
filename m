Return-Path: <linux-wireless+bounces-30112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61247CDE34E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE30300794F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 01:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF51F92E;
	Fri, 26 Dec 2025 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gYSu50eB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5F15E97
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766713880; cv=none; b=PQNhD9XG2n+ECN/+yAZKZa79cXsbLbTHG9cOiQsd6elixxWpQEfAEHwP8UEf7Pp0CmFPioKRwQszjiG8REQBZvvbP36xM+EvRI+QlgEpONMzOORwg99oFl3AjEc8FdtQBBdA0RG6BzRdijWpF7+SNQH34aslxf1ACTPH/IuQHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766713880; c=relaxed/simple;
	bh=dslxs6vWcawiNg5I0dstdaVX94J4pHtoEcr97MC7L0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqaUquVleMBVXRKx8qSraogtzmFrSmhpsozQr88WloSjAQDVZqVYdUiKASf4IWlbmAT93PO+cQdbC1dAkF3avZ7CD/UKeQI4WT+hlcpQN+1FHhjtX+hcxuouWbHtndrdCAtFzame7IJYyPlCVw6vdLiSHhUqTiqVstYJ8w0oe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gYSu50eB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ1pDIR12693467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766713873; bh=dslxs6vWcawiNg5I0dstdaVX94J4pHtoEcr97MC7L0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gYSu50eBJiZPyHii5AlfaV0S1AtX7HMcbzUlpRnl7f5mKRY81dGYac2boJr6ln2C0
	 33ND/F58p4h2lyg2MNLC8Etf9mYofUckkzDSANN5/7aTaYvK2p5QEhuzOYzSqFlAXx
	 7a+A6zq9dckHLDWzYrPAF7QeKdb1RYsvxl4SnuRefhGr4+jfCErWINjIG2J4fsvdYn
	 TZWyNv16O76s7q+86lt9Uw+vg/RjijQYlt7TnOsGzzKJ5zwUGNAQeFBL/mNtTInwzK
	 9SaJx/cqFnMgOS12N8ooYnCuhKxCbvPevxeQO7K2ICOKlE10feL/egY+wo8akoCgL5
	 HEzAC6pzmM5iw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ1pDIR12693467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 09:51:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:51:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:51:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 26 Dec 2025 09:51:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/3] wifi: rtw88: Fix inadvertent sharing of
 struct ieee80211_supported_band data
Thread-Topic: [PATCH rtw-next 3/3] wifi: rtw88: Fix inadvertent sharing of
 struct ieee80211_supported_band data
Thread-Index: AQHcdGOeDI9Db9hUtkerHX5Qw5q7TLUzKYiw
Date: Fri, 26 Dec 2025 01:51:13 +0000
Message-ID: <a740cc19f23a409285b066044a81455b@realtek.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
 <e94ad653-2b6d-4284-a33c-8c694f88955b@gmail.com>
In-Reply-To: <e94ad653-2b6d-4284-a33c-8c694f88955b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJbnRl
cm5hbGx5IHdpcGh5IHdyaXRlcyB0byBpbmRpdmlkdWFsIGNoYW5uZWxzIGluIHRoaXMgc3RydWN0
dXJlLA0KPiBzbyB3ZSBtdXN0IG5vdCBzaGFyZSBvbmUgc3RhdGljIGRlZmluaXRpb24gb2YgY2hh
bm5lbCBsaXN0IGJldHdlZW4NCj4gbXVsdGlwbGUgZGV2aWNlIGluc3RhbmNlcywgYmVjYXVzZSB0
aGF0IGNhdXNlcyBoYXJkIHRvIGRlYnVnDQo+IGJyZWFrYWdlLg0KPiANCj4gRm9yIGV4YW1wbGUs
IHdpdGggdHdvIHJ0dzg4IGRyaXZlbiBkZXZpY2VzIGluIHRoZSBzeXN0ZW0sIGNoYW5uZWwNCj4g
aW5mb3JtYXRpb24gbWF5IGdldCBpbmNvaGVyZW50LCBwcmV2ZW50aW5nIGNoYW5uZWwgdXNlLg0K
PiANCj4gQ29waWVkIGZyb20gY29tbWl0IDBhZTM2MzkxYzgwNCAoIndpZmk6IHJ0dzg5OiBGaXgg
aW5hZHZlcmVudCBzaGFyaW5nDQo+IG9mIHN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQg
ZGF0YSIpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFp
bi5jIHwgMzQgKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9tYWluLmMNCj4gaW5kZXggNDZhZjViY2JiOGJjLi5jNGY5NzU4YjRlOTYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+IEBA
IC0xNjYxLDE2ICsxNjYxLDQxIEBAIHN0YXRpYyB1MTYgcnR3X2dldF9tYXhfc2Nhbl9pZV9sZW4o
c3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gICAgICAgICByZXR1cm4gbGVuOw0KPiAgfQ0KPiAN
Cj4gK3N0YXRpYyBzdHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kICoNCj4gK3J0d19zYmFu
ZF9kdXAoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gKyAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kICpzYmFuZCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1
Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kICpkdXA7DQo+ICsNCj4gKyAgICAgICBkdXAgPSBk
ZXZtX2ttZW1kdXAocnR3ZGV2LT5kZXYsIHNiYW5kLCBzaXplb2YoKnNiYW5kKSwgR0ZQX0tFUk5F
TCk7DQo+ICsgICAgICAgaWYgKCFkdXApDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsN
Cj4gKw0KPiArICAgICAgIGR1cC0+Y2hhbm5lbHMgPSBkZXZtX2ttZW1kdXBfYXJyYXkocnR3ZGV2
LT5kZXYsIHNiYW5kLT5jaGFubmVscywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNiYW5kLT5uX2NoYW5uZWxzLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCpzYmFuZC0+Y2hhbm5lbHMpLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQoNCkknZCBq
dXN0IHBvaW50IG91dCB0aGUgY2hhbm5lbHMgKHJ0d19jaGFubmVsdGFibGVfezJnLDVnfSkgYW5k
IGJpdHJhdGVzDQoocnR3X3JhdGV0YWJsZSkgYXJyYXlzIHRoYXQgYm90aCBjYW4ndCBiZSBjb25z
dGFudCwgYmVjYXVzZSBkZWNsYXJhdGlvbiBvZg0KaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kIGlz
IG5vdCBhIGNvbnN0YW50Og0KDQpzdHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kIHsNCglz
dHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgKmNoYW5uZWxzOw0KCXN0cnVjdCBpZWVlODAyMTFfcmF0
ZSAqYml0cmF0ZXM7DQoJLi4uDQp9DQoNCg0K

