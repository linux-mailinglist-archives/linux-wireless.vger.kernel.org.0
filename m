Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1128C707
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgJMCLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 22:11:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35292 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgJMCLj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 22:11:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09D2BTVY0018278, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09D2BTVY0018278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Oct 2020 10:11:29 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 13 Oct 2020 10:11:29 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa]) by
 RTEXMB04.realtek.com.tw ([fe80::89f7:e6c3:b043:15fa%3]) with mapi id
 15.01.2044.006; Tue, 13 Oct 2020 10:11:29 +0800
From:   Andy Huang <tehuang@realtek.com>
To:     "'Brian Norris'" <briannorris@chromium.org>,
        David Rubio <david.alejandro.rubio@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Topic: rtw88 / rtl_8821ce: rfe 2 is not supported
Thread-Index: AQHWn+l1M4JR4F24I0SZAkWf/gzk8qmTwKwAgAEJzzA=
Date:   Tue, 13 Oct 2020 02:11:28 +0000
Message-ID: <362f154dff1b4d6f88503af813eae406@realtek.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
In-Reply-To: <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
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

VGhlIHN1cHBvcnQgZm9yIFJGRSB0eXBlIDIgb2YgODgyMWNlLCB0aGUgcGF0Y2hlcyBhcmUgcmVh
ZHksIGJ1dCB3ZSBuZWVkIHRvIGRvIHNvbWUgdmVyaWZpY2F0aW9ucy4gQWZ0ZXIgdGhlIHZlcmlm
aWNhdGlvbiBpdCB3aWxsIGJlIHVwbG9hZC4NCg0KVHp1LUVuDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4g
DQpTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAyMDIwIDI6MTMgQU0NClRvOiBEYXZpZCBSdWJp
byA8ZGF2aWQuYWxlamFuZHJvLnJ1YmlvQGdtYWlsLmNvbT4NCkNjOiBsaW51eC13aXJlbGVzcyA8
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnPjsgWWFuLUhzdWFuIENodWFuZyA8dG9ueTA2
MjBlbW1hQGdtYWlsLmNvbT47IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2Fs
LmNvbT4NClN1YmplY3Q6IFJlOiBydHc4OCAvIHJ0bF84ODIxY2U6IHJmZSAyIGlzIG5vdCBzdXBw
b3J0ZWQNCg0KT24gU3VuLCBPY3QgMTEsIDIwMjAgYXQgOToxMyBBTSBEYXZpZCBSdWJpbyA8ZGF2
aWQuYWxlamFuZHJvLnJ1YmlvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9jdCAxMSAxMjoyMDozOSB5
b3VtdSBrZXJuZWw6IHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiByZmUgMiBpc24ndCANCj4gc3Vw
cG9ydGVkDQoNCkknbSBub3Qgc3VyZSBhbnl0aGluZyBjaGFuZ2VkIHNpbmNlIHRoZSBsYXN0IHRp
bWUgdGhpcyBjYW1lIHVwOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVz
cy9jMGMzMzZkODA2NTg0MzYxOTkyZDRiNTI2NjVmYmI4MkByZWFsdGVrLmNvbS8NCg0KSSB0aGlu
ayB0aGlzIG5lZWRzIHNvbWVib2R5IGZyb20gUmVhbHRlayB0byBsb29rLCBvciBlbHNlIGlnbm9y
ZSB0aGUgb2JqZWN0aW9ucyBhbmQgbWVyZ2UgdGhlIHN1Yi1vcHRpbWFsICh0cml2aWFsKSBwYXRj
aC4gSSdtIG5vdCBzdXJlIG9mIHRoZSByYW1pZmljYXRpb25zIG9mIGRvaW5nIHRoZSBsYXR0ZXIu
DQoNCkJyaWFuDQoNCi0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3Jl
IHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
