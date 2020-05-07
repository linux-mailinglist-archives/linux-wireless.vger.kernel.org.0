Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F31C80FF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgEGE0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:26:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34250 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgEGE0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:26:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474QPkzC027678, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474QPkzC027678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:26:25 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:26:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:26:24 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Thu, 7 May 2020 12:26:24 +0800
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
Thread-Index: AQHWFIxwWk+IgF2xvEuU+RV8JviaE6iZH+SAgAFUOICAAJ7xgIABElcg
Date:   Thu, 7 May 2020 04:26:24 +0000
Message-ID: <2ee629b3bb374532b0830a39b57c2389@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
 <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
 <c7083dc760464c1a9017888457c1718d@realtek.com>
 <20200506200129.suid6lfkdwuoapzl@linutronix.de>
In-Reply-To: <20200506200129.suid6lfkdwuoapzl@linutronix.de>
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

U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cml0ZXMN
Cj4gT24gMjAyMC0wNS0wNiAwMjozNToyMSBbKzAwMDBdLCBUb255IENodWFuZyB3cm90ZToNCj4g
PiA+IE9uIDIwMjAtMDQtMTcgMTU6NDY6NDEgWyswODAwXSwgeWhjaHVhbmdAcmVhbHRlay5jb20g
d3JvdGU6DQo+ID4gPiA+IEZyb206IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBXaXRob3V0IHRoaXMgcGF0Y2gsIHdpZmkgY2FyZCBjYW4ndCBpbml0
aWFsaXplIHByb3Blcmx5IGR1ZSB0byBCVCBpbiBVU0INCj4gPiA+ID4gc3VzcGVuZCBzdGF0ZS4g
U28sIHdlIGRpc2FibGUgQlQgVVNCIHN1c3BlbmQgKHdha2V1cCkgaW4gc2h1dGRvd24NCj4gY2Fs
bGJhY2sNCj4gPiA+ID4gdGhhdCBpcyB0aGUgbW9tZW50IGJlZm9yZSByZWJvb3RpbmcuIFRvIHNh
dmUgQlQgVVNCIHBvd2VyLCB3ZSBjYW4ndCBkbw0KPiB0aGlzDQo+ID4gPiA+IGluICdyZW1vdmUn
IGNhbGxiYWNrLg0KPiA+ID4NCj4gPiA+IFNvIHlvdSBjYW4ndCBpbml0aWFsaXplIHRoZSBVU0Ig
cGFydCBiZWNhdXNlIGl0IGlzIGluIHN1c3BlbmQgYW5kIHRoZQ0KPiA+ID4gb25seSB3YXkgdG8g
YXZvaWQgaXQgdG8gZGlzYWJsZSBpdCBvbiB0aGUgUENJIHNpZGUuIFRoYXQgbWVhbnMgeW91IGRv
bid0DQo+ID4gPiBzZWUgaXQgZW51bWVyYXRlZCBvbiB0aGUgVVNCIGJ1cyBhdCBhbGw/DQo+ID4N
Cj4gPiBZZXMsIGlmIHdlIGRvbid0IGRpc2FibGUgaXQgb24gUENJIHNpZGUsIHRoZW4gdGhlIFVT
QiBwYXJ0IGNhbm5vdCBiZQ0KPiA+IHByb2JlZCBvbiBVU0IgYnVzLg0KPiANCj4gV2UgdGFsayBo
ZXJlIGFib3V0IFVTQidzIHJ1bnRpbWUtc3VzcGVuZCAvIGF1dG9zdXNwZW5kPyBJZiBzbywgYXJl
IHlvdQ0KPiBhd2FyZSBvZiBjb21taXQNCj4gICA3ZWNhY2FmYzI0MDYzICgiQmx1ZXRvb3RoOiBi
dHVzYjogRGlzYWJsZSBydW50aW1lIHN1c3BlbmQgb24gUmVhbHRlaw0KPiBkZXZpY2VzIikNCj4g
DQo+IG9yIGlzIHRoaXMgYW4gYXR0ZW1wdCB0byBnZXQgcmlkIG9mIHRoaXMgY2hhbmdlIGluIGZh
dm91ciBvZiB0aGlzIG9uZQ0KPiAoc28gdGhhdCB0aGUgZGV2aWNlIGNhbiBlbnRlciBzdXNwZW5k
LW1vZGUpPw0KPiANCg0KUGluZy1LZSwgY2FuIHlvdSBwbGVhc2UgaGVscCB0byBjaGVjayBvbiB0
aGlzID8NCkxvb2tzIGxpa2UgS2FpLUhlbmcgaXMgZG9pbmcgdGhlIG11Y2ggc2FtZSB0aGluZyBo
ZXJlLg0KDQpCdXQgaXQncyBzdGlsbCB3b3J0aCB0byBkbyBpdCBpbiB3aWZpIHNpZGUgSSB0aGlu
aywgYmVjYXVzZSBpdCdzIGRpZmZpY3VsdCB0bw0KbWFrZSBzdXJlIHRoZSBzeW5jaHJvbml6YXRp
b24gb2YgQlQgYW5kIFdpZmkgcGF0Y2guDQoNClllbi1Ic3Vhbg0K
