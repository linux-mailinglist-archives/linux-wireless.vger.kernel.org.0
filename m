Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB11E75B6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 07:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2F6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 01:58:50 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46441 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgE2F6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 01:58:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T5wXBU1024189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T5wXBU1024189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 13:58:33 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 13:58:32 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 13:58:32 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 29 May 2020 13:58:32 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Subject: RE: [PATCH 5/7] rtw88: 8821c: add query rx desc support
Thread-Topic: [PATCH 5/7] rtw88: 8821c: add query rx desc support
Thread-Index: AQHWLmbgMVb/wd6cX0WqyDn1K6hK+qi9MecAgAFtOAA=
Date:   Fri, 29 May 2020 05:58:32 +0000
Message-ID: <ff2f20f60cb84d1684379eb5be4c2285@realtek.com>
References: <20200520052335.22466-1-yhchuang@realtek.com>
 <20200520052335.22466-6-yhchuang@realtek.com>
 <20200528160948.rn5eq6kguqcdf34b@linutronix.de>
In-Reply-To: <20200528160948.rn5eq6kguqcdf34b@linutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQouLi4NCj4gPiArc3RhdGljIHZvaWQgcnR3ODgyMWNfcXVlcnlfcnhfZGVzYyhzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2LCB1OCAqcnhfZGVzYywNCj4gPiArCQkJCSAgIHN0cnVjdCBydHdfcnhfcGt0
X3N0YXQgKnBrdF9zdGF0LA0KPiA+ICsJCQkJICAgc3RydWN0IGllZWU4MDIxMV9yeF9zdGF0dXMg
KnJ4X3N0YXR1cykNCj4gPiArew0KPiA+ICsJc3RydWN0IGllZWU4MDIxMV9oZHIgKmhkcjsNCj4g
PiArCXUzMiBkZXNjX3N6ID0gcnR3ZGV2LT5jaGlwLT5yeF9wa3RfZGVzY19zejsNCj4gPiArCXU4
ICpwaHlfc3RhdHVzID0gTlVMTDsNCj4gPiArDQo+ID4gKwltZW1zZXQocGt0X3N0YXQsIDAsIHNp
emVvZigqcGt0X3N0YXQpKTsNCj4gPiArDQo+ID4gKwlwa3Rfc3RhdC0+cGh5X3N0YXR1cyA9IEdF
VF9SWF9ERVNDX1BIWVNUKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPmljdl9lcnIgPSBHRVRf
UlhfREVTQ19JQ1ZfRVJSKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPmNyY19lcnIgPSBHRVRf
UlhfREVTQ19DUkMzMihyeF9kZXNjKTsNCj4gPiArCXBrdF9zdGF0LT5kZWNyeXB0ZWQgPSAhR0VU
X1JYX0RFU0NfU1dERUMocnhfZGVzYyk7DQo+ID4gKwlwa3Rfc3RhdC0+aXNfYzJoID0gR0VUX1JY
X0RFU0NfQzJIKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPnBrdF9sZW4gPSBHRVRfUlhfREVT
Q19QS1RfTEVOKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPmRydl9pbmZvX3N6ID0gR0VUX1JY
X0RFU0NfRFJWX0lORk9fU0laRShyeF9kZXNjKTsNCj4gPiArCXBrdF9zdGF0LT5zaGlmdCA9IEdF
VF9SWF9ERVNDX1NISUZUKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPnJhdGUgPSBHRVRfUlhf
REVTQ19SWF9SQVRFKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPmNhbV9pZCA9IEdFVF9SWF9E
RVNDX01BQ0lEKHJ4X2Rlc2MpOw0KPiA+ICsJcGt0X3N0YXQtPnBwZHVfY250ID0gR0VUX1JYX0RF
U0NfUFBEVV9DTlQocnhfZGVzYyk7DQo+ID4gKwlwa3Rfc3RhdC0+dHNmX2xvdyA9IEdFVF9SWF9E
RVNDX1RTRkwocnhfZGVzYyk7DQo+ID4gKw0KPiA+ICsJLyogZHJ2X2luZm9fc3ogaXMgaW4gdW5p
dCBvZiA4LWJ5dGVzICovDQo+ID4gKwlwa3Rfc3RhdC0+ZHJ2X2luZm9fc3ogKj0gODsNCj4gPiAr
DQo+ID4gKwkvKiBjMmggY21kIHBrdCdzIHJ4L3BoeSBzdGF0dXMgaXMgbm90IGludGVyZXN0ZWQg
Ki8NCj4gPiArCWlmIChwa3Rfc3RhdC0+aXNfYzJoKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+
ID4gKwloZHIgPSAoc3RydWN0IGllZWU4MDIxMV9oZHIgKikocnhfZGVzYyArIGRlc2Nfc3ogKyBw
a3Rfc3RhdC0+c2hpZnQgKw0KPiA+ICsJCQkJICAgICAgIHBrdF9zdGF0LT5kcnZfaW5mb19zeik7
DQo+IA0KPiBJIHdvdWxkIGZlZWwgc2FmZXIgaWYgeW91IGNvdWxkIGVuc3VyZSB0aGF0IHRoYXQg
aGRyIGlzIHdpdGhpbiB2YWxpZCBidWZmZXIgYm91bmRzLg0KPiBTbyB0aGF0IGhkciBhbmQgaGRy
ICsgc2l6ZW9mKCpoZHIpLSAxIGRvZXNuJ3QgcG9pbnQgb3V0c2lkZSBvZiByeF9kZXNjLg0KPiAN
Cj4gPiArCWlmIChwa3Rfc3RhdC0+cGh5X3N0YXR1cykgew0KPiA+ICsJCXBoeV9zdGF0dXMgPSBy
eF9kZXNjICsgZGVzY19zeiArIHBrdF9zdGF0LT5zaGlmdDsNCj4gDQo+IGFuZCBoZXJlLCB0b28u
DQo+IA0KPiA+ICsJCXF1ZXJ5X3BoeV9zdGF0dXMocnR3ZGV2LCBwaHlfc3RhdHVzLCBwa3Rfc3Rh
dCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcnR3X3J4X2ZpbGxfcnhfc3RhdHVzKHJ0d2Rldiwg
cGt0X3N0YXQsIGhkciwgcnhfc3RhdHVzLCBwaHlfc3RhdHVzKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgc3RhdGljIHZvaWQNCj4gPiAgcnR3ODgyMWNfc2V0X3R4X3Bvd2VyX2luZGV4X2J5X3JhdGUo
c3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTggcGF0aCwNCj4gdTggcnMpDQo+ID4gIHsNCj4gDQoN
CkkgY2FuIHRyeSB0byBtZXJnZSB0aGUgUlggcXVlcnkgY29kZSBpbiA4ODIxQy84ODIyQi84ODIy
Qy4NCkxvb2tzIGxpa2UgdGhleSBhcmUgbXVjaCB0aGUgc2FtZS4NCg0KWWFuLUhzdWFuDQo=
