Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC62F2623
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 03:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbhALCOv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 21:14:51 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47550 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhALCOv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 21:14:51 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10C2E5S80015295, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs02.realtek.com.tw[172.21.6.95])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10C2E5S80015295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 10:14:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 10:14:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 10:14:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Tue, 12 Jan 2021 10:14:04 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        DeanKu <ku920601@realtek.com>
Subject: Re: [PATCH] rtw88: coex: set 4 slot TDMA for BT link and WL busy
Thread-Topic: [PATCH] rtw88: coex: set 4 slot TDMA for BT link and WL busy
Thread-Index: AQHW3l0fSk9TvQGSsEWWqiSgMzzJ3qoiYRRXgABtHwA=
Date:   Tue, 12 Jan 2021 02:14:04 +0000
Message-ID: <1610417610.3495.1.camel@realtek.com>
References: <20201230033602.13636-1-pkshih@realtek.com>
         <87ft37k8fh.fsf@codeaurora.org>
In-Reply-To: <87ft37k8fh.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2466BC8715DD62439C59077EB781EC8A@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTExIGF0IDExOjQxICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBUbyBwcm90
ZWN0IGJvdGggb2YgV0wvQlQgcGVyZm9ybWFuY2Ugd2hpbGUgQlQgaXMgdW5kZXIgcmUtbGluayBz
dGF0ZS4NCj4gPiA0LXNsb3QgbW9kZSBURE1BIGNhbiBtYWtlIHRoZSByZS1saW5rIG1vcmUgc2Vu
c2l0aXZlIGFuZCBtaXRpZ2F0ZSB0aGUgV0wNCj4gPiB0aHJvdWdocHV0IGRyb3AuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaGluZy1UZSBLdSA8a3U5MjA2MDFAcmVhbHRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBX
aG8gc2hvdWxkIGJlIG1hcmtlZCBhcyB0aGUgYXV0aG9yLCBJIGd1ZXNzIENoaW5nLVRlPyBUaGVu
IEZyb20gZmllbGQgaXMNCj4gbWlzc2luZy4NCj4gDQoNCkl0IHNob3VsZCBiZSBDaGluZy1UZS4g
SSBzZW50IHYyIHRvIGZpeCBpdC4NClRoYW5rIHlvdQ0KDQotLS0NClBpbmctS2UNCg0K
