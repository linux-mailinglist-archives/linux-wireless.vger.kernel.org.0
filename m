Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF91EF64E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgFELQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 07:16:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42610 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFELQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 07:16:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 055BG0IP0010429, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 055BG0IP0010429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 5 Jun 2020 19:16:00 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 5 Jun 2020 19:16:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 5 Jun 2020 19:16:00 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 5 Jun 2020 19:16:00 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Subject: RE: [PATCH v3 5/7] rtw88: 8821c: add query rx desc support
Thread-Topic: [PATCH v3 5/7] rtw88: 8821c: add query rx desc support
Thread-Index: AQHWOYq/DufmVtTfpUS6fNFzT49g96jJU0QAgACOwpA=
Date:   Fri, 5 Jun 2020 11:16:00 +0000
Message-ID: <811b7c714d374b84a8ec8ea9f5523b63@realtek.com>
References: <20200603093804.19779-1-yhchuang@realtek.com>
 <20200603093804.19779-6-yhchuang@realtek.com>
 <20200605104404.msgfrpjqerd2eozx@linutronix.de>
In-Reply-To: <20200605104404.msgfrpjqerd2eozx@linutronix.de>
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

PiBPbiAyMDIwLTA2LTAzIDE3OjM4OjAyIFsrMDgwMF0sIHloY2h1YW5nQHJlYWx0ZWsuY29tIHdy
b3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3J0dzg4MjFjLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4
MjFjLmMNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4
MjFjLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4
MjFjLmMNCj4g4oCmDQo+ID4gK3N0YXRpYyB2b2lkIHJ0dzg4MjFjX3F1ZXJ5X3J4X2Rlc2Moc3Ry
dWN0IHJ0d19kZXYgKnJ0d2RldiwgdTggKnJ4X2Rlc2MsDQo+ID4gKwkJCQkgICBzdHJ1Y3QgcnR3
X3J4X3BrdF9zdGF0ICpwa3Rfc3RhdCwNCj4gPiArCQkJCSAgIHN0cnVjdCBpZWVlODAyMTFfcnhf
c3RhdHVzICpyeF9zdGF0dXMpDQo+ID4gK3sNCj4g4oCmDQo+ID4gKw0KPiA+ICsJaGRyID0gKHN0
cnVjdCBpZWVlODAyMTFfaGRyICopKHJ4X2Rlc2MgKyBkZXNjX3N6ICsgcGt0X3N0YXQtPnNoaWZ0
ICsNCj4gPiArCQkJCSAgICAgICBwa3Rfc3RhdC0+ZHJ2X2luZm9fc3opOw0KPiANCj4gSSBkaWQg
c29tZSBjb3VudGluZyBhbmQgaGRyIGNhbiBiZSBtYXguIHJ4X2Rlc2MrMTQ3IHNvIGl0IGlzIGZp
bmUgaW4NCj4gdGVybXMgb2YgYSBib3VuZHMgY2hlY2suDQo+IEluIGZmMmYyMGY2MGNiODRkMTY4
NDM3OWViNWJlNGMyMjg1QHJlYWx0ZWsuY29tIHlvdSBzdWdnZXN0ZWQgdG8gbWVyZ2UNCj4gdGhl
IGZ1bmN0aW9uIHdpdGggODgyMUMvODgyMkIvODgyMkMuIERpZCB5b3UgY2hhbmdlIHlvdXIgbWlu
ZCBvciB3aWxsDQo+IHRoaXMgaGFwcGVuIGxhdGVyPw0KPiANCg0KVGhpcyB3aWxsIGhhcHBlbiBs
YXRlci4gQWZ0ZXIgODgyMUMgaXMgYXBwbGllZCwgSSB3aWxsIHRyeSB0byBtZXJnZSB0aGUgZnVu
Y3Rpb25zLg0KDQpZZW4tSHN1YW4NCg==
