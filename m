Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE18741CEE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjF2Aco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 20:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjF2Ack (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 20:32:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E9B71FC2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jun 2023 17:32:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35T0WERA0019534, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35T0WERA0019534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Jun 2023 08:32:14 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 29 Jun 2023 08:32:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Jun 2023 08:32:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 29 Jun 2023 08:32:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Giulio Paci <giuliopaci@gmail.com>
CC:     James <bjlockie@lockie.ca>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8822ce connection is very unstable
Thread-Topic: Realtek 8822ce connection is very unstable
Thread-Index: AQHZqQnme5lXUSoFX0KxvKzAZ70xJa+eSecAgAACcoCAACRSgIAA+I6AgAAXDICAADBjAIABPGiA
Date:   Thu, 29 Jun 2023 00:32:15 +0000
Message-ID: <518990b094f94ca489276ebb5dbf5d81@realtek.com>
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
 <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
 <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
 <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
 <b3c5f2f05d0844dfb4e9f7e943b4cbbd@realtek.com>
 <CA+zRt5HyZaOvDpVUxF9Rfv4rrx4Us1Krs+TeiP-U9QsrA_SX6A@mail.gmail.com>
 <d4c7dbda-a24f-9ff1-3a9f-918034c60f92@gmail.com>
In-Reply-To: <d4c7dbda-a24f-9ff1-3a9f-918034c60f92@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyOCwg
MjAyMyA5OjI4IFBNDQo+IFRvOiBHaXVsaW8gUGFjaSA8Z2l1bGlvcGFjaUBnbWFpbC5jb20+OyBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IEphbWVzIDxiamxvY2tpZUBs
b2NraWUuY2E+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFJlYWx0ZWsgODgyMmNlIGNvbm5lY3Rpb24gaXMgdmVyeSB1bnN0YWJsZQ0KPiANCj4gT24gMjgv
MDYvMjAyMyAxMzozNSwgR2l1bGlvIFBhY2kgd3JvdGU6DQo+ID4NCj4gPiBJIGNvbmZpcm0gdGhp
cyBpcyB0aGUgYXBwcm9hY2ggSSB1c2VkIGluIGFsbCBteSBhdHRlbXB0cywgaW5jbHVkaW5nDQo+
ID4gZGlzYWJsZV9scHNfZGVlcD0xLg0KPiA+IEkgYWxzbyBjaGVja2VkIC9zeXMvbW9kdWxlLyRt
b2R1bGUvcGFyYW1ldGVycy8kb3B0aW9uIGNvbnRlbnQsIHRvDQo+ID4gY29uZmlybSB0aGF0IHRo
ZSBvcHRpb25zIHdlcmUgY29ycmVjdGx5IHNldC4NCj4gPg0KPiA+IEkgaGF2ZSBhbHNvIGNhcnJp
ZWQgb3V0IHNvbWUgYWRkaXRpb25hbCBhdHRlbXB0czoNCj4gPg0KPiA+IC0gYm9vdCB3aXRoIGlv
bW11LnBhc3N0aHJvdWdoPTEgaW5zdGVhZCBvZiBwY2llX2FzcG09b2ZmLCBidXQgaXQgZG9lcw0K
PiA+IG5vdCBzZWVtIHRvIGltcHJvdmUgYW55dGhpbmcgKGFuZCBBRVIgZXJyb3JzIGNhbWUgYmFj
ayBpbiB0aGUgZG1lc2cpOw0KPiA+IC0gQWZ0ZXIgbXkgY29tbWVudHMgb24gaHR0cHM6Ly9naXRo
dWIuY29tL2x3ZmluZ2VyL3J0dzg4L2lzc3Vlcy8xNTAsDQo+ID4gaHR0cHM6Ly9naXRodWIuY29t
L2x3ZmluZ2VyL3J0dzg4LyB3YXMgdXBkYXRlZCBhbmQgSSB3YXMgYWJsZSB0byBsb2FkDQo+ID4g
dGhlc2UgbW9kdWxlcy4gVGhlIGNvbm5lY3Rpb24gaXMgc3RpbGwgdmVyeSB1bnN0YWJsZSwgYnV0
IHdpdGggdGhlc2UNCj4gPiBtb2R1bGVzLCB3aGVuIHRoZSBjb25uZWN0aW9uIGhhbmdzLCBkbWVz
ZyByZXBvcnRzOg0KPiA+DQo+ID4gcnR3Xzg4MjJjZSAwMDAwOjAzOjAwLjA6IGZpcm13YXJlIGZh
aWxlZCB0byBsZWF2ZSBscHMgc3RhdGUNCj4gPg0KPiA+IHNvbWV0aW1lcyBmb2xsb3dlZCBieToN
Cj4gPg0KPiA+IHJ0d184ODIyY2UgMDAwMDowMzowMC4wOiBmYWlsZWQgdG8gc2VuZCBoMmMgY29t
bWFuZA0KDQpJIHN1Z2dlc3QgdG8gdHJ5ICJpdyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmYiIGZv
ciB0aGVzZSB0d28gY2FzZXMsIG9yDQp5b3UgY2FuIGNvbmZpZ3VyZSBuZXR3b3JrX21hbmFnZXIg
YWxvbmcgd2l0aCBbMV0uDQpBbmQsIGFzIHlvdXIgZXhwZXJpbWVudCwgc2V0IHBjaWVfYXNwbT1v
ZmYgdG8gdGhlIExpbnV4IGNvbW1hbmQgbGluZSB0bw0KYXZvaWQgQUVSIGVycm9yLg0KDQoNClsx
XSBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9qY2JlcnRob24vZWE4Y2ZlMjc4OTk4OTY4YmE3YzVh
OTUzNDRiYzhiNTUNCg0KPiA+IE9uZSBvZiBteSBjb2xsZWFndWVzIGhhcyB0aGUgc2FtZSBoYXJk
d2FyZSAoc2FtZSBBUCBtb2RlbCBhbmQgc2FtZQ0KPiA+IGxhcHRvcCBtb2RlbCkgYW5kIGFsc28g
dHJpZWQgdG8gaW5zdGFsbCBEZWJpYW4gYm9va3dvcm0gb24gaXQuIEkgYXNrZWQNCj4gPiB0byBj
aGVjayBpZiBoZSBleHBlcmllbmNlcyB0aGUgc2FtZSBpc3N1ZSwgYnV0IGluIGhpcyBjYXNlIGhl
IHdhcyBhYmxlDQo+ID4gdG8gc3RheSBjb25uZWN0ZWQgZm9yIGEgZmV3IGhvdXJzIHdpdGhvdXQg
YW55IGlzc3VlLg0KPiA+IEkgd29uZGVyIGlmIHRoZSBpc3N1ZSBJIGFtIGV4cGVyaWVuY2luZyBj
b3VsZCBiZSBkdWUgdG8gZGVmZWN0aXZlDQo+ID4gaGFyZHdhcmUgKGluaXRpYWxseSBJIGV4Y2x1
ZGVkIGl0IHNpbmNlIHRoZSBzYW1lIGNvbmZpZ3VyYXRpb24gaXMgdmVyeQ0KPiA+IHN0YWJsZSB1
bmRlciBXaW5kb3dzKS4gSXMgdGhlcmUgYW55IHNwZWNpZmljIHRlc3QgdGhhdCBJIGNhbiB0cnkg
dG8NCj4gPiBleGNsdWRlIGhhcmR3YXJlIGlzc3Vlcz8NCj4gPg0KPiA+IEJlc3RzLA0KPiA+IEdp
dWxpbw0KPiANCj4gWW91IGNhbiBzd2FwIHRoZSB3aWZpIGNhcmRzIGluIHRoZSB0d28gbGFwdG9w
cy4gTWFrZSBzdXJlIHRvIHVucGx1Zw0KPiB0aGUgY2hhcmdlciBhbmQgdGhlIGJhdHRlcnkgYmVm
b3JlIHdvcmtpbmcgaW5zaWRlLg0KPiANCg0KSSBoYXZlIHRoZSBzYW1lIHRoaW5raW5nLiANCg0K
DQo=
