Return-Path: <linux-wireless+bounces-1134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEC81AFDD
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 08:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544541F23D90
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E174154BB;
	Thu, 21 Dec 2023 07:57:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F9154AA
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BL7ukL031303734, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BL7ukL031303734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 15:56:46 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 21 Dec 2023 15:56:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 15:56:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 21 Dec 2023 15:56:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.kaistra@linutronix.de" <martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to both interfaces
Thread-Topic: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to
 both interfaces
Thread-Index: AQHaMb/F+8FmqtnoUU+G0r/J9qn1AbCxpxFAgAA2qYCAAP7QgA==
Date: Thu, 21 Dec 2023 07:56:45 +0000
Message-ID: <f2f6f794a4ad206281c9f7cc4b9f410db5618ada.camel@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
	 <20231218143645.433356-8-martin.kaistra@linutronix.de>
	 <cddf0a0b59a1425fa0e37743feaaafa4@realtek.com>
	 <19477f91-4a4e-4ce2-91ca-09ab4f56384a@linutronix.de>
In-Reply-To: <19477f91-4a4e-4ce2-91ca-09ab4f56384a@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <746A7C68E04B814BA6967195B1C48ABF@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE3OjQzICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gDQo+IEFtIDIwLjEyLjIzIHVtIDA2OjUxIHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiA+IA0K
PiA+IEkgZmVlbCB0aGF0IGRyaXZlciBjYW4gb25seSB0cmFjayBzaW5nbGUgb25lIENGTyAoY2Fy
cmllciBmcmVxdWVuY3kgb2Zmc2V0KQ0KPiA+IGZyb20gQVAuIENvbnNpZGVyaW5nIFNUQStTVEEg
Y2FzZSB3aXRoIHR3byBkaWZmZXJlbnQgQVBzLCBpdCB3b3VsZCBjYXVzZQ0KPiA+IHBpbmctcG9u
ZyBDRk8gdmFsdWVzIGJldHdlZW4gdHdvIEFQcy4NCj4gPiANCj4gPiBBIHNpbXBsZSB3YXkgaXMg
anVzdCB0byBpZ25vcmUgQ0ZPIGZvciBTVEErU1RBIGNhc2UuIEFub3RoZXIgd2F5IGlzIHRvDQo+
ID4gcmVmZXJlbmNlIHRoZSBtZXRob2RzIGltcGxlbWVudGVkIGJ5IHJ0dzg5IHdoZXJlIGZ1bmN0
aW9uIG5hbWUgaXMNCj4gPiBydHc4OV9waHlfbXVsdGlfc3RhX2Nmb19jYWxjKCkuIE9uZSBtZXRo
b2QgaXMgdG8gcmVjb3JkIENGTyB0YWlsIGZvciBlYWNoDQo+ID4gbWFjX2lkIGFuZCB1c2UgdGhl
IGF2ZXJhZ2UgYXMgdGFyZ2V0IENGTyB2YWx1ZSB0byBoYXJkd2FyZS4NCj4gDQo+IFRoaXMgaXMg
b25seSBhIHByb2JsZW0sIGlmIGJvdGggaW50ZXJmYWNlcyBhcmUgaW4gU1RBIG1vZGUgYW5kIGFy
ZSBhY3R1YWxseQ0KPiBjb25uZWN0ZWQsIHJpZ2h0Pw0KDQpZZXMuIA0KDQoNCg0K

