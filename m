Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C26E2EF0
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDOEA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 00:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDOEAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 00:00:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDA5270
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 21:00:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F4061Q0024705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F4061Q0024705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 12:00:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 12:00:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 15 Apr 2023 12:00:28 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec]) by
 RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec%5]) with mapi id
 15.01.2375.007; Sat, 15 Apr 2023 12:00:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: Question about rtw88 patches
Thread-Topic: Question about rtw88 patches
Thread-Index: AQHZbwpiFNgrFoOq/kmg2I/EzLeK4a8rOWmA
Date:   Sat, 15 Apr 2023 04:00:28 +0000
Message-ID: <e8e70392bb38ee44f29fd0dc2522daa8340cf609.camel@realtek.com>
References: <3aaaceb0-1518-49b6-ca18-f7c46c35c65c@lwfinger.net>
In-Reply-To: <3aaaceb0-1518-49b6-ca18-f7c46c35c65c@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.20.53]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <6843D7972CE8D84B992EC69CB18E354C@realtek.com>
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

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDE0OjUwIC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IA0KPiBLYWxsZSwNCj4gDQo+IEhhcyBzb21ldGhpbmcgZ29uZSB3cm9uZyB3aXRoIFNhc2hhJ3Mg
cnR3ODggcGF0Y2hlcyB0byBmaXggdGhlIGhhcmR3YXJlIHF1ZXVlDQo+IHNlbGVjdGlvbiBpbiBy
dHc4OCBbMV0sIGFuZCB0aGUgY29ycmVzcG9uZGluZyByZmUgZmllbGQgd2lkdGggZml4IFsyXS4g
VGhlc2UgdHdvDQo+IHBhdGNoZXMgYXJlIGluY2x1ZGVkIGluIG15IEdpdEh1YiByZXBvIGZvciBy
dHc4OCwgYW5kIHRoZXkgZml4IHRoZSB1YmlxdWl0b3VzDQo+ICJ0aW1lZCBvdXQgdG8gZmx1c2gg
cXVldWUiIHdhcm5pbmdzLg0KPiANCj4gTGFycnkNCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIzMDQwNDA3MjUwOC41NzgwNTYtMi1zLmhhdWVy
QHBlbmd1dHJvbml4LmRlLw0KPiBbMl0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
d2lyZWxlc3MvMjAyMzA0MDQwNzI1MDguNTc4MDU2LTMtcy5oYXVlckBwZW5ndXRyb25peC5kZS8N
Cj4gDQoNCkhpIExhcnJ5LA0KDQpJIHRoaW5rIHRoaXMgaXMgYmVjYXVzZSBJIGhhdmUgc29tZSBz
dWdnZXN0aW9ucyBvZiBbMl0gdG8gaW1wcm92ZSBmdXJ0aGVyLg0KRG8geW91IHRoaW5rIHdlIGNh
biB0YWtlIHRoaXMgdGVtcG9yYXJ5IHZlcnNpb24gaW4gYWR2YW5jZT8gDQoNClBpbmctS2UNCg0K
DQo=
