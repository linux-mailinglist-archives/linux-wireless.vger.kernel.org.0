Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26B31AD460
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 04:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgDQCQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 22:16:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55913 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgDQCQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 22:16:44 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H2GapT6019509, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H2GapT6019509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 10:16:36 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 10:16:36 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 10:16:35 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 17 Apr 2020 10:16:35 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH v2] rtw88: set power trim according to efuse PG values
Thread-Topic: [PATCH v2] rtw88: set power trim according to efuse PG values
Thread-Index: AQHWE50mY6FaCN6+TU+B3bkrrH+fBqh7RrUAgAFOT4A=
Date:   Fri, 17 Apr 2020 02:16:35 +0000
Message-ID: <935082601aff4e7b986ebfe5177c9f12@realtek.com>
References: <20200416031407.5899-1-yhchuang@realtek.com>
 <20200416141922.0A56EC44791@smtp.codeaurora.org>
In-Reply-To: <20200416141922.0A56EC44791@smtp.codeaurora.org>
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

PiA8eWhjaHVhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBUenUtRW4gSHVh
bmcgPHRlaHVhbmdAcmVhbHRlay5jb20+DQo+ID4NCj4gPiA4ODIyQyBkZXZpY2VzIGhhdmUgcG93
ZXIgdHJpbSwgdGhlcm1hbCBhbmQgUEEgYmlhcyB2YWx1ZXMNCj4gPiBwcm9ncmFtbWVkIGluIGVm
dXNlLiBEcml2ZXIgc2hvdWxkIGNvbmZpZ3VyZSB0aGUgUkYgY29tcG9uZW50cw0KPiA+IGFjY29y
ZGluZyB0byB0aGUgdmFsdWVzLg0KPiA+DQo+ID4gSWYgdGhlIHBvd2VyIHRyaW0gaXMgbm90IGNv
bmZpZ3VyZWQsIHRoZW4gdGhlIGRldmljZXMgbWlnaHQgaGF2ZQ0KPiA+IGRpc3RvcnRpb24gb24g
dGhlIG91dHB1dCB0eCBwb3dlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFR6dS1FbiBIdWFu
ZyA8dGVodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW4tSHN1YW4gQ2h1
YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gDQo+IFlvdSBkaWRuJ3QgdXNlIHJlYWRfcG9s
bF90aW1lb3V0KCkgbGlrZSBDaHJpcyBzdWdnZXN0ZWQ/DQo+IA0KDQpNaXNzZWQgdGhhdCwgd2ls
bCByZXNlbmQgYW5vdGhlci4NCg0KWWVuLUhzdWFuDQo=
