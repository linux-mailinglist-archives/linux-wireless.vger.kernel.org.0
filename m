Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4652968AA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 05:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460299AbgJWDOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 23:14:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50253 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460297AbgJWDOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 23:14:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N3DcwZ6001537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb05.realtek.com.tw[172.21.6.98])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N3DcwZ6001537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 11:13:38 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 11:13:38 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 11:13:38 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Fri, 23 Oct 2020 11:13:38 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     "'Larry Finger'" <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     David Rubio <david.alejandro.rubio@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Topic: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Index: AQHWn+l1M4JR4F24I0SZAkWf/gzk8qmTwKwAgAEJzzD//4MXAIAFxLuAgAMLTxOAAZILAIAEf+iKgAAhYwCAAUBpoA==
Date:   Fri, 23 Oct 2020 03:13:38 +0000
Message-ID: <d6fecd1e5d7c4ba7a84494a61946c33a@realtek.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com>
 <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net>
 <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
 <87a6we7qna.fsf@codeaurora.org>
 <fae0b720-bc94-b380-baa0-08a3286fb2cf@lwfinger.net>
In-Reply-To: <fae0b720-bc94-b380-baa0-08a3286fb2cf@lwfinger.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.231]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpGcm9tOiBMYXJyeSBGaW5nZXIgPGxhcnJ5LmZpbmdlckBnbWFpbC5jb20+IE9uIEJlaGFsZiBP
ZiBMYXJyeSBGaW5nZXINCj4gDQo+IE9uIDEwLzIyLzIwIDEyOjUzIEFNLCBLYWxsZSBWYWxvIHdy
b3RlOg0KPiA+IE9rLCBJIHdpbGwgZHJvcCB0aGUgcGF0Y2ggdGhlbi4gQnV0IGl0IHdvdWxkIGJl
IHJlYWxseSBuaWNlIHRvIGVuYWJsZQ0KPiA+IGV2ZW4gc29tZSBsZXZlbCBvZiBzdXBwb3J0IGZv
ciByZmUgMiwgY2FuJ3Qgd2UgZmluZCBzb21lIHNvbHV0aW9uPyBMaWtlDQo+ID4gZGlzYWJsaW5n
IDIuNCBHSHogYmFuZCBmb3IgdGhhdCByZmUgb3Igc29tZXRoaW5nPw0KPiANCj4gVGhlIEUtbWFp
bCBmcm9tIFJlYWx0ZWsNCj4gKGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LXdpcmVsZXNzJm09
MTYwMjU1NTEwMDA0OTM4Jnc9Mikgc2F5cyB0aGF0IHRoZQ0KPiBwYXRjaGVzIGFyZSByZWFkeTsg
aG93ZXZlciwgdGhleSBuZWVkIHRvIGRvIHNvbWUgInZlcmlmaWNhdGlvbiIuIFRvIG1lDQo+ICh3
aXRob3V0DQo+IHByb29mKSwgdGhhdCBpbXBsaWVzIGEgcmVndWxhdG9yeSBwcm9ibGVtLCBhbmQg
aXQgaXMgYmV0dGVyIHRoYXQgd2Ugbm90IGVuYWJsZQ0KPiByZmUgMiB3aXRob3V0IHRoZSBvZmZp
Y2lhbCBwYXRjaGVzLg0KPiANCj4gSSBob3BlIHRob3NlIHBhdGNoZXMgd2lsbCBiZSBmb3J0aGNv
bWluZyB2ZXJ5IHNvb24uDQo+IA0KPiBMYXJyeQ0KPiANClRoZSB2ZXJpZmljYXRpb24gaXMgbm90
IHJlbGF0ZWQgdG8gcmVndWxhdG9yeS4gSXQgaXMgdGhhdCBvdXIgUUEgdGVhbSB0ZXN0cyB0aGUg
c29tZQ0KZnVuY3Rpb25hbGl0aWVzIChwZXJmb3JtYW5jZSwgQlQgY29leCBldGMuKSBvZiBSRkUg
dHlwZSAyLiBJZiB0aGUgdGVzdCBydW4gc3VjY2Vzc2Z1bGx5LA0KdGhlIHBhdGNoIHdpbGwgYmUg
c2VudCBpbiB0aGUgbmV4dCAyIHdlZWtzLg0KDQpUenUtRW4NCg==
