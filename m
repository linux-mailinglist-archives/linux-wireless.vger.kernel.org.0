Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF845FCA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfFNN65 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 09:58:57 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.213]:42747 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbfFNN65 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:57 -0400
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id CD/92-05637-F18A30D5; Fri, 14 Jun 2019 13:58:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRWlGSWpSXmKPExsXi5LtOQFduBXO
  swf65+hYfN3xisXiz4g67A5NHf+82Fo/Pm+QCmKJYM/OS8isSWDM+dK5iL+i2rDi67j5LA+Ma
  iy5GLg4hgdWMEg8f9jFBOHsZJd5d2MrcxcjJwSZgKLF6wRF2EFtEQFfi4qTbLCA2s4CrxJn7r
  8FqhAWiJRbOnsUEURMjceraAxYI20piw9X5YHEWAVWJbTe2MoLYvALWEts3vgOLCwnkSjw8/g
  1sPqeAn8S0V0/AZjIKyEq8aJ/ABLFLXOLWE4g5EgICEkv2nGeGsEUlXj7+xwpiiwqES0xc9Qc
  qriDR19kNZHMA9WpKrN+lDzHGXKL73GdWCFtRYkr3Q3aIcwQlTs58wgJxjorEtindbBMYxWch
  2TwLYdIsJJNmIZk0C8mkBYysqxgtkooy0zNKchMzc3QNDQx0DQ2NdA2NTYC0mV5ilW6SXmmxb
  nlqcYmukV5iebFecWVuck6KXl5qySZGYJymFLSV7GDcf+C13iFGSQ4mJVFe5xLmWCG+pPyUyo
  zE4oz4otKc1OJDjDIcHEoSvMzLgHKCRanpqRVpmTnAlAGTluDgURLhTQZJ8xYXJOYWZ6ZDpE4
  xGnNMeDl3ETPHkblLFzELseTl56VKifMWgZQKgJRmlObBDYKlskuMslLCvIwMDAxCPAWpRbmZ
  JajyrxjFORiVhHlngkzhycwrgdv3CugUJqBTZm1gAjmlJBEhJdXAZFX1fprj04OFCzj85Nd7e
  EuaR2svPiDPECZ29rSJ1VulhbLZ8mt/8P5+wrnjzrvg5e/NTr9WuahUyXtsbZ7CqbOvPSd/7E
  g+fETc8bs3n11CcrFsqZiypf12i413H2/IiPm/LHC7xdt8+yzPL3oe9+V3WPUHmmpHK3f4W1Y
  vaJs4geHXq20HaoTPX3mdvPm1WYtVlbZi3KV1aVqHhC4F8s1/oTCx4bmmSL7PBxnHgheMb1J1
  rXv2hByJF3pUUndXW3j39cV1S3I6r6WuuHtmetb80hUODJdPfWJVqrFiO9OidY+h3/+h33atm
  OP1M59t9vb2yrdscmmNvJ++/SuXh9/FXqeKMw9OLvy+SeycEktxRqKhFnNRcSIAd0W0L+ADAA
  A=
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-13.tower-345.messagelabs.com!1560520733!35105!4
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19479 invoked from network); 14 Jun 2019 13:58:54 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-13.tower-345.messagelabs.com with SMTP; 14 Jun 2019 13:58:54 -0000
Received: from MTK-SMS-XCH05.digi.com (10.10.8.199) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 14 Jun 2019
 08:58:49 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH05.digi.com ([fe80::a576:56af:8463:b976%15]) with mapi id
 14.03.0415.000; Fri, 14 Jun 2019 08:58:49 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
Thread-Topic: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
Thread-Index: AQHVIrNP/gN6lxCOEkmu6xBChwu2HqabeTaAgAAHxgA=
Date:   Fri, 14 Jun 2019 13:58:48 +0000
Message-ID: <32951d52-3f9d-aaee-fa07-75585c03edba@digi.com>
References: <20190614131600.GA13897@a1-hr>
 <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
