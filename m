Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68A1C65E7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgEFCfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 22:35:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60925 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEFCfn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 22:35:43 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0462ZM8D0011117, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0462ZM8D0011117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 6 May 2020 10:35:22 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 6 May 2020 10:35:21 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Wed, 6 May 2020 10:35:21 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT USB suspend
Thread-Topic: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT
 USB suspend
Thread-Index: AQHWFIxwWk+IgF2xvEuU+RV8JviaE6iZH+SAgAFUOIA=
Date:   Wed, 6 May 2020 02:35:21 +0000
Message-ID: <c7083dc760464c1a9017888457c1718d@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
 <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
In-Reply-To: <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
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

PiBPbiAyMDIwLTA0LTE3IDE1OjQ2OjQxIFsrMDgwMF0sIHloY2h1YW5nQHJlYWx0ZWsuY29tIHdy
b3RlOg0KPiA+IEZyb206IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+DQo+
ID4gV2l0aG91dCB0aGlzIHBhdGNoLCB3aWZpIGNhcmQgY2FuJ3QgaW5pdGlhbGl6ZSBwcm9wZXJs
eSBkdWUgdG8gQlQgaW4gVVNCDQo+ID4gc3VzcGVuZCBzdGF0ZS4gU28sIHdlIGRpc2FibGUgQlQg
VVNCIHN1c3BlbmQgKHdha2V1cCkgaW4gc2h1dGRvd24gY2FsbGJhY2sNCj4gPiB0aGF0IGlzIHRo
ZSBtb21lbnQgYmVmb3JlIHJlYm9vdGluZy4gVG8gc2F2ZSBCVCBVU0IgcG93ZXIsIHdlIGNhbid0
IGRvIHRoaXMNCj4gPiBpbiAncmVtb3ZlJyBjYWxsYmFjay4NCj4gDQo+IFNvIHlvdSBjYW4ndCBp
bml0aWFsaXplIHRoZSBVU0IgcGFydCBiZWNhdXNlIGl0IGlzIGluIHN1c3BlbmQgYW5kIHRoZQ0K
PiBvbmx5IHdheSB0byBhdm9pZCBpdCB0byBkaXNhYmxlIGl0IG9uIHRoZSBQQ0kgc2lkZS4gVGhh
dCBtZWFucyB5b3UgZG9uJ3QNCj4gc2VlIGl0IGVudW1lcmF0ZWQgb24gdGhlIFVTQiBidXMgYXQg
YWxsPw0KDQpZZXMsIGlmIHdlIGRvbid0IGRpc2FibGUgaXQgb24gUENJIHNpZGUsIHRoZW4gdGhl
IFVTQiBwYXJ0IGNhbm5vdCBiZQ0KcHJvYmVkIG9uIFVTQiBidXMuDQoNCj4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+IA0KPiBTZWJh
c3RpYW4NCj4gDQoNClllbi1Ic3Vhbg0K
