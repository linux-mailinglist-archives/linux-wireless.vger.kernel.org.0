Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D93EBC45
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 04:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfKADNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 23:13:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55997 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKADNw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 23:13:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA13Dge8006142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA13Dge8006142
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Nov 2019 11:13:43 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 1 Nov 2019
 11:13:42 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "g.schlmm@googlemail.com" <g.schlmm@googlemail.com>
Subject: RE: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Topic: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Thread-Index: AQHVixdU7Df1/OOTokC0rqDmBUERUKdz5d2AgACHtpCAAEH+AIAA/jhQ
Date:   Fri, 1 Nov 2019 03:13:41 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D19159DA@RTITMBSVM04.realtek.com.tw>
References: <20191025093345.22643-4-yhchuang@realtek.com>
 <20191031075911.3CCB86079C@smtp.codeaurora.org>
 <F7CD281DE3E379468C6D07993EA72F84D1914F4C@RTITMBSVM04.realtek.com.tw>
 <CA+ASDXPzLJ0OkuN0-BHqxGSBuVqQg6=eyg+PizLTCj+5bJ_5kw@mail.gmail.com>
In-Reply-To: <CA+ASDXPzLJ0OkuN0-BHqxGSBuVqQg6=eyg+PizLTCj+5bJ_5kw@mail.gmail.com>
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

PiANCj4gT24gVGh1LCBPY3QgMzEsIDIwMTkgYXQgMToxNyBBTSBUb255IENodWFuZyA8eWhjaHVh
bmdAcmVhbHRlay5jb20+DQo+IHdyb3RlOg0KPiA+IE9yIEkgc2hvdWxkIGp1c3QgY2hhbmdlIHRo
ZQ0KPiA+IHZhbHVlIHRvIGEgYmV0dGVyIG9uZS4gQnkgb3VyIGV4cGVyaWVuY2UsIHNldCB0aGlz
IHRvIDUwIGlzIGEgbW9yZSByZWFzb25hYmxlDQo+ID4gdmFsdWUsIHN1Y2ggdGhhdCBzb21lIHdl
YiBzdXJmaW5nIG9yIGJhY2tncm91bmQgdHJhZmZpYyB3b3VsZG4ndCBtYWtlIHRoZQ0KPiA+IGRy
aXZlciB0byBsZWF2ZSBQUyBtb2RlLg0KPiANCj4gRldJVywgSSB0aGluayBjaG9vc2luZyBhIG1v
cmUgcmVhc29uYWJsZSBkZWZhdWx0IGlzIGRlZmluaXRlbHkgYSBnb29kDQo+IHN0YXJ0LCBhcyBs
b25nIGFzIHRoaXMgY2hvaWNlIGRvZXNuJ3QgaGF2ZSBodWdlIGRvd25zaWRlcy4NCj4gDQo+IEBL
YWxsZTogRllJLCB0aGlzIChzZXQgdG8gNTApIGlzIGV4YWN0bHkgdGhlIGNoYW5nZSB0aGF0IFRv
bnkgaXMNCj4gcmVjb21tZW5kaW5nIHRvIG1lIGZvciBteSBkaXN0cm8sIGFuZCBJIGhhdmUgdGhl
IHNhbWUgcXVhbG1zIGFib3V0DQo+IHN1cHBvcnRpbmcgYSBncm93aW5nIG51bWJlciBvZiBtb2R1
bGUgcGFyYW1ldGVyIHR3ZWFrcyBsaWtlIHRoaXMuIFNvLA0KPiB0aGFua3MgZm9yIHB1c2hpbmcg
YmFjayA6KQ0KPiANCj4gQnJpYW4NCj4gDQoNCkkgd2FzIGFmcmFpZCBvZiB5b3UgdGhpbmtpbmcg
dGhhdCBzZXR0aW5nIHRoaXMgdG8gNTAgaXMgYSBzdHJhbmdlIHRoaW5nLg0KQnV0IGl0IHNlZW1z
IGxpa2UgeW91J2QgcHJlZmVyIHRvIGNoYW5nZSB0aGUgZGVmYXVsdCB2YWx1ZSBpbnN0ZWFkIG9m
IGFkZGluZyBhDQptb2R1bGUgcGFyYW1ldGVyIHRvIGNvbnRyb2wgaXQuIEkgdGhpbmsgd2UgY2Fu
IGRyb3AgdGhpcyBvbmUgYW5kIEkgd2lsbCBzZW5kDQphIHBhdGNoIHRvIGNoYW5nZSB0aGUgZGVm
YXVsdCB2YWx1ZSB0byA1MC4NCg0KWWFuLUhzdWFuDQo=
