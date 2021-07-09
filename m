Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89323C2763
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jul 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGIQSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jul 2021 12:18:33 -0400
Received: from smtp.aic.fr ([195.13.32.122]:43988 "EHLO smtp-out02.aic.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIQSc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jul 2021 12:18:32 -0400
Received: from webmail.cube-technologies.net (unknown [93.191.42.150])
        by smtp-out02.aic.fr (Postfix) with ESMTP id 73DA452A;
        Fri,  9 Jul 2021 18:15:42 +0200 (CEST)
Received: from Cube-mail.cube.local (192.168.3.242) by Cube-mail.cube.local
 (192.168.3.242) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 9 Jul
 2021 18:15:24 +0200
Received: from Cube-mail.cube.local ([::1]) by Cube-mail.cube.local ([::1])
 with mapi id 15.00.0847.040; Fri, 9 Jul 2021 18:15:24 +0200
From:   Vincent RUBY <vruby@cube-technologies.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
Thread-Topic: Kernel crash when scanning for APs in huge WiFi environment -
 Ath10K - ARMV7 - Linux 4.14.73
Thread-Index: Add00g30B+V1wjYvQ12HCt8vs0rm9wAB60sA///hoYD//9t44A==
Date:   Fri, 9 Jul 2021 16:15:23 +0000
Message-ID: <2eb86fb560cc482fa63bf42fafb97922@Cube-mail.cube.local>
References: <1cef8054e4e447f2ba02d1de1e6afdf8@Cube-mail.cube.local>
 <e23f3f12dcab42ea9ab4b7384080cdf2@Cube-mail.cube.local>
 <c2f66f16-3800-b127-4c58-704a29ec693d@candelatech.com>
In-Reply-To: <c2f66f16-3800-b127-4c58-704a29ec693d@candelatech.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.3.53]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhhbmsgeW91IEJlbiBmb3IgeW91ciBxdWljayByZXBseS4NCg0KVW5mb3J0dW5hdGVseSwgd2hl
biB0aGUgc3lzdGVtIGNyYXNoZXMsIHRoZXJlIGlzIG5vIGRldGFpbC4gTm8gdHJhY2Ugb3IgbG9n
IGNhbiBiZSByZXRyaWV2ZWQsIGV2ZW4gaW4gZG1lc2cuDQpJdCBpcyBzaW1wbHkgcmVib290aW5n
Lg0KDQpUcnlpbmcgYSBuZXdlciBrZXJuZWwgaXMgbm90IGVhc3kgc2luY2Ugd2UgYXJlIGhhcmR3
YXJlIGRyaXZlciBkZXBlbmRlbnQuDQoNClZpbmNlQ3ViZQ0KDQotLS0tLU1lc3NhZ2UgZCdvcmln
aW5lLS0tLS0NCkRlwqA6IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPiANCkVu
dm95w6nCoDogdmVuZHJlZGkgOSBqdWlsbGV0IDIwMjEgMTc6NTkNCsOAwqA6IFZpbmNlbnQgUlVC
WSA8dnJ1YnlAY3ViZS10ZWNobm9sb2dpZXMubmV0PjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnDQpPYmpldMKgOiBSZTogS2VybmVsIGNyYXNoIHdoZW4gc2Nhbm5pbmcgZm9yIEFQcyBp
biBodWdlIFdpRmkgZW52aXJvbm1lbnQgLSBBdGgxMEsgLSBBUk1WNyAtIExpbnV4IDQuMTQuNzMN
Cg0KT24gNy85LzIxIDg6NDggQU0sIFZpbmNlbnQgUlVCWSB3cm90ZToNCj4gSGksDQo+IA0KPiBJ
IGFwb2xvZ2l6ZSBpbiBhZHZhbmNlIGlmIEkgYW0gd3JpdGluZyBhdCB0aGUgd3JvbmcgcGxhY2Uu
DQo+IFdlIGhhdmUgZGV2ZWxvcGVkIGEgY3VzdG9tIGVtYmVkZGVkIGJvYXJkIGJhc2VkIG9uIEFS
TVY3LiBPbiB0aGUgYm9hcmQgdGhlcmUgaXMgYSBUZWxpdCBXRTg2NkMzLVAgV2lmaSBtb2R1bGUg
KGJhc2VkIG9uIGF0aDEwaykuDQo+IExpbnV4IDogNC4xNC43MyAoWU9DVE8vcG9reSkNCj4gTWlj
cm9jb250cm9sbGVyIDogU0FNQTVEMjcNCj4gDQo+IFRoZSBib2FyZCBpcyB3b3JraW5nIHBlcmZl
Y3RseSBpbiBhIG5vcm1hbCBXaWZpIGVudmlyb25tZW50IChlLmcuLCBhdCBvZmZpY2UpLg0KPiBC
dXQgd2hlbiB0aGUgYm9hcmQgaXMgcHV0IGluIGEgaHVnZSBXaWZpIGVudmlyb25tZW50IChlLmcu
LCAzNTAgQVBzIHdpdGggMiBhbnRlbm5hcyBlYWNoIHdpdGggbW9yZSB0aGFuIDYwMCB2aXNpYmxl
IEJTU0lEUykgdGhlIExpbnV4IGtlcm5lbCBjcmFzaGVzIHdoZW4gYXR0ZW1wdGluZyB0byBjb25u
ZWN0IHRvIGEgV2lmaSBuZXR3b3JrIHVzaW5nIHdwYV9zdXBwbGljYW50Lg0KPiBXaGVuIHRoZSBX
aWZpIGFudGVubmEgaXMgYXR0ZW51YXRlZCB3aXRoIHNvbWUgZWxlY3Ryb21hZ25ldGljIG9ic3Rh
Y2xlIChlLmcuLCBoYW5kIG9yIG1ldGFsbGljIHNoaWVsZCksIHRoZSBib2FyZCBjb25uZWN0cyB3
aXRob3V0IGFueSBwcm9ibGVtLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhlIHNhbWUgd2hlbiBy
dW5uaW5nIGEgc2NhbiBmcm9tIHdwYV9jbGkgLg0KPiANCj4gRG8geW91IGhhdmUgYW55IGlkZWEg
d2hlcmUgSSBjYW4gZmluZCBzb21lIGNsdWUgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlPw0KPiANCj4g
TWFueSB0aGFua3MgaW4gYWR2YW5jZSAhDQo+IA0KPiBWaW5jZUN1YmUNCj4gDQoNClBsZWFzZSBz
aG93IHRoZSBkZXRhaWxzIG9mIHRoZSBrZXJuZWwgY3Jhc2guICBBbmQgZWl0aGVyIHdheSwgYW5z
d2VyIGlzIHByb2JhYmx5IHRvIHRyeSBtb3JlIHJlY2VudCBrZXJuZWwgYW5kIHNlZSBpZiBwcm9i
bGVtIGlzIGFscmVhZHkgZml4ZWQuDQoNClRoYW5rcywNCkJlbg0KDQotLQ0KQmVuIEdyZWVhciA8
Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+DQpDYW5kZWxhIFRlY2hub2xvZ2llcyBJbmMgIGh0dHA6
Ly93d3cuY2FuZGVsYXRlY2guY29tDQoNCg==
