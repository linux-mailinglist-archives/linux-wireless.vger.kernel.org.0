Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AA29470C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Oct 2020 05:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411821AbgJUDmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 23:42:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50496 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411818AbgJUDmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 23:42:03 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09L3fddfF003202, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09L3fddfF003202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Oct 2020 11:41:39 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 21 Oct 2020 11:41:39 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Wed, 21 Oct 2020 11:41:39 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     "'David Rubio'" <david.alejandro.rubio@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Topic: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Index: AQHWn+l1M4JR4F24I0SZAkWf/gzk8qmTwKwAgAEJzzD//4MXAIAFxLuAgAMLTxOAAZILAIAACPgAgAK7ZoA=
Date:   Wed, 21 Oct 2020 03:41:39 +0000
Message-ID: <50fda979cb584ea898681282926fcfef@realtek.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com>
 <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net>
 <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
 <CAO6ttS=U=UXLEByJVDQgXdBbtgKm=WgGUjOVZCXuOnjyajUTFA@mail.gmail.com>
In-Reply-To: <CAO6ttS=U=UXLEByJVDQgXdBbtgKm=WgGUjOVZCXuOnjyajUTFA@mail.gmail.com>
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

DQpEYXZpZCBSdWJpbyA8ZGF2aWQuYWxlamFuZHJvLnJ1YmlvQGdtYWlsLmNvbT4gd3JpdGVzLA0K
PiANCj4gTWFrZXMgc2Vuc2UgSSBndWVzcy4gTXkgcm9vbSBpcyA3bV4yIHNvIGNhbid0IHRlc3Qg
YmV5b25kIHRoYXQuDQo+IFNtYWxsIHJvb20gaXNzdWVzLCBvciB3ZWxsLCBub3QgaXNzdWVzLCBJ
IGd1ZXNzLg0KPiANCj4gLSBLb2RlaGF3YQ0KPiANCj4gRWwgbHVuLiwgMTkgb2N0LiAyMDIwIGEg
bGFzIDE0OjEwLCBMYXJyeSBGaW5nZXINCj4gKDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0Pikg
ZXNjcmliacOzOg0KPiA+DQo+ID4gT24gMTAvMTgvMjAgNDoxMSBBTSwgS2FsbGUgVmFsbyB3cm90
ZToNCj4gPiA+IERhdmlkIFJ1YmlvIDxkYXZpZC5hbGVqYW5kcm8ucnViaW9AZ21haWwuY29tPiB3
cml0ZXM6DQo+ID4gPg0KPiA+ID4+Pg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13
aXJlbGVzcy9jMGMzMzZkODA2NTg0MzYxOTkyZDRiNTI2NjVmYmI4MkByDQo+IGVhbHRlay5jb20v
DQo+ID4gPj4NCj4gPiA+PiBJIHRlc3RlZCB0aGF0IHBhdGNoLiBXb3JrcyBmaW5lIGZvciBtZSBm
b3Igd2lmaSwgYnV0IEkgY2FuJ3QgdGVzdCBCVA0KPiA+ID4+IHRvIGJlIHN1cmUgaXQgd29ya3Mg
MTAwJS4gTW9zdCBwZW9wbGUgd2lsbCBiZSBmaW5lIHdpdGgganVzdCB3aWZpDQo+ID4gPj4gdGhv
dWdoLCBJIGd1ZXNzLCBjb25zaWRlcmluZyB0aGUgb2JqZWN0aW9ucyB3ZXJlIG1vc3RseSBhYm91
dCBCVCAoSQ0KPiA+ID4+IHVuZGVyc3Rvb2QgLWZyb20gdGhlIG9iamVjdGlvbi0gdGhhdCBjb25u
ZWN0aW5nIHRvIGEgQVAgd2hlbiBoYXZpbmcgYQ0KPiA+ID4+IEJUIGRldmljZSBwYWlyZWQgYnJl
YWtzPykNCj4gPiA+DQo+ID4gPiBJZiB0aGUgcGF0Y2ggaGVscHMgcGVvcGxlIHRvIGdldCB3aWZp
IHdvcmtpbmcgd2Ugc2hvdWxkIHRha2UgaXQsIEJUIGNvZXgNCj4gPiA+IGlzc3VlcyBjYW4gYmUg
Zml4ZWQgaW4gZm9sbG93dXAgcGF0Y2hlcy4gSUlSQyB0aGVyZSBoYXMgYmVlbiBtdWx0aXBsZQ0K
PiA+ID4gcmVwb3J0cyBhYm91dCB0aGlzIHNvIEknbSBsZWFuaW5nIHRvd2FyZHMgdGFraW5nIHRo
ZSBwYXRjaCB0byB2NS4xMS4NCj4gPiA+DQo+ID4gPiBJIGNoYW5nZWQgdGhlIHBhdGNoIHRvIE5l
dyBzdGF0ZSBhbmQgbXkgcGxhbiBpcyB0byB0YWtlIGl0IHRvDQo+ID4gPiB3aXJlbGVzcy1kcml2
ZXJzLW5leHQgb25jZSB0aGUgdHJlZSBvcGVuczoNCj4gPiA+DQo+ID4gPg0KPiBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyMDA4MDUw
ODQ1NTkuMzANCj4gMDkyLTEta2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tLw0KPiA+DQo+ID4g
S2FsbGUsDQo+ID4NCj4gPiBJIGhhZCBnZW5lcmF0ZWQgYW5kIGFwcGxpZWQgdGhhdCB0cml2aWFs
IHBhdGNoIHRvIG15IEdpdEh1YiByZXBvIHdpdGggdGhlDQo+IHJ0dzg4DQo+ID4gZHJpdmVycyBh
IGNvdXBsZSBvZiBtb250aHMgYWdvLiBZZXMsIGl0IGRvZXMgZ2V0IHRoZSB1c2VyIHBhc3QgdGhl
DQo+ID4gaW5pdGlhbGl6YXRpb24gY2hlY2s7IGhvd2V2ZXIsIHdpZmkgcGVyZm9ybWFuY2UgaXMg
YWJ5c21hbCBhY2NvcmRpbmcgdGhlIHRoZQ0KPiA+IHVzZXJzIG9mIHRoZSByZXBvLiBJdCBzZWVt
cyB0aGF0IHRoZSBhbnRlbm5hIHNlbGVjdGlvbiBvZiByZmUgMiBtb2RlbHMgYWZmZWN0cw0KPiA+
IHdpZmkgYXMgd2VsbCBhcyBCVC4gQXBwbHlpbmcgdGhpcyBwYXRjaCB3aWxsIGdldCB3aWZpIHJ1
bm5pbmc7IGhvd2V2ZXIsIHRoZQ0KPiA+IHVzZXJzIHdpbGwgbmVlZCB0byBiZSB3aXRoaW4gMSBt
IG9mIHRoZSBBUCBmb3IgaXQgdG8gd29yayEgSSBkbyBub3QgaGF2ZSBhbg0KPiA+IFJUTDg4MjFD
RSBjaGlwLCB0aHVzIEkgaGF2ZSBub3QgdGVzdGVkIG15c2VsZi4NCj4gPg0KPiA+IExhcnJ5DQo+
ID4NCj4gDQpEYXZpZCwNCg0KV2hhdCBpcyB0aGUgYmFuZCBmb3IgdGhlIHRlc3QsIDIuNEdIeiBv
ciA1R0h6Pw0KV2l0aG91dCBzZXR0aW5nIHRvIGEgY29ycmVjdCByZiBtb2R1bGUgZm9yIFJGRSB0
eXBlIDIsIHlvdSBtaWdodCBlbmNvdW50ZXIgc29tZQ0KcHJvYmxlbXMgb24gMi40R0h6IGJhbmQu
DQpJbiBteSB0ZXN0LCBvbiAyLjRHSHogYmFuZCwgd2l0aCB0aGUgd3Jvbmcgc2V0dGluZywgaXQg
Y291bGQgbm90IGNvbm5lY3QgdG8gYW4gQVAuDQoNClR6dS1Fbg0K
