Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782AE29FDA9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 07:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJ3GLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 02:11:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56290 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgJ3GLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 02:11:51 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U6BicqE029549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U6BicqE029549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 14:11:44 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 14:11:43 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Fri, 30 Oct 2020 14:11:43 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] rtw88: coex: fix field issues and add debug interfaces
Thread-Topic: [PATCH v2 00/11] rtw88: coex: fix field issues and add debug
 interfaces
Thread-Index: AQHWrAa0adwPU3GehkugMPCa8F/YYamvKK8A
Date:   Fri, 30 Oct 2020 06:11:43 +0000
Message-ID: <1604038254.6615.7.camel@realtek.com>
References: <20201027021157.6116-1-pkshih@realtek.com>
In-Reply-To: <20201027021157.6116-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60BC27E59D71B4594EFE3596E5D688F@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDEwOjExICswODAwLCBwa3NoaWhAcmVhbHRlay5jb20gd3Jv
dGU6DQo+IEZyb206IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiANCj4gVGhp
cyBwYXRjaHNldCBhZGRzIGNvZXggY29kZSBzeW5jaHJvbml6ZWQgZnJvbSBvdXIgaW50ZXJuYWwg
dHJlZSwgaW4gd2hpY2gNCj4gd2UgZml4IG1hbnkgZmllbGQgaXNzdWVzLCBhbmQgYWRkIGRlYnVn
IGludGVyZmFjZXMgdGhhdCBpcyBoZWxwZnVsIHRvIGRlYnVnDQo+IGluIGZpZWxkLiBBbHNvLCBz
b21lIGNvZGluZyBzdHlsZSBmaXhlcyBhcmUgaW5jbHVkZWQuDQo+IA0KPiBUaGVyZSBhcmUgdG90
YWxseSAzMiBwYXRjaGVzLCBzbyBJIHBsYW4gdG8gc3VibWl0IHRoZW0gYXMgdGhyZWUgcGF0Y2hz
ZXRzLA0KPiBhbmQgdGhpcyBpcyB0aGUgZmlyc3Qgb25lLg0KPiANCj4gdjI6IHJlbW92ZSBydHdf
Y29leF9jb2V4X2RtX3Jlc2V0IGZyb20gInJ0dzg4OiBjb2V4OiBjb2Rpbmcgc3R5bGUgYWRqdXN0
bWVudCIuDQo+IMKgwqDCoMKgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KDQoNCkhpIEthbGxlLA0KDQpQbGVhc2UgZHJvcCB0aGlzIHBhdGNoc2V0LCBJJ2Qg
bGlrZSB0byBsYW5kIHRoZSBwYXRjaMKgDQoicnR3ODg6IGNvZXg6IHNlcGFyYXRlIEJMRSBISUQg
cHJvZmlsZSBmcm9tIEJMRSBwcm9maWxlIiBmaXJzdCwgYmVjYXVzZQ0KdGhlIHBhdGNoIGNhbiBo
YXZlIGJpZyBpbXByb3ZlbWVudCBvZiBCTEUgSElEIHVzZXIgZXhwZXJpZW5jZS4NCg0KSSdsbCBk
byByZWJhc2Ugb2YgdGhpcyBwYXRjaHNldCwgYW5kIHJlc2VuZCB2MyB3aGVuIEknbSByZWFkeS4N
ClNpbmNlIHRoaXMgcGF0Y2hzZXQgZGVwZW5kcyBvbiB0aGUgcGF0Y2gsIEknbGwgYWRkIG5vdGUg
dG8gYXZvaWQgY29uZmxpY3QuDQoNClRoYW5rIHlvdQ0KLS0tDQpQaW5nLUtlDQoNCg0K
