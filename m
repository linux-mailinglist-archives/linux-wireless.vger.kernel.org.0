Return-Path: <linux-wireless+bounces-27732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41868BABED6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC436189D073
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C32C11C9;
	Tue, 30 Sep 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s6ErOSoO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB523E229;
	Tue, 30 Sep 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219028; cv=none; b=QL4QuYmlVEa4Rt5lnqQpS7RxUGePw9LeQYZWIIwNjWHJn/U/s4dFoz0yrfs9zGrseLBkEegmqD2Uh/RdmcYS74WPMgSGqms50+tNHQSNZRx0TcXqiik4ERV/YQOAV4jgr2+nIrXvU+wJf2qKt9TPCz7mId1uhbO+p6Y+H+wN+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219028; c=relaxed/simple;
	bh=0s6ejZYwNsOM6uPaW1Eumj7yDgYQ23Q6dPw8TxD24qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DSydb1sF8OcLiy/1mZZqmlP66/Rtni3tRFpbao5EYMcbOPTPOm47VQJ1XqZrTXHi9z36pHNtMMNQmNrRFLbeTuvGfaMTLHHz/V7CJeM0v2a4P04vaTPwUQyE6jYlkuBgQSOiyglKkMC8B2Io9pQrquXbW+rPtAgQ7q0Qo8FBqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s6ErOSoO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U7v1KK1726047, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759219021; bh=0s6ejZYwNsOM6uPaW1Eumj7yDgYQ23Q6dPw8TxD24qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s6ErOSoOiy3pHB+R6KFpp9L8xdYE51oLgMeMUaDt8fwIVZfkEmn9dON7jXS8idSgi
	 D/FxUwzZ0nlgPOWXsReelJmhaB60wm/LOc/og5fqSbx+4HrjWgNGnLRvJ2KE53+Gkz
	 Huu++r63DCnToymW0HDNOAm3i8J55GzJ0gKVkW2OJCrC2YQhrOEwTBRWkJSFtVfs3O
	 kIzlZ8TX8cn/dM/tQoofoypyr4CXlOJm85hgfM5xIavmSHO+IMZf6ttd9HUoK4iGCr
	 D81HrpM5SaA/CMQiH4/+nsrrxrnxmnxwB9N+BeCF6bnEjkimvPslngWNBeawCeqkON
	 Ld/fWpW4Xjh9g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U7v1KK1726047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 15:57:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 15:57:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 15:57:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link
 AN3U rev. A1
Thread-Index: AQHcMPU4LFvfPiVdyEmxJ5atcfU8NbSrAmPg///R9ACAAIdawA==
Date: Tue, 30 Sep 2025 07:57:00 +0000
Message-ID: <70d9d98f2c8d41fb94438d653e91697a@realtek.com>
References: <62f767e17eaf428393cf79d55666a011@realtek.com>
 <20250930074530.4204-1-zenmchen@gmail.com>
In-Reply-To: <20250930074530.4204-1-zenmchen@gmail.com>
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

