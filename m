Return-Path: <linux-wireless+bounces-26214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEFB1E1E2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2D6164E9B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E64A92E;
	Fri,  8 Aug 2025 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rd/FIT59"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E552367
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632861; cv=none; b=dnBcPb0Yo/VXTyAaGmPi+8Ovqpi7pTOzdX0NJ230uM32M0Pznt44V6mlX25VGTm+ggtQfGZUi+ftihXyH9PskypuC1R9cCkTDi6/ATH6lAWP87f5RlJO5uNWX8b00Ti7X2ZieFgu0GImyX/dy4+eKX3SeNNdGT59d8cdquCJSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632861; c=relaxed/simple;
	bh=PkLUE6od/d28sKj3AU1O5/ihavT/DxIP8xaMH2dshf4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AHZVV9xW+yO//M1xRIJe5Ics9ObCgP0Xk4AfHC49Rz22EATi5QSy5xJeGHV/9/f8OO0GGdiEHmTpKb+89j61NBi8ETIS+jMScOie+xho6msCK1R8V/Uov5mldl8UEoVw0Y+2shf/N2n6+1uBNQNCgXSR+JrV6FDldVYdAyY4DsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rd/FIT59; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57860tezE2767894, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754632855; bh=PkLUE6od/d28sKj3AU1O5/ihavT/DxIP8xaMH2dshf4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rd/FIT598FzcGZT3Dq/zf1r5RX6aaw1ZT5XgftzO9nujy3ir8eqfHlqgv7zQaq3b8
	 ckx7gF13HTpBZaMgJn+LD4Q91idnvq20qhJUkOScizsHuapSVWksX2noL3sYtEpMTQ
	 duIidhkXCR/n0g2rSieOXXMU89YZ8zYifLDpkhH2XDBSbcmzbcqbULWM4Mhzq7e+SL
	 pZ6Q0RG6//5rm0jefYIaqThaZV4GmYe2lPMelPgZuzDyy0+z0FkrKlv85diGqoz8OA
	 sWN0zEU05J5CwWRKbz5/KeW2xKH4RhwZh72NDMnPOMGwPMb3oIlekt1VIiaNEOEafM
	 WbX74TDQ2+ywQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57860tezE2767894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:00:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:00:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:00:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 03/11] wifi: rtw89: usb: Fix rtw89_usb_ops_mac_pre_init() for RTL8852CU
