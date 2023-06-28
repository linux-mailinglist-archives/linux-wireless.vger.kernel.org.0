Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C3741223
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjF1NTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 09:19:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24556 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231828AbjF1NT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 09:19:27 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-126-1UM9UdssPjqYY5USSmqybw-1; Wed, 28 Jun 2023 14:19:24 +0100
X-MC-Unique: 1UM9UdssPjqYY5USSmqybw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 28 Jun
 2023 14:19:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 28 Jun 2023 14:19:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Antipov' <dmantipov@yandex.ru>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] [v2] wifi: b43: fix cordic arithmetic
Thread-Topic: [PATCH] [v2] wifi: b43: fix cordic arithmetic
Thread-Index: AQHZqQsGGmQjvdKBv0W33H1tLjOZ1K+f3QLwgAAbbwCAADptcA==
Date:   Wed, 28 Jun 2023 13:19:23 +0000
Message-ID: <c3fed52f459b4bea8057b13f89ad6760@AcuMS.aculab.com>
References: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
 <20230627151411.92749-1-dmantipov@yandex.ru>
 <d0825edd2a3c4bbba72685340f547c9e@AcuMS.aculab.com>
 <4482488b-35d8-a2e8-259b-0a39ddffecba@yandex.ru>
In-Reply-To: <4482488b-35d8-a2e8-259b-0a39ddffecba@yandex.ru>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogRG1pdHJ5IEFudGlwb3YNCj4gU2VudDogMjggSnVuZSAyMDIzIDExOjQ1DQo+IA0KPiBP
biA2LzI4LzIzIDExOjI0LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+IA0KPiA+IFdoYXQgYXJlIHRo
ZSAodTE2KSBjYXN0cyBmb3I/DQo+IA0KPiBXZWxsLCB0aGlzIGlzIGEga2luZCBvZiBhIEMgbGFu
Z3VhZ2UgcHVyaXNtIGludGVuZGVkIHRvIHNpbGVuY2UNCj4gd2FybmluZzogY29udmVyc2lvbiBm
cm9tIOKAmGludOKAmSB0byDigJh1MTbigJkge2FrYSDigJhzaG9ydCB1bnNpZ25lZCBpbnTigJl9
IG1heSBjaGFuZ2UgdmFsdWUgWy1XY29udmVyc2lvbl0NCj4gb2JzZXJ2ZWQgd2l0aCBXPTEyMy4N
Cg0KVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY2FzdHMgY2FuIGhpZGUgbW9yZSB0aGFuIGp1c3Qg
YSB2YWx1ZSBiZWluZyB0cnVuY2F0ZWQuDQpJbiB0aGlzIGNhc2UgdGhlIGNvbXBpbGVyIGV2ZW4g
a25vd3MgdGhlIHZhbHVlcyBkb24ndCBvdmVyZmxvdy4NCg0KRldJVyBJJ3ZlIHNlZW4gZ2VuZXJh
dGVkIGNvZGUgZm9yOg0KCSpjcCsrID0gKHVuc2lnbmVkIGNoYXIpKHZhbHVlICYgMHhmZik7DQp0
aGF0IG1hc2tlZCB0aGUgdmFsdWUgd2l0aCAweGZmIG9uY2UgZm9yIHRoZSAmIGEgc2Vjb25kIHRp
bWUgZm9yDQp0aGUgY2FzdCBhbmQgdGhlbiBzdG9yZWQgdGhlIGxvdyBieXRlLg0KSSBkb24ndCB0
aGluayBtb2Rlcm4gZ2NjIHdpbGwgZG8gdGhhdCwgYnV0IGEgZHVtYiBjb21waWxlciB3aWxsLg0K
DQpJZiAtV2NvbnZlcnNpb24gYmxlYXRzIGFib3V0IHRoZXNlIHNvcnQgb2YgYXNzaWdubWVudHMg
aXQganVzdA0KbmVlZHMgcGVybWFuZW50bHkgZGlzYWJsaW5nIChvciBkZWxldGluZyBmcm9tIHRo
ZSBjb21waWxlciEpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

