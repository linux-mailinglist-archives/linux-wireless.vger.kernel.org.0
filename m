Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414334FEBEC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 02:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiDMA1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiDMA0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 20:26:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9647047
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 17:24:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23D0ODrA4002715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23D0ODrA4002715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 08:24:13 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 08:24:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 08:24:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 13 Apr 2022 08:24:13 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Thread-Topic: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Thread-Index: AQHYPxkFP7R5JPsLF0yyO3i26l23HKzqBBeAgACJGSCAAM/4AIABvL9g
Date:   Wed, 13 Apr 2022 00:24:13 +0000
Message-ID: <f528e86d086c49488c9adebc835f3f88@realtek.com>
References: <20220324004816.6202-1-pkshih@realtek.com>
         <e90e6249a7330cd60434d184d358694785e465e7.camel@sipsolutions.net>
         <1170e4f5f399431e88b8304e9b606170@realtek.com>
 <da208535ec78e867f3b1d881cd5784bdaea1b1c2.camel@sipsolutions.net>
In-Reply-To: <da208535ec78e867f3b1d881cd5784bdaea1b1c2.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTIg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDEyLCAyMDIy
IDE6NDcgUE0NCj4gVG86IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1hYzgwMjEx
OiBjb25zaWRlciBPcmRlciBiaXQgdG8gZmlsbCBDQ01QIEFBRA0KPiANCj4gT24gVHVlLCAyMDIy
LTA0LTEyIGF0IDAwOjM3ICswMDAwLCBQa3NoaWggd3JvdGU6DQo+ID4gQWZ0ZXIgSSBmaXggbXkg
ZHJpdmVyLCBJIGRvbid0IG5lZWQgdGhpcywgYnV0IEkgdGhpbmsgaXQgaXMgd29ydGggdG8NCj4g
PiBoYXZlDQo+ID4gdGhpcyBwYXRjaC4NCj4gDQo+IE9LLiBCdXQgSSBndWVzcyB0aGF0IG1lYW5z
IG5vIGh1cnJ5Lg0KDQpZZXMuDQoNCj4gDQo+IFllYWgsIHRoaW5raW5nIGFib3V0IHRoYXQsIEkg
Z3Vlc3MgeW91J3JlIHJpZ2h0LiBNYXliZSB3ZSBjYW4gZXhwcmVzcw0KPiB0aGUgMjIgYSBiaXQg
YmV0dGVyIChzb21lIGhlYWRlcmxlbiAtIDIgd2l0aCBhIGNvbW1lbnQ/KSwgYnV0IEkgY2FuIGxv
b2sNCj4gYXQgdGhhdCB3aGVuIEkgYXBwbHkgdGhlIHBhdGNoLg0KDQpIb3cgYWJvdXQgcmVwbGFj
aW5nIDIyIGJ5IDIgKyA2ICsgNiArIDYgKyAyDQpiZWNhdXNlIG9mICJGQyB8IEExIHwgQTIgfCBB
MyB8IFNDIHwgW0E0XSB8IFtRQ10iID8NCg0KUGluZy1LZQ0KDQo=
