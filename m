Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C532F73FE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 09:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbhAOIIa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 03:08:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43522 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbhAOIIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 03:08:30 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10F87ifwE014472, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10F87ifwE014472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 16:07:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 16:07:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Fri, 15 Jan 2021 16:07:43 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Topic: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Index: AQHW6hbgUYGqUWBfGU6F85gETk1ltKomuBPugACl8wCAAPUAfv//fYWA
Date:   Fri, 15 Jan 2021 08:07:43 +0000
Message-ID: <1610698027.2741.26.camel@realtek.com>
References: <20210114010950.3316-1-pkshih@realtek.com>
         <874kjkrnje.fsf@codeaurora.org> <1610673434.2741.20.camel@realtek.com>
         <87zh1ar60n.fsf@codeaurora.org>
In-Reply-To: <87zh1ar60n.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <61ABDC13BE5D5343B33428DDE18741B4@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTE1IGF0IDA5OjUyICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
a3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBUbyBhdm9pZCBmcmVx
dWVudGx5IHN1Ym1pdHRpbmcgcGF0Y2hlcyByZXN1bHRzIGZyb20gZXhjZWVkaW5nIHBhdGNoIHNp
emUNCj4gbGltaXQuDQo+ID4gSSdkIGxpa2UgdG8ga25vdyB0aGUgcGF0Y2ggc2l6ZSBsaW1pdCBh
Y2NlcHRlZCBieSBwYXRjaHdvcmsuDQo+ID4gQXMgSSBrbm93LCB0aGUgbGltaXQgaXMgYWJvdXQg
NTEyaywgc28gaXQgaXMgZXhwZWN0ZWQgdGhhdCBiZWxvdyBwYXRjaGVzDQo+ID4gZG9uJ3QgYXBw
ZWFyIGluIHBhdGNod29yaw0KPiA+IDEuIHBhdGNoIDUvNSBvZiB2MSAoOTc4SykNCj4gPiAyLiBw
YXRjaCA2Lzcgb2YgdjIgKDUzMkspDQo+ID4NCj4gPiBCdXQsIEkgZG9uJ3Qga25vdyB3aHkgdGhl
IHRhYmxlIGZpbGUgKHBhdGNoIDE2LzE4KSBvZiBydHc4OSB3aG9zZSBzaXplIGlzDQo+ID4gNzcy
ayBjYW4gYXBwZWFyIGluIHBhdGNod29yay4gRG9lcyBwYXRjaHdvcmsgaGF2ZSBkaWZmZXJlbnQg
bGltaXRzIG9mDQo+ID4gZXhpc3RpbmcgYW5kIG5ldyBmaWxlPyBNb3Jlb3ZlciwgaWYgbmV3IGZp
bGUgZXhjZWVkcyB0aGUgbGltaXQgc29tZWRheSwNCj4gPiBob3cgY2FuIEkgZGVhbCB3aXRoIGl0
PyBDYW4gSSBzcGxpdCB0aGUgbmV3IGZpbGUgaW50byB0d28gb3IgbW9yZSBwYXRjaGVzPw0KPiAN
Cj4gSSBzdXNwZWN0IHRoZSBtYWlsaW5nIGxpc3QgbGltaXRzIHRoZSBzaXplLCBub3QgcGF0Y2h3
b3JrLiBJIGRpZA0KPiBkaXJlY3RseSBnZXQgIltQQVRDSCA1LzVdIHJ0dzg4OiA4ODIyYzogdXBk
YXRlIHBoeSBwYXJhbWV0ZXIgdGFibGVzIHRvDQo+IHY2MCIgKE1lc3NhZ2UtSUQgMjAyMTAxMTMw
OTIzMTIuMTM4MDktNi1wa3NoaWhAcmVhbHRlay5jb20pIGFzIHlvdSBhZGRlZA0KPiBtZSB0byBD
Qy4gQnV0IEkgZG9uJ3Qgc2VlIGl0IGluIGxvcmUsIHdoaWNoIHBvaW50cyB0aGF0IGxpbnV4LXdp
cmVsZXNzDQo+IGRyb3BwZWQgaXQuDQo+IA0KPiBOb3JtYWxseSB0aGVzZSBodWdlIHBhdGNoZXMg
d291bGQgbm90IGJlIGFwcGxpZWQgYmVpbmcgdG8gYmlnLCBidXQNCj4gdXBkYXRpbmcgcGFyYW1l
dGVyIHRhYmxlcyBpcyBhIGdvb2QgZXhjZXB0aW9uIHRvIHRoZSBydWxlIGFuZCBJIGNhbg0KPiBj
b21taXQgdGhvc2UgbWFudWFsbHkgZGlyZWN0bHkgZnJvbSBteSBJTkJPWC4gU28gZm9yIGh1Z2Ug
cGF0Y2hlcyBJDQo+IHJlY29tbWVuZDoNCj4gDQo+ICogbW92ZSB0aGUgcGF0Y2ggYXMgdGhlIGxh
c3QgcGF0Y2ggaW4gdGhlIHBhdGNoc2V0DQo+IA0KPiAqIHRoZSBodWdlIHBhdGNoIHNob3VsZCBv
bmx5IGhhdmUgY2hhbmdlcyB0byBwYXJhbWV0ZXIgdmFyaWFibGVzLCBpZS4NCj4gwqAgcmVmYWN0
b3IgY2hhbmdlcyB0byB0aGUgYWN0dWFsIGNvZGUgdG8gYSBzZXBhcmF0ZSBwYXRjaA0KPiANCj4g
KiBhZGQga3ZhbG9AY29kZWF1cm9yYS5vcmcgdG8gQ0MNCj4gDQo+ICogYWRkIGEgYmlnIHdhcm5p
bmcgdG8gdGhlIGNvdmVyIGxldHRlciAob3IgcmVwbHkgYWZ0ZXJ3YXJkcykgc28gdGhhdCBJDQo+
IMKgIG5vdGljZSB0aGUgaHVnZSBwYXRjaCBpcyBtaXNzaW5nIGZyb20gcGF0Y2h3b3JrDQo+IA0K
PiBXb3VsZCB0aGlzIHdvcms/DQo+IA0KDQpZZXMsIGl0IHdvcmtzLiBNYW55IHRoYW5rcy4NCg0K
SSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgaXQgaXMgYWNjZXB0ZWQgdG8gc3BsaXQgdGhlIGJpZyBv
bmUgaW50byB0d28gb3INCm1vcmUgcGF0Y2hlcywgbGlrZSBteSB2Mz8gT3IsIEkgc2hvdWxkIHJl
Y2FsbCB2MSBzdHlsZSB3aGVuIEkgc3VibWl0IHY0Pw0KDQotLQ0KUGluZy1LZQ0KDQo=
