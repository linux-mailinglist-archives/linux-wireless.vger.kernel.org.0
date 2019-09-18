Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D91B5987
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 04:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfIRCKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 22:10:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55197 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfIRCKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 22:10:40 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8I2AWTp009447, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8I2AWTp009447
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 10:10:32 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Wed, 18 Sep 2019 10:10:31 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
Thread-Topic: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
Thread-Index: AQHVbFzthQTPSGBi5kOtH0MxIMGahqcwFOyAgACdtzA=
Date:   Wed, 18 Sep 2019 02:10:30 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
 <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
 <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
In-Reply-To: <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
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

PiBNYXkgYmUgYSBkdW1iIHF1ZXN0aW9uIGJ1dDoNCj4gDQo+IE9uIE1vbiwgU2VwIDE2LCAyMDE5
IGF0IDEyOjAzIEFNIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IEludGVy
cnVwdCBpcyBkaXNhYmxlZCB0byBzdG9wIFBDSSwgd2hpY2ggbWVhbnMgdGhlIHNrYnMNCj4gPiBx
dWV1ZWQgZm9yIGVhY2ggVFggcmluZyB3aWxsIG5vdCBiZSByZWxlYXNlZCB2aWEgRE1BDQo+ID4g
aW50ZXJydXB0Lg0KPiANCj4gSW4gd2hhdCBjYXNlcyBkbyB5b3UgaGl0IHRoaXM/IEkgdGhpbmsg
eW91IGRvIHRoaXMgd2hlbiBlbnRlcmluZyBQUw0KPiBtb2RlLCBubz8gQnV0IHRoZW4sIHNlZSBi
ZWxvdy4NCg0KSSdsbCBoaXQgdGhpcyB3aGVuIGllZWU4MDIxMV9vcHM6OnN0b3AsIG9yIHJ0d19w
b3dlcl9vZmYuDQpCb3RoIGFyZSB0byB0dXJuIG9mZiB0aGUgZGV2aWNlLCBzbyB0aGVyZSdzIG5v
IG1vcmUgRE1BIGFjdGl2aXRpZXMuDQpJZiB3ZSBkb24ndCByZWxlYXNlIHRoZSBTS0JzIHRoYXQg
YXJlIG5vdCByZWxlYXNlZCBieSBETUEgaW50ZXJydXB0DQp3aGVuIHBvd2VyaW5nIG9mZiwgdGhl
c2UgY291bGQgYmUgbGVha2VkLg0KDQo+IA0KPiA+IFRvIGF2b2lkIHRob3NlIHNrYnMgcmVtYWlu
ZWQgYmVpbmcgbGVmdCBpbg0KPiA+IHRoZSBza2IgcXVldWUgdW50aWwgUENJIGhhcyBiZWVuIHJl
bW92ZWQsIGRyaXZlciBuZWVkcw0KPiA+IHRvIHJlbGVhc2Ugc2ticyBieSBpdHNlbGYuDQo+IA0K
PiBEb2Vzbid0IHRoYXQgYWxzbyBtZWFuIHlvdXIgZHJvcHBpbmcgdGhlc2UgcGFja2V0cz8gU2hv
dWxkbid0IHlvdSBiZQ0KPiBkZWxheWluZyBQUyB0cmFuc2l0aW9ucyB1bnRpbCB5b3UndmUgZmlu
aXNoZWQgVFgnaW5nPw0KPiANCj4gQnJpYW4NCj4gDQoNCllhbi1Ic3Vhbg0KDQo=
