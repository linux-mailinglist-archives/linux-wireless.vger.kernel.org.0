Return-Path: <linux-wireless+bounces-1135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF31A81B005
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B3282F93
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9EC171D5;
	Thu, 21 Dec 2023 08:10:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E514171D3
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BL8AIlL41309813, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BL8AIlL41309813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 16:10:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 21 Dec 2023 16:10:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Dec 2023 16:10:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 21 Dec 2023 16:10:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.kaistra@linutronix.de" <martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH 16/20] wifi: rtl8xxxu: support multiple interfaces in get_macid()
Thread-Topic: [PATCH 16/20] wifi: rtl8xxxu: support multiple interfaces in
 get_macid()
Thread-Index: AQHaMb/ihD8TykSy2kSZONBmOCWKE7Cxs6VwgAApN4CAAQN1gA==
Date: Thu, 21 Dec 2023 08:10:17 +0000
Message-ID: <fa3527bcb701de8a077d4247b16a258cbc1b8c12.camel@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
	 <20231218143645.433356-17-martin.kaistra@linutronix.de>
	 <3514e2620c734baaab8dbd8e34aaa5c5@realtek.com>
	 <d78d5a4c-45bf-4938-b5af-96b0ff4e9bfd@linutronix.de>
In-Reply-To: <d78d5a4c-45bf-4938-b5af-96b0ff4e9bfd@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC10A7396D46B147A67C0CC727F30E4B@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE3OjQwICswMTAwLCBNYXJ0aW4gS2Fpc3RyYSB3cm90ZToN
Cj4gDQo+IEFtIDIwLjEyLjIzIHVtIDA3OjE0IHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiA+IA0K
PiA+IA0KPiA+IEkgY2hlY2tlZCB3aGVyZSBkcml2ZXIgYXNzaWduIG1hY2lkLCBhbmQgb25seQ0K
PiA+IA0KPiA+ICAgICAgIGlmICh2aWYtPnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfQVApIHsNCj4g
PiAgICAgICAgICAgICAgIHN0YV9pbmZvLT5tYWNpZCA9IHJ0bDh4eHh1X2FjcXVpcmVfbWFjaWQo
cHJpdik7DQo+ID4gDQo+ID4gVGhhdCBtZWFucyBTVEEgbW9kZSBjYW4gYmUgbWFjaWQgPT0gMCBh
bHdheXMsIHJpZ2h0Pw0KPiA+IFRoaXMgd2lsbCBiZSBhIHByb2JsZW0uIEF0IGxlYXN0IFRYIHJh
dGUgd2lsbCBiZSBpbmNvcnJlY3QuDQo+IA0KPiBZZXMsIGN1cnJlbnRseSBtYWNpZCBmb3IgU1RB
IG1vZGUgaXMgYWx3YXlzIDAuIFdvdWxkIGl0IGJlIGVub3VnaCB0byBzZXQgbWFjaWQNCj4gaW4g
U1RBIG1vZGUgdG8gZWl0aGVyIDAgb3IgMSBkZXBlbmRpbmcgb24gcG9ydF9udW0/DQo+IA0KDQpJ
IGFtIG5vdCB2ZXJ5IHN1cmUgaWYgbWFjaWQgMCBwbGF5cyBhIHNwZWNpYWwgcm9sZSwgYnV0IG90
aGVycyAobWFjaWQgPj0gMSkNCmNhbiBiZSBkeW5hbWljYWxseSBhc3NpZ25lZCB0byBlYWNoIHN0
YXRpb25zLiANCg0KSSB0aGluayB3ZSBjYW4gcmVzZXJ2ZSBtYWNpZCAwIGFuZCAxIGZvciBwb3J0
IDAgYW5kIDEgcmVzcGVjdGl2ZWx5LA0KYW5kIGR5bmFtaWNhbGx5IGFzc2lnbiBtYWNpZCAyIG9y
IGxhcmdlciB0byBURExTIG9yIEFQIG1vZGUgcGVlciwgbGlrZQ0KDQptYWNpZCAgICAgcG9ydCBu
dW0gICAgICAgICBTVEEgbW9kZSAgICAgICAgICAgIEFQIG1vZGUNCi0tLS0tLSAgICAtLS0tLS0t
LS0tICAgICAgLS0tLS0tLS0tLS0tLSAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
ICAwICAgICAgICAgICAwICAgICAgICAgICAgdG8vZnJvbSBBUCAgICAgICAgICBicm9hZGNhc3QN
CiAgMSAgICAgICAgICAgMSAgICAgICAgICAgIHRvL2Zyb20gQVAgICAgICAgICAgICAgWA0KICAy
fiAgICAgICAwIG9yIDEgICAgICAgICAgdG8vZnJvbSBURExTICAgICAgICB0by9mcm9tIGNvbm5l
Y3RlZCBzdGF0aW9uDQoNCg0K

