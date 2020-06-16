Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78B1FAEE7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFPLIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 07:08:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53368 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPLIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 07:08:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05GB7uPN2025880, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05GB7uPN2025880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 19:07:56 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 19:07:56 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 19:07:56 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Tue, 16 Jun 2020 19:07:56 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Andy Huang" <tehuang@realtek.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: RE: [PATCH v2 5/5] rtw88: 8821c: Add 8821CE to Kconfig and Makefile
Thread-Topic: [PATCH v2 5/5] rtw88: 8821c: Add 8821CE to Kconfig and Makefile
Thread-Index: AQHWOYtTsat00zurkU+RT3WBf8Vp4KjOlT8AgAyUFKA=
Date:   Tue, 16 Jun 2020 11:07:55 +0000
Message-ID: <fb3241a02b6744e6aa59886b5ef53245@realtek.com>
References: <20200603094218.19942-1-yhchuang@realtek.com>
 <20200603094218.19942-6-yhchuang@realtek.com>
 <bec7010d-e979-da0a-0ce1-88fc872c1eec@lwfinger.net>
In-Reply-To: <bec7010d-e979-da0a-0ce1-88fc872c1eec@lwfinger.net>
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

PiBPbiA2LzMvMjAgNDo0MiBBTSwgeWhjaHVhbmdAcmVhbHRlay5jb20gd3JvdGU6DQo+ID4gRnJv
bTogVHp1LUVuIEh1YW5nIDx0ZWh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gU2luY2UgODgy
MUMgY29kZSBpcyByZWFkeSwgd2UgY2FuIGJ1aWxkIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVHp1LUVuIEh1YW5nIDx0ZWh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiANCj4gSSBhZGRlZCB0
aGlzIGNvZGUgdG8gdGhlIHJ0dzg4IEdpdEh1YiByZXBvc2l0b3J5IHRoYXQgSSBtYWludGFpbi4g
SSBkbyBub3QgaGF2ZQ0KPiBhbiA4ODIxQ0UgY2FyZCBhbmQgaGF2ZSBubyB3YXkgdG8gdGVzdCBp
dDsgaG93ZXZlciwgdGhlcmUgaXMgYXQgbGVhc3Qgb25lIHVzZXIuDQo+IA0KPiBUaGF0IHVzZXIg
aGFzIGJ1aWx0IHRoZSBkcml2ZXIgYW5kIGdldHMgdGhlIGZpcm13YXJlIGxvYWRlZCwgYnV0IHJ1
bnMgaW50byB0aGUNCj4gZm9sbG93aW5nOg0KPiANCj4gWyAgIDEyLjM3ODE1OF0gcnR3Xzg4MjFj
ZSAwMDAwOjAyOjAwLjA6IEZpcm13YXJlIHZlcnNpb24gMjQuNS4wLCBIMkMNCj4gdmVyc2lvbiAx
Mg0KPiBbICAgMTIuNDA0ODM0XSBydHdfODgyMWNlIDAwMDA6MDI6MDAuMDogcmZlIDIgaXNuJ3Qg
c3VwcG9ydGVkDQo+IFsgICAxMi40MDQ5MzddIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiBmYWls
ZWQgdG8gc2V0dXAgY2hpcCBlZnVzZSBpbmZvDQo+IFsgICAxMi40MDQ5MzldIHJ0d184ODIxY2Ug
MDAwMDowMjowMC4wOiBmYWlsZWQgdG8gc2V0dXAgY2hpcCBpbmZvcm1hdGlvbg0KPiANCg0KSSBu
ZWVkIHRvIGNoZWNrIHRoZSBkZXZpY2VzIHdpdGggUkZFIHR5cGUgMi4gSSBhbSBub3Qgc3VyZSBp
ZiB0aGV5IGFyZSBzdXBwb3J0ZWQuDQpCdXQgeW91IGNhbiB0cnkgdG8gYWRkIFJGRSAyIGluIHJ0
dzg4MjFjLmMsIHRoYXQgY2FuIHByb2JhYmx5IHdvcmsuDQoNClllbi1Ic3Vhbg0K
