Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0414E72A9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbiCYMDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbiCYMDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 08:03:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EADD4C92
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 05:01:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22PC1ovdE005077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22PC1ovdE005077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 20:01:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 20:01:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 20:01:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Fri, 25 Mar 2022 20:01:49 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?5p2O5L2z6YGg?= <leo.li@realtek.com>
Subject: Re: [PATCH 00/16] rtw89: refine PCI and MAC codes into function with attributes
Thread-Topic: [PATCH 00/16] rtw89: refine PCI and MAC codes into function with
 attributes
Thread-Index: AQHYQA3iwI7Zp8iaJku1RE/l33ZnBazP8jH+//+HlQA=
Date:   Fri, 25 Mar 2022 12:01:49 +0000
Message-ID: <132b019a86c94d9cef209c4f6291cfcd942faa01.camel@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
         <87y20ynv61.fsf@kernel.org>
In-Reply-To: <87y20ynv61.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.71.187]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUg5LiK5Y2IIDA5OjUzOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <2339536DE7229C4394BE946C08697A62@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTI1IGF0IDEzOjExICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBUaGUgZXhp
c3RpbmcgUENJIGFuZCBNQUMgY29kZXMgYXJlIG9ubHkgdXNlZCBieSA4ODUyQUUsIHNvIG1hbnkg
c2V0dGluZ3MgYXJlDQo+ID4gcHV0IGluIHNpbmdsZSBmdW5jdGlvbi4gVG8gYmUgY2xlYXIsIG1v
dmUgdGhlIHNldHRpbmdzIGludG8gYW4gaW5kaXZpZHVhbA0KPiA+IGZ1bmN0aW9uIGFjY29yZGlu
ZyB0byBpdHMgZnVuY3Rpb25hbGl0eS4gU2luY2UgZnVuY3Rpb25zIHdpbGwgYmUgc2hhcmVkDQo+
ID4gd2l0aCBjaGlwcywgYWRkIGF0dHJpYnV0ZXMgdG8gbWFrZSBpdCBwb3NzaWJsZSB0byB1c2Ug
Y29tbW9uIGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBBbHNvLCB1cGRhdGUgdGhlIHNldHRpbmdzIHRv
IHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBvdXIgaW50ZXJuYWwgY29kZS4NCj4gPiANCj4gPiBUaGlz
IHBhdGNoc2V0IGlzIGJhc2VkIG9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KPiA+ICAicnR3ODk6IGFkZCBmaXJtd2FyZSByZXNldCBhbmQg
ZHVtcCBmaXJtd2FyZSBtZW1vcnkgYW5kIGJhY2t0cmFjZSIgYW5kDQo+ID4gICJydHc4OTogdXBk
YXRlIFRYIHBvd2VyIHRhYmxlIGFuZCA2RywgcmVmaW5lIElHSSwgYW5kIGFkZCBUWC9SWCBkZXNj
cmlwdG9ycyBWMSINCj4gPiBCdXQgbm8gYWN0dWFsIGZ1bmN0aW9uIGRlcGVuZGVuY3kuICAgICAN
Cj4gDQo+IFRoZSBtZXJnZSB3aW5kb3cgaXMgbm93IG9wZW4gd2hpY2ggbWVhbnMgd2lyZWxlc3Mt
bmV4dCBpcyBjbG9zZWQuIEkNCj4gZG9uJ3QgbWluZCBwZW9wbGUgc3VibWl0dGluZyBmZXcgLW5l
eHQgcGF0Y2hlcyBkdXJpbmcgdGhlIG1lcmdlIHdpbmRvdywNCj4gYnV0IHRoZXJlJ3MgYSBsaW1p
dCBmb3IgdGhhdC4gQ3VycmVudGx5IEkgc2VlIDM5IHJ0dzg5IHBhdGNoZXMgaW4NCj4gcGF0Y2h3
b3JrLCB0aGF0J3MganVzdCB0b28gbXVjaC4gU28gcGxlYXNlIHRyeSB0byBsaW1pdCB0aGUgbnVt
YmVyIG9mDQo+IHBhdGNoZXMgeW91IHN1Ym1pdCBkdXJpbmcgdGhlIG1lcmdlIHdpbmRvdy4NCj4g
DQo+IFVzdWFsbHkgd2lyZWxlc3MtbmV4dCBvcGVucyBmZXcgZGF5cyBhZnRlciAtcmMxIGlzIHJl
bGVhc2VkLCBidXQgdGhlcmUncw0KPiBubyBmaXhlZCBzY2hlZHVsZS4NCj4gDQoNCkdvdCBpdC4g
SSdsbCBzdG9wIHN1Ym1pdHRpbmcgYmVmb3JlIHF1ZXVlZCBwYXRjaGVzIGdldCByZXZpZXdlZC4g
DQpJZiB0aGlzIHBhdGNoc2V0IGlzIGluY29udmVuaWVudCB0byB5b3UsIHBsZWFzZSBkcm9wIGl0
Lg0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0K
