Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070A2D203A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 02:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLHBl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 20:41:26 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34427 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLHBl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 20:41:26 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B81eWLr9000771, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.33])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B81eWLr9000771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Dec 2020 09:40:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS04.realtek.com.tw (172.21.6.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 09:40:32 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 09:40:32 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Tue, 8 Dec 2020 09:40:32 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "lkp@intel.com" <lkp@intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-drivers-next:master 1/8] mips-linux-ld: drivers/net/wireless/realtek/rtw88/rtw8822ce.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here
Thread-Topic: [wireless-drivers-next:master 1/8] mips-linux-ld:
 drivers/net/wireless/realtek/rtw88/rtw8822ce.o:(.rodata.rtw_pm_ops+0x0):
 multiple definition of `rtw_pm_ops';
 drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0):
 first defined here
Thread-Index: AQHWzPBshrdJEf/D/EOcCOEabUPYtanr5jcA
Date:   Tue, 8 Dec 2020 01:40:32 +0000
Message-ID: <1607391626.11115.1.camel@realtek.com>
References: <202012080726.z6M9DkUt-lkp@intel.com>
In-Reply-To: <202012080726.z6M9DkUt-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4968C3C53E977D4C9F6A6D59264E2AE6@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIwLTEyLTA3IGF0IDIzOjI0ICswMDAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gdHJlZTrCoMKgwqBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9rdmFsby93aXJlbGVzcy1kcml2ZXJzDQo+IC1uZXh0LmdpdCBtYXN0ZXINCj4gaGVh
ZDrCoMKgwqA4NzFhODI1YzM5MDIyNDdkN2ZjYzA2ZTgxZWI5OTMxOTRkM2JmNDI0DQo+IGNvbW1p
dDogMmU4NmVmNDEzYWIzZjhkYTZlY2Y2Yzg2YjRlZWU1ZmI0N2JkNzdmNiBbMS84XSBydHc4ODog
cGNpOiBBZGQNCj4gcHJvdG90eXBlcyBmb3IgLnByb2JlLCAucmVtb3ZlIGFuZCAuc2h1dGRvd24N
Cj4gY29uZmlnOiBtaXBzLWFsbHllc2NvbmZpZyAoYXR0YWNoZWQgYXMgLmNvbmZpZykNCj4gY29t
cGlsZXI6IG1pcHMtbGludXgtZ2NjIChHQ0MpIDkuMy4wDQo+IHJlcHJvZHVjZSAodGhpcyBpcyBh
IFc9MSBidWlsZCk6DQo+IMKgwqDCoMKgwqDCoMKgwqB3Z2V0IGh0dHBzOi8vcmF3LmdpdGh1YnVz
ZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtdGVzdHMvbWFzdGVyL3NiaW4vbWFrDQo+IGUuY3Jvc3Mg
LU8gfi9iaW4vbWFrZS5jcm9zcw0KPiDCoMKgwqDCoMKgwqDCoMKgY2htb2QgK3ggfi9iaW4vbWFr
ZS5jcm9zcw0KPiDCoMKgwqDCoMKgwqDCoMKgIyBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9rdmFsby93aXJlbGVzcy1kcml2ZQ0KPiBycy1uZXh0LmdpdC9j
b21taXQvP2lkPTJlODZlZjQxM2FiM2Y4ZGE2ZWNmNmM4NmI0ZWVlNWZiNDdiZDc3ZjYNCj4gwqDC
oMKgwqDCoMKgwqDCoGdpdCByZW1vdGUgYWRkIHdpcmVsZXNzLWRyaXZlcnMtbmV4dCBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGkNCj4gbnV4L2tlcm5lbC9naXQva3ZhbG8vd2lyZWxl
c3MtZHJpdmVycy1uZXh0LmdpdA0KPiDCoMKgwqDCoMKgwqDCoMKgZ2l0IGZldGNoIC0tbm8tdGFn
cyB3aXJlbGVzcy1kcml2ZXJzLW5leHQgbWFzdGVyDQo+IMKgwqDCoMKgwqDCoMKgwqBnaXQgY2hl
Y2tvdXQgMmU4NmVmNDEzYWIzZjhkYTZlY2Y2Yzg2YjRlZWU1ZmI0N2JkNzdmNg0KPiDCoMKgwqDC
oMKgwqDCoMKgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1aWxkIHRyZWUN
Cj4gwqDCoMKgwqDCoMKgwqDCoENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5IENPTVBJ
TEVSPWdjYy05LjMuMCBtYWtlLmNyb3NzDQo+IEFSQ0g9bWlwc8KgDQo+IA0KPiBJZiB5b3UgZml4
IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+IFJl
cG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IEFsbCBl
cnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ID4+IG1pcHMtbGludXgtbGQ6
DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMmNlLm86KC5yb2Rh
dGEucnR3X3BtX29wcysweDApOg0KPiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBydHdfcG1fb3Bz
JzsNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYmUubzooLnJv
ZGF0YS5ydHdfcG1fb3BzKzB4MCk6IGZpcnN0DQo+IGRlZmluZWQgaGVyZQ0KPiDCoMKgwqBtaXBz
LWxpbnV4LWxkOg0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg3MjNk
ZS5vOigucm9kYXRhLnJ0d19wbV9vcHMrMHgwKToNCj4gbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
cnR3X3BtX29wcyc7DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgy
MmJlLm86KC5yb2RhdGEucnR3X3BtX29wcysweDApOiBmaXJzdA0KPiBkZWZpbmVkIGhlcmUNCj4g
wqDCoMKgbWlwcy1saW51eC1sZDoNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9ydHc4ODIxY2UubzooLnJvZGF0YS5ydHdfcG1fb3BzKzB4MCk6DQo+IG11bHRpcGxlIGRlZmlu
aXRpb24gb2YgYHJ0d19wbV9vcHMnOw0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J0dzg4MjJiZS5vOigucm9kYXRhLnJ0d19wbV9vcHMrMHgwKTogZmlyc3QNCj4gZGVmaW5l
ZCBoZXJlDQo+IMKgwqDCoG1pcHMtbGludXgtbGQ6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcGNpLm86KC5yb2RhdGEucnR3X3BtX29wcysweDApOiBtdWx0aXBsZQ0KPiBk
ZWZpbml0aW9uIG9mIGBydHdfcG1fb3BzJzsNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9ydHc4ODIyYmUubzooLnJvZGF0YS5ydHdfcG1fb3BzKzB4MCk6IGZpcnN0DQo+IGRl
ZmluZWQgaGVyZQ0KPiANCj4gDQoNCkkgaGF2ZSBzZW50IGEgcGF0Y2ggbmFtZWQgInJ0dzg4OiBm
aXggbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBydHdfcG1fb3BzIiB0bw0KZml4IGl0Lg0KDQotLS0N
ClBpbmctS2UNCg0KDQo=
