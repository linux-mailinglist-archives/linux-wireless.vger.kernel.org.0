Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796742B5AD0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 09:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgKQING (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 03:13:06 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46042 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgKQING (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 03:13:06 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AH8CfjL6015835, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AH8CfjL6015835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Nov 2020 16:12:41 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.34) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 17 Nov 2020 16:12:41 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 17 Nov 2020 16:12:40 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Tue, 17 Nov 2020 16:12:40 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kaixuxia@tencent.com" <kaixuxia@tencent.com>
Subject: Re: [PATCH] rtw88: coex: remove the unreached code in rtw_coex_set_tdma
Thread-Topic: [PATCH] rtw88: coex: remove the unreached code in
 rtw_coex_set_tdma
Thread-Index: AQHWupojIOQCHYBFVUSs8qBgiST6ganLdzgA
Date:   Tue, 17 Nov 2020 08:12:40 +0000
Message-ID: <1605600696.20048.11.camel@realtek.com>
References: <1605367343-11770-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1605367343-11770-1-git-send-email-kaixuxia@tencent.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA391B2213CAA64BAC339DA5BFC57AA1@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIwLTExLTE0IGF0IDE1OjIyICswMDAwLCB4aWFrYWl4dTE5ODdAZ21haWwuY29t
IHdyb3RlOg0KPiBGcm9tOiBLYWl4dSBYaWEgPGthaXh1eGlhQHRlbmNlbnQuY29tPg0KPiANCj4g
VGhlIHZhbHVlIG9mIHRoZSBib29sIHZhcmlhYmxlIGFwX2VuYWJsZSBpcyBhbHdheXMgZmFsc2Us
IHNvIHRoZSBmaXJzdA0KPiBpZiBicmFuY2ggaXMgdW5yZWFjaGVkIGNvZGUuIFJlbW92ZSBpdC4N
Cj4gDQo+IFJlcG9ydGVkLWJ5OiBUb3NrIFJvYm90IDx0ZW5jZW50X29zX3JvYm90QHRlbmNlbnQu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLYWl4dSBYaWEgPGthaXh1eGlhQHRlbmNlbnQuY29tPg0K
PiAtLS0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2NvZXguYyB8IDEy
ICstLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTEgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9jb2V4LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2Nv
ZXguYw0KPiBpbmRleCBhYTA4ZmQ3ZDlmY2QuLjljNzk2M2U0NTc1NSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9jb2V4LmMNCj4gQEAgLTg2MywxOCArODYzLDgg
QEAgc3RhdGljIHZvaWQgcnR3X2NvZXhfc2V0X3RkbWEoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwg
dTgNCj4gYnl0ZTEsIHU4IGJ5dGUyLA0KPiDCoAlzdHJ1Y3QgcnR3X2NvZXhfZG0gKmNvZXhfZG0g
PSAmY29leC0+ZG07DQo+IMKgCXN0cnVjdCBydHdfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5j
aGlwOw0KPiDCoAl1OCBwc190eXBlID0gQ09FWF9QU19XSUZJX05BVElWRTsNCj4gLQlib29sIGFw
X2VuYWJsZSA9IGZhbHNlOw0KDQpUaGUgdmFyaWFibGUgJ2FwX2VuYWJsZScgaXMgdXNlZCB0byBp
bmRpY2F0ZSBhIHZpZiBpcyBydW5uaW5nIGluIEFQIG1vZGUuDQpBdCB0aGUgZmlyc3QgY29leCB2
ZXJzaW9uLCBydHc4OCBkb2Vzbid0IHN1cHBvcnQgQVAgbW9kZSB5ZXQsIHNvIGFwX2VuYWJsZQ0K
aXMgc2V0IHRvIGZhbHNlLiBGb3Igbm93LCBBUCBtb2RlIGlzIHJlYWR5LCBhbmQgSSBjYW4gc2Vu
ZCBhIHBhdGNoIHRvIHNldA0KcHJvcGVyIHZhbHVlIGRlcGVuZHMgb24gdmlmIG1vZGUuDQoNClNp
bmNlIEknbSBzdWJtaXR0aW5nIGNvZXggcGF0Y2hlcyB0byB1cGdyYWRlIHRoZSBjb2RlLiBJbiBv
cmRlciB0byBhdm9pZA0KY29uZmxpY3RpbmcsIEknbGwgc2VuZCB0aGUgcGF0Y2ggdG8gc2V0IHBy
b3BlciBhcF9lbmFibGUgYWZ0ZXIgYWxsIG15IHBhdGNoZXMNCmFyZSBtZXJnZWQuDQoNCg0KPiAt
DQo+IC0JaWYgKGFwX2VuYWJsZSAmJiAoYnl0ZTEgJiBCSVQoNCkgJiYgIShieXRlMSAmIEJJVCg1
KSkpKSB7DQo+IC0JCWJ5dGUxICY9IH5CSVQoNCk7DQo+IC0JCWJ5dGUxIHw9IEJJVCg1KTsNCj4g
LQ0KPiAtCQlieXRlNSB8PSBCSVQoNSk7DQo+IC0JCWJ5dGU1ICY9IH5CSVQoNik7DQo+IMKgDQo+
IC0JCXBzX3R5cGUgPSBDT0VYX1BTX1dJRklfTkFUSVZFOw0KPiAtCQlydHdfY29leF9wb3dlcl9z
YXZlX3N0YXRlKHJ0d2RldiwgcHNfdHlwZSwgMHgwLCAweDApOw0KPiAtCX0gZWxzZSBpZiAoYnl0
ZTEgJiBCSVQoNCkgJiYgIShieXRlMSAmIEJJVCg1KSkpIHsNCj4gKwlpZiAoYnl0ZTEgJiBCSVQo
NCkgJiYgIShieXRlMSAmIEJJVCg1KSkpIHsNCj4gwqAJCWlmIChjaGlwLT5wc3RkbWFfdHlwZSA9
PSBDT0VYX1BTVERNQV9GT1JDRV9MUFNPRkYpDQo+IMKgCQkJcHNfdHlwZSA9IENPRVhfUFNfTFBT
X09GRjsNCj4gwqAJCWVsc2UNCj4gLS3CoA0KPiAyLjIwLjANCj4gDQoNCi0tLQ0KUGluZy1LZQ0K
DQo=
