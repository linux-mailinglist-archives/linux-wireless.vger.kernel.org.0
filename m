Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAD1FAEE5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFPLHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 07:07:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53319 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgFPLHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 07:07:03 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05GB6SRR0025779, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05GB6SRR0025779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 19:06:28 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 19:06:28 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Tue, 16 Jun 2020 19:06:28 +0800
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
Thread-Index: AQHWOw2RujNwSXbT4UO+bT296oFUSqjR4mwAgAk8kAA=
Date:   Tue, 16 Jun 2020 11:06:28 +0000
Message-ID: <a2aac609b5e2416b899c5842817da4bb@realtek.com>
References: <20200605074703.32726-1-yhchuang@realtek.com>
 <20200610213720.3sopcuimas375xl2@linutronix.de>
In-Reply-To: <20200610213720.3sopcuimas375xl2@linutronix.de>
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

PiBPbiAyMDIwLTA2LTA1IDE1OjQ3OjAzIFsrMDgwMF0sIHloY2h1YW5nQHJlYWx0ZWsuY29tIHdy
b3RlOg0KPiA+IEZyb206IFlhbi1Ic3VhbiBDaHVhbmcgPHloY2h1YW5nQHJlYWx0ZWsuY29tPg0K
PiA+DQo+ID4gU29tZSBwbGF0Zm9ybXMgY2Fubm90IHJlYWQgdGhlIERCSSByZWdpc3RlciBzdWNj
ZXNzZnVsbHkgZm9yIHRoZQ0KPiA+IEFTUE0gc2V0dGluZ3MuIEFmdGVyIHRoZSByZWFkIGZhaWxl
ZCwgdGhlIGJ1cyBjb3VsZCBiZSB1bnN0YWJsZSwNCj4gPiBhbmQgdGhlIGRldmljZSBqdXN0IGJl
Y2FtZSB1bmF2YWlsYWJsZSBbMV0uIEZvciB0aG9zZSBwbGF0Zm9ybXMsDQo+ID4gdGhlIEFTUE0g
c2hvdWxkIGJlIGRpc2FibGVkLiBCdXQgYXMgdGhlIEFTUE0gY2FuIGhlbHAgdGhlIGRyaXZlcg0K
PiA+IHRvIHNhdmUgdGhlIHBvd2VyIGNvbnN1bXB0aW9uIGluIHBvd2VyIHNhdmUgbW9kZSwgdGhl
IEFTUE0gaXMgc3RpbGwNCj4gPiBuZWVkZWQuIFNvLCBhZGQgYSBtb2R1bGUgcGFyYW1ldGVyIGZv
ciB0aGVtIHRvIGRpc2FibGUgaXQsIHRoZW4NCj4gPiB0aGUgZGV2aWNlIGNhbiBzdGlsbCB3b3Jr
LCB3aGlsZSBvdGhlcnMgY2FuIGJlbmVmaXQgZnJvbSB0aGUgbGVzcw0KPiA+IHBvd2VyIGNvbnN1
bXB0aW9uIHRoYXQgYnJpbmdzIGJ5IEFTUE0gZW5hYmxlZC4NCj4gDQo+IENhbiB5b3Ugc2V0IGRp
c2FibGVfYXNwbSBpZiBydHdfZGJpX3JlYWQ4KCkgZmFpbHM/IE9yIG1ha2UgYSB0ZXN0IGlmIGl0
DQo+IGlzIHNhdmUgdG8gdXNlPw0KPiANCj4gSWYgc29tZW9uZSBub3RpY2VzIHRoZSB3YXJuaW5n
IHRoZXkgc3RpbGwgaGF2ZSB0byBzZWFyY2ggZm9yIHRoZSB3YXJuaW5nDQo+IGluIG9yZGVyIHRv
IG1ha2UgdGhlIGxpbmsgdG93YXJkcyBsb2FkaW5nIHRoZSBtb2R1bGUgd2l0aCB0aGUNCj4gZGlz
YWJsZV9hc3BtPTEgcGFyYW10ZXIuDQo+IElzIGl0IGtub3duIHdoYXQgY2F1c2VzIHRoZSBmYWls
dXJlPw0KPiANCg0KSSB0aGluayBhcyBsb25nIGFzIHRoZSBydHdfZGJpX3JlYWQoKSBmYWlscywg
dGhlIGNvbnNlcXVlbnQgcmVnaXN0ZXINCm9wZXJhdGlvbiB3aWxsIGFsc28gZmFpbCwgYW5kIHN0
aWxsIGdldCBhbiBlcnJvciByZWFkL3dyaXRlIHRoZSByZWdpc3Rlci4NCkFuZCB0aGlzIGlzIHNv
bWUgc29ydCBvZiBQQ0kgaXNzdWUsIGFuZCBJIGFtIG5vdCByZWFsbHkgZmFtaWxpYXIgd2l0aCBp
dC4NClN1Y2ggYXMgdGhlIHJvb3QgY2F1c2Ugb3IgaG93IGl0IGZhaWxzLg0KDQpJZiB3ZSBjYW4g
ZGVmYXVsdCBkaXNhYmxlIGl0LCB0aGVuIHdlIGNhbiBoZWxwIHRob3NlIHBsYXRmb3JtcywgYnV0
DQp0aGVuIG90aGVyIHBsYXRmb3JtIHdpbGwgc3VmZmVyIGZyb20gaGlnaGVyIHBvd2VyIGNvbnN1
bXB0aW9uLg0KDQpZZW4tSHN1YW4NCg==
