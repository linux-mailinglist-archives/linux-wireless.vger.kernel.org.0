Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC231D29BE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgENILQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 04:11:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51400 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgENILQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 04:11:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-94-pPKAQ0JRPGmhyT1OD-2rfA-1; Thu, 14 May 2020 09:11:13 +0100
X-MC-Unique: pPKAQ0JRPGmhyT1OD-2rfA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 14 May 2020 09:11:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 14 May 2020 09:11:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: gcc-10: kernel stack is corrupted and fails to boot
Thread-Topic: gcc-10: kernel stack is corrupted and fails to boot
Thread-Index: AQHWKZY6Y215XsBMzU2jywoKX8cjPqinObQQ
Date:   Thu, 14 May 2020 08:11:12 +0000
Message-ID: <d907ef9d30bc4169bf1e923fb066f7a1@AcuMS.aculab.com>
References: <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic>
 <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
 <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
 <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
 <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTQgTWF5IDIwMjAgMDM6MjANCj4gT24gV2Vk
LCBNYXkgMTMsIDIwMjAgYXQgNTo1MSBQTSBOaWNrIERlc2F1bG5pZXJzDQo+IDxuZGVzYXVsbmll
cnNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBcmUgeW91IHN1cmUgTFRPIHRyZWF0cyBl
bXB0eSBhc20gc3RhdGVtZW50cyBkaWZmZXJlbnRseSB0aGFuIGZ1bGwNCj4gPiBtZW1vcnkgYmFy
cmllcnMgaW4gcmVnYXJkcyB0byBwcmV2ZW50aW5nIHRhaWwgY2FsbHM/DQo+IA0KPiBJdCBoYWQg
YmV0dGVyLg0KPiANCj4gQXQgbGluay10aW1lLCB0aGVyZSBpcyBub3RoaW5nIGxlZnQgb2YgYW4g
ZW1wdHkgYXNtIHN0YXRlbWVudC4gU28gYnkNCj4gdGhlIHRpbWUgdGhlIGxpbmtlciBydW5zLCBp
dCBvbmx5IHNlZXMNCj4gDQo+ICAgICBjYWxsIHh5eg0KPiAgICAgcmV0DQo+IA0KPiBpbiB0aGUg
b2JqZWN0IGNvZGUuIEF0IHRoYXQgcG9pbnQsIGl0J3Mgc29tZXdoYXQgcmVhc29uYWJsZSBmb3Ig
YW55DQo+IGxpbmstdGltZSBvcHRpbWl6ZXIgKG9yIGFuIG9wdGltaXppbmcgYXNzZW1ibGVyLCBm
b3IgdGhhdCBtYXR0ZXIpIHRvDQo+IHNheSAiSSdsbCBqdXN0IHR1cm4gdGhhdCBzZXF1ZW5jZSBp
bnRvIGEgc2ltcGxlICdqbXAgeHl6JyBpbnN0ZWFkIi4NCg0KRXhjZXB0IGlzIHNlZXM6DQoJY2Fs
bCB4eXoNCgljYW5hcnlfY2hlY2tfY29kZQ0KCXJldA0KDQpUaGVyZSdzIGFsc28gYWxtb3N0IGNl
cnRhaW5seSBzb21lIHN0YWNrIGZyYW1lIHRpZHl1cC4NCldoaWNoIGl0IHdvdWxkIGhhdmUgdG8g
ZGV0ZWN0IGFuZCBjb252ZXJ0Lg0KQW5kLCBpbiBwcmluY2lwbGUsIHRoZSBmdW5jdGlvbiBpcyBh
bGxvd2VkIHRvIGFjY2VzcyB0aGUNCnN0YWNrIHNwYWNlIHRoYW4gY29udGFpbnMgdGhlIGNhbmFy
eS4NCg0KPiBOb3csIGRvbid0IGdldCBtZSB3cm9uZyAtIEknbSBub3QgY29udmluY2VkIGFueSBl
eGlzdGluZyBMVE8gZG9lcw0KPiB0aGF0LiBCdXQgSSdkIGFsc28gbm90IGJlIHNob2NrZWQgYnkg
c29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gDQo+IEluIGNvbnRyYXN0LCBpZiBpdCdzIGEgcmVhbCBt
YigpLCB0aGUgbGlua2VyIHdvbid0IHNlZSBqdXN0IGENCj4gJ2NhbGwrcmV0IiBzZXF1ZW5jZS4g
SXQgd2lsbCBzZWUgc29tZXRoaW5nIGxpa2UNCj4gDQo+ICAgICBjYWxsIHh5eg0KPiAgICAgbWZl
bmNlDQo+ICAgICByZXQNCj4gDQo+IChvaywgdGhlIG1mZW5jZSBtYXkgYWN0dWFsbHkgYmUgc29t
ZXRoaW5nIGVsc2UsIGFuZCB3ZSdsbCBoYXZlIGEgbGFiZWwNCj4gb24gaXQgYW5kIGFuIGFsdGVy
bmF0aXZlcyB0YWJsZSBwb2ludGluZyB0byBpdCwgYnV0IHRoZSBwb2ludCBpcywNCj4gdW5saWtl
IGFuIGVtcHR5IGFzbSwgdGhlcmUncyBzb21ldGhpbmcgX3RoZXJlXykuDQoNCk5vdCBpZiB5b3Un
dmUgYW4gYXJjaGl0ZWN0dXJlIHRoYXQgZG9lc24ndCBoYXZlIGFueSBtZW1vcnkgYmFycmllcnMu
DQpJbiB0aGF0IGNhc2UgbWIoKSBtYXkgbm90IGV2ZW4gYmUgYXNtKCIiKS4NCihhbHRob3VnaCBp
dCBtaWdodCBoYXZlIHRvIGJlIGFzbSAoIiI6OjptZW1vcnkpKS4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

