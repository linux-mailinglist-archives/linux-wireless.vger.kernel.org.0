Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8C129EA8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 08:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfLXHuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 02:50:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39214 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 02:50:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBO7oAGt007115, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBO7oAGt007115
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 24 Dec 2019 15:50:11 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 24 Dec 2019 15:50:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Dec 2019 15:50:10 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Tue, 24 Dec 2019 15:50:10 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH 05/11] rtw88: 8822c: modify rf protection setting
Thread-Topic: [PATCH 05/11] rtw88: 8822c: modify rf protection setting
Thread-Index: AQHVtxcIiDKgUT6340W0dj3usMaGeqfIZk8AgACHmRA=
Date:   Tue, 24 Dec 2019 07:50:10 +0000
Message-ID: <2fefc26a026f47f1a34b2592040da1ec@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
 <20191220092156.13443-6-yhchuang@realtek.com>
 <CAB4CAwfhn10dWO8Fr5Bk1PMOAYTC-RVK2fVsh92kUDxdsr3+ZA@mail.gmail.com>
In-Reply-To: <CAB4CAwfhn10dWO8Fr5Bk1PMOAYTC-RVK2fVsh92kUDxdsr3+ZA@mail.gmail.com>
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

PiBPbiBGcmksIERlYyAyMCwgMjAxOSBhdCA1OjIyIFBNIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGllbi1Ic3VuIExpYW8gPGJlbi5saWFvQHJlYWx0ZWsu
Y29tPg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHNvbWUgZXhwZXJpbWVudHMsIHRoZSBvcmlnaW5h
bCByZiBwcm90ZWN0aW9uDQo+ID4gc2V0dGluZyBjYW4gbm90IHBlcmZlY3RseSBtYWtlIHN1cmUg
dGhhdCB0aGVyZSBpcyBubyBoYXJkd2FyZQ0KPiA+IHBpIHdyaXRlIGR1cmluZyB0aGUgZGlyZWN0
IHdyaXRlLiBTbywgbW9kaWZ5IHRoZSBzZXR0aW5nIHNvDQo+ID4gdGhhdCB0aGUgaGFyZHdhcmUg
YmxvY2sgb2YgcGkgd291bGQgYmUgdHVybmVkIG9mZiBkdXJpbmcgdGhlDQo+ID4gZGlyZWN0IHdy
aXRlLg0KPiA+DQo+IA0KPiBTb3JyeSwgSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB0aGlzIHBh
cnQuIERvZXMgaXQgbWVhbiBydHc4ODIyY19yc3RiXzN3aXJlKCkNCj4gaXMgdG8gZGlzYWJsZS9l
bmFibGUgdGhlIGhhcmR3YXJlIGJsb2NrIG9mIFBJPyBJbiB0aGlzIHBhdGNoLCBJIGNhbiBvbmx5
DQo+IHNlZSB0aGUgY29kZSBibG9jayBvZiBFTkFCTEVfUEkvRElTQUJMRV9QSSBiZWVuIHJlbW92
ZWQgYW5kIHNvbWUNCj4gcnR3X3dyaXRlX3JmKClzIGJlZW4gcHJvdGVjdGVkIGJ5IG5ldyBydHc4
ODIyY19yc3RiXzN3aXJlKCkuIElmIHRoZSBuZXcNCj4gZnVuY3Rpb24gaXMgdG8gcmVwbGFjZSB0
aGUgRU5BQkxFX1BJL0RJU0FCTEVfUEksIG1heWJlIHRoZXkgc2hvdWxkIGJlDQo+IHJlbW92ZWQg
aW4gdGhlIHJlZy5oLiBBbmQgSXQgc2VlbXMgcnR3ODgyMmNfcnN0Yl8zd2lyZSgpIGlzIG9ubHkg
Zm9yIDg4MjJjLA0KPiBtZWFucyB0aGVyZSdzIG5vIHN1Y2ggcHJvYmxlbSBmb3IgODgyMmI/DQo+
IA0KDQpZZXMsIHJ0dzg4MjJjX3JzdGJfM3dpcmUoKSBpcyB0byBkaXNhYmxlL2VuYWJsZSBQSS4g
T25seSA4ODIyYyB1c2VzIG1peCBtb2RlLg0KVGhhdCBtZWFucywgODgyMmMgdXNlcyBkaXJlY3Qg
d3JpdGUgZm9yIFJGIHJlZ2lzdGVycyBleGNlcHQgZm9yIHJlZ2lzdGVyIDB4MC4NCkFuZCA4ODIy
YiB1c2VzIHNpcGkgd3JpdGUgKGluZGlyZWN0KS4gU28gODgyMmIgZG9lc24ndCBoYXZlIHN1Y2gg
cHJvYmxlbS4NCg0KWWFuLUhzdWFuDQo=