WmVubSBDaGVuIDx6ZW5tY2hlbkBnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4g5pa8IDIwMjXlubQ55pyIMzDml6Ug6YCx5LqMIOS4iuWNiDExOjE5
5a+r6YGT77yaDQo+ID4NCj4gPiBaZW5tIENoZW4gPHplbm1jaGVuQGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gPiBBZGQgVVNCIElEIDIwMDE6MzMyOCBmb3IgRC1MaW5rIEFOM1UgcmV2LiBBMSB3aGlj
aCBpcyBhIFJUTDgxOTJGVS1iYXNlZA0KPiA+ID4gV2ktRmkgYWRhcHRlci4NCj4gPiA+DQo+ID4g
PiBDb21waWxlIHRlc3RlZCBvbmx5Lg0KPiA+ID4NCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgNi42LngNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFplbm0gQ2hlbiA8emVubWNoZW5A
Z21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBMaW5rIHRvIHRoZSBXaW5kb3dzIGRyaXZlciBm
b3IgRC1MaW5rIEFOM1UgcmV2LiBBMQ0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vd3d3LmRsaW5rdHcu
Y29tLnR3L3RlY2hzdXBwb3J0L1Byb2R1Y3RJbmZvLmFzcHg/bT1BTjNVDQo+ID4NCj4gPiBDb3Vs
ZCB5b3UgcGxlYXNlIGVubGlnaHRlbiBtZSBob3cgeW91IGFkZHJlc3MgdGhpcyBpcyBSVEw4MTky
RlUtYmFzZWQ/DQo+ID4gSSBkb3dubG9hZGVkIHRoZSBzZXR1cC5leHQgYW5kIGRlY29tcHJlc3Nl
ZCB0aGUgZmlsZSwgYnV0IEkgY2FuJ3QgZmluZA0KPiA+IDgxOTJGVS4NCj4gDQo+IEhpIFBpbmct
S2UsDQo+IA0KPiBBZnRlciBpbnN0YWxsaW5nIHRoYXQgV2luZG93cyBkcml2ZXIsIHRoZSBkcml2
ZXIgd2lsbCBiZSBwbGFjZWQgYXQgQzpcUHJvZ3JhbSBGaWxlc1xELUxpbmtcQU4zVVxEcml2ZXIu
DQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGxpbmUgMjY2IG9mIHRoZSBDOlxQcm9ncmFtIEZpbGVz
XEQtTGlua1xBTjNVXERyaXZlclxXSU4xMFg2NFxuZXRydHdsYW51LmluZiBmaWxlIFsxXSwgd2UN
Cj4ga25vdyB0aGF0IHRoaXMgZG9uZ2xlIHVzZXMgYSA4MTkyRlUgY2hpcC4NCj4gVGhlIHNwZWNp
ZmljYXRpb24gWzJdIHdoaWNoIHNheXMgaXQgc3VwcG9ydHMgYm90aCBXUEEyIGFuZCBXUEEzIGlz
IGFsc28gYSBjbHVlLiBBcyBmYXIgYXMgSSBrbm93LCBhbW9uZw0KPiBhbGwgV2luZG93cyBkcml2
ZXJzIGZvciBSZWFsdGVrIDgwMi4xMW4gMlQyUiBjaGlwcywgb25seSB0aGUgZHJpdmVyIGZvciA4
MTkyRlUgc3VwcG9ydHMgYm90aCBXUEEyL1dQQTMsDQo+IG90aGVycyBzdXBwb3J0IFdQQTIgb25s
eS4NCj4gVGhpcyBpcyBob3cgSSBkZXRlcm1pbmUgd2hhdCBjaGlwIHRoaXMgZG9uZ2xlIHVzZXMs
IGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZXJlIGlzIG5vIHJlbGF0ZWQgcmVwb3J0IGF0DQo+IGxpbnV4
LWhhcmR3YXJlLm9yZyBbM10gc28gY2Fubm90IGNvbmZpcm0gaXQgZG9lcyB1c2UgdGhlIElEIDIw
MDE6MzMyOC4NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsLiBJIGhhdmUgbm8gcGVybWlzc2lvbiB0
byBpbnN0YWxsIGRyaXZlcnMgdG8NCm15IFdpbmRvd3MgUEMgaW4gb2ZmaWNlLCBzbyBJIGNhbiBv
bmx5IHRyeSB0byBkZWNvbXByZXNzIHNldHVwLmV4ZS4NCkFueXdheSwgYWNrIHRoaXMgcGF0Y2gu
IFRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
Pg0KDQo+IA0KPiBbMV0gbGluZSAyNjUgfiAyNjYgb2YgdGhlIG5ldHJ0d2xhbnUuaW5mIGZpbGUN
Cj4gOzsgRm9yIDgxOTJGIERMSU5LDQo+ICVETGlua19BTjNVLkRldmljZURlc2MlICAgICAgICAg
ICAgICAgICAgICAgICAgID0gUlRMODE5MmZ1Lm5kaSwgICAgICAgIFVTQlxWSURfMjAwMSZQSURf
MzMyOA0KPiANCj4gWzJdIGh0dHBzOi8vd3d3LmRsaW5rLmNvbS90dy96aC9wcm9kdWN0cy9hbjN1
I1NwZWNzDQo+IA0KPiBbM10gUmVwb3J0cyBhYm91dCB0aGUgSUQgMjAwMTozMzI4IGFuZCAyMDAx
OjMzMjkNCj4gaHR0cHM6Ly9saW51eC1oYXJkd2FyZS5vcmcvP2lkPXVzYjoyMDAxLTMzMjgNCj4g
aHR0cHM6Ly9saW51eC1oYXJkd2FyZS5vcmcvP2lkPXVzYjoyMDAxLTMzMjkNCj4gDQo+ID4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29y
ZS5jIHwgMyArKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvY29yZS5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
Y29yZS5jDQo+ID4gPiBpbmRleCAzZGVkNTk1MjcuLmJlMzk0NjNiZCAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiA+ID4g
QEAgLTgxMzYsNiArODEzNiw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBk
ZXZfdGFibGVbXSA9IHsNCj4gPiA+ICAvKiBUUC1MaW5rIFRMLVdOODIzTiBWMiAqLw0KPiA+ID4g
IHtVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIzNTcsIDB4MDEzNSwgMHhmZiwgMHhm
ZiwgMHhmZiksDQo+ID4gPiAgICAgICAgIC5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSZy
dGw4MTkyZnVfZm9wc30sDQo+ID4gPiArLyogRC1MaW5rIEFOM1UgcmV2LiBBMSAqLw0KPiA+ID4g
K3tVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIwMDEsIDB4MzMyOCwgMHhmZiwgMHhm
ZiwgMHhmZiksDQo+ID4gPiArICAgICAgIC5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSZy
dGw4MTkyZnVfZm9wc30sDQo+ID4gPiAgI2lmZGVmIENPTkZJR19SVEw4WFhYVV9VTlRFU1RFRA0K
PiA+ID4gIC8qIFN0aWxsIHN1cHBvcnRlZCBieSBydGx3aWZpICovDQo+ID4gPiAge1VTQl9ERVZJ
Q0VfQU5EX0lOVEVSRkFDRV9JTkZPKFVTQl9WRU5ET1JfSURfUkVBTFRFSywgMHg4MTc2LCAweGZm
LCAweGZmLCAweGZmKSwNCj4gPiA+IC0tDQo+ID4gPiAyLjUxLjANCj4gPg0KDQo=

