Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF586E2EDC
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 05:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDODqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDODp4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 23:45:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA55270
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 20:45:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F3jMv55001398, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F3jMv55001398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 11:45:23 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 11:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 15 Apr 2023 11:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec]) by
 RTEXDAG02.realtek.com.tw ([fe80::b457:c042:266c:6fec%5]) with mapi id
 15.01.2375.007; Sat, 15 Apr 2023 11:45:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>,
        Gary Chang <gary.chang@realtek.com>
Subject: Re: [PATCH 2/5] wifi: rtw89: refine scan function after chanctx
Thread-Topic: [PATCH 2/5] wifi: rtw89: refine scan function after chanctx
Thread-Index: AQHZbtpB+64NDY+jxEi+Hfd6/tXK4K8rNayA
Date:   Sat, 15 Apr 2023 03:45:44 +0000
Message-ID: <048c2591a93365eea802d723cdccec6b3e5965e0.camel@realtek.com>
References: <20230414140316.27656-1-pkshih@realtek.com>
         <20230414140316.27656-3-pkshih@realtek.com>
In-Reply-To: <20230414140316.27656-3-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.20.53]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D24D7FAA28DE54899212F8913DC5A53@realtek.com>
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

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDIyOjAzICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IEZyb206IFBvLUhhbyBIdWFuZyA8cGhodWFuZ0ByZWFsdGVrLmNvbT4NCj4gDQo+IFNpbmNlIHdl
IGNhbiBnZXQgdGhlIGN1cnJlbnQgY2hhbm5lbCBkZWZpbml0aW9uIGVhY2ggaW50ZXJmYWNlIG1h
cHMgdG8sDQo+IHJlbW92ZSBzdG9yZV9vcCBmdW5jdGlvbiB0aGF0IGlzIG5vIGxvbmdlciByZXF1
aXJlZCB0byBtYWtlIHRoaW5ncyBzaW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQby1IYW8g
SHVhbmcgPHBoaHVhbmdAcmVhbHRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiANCg0KWy4uLl0NCg0KPiBAQCAtMjU2NywxMyArMjU2
NywxMSBAQCBpbnQgcnR3ODlfZndfaDJjX3NjYW5fb2ZmbG9hZChzdHJ1Y3QgcnR3ODlfZGV2ICpy
dHdkZXYsDQo+ICAJUlRXODlfU0VUX0ZXQ01EX1NDQU5PRkxEX1NUQVJUX01PREUoY21kLCBSVFc4
OV9TQ0FOX0lNTUVESUFURSk7DQo+ICAJUlRXODlfU0VUX0ZXQ01EX1NDQU5PRkxEX1NDQU5fVFlQ
RShjbWQsIFJUVzg5X1NDQU5fT05DRSk7DQo+ICAJaWYgKG9wdGlvbi0+dGFyZ2V0X2NoX21vZGUp
IHsNCj4gLQkJUlRXODlfU0VUX0ZXQ01EX1NDQU5PRkxEX1RBUkdFVF9DSF9CVyhjbWQsIHNjYW5f
aW5mby0+b3BfYncpOw0KPiArCQlSVFc4OV9TRVRfRldDTURfU0NBTk9GTERfVEFSR0VUX0NIX0JX
KGNtZCwgb3AtPmJhbmRfd2lkdGgpOw0KPiAgCQlSVFc4OV9TRVRfRldDTURfU0NBTk9GTERfVEFS
R0VUX1BSSV9DSChjbWQsDQo+IC0JCQkJCQkgICAgICAgc2Nhbl9pbmZvLT5vcF9wcmlfY2gpOw0K
PiAtCQlSVFc4OV9TRVRfRldDTURfU0NBTk9GTERfVEFSR0VUX0NFTlRSQUxfQ0goY21kLA0KPiAt
CQkJCQkJCSAgIHNjYW5faW5mby0+b3BfY2hhbik7DQo+IC0JCVJUVzg5X1NFVF9GV0NNRF9TQ0FO
T0ZMRF9UQVJHRVRfQ0hfQkFORChjbWQsDQo+IC0JCQkJCQkJc2Nhbl9pbmZvLT5vcF9iYW5kKTsN
Cj4gKwkJCQkJCSAgICAgICBvcC0+cHJpbWFyeV9jaGFubmVsKTsNCj4gKwkJUlRXODlfU0VUX0ZX
Q01EX1NDQU5PRkxEX1RBUkdFVF9DRU5UUkFMX0NIKGNtZCwgb3AtPmNoYW5uZWwpOw0KPiArCQlS
VFc4OV9TRVRfRldDTURfU0NBTk9GTERfVEFSR0VUX0NIX0JBTkQoY21kLCBvcC0+YmFuZF90eXBl
KTsNCj4gIAl9DQo+ICANCj4gIAlydHc4OV9oMmNfcGt0X3NldF9oZHIocnR3ZGV2LCBza2IsIEZX
Q01EX1RZUEVfSDJDLA0KPiANCg0KVGhpcyBwYXRjaCB0b3VjaCB0aGVzZSBtYWNyb3MsIHNvIEkg
YWRkIGEgcGF0Y2ggdG8gY29udmVydCB0aGVtIGJ5IHYyLg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBh
dGNoc2V0Lg0KDQpQaW5nLUtlDQoNCg==
