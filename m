Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874A6233D83
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgGaCyA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 22:54:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47556 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgGaCx7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 22:53:59 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06V2roXgB009662, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06V2roXgB009662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 10:53:50 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:53:50 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:53:50 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 31 Jul 2020 10:53:50 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] rtlwifi: btcoex: use %*ph to print small buffer
Thread-Topic: [PATCH v1] rtlwifi: btcoex: use %*ph to print small buffer
Thread-Index: AQHWZofDZNBgqePhnESdHtgZI+Ji8qkgeHYA
Date:   Fri, 31 Jul 2020 02:53:50 +0000
Message-ID: <1596164030.9996.0.camel@realtek.com>
References: <20200730154026.39901-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200730154026.39901-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F2E85860279904FB54A2DFB1AE0B7B1@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTMwIGF0IDE1OjQwICswMDAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFVzZSAlKnBoIGZvcm1hdCB0byBwcmludCBzbWFsbCBidWZmZXIgYXMgaGV4IHN0cmluZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29A
bGludXguaW50ZWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQoNCj4gLS0tDQo+IMKgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYnRj
b2V4aXN0L2hhbGJ0Y291dHNyYy5jwqDCoMKgfCA2ICsrLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL2J0Y29leGlzdC9oYWxidGNvdXRzcmMu
Yw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFs
YnRjb3V0c3JjLmMNCj4gaW5kZXggYTQ5NDBhMzg0MmRlLi4wODUwYzVkZGFkMTQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9idGNvZXhpc3QvaGFs
YnRjb3V0c3JjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZp
L2J0Y29leGlzdC9oYWxidGNvdXRzcmMuYw0KPiBAQCAtODk0LDExICs4OTQsOSBAQCBzdGF0aWMg
dm9pZCBoYWxidGNfZGlzcGxheV93aWZpX3N0YXR1cyhzdHJ1Y3QgYnRjX2NvZXhpc3QNCj4gKmJ0
Y29leGlzdCwNCj4gwqAJCcKgwqDCoChsb3dfcG93ZXIgPyAiLCAzMmsiIDogIiIpKTsNCj4gwqAN
Cj4gwqAJc2VxX3ByaW50ZihtLA0KPiAtCQnCoMKgwqAiXG4gJS0zNXMgPSAlMDJ4ICUwMnggJTAy
eCAlMDJ4ICUwMnggJTAyeCAoMHgleC8weCV4KSIsDQo+ICsJCcKgwqDCoCJcbiAlLTM1cyA9ICU2
cGggKDB4JXgvMHgleCkiLA0KPiDCoAkJwqDCoMKgIlBvd2VyIG1vZGUgY21kKGxwcy9ycHdtKSIs
DQo+IC0JCcKgwqDCoGJ0Y29leGlzdC0+cHdyX21vZGVfdmFsWzBdLCBidGNvZXhpc3QtPnB3cl9t
b2RlX3ZhbFsxXSwNCj4gLQkJwqDCoMKgYnRjb2V4aXN0LT5wd3JfbW9kZV92YWxbMl0sIGJ0Y29l
eGlzdC0+cHdyX21vZGVfdmFsWzNdLA0KPiAtCQnCoMKgwqBidGNvZXhpc3QtPnB3cl9tb2RlX3Zh
bFs0XSwgYnRjb2V4aXN0LT5wd3JfbW9kZV92YWxbNV0sDQo+ICsJCcKgwqDCoGJ0Y29leGlzdC0+
cHdyX21vZGVfdmFsLA0KPiDCoAkJwqDCoMKgYnRjb2V4aXN0LT5idF9pbmZvLmxwc192YWwsDQo+
IMKgCQnCoMKgwqBidGNvZXhpc3QtPmJ0X2luZm8ucnB3bV92YWwpOw0KPiDCoH0NCj4gLS3CoA0K
PiAyLjI3LjANCj4gDQoNCg0KDQo=
