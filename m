Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73A527B05
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 02:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiEPAli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 20:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiEPAlg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 20:41:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984A0193C1
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 17:41:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24G0fF8A1031527, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24G0fF8A1031527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 May 2022 08:41:15 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 08:41:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 08:41:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Mon, 16 May 2022 08:41:14 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 5/6] rtw89: convert rtw89_band to nl80211_band precisely
Thread-Topic: [PATCH 5/6] rtw89: convert rtw89_band to nl80211_band precisely
Thread-Index: AQHYZoxesbYsXfXU+0WOl6NbvpqPxa0ce10AgAOstgA=
Date:   Mon, 16 May 2022 00:41:14 +0000
Message-ID: <4dab18241944c2e262190500ecd9d524e69d711e.camel@realtek.com>
References: <20220513054224.16902-1-pkshih@realtek.com>
         <20220513054224.16902-6-pkshih@realtek.com>
         <548d2149-f47a-6afb-92e5-124abcecfe51@quicinc.com>
In-Reply-To: <548d2149-f47a-6afb-92e5-124abcecfe51@quicinc.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.21]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTUg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E50B2759AC04D4D84029ED21EDFCBC6@realtek.com>
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

T24gRnJpLCAyMDIyLTA1LTEzIGF0IDA5OjM0IC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6DQo+
IE9uIDUvMTIvMjAyMiAxMDo0MiBQTSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEZyb206IFpv
bmctWmhlIFlhbmcgPGtldmluX3lhbmdAcmVhbHRlay5jb20+DQo+ID4gDQo+ID4gQmVmb3JlIDZH
IGJhbmQgd2FzIHN1cHBvcnRlZCwgaS5lLiBvbmx5IDJHIGFuZCA1RywgdGhleSB3ZXJlIHRoZSBz
YW1lDQo+ID4gZnJvbSB0aGUgbnVtZXJpY2FsIHBvaW50IG9mIHZpZXcuIEhvd2V2ZXIsIGFmdGVy
IDZHIGJhbmQgc3VwcG9ydCwgd2UNCj4gPiBuZWVkIHRvIGRvIHRoaXMgY29udmVyc2lvbiBsb2dp
Y2FsbHkuDQo+IA0KPiBJbiB0aGUgYXRoIGRyaXZlcnMgd2UndmUgYmVlbiB0cnlpbmcgdG8gYXZv
aWQgdXNpbmcgdGhlIHRlcm1zIDJHLzVHLzZHIA0KPiB0byBkZXNjcmliZSBmcmVxdWVuY2llcyBz
aW5jZSB0aGF0IHVzYWdlIGNvbmZsaWN0cyB3aXRoIHRoZSBjZWxsdWxhciB1c2UgDQo+IG9mIHNp
bWlsYXIgdGVybXMgdG8gZGVzY3JpYmUgZ2VuZXJhdGlvbnMgb2YgdGhlIHRlY2hub2xvZ3ksIGFu
ZCBmdXJ0aGVyIA0KPiBjb3VsZCBjYXVzZSBjb25mdXNpb24gbm93IHRoYXQgV0ZBIGlzIGFsc28g
ZGVmaW5pbmcgZ2VuZXJhdGlvbnMgb2YgV2ktRmkgDQo+IGJ5IG51bWJlciBpbnN0ZWFkIG9mIGJ5
IElFRUUgODAyLjExIGFtZW5kbWVudC4NCj4gDQo+IFRvIHRoYXQgZW5kIGl0IHdvdWxkIGJlIG5p
Y2UgaWYgd2UgY291bGQgdW5pdmVyc2FsbHkgYWRvcHQgdXNpbmcgcHJvcGVyIA0KPiBTSSB0ZXJt
aW5vbG9neSB3aGVuIHJlZmVycmluZyB0byBXaS1GaSBmcmVxdWVuY2llczoNCj4gMiBHSHogKG9y
IDIuNCBHSHopLCA1IEdIeiwgJiA2IEdIeg0KPiANCg0KSSB3aWxsIHVzZSBTSSB0ZXJtaW5vbG9n
eSBieSB2MiwgYW5kIHNoYXJlIHRoaXMgaW5mb3JtYXRpb24gd2l0aCBteQ0KbWVtYmVycy4gQWxz
bywgSSB3aWxsIHBsYW4gdG8gcmVuYW1lIHRoZSBlbnVtKHMpIG9mIGRyaXZlciBpbiBzZXBhcmF0
ZQ0KcGF0Y2ggbGF0ZXIuDQoNCi0tDQpQaW5nLUtlDQoNCg==
