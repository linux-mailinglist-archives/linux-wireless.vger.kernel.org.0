Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83E172F5F0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbjFNHTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjFNHS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 03:18:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F21FC2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 00:18:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35E7GjdhE013490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35E7GjdhE013490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 14 Jun 2023 15:16:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 14 Jun 2023 15:17:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 14 Jun 2023 15:17:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 14 Jun 2023 15:17:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "petter@technux.se" <petter@technux.se>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "morrownr@gmail.com" <morrownr@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux@ulli-kroll.de" <linux@ulli-kroll.de>,
        "petter.mabacker@esab.se" <petter.mabacker@esab.se>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: Linux mainline support for RTL8811AU/RTL8821AU
Thread-Topic: Linux mainline support for RTL8811AU/RTL8821AU
Thread-Index: AQHZnc5dl9i8HjN9rEOIrsiwl7X/wK+IiCyAgAFbh4A=
Date:   Wed, 14 Jun 2023 07:17:03 +0000
Message-ID: <e1d49f94865f4a69b3b3228b00697ad1@realtek.com>
References: <20230613080907.328548-1-petter@technux.se>
 <91f3ecc2-7ae4-b17d-acda-f3f7e4b48f6f@lwfinger.net>
In-Reply-To: <91f3ecc2-7ae4-b17d-acda-f3f7e4b48f6f@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IFdlZG5lc2RheSwgSnVuZSAxNCwgMjAyMyAyOjI5IEFNDQo+IFRvOiBwZXR0ZXJAdGVjaG51eC5z
ZTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT47IG1vcnJvd25yQGdtYWlsLmNvbTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBrdmFsb0BrZXJuZWwub3JnOw0KPiBsaW51eEB1bGxpLWtyb2xsLmRlOyBwZXR0ZXIubWFi
YWNrZXJAZXNhYi5zZTsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogTGlu
dXggbWFpbmxpbmUgc3VwcG9ydCBmb3IgUlRMODgxMUFVL1JUTDg4MjFBVQ0KPiANCj4gT24gNi8x
My8yMyAwMzowOSwgcGV0dGVyQHRlY2hudXguc2Ugd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBJ
J20gaW52ZXN0aWdhdGluZyBhIHdpZmkgZG9uZ2xlIChMTTgwOCkgdGhhdCBpcyBiYXNlZCBvbiB0
aGUgUlRMODgxMUFVIGNoaXBzZXQuDQo+ID4NCj4gPiAkIGxzdXNiDQo+ID4gLi4NCj4gPiBCdXMg
MDAzIERldmljZSAwNjY6IElEIDBiZGE6YTgxMSBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ29ycC4g
UlRMODgxMUFVIDgwMi4xMWEvYi9nL24vYWMgV0xBTiBBZGFwdGVyDQo+ID4gLi4NCj4gPg0KPiA+
IEkgY2Fubm90IGZpbmQgYW55IGRyaXZlciBzdXBwb3J0IGluIG1haW5saW5lIGZvciB0aGF0IGNo
aXBzZXQgKDg4MTFjdS84ODIxY3UsIHNlZW1zIHRvIGV4aXN0cykuIEp1c3QgY3VyaW91cw0KPiBp
ZiBhbnlvbmUga25vd3MgaWYgdGhlcmUgYXJlIGFueSBvbmdvaW5nIGVmZm9ydHMgdG8gZ2V0IHRo
aXMgZHJpdmVyIGluY2x1ZGVkIGluIG1haW5saW5lPw0KPiA+DQo+ID4gSSBjYW4gc2VlIHRoYXQg
Ym90aDoNCj4gPg0KPiA+IGh0dHBzOi8vd3d3LmxtLXRlY2hub2xvZ2llcy5jb20vcHJvZHVjdC93
aWZpLXVzYi1hZGFwdGVyLTQzM21icHMtbG04MDgvP3RlbXBsYXRlPWRyaXZlcg0KPiA+DQo+ID4g
YW5kDQo+ID4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbW9ycm93bnIvODgyMWF1LTIwMjEwNzA4
DQo+ID4NCj4gPiBleGlzdHMgZm9yIG5vbi1tYWlubGluZSBzdXBwb3J0LCBzbyB3aWxsIHBsYXkg
YSBiaXQgd2l0aCB0aGVtLiBCdXQgZm9yIG1haW50ZW5hbmNlIGV0YyBJJ20gaW50ZXJlc3RlZA0K
PiB0byBsZWFybiBhYm91dCBwb3NzaWJsZSBtYWlubGluZSBlZmZvcnRzIHdpdGhpbiB0aGlzIGFy
ZWEuDQo+IA0KPiBJdCBzZWVtcyB0aGF0IHRoZSBSVFc4ODIxQUUgaGFzIG5ldmVyIGJlZW4gYnVp
bHQgb3IgcmVsZWFzZWQuIElmIGl0IGhhZCBiZWVuLA0KPiB0aGVuIGV4dGVuZGluZyB0aGF0IGRy
aXZlciB0byB0aGUgODgyMUFVIHdvdWxkIGJlIGVhc3kgYXMgdGhlcmUgd291bGQgYmUgYSBmaWxl
DQo+IHJ0dzg4MjFhLmMgdGhhdCBjb250YWluZWQgYWxsIHRoZSBkZXRhaWxzIG9mIHRoYXQgY2hp
cC4gV2l0aG91dCB0aGF0LCB0aGVyZSBpcw0KPiBsaXR0bGUgdGhhdCBhbnlvbmUgb3V0c2lkZSBS
ZWFsdGVrIGNhbiBkby4gVGhlIHZlbmRvciBkcml2ZXIsIHdoaWNoIGlzIHRoZSBvbmUNCj4gaW4g
dGhlIGxpbmsgeW91IHBvc3RlZCwgd2lsbCBsaWtlbHkgd29yay4NCj4gDQoNCnJ0bHdpZmkgY2Fu
IHN1cHBvcnQgUlRMODgyMUFFL1JUTDg4MTJBRSBhbmQgYmFzaWMgVVNCIGluZnJhc3RydWN0dXJl
LCBzbyBpdCBsb29rcw0KbGlrZSBwb3NzaWJsZSB0byBzdXBwb3J0IDg4MjFBVSBieSBydGx3aWZp
Lg0KDQpQaW5nLUtlDQoNCg==
