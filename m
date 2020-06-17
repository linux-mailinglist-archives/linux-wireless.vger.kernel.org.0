Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CE1FC5AB
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 07:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQFbC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 01:31:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39839 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgFQFbC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 01:31:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05H5UNhI4018950, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05H5UNhI4018950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 13:30:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Jun 2020 13:30:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Jun 2020 13:30:22 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Wed, 17 Jun 2020 13:30:22 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "kernel@iuliancostan.com" <kernel@iuliancostan.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "i@outv.im" <i@outv.im>,
        "trevor@shartrec.com" <trevor@shartrec.com>
Subject: RE: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with module parameter
Thread-Topic: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with
 module parameter
Thread-Index: AQHWOw2RujNwSXbT4UO+bT296oFUSqjR4mwAgAk8kAD//6rOgIABjPPw
Date:   Wed, 17 Jun 2020 05:30:22 +0000
Message-ID: <fbf8d9cb6b864004b11372f6d70b734b@realtek.com>
References: <20200605074703.32726-1-yhchuang@realtek.com>
 <20200610213720.3sopcuimas375xl2@linutronix.de>
 <a2aac609b5e2416b899c5842817da4bb@realtek.com>
 <20200616133531.7eyfu6jniywhak7h@linutronix.de>
In-Reply-To: <20200616133531.7eyfu6jniywhak7h@linutronix.de>
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

