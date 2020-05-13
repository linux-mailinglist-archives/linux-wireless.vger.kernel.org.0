Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B861D1AA2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbgEMQIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 12:08:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29055 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729589AbgEMQIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 12:08:01 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-164-ZG3c9vU-NVypks5Qb5EXZQ-1; Wed, 13 May 2020 17:07:58 +0100
X-MC-Unique: ZG3c9vU-NVypks5Qb5EXZQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 May 2020 17:07:57 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 May 2020 17:07:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: gcc-10: kernel stack is corrupted and fails to boot
Thread-Topic: gcc-10: kernel stack is corrupted and fails to boot
Thread-Index: AQHWKT/xY215XsBMzU2jywoKX8cjPqimLnCA
Date:   Wed, 13 May 2020 16:07:57 +0000
Message-ID: <88aae01f75584c2ea8df3f59a43dcddd@AcuMS.aculab.com>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
 <87zhacrokl.fsf@kamboji.qca.qualcomm.com>
 <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
 <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
 <CAK8P3a2eKoOL0KF4CmyEtk-3309f2_D+daQbe=Bj5vCkvD_khA@mail.gmail.com>
In-Reply-To: <CAK8P3a2eKoOL0KF4CmyEtk-3309f2_D+daQbe=Bj5vCkvD_khA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMyBNYXkgMjAyMCAxNzowMA0KPiBPbiBXZWQs
IE1heSAxMywgMjAyMCBhdCA1OjMxIFBNIEthbGxlIFZhbG8gPGt2YWxvQGNvZGVhdXJvcmEub3Jn
PiB3cm90ZToNCi4uLg0KPiBJIGludmVzdGlnYXRlZCBhIGxpdHRsZSBtb3JlOiBUaGlzIGRvZXMg
aGFwcGVuIHdpdGggJ2RlZmNvbmZpZycNCj4gYWZ0ZXIgYWxsLCBpbiBteSBmaXJzdCB0cnkgSSBt
dXN0IGhhdmUgbWlzc2VkIHRoZSAnLXNtcCAyJyBhcmd1bWVudA0KPiB0byBxZW11LCBhbmQgaXQg
ZW5kZWQgdXAgd29ya2luZyBjb3JyZWN0bHkgd2l0aCBqdXN0IG9uZSBDUFUNCj4gYnV0IGZhaWxz
IG5vdy4NCj4gDQo+IFN0ZXBwaW5nIHRocm91Z2ggdGhlIGJvb3QgcHJvY2VzcywgSSBzZWUgd2hl
cmUgaXQgY3Jhc2hlcw0KPiBpbiBzdGFydF9zZWNvbmRhcnk6DQo+IA0KPiB8ICAgICAgICAvKiB0
byBwcmV2ZW50IGZha2Ugc3RhY2sgY2hlY2sgZmFpbHVyZSBpbiBjbG9jayBzZXR1cCAqLw0KPiB8
ICAgICAgICBib290X2luaXRfc3RhY2tfY2FuYXJ5KCk7DQo+IHwNCj4gfCAgICAgICAgeDg2X2Nw
dWluaXQuc2V0dXBfcGVyY3B1X2Nsb2NrZXYoKTsNCj4gfA0KPiB8ICAgICAgICB3bWIoKTsNCj4g
fCAgICAgICAgY3B1X3N0YXJ0dXBfZW50cnkoQ1BVSFBfQVBfT05MSU5FX0lETEUpOw0KPiANCj4g
VGhlIGNhbGwgdG8gY3B1X3N0YXJ0dXBfZW50cnkoKSBkb2VzIG5vdCBzdWNjZWVkLCBpbnN0ZWFk
DQo+IGl0IGp1bXBzIHRvIF9fc3RhY2tfY2hrX2ZhaWwoKSBmcm9tIHRoZXJlLg0KDQpIYXNuJ3Qg
dGhpcyBhbHJlYWR5IGJlZW4gZml4ZWQ/DQpBZGQ6DQoJCWFzbSgiIik7DQphZnRlciBjcHVfc3Rh
cnR1cF9lbnRyeSgpIHRvIHN0b3AgaXQgYmVpbmcgdGFpbC1jYWxsZWQuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

