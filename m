Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDAE0F50
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 02:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJWAr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 20:47:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40998 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJWAr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 20:47:56 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9N0lgT6017959, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9N0lgT6017959
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 08:47:42 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Wed, 23 Oct 2019 08:47:42 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>, Tony Chuang <yhchuang@realtek.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH v3 4/5] rtw88: add set_bitrate_mask support
Thread-Topic: [PATCH v3 4/5] rtw88: add set_bitrate_mask support
Thread-Index: AQHViMCyu5KjsNbAd0CXoL0Xc3riU6dmFqcAgAFOEYA=
Date:   Wed, 23 Oct 2019 00:47:40 +0000
Message-ID: <5B2DA6FDDF928F4E855344EE0A5C39D1D5C88DA8@RTITMBSVM04.realtek.com.tw>
References: <20191022100420.25116-1-yhchuang@realtek.com>
 <20191022100420.25116-5-yhchuang@realtek.com>
 <CAB4CAwcBUHMR3btH9LGd=GzqU1mRmfmL0o4EOY4E8H1OxfpvMg@mail.gmail.com>
In-Reply-To: <CAB4CAwcBUHMR3btH9LGd=GzqU1mRmfmL0o4EOY4E8H1OxfpvMg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtd2lyZWxlc3Mt
b3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtd2lyZWxlc3Mtb3duZXJAdmdlci5r
ZXJuZWwub3JnXSBPbiBCZWhhbGYNCj4gT2YgQ2hyaXMgQ2hpdQ0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDIyLCAyMDE5IDg6NDkgUE0NCj4gVG86IFRvbnkgQ2h1YW5nDQo+IENjOiBLYWxsZSBW
YWxvOyBsaW51eC13aXJlbGVzczsgQnJpYW4gTm9ycmlzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgNC81XSBydHc4ODogYWRkIHNldF9iaXRyYXRlX21hc2sgc3VwcG9ydA0KPiANCj4gT24gVHVl
LCBPY3QgMjIsIDIwMTkgYXQgNjowNCBQTSA8eWhjaHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gRnJvbTogVHp1LUVuIEh1YW5nIDx0ZWh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+
ID4gU3VwcG9ydCBzZXR0aW5nIGJpdCByYXRlIGZyb20gdXBwZXIgbGF5ZXIuDQo+ID4gQWZ0ZXIg
Y29uZmlndXJpbmcgdGhlIG9yaWdpbmFsIHJhdGUgY29udHJvbCByZXN1bHQgaW4gdGhlIGRyaXZl
ciwgdGhlDQo+ID4gcmVzdWx0IGlzIHRoZW4gbWFza2VkIGJ5IHRoZSBiaXQgcmF0ZSBtYXNrIHJl
Y2VpdmVkIGZyb20gdGhlIG9wcw0KPiA+IHNldF9iaXRyYXRlX21hc2suIExhc3RseSwgdGhlIG1h
c2tlZCByZXN1bHQgd2lsbCBiZSBzZW50IHRvIGZpcm13YXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVHp1LUVuIEh1YW5nIDx0ZWh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gdjEgLT4gdjINCj4gPiAgICogTm8gY2hhbmdlDQo+ID4NCj4gPiB2MiAtPiB2Mw0KPiA+
ICAgKiB1c2UgdTY0X2VuY29kZV9iaXRzDQo+ID4NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9tYWM4MDIxMS5jIHwgNTMgKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyAgICAgfCA3OCArKysrKysrKysrKysr
KystLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5oICAg
ICB8ICAzICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9tYWM4MDIxMS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9tYWM4MDIxMS5jDQo+ID4gaW5kZXggYmMwNGNjMjgwYTk2Li4yMjQ3YmQ2MWU3MTYgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWM4MDIx
MS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWM4MDIx
MS5jDQo+ID4gQEAgLTY4NCw2ICs2ODYsNTYgQEAgc3RhdGljIHZvaWQgcnR3X29wc19mbHVzaChz
dHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCj4gPiAgICAgICAgIG11dGV4X3VubG9jaygmcnR3ZGV2
LT5tdXRleCk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdHJ1Y3QgcnR3X2l0ZXJfYml0cmF0ZV9tYXNr
X2RhdGEgew0KPiA+ICsgICAgICAgc3RydWN0IHJ0d19kZXYgKnJ0d2RldjsNCj4gPiArICAgICAg
IHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWY7DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgY2Zn
ODAyMTFfYml0cmF0ZV9tYXNrICptYXNrOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgcnR3X3JhX21hc2tfaW5mb191cGRhdGVfaXRlcih2b2lkICpkYXRhLCBzdHJ1Y3QgaWVlZTgw
MjExX3N0YSAqc3RhKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnR3X2l0ZXJfYml0cmF0
ZV9tYXNrX2RhdGEgKmJyX2RhdGEgPSBkYXRhOw0KPiA+ICsgICAgICAgc3RydWN0IHJ0d19zdGFf
aW5mbyAqc2kgPSAoc3RydWN0IHJ0d19zdGFfaW5mbyAqKXN0YS0+ZHJ2X3ByaXY7DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKHNpLT52aWYgIT0gYnJfZGF0YS0+dmlmKQ0KPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZnJlZSBwcmV2aW91cyBtYXNrIHNl
dHRpbmcgKi8NCj4gPiArICAgICAgIGtmcmVlKHNpLT5tYXNrKTsNCj4gDQo+IFlvdSBtYXkgd2Fu
dCB0byBkbyBOVUxMIGNoZWNrIGZvciBzaS0+bWFzayBiZWZvcmUga2ZyZWUuDQoNCmtmcmVlIGNo
ZWNrcyBOVUxMIGJ5IGl0c2VsZiwgYW5kIGNoZWNrcGF0Y2ggYWxzbyB3YXJucyB0aGlzIGtpbmQg
b2YgbmVlZGxlc3MgY2hlY2tpbmcuDQoNCj4gDQo+ID4gKyAgICAgICBzaS0+bWFzayA9IGttZW1k
dXAoYnJfZGF0YS0+bWFzaywgc2l6ZW9mKHN0cnVjdCBjZmc4MDIxMV9iaXRyYXRlX21hc2spLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9BVE9NSUMpOw0KPiA+ICsgICAgICAg
aWYgKCFzaS0+bWFzaykgew0KPiA+ICsgICAgICAgICAgICAgICBzaS0+dXNlX2NmZ19tYXNrID0g
ZmFsc2U7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgICBzaS0+dXNlX2NmZ19tYXNrID0gdHJ1ZTsNCj4gPiArICAgICAgIHJ0d191
cGRhdGVfc3RhX2luZm8oYnJfZGF0YS0+cnR3ZGV2LCBzaSk7DQo+ID4gK30NCj4gPiArDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4gPiBpbmRleCA0N2U3
NGYwYWVjMDYuLmU1MzE0MzEzMmE5YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+ID4gQEAgLTYxMiwxMiArNjEyLDcxIEBAIHN0YXRpYyB1
OCBnZXRfcmF0ZV9pZCh1OCB3aXJlbGVzc19zZXQsIGVudW0gcnR3X2JhbmR3aWR0aCBid19tb2Rl
LCB1OCB0eF9udW0pDQo+ID4gICNkZWZpbmUgUkFfTUFTS19PRkRNX0lOX0hUXzJHICAweDAwMDEw
DQo+ID4gICNkZWZpbmUgUkFfTUFTS19PRkRNX0lOX0hUXzVHICAweDAwMDMwDQo+ID4NCj4gPiAr
c3RhdGljIHU2NCBydHdfdXBkYXRlX3JhdGVfbWFzayhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJ0d19zdGFfaW5mbyAq
c2ksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgcmFfbWFzaywgYm9v
bCBpc192aHRfZW5hYmxlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTgg
d2lyZWxlc3Nfc2V0KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnR3X2hhbCAqaGFsID0g
JnJ0d2Rldi0+aGFsOw0KPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IGNmZzgwMjExX2JpdHJhdGVf
bWFzayAqbWFzayA9IHNpLT5tYXNrOw0KPiA+ICsgICAgICAgdTY0IGNmZ19tYXNrID0gR0VOTUFT
Syg2MywgMCk7DQo+ID4gKyAgICAgICB1OCByc3NpX2xldmVsLCBiYW5kOw0KPiA+ICsNCj4gPiAr
ICAgICAgIGlmICh3aXJlbGVzc19zZXQgIT0gV0lSRUxFU1NfQ0NLKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJzc2lfbGV2ZWwgPSBzaS0+cnNzaV9sZXZlbDsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKHJzc2lfbGV2ZWwgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByYV9tYXNr
ICY9IDB4ZmZmZmZmZmZmZmZmZmZmZlVMTDsNCj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAo
cnNzaV9sZXZlbCA9PSAxKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhX21hc2sgJj0g
MHhmZmZmZmZmZmZmZmZmZmYwVUxMOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChyc3Np
X2xldmVsID09IDIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmFfbWFzayAmPSAweGZm
ZmZmZmZmZmZmZmVmZTBVTEw7DQo+ID4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKHJzc2lfbGV2
ZWwgPT0gMykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByYV9tYXNrICY9IDB4ZmZmZmZm
ZmZmZmZmY2ZjMFVMTDsNCj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAocnNzaV9sZXZlbCA9
PSA0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJhX21hc2sgJj0gMHhmZmZmZmZmZmZm
ZmY4ZjgwVUxMOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChyc3NpX2xldmVsID49IDUp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmFfbWFzayAmPSAweGZmZmZmZmZmZmZmZjBm
MDBVTEw7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBXb3VsZCBiZSBiZXR0ZXIgdG8gZW51bWVyYXRl
IHJzc2lfbGV2ZWwgaW5zdGVhZCBvZiAwIHRvIDUuIERvZXMgbGV2ZWwNCj4gMCBtZWFucyBiYWQg
cnNzaSBvciBnb29kPw0KPiANCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiAtLS0tLS1Q
bGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFp
bC4NCg==
