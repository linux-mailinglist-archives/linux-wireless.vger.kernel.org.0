Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95DA159F41
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 03:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBLC4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 21:56:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55831 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgBLC4K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 21:56:10 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01C2tvYI029249, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01C2tvYI029249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 10:55:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 10:55:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Feb 2020 10:55:56 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 12 Feb 2020 10:55:56 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Justin Capella <justincapella@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     Brian Norris <briannorris@chromium.org>,
        Chris Chiu <chiu@endlessm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
Thread-Topic: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
Thread-Index: AQHV21OHHItZDat19kepRGReIXwWz6gOfeMAgAEiYICAABDUgIAAAkOAgAABKwCAAWSY3YAAaeIAgAVjDSA=
Date:   Wed, 12 Feb 2020 02:55:56 +0000
Message-ID: <2c91e4e7b36d42a8abad6ae356c2869c@realtek.com>
References: <20200204120614.28861-1-yhchuang@realtek.com>
 <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
 <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
 <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
 <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
 <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
 <87wo8xxueg.fsf@kamboji.qca.qualcomm.com>
 <CAMrEMU-nM1O_iJPVgGg2pL6JYWMdRKdPGe5N2rkfOihdmTeMaw@mail.gmail.com>
In-Reply-To: <CAMrEMU-nM1O_iJPVgGg2pL6JYWMdRKdPGe5N2rkfOihdmTeMaw@mail.gmail.com>
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

DQo+IFdvdWxkIHNvbWUgb3RoZXIgcGllY2Ugb2YgdGhlIHN0YWNrIGNvdWxkIGRlY2lkZSB0byB1
c2Ugb3Igbm90IHVzZSBhZ2dyZWdhdGlvbiBmb3IgYSBnaXZlbiBiYW5kL3ZpZi9zdGE/IE1heWJl
IGp1c3Qgc2VtYW50aWNzIGJ1dCBteSB0aG91Z2h0IHdhcyB0aGUgZHJpdmVyIHJldHVybmluZyBm
YWxzZSBtYWtlcyBpdCBzZWVtIGluY2FwYWJsZSBvZiBpdC4NCj4gSSBhZ3JlZSBhYm91dCBub3Qg
cG9sbHV0aW5nIHRoZSBtb2R1bGUgcGFyYW1ldGVycy4gSSdsbCBoYXZlIGEgbG9vayBhdCB0aGUg
b3V0IG9mIHRyZWUgc3R1ZmYuIFRob3VnaHRzIG9uIGRlYnVnZnMga25vYnMsIG5vdCBuZWNlc3Nh
cmlseSBwYXRjaCBzcGVjaWZpYyBqdXN0IGluIGdlbmVyYWw/wqANCg0KPiBPbiBTYXQsIEZlYiA4
LCAyMDIwLCAyOjA5IEFNIEthbGxlIFZhbG8gPGt2YWxvQGNvZGVhdXJvcmEub3JnPiB3cm90ZToN
Cj4+IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPiB3cml0ZXM6DQo+Pj4g
T24gRnJpLCBGZWIgNywgMjAyMCBhdCAxMjo0OCBQTSBKdXN0aW4gQ2FwZWxsYSA8anVzdGluY2Fw
ZWxsYUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiBJIHVuZGVyc3RhbmQsIEknbSBzdWdnZXN0aW5n
IGRpc2FibGUgYnkgZGVmYXVsdCBidXQgb3B0aW9uIHRvIHJlLWVuYWJsZQ0KPj4+DQo+Pj4gQWgs
IE9LLiBTZWVtcyByZWFzb25hYmxlLCBJIHN1cHBvc2UsIGFsdGhvdWdoIEkgZG9uJ3QgcmVjYWxs
IEthbGxlDQo+Pj4gaGF2aW5nIGEgcGFydGljdWxhcmx5LWhpZ2ggb3BpbmlvbiBvZiBtb2R1bGUg
cGFyYW1ldGVycyBmb3IgdHdlYWtpbmcNCj4+PiBjb3JlIDgwMi4xMSBwcm90b2NvbCBiZWhhdmlv
cnMuDQoNCj4+IFllYWgsIGV4YWN0bHkuIEFuZCB0aGUgbnVtYmVyIG9mIG1vZHVsZSBwYXJhbWV0
ZXJzIGEgZHJpdmVyIGhhcyBzaG91bGQNCj4+IGJlIG1pbmltaXNlZC4gSSBrbm93IG91dC1vZi10
cmVlIHZlbmRvciBkcml2ZXJzIGhhdmUgaW5pIGZpbGVzIHdpdGggMTAwDQo+PiBkaWZmZXJlbnQg
a25vYnMsIGJ1dCBJIGRvbid0IHRoaW5rIG1vZHVsZSBwYXJhbWV0ZXJzIHNob3VsZCBiZQ0KPj4g
ZXF1aXZhbGVudCB0byBpbmkgZmlsZXMuDQoNCk1vZHVsZSBwYXJhbWV0ZXJzIGFyZSByZWFsbHkg
Z29vZCBmb3IgbWUsIHRvby4gQnV0IHdlJ3ZlIGhhZCBkaXNjdXNzaW9uDQpiZWZvcmUgd2l0aCBL
YWxsZSBhbmQgQnJpYW4sIHRoZXkgYm90aCB3ZXJlIHRyeWluZyBoYXJkIHRvIGF2b2lkIG1vZHVs
ZQ0KcGFyYW1ldGVycy4NCg0KU28sIEkgdGhpbmsgS2FsbGUgYW5kIEJyaWFuIGRvbid0IHJlY29t
bWVuZCB1c2luZyBtb2R1bGUgcGFyYW1ldGVycy4NCkFuZCBJIHRoaW5rIGp1c3QgZGlzYWJsZSBp
dCBvbiAyLjRHIGlzIE9LLCB0aGVyZSdzIG5vIG5lZWQgdG8gZW5hYmxlIGl0IGZvcg0KdGhvc2Ug
c3VwcG9ydGVkIDJ4MiBkZXZpY2VzLCB1bmxlc3Mgd2UgYXJlIGdvaW5nIHRvIHN1cHBvcnQgM3gz
LzR4NA0KZGV2aWNlcy4gSWYgdGhhdCBoYXBwZW5zLCB3ZSBjYW4gYWRkIGNvbmRpdGlvbnMgZm9y
IHRob3NlIDN4My80eDQuDQoNCllhbi1Ic3Vhbg0K