In-Reply-To: <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [172.27.2.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <37BAE3718B01634A85F93A873CD1A03E@digi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCipGcm9tOiogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldD4NCipTZW50OiogRnJpZGF5LCBKdW5lIDE0LCAyMDE5IDM6MzBQTQ0KKlRvOiog
SG9kYXN6aSwgUm9iZXJ0IDxSb2JlcnQuSG9kYXN6aUBkaWdpLmNvbT4NCipDYzoqIExpbnV4LXdp
cmVsZXNzIDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+DQoqU3ViamVjdDoqIFJlOiBb
UEFUQ0ggdjJdIFJldmVydCAiY2ZnODAyMTE6IGZpeCBwcm9jZXNzaW5nIHdvcmxkIA0KcmVnZG9t
YWluIHdoZW4gbm9uIG1vZHVsYXIiDQoNCj4gT24gRnJpLCAyMDE5LTA2LTE0IGF0IDEzOjE2ICsw
MDAwLCBIb2Rhc3ppLCBSb2JlcnQgd3JvdGU6DQo+PiBUaGlzIHJldmVydHMgY29tbWl0IDk2Y2Nl
MTJmZjZlMGJjOWQ5ZmNiMjIzNWUwOGI3ZmMxNTBmOTZmZDIuDQo+Pg0KPj4gUmUtdHJpZ2dlcmlu
ZyBhIHJlZ19wcm9jZXNzX2hpbnQgd2l0aCB0aGUgbGFzdCByZXF1ZXN0IG9uIGFsbCBldmVudHMs
DQo+PiBjYW4gbWFrZSB0aGUgcmVndWxhdG9yeSBkb21haW4gZmFpbCBpbiBjYXNlIG9mIG11bHRp
cGxlIFdpRmkgbW9kdWxlcy4gT24NCj4+IHNsb3dlciBib2FyZHMgKGVzcGFjaWFsbHkgd2l0aCBt
ZGV2KSwgZW51bWVyYXRpb24gb2YgdGhlIFdpRmkgbW9kdWxlcw0KPj4gY2FuIGVuZCB1cCBpbiBh
biBpbnRlcnNlY3RlZCByZWd1bGF0b3J5IGRvbWFpbiwgYW5kIHVzZXIgY2Fubm90IHNldCBpdA0K
Pj4gd2l0aCAnaXcgcmVnIHNldCcgYW55bW9yZS4NCj4+DQo+PiBUaGlzIGlzIGhhcHBlbmluZywg
YmVjYXVzZToNCj4+IC0gMXN0IG1vZHVsZSBlbnVtZXJhdGVzLCBxdWV1ZXMgdXAgYSByZWd1bGF0
b3J5IHJlcXVlc3QNCj4+IC0gcmVxdWVzdCBnZXRzIHByb2Nlc3NlZCBieSBfX3JlZ19wcm9jZXNz
X2hpbnRfZHJpdmVyKCk6DQo+PiAgICAtIGNoZWNrcyBpZiBwcmV2aW91cyB3YXMgc2V0IGJ5IENP
UkUgLT4geWVzDQo+PiAgICAgIC0gY2hlY2tzIGlmIHJlZ3VsYXRvciBkb21haW4gY2hhbmdlZCAt
PiB5ZXMsIGZyb20gJzAwJyB0byBlLmcuICdVUycNCj4+ICAgICAgICAtPiBzZW5kcyByZXF1ZXN0
IHRvIHRoZSAnY3JkYScNCj4+IC0gMm5kIG1vZHVsZSBlbnVtZXJhdGVzLCBxdWV1ZXMgdXAgYSBy
ZWd1bGF0b3IgcmVxdWVzdCAod2hpY2ggdHJpZ2dlcnMNCj4+IHRoZSByZWdfdG9kbygpIHdvcmsp
DQo+PiAtIHJlZ190b2RvKCkgLT4gcmVnX3Byb2Nlc3NfcGVuZGluZ19oaW50cygpIHNlZXMsIHRo
YXQgdGhlIGxhc3QgcmVxdWVzdA0KPj4gaXMgbm90IHByb2Nlc3NlZCB5ZXQsIHNvIGl0IHRyaWVz
IHRvIHByb2Nlc3MgaXQgYWdhaW4uDQo+PiBfX3JlZ19wcm9jZXNzX2hpbnQgZHJpdmVyKCkgd2ls
bCBydW4gYWdhaW4sIGFuZDoNCj4+ICAgIC0gY2hlY2tzIGlmIHRoZSBsYXN0IHJlcXVlc3QncyBp
bml0aWF0b3Igd2FzIHRoZSBjb3JlIC0+IG5vLCBpdCB3YXMNCj4+IHRoZSBkcml2ZXIgKDFzdCBX
aUZpIG1vZHVsZSkNCj4+ICAgIC0gY2hlY2tzLCBpZiB0aGUgcHJldmlvdXMgaW5pdGlhdG9yIHdh
cyB0aGUgZHJpdmVyIC0+IHllcw0KPj4gICAgICAtIGNoZWNrcyBpZiB0aGUgcmVndWxhdG9yIGRv
bWFpbiBjaGFuZ2VkIC0+IHllcywgaXQgd2FzICcwMCcgKHNldCBieQ0KPj4gY29yZSwgYW5kIGNy
ZGEgY2FsbCBkaWQgbm90IHJldHVybiB5ZXQpLCBhbmQgc2hvdWxkIGJlIGNoYW5nZWQgdG8gJ1VT
Jw0KPj4NCj4+IC0tLS0tLT4gX19yZWdfcHJvY2Vzc19oaW50X2RyaXZlciBjYWxscyBhbiBpbnRl
cnNlY3QNCj4+DQo+PiBCZXNpZGVzLCB0aGUgcmVnX3Byb2Nlc3NfaGludCBjYWxsIHdpdGggdGhl
IGxhc3QgcmVxdWVzdCBpcyBtZWFuaW5nbGVzcw0KPj4gc2luY2UgdGhlIGNyZGEgY2FsbCBoYXMg
YSB0aW1lb3V0IHdvcmsuIElmIHRoYXQgdGltZW91dCBleHBpcmVzLCB0aGUNCj4+IGZpcnN0IG1v
ZHVsZSdzIHJlcXVlc3Qgd2lsbCBsb3N0Lg0KPiBJdCdzIHBvaW50bGVzcyB0byByZXNlbmQgd2hl
biBJIHN0aWxsIGhhdmUgdGhlIG9yaWdpbmFsIHBhdGNoIHBlbmRpbmcsDQo+IGF0IGxlYXN0IHdp
dGhvdXQgYW55IGNoYW5nZXMuDQo+DQo+IFRoYXQgc2FpZCwgSSBsb29rZWQgYXQgdGhpcyB0b2Rh
eSBhbmQgSSdtIG5vdCBzdXJlIGhvdyB0aGUgY29kZSBkb2Vzbid0DQo+IG5vdyBoYXZlIHRoZSBv
cmlnaW5hbCBpc3N1ZSBhZ2Fpbj8NCj4NCj4gam9oYW5uZXMNCj4NCg0KSSBkaWRuJ3QganVzdCBy
ZXNlbmQgdGhhdC4gSSBqdXN0IHJlYWxpemVkLCBhY2NpZGVudGFsbHkgSSBmb3Jnb3QgdG8gZml4
IA0KdGhlIGRlYnVnIG1lc3NhZ2UgcHJpbnRpbmcgZnVuY3Rpb24sIHRoYXQgZGVmaW5lIGRvZXNu
J3QgZXhpc3QgYW55bW9yZS4gDQpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbiENCg0KVW5kZXIgIm9y
aWdpbmFsIGlzc3VlIiwgeW91IG1lYW4gdGhlIGlzc3VlLCB3aGljaCBjb21taXQgDQo5NmNjZTEy
ZmY2ZTBiYzlkOWZjYjIyMzVlMDhiN2ZjMTUwZjk2ZmQyIChjZmc4MDIxMTogZml4IHByb2Nlc3Np
bmcgd29ybGQgDQpyZWdkb21haW4gd2hlbiBub24gbW9kdWxhcikgc3VwcG9zZWQgdG8gZml4PyBU
aGF0IHN0aWxsIHdvbid0IHdvcmssIGJ1dCANCnRoYXQgZGlkbid0IHdvcmsgbmVpdGhlciBiZWZv
cmUgSSByZXZlcnRlZCB0aGUgcGF0Y2gsIGJlY2F1c2UgY3JkYSBjYWxsIA0KdGltZW91dCB3aWxs
IGp1c3QgZHJvcCB0aGUgbGFzdCBwYWNrZXQuIEFsc28sIGFzIGl0IHJlLXByb2Nlc3NlZCB0aGUg
DQpsYXN0IHJlcXVlc3QsIG5vdCBqdXN0IHJlc2VudCBpdCwgaXQgY2F1c2VkIHVuZGVzaXJlZCBz
dGF0ZXMuIExpa2Ugd2hlbiANCkkgdXNlZCAyIFdpRmkgbW9kdWxlcyB3aXRoIFVTIHJlZ3VsYXRv
cnkgZG9tYWlucywgYWZ0ZXIgZW51bWVyYXRpb24sIG15IA0KZ2xvYmFsIHJlZ3VsYXRvciBkb21h
aW4gd2FzIHNldCB0byAiQ291bnRyeSA5OCIuDQoNClRvIGZpeCBteSBpc3N1ZSwgd2h5IEkgcmV2
ZXJ0ZWQgdGhlIHBhdGNoLCBhbmQgYWxzbyBmaXggdGhlIGlzc3VlIHRoZSANCnJldmVydGVkIGNv
bW1pdCBzdXBwb3NlZCB0byBmaXgsIEkgY291bGQgaW1hZ2luZSBzb21ldGhpbmcgbGlrZSB0aGlz
LiANCkJ1dCBJJ20gbm90IHN1cmUsIGl0IGRvZXNuJ3QgaGF2ZSBhbnkgc2lkZSBlZmZlY3Q6DQoN
CmRpZmYgLS1naXQgYS9saW51eC9uZXQvd2lyZWxlc3MvcmVnLmMgYi9saW51eC9uZXQvd2lyZWxl
c3MvcmVnLmMNCmluZGV4IDZmZGIwMWIyMGIuLjEzZDU2NDU1OGQgMTAwNjQ0DQotLS0gYS9saW51
eC9uZXQvd2lyZWxlc3MvcmVnLmMNCisrKyBiL2xpbnV4L25ldC93aXJlbGVzcy9yZWcuYw0KQEAg
LTI3OTgsNyArMjc5OCw4IEBAIHN0YXRpYyB2b2lkIHJlZ19wcm9jZXNzX3BlbmRpbmdfaGludHMo
dm9pZCkNCg0KZGlmZiAtLWdpdCBhL2xpbnV4L25ldC93aXJlbGVzcy9yZWcuYyBiL2xpbnV4L25l
dC93aXJlbGVzcy9yZWcuYw0KaW5kZXggNmZkYjAxYjIwYi4uMTNkNTY0NTU4ZCAxMDA2NDQNCi0t
LSBhL2xpbnV4L25ldC93aXJlbGVzcy9yZWcuYw0KKysrIGIvbGludXgvbmV0L3dpcmVsZXNzL3Jl
Zy5jDQpAQCAtMjc5OCw3ICsyNzk4LDggQEAgc3RhdGljIHZvaWQgcmVnX3Byb2Nlc3NfcGVuZGlu
Z19oaW50cyh2b2lkKQ0KDQogwqDCoMKgwqDCoMKgwqAgLyogV2hlbiBsYXN0X3JlcXVlc3QtPnBy
b2Nlc3NlZCBiZWNvbWVzIHRydWUgdGhpcyB3aWxsIGJlIA0KcmVzY2hlZHVsZWQgKi8NCiDCoMKg
wqDCoMKgwqDCoCBpZiAobHIgJiYgIWxyLT5wcm9jZXNzZWQpIHsNCi3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlZ19wcm9jZXNzX2hpbnQobHIpOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFyZWdfcXVlcnlfZGF0YWJhc2UobHIpKQ0KK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZ19mcmVlX3JlcXVlc3QobHIpOw0KIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQogwqDCoMKgwqDCoMKgwqAgfQ0KDQpA
QCAtMzE3NSw2ICszMTc2LDcgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9yZWd1bGF0b3J5X3NldHRp
bmdzKGJvb2wgDQpyZXNldF91c2VyLCBib29sIGNhY2hlZCkNCiDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgcmVnX2JlYWNvbiAqcmVnX2JlYWNvbiwgKmJ0bXA7DQogwqDCoMKgwqDCoMKgwqAgTElTVF9I
RUFEKHRtcF9yZWdfcmVxX2xpc3QpOw0KIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjZmc4MDIxMV9y
ZWdpc3RlcmVkX2RldmljZSAqcmRldjsNCivCoMKgwqDCoMKgwqAgc3RydWN0IHJlZ3VsYXRvcnlf
cmVxdWVzdCAqbHI7DQoNCiDCoMKgwqDCoMKgwqDCoCBBU1NFUlRfUlROTCgpOw0KDQpAQCAtMzE5
MCw2ICszMTkyLDEzIEBAIHN0YXRpYyB2b2lkIHJlc3RvcmVfcmVndWxhdG9yeV9zZXR0aW5ncyhi
b29sIA0KcmVzZXRfdXNlciwgYm9vbCBjYWNoZWQpDQogwqDCoMKgwqDCoMKgwqAgfQ0KIMKgwqDC
oMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZyZWdfaW5kb29yX2xvY2spOw0KDQorwqDCoMKgwqDCoMKg
IC8qIElmIGxhc3QgcmVxdWVzdCBpcyBwZW5kaW5nLCBzYXZlIGl0LCB3aWxsIHJlc3VibWl0IGl0
ICovDQorwqDCoMKgwqDCoMKgIGxyID0gZ2V0X2xhc3RfcmVxdWVzdCgpOw0KK8KgwqDCoMKgwqDC
oCBpZiAobHIgJiYgIWxyLT5wcm9jZXNzZWQpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByY3VfYXNzaWduX3BvaW50ZXIobGFzdF9yZXF1ZXN0LCBOVUxMKTsNCivCoMKgwqDCoMKgwqAg
ZWxzZQ0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbHIgPSBOVUxMOw0KKw0KIMKgwqDC
oMKgwqDCoMKgIHJlc2V0X3JlZ2RvbWFpbnModHJ1ZSwgJndvcmxkX3JlZ2RvbSk7DQogwqDCoMKg
wqDCoMKgwqAgcmVzdG9yZV9hbHBoYTIoYWxwaGEyLCByZXNldF91c2VyKTsNCg0KQEAgLTMyNjcs
NiArMzI3Niw5IEBAIHN0YXRpYyB2b2lkIHJlc3RvcmVfcmVndWxhdG9yeV9zZXR0aW5ncyhib29s
IA0KcmVzZXRfdXNlciwgYm9vbCBjYWNoZWQpDQogwqDCoMKgwqDCoMKgwqAgbGlzdF9zcGxpY2Vf
dGFpbF9pbml0KCZ0bXBfcmVnX3JlcV9saXN0LCAmcmVnX3JlcXVlc3RzX2xpc3QpOw0KIMKgwqDC
oMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZyZWdfcmVxdWVzdHNfbG9jayk7DQoNCivCoMKgwqDCoMKg
wqAgaWYgKGxyICE9IE5VTEwpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByY3VfYXNz
aWduX3BvaW50ZXIobGFzdF9yZXF1ZXN0LCBscik7DQorDQogwqDCoMKgwqDCoMKgwqAgcHJfZGVi
dWcoIktpY2tpbmcgdGhlIHF1ZXVlXG4iKTsNCg0KIMKgwqDCoMKgwqDCoMKgIHNjaGVkdWxlX3dv
cmsoJnJlZ193b3JrKTsNCg0KDQpCZXN0IHJlZ2FyZHMsDQpSb2JlcnQgSG9kYXN6aQ0K
