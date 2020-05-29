Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5331E7289
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 04:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404420AbgE2CX1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 22:23:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60167 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbgE2CXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 22:23:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04T2N1ptC016062, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04T2N1ptC016062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:23:01 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 10:23:01 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4]) by
 RTEXMB04.realtek.com.tw ([fe80::8001:f5f5:a41e:f8d4%3]) with mapi id
 15.01.1779.005; Fri, 29 May 2020 10:23:01 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>
Subject: RE: [PATCH 0/3] rtw88: 8723d: follow up fixes
Thread-Topic: [PATCH 0/3] rtw88: 8723d: follow up fixes
Thread-Index: AQHWLOxz7TijVaYK2UWUZI2EDsUwmKi9Fp2AgAFPc8A=
Date:   Fri, 29 May 2020 02:23:01 +0000
Message-ID: <95c1be430eac4fbcb12f5cab1a34ace6@realtek.com>
References: <20200518081444.7664-1-yhchuang@realtek.com>
 <20200528142133.jkl6j3vyk6nkccsk@linutronix.de>
In-Reply-To: <20200528142133.jkl6j3vyk6nkccsk@linutronix.de>
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

DQo+IE9uIDIwMjAtMDUtMTggMTY6MTQ6NDEgWyswODAwXSwgeWhjaHVhbmdAcmVhbHRlay5jb20g
d3JvdGU6DQo+ID4gRnJvbTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+
DQo+ID4NCj4gPiBUaGUgUlRMODcyM0RFIGRldmljZXMgaGF2ZSBiZWVuIHRlc3RlZCBieSBDYW5v
bmljYWwgZm9yIHRoZSBjb2V4DQo+ID4gYW5kIGJhc2ljIHdpZmkgZnVuY3Rpb25zLiBBbmQgdGhl
eSBoYXZlIHJlcG9ydGVkIHNvbWUgaXNzdWVzIGZvcg0KPiA+IFJUTDg3MjNERS4gRml4IHRoZW0g
YWNjb3JkaW5nbHkuDQo+IA0KPiBNaW5vciByZXdvcmRpbmcgaW4gMy8zLCBvdGhlcndpc2UgbG9v
a3MgZ29vZC4NCj4gDQo+IFNlYmFzdGlhbg0KPiANCg0KVGhhbmtzLiBJIHdpbGwgaW1wcm92ZSB0
aGUgd29yZGluZyBpbiB2Mi4NCg0KWWFuLUhzdWFuDQo=
