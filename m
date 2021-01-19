Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A172FAEA8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 03:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394060AbhASCQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 21:16:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52761 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394041AbhASCQB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 21:16:01 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10J2FBrL4017460, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10J2FBrL4017460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 10:15:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 10:15:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Tue, 19 Jan 2021 10:15:10 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Topic: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Index: AQHW6hbgUYGqUWBfGU6F85gETk1ltKomuBPugACl8wCAAPUAfv//fYWAgAWsoR+AADotAA==
Date:   Tue, 19 Jan 2021 02:15:10 +0000
Message-ID: <1611022470.3171.2.camel@realtek.com>
References: <20210114010950.3316-1-pkshih@realtek.com>
         <874kjkrnje.fsf@codeaurora.org> <1610673434.2741.20.camel@realtek.com>
         <87zh1ar60n.fsf@codeaurora.org> <1610698027.2741.26.camel@realtek.com>
         <87a6t6gv96.fsf@codeaurora.org>
In-Reply-To: <87a6t6gv96.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A847CFC32F17B6448DAED1745D717166@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTE4IGF0IDE0OjQ0ICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
a3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBPbiBGcmksIDIwMjEt
MDEtMTUgYXQgMDk6NTIgKzAyMDAsIEthbGxlIFZhbG8gd3JvdGU6DQo+ID4+IFBrc2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPiB3cml0ZXM6DQo+ID4+wqANCj4gPj4gPiBUbyBhdm9pZCBmcmVxdWVu
dGx5IHN1Ym1pdHRpbmcgcGF0Y2hlcyByZXN1bHRzIGZyb20gZXhjZWVkaW5nIHBhdGNoIHNpemUN
Cj4gPj4gbGltaXQuDQo+ID4+ID4gSSdkIGxpa2UgdG8ga25vdyB0aGUgcGF0Y2ggc2l6ZSBsaW1p
dCBhY2NlcHRlZCBieSBwYXRjaHdvcmsuDQo+ID4+ID4gQXMgSSBrbm93LCB0aGUgbGltaXQgaXMg
YWJvdXQgNTEyaywgc28gaXQgaXMgZXhwZWN0ZWQgdGhhdCBiZWxvdyBwYXRjaGVzDQo+ID4+ID4g
ZG9uJ3QgYXBwZWFyIGluIHBhdGNod29yaw0KPiA+PiA+IDEuIHBhdGNoIDUvNSBvZiB2MSAoOTc4
SykNCj4gPj4gPiAyLiBwYXRjaCA2Lzcgb2YgdjIgKDUzMkspDQo+ID4+ID4NCj4gPj4gPiBCdXQs
IEkgZG9uJ3Qga25vdyB3aHkgdGhlIHRhYmxlIGZpbGUgKHBhdGNoIDE2LzE4KSBvZiBydHc4OSB3
aG9zZSBzaXplIGlzDQo+ID4+ID4gNzcyayBjYW4gYXBwZWFyIGluIHBhdGNod29yay4gRG9lcyBw
YXRjaHdvcmsgaGF2ZSBkaWZmZXJlbnQgbGltaXRzIG9mDQo+ID4+ID4gZXhpc3RpbmcgYW5kIG5l
dyBmaWxlPyBNb3Jlb3ZlciwgaWYgbmV3IGZpbGUgZXhjZWVkcyB0aGUgbGltaXQgc29tZWRheSwN
Cj4gPj4gPiBob3cgY2FuIEkgZGVhbCB3aXRoIGl0PyBDYW4gSSBzcGxpdCB0aGUgbmV3IGZpbGUg
aW50byB0d28gb3IgbW9yZQ0KPiBwYXRjaGVzPw0KPiA+PsKgDQo+ID4+IEkgc3VzcGVjdCB0aGUg
bWFpbGluZyBsaXN0IGxpbWl0cyB0aGUgc2l6ZSwgbm90IHBhdGNod29yay4gSSBkaWQNCj4gPj4g
ZGlyZWN0bHkgZ2V0ICJbUEFUQ0ggNS81XSBydHc4ODogODgyMmM6IHVwZGF0ZSBwaHkgcGFyYW1l
dGVyIHRhYmxlcyB0bw0KPiA+PiB2NjAiIChNZXNzYWdlLUlEIDIwMjEwMTEzMDkyMzEyLjEzODA5
LTYtcGtzaGloQHJlYWx0ZWsuY29tKSBhcyB5b3UgYWRkZWQNCj4gPj4gbWUgdG8gQ0MuIEJ1dCBJ
IGRvbid0IHNlZSBpdCBpbiBsb3JlLCB3aGljaCBwb2ludHMgdGhhdCBsaW51eC13aXJlbGVzcw0K
PiA+PiBkcm9wcGVkIGl0Lg0KPiA+PsKgDQo+ID4+IE5vcm1hbGx5IHRoZXNlIGh1Z2UgcGF0Y2hl
cyB3b3VsZCBub3QgYmUgYXBwbGllZCBiZWluZyB0byBiaWcsIGJ1dA0KPiA+PiB1cGRhdGluZyBw
YXJhbWV0ZXIgdGFibGVzIGlzIGEgZ29vZCBleGNlcHRpb24gdG8gdGhlIHJ1bGUgYW5kIEkgY2Fu
DQo+ID4+IGNvbW1pdCB0aG9zZSBtYW51YWxseSBkaXJlY3RseSBmcm9tIG15IElOQk9YLiBTbyBm
b3IgaHVnZSBwYXRjaGVzIEkNCj4gPj4gcmVjb21tZW5kOg0KPiA+PsKgDQo+ID4+ICogbW92ZSB0
aGUgcGF0Y2ggYXMgdGhlIGxhc3QgcGF0Y2ggaW4gdGhlIHBhdGNoc2V0DQo+ID4+wqANCj4gPj4g
KiB0aGUgaHVnZSBwYXRjaCBzaG91bGQgb25seSBoYXZlIGNoYW5nZXMgdG8gcGFyYW1ldGVyIHZh
cmlhYmxlcywgaWUuDQo+ID4+IMKgIHJlZmFjdG9yIGNoYW5nZXMgdG8gdGhlIGFjdHVhbCBjb2Rl
IHRvIGEgc2VwYXJhdGUgcGF0Y2gNCj4gPj7CoA0KPiA+PiAqIGFkZCBrdmFsb0Bjb2RlYXVyb3Jh
Lm9yZyB0byBDQw0KPiA+PsKgDQo+ID4+ICogYWRkIGEgYmlnIHdhcm5pbmcgdG8gdGhlIGNvdmVy
IGxldHRlciAob3IgcmVwbHkgYWZ0ZXJ3YXJkcykgc28gdGhhdCBJDQo+ID4+IMKgIG5vdGljZSB0
aGUgaHVnZSBwYXRjaCBpcyBtaXNzaW5nIGZyb20gcGF0Y2h3b3JrDQo+ID4+wqANCj4gPj4gV291
bGQgdGhpcyB3b3JrPw0KPiA+PsKgDQo+ID4NCj4gPiBZZXMsIGl0IHdvcmtzLiBNYW55IHRoYW5r
cy4NCj4gPg0KPiA+IEkgd291bGQgbGlrZSB0byBrbm93IGlmIGl0IGlzIGFjY2VwdGVkIHRvIHNw
bGl0IHRoZSBiaWcgb25lIGludG8gdHdvIG9yDQo+ID4gbW9yZSBwYXRjaGVzLCBsaWtlIG15IHYz
PyBPciwgSSBzaG91bGQgcmVjYWxsIHYxIHN0eWxlIHdoZW4gSSBzdWJtaXQgdjQ/DQo+IA0KPiBG
b3IgbWUgc3BsaXR0aW5nIHRoZSBwYXRjaCBpbnRvIHNtYWxsZXIgcGF0Y2hlcyAod2hpY2ggYXJl
IHZpc2libGUgaW4NCj4gcGF0Y2h3b3JrKSBpcyBlYXNpZXIgYXMgdGhlbiBJIGRvbid0IG5lZWQg
dG8gZG8gYW55IG1hbnVhbCB3b3JrLiBXaGVuDQo+IHNwbGl0dGluZyBwYXRjaGVzIGp1c3QgbWFr
ZSBzdXJlIHRoYXQgdGhlIHJlcXVpcmVtZW50IG9mIGV2ZXJ5IHBhdGNoDQo+IGNvbXBpbGluZyB3
aXRob3V0IHdhcm5pbmdzIGlzIGZ1bGZpbGxlZC4NCj4gDQoNCk9LLiBUaGFua3MgZm9yIHlvdXIg
cGF0aWVuY2UgdG8gYW5zd2VyIG15IHF1ZXN0aW9ucy4NCg0KLS0NClBpbmctS2UNCg==
