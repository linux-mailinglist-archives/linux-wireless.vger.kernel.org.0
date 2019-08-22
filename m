Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B09896D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfHVC0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 22:26:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41467 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfHVC0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 22:26:15 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7M2Q6rF009795, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7M2Q6rF009795
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 22 Aug 2019 10:26:06 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 22 Aug
 2019 10:26:06 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jano.vesely@gmail.com" <jano.vesely@gmail.com>
Subject: RE: [PATCH] rtw88: pci: enable MSI interrupt
Thread-Topic: [PATCH] rtw88: pci: enable MSI interrupt
Thread-Index: AQHVRsz7S+hWGWZ+/EW68pA5j53xh6bjDjWAgADwiMCADQCTAIAUcNlQ
Date:   Thu, 22 Aug 2019 02:26:05 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18A6A16@RTITMBSVM04.realtek.com.tw>
References: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
 <20190730195703.GA224792@google.com>
 <F7CD281DE3E379468C6D07993EA72F84D18855BB@RTITMBSVM04.realtek.com.tw>
 <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
In-Reply-To: <CA+ASDXPFVHaXM_5VtWNeTW8mPSZi6EX9JYoJRn4RTygA6iKQpg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gT24gQmVoYWxmIE9mIEJyaWFuIE5vcnJpcw0KPiBPbiBUaHUsIEF1ZyAxLCAyMDE5IGF0
IDI6MjEgQU0gVG9ueSBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiB3cm90ZToNCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJ0dzg4OiBwY2k6IGVuYWJsZSBNU0kgaW50ZXJydXB0
DQo+ID4gPiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAwNzo1MDoxNFBNICswODAwLCB5aGNodWFu
Z0ByZWFsdGVrLmNvbQ0KPiB3cm90ZToNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+ID4gPiA+IEBAIC04NzQsNiArODc4LDcgQEAgc3RhdGlj
IGlycXJldHVybl90IHJ0d19wY2lfaW50ZXJydXB0X2hhbmRsZXIoaW50DQo+IGlycSwNCj4gPiA+
IHZvaWQgKmRldikNCj4gPiA+ID4gICAgIGlmICghcnR3cGNpLT5pcnFfZW5hYmxlZCkNCj4gPiA+
ID4gICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICBydHdfcGNpX2Rp
c2FibGVfaW50ZXJydXB0KHJ0d2RldiwgcnR3cGNpKTsNCj4gPiA+DQo+ID4gPiBXaHkgZXhhY3Rs
eSBkbyB5b3UgaGF2ZSB0byBtYXNrIGludGVycnVwdHMgZHVyaW5nIHRoZSBJU1I/IElzIHRoZXJl
IGENCj4gPiA+IHJhY2UgaW4gcnR3X3BjaV9pcnFfcmVjb2duaXplZCgpIG9yIHNvbWV0aGluZz8N
Cj4gPg0KPiA+DQo+ID4gSSB0aGluayB0aGVyZSBpcyBhIHJhY2UgYmV0d2VlbiBTVyBhbmQgSFcs
IGlmIHdlIGRvIG5vdCBzdG9wIHRoZQ0KPiA+IElSUSBmaXJzdCwgd3JpdGUgMSBjbGVhciB3aWxs
IG1ha2UgdGhlIGludGVycnVwdCB0byBiZSBsb3N0Lg0KPiANCj4gVGhpcyBkb2Vzbid0IG5lZWQg
dG8gc2xvdyBkb3duIHRoaXMgcGF0Y2ggKEkgdGhpbmsgdjIgaXMgZmluZSksIGJ1dCBJDQo+IHN0
aWxsIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQuIEJlZm9yZSB0aGlzIGFkZGl0aW9uLCB0aGUgc2Vx
dWVuY2UgaXM6DQo+IChhKSByZWFkIG91dCB5b3VyIElSUSBzdGF0dXMNCj4gKGIpIGFjayB0aGUg
dW4tbWFza2VkIElSUXMgeW91IHNlZQ0KPiAoYykgb3BlcmF0ZSBvbiB0aG9zZSBJUlFzDQo+IA0K
PiBFdmVuIGlmIGEgbmV3IElSUSBjb21lcyBpbiB0aGUgbWlkZGxlIG9mIChiKSwgc2hvdWxkbid0
IGl0IGJlDQo+IHN1ZmZpY2llbnQgdG8gbW92ZSBvbiB0byAoYyksIHdoZXJlIHlvdSdyZSBzdGls
bCBwcmVwYXJlZCB0byBoYW5kbGUNCj4gdGhhdCBJUlE/DQo+IA0KPiBPciBpZiB0aGUgSVJRIGNv
bWVzIGFmdGVyIChiKSwgeW91IHdvbid0IEFDSyBpdCwgYW5kIHlvdSBzaG91bGQNCj4gaW1tZWRp
YXRlbHkgZ2V0IGEgbmV3IElSUSBhZnRlciB5b3UgcmV0dXJuPw0KDQpJIHRoaW5rIGl0J3MgYmVj
YXVzZSB0aGF0IE1TSSBpbnRlcnJ1cHRzIGFyZSBlZGdlLXRyaWdnZXJlZC4NCklmIHRoZSBpbnRl
cnJ1cHQgY29tZXMgd2hlbiBJUlEgaXMgYmVpbmcgcHJvY2Vzc2VkLCB0aGUgaW50ZXJydXB0IHdv
bid0IGJlIHJlY2VpdmVkLg0KSWYgdGhlIGludGVycnVwdCBpcyBub3QgcmVjZWl2ZWQsIHRoZSBp
bnRlcnJ1cHQgd29uJ3QgYmUgV3JpdGUtMS1DbGVhcmVkLCBhbmQgd29uJ3QgYmUgZmlyZWQgYWdh
aW4uDQoNClNvIGRyaXZlciBzaG91bGQgZGlzYWJsZSB0aGUgaW50ZXJydXB0IHVudGlsIHRoZSBJ
U1JzIGFyZSBkb25lLg0KDQo+IA0KPiBJIGd1ZXNzIHRoYXQncyBhc3N1bWluZyB0aGF0IHRoZXNl
IHJlZ2lzdGVycyBhcmUgV3JpdGUgMSB0byBDbGVhci4gQnV0DQo+IGlmIHNvLCB0aGF0IG1lYW5z
IHJ0d19wY2lfaXJxX3JlY29nbml6ZWQoKSBpcyBlZmZlY3RpdmVseSBhdG9taWMsIG5vPw0KPiAN
Cj4gQWxzbywgc29tZXdoYXQgdW5yZWxhdGVkOiBidXQgd2h5IGRvIHlvdSB1bm1hc2sgSElNUjEs
IHdoZW4geW91J3JlIG5vdA0KPiBhY3R1YWxseSBoYW5kbGluZyBhbnkgb2YgaXRzIElSUSBiaXRz
Pw0KDQpXZSBjb3VsZCB1c2UgSElNUjEsIGp1c3Qgbm90IGhhbmRsaW5nIGFueSBvZiB0aGVtIG5v
dyA6KQ0KDQo+IA0KPiBCcmlhbg0KPiANCg0KWWFuLUhzdWFuDQo=
