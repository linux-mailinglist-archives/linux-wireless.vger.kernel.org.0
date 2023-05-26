Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D471260F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjEZLzr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 07:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEZLzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 07:55:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B1195
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 04:55:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34QBtGJE1009662, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34QBtGJE1009662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 26 May 2023 19:55:16 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 26 May 2023 19:55:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 May 2023 19:55:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 26 May 2023 19:55:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Question about power save
Thread-Topic: Question about power save
Thread-Index: AQHZjyJp/omCEnmceEyfVuCNSiYYRa9qwpaAgAAIjACAASJfgA==
Date:   Fri, 26 May 2023 11:55:27 +0000
Message-ID: <731603cd61e49fece503780a74d0efdef8c7e380.camel@realtek.com>
References: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
         <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
         <6d635666-4973-b498-f67b-64762dbbd768@lwfinger.net>
In-Reply-To: <6d635666-4973-b498-f67b-64762dbbd768@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.76.140]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECBD065A88199047840110913F8F6939@realtek.com>
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

T24gVGh1LCAyMDIzLTA1LTI1IGF0IDEzOjM2IC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IA0KPiBPbiA1LzI1LzIzIDEzOjA1LCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiA+IFllYWgsIEkg
dGhpbmsgSSBzYXcgdGhlIHJlcG9ydCwgYnV0IEknbSB0cmF2ZWxsaW5nIGFuZCBkaWRuJ3QgaGF2
ZSB0aGF0DQo+ID4gbXVjaCB0aW1lIHRvIHJlcGx5Lg0KPiANCj4gSm9oYW5uZXMsDQo+IA0KPiBU
aGUgcnR3ODggZHJpdmVycyBhcmUgZGVmaW5pdGVseSBzZXR0aW5nIGJvdGggU1VQUE9SVFNfUFMg
YW5kDQo+IFNVUFBPUlRTX0RZTkFNSUNfUFMuIEl0IHNlZW1zIHRoYXQgdGhlcmUgaXMgYSBidWcg
c29tZXdoZXJlIGlzIHRob3NlIGRyaXZlcnMuDQo+IA0KPiBJbiBteSByZXBvLCBJIHdpbGwgcmVt
b3ZlIHRoZSBTVVBQT1JUU19EWU5BTUlDX1BTLCB3aGljaCB3aWxsIHNvbHZlIHRoZSBwcm9ibGVt
DQo+IHJhaXNlZCBpbiB0aGUgR2l0SHViIGlzc3VlLiBUaGF0IHdpbGwgZ2l2ZSBtZSB0aW1lIHRv
IGZpbmQgdGhhdCBidWcuDQo+IA0KDQpXZSBhbHNvIGhhdmUgYmVlbiBhd2FyZSBvZiB0aGlzIGEg
Y291cGxlIGRheXMgYWdvLCBzbyB3ZSBhcmUgcHJlcGFyaW5nIHBhdGNoZXMNCnRvIGNvcnJlY3Qg
dGhpcyBmb3IgYm90aCBydHc4OC84OS4gVGhlIG1ldGhvZCBpcyB0aGF0IHJlLWNhbGN1bGF0ZSBp
ZiB3ZSBjYW4NCmVudGVyIFBTIGJ5IGNoYW5nZXMgb2YgQlNTX0NIQU5HRURfUFMgYW5kIHZpZi0+
Y2ZnLnBzLg0KSSB3aWxsIHN1Ym1pdCB0aGUgcGF0Y2ggc29vbi4gDQoNClBpbmctS2UNCg0K
