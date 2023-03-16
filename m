Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE46BCF4C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCPMVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCPMVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 08:21:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C189F31
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 05:21:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32GCL1i34017153, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32GCL1i34017153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 20:21:01 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Mar 2023 20:20:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 16 Mar 2023 20:20:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 16 Mar 2023 20:20:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH v2 0/5] wifi: rtw89: preparation of multiple interface concurrency support
Thread-Topic: [PATCH v2 0/5] wifi: rtw89: preparation of multiple interface
 concurrency support
Thread-Index: AQHZWADTlS1gsdDdDk+9k6YancLMka78zRAA
Date:   Thu, 16 Mar 2023 12:20:40 +0000
Message-ID: <9bdda86cb36feb948ecdc10acf7346e3cee2ae1f.camel@realtek.com>
References: <20230316121206.11479-1-pkshih@realtek.com>
In-Reply-To: <20230316121206.11479-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.31]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <38735A88E312BE42A607C03655F9E951@realtek.com>
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

T24gVGh1LCAyMDIzLTAzLTE2IGF0IDIwOjEyICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IFRvIHN1cHBvcnQgY29uY3VycmVuY3ksIHdlIGltcGxlbWVudCBiZWFjb24gZmlsdGVyLCBDUU0g
YW5kDQo+IGllZWU4MDIxMTo6cmVtYWluX29uX2NoYW5uZWwgb3BzLiBTaW5jZSBvdXIgZmlybXdh
cmUgZG9lc24ndCBzdXBwb3J0IHRvIFRYDQo+IG51bGwgcGFja2V0IHdoaWxlIGRvaW5nIHJlbWFp
bi1vbi1jaGFubmVsLCBkcml2ZXIgZG9lcyB0aGlzIGluc3RlYWQuIFRvDQo+IGVuc3VyZSBudWxs
IHBhY2tldCBzZW5kIG91dCBiZWZvcmUgc3dpdGNoaW5nIGNoYW5uZWwsIHBhdGNoIDIvNSBhZGRz
IGENCj4gd2FpdGluZyBtZWNoYW5pc20uDQo+IA0KPiBUaGUgcGF0Y2hlcyA0LzUgYW5kIDUvNSBy
ZWZpbmUgdGhpbmdzIHdlIGZvdW5kIGR1cmluZyBkZXZlbG9waW5nLg0KPiANCj4gdjI6DQo+ICAg
LSBwYXRjaCAxLzUNCj4gICAgIC0gcmVtb3ZlIHVubmVjZXNzYXJ5IHR5cGUgY2FzdGluZw0KPiAg
ICAgLSB1c2UgY2xlYXIgc3R5bGUgb2YgbWFzayBkZWZpbml0aW9uIGZvciBIMkMvQzJIDQo+ICAg
LSBwYXRjaCAyLzUNCj4gICAgIC0gYWRkIGNvbW1lbnQgdG8gZGVzY3JpYmUgd2h5IHBvbGxpbmcg
Y2FuIGhlbHAgZnJlZWluZw0KPiAgIC0gb3RoZXJzDQo+ICAgICAtIG5vIGNoYW5nZQ0KPiANCj4g
UG8tSGFvIEh1YW5nICg1KToNCj4gICB3aWZpOiBydHc4OTogODg1MmM6IGFkZCBiZWFjb24gZmls
dGVyIGFuZCBDUU0gc3VwcG9ydA0KPiAgIHdpZmk6IHJ0dzg5OiBhZGQgZnVuY3Rpb24gdG8gd2Fp
dCBmb3IgY29tcGxldGlvbiBvZiBUWCBza2JzDQo+ICAgd2lmaTogcnR3ODk6IGFkZCBpZWVlODAy
MTE6OnJlbWFpbl9vbl9jaGFubmVsIG9wcw0KPiAgIHdpZmk6IHJ0dzg5OiBhZGQgZmxhZyBjaGVj
ayBmb3IgcG93ZXIgc3RhdGUNCj4gICB3aWZpOiBydHc4OTogZml4IGF1dGhlbnRpY2F0aW9uIGZh
aWwgZHVyaW5nIHNjYW4NCj4gDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L2NoYW4uYyAgICAgfCAgMzUgKysrDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L2NoYW4uaCAgICAgfCAgIDMgKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9jb3JlLmMgICAgIHwgMjg4ICsrKysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb3JlLmggICAgIHwgIDY0ICsrKysNCj4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYyAgICAgICB8IDExOCArKysrKystDQo+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmggICAgICAgfCAgNDggKysrDQo+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jICAgICAgfCAgNjEgKysr
Kw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuaCAgICAgIHwgICAx
ICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjODAyMTEuYyB8ICA4
OCArKysrKy0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMgICAg
ICB8ICAgNiArDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5oICAg
ICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcHMuYyAg
ICAgICB8ICAgNiArDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BzLmgg
ICAgICAgfCAgMTYgKw0KPiAgMTMgZmlsZXMgY2hhbmdlZCwgNzIzIGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQ0KPiANCg0KSSBtZXNzZWQgdXAgdjIuIFBsZWFzZSBpZ25vcmUuDQpTb3Jy
eSBmb3IgdGhhdC4NCg0KUGluZy1LZQ0KDQoNCg==
