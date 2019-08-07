Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44CE848EE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfHGJx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 05:53:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53701 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfHGJx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 05:53:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x779rBL7026634, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x779rBL7026634
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 7 Aug 2019 17:53:11 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Wed, 7 Aug
 2019 17:53:11 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Subject: RE: [PATCH v2 2/2] rtw88: RTL8822C: add WoW firmware v7.3
Thread-Topic: [PATCH v2 2/2] rtw88: RTL8822C: add WoW firmware v7.3
Thread-Index: AQHVTPzxbrKftPnACEGB7zXG6SB0sabu5jCAgACJm4A=
Date:   Wed, 7 Aug 2019 09:53:10 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D188A068@RTITMBSVM04.realtek.com.tw>
References: <1565167700-22501-1-git-send-email-yhchuang@realtek.com>
 <1565167700-22501-2-git-send-email-yhchuang@realtek.com>
 <3307e4b7-c92d-e1d2-b896-26e45fb69a9b@broadcom.com>
In-Reply-To: <3307e4b7-c92d-e1d2-b896-26e45fb69a9b@broadcom.com>
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

PiBGcm9tOiBBcmVuZCBWYW4gU3ByaWVsIFttYWlsdG86YXJlbmQudmFuc3ByaWVsQGJyb2FkY29t
LmNvbV0NCj4gDQo+IE9uIDgvNy8yMDE5IDEwOjQ4IEFNLCB5aGNodWFuZ0ByZWFsdGVrLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBZYW4tSHN1YW4gQ2h1YW5nIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4N
Cj4gPg0KPiA+IEFkZCBXb1cgZmlybXdhcmUgdG8gc3VwcG9ydCBlbnRlcmluZyBXYWtlIG9uIFdp
cmVsZXNzTEFOIG1vZGUNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbi1Ic3VhbiBDaHVhbmcg
PHloY2h1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gdjEgLT4gdjINCj4gPiAg
ICAgKiB1cGRhdGUgV0hFTkNFIGZpbGUgZm9yIG5ldyBhZGRlZCBmaXJtd2FyZQ0KPiA+DQo+ID4g
ICBXSEVOQ0UgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIHJ0dzg4L3J0dzg4MjJj
X3dvd19mdy5iaW4gfCBCaW4gMCAtPiAxMzg3MjAgYnl0ZXMNCj4gPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSBydHc4OC9ydHc4ODIy
Y193b3dfZncuYmluDQo+IA0KPiBKdXN0IHdvbmRlcmluZzogSXMgdGhpcyBhIGdvb2QgYXBwcm9h
Y2g/IFdoYXQgZmlybXdhcmUgc2hvdWxkIGRpc3Ryb3MNCj4gcGljaz8gSXMgdGhlcmUgYSB0cmFk
ZS1vZmYgYWZmZWN0aW5nIG90aGVyIHdpZmkgZnVuY3Rpb25hbGl0eSB3aGVuIHVzaW5nDQo+IFdv
VyBmaXJtd2FyZT8NCj4gDQoNCklmIGRpc3Ryb3Mgd2FudCB0byB1c2UgV09XLCB0aGV5IHNob3Vs
ZCBwaWNrIGJvdGguDQoNCkZvciBSZWFsdGVrIGRldmljZXMgc3VjaCBhcyBSVEw4ODIyQ0UsIGl0
IG5lZWRzIHRvICJjaGFuZ2UvcmUtZG93bmxvYWQiDQp0aGUgd293IGZpcm13YXJlIHRvIHN1c3Bl
bmQgd2l0aCBXT1cgZnVuY3Rpb25hbGl0aWVzLiBXaGVuIHJlc3VtZSwNCnN3aXRjaCBiYWNrIHRv
IG5vcm1hbCBmaXJtd2FyZSB0byBydW4gIm5vcm1hbGx5Ii4NCg0KSSB0aGluayB0aGUgcmVhc29u
IGlzIHRoZSBmaXJtd2FyZSBzaXplIHJlc3RyaWN0aW9uLiBGb3IgbmV3ZXIgZGV2aWNlcywNCm1h
eWJlIHRoZXJlIGlzIGEgbGFyZ2VyIHNwYWNlIGZvciBmaXJtd2FyZSwgYW5kIHdlIGRvbid0IG5l
ZWQgdG8gc3dhcA0KdGhlIEZXIGxpa2UgdGhpcyA6KQ0KDQpZYW4tSHN1YW4NCg==
