Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987957910F3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjIDFgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 01:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIDFgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 01:36:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CD4FB6
        for <linux-wireless@vger.kernel.org>; Sun,  3 Sep 2023 22:36:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3845Zia36028740, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3845Zia36028740
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Sep 2023 13:35:44 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Sep 2023 13:36:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 4 Sep 2023 13:36:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 4 Sep 2023 13:36:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "shubhisroking@gmail.com" <shubhisroking@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
Thread-Topic: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
Thread-Index: AQHZ3X0MiJxICAqZA0+oCnRLrtY4OLAJ5EgA//+z2YCAAAn4AA==
Date:   Mon, 4 Sep 2023 05:36:10 +0000
Message-ID: <12daa0f4654b407b0a79007f7432a3e7535793d7.camel@realtek.com>
References: <20230902090808.67926-1-shubhisroking@gmail.com>
         <53577222509340228cd27847e4d7f999@realtek.com>
         <CADMyVtz6DbxwNMRJMzS6RTG9z5GyjizHWgWC4xHQgczDHZLMOg@mail.gmail.com>
In-Reply-To: <CADMyVtz6DbxwNMRJMzS6RTG9z5GyjizHWgWC4xHQgczDHZLMOg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <160EA34499C58D4CBF953CDE5DF91313@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTA0IGF0IDEwOjI5ICswNTMwLCBTaHViaCB3cm90ZToNCj4gDQo+IFNv
LCBpcyBpdCBhY2NlcHRlZCwgcmlnaHQ/IEFsc28sIHdoYXQgZG8geW91IG1lYW4gYnkgJ0kgdGhp
bmsgYW55IHBhdGNoIG5lZWRzIGEgY29tbWl0IG1lc3NhZ2UsDQo+IGV2ZW4gYSBzaW1wbGUgcGF0
Y2ggbGlrZSB0aGlzJz8gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8gTGlrZSwgSSBkaWRuJ3QgaW5j
bHVkZSBhIGNvbW1pdCBtZXNzYWdlPw0KPiBCZWNhdXNlIGFzIEkgY2FuIHNlZSwgSSBoYXZlIGNv
bW1pdCBtZXNzYWdlIGluIHRoZSBzdWJqZWN0IG9mIHRoZSBlbWFpbC4gUGxlYXNlIGZlZWwgZnJl
ZSB0bw0KPiBjb3JyZWN0IG1lLg0KPiANCg0KTm90IG9ubHkgaW5jbHVkZSBhIHN1YmplY3QgYnV0
IHNvbWUgZGVzY3JpcHRpb24gdGhhdCBJIG1lYW50IGJlZm9yZS4gDQoNCkJ5IHRoZSB3YXksIG5v
IHRvcCBwb3N0aW5nIGFuZCBzaG91bGQgcmVwbHkgaW4gcGxhaW4gdGV4dCBtb2RlLg0KDQoNCg==
