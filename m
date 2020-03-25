Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA81920C5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 06:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCYFyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 01:54:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59078 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 01:54:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02P5sSOZ003794, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02P5sSOZ003794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 13:54:29 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 13:54:28 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 13:54:28 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 25 Mar 2020 13:54:28 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Topic: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Index: AQHV+QPS9h9ZLy9E5U2M/GVMmM07xahGU7JUgAQrRBCAAeVFp4AANj0wgABYekb//3w6gIABoSZAgALoHICABwEiAIAAsS3g//+mMICAAIxHUA==
Date:   Wed, 25 Mar 2020 05:54:28 +0000
Message-ID: <30819fb6d90d48a9852dd0b7f59aa4f1@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com>
 <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
 <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
 <3894907ca6bf4566b8716731492a869b@realtek.com>
 <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
In-Reply-To: <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
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

QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+IHdyaXRlczoNCj4gDQo+IE9u
IFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDc6NTUgUE0gVG9ueSBDaHVhbmcgPHloY2h1YW5nQHJlYWx0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVt
Lm9yZz4gd3JpdGVzOg0KPiA+IFdlIHdhbnQgdG8gbWVhc3VyZSB0aGUgVFggcG93ZXIsIGFuZCB0
aGUgZXF1aXBtZW50IGp1c3QgY2Fubm90DQo+ID4gZGV0ZWN0IHRoZSBzaWduYWwgb24gc29tZSBy
YXRlcywgdW5sZXNzIHdlICJmaXgiIHRoZSByYXRlIGV4YWN0bHkuDQo+IA0KPiBJIHRoaW5rIHdl
IGFsbCB1bmRlcnN0YW5kIHRoaXMgbm93Lg0KPiANCj4gPiBTbyBOTDgwMjExX0NNRF9TRVRfVFhf
QklUUkFURV9NQVNLIGlzIG5vdCBzbyB1c2VmdWwgZm9yIHVzDQo+ID4gc29tZXRpbWVzLg0KPiAN
Cj4gSSdtIG5vdCBzdXJlIGlmIHlvdSBoYXZlIGRpcmVjdGx5IGV4cGxhaW5lZCB3aHkgdGhpcyBp
cyB0aGUgY2FzZS4gU2VlDQo+IHlvdXIgY29tbWVudCBlYXJsaWVyOg0KPiANCj4gIlRoaXMgY29t
bWFuZCBqdXN0IG1hc2sgb3V0IHNvbWUgb2YgcmF0ZXMgdGhhdCBhcmUgbm90IGFsbG93ZWQuIg0K
PiANCj4gU3VyZSwgYnV0IGlmIHlvdSBtYXNrIG91dCBhbGwgYnV0IDEgYml0cmF0ZS4uLnZvaWxh
ISBBIGZpeGVkIHJhdGUhDQo+IA0KPiBBbmQgdGhpczoNCj4gDQo+ICJCdXQgYWN0dWFsbHkgdGhl
IGZpcm13YXJlIGhhcyBpdHMgb3duIHJhdGUNCj4gYWRhcHRpdmUgbWVjaGFuaXNtLCBzbyBtYXNr
IG91dCB0aGUgb3RoZXIgcmF0ZXMgZG9lcyBub3QgbWVhbiB0aGUgcmF0ZQ0KPiBsZWZ0IHdpbGwg
YmUgY2hvc2VuLiINCj4gDQo+IFRoYXQncyBlbnRpcmVseSB5b3VyIGZhdWx0LCBub3QgdGhlIGZh
dWx0IG9mIHRoZSBBUEkuIElmIHlvdXIgZmlybXdhcmUNCj4gZG9lc24ndCBsaXN0ZW4gdG8geW91
ciBkcml2ZXIsIHRoZW4gdGhhdCdzIGVpdGhlciB5b3VyIGZpcm13YXJlIG9yDQo+IHlvdXIgZHJp
dmVyJ3MgZmF1bHQuIElmIHlvdSBzZXQgYSBtYXNrIHRoYXQgaGFzIGV4YWN0bHkgMSBiaXRyYXRl
IGluDQo+IGl0Li4uIHdlbGwsIHRoYXQncyBleGFjdGx5IHdoYXQgeW91IHNob3VsZCB0ZWxsIHlv
dXIgZmlybXdhcmUgdG8gZG8uDQo+IE5vdCwgInVzZSB0aGlzIDEgYml0cmF0ZSwgYnV0IHRyeSBz
b21ldGhpbmcgZWxzZSBpZiB5b3UgZmVlbCBsaWtlIGl0LiINCg0KSSBjYW5ub3QgYWdyZWUgd2l0
aCBpdC4gTGV0J3MgYmUgY2xlYXIgaGVyZToNCg0KSWYgdGhlcmUncyBhIHJhdGUgbWFzayBjb21l
cyBmcm9tIHVwcGVyIHNwYWNlLCBkb2VzIGl0IG1lYW4NClRoYXQgZHJpdmVyIG9yIGZpcm13YXJl
L2hhcmR3YXJlIGNhbiBvbmx5IHVzZSB0aG9zZSByYXRlcw0KbWFza2VkIHdoZW4gKjgwMi4xMSBy
ZXRyeSo/ICBBbmQgdXNlIGEgbG93ZXIgcmF0ZSB3aGVuDQpyZXRyeSBpcyBjYWxsZWQgcmF0ZS1m
YWxsYmFjayBhcyBJJ3ZlIG1lbnRpb25lZCBiZWZvcmUuICBTbyBJDQp0aGluayB0aGUgcHJvYmxl
bSBoZXJlIGlzLCBkbyB3ZSBuZWVkIGFub3RoZXIgb3B0aW9uIGluIHRoZQ0KZXhpc3Rpbmcgbmw4
MDIxMSBjb21tYW5kLCBpZiA4MDIuMTEgKnJldHJ5KiBpcyBzdGlsbCBhbGxvd2VkIHRvDQpjaG9v
c2UgYSByYXRlIG5vdCBpbiB0aGUgcmF0ZSBtYXNrPyAgSW4gbXkgb3BpbmlvbiwgaWYgODAyLjEx
DQpyZXRyeSBzaG91bGQgYmUgZGlzYWJsZWQsIHRoZW4gYWxsIG9mIHRoZSBhbGdvcml0aG0gb2Yg
dGhlIGV4aXN0aW5nDQpyYXRlIGFkYXB0aXZlIG1lY2hhbmlzbSBmb3IgcnR3ODggc2hvdWxkIGJl
IHRvdGFsbHkgcmUtZGVzaWduZWQNCmFuZCB3ZSB3aWxsIGhhdmUgdG8gcmVidWlsZCBhbm90aGVy
IG9uZS4NCg0KPiANCj4gTm93LCB0aGVyZSBhcmUgb3RoZXIgcHJvYmxlbXMsIGxpa2UgdGhlIG90
aGVycyB0aGF0IEJlbiBtZW50aW9uZWQ6IHRoZQ0KPiByZXN0IG9mIHRoZSBtYWM4MDIxMSBmcmFt
ZXdvcmsgZG9lc24ndCBsaWtlIGl0IHRvbyBtdWNoIGlmIHlvdSByZWFsbHkNCj4gZGlzYWJsZSBh
bGwgYnV0IDEgcmF0ZSAoYXJndWFibHkgYSBtYWM4MDIxMSBidWcgLS0gYnV0IG5vdCBhIG5sODAy
MTENCj4gYnVnKTsgb3IgbWF5YmUgeW91IHdhbnQgdG8gZGlmZmVyZW50aWF0ZSBtYW5hZ2VtZW50
IGZyYW1lcyBhbmQgZGF0YQ0KPiBmcmFtZXMgKGFuZCB0aGF0J3Mgbm90IHdoYXQgdGhlIGN1cnJl
bnQNCj4gTkw4MDIxMV9DTURfU0VUX1RYX0JJVFJBVEVfTUFTSyBhbGxvd3MgZm9yKS4NCj4gDQo+
IEknbSBzdGlsbCBub3QgKHBlcnNvbmFsbHkpIGV4cGVjdGluZyB0aGF0IHlvdSAqbXVzdCogZG8g
dGhpcyBhbGwgdmlhDQo+IHRoZSBleGlzdGluZyBDTURfU0VUX1RYX0JJVFJBVEVfTUFTSywgYnV0
IHRvIHNhdGlzZnkgZXZlcnlvbmUgaW52b2x2ZWQNCj4gaGVyZSwgeW91IGF0IGxlYXN0IG5lZWQg
dG8gYmUgY2xlYXIgYWJvdXQgd2h5IHlvdSBhcmVuJ3QuDQo+IA0KDQpZZW4tSHN1YW4NCg==
