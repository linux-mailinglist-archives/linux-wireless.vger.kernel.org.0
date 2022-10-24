Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCA6097F3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJXBsU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Oct 2022 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJXBsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Oct 2022 21:48:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307556E88E
        for <linux-wireless@vger.kernel.org>; Sun, 23 Oct 2022 18:48:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29O1laelF005988, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29O1laelF005988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Oct 2022 09:47:36 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Oct 2022 09:48:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Oct 2022 09:48:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 24 Oct 2022 09:48:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
Thread-Topic: [PATCH 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
Thread-Index: AQHY4YSZLQ/A6qXBgEyoHcMrhYlOea4YWosggABTMYCABCIbIA==
Date:   Mon, 24 Oct 2022 01:48:09 +0000
Message-ID: <6a57d98b53334f419539a9ea80ff3d74@realtek.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
 <6a91fd1b8d5e4bf3910366121ed92f3b@realtek.com>
 <c3540f87-b124-2642-f53e-aa15704a54e8@gmail.com>
In-Reply-To: <c3540f87-b124-2642-f53e-aa15704a54e8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIzIOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAyMiwg
MjAyMiAyOjMyIEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29y
ZW5zZW5AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gd2lmaTogcnRsOHh4
eHU6IEFkZCBjZW50cmFsIGZyZXF1ZW5jeSBvZmZzZXQgdHJhY2tpbmcNCj4gDQo+IE9uIDIxLzEw
LzIwMjIgMDg6NDcsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTcsIDIwMjIgMToy
NyBBTQ0KPiBbLi4uXQ0KPiA+PiArCQkJaWYgKHByaXYtPmNmb190cmFja2luZy5wYWNrZXRfY291
bnQgPT0gMHhmZmZmZmZmZikNCj4gPj4gKwkJCQlwcml2LT5jZm9fdHJhY2tpbmcucGFja2V0X2Nv
dW50ID0gMDsNCj4gPj4gKwkJCWVsc2UNCj4gPj4gKwkJCQlwcml2LT5jZm9fdHJhY2tpbmcucGFj
a2V0X2NvdW50Kys7DQo+ID4NCj4gPiAncGFja2V0X2NvdW50JyBpcyB1MzIsIHNvIDB4ZmZmZmZm
ZmYgKyAxIHdpbGwgYmVjb21lIDAuIFRoZW4sIGp1c3QNCj4gPg0KPiA+ICAgIHByaXYtPmNmb190
cmFja2luZy5wYWNrZXRfY291bnQrKzsNCj4gPg0KPiANCj4gSSB0aG91Z2h0IHNvLCBidXQgSSdt
IG5vdCAqdGhhdCogZmFtaWxpYXIgd2l0aCB0aGUgQyBzdGFuZGFyZCwNCj4gc28gSSBsZWZ0IGl0
IGhvdyBJIGZvdW5kIGl0IGluIG9uZSBvZiB0aGUgUmVhbHRlayBkcml2ZXJzLg0KDQoncGFja2V0
X2NvdW50JyBpcyB1c2VkIGFzIGEgc2VxdWVuY2UgbnVtYmVyIHRvIGluZGljYXRlIG51bWJlciBv
ZiByZWNlaXZlZA0KcGFja2V0cyBpcyBjaGFuZ2VkLCBhbmQgdGhlbiBpdCBjYW4gcmUtY2FsY3Vs
YXRlIENGTy4gU28sIGRvbid0IHdvcnJ5IHRvDQpkbyBwYWNrZXRfY291bnQrKywgbm90IGp1c3Qg
bGVmdCBjb2RlIGZyb20gUmVhbHRlayB2ZW5kb3IgZHJpdmVyLiBUaGlzIGlzDQpvbmUgcmVhc29u
IHRoYXQgd2UgbmVlZCB0byByZXdyaXRlIHRoZSBkcml2ZXIgZm9yIExpbnV4IHVwc3RyZWFtLg0K
DQpQaW5nLUtlDQoNCg==
