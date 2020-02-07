Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13F31553D1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGIkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 03:40:52 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42502 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGIkw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 03:40:52 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0178eeT9008499, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0178eeT9008499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 16:40:40 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 16:40:39 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 7 Feb 2020 16:40:39 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH v2] rtw88: Fix incorrect beamformee role setting
Thread-Topic: [PATCH v2] rtw88: Fix incorrect beamformee role setting
Thread-Index: AQHV3J13am0lYwY0X0+jN725/xeLYagOeF4AgADyhPA=
Date:   Fri, 7 Feb 2020 08:40:39 +0000
Message-ID: <d03928b308654704a360e73dd4441058@realtek.com>
References: <20200206032801.25835-1-yhchuang@realtek.com>
 <CAB4CAwe_uiCitczp2KYQ-H5gAVE_fPGr8GzRqnKAoXSxVw9meQ@mail.gmail.com>
In-Reply-To: <CAB4CAwe_uiCitczp2KYQ-H5gAVE_fPGr8GzRqnKAoXSxVw9meQ@mail.gmail.com>
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

PiBPbiBUaHUsIEZlYiA2LCAyMDIwIGF0IDExOjI4IEFNIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBUenUtRW4gSHVhbmcgPHRlaHVhbmdAcmVhbHRlay5jb20+
DQo+ID4NCj4gPiBJbiBhc3NvY2lhdGluZyBhbmQgY29uZmlndXJpbmcgYmVhbWZvcm1lZSwgYmZl
ZS0+cm9sZSBpcyBub3QNCj4gPiBjb3JyZWN0bHkgc2V0IGJlZm9yZSBydHdfY2hpcF9vcHM6OmNv
bmZpZ19iZmVlKCkuDQo+ID4gRml4IGl0IGJ5IHNldHRpbmcgaXQgY29ycmVjdGx5Lg0KPiA+DQo+
ID4gRml4ZXM6IDBiZDk1NTczNDFiNyAoInJ0dzg4OiBFbmFibGUgODAyLjExYWMgYmVhbWZvcm1l
ZSBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUenUtRW4gSHVhbmcgPHRlaHVhbmdAcmVh
bHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdA
cmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiB2MSAtPiB2Mg0KPiA+ICAgKiBjYW5ub3Qg
cHV0IGJmZWUtPnJvbGUgPSBSVFdfQkZFRV9OT05FIGFmdGVyIG91dF91bmxvY2sNCj4gPiAgICAg
cHV0IGl0IGVuY2xvc2VkIGJ5IGVsc2UNCj4gPg0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L2JmLmMgfCA4ICsrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9iZi5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9iZi5jDQo+ID4gaW5kZXggZmRhNzcxZDIzZjcxLi4wNzNjNzU0ZTll
NzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9i
Zi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9iZi5jDQo+
ID4gQEAgLTk5LDEwICs5OCwxMSBAQCB2b2lkIHJ0d19iZl9hc3NvYyhzdHJ1Y3QgcnR3X2RldiAq
cnR3ZGV2LCBzdHJ1Y3QNCj4gaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiA+ICAgICAgICAgICAgICAg
ICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgY2hpcC0+b3BzLT5jb25maWdfYmZlZShydHdk
ZXYsIHJ0d3ZpZiwgYmZlZSwgdHJ1ZSk7DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgICAgICAgICBiZmVlLT5yb2xlID0gUlRXX0JGRUVfTk9ORTsNCj4gPiAgICAgICAgIH0NCj4g
Pg0KPiANCj4gRG8gd2UgcmVhbGx5IG5lZWQgdGhpcyBgZWxzZWAgc2VjdGlvbj8gVGhlIGJmZWUt
PnJvbGUgaXMgb25seSBmb3INCj4gYGNvbmZpZ19iZmVlYCwgcmlnaHQ/IElmIHdlIGRvbid0DQo+
IG5lZWQgdG8gY29uZmlnX2JmZWUgZm9yIFJUV19CRkVFX05PTkUsIHRoZW4gd2UgZG9uJ3QgbmVl
ZCB0aGUgYGVsc2VgDQo+IHBhcnQuDQo+IA0KDQpSaWdodCwgaXQgbG9va3MgdW5uZWNlc3Nhcnkg
dG8gc2V0IGl0IHRvIE5PTkUgd2hpbGUgZGlzYXNzb2Mgd2lsbCBzZXQgaXQuDQpTbyBJIHRoaW5r
IHdlIGNhbiBqdXN0IHNraXAgdGhpcyAiZWxzZSIgc3RhdGVtZW50LCB3aWxsIHNlbmQgYSB2MyBs
YXRlci4NClRoYW5rcy4NCg0KWWFuLUhzdWFuDQo=
