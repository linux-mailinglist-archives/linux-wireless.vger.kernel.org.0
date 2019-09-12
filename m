Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05913B09A3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfILHnY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 03:43:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47539 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfILHnY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 03:43:24 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8C7hGNW005218, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8C7hGNW005218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 15:43:16 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0468.000; Thu, 12 Sep 2019 15:43:15 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH 2/2] rtw88: report RX power for each antenna
Thread-Topic: [PATCH 2/2] rtw88: report RX power for each antenna
Thread-Index: AQHVaTTdaq5/HwkqZUyeOZkd8ApRzqcnGx+AgACNUlA=
Date:   Thu, 12 Sep 2019 07:43:15 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18D2D2B@RTITMBSVM04.realtek.com.tw>
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
 <1568270355-29727-3-git-send-email-yhchuang@realtek.com>
 <CAB4CAwde2ciT8AtYOXP3NJw=fq3uano_GQYXNKjcL+M+hKeWhA@mail.gmail.com>
In-Reply-To: <CAB4CAwde2ciT8AtYOXP3NJw=fq3uano_GQYXNKjcL+M+hKeWhA@mail.gmail.com>
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

PiBGcm9tOiBDaHJpcyBDaGl1IA0KPiANCj4gT24gVGh1LCBTZXAgMTIsIDIwMTkgYXQgMjozOSBQ
TSA8eWhjaHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogWWFuLUhzdWFu
IENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBSZXBvcnQgY2hhaW5zIGFu
ZCBjaGFpbl9zaWduYWwgaW4gaWVlZTgwMjExX3J4X3N0YXR1cy4NCj4gPiBJdCBpcyB1c2VmdWwg
Zm9yIHByb2dyYW0gc3VjaCBhcyB0Y3BkdW1wIHRvIHNlZSBpZiB0aGUNCj4gPiBhbnRlbm5hcyBh
cmUgd2VsbCBjb25uZWN0ZWQvcGxhY2VkLg0KPiA+DQo+ID4gODgyMkMgaXMgYWJsZSB0byByZWNl
aXZlIENDSyByYXRlcyB3aXRoIDIgYW50ZW5uYXMsIHdoaWxlDQo+ID4gODgyMkIgY2FuIG9ubHkg
dXNlIDEgYW50ZW5uYSBwYXRoIHRvIHJlY2VpdmUgQ0NLIHJhdGVzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMmIuYyB8IDEg
Kw0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjJjLmMgfCA2
ICsrKy0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMgICAg
ICAgfCA1ICsrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcnR3ODgyMmIuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcnR3ODgyMmIuYw0KPiA+IGluZGV4IDU2ODAzM2EuLjA4NjExOTUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYi5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYi5jDQo+ID4g
QEAgLTc2Niw2ICs3NjYsNyBAQCBzdGF0aWMgdm9pZCBxdWVyeV9waHlfc3RhdHVzX3BhZ2UwKHN0
cnVjdCBydHdfZGV2DQo+ICpydHdkZXYsIHU4ICpwaHlfc3RhdHVzLA0KPiA+ICAgICAgICAgczgg
bWluX3J4X3Bvd2VyID0gLTEyMDsNCj4gPiAgICAgICAgIHU4IHB3ZGIgPSBHRVRfUEhZX1NUQVRf
UDBfUFdEQihwaHlfc3RhdHVzKTsNCj4gPg0KPiA+ICsgICAgICAgLyogODgyMkIgdXNlcyBvbmx5
IDEgYW50ZW5uYSB0byBSWCBDQ0sgcmF0ZXMgKi8NCj4gPiAgICAgICAgIHBrdF9zdGF0LT5yeF9w
b3dlcltSRl9QQVRIX0FdID0gcHdkYiAtIDExMDsNCj4gDQo+IEl0IG9ubHkgdXNlcyBQQVRIX0Eg
Zm9yIHJlY2VpdmluZyBDQ0sgcmF0ZXMgcGFja2V0cz8gVGhlIGNvbW1lbnQgc2VlbXMNCj4gbm90
IGNsZWFyIGVub3VnaC4NCj4gDQoNClllcywgaXQgY2FuIG9ubHkgdXNlIFBBVEhfQSwgc28gd2Ug
ZG9uJ3QgaGF2ZSBQV0RCX1tBfEJdIGZvciA4ODIyQi4NCg0KWWFuLUhzdWFuDQoNCg==
