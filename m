Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078BB6F22C7
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 05:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjD2D7E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 23:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjD2D7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 23:59:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276802717
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:59:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33T3wtTF3028611, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33T3wtTF3028611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 29 Apr 2023 11:58:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 29 Apr 2023 11:58:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 29 Apr 2023 11:58:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 29 Apr 2023 11:58:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZd5tasrPlKIiNeUKI8XDI8zOKla9ACi8AgACsjoCAAHGzAA==
Date:   Sat, 29 Apr 2023 03:58:57 +0000
Message-ID: <fb57cba49f869012af089fcd8b12b4962c570429.camel@realtek.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
         <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
         <c2e57571-4fc4-69ef-f8a1-049bf2eca9ed@gmail.com>
In-Reply-To: <c2e57571-4fc4-69ef-f8a1-049bf2eca9ed@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.30]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6198888BBC8B04690A6DE4A665600D6@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTI5IGF0IDAwOjExICswMzAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMjgvMDQvMjAyMyAwOToyMSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IA0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBB
cHJpbCAyNiwgMjAyMyAxOjI4IEFNDQo+ID4gPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsg
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0hd
IHdpZmk6IHJ0bDh4eHh1OiBTdXBwb3J0IG5ldyBjaGlwIFJUTDgxOTJGVQ0KPiA+ID4gDQo+ID4g
PiBUaGlzIGlzIGEgbmV3ZXIgY2hpcCwgc2ltaWxhciB0byB0aGUgUlRMODcxMEJVIGluIHRoYXQg
aXQgdXNlcyB0aGUgc2FtZQ0KPiA+ID4gUEhZIHN0YXR1cyBzdHJ1Y3RzLg0KPiA+ID4gDQo+ID4g
PiBGZWF0dXJlczogMi40IEdIeiwgYi9nL24gbW9kZSwgMlQyUiwgMzAwIE1icHMuDQo+ID4gPiAN
Cj4gPiA+IEl0IGNhbiBhbGxlZ2VkbHkgaGF2ZSBCbHVldG9vdGgsIGJ1dCB0aGF0J3Mgbm90IGlt
cGxlbWVudGVkIGhlcmUuDQo+ID4gPiANCj4gPiA+IFRoaXMgY2hpcCBjYW4gaGF2ZSBtYW55IFJG
RSAoUkYgZnJvbnQgZW5kKSB0eXBlcywgb2Ygd2hpY2ggdHlwZSA1IGlzDQo+ID4gPiB0aGUgb25s
eSBvbmUgdGVzdGVkLiBNYW55IG9mIHRoZSBvdGhlciB0eXBlcyBuZWVkIGRpZmZlcmVudA0KPiA+
ID4gaW5pdGlhbGlzYXRpb24gdGFibGVzLiBUaGV5IGNhbiBiZSBhZGRlZCBpZiBzb21lb25lIHdh
bnRzIHRoZW0uDQo+ID4gPiANCj4gPiA+IFRoZSB2ZW5kb3IgZHJpdmVyIHY1LjguNi4yXzM1NTM4
LjIwMTkxMDI4X0NPRVgyMDE5MDkxMC0wZDAyIGZyb20NCj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9CcmlnaHRYL3J0bDgxOTJmdSB3YXMgdXNlZCBhcyByZWZlcmVuY2UuDQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9LY29uZmlnIHwgICAgMyArLQ0KPiA+ID4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dS5oICB8ICAgNDcgKw0KPiA+ID4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1XzgxODhmLmMgICAgICAgICB8ICAgIDMgKy0NCj4gPiA+ICAuLi4vcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV84MTkyZi5jICAgICAgICAgfCAyMDgxICsrKysrKysrKysrKysrKysrDQo+
ID4gPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcxMGIuYyAgICAgICAgIHwgICAg
MSArDQo+ID4gPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODcyM2IuYyAgICAgICAg
IHwgICAgMSArDQo+ID4gPiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVf
Y29yZS5jIHwgIDEwNCArLQ0KPiA+ID4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1X3JlZ3MuaCB8ICAgMTUgKw0KPiA+ID4gIDggZmlsZXMgY2hhbmdlZCwgMjIyNSBpbnNl
cnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTkyZi5jDQo+ID4g
PiANCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gK3N0YXRpYyB2b2lkIHJ0bDgxOTJmdV9j
b25maWdfa2ZyZWUoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHU4IGNoYW5uZWwpDQo+ID4g
PiArew0KPiA+ID4gKyAgICAgICB1OCBiYl9nYWluWzNdID0geyBFRlVTRV9VTkRFRklORUQsIEVG
VVNFX1VOREVGSU5FRCwgRUZVU0VfVU5ERUZJTkVEIH07DQo+ID4gPiArICAgICAgIHU4IGJiX2dh
aW5fcGF0aF9tYXNrWzJdID0geyAweDBmLCAweGYwIH07DQo+ID4gPiArICAgICAgIGVudW0gcnRs
OHh4eHVfcmZwYXRoIHJmcGF0aDsNCj4gPiA+ICsgICAgICAgdTggYmJfZ2Fpbl9mb3JfcGF0aDsN
Cj4gPiA+ICsgICAgICAgdTggY2hhbm5lbF9pZHg7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlm
IChjaGFubmVsID49IDEgJiYgY2hhbm5lbCA8PSAzKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIGNo
YW5uZWxfaWR4ID0gMDsNCj4gPiA+ICsgICAgICAgaWYgKGNoYW5uZWwgPj0gNCAmJiBjaGFubmVs
IDw9IDkpDQo+ID4gPiArICAgICAgICAgICAgICAgY2hhbm5lbF9pZHggPSAxOw0KPiA+ID4gKyAg
ICAgICBpZiAoY2hhbm5lbCA+PSAxMCAmJiBjaGFubmVsIDw9IDE0KQ0KPiA+ID4gKyAgICAgICAg
ICAgICAgIGNoYW5uZWxfaWR4ID0gMjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgcnRsOHh4eHVf
cmVhZF9lZnVzZTgocHJpdiwgMHgxZWUsICZiYl9nYWluWzFdKTsNCj4gPiA+ICsgICAgICAgcnRs
OHh4eHVfcmVhZF9lZnVzZTgocHJpdiwgMHgxZWMsICZiYl9nYWluWzBdKTsNCj4gPiA+ICsgICAg
ICAgcnRsOHh4eHVfcmVhZF9lZnVzZTgocHJpdiwgMHgxZWEsICZiYl9nYWluWzJdKTsNCj4gPiAN
Cj4gPiBDYW4geW91IGRlZmluZSB0aGVzZSBmaWVsZHMgaW4gc3RydWN0IHJ0bDgxOTJmdV9lZnVz
ZSwgYW5kIGFjY2VzcyB2aWENCj4gPiB0aGUgc3RydWN0Pw0KPiA+IA0KPiANCj4gVGhleSBhcmUg
bm90IGluIHRoZSBlZnVzZSBtYXAuIFRoZXNlIGFyZSAicGh5c2ljYWwiIGVmdXNlIGFkZHJlc3Nl
cy4NCj4gSSBkb24ndCBrbm93IHdoYXQgdGhhdCBtZWFucywgYXMgSSBoYXZlIG5vdCBzdHVkaWVk
IHRoZSBlZnVzZSBzdHVmZi4NCg0KSSBtaXNzIHRoZSBwb2ludC4gVGhlbiwgeW91ciBjb2RlIGlz
IHJpZ2h0LiANCg0KInBoeXNpY2FsIiBhZGRyZXNzIGlzIGp1c3QgYXMgaXRzIG5hbWUsIG5vIG1v
cmUgZXhwbGFpbi4gDQoNCk90aGVyd2lzZSwgc3RydWN0IHJ0bDgxOTJmdV9lZnVzZSBpcyAibG9n
aWMiIGFkZHJlc3MgdGhhdCBpcyB0cmFuc2xhdGVkDQpmcm9tIGVuY29kZWQgZGF0YSByZWFkIGZy
b20gcGh5c2ljYWwgc3RhcnRpbmcgYXQgMHgwLg0KDQo+IEkgd29uZGVyIGFib3V0IHRoZXNlOg0K
PiANCj4gI2RlZmluZSBSRUdfSVFLX1JUUF9UWEEgMHhlOTgNCj4gI2RlZmluZSBSRUdfSVFLX1JU
UF9SWEEgMHhlYTgNCj4gI2RlZmluZSBSRUdfSVFLX1JUUF9UWEIgMHhlYjgNCj4gI2RlZmluZSBS
RUdfSVFLX1JUUF9SWEIgMHhlYzgNCj4gDQo+IFNob3VsZCB0aGV5IGJlIFJFR19JUUtfUlBUXy4u
LiBmb3IgInJlcG9ydCI/DQoNClJpZ2h0LCBwbGVhc2UgY29ycmVjdCB0aGVtLg0KDQo+IA0KPiBB
bmQgdGhlc2U6DQo+IA0KPiAjZGVmaW5lIFJFR19SRUZfT1BUNjIgMHg5NjgNCj4gI2RlZmluZSBS
RUdfUkVGX09QVCAweDkyMA0KPiANCj4gU2hvdWxkIHRoZXkgYmUgUkVHX1JGRV8uLi4gPw0KPiAN
Cg0KUmlnaHQsIHBsZWFzZSBjb3JyZWN0IHRoZW0gdG9vLiANCg0KU29ycnkgZm9yIHRoZSBtaXN0
YWtlcy4gDQoNCg0K
