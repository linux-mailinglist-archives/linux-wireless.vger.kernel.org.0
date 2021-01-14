Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA682F5635
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbhANBod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 20:44:33 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44264 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbhANBQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 20:16:43 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10E1FTxI4020537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10E1FTxI4020537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 09:15:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 09:15:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Thu, 14 Jan 2021 09:15:29 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>
Subject: RE: [PATCH v2 4/7] rtw88: replace tx tasklet with tx work
Thread-Topic: [PATCH v2 4/7] rtw88: replace tx tasklet with tx work
Thread-Index: AQHW6ZH5phOfY8KHiUKPWljFRNdiMaolZLeAgADs9uA=
Date:   Thu, 14 Jan 2021 01:15:28 +0000
Message-ID: <3d27cfd738e645858b1ff186307e4912@realtek.com>
References: <20210113095101.16570-1-pkshih@realtek.com>
 <20210113095101.16570-5-pkshih@realtek.com>
 <CA+ASDXMZL-nWU=Wn=SQOQr6aSR2ntW15RbuUNvXLmH+q1q35nw@mail.gmail.com>
In-Reply-To: <CA+ASDXMZL-nWU=Wn=SQOQr6aSR2ntW15RbuUNvXLmH+q1q35nw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJyaWFuIE5vcnJpcyBbbWFp
bHRvOmJyaWFubm9ycmlzQGNocm9taXVtLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkg
MTQsIDIwMjEgMzowNSBBTQ0KPiBUbzogUGtzaGloDQo+IENjOiBZYW4tSHN1YW4gQ2h1YW5nOyBL
YWxsZSBWYWxvOyBsaW51eC13aXJlbGVzczsgQmVybmllIEh1YW5nDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgNC83XSBydHc4ODogcmVwbGFjZSB0eCB0YXNrbGV0IHdpdGggdHggd29yaw0KPiAN
Cj4gT24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMTo1MyBBTSBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQby1IYW8gSHVhbmcgPHBoaHVhbmdA
cmVhbHRlay5jb20+DQo+ID4NCj4gPiBNb3ZlIHR4IHRhc2tsZXQgdG8gdGhyZWFkLCBieSB0aGlz
IHdlIGNhbiByZWR1Y2UgdGltZSBzcGVudCBvbg0KPiA+IHdhaXRpbmcgZm9yIHNjaGVkdWxlIGFu
ZCBoYXZlIGJldHRlciBlZmZpY2llbmN5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUG8tSGFv
IEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2Ug
U2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiANCj4gSSdtIGN1cmlvdXMsIHdoeSBhIGJhcmUg
a3RocmVhZCBhbmQgbm90IGp1c3QgYSAoV1FfSElHSFBSST8pDQo+IHdvcmtxdWV1ZT8gSXQgc2Vl
bXMgbGlrZSB5b3UncmUgc29ydCBvZiByZWltcGxlbWVudGluZyBzb21lIG9mIHRoZQ0KPiB3b3Jr
cXVldWUgc2VtYW50aWNzIHdpdGggeW91ciBTQ0hFRFVMRUQgYW5kIFJVTk5JTkcgZmxhZ3MsIHdo
ZW4NCj4gcXVldWVfd29yaygpIHdvdWxkIGRvIHRoYXQgZm9yIHlvdS4NCj4gDQoNClRoYW5rcyBm
b3IgeW91ciBhZHZpY2UuDQpXZSdsbCBkbyBpdCBpbiB2NCwgc2luY2UgdjMgaGFzIGJlZW4gc2Vu
dCwgYnV0IG5vdCBhcHBlYXIgaW4gcGF0Y2h3b3JrLg0KDQotLS0NClBpbmctS2UNCg0K
