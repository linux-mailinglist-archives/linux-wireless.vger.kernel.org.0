Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E748C2F6FEC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 02:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbhAOBSk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 20:18:40 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47921 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAOBSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 20:18:40 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10F1Hp5Q2012686, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10F1Hp5Q2012686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 09:17:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 09:17:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Fri, 15 Jan 2021 09:17:50 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Topic: [PATCH RESEND v3 0/8] rtw88: improve TX performance in field
Thread-Index: AQHW6hbgUYGqUWBfGU6F85gETk1ltKomuBPugACl8wA=
Date:   Fri, 15 Jan 2021 01:17:50 +0000
Message-ID: <1610673434.2741.20.camel@realtek.com>
References: <20210114010950.3316-1-pkshih@realtek.com>
         <874kjkrnje.fsf@codeaurora.org>
In-Reply-To: <874kjkrnje.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4F59CAA3D5DFC4BB46AF436D26D9018@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTE0IGF0IDA3OjIxICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBJbXByb3Zl
IFRYIHBlcmZvcm1hbmNlIGluIGFzcGVjdHMgb2YgcHJvdG9jb2wgYW5kIHNvZnR3YXJlIGRlc2ln
bi4gQWxzbywNCj4gPiB1cGRhdGUgUEhZIHBhcmFtZXRlcnMgdG8gZml4IGluY29ycmVjdCBSU1NJ
IHJlcG9ydC4NCj4gPg0KPiA+IHYyOiBTaW5jZSA1LzUgb2YgdjEgaXMgdG9vIGxhcmdlLCBJIHNw
bGl0IGl0IGludG8gdGhyZWUgcGF0Y2hlcy4NCj4gPiB2MzogU2luY2UgNi83IG9mIHYyIGlzIHN0
aWxsIHRvbyBsYXJnZSBmb3IgcGF0Y2h3b3JrLCBJIHNwbGl0IHBhcmFtZXRlcg0KPiA+wqDCoMKg
wqDCoGludG8gZm91ciBwYXRjaGVzLg0KPiA+DQo+ID4gLS0tDQo+ID4gUkVTRU5EIHYzIGR1ZSB0
byBubyBhcHBlYXJhbmNlIG9mIHBhdGNod29yaw0KPiANCj4gUGxlYXNlIGF2b2lkIHVzaW5nICJS
RVNFTkQiLCBpbnN0ZWFkIGp1c3QgaW5jcmVhc2UgdGhlIHZlcnNpb24gKGluIHRoaXMNCj4gY2Fz
ZSB5b3Ugc2hvdWxkIGhhdmUgdXNlZCB2NCkuIE1ha2VzIG15IHNvcnRpbmcgZWFzaWVyIGFuZCBp
dCdzIG5vdCBsaWtlDQo+IHdlIGFyZSBydW5uaW5nIG91dCBvZiBudW1iZXJzIGZvciB2ZXJzaW9u
cyA6KQ0KPiANCj4gQW5kIG1haWxpbmcgbGlzdHMgYW5kIHBhdGNod29yayBjYW4gYmUgc2xvdyBz
b21ldGltZXMgKHJlY2VudGx5IG1vcmUNCj4gb2Z0ZW4pLCBzbyBwbGVhc2Ugd2FpdCBhdCBsZWFz
dCAxMmggYmVmb3JlIHJlc3VibWl0dGluZyBhbnkgcGF0Y2hlcy4gTm93DQo+IGJvdGggdjMgYW5k
ICJ2MyBSRVNFTkQiIGFyZSBpbiBwYXRjaHdvcmsuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIG1lc3Mu
DQpJJ2xsIGZvbGxvdyB5b3VyIGd1aWRlcyBmb3IgZnVydGhlciBzdWJtaXNzaW9uLg0KDQpUbyBh
dm9pZCBmcmVxdWVudGx5IHN1Ym1pdHRpbmcgcGF0Y2hlcyByZXN1bHRzIGZyb20gZXhjZWVkaW5n
IHBhdGNoIHNpemUgbGltaXQuDQpJJ2QgbGlrZSB0byBrbm93IHRoZSBwYXRjaCBzaXplIGxpbWl0
IGFjY2VwdGVkIGJ5IHBhdGNod29yay4NCkFzIEkga25vdywgdGhlIGxpbWl0IGlzIGFib3V0IDUx
MmssIHNvIGl0IGlzIGV4cGVjdGVkIHRoYXQgYmVsb3cgcGF0Y2hlcw0KZG9uJ3QgYXBwZWFyIGlu
IHBhdGNod29yaw0KMS4gcGF0Y2ggNS81IG9mIHYxICg5NzhLKQ0KMi4gcGF0Y2ggNi83IG9mIHYy
ICg1MzJLKQ0KDQpCdXQsIEkgZG9uJ3Qga25vdyB3aHkgdGhlIHRhYmxlIGZpbGUgKHBhdGNoIDE2
LzE4KSBvZiBydHc4OSB3aG9zZSBzaXplIGlzDQo3NzJrIGNhbiBhcHBlYXIgaW4gcGF0Y2h3b3Jr
LiBEb2VzIHBhdGNod29yayBoYXZlIGRpZmZlcmVudCBsaW1pdHMgb2YNCmV4aXN0aW5nIGFuZCBu
ZXcgZmlsZT8gTW9yZW92ZXIsIGlmIG5ldyBmaWxlIGV4Y2VlZHMgdGhlIGxpbWl0IHNvbWVkYXks
DQpob3cgY2FuIEkgZGVhbCB3aXRoIGl0PyBDYW4gSSBzcGxpdCB0aGUgbmV3IGZpbGUgaW50byB0
d28gb3IgbW9yZSBwYXRjaGVzPw0KDQotLS0NClBpbmctS2UNCg0K
