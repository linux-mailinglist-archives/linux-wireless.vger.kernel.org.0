Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13EA78BE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 04:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfIDCb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 22:31:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36275 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfIDCb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 22:31:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x842ViBL016652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x842ViBL016652
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 4 Sep 2019 10:31:44 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Wed, 4 Sep
 2019 10:31:43 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>
Subject: RE: [PATCH 4/8] rtw88: 8822c: add FW IQK support
Thread-Topic: [PATCH 4/8] rtw88: 8822c: add FW IQK support
Thread-Index: AQHVTQyHeGrW/0lhJEuPz5bjYVAAaacZjO8AgAFnE8A=
Date:   Wed, 4 Sep 2019 02:31:42 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D18C6B3B@RTITMBSVM04.realtek.com.tw>
References: <1565174405-2689-5-git-send-email-yhchuang@realtek.com>
 <20190903125324.4CDC76085C@smtp.codeaurora.org>
In-Reply-To: <20190903125324.4CDC76085C@smtp.codeaurora.org>
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

PiANCj4gPHloY2h1YW5nQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogWWFuLUhz
dWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBm
b3IgZG9pbmcgSVFLIGluIGZpcm13YXJlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW4tSHN1
YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gDQo+IFRoZSBjb21taXQgbG9nIGRv
ZXMgbm90IGFuc3dlciAiV2h5PyIuIFdoYXQgaXMgSVFLIGFuZCBob3cgZG9lcyBpdCBoZWxwPw0K
PiANCj4gTm8gbmVlZCB0byByZXNlbmQsIEkgY2FuIHVwZGF0ZSB0aGUgY29tbWl0IGxvZyBidXQg
anVzdCBsZXQgbWUga25vdyB3aGF0IHRvDQo+IGFkZC4NCj4gDQoNCklkZWFsbHkgdGhlIFJGIGNv
bXBvbmVudCdzIEkvUSB2ZWN0b3JzIHNob3VsZCBiZSBvcnRob2dvbmFsLCBidXQgdXN1YWxseSB0
aGV5IGFyZSBub3QuDQpTbyB3ZSBuZWVkIHRvIGNhbGlicmF0ZSBmb3IgdGhlIFJGIGNvbXBvbmVu
dHMsIGV4LiBQQS9MTkEsIEFEQy9EQUMuDQoNCkFuZCBpZiB0aGUgSS9RIHZlY3RvcnMgYXJlIG1v
cmUgb3J0aG9nb25hbCwgdGhlIG1peGVkIHNpZ25hbCB3aWxsIGhhdmUgbGVzcyBkZXZpYXRpb24u
DQpUaGlzIGhlbHBzIHdpdGggdGhvc2UgcmF0ZXMgd2l0aCBoaWdoZXIgbW9kdWxhdGlvbiAoTUNT
OC05KSwgYmVjYXVzZSB0aGV5IGhhdmUgbW9yZQ0Kc3RyaWN0IEVWTS9TTlIgcmVxdWlyZW1lbnQu
IEFsc28gdGhlIGJldHRlciBvZiB0aGUgcXVhbGl0eSBvZiB0aGUgc2lnbmFsLCB0aGUgbG9uZ2Vy
IGl0DQpjYW4gcHJvcGFnYXRlLCBhbmQgdGhlIGJldHRlciB0aHJvdWdocHV0IHBlcmZvcm1hbmNl
IHdlIGNhbiBnZXQuDQoNCllhbi1Ic3Vhbg0KDQo=
