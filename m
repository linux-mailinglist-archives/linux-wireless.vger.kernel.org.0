Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD1785B07
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjHWOr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjHWOr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:47:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB543E69
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 07:47:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37NEkp1S3012840, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37NEkp1S3012840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Aug 2023 22:46:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 23 Aug 2023 22:47:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 23 Aug 2023 22:47:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 23 Aug 2023 22:47:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
Thread-Topic: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
Thread-Index: AQHZ0Brxr+k/PO8FCkKk2NopO/rnjK/38wxC//+H2AA=
Date:   Wed, 23 Aug 2023 14:47:12 +0000
Message-ID: <22a5d99c4f4be30dd7659400ba9a42c0701f6521.camel@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
         <87o7ixhng5.fsf@kernel.org>
In-Reply-To: <87o7ixhng5.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.79.203]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <7013293E26D05F41A89A16170836CA9D@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
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

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDE2OjU2ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gVERN
QS1iYXNlZCBNQ0MgKFNUQStQMlApIGlzIGEga2luZCBvZiBtdWx0aXBsZSBpbnRlcmZhY2VzIGNv
bmN1cnJlbmNlLg0KPiA+IEJhc2ljYWxseSwgZHJpdmVyIGlzIHRvIGNhbGN1bGF0ZSB0aW1lc2xv
dCBwYXR0ZXJuIGFuZCBmaXJtd2FyZSBmb2xsb3dzDQo+ID4gdGhlIHBhdHRlcm4gdG8gc3dpdGNo
IGNoYW5uZWxzLiBTaW5jZSBCVC1jb2V4aXN0ZW5jZSBpcyBhbHNvIGEgVERNQS1iYXNlZA0KPiA+
IG1lY2hhbmlzbSwgYWxzbyBjb25zaWRlciBCVCB0aW1lc2xvdCBpbnRvIHBhdHRlcm4gaWYgQlQg
ZGV2aWNlcyBwcmVzZW50Lg0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiB3aXRoIFRETUEgaGVyZT8g
SXQgc29tZXRoaW5nIGxpa2UgdGhhdCBpbiBTVEEgbW9kZSB0aGUNCj4gZHJpdmVyIGVuYWJsZXMg
ODAyLjExIFBTIG1vZGUgYmVmb3JlIGdvaW5nIHRvIGFub3RoZXIgY2hhbm5lbD8gT3INCj4gc29t
ZXRoaW5nIGVsc2U/DQo+IA0KDQpZZXMsIHdoZW4gaXQgaXMgd29ya2luZyBhcyBTVEEgbW9kZSBv
ciBHQywgdXNpbmcgODAyLjExIFBTIG1vZGUgYmVmb3JlDQpzd2l0Y2hpbmcgY2hhbm5lbC4gV2hl
biBpdCBwbGF5cyBhcyBHTywgTm9BIGlzIHVzZWQgdG8gaW5mb3JtIEdDIGFic2VudA0KdGltaW5n
LiANCg0KRm9yIGV4YW1wbGUsIFNUQSBvbiBjaGFubmVsIDEgKyBHTyBvbiBjaGFubmVsIDExLCBh
bmQgcHJlc2VydmUgc29tZQ0KdGltZSBzbG90IGZvciBCVA0KDQoNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKDEpDQogY2hhbm5lbCAxICAgKFNUQSkgICArKysrKysrKysNCg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKDIpDQogY2hhbm5lbCAxMSAgKEdPKSAgICAgICAgICAg
ICArKysrKysrKysNCg0KIEJUICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKysr
KysrKysNCg0KICAgICAgICAgICAgICAgICAgICAgfDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT58
DQogICAgICAgICAgICAgICAgICAgICAgIFBlcmlvZCAob3IgY3ljbGUgdGltZSkNCiANCigxKSBp
c3N1ZSBudWxsIHdpdGggcG93ZXIgYml0DQooMikgaXNzdWUgYmVhY29uIHdpdGggTm9BIA0KDQoN
ClRob3VnaCBTVEEgYW5kIEdPIGFyZSBpbiBkaWZmZXJlbnQgY2hhbm5lbHMsIHRoZXkgZG9uJ3Qg
b3BlcmF0ZSBhdA0KdGhlIHNhbWUgdGltZS4gVGhpcyBpcyB0aGUgcmVhc29uIEkgcG9pbnQgIlRE
TUEiIHRvIHByZXZlbnQNCm1pc3VuZGVyc3RhbmRpbmcgdHdvIHZpcnR1YWwgaW50ZXJmYWNlcyBj
YW4gb3BlcmF0ZSB0d28gY2hhbm5lbHMNCmF0IHRoZSBzYW1lIHRpbWUsIHdoaWNoIG1heSBiZSBj
YWxsZWQgREJTIG9yIERCQ0MuIEJ1dCwgSSdtIHRyeWluZw0KdG8gZXhwbGFpbiBoYXJkd2FyZSBj
YXBhYmlsaXR5IGNvcnJlY3RseS4NCg0KUGluZy1LZQ0KDQoNCg==
