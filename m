Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007228F92F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHPCpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 22:45:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51928 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfHPCpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 22:45:35 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7G2jINu016587, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7G2jINu016587
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 16 Aug 2019 10:45:18 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 16 Aug
 2019 10:45:18 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: RE: [PATCH v3 2/3] rtw88: enclose c2h cmd handle with mutex
Thread-Topic: [PATCH v3 2/3] rtw88: enclose c2h cmd handle with mutex
Thread-Index: AQHVR5q3nan8bHQ1XkuCG3EAT/So7qb8RpoAgADeJtA=
Date:   Fri, 16 Aug 2019 02:45:17 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18914D3@RTITMBSVM04.realtek.com.tw>
References: <1564575767-27557-1-git-send-email-yhchuang@realtek.com>
 <1564575767-27557-3-git-send-email-yhchuang@realtek.com>
 <CA+ASDXPJiNTXAihzohT06RS57gkJU9Q-u3kpp0piJP-3U1miFw@mail.gmail.com>
In-Reply-To: <CA+ASDXPJiNTXAihzohT06RS57gkJU9Q-u3kpp0piJP-3U1miFw@mail.gmail.com>
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

PiBJIHVuZGVyc3RhbmQgdGhpcyBpcyBhbHJlYWR5IHF1ZXVlZCB1cCwgYnV0IEkgc3RpbGwgaGF2
ZSBhIHF1ZXN0aW9uOg0KPiANCj4gT24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgNToyMyBBTSA8eWhj
aHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+IEMySCBjb21tYW5kcyB0aGF0IGNhbm5vdCBi
ZSBoYW5kbGVkIGluIElSUSBjb250ZXh0IHNob3VsZA0KPiA+IGJlIHByb3RlY3RlZCBieSBydHdk
ZXYtPm11dGV4LiBCZWNhdXNlIHRoZXkgbWlnaHQgaGF2ZSBhDQo+ID4gc2VxdWVjZSBvZiBoYXJk
d2FyZSBvcGVyYXRpb25zIHRoYXQgZG9lcyBub3Qgd2FudCB0byBiZQ0KPiA+IGludGVyZmVyZWQu
DQo+IA0KPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB3aGF0IGludGVyZmVyZW5jZSB5b3UncmUgbG9v
a2luZyBhdCwgZXhhY3RseT8gSSdtDQo+IG5vdCBhIGJpZyBmYW4gb2YgZGVmZW5zaXZlIGFkZGl0
aW9uIG9mIGdsb2JhbCBsb2NrcywgYW5kIHRoaXMNCj4gcGFydGljdWxhciBtdXRleCBpc24ndCB2
ZXJ5IHRhcmdldGVkLiBJdCBjbGFpbXMgdG8gYmUgZm9yIG1hYzgwMjExDQo+IGNhbGxiYWNrcywg
YnV0IHlvdSB1c2UgaXQgaW4gcXVpdGUgYSBmZXcgcGxhY2VzIChzb21lIG9mIHdoaWNoIGNsZWFy
bHkNCj4gZG9uJ3QgbWFrZSBzZW5zZSksIGFuZCBtYW55IG9mIHRoZW0gYXJlIG5vdCByZWxhdGVk
IHRvIG1hYzgwMjExDQo+IGNhbGxiYWNrcyBBRkFJQ1QuDQoNCkJhc2ljYWxseSBpdCBtdXN0IHBy
b3RlY3QgcnR3ZGV2IGl0c2VsZiBmb3IgbWFjODAyMTEgY2FsbGJhY2tzLCBidXQNCndvcmsgcXVl
dWUgYWxzbyBzaG91bGQgYmUgcHJvdGVjdGVkLCBhcyB3b3JrIHF1ZXVlIGNvdWxkIGJlIGludGVy
ZmVyZWQNCmJ5IG1hYzgwMjExIGNhbGxiYWNrcyBJSVVDLiBBbmQgbW9zdCBvZiB0aGUgdGltZSB3
aGF0IEkgd2FudCB0bw0KcHJvdGVjdCBpcyB0aGUgImhhcmR3YXJlIG9wZXJhdGlvbnMiLiBJIG1p
Z2h0IGltcGxpY2l0bHkgYmluZHMgdGhvc2UNCnJlZ2lzdGVyIHJlYWQvd3JpdGUocykgd2l0aCB0
aGUgcnR3ZGV2IHN0cnVjdC4NCg0KSSB0aGluayB0aGUgcHJvYmxlbSBoZXJlIGlzIEkgc2hvdWxk
IGdpdmUgYSBiZXR0ZXIgY29tbWVudCB0byBiZXR0ZXINCmRlc2NyaWJlIHRoZSB1c2FnZSBvZiB0
aGUgbXV0ZXguIEFuZCBJIGFsc28gd2FudCB0byBrZWVwIGl0IHNob3J0Lg0KDQo+IA0KPiBUbyB0
aGUgY29udHJhcnk6IHRoaXMgaGFuZGxlciBpcyBjYWxsZWQgZnJvbSB0aGUgbWFjODAyMTEgd29y
ayBxdWV1ZSwNCj4gd2hpY2ggaXMgb3JkZXJlZCBhbmQgdGhlcmVmb3JlIHNob3VsZG4ndCBiZSBn
ZXR0aW5nICJpbnRlcnJ1cHRlZCINCj4gKGUuZy4sIGNvbmZsaWN0aW5nIGNvbW1hbmRzKS4gQnV0
IHRoZW4sIHlvdSBhZGRlZCB0aGUgJ2lycXNhZmUnDQo+IGNvbW1hbmQsIHdoaWNoIGdldHMgcnVu
IGZyb20gdGhlIElTUi4uLmFuZCBkb2Vzbid0IGhvbGQgdGhpcyBsb2NrLA0KPiBvYnZpb3VzbHku
DQoNCkMySCB3b3JrIHF1ZXVlIHdpbGwgbm90IGludGVycnVwdCBlYWNoIG90aGVyLCBidXQgbWFj
ODAyMTEgY2FsbGJhY2tzDQpjb3VsZCwgYXMgbW9zdCBvZiB0aGUgZnVuY3Rpb25zIGFyZSBjb25z
aXN0IG9mIGEgc2VxdWVuY2Ugb2YgaGFyZHdhcmUNCnJlZ2lzdGVyIG9wZXJhdGlvbnMuIEFuZCBJ
IGRvbid0IHdhbnQgdG8gdXNlIEkvTyB1bmRlciBJU1IgY29udGV4dCwNCnNvIGhlcmUgdG8gc3Bs
aXQgdGhlIEMySCBjb21tYW5kcy4NCg0KPiANCj4gSXQgbWF5IHdlbGwgYmUgdGhhdCB5b3UncmUg
Y29ycmVjdCBoZXJlLCBidXQgSSdkIGxpa2UgdG8gc2VlIGEgYmV0dGVyDQo+IGV4cGxhbmF0aW9u
IGZvciBzdHVmZiBsaWtlIHRoaXMuIEFuZCBtYXliZSBhbiB1cGRhdGUgdG8gdGhlDQo+IHJ0d19k
ZXY6Om11dGV4IGNvbW1lbnRzLg0KPiANCj4gQnJpYW4NCj4gDQoNCllhbi1Ic3Vhbg0K
