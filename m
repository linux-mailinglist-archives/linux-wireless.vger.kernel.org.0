Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93677F7A2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 15:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbjHQNXA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351446AbjHQNWj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 09:22:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15C8235A8
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 06:22:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37HDLCxF4013231, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37HDLCxF4013231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 21:21:12 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Aug 2023 21:21:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 17 Aug 2023 21:21:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 17 Aug 2023 21:21:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "gregory.greenman@intel.com" <gregory.greenman@intel.com>
Subject: Re: [RFC] wifi: mac80211: fix UBSAN warning caused by reorder_buf_filtered bits shift-out-of-bounds
Thread-Topic: [RFC] wifi: mac80211: fix UBSAN warning caused by
 reorder_buf_filtered bits shift-out-of-bounds
Thread-Index: AQHZ0Mx0fntfUGBm7E6lIBAm7nSdWa/tigWAgABUmICAAAbBAIAADjqA
Date:   Thu, 17 Aug 2023 13:21:32 +0000
Message-ID: <3db092ea0aa6b758e23df577f415f142e82776a2.camel@realtek.com>
References: <20230817053215.51636-1-pkshih@realtek.com>
         <d55de56e2cc69031f1588fc1db981f5bed640348.camel@sipsolutions.net>
         <408e1ca10cb4daabdad0e2760f69a9b03fbeedd3.camel@realtek.com>
         <dda4148bb980f7f92b8092854be140e6a79e8c4a.camel@sipsolutions.net>
In-Reply-To: <dda4148bb980f7f92b8092854be140e6a79e8c4a.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.88.175]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4F3399BE78E774A87EF92E199BD7773@realtek.com>
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

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDE0OjMwICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiANCj4gPiA+IEkgZG9uJ3QgcmVhbGx5IHRoaW5rIHRoaXMgaXMgc3RhYmxlIG1hdGVyaWFsIC0g
aWYgdGhlcmUncyBhIGRyaXZlcg0KPiA+ID4gdGhhdCdzIGNhbGxpbmcgdGhpcyB3aGVuID42NCBm
cmFtZXMgaXMgc3VwcG9ydGVkIHRoZW4gaXQncyBhIGRyaXZlciBidWcNCj4gPiA+IHRoYXQgc2hv
dWxkIGJlIGZpeGVkLCBhbmQgaWYgbm90IHRoZW4gdGhlcmUncyBubyBidWc/DQo+ID4gDQo+ID4g
SSdsbCByZW1vdmUgdGhpcy4NCj4gDQo+IEFjdHVhbGx5IEkgZG9uJ3Qga25vdyAtIGRvIHlvdSBo
YXZlIGEgZHJpdmVyIHRoYXQncyBhY3R1YWxseSBzdXBwb3J0aW5nDQo+ID4gNjQgQmxvY2tBY2sg
b24gc3RhYmxlPw0KDQpJIGRvbid0IGhhdmUgdGhhdCBvbmUuIA0KDQpBY3R1YWxseSB0aGUgY29k
ZSBjYW4gd29yayB3ZWxsLCBldmVuIHRob3VnaCBpdCBoYXMgZHJhd2JhY2sgZm91bmQgYnkgVUJT
QU4uIA0KU28sIEkgdGhvdWdodCBtYXliZSBzb21lIGRyaXZlcnMgd29yayB1bmRlciB0aGF0IHNp
dHVhdGlvbi4gDQoNCj4gDQo+IEp1c3Qgc2VuZCB0aGUgcGF0Y2ggYXMgaXQgd2FzPw0KPiANCg0K
SSB3aWxsLiANCg0KUGluZy1LZQ0KDQoNCg==