MDAwMF0sIFRvbnkgQ2h1YW5nIHdyb3RlOg0KPiA+ID4gT24gMjAyMC0wNi0wNSAxNTo0NzowMyBb
KzA4MDBdLCB5aGNodWFuZ0ByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiA+ID4gRnJvbTogWWFuLUhz
dWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFNvbWUg
cGxhdGZvcm1zIGNhbm5vdCByZWFkIHRoZSBEQkkgcmVnaXN0ZXIgc3VjY2Vzc2Z1bGx5IGZvciB0
aGUNCj4gPiA+ID4gQVNQTSBzZXR0aW5ncy4gQWZ0ZXIgdGhlIHJlYWQgZmFpbGVkLCB0aGUgYnVz
IGNvdWxkIGJlIHVuc3RhYmxlLA0KPiA+ID4gPiBhbmQgdGhlIGRldmljZSBqdXN0IGJlY2FtZSB1
bmF2YWlsYWJsZSBbMV0uIEZvciB0aG9zZSBwbGF0Zm9ybXMsDQo+ID4gPiA+IHRoZSBBU1BNIHNo
b3VsZCBiZSBkaXNhYmxlZC4gQnV0IGFzIHRoZSBBU1BNIGNhbiBoZWxwIHRoZSBkcml2ZXINCj4g
PiA+ID4gdG8gc2F2ZSB0aGUgcG93ZXIgY29uc3VtcHRpb24gaW4gcG93ZXIgc2F2ZSBtb2RlLCB0
aGUgQVNQTSBpcyBzdGlsbA0KPiA+ID4gPiBuZWVkZWQuIFNvLCBhZGQgYSBtb2R1bGUgcGFyYW1l
dGVyIGZvciB0aGVtIHRvIGRpc2FibGUgaXQsIHRoZW4NCj4gPiA+ID4gdGhlIGRldmljZSBjYW4g
c3RpbGwgd29yaywgd2hpbGUgb3RoZXJzIGNhbiBiZW5lZml0IGZyb20gdGhlIGxlc3MNCj4gPiA+
ID4gcG93ZXIgY29uc3VtcHRpb24gdGhhdCBicmluZ3MgYnkgQVNQTSBlbmFibGVkLg0KPiA+ID4N
Cj4gPiA+IENhbiB5b3Ugc2V0IGRpc2FibGVfYXNwbSBpZiBydHdfZGJpX3JlYWQ4KCkgZmFpbHM/
IE9yIG1ha2UgYSB0ZXN0IGlmIGl0DQo+ID4gPiBpcyBzYXZlIHRvIHVzZT8NCj4gPiA+DQo+ID4g
PiBJZiBzb21lb25lIG5vdGljZXMgdGhlIHdhcm5pbmcgdGhleSBzdGlsbCBoYXZlIHRvIHNlYXJj
aCBmb3IgdGhlIHdhcm5pbmcNCj4gPiA+IGluIG9yZGVyIHRvIG1ha2UgdGhlIGxpbmsgdG93YXJk
cyBsb2FkaW5nIHRoZSBtb2R1bGUgd2l0aCB0aGUNCj4gPiA+IGRpc2FibGVfYXNwbT0xIHBhcmFt
dGVyLg0KPiA+ID4gSXMgaXQga25vd24gd2hhdCBjYXVzZXMgdGhlIGZhaWx1cmU/DQo+ID4gPg0K
PiA+DQo+ID4gSSB0aGluayBhcyBsb25nIGFzIHRoZSBydHdfZGJpX3JlYWQoKSBmYWlscywgdGhl
IGNvbnNlcXVlbnQgcmVnaXN0ZXINCj4gPiBvcGVyYXRpb24gd2lsbCBhbHNvIGZhaWwsIGFuZCBz
dGlsbCBnZXQgYW4gZXJyb3IgcmVhZC93cml0ZSB0aGUgcmVnaXN0ZXIuDQo+ID4gQW5kIHRoaXMg
aXMgc29tZSBzb3J0IG9mIFBDSSBpc3N1ZSwgYW5kIEkgYW0gbm90IHJlYWxseSBmYW1pbGlhciB3
aXRoIGl0Lg0KPiA+IFN1Y2ggYXMgdGhlIHJvb3QgY2F1c2Ugb3IgaG93IGl0IGZhaWxzLg0KPiAN
Cj4gVGhlbiBpdCBkb2VzIG5vdCBzb3VuZCBzYWZlIHRvIGVuYWJsZSBpdCBieSBkZWZhdWx0Lg0K
DQpXZSBoYXZlIGhhZCBhIGRpc2N1c3Npb24gYWJvdXQgdGhpcywgYnV0IEkgY2Fubm90IGZpbmQg
dGhlIHRocmVhZCBub3cuDQpQZW9wbGUgc3VnZ2VzdGVkIHRoYXQgdGhlIG1vZHVsZSBwYXJhbWV0
ZXIgc2hvdWxkIG5vdCBiZSB1c2VkLg0KQW5kIHRoZXkgdGhpbmsgdGhhdCBpZiB0aGUgQVNQTSBj
YW4gaGVscCBmb3IgcG93ZXIgY29uc3VtcHRpb24sIHRoZW4NCml0IHNob3VsZCBiZSBkZWZhdWx0
IGVuYWJsZWQuIEJ1dCBJIHRoaW5rIGl0IHNob3VsZCBiZSBiYXNlZCBvbiB0aGF0IHRoZQ0Kb3Ro
ZXIgcGxhdGZvcm1zIHdpbGwgbm90IGp1c3QgZmFpbCB0byBicmluZyB1cCB0aGUgZGV2aWNlLiBI
b3dldmVyLCB0aGUNCnBsYXRmb3JtcyBhcmUgbGVzcyB0aGFuIHRoZSBvdGhlcnMsIG5vdCBzdXJl
IGlmIGRlZmF1bHQgZW5hYmxlIG9yIGRpc2FibGUNCmlzIGJldHRlci4NCg0KPiANCj4gPiBJZiB3
ZSBjYW4gZGVmYXVsdCBkaXNhYmxlIGl0LCB0aGVuIHdlIGNhbiBoZWxwIHRob3NlIHBsYXRmb3Jt
cywgYnV0DQo+ID4gdGhlbiBvdGhlciBwbGF0Zm9ybSB3aWxsIHN1ZmZlciBmcm9tIGhpZ2hlciBw
b3dlciBjb25zdW1wdGlvbi4NCj4gDQo+IFNvIGZvciB0aG9zZSBwbGF0Zm9ybSwgd2hlcmUgdGhl
IGVycm9yIG9jY3VycywgeW91IGV4cGVjdCB0aGF0IHRoZSB1c2VyDQo+IG1hbmFnZXMgdG8gcmVh
ZCB0aGUgZXJyb3IgbWVzc2FnZSAoYSBiYWNrdHJhY2UgZnJvbSBydHdfZGJpX3JlYWQ4KCkpIGFu
ZA0KPiBjb25uZWN0cyB0aGlzIHRoZSBuZWVkIHRvIHNldCBhIGNlcnRhaW4gbW9kdWxlIG9wdGlv
bi4NCg0KWWVzLCB3ZSBjYW4gZGlzY3VzcyBpZiBpdCBzaG91bGQgYmUgZGVmYXVsdCBlbmFibGVk
IG9yIG5vdC4gT3RoZXJ3aXNlIHRoZQ0KcGVvcGxlIHdpdGggdGhvc2UgcGxhdGZvcm1zIGNhbiBv
bmx5IGRvIHRoYXQgdG8gcHJldmVudCB0aGlzLiBSZWFsbHkgYmFkLg0KDQo+IFNlYmFzdGlhbg0K
PiANCg0KWWVuLUhzdWFuDQo=
