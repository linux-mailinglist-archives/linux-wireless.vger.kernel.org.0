Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC5DA40D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfJQCzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 22:55:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33268 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392045AbfJQCzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 22:55:31 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9H2tOZS009506, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9H2tOZS009506
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 10:55:25 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 17 Oct
 2019 10:55:24 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] rtw88: update regulatory settings implementaion
Thread-Topic: [PATCH v2 4/6] rtw88: update regulatory settings implementaion
Thread-Index: AQHVhB3i85C44Tj9vUuCv01IpIQXlqdc9gcAgAEr8NA=
Date:   Thu, 17 Oct 2019 02:55:23 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1900CF3@RTITMBSVM04.realtek.com.tw>
References: <20191016123301.2649-1-yhchuang@realtek.com>
 <20191016123301.2649-5-yhchuang@realtek.com>
 <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com>
In-Reply-To: <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com>
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

RnJvbTogQnJpYW4gTm9ycmlzDQo+IA0KPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBhdCA1OjMzIEFN
IDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBhbHNvIHN1cHBvcnRzIHVz
ZXIgcmVndWxhdG9yeSBoaW50cywgYW5kIGl0IHNob3VsZCBvbmx5IGJlDQo+ID4gZW5hYmxlZCBm
b3Igc3BlY2lmaWMgZGlzdHJpYnV0aW9ucyB0aGF0IG5lZWQgdGhpcyB0byBjb3JyZWN0DQo+ID4g
dGhlIGNhcmRzIHJlZ2x1dG9yeS4NCj4gDQo+IHMvY2FyZHMvY2FyZCdzLw0KPiBzL3JlZ2x1dG9y
eS9yZWd1bGF0b3J5Lw0KDQpUeXBvIHNob3VsZCBiZSBmaXhlZCBpbiB2MyA6KQ0KDQo+IA0KPiBU
aGVyZSBzaG91bGQgYmUgYSBwcmV0dHkgaGlnaCBiYXIgZm9yIGludHJvZHVjaW5nIGVpdGhlciBu
ZXcgQ09ORklHXyoNCj4gb3B0aW9ucyBvciBtb2R1bGUgcGFyYW1ldGVycywgaW4gbXkgb3Bpbmlv
biwgYW5kIEknbSBub3Qgc3VyZSB5b3UNCj4gcmVhbGx5IHNhdGlzZmllZCBpdC4gV2h5ICJzaG91
bGQgb25seSBiZSBlbmFibGVkIiBieSBjZXJ0YWluDQo+IGRpc3RyaWJ1dGlvbnM/IFlvdXIgb3Bp
bmlvbj8gSWYgaXQncyB0aGUgdGVjaG5pY2FsIGxpbWl0YXRpb24geW91DQo+IHJlZmVyIHRvICgi
ZWZ1c2Ugc2V0dGluZ3MiKSwgdGhlbiBqdXN0IGRldGVjdCB0aGUgZWZ1c2UgYW5kIHByZXZlbnQN
Cj4gdXNlciBoaW50cyBvbmx5IG9uIHRob3NlIG1vZHVsZXMuDQo+IA0KDQpCZWNhdXNlIHRoZSBl
ZnVzZS9tb2R1bGUgZG9lcyBub3QgY29udGFpbiB0aGUgaW5mb3JtYXRpb24gaWYgdGhlDQp1c2Vy
J3MgaGludCBpcyBhbGxvd2VkLiBCdXQgc29tZXRpbWVzIGRpc3RyaWJ1dGlvbnMgcmVxdWlyZSB0
byBzZXQgdGhlDQpyZWd1bGF0b3J5IHZpYSAiTkw4MDIxMV9DTURfU0VUX1JFRyIuDQpTbyB3ZSBh
cmUgbGVhdmluZyB0aGUgQ09ORklHXyogaGVyZSBmb3Igc29tZSByZWFzb24gdGhhdCBuZWVkcyBp
dC4NCg0KWWFuLUhzdWFuDQo=