Thread-Topic: [PATCH rtw-next v2 03/11] wifi: rtw89: usb: Fix
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
Thread-Index: AQHcAyZLDNkKlARKV0CIx9TGXwsDHrRYTLog
Date: Fri, 8 Aug 2025 06:00:55 +0000
Message-ID: <6e9dc0863f23485d9bfe00e7fadbd190@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <e4911e9c-7a34-45c8-ba05-a6ff4649eb71@gmail.com>
In-Reply-To: <e4911e9c-7a34-45c8-ba05-a6ff4649eb71@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
cmVnaXN0ZXJzIHVzZWQgaW4gdGhpcyBmdW5jdGlvbiBhcmUgbG9jYXRlZCBhdCBkaWZmZXJlbnQg
b2Zmc2V0cyBpbg0KPiBSVEw4ODUyQ1UgY29tcGFyZWQgdG8gb3RoZXIgY2hpcHMuIFVzZSB0aGUg
cmlnaHQgcmVnaXN0ZXJzIGZvciBlYWNoDQo+IGNoaXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYyOg0K
PiAgLSBObyBjaGFuZ2UsIG1lc3NlZCB1cCBzZW5kaW5nIHYxLg0KPiAtLS0NCj4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMgfCAyOSArKysrKysrKysrKysrKysrKysr
Ky0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
dXNiLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5jDQo+IGluZGV4
IGViOTk3OGE2MGQwNC4uZTc0OWEzN2FjMWI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gQEAgLTcyNiwyMCArNzI2LDM5IEBAIHN0YXRpYyBpbnQg
cnR3ODlfdXNiX29wc19kZWluaXQoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiANCj4gIHN0
YXRpYyBpbnQgcnR3ODlfdXNiX29wc19tYWNfcHJlX2luaXQoc3RydWN0IHJ0dzg5X2RldiAqcnR3
ZGV2KQ0KPiAgew0KPiArICAgICAgIHUzMiB1c2JfaG9zdF9yZXF1ZXN0XzIsIHVzYl93bGFuMF8x
LCBoY2lfZnVuY19lbjsNCj4gICAgICAgICB1MzIgdmFsMzI7DQo+IA0KPiAtICAgICAgIHJ0dzg5
X3dyaXRlMzJfc2V0KHJ0d2RldiwgUl9BWF9VU0JfSE9TVF9SRVFVRVNUXzIsIEJfQVhfUl9VU0JJ
T19NT0RFKTsNCj4gKyAgICAgICBzd2l0Y2ggKHJ0d2Rldi0+Y2hpcC0+Y2hpcF9pZCkgew0KPiAr
ICAgICAgIGNhc2UgUlRMODg1MUI6DQo+ICsgICAgICAgY2FzZSBSVEw4ODUyQToNCj4gKyAgICAg
ICBjYXNlIFJUTDg4NTJCOg0KPiArICAgICAgICAgICAgICAgdXNiX2hvc3RfcmVxdWVzdF8yID0g
Ul9BWF9VU0JfSE9TVF9SRVFVRVNUXzI7DQo+ICsgICAgICAgICAgICAgICB1c2Jfd2xhbjBfMSA9
IFJfQVhfVVNCX1dMQU4wXzE7DQo+ICsgICAgICAgICAgICAgICBoY2lfZnVuY19lbiA9IFJfQVhf
SENJX0ZVTkNfRU47DQoNCkxpa2UgY29tbWVudCBpbiAwMi8xMSwgcnR3ODlfdXNiX2luZm8gY2Fu
IGhlbHAgaWYgeW91IGxpa2UgdGhhdCBzdHlsZS4gDQoNCk90aGVyd2lzZSwNCg0KQWNrZWQtYnk6
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+ICsgICAgICAgICAgICAgICBi
cmVhazsNCj4gKyAgICAgICBjYXNlIFJUTDg4NTJDOg0KPiArICAgICAgICAgICAgICAgdXNiX2hv
c3RfcmVxdWVzdF8yID0gUl9BWF9VU0JfSE9TVF9SRVFVRVNUXzJfVjE7DQo+ICsgICAgICAgICAg
ICAgICB1c2Jfd2xhbjBfMSA9IFJfQVhfVVNCX1dMQU4wXzFfVjE7DQo+ICsgICAgICAgICAgICAg
ICBoY2lfZnVuY19lbiA9IFJfQVhfSENJX0ZVTkNfRU5fVjE7DQo+ICsgICAgICAgICAgICAgICBi
cmVhazsNCj4gKyAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgcnR3ODlfZXJyKHJ0
d2RldiwgIiVzOiB1bmtub3duIGNoaXBcbiIsIF9fZnVuY19fKTsNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRU9QTk9UU1VQUDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBydHc4OV93
cml0ZTMyX3NldChydHdkZXYsIHVzYl9ob3N0X3JlcXVlc3RfMiwgQl9BWF9SX1VTQklPX01PREUp
Ow0KPiANCj4gICAgICAgICAvKiBmaXggVVNCIElPIGhhbmcgc3VnZ2VzdCBieSBjaGloaGFubGlA
cmVhbHRlay5jb20gKi8NCj4gLSAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhf
VVNCX1dMQU4wXzEsDQo+ICsgICAgICAgcnR3ODlfd3JpdGUzMl9jbHIocnR3ZGV2LCB1c2Jfd2xh
bjBfMSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBCX0FYX1VTQlJYX1JTVCB8IEJfQVhf
VVNCVFhfUlNUKTsNCj4gDQo+IC0gICAgICAgdmFsMzIgPSBydHc4OV9yZWFkMzIocnR3ZGV2LCBS
X0FYX0hDSV9GVU5DX0VOKTsNCj4gKyAgICAgICB2YWwzMiA9IHJ0dzg5X3JlYWQzMihydHdkZXYs
IGhjaV9mdW5jX2VuKTsNCj4gICAgICAgICB2YWwzMiAmPSB+KEJfQVhfSENJX1JYRE1BX0VOIHwg
Ql9BWF9IQ0lfVFhETUFfRU4pOw0KPiAtICAgICAgIHJ0dzg5X3dyaXRlMzIocnR3ZGV2LCBSX0FY
X0hDSV9GVU5DX0VOLCB2YWwzMik7DQo+ICsgICAgICAgcnR3ODlfd3JpdGUzMihydHdkZXYsIGhj
aV9mdW5jX2VuLCB2YWwzMik7DQo+IA0KPiAgICAgICAgIHZhbDMyIHw9IEJfQVhfSENJX1JYRE1B
X0VOIHwgQl9BWF9IQ0lfVFhETUFfRU47DQo+IC0gICAgICAgcnR3ODlfd3JpdGUzMihydHdkZXYs
IFJfQVhfSENJX0ZVTkNfRU4sIHZhbDMyKTsNCj4gKyAgICAgICBydHc4OV93cml0ZTMyKHJ0d2Rl
diwgaGNpX2Z1bmNfZW4sIHZhbDMyKTsNCj4gICAgICAgICAvKiBmaXggVVNCIFRSWCBoYW5nIHN1
Z2dlc3QgYnkgY2hpaGhhbmxpQHJlYWx0ZWsuY29tICovDQo+IA0KPiAgICAgICAgIHJldHVybiAw
Ow0KPiAtLQ0KPiAyLjUwLjANCg0K

