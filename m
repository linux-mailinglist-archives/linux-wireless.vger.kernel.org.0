Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0FA6501
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfICJTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 05:19:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42606 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfICJTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 05:19:54 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x839Jkbi029061, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x839Jkbi029061
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:19:46 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 3 Sep 2019
 17:19:45 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Daniel Drake <drake@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        =?utf-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Brian Norris" <briannorris@chromium.org>,
        "gojun077@gmail.com" <gojun077@gmail.com>
Subject: RE: [PATCH v3] rtw88: pci: enable MSI interrupt
Thread-Topic: [PATCH v3] rtw88: pci: enable MSI interrupt
Thread-Index: AQHVYVxwzMgBel6OxUCqZGVA0OyFQKcXqzMAgAIDTNA=
Date:   Tue, 3 Sep 2019 09:19:44 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18C3659@RTITMBSVM04.realtek.com.tw>
References: <1567407757-26951-1-git-send-email-yhchuang@realtek.com>
 <CAD8Lp44L06OAXvoP=jU9Tt0YgfWrRmTN0v4Jq_gjxrOTYn5XwQ@mail.gmail.com>
In-Reply-To: <CAD8Lp44L06OAXvoP=jU9Tt0YgfWrRmTN0v4Jq_gjxrOTYn5XwQ@mail.gmail.com>
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

PiBPbiBNb24sIFNlcCAyLCAyMDE5IGF0IDM6MDIgUE0gPHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPiBGcm9tOiBZdS1ZZW4gVGluZyA8c3RldmVudGluZ0ByZWFsdGVrLmNvbT4NCj4g
Pg0KPiA+IE1TSSBpbnRlcnJ1cHQgc2hvdWxkIGJlIGVuYWJsZWQgb24gY2VydGFpbiBwbGF0Zm9y
bS4NCj4gPg0KPiA+IEFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgZGlzYWJsZV9tc2kgdG8gZGlzYWJs
ZSBNU0kgaW50ZXJydXB0LA0KPiA+IGRyaXZlciB3aWxsIHRoZW4gdXNlIGxlZ2FjeSBpbnRlcnJ1
cHQgaW5zdGVhZC4NCj4gPg0KPiA+IE9uZSBjb3VsZCByZWJpbmQgdGhlIFBDSSBkZXZpY2UsIHBy
b2JlKCkgd2lsbCBwaWNrIHVwIHRoZQ0KPiA+IG5ldyB2YWx1ZSBvZiB0aGUgbW9kdWxlIHBhcmFt
ZXRlci4gU3VjaCBhczoNCj4gPg0KPiA+ICAgICBlY2hvICcwMDAwOjAxOjAwLjAnID4gL3N5cy9i
dXMvcGNpL2RyaXZlcnMvcnR3X3BjaS91bmJpbmQNCj4gPiAgICAgZWNobyAnMDAwMDowMTowMC4w
JyA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzL3J0d19wY2kvYmluZA0KPiA+DQo+ID4gVGVzdGVkLWJ5
OiBKw6FuIFZlc2Vsw70gPGphbm8udmVzZWx5QGdtYWlsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+IFJldmlld2VkLWJ5OiBE
YW5pZWwgRHJha2UgPGRyYWtlQGVuZGxlc3NtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdS1Z
ZW4gVGluZyA8c3RldmVudGluZ0ByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW4t
SHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCg0KUmViYXNlZCBhbmQgc2VudC4g
UGxlYXNlIGNoZWNrIGl0IGFuZCBzZWUgaWYgSSd2ZSBkb25lIGFueXRoaW5nIHdyb25nIDopDQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMTI3NDUzLw0KDQpUaGFua3MsDQpZ
YW4tSHN1YW4NCg==
