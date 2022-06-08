Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80059542462
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiFHFBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 01:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiFHFBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 01:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DE3104CE
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 18:43:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2581ADziC022611, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2581ADziC022611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 09:10:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 09:10:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 09:10:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Wed, 8 Jun 2022 09:10:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Topic: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Thread-Index: AQHYb4QquNlgqX2VSESbLHcGkKULkq1D3fwAgAAnIgCAALd/MP//hVkAgACHK4A=
Date:   Wed, 8 Jun 2022 01:10:12 +0000
Message-ID: <764fc8f115dc411e82938311273d9b51@realtek.com>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
 <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
 <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
 <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
 <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
In-Reply-To: <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvNyDkuIvljYggMTA6MDA6MDA=?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciA8bGFy
cnkuZmluZ2VyQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0KPiBTZW50OiBX
ZWRuZXNkYXksIEp1bmUgOCwgMjAyMiA5OjAzIEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT47IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4g
Q2M6IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBKb2hhbm5lcyBCZXJnIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0PjsNCj4gbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC80XSBydHc4ODogRml4IFNwYXJzZSB3YXJuaW5nIGZv
ciBydHc4ODIxY19od19zcGVjDQo+IA0KPiBPbiA2LzcvMjIgMTk6MjUsIFBpbmctS2UgU2hpaCB3
cm90ZToNCj4gPg0KPiA+DQo+ID4gSGkgTGFycnksDQo+ID4NCj4gPiBIb3cgYWJvdXQga2VlcGlu
ZyBydHc4ODIxY19od19zcGVjIGNvbnN0LCBidXQgbW92ZSBjaF9wYXJhbVszXSBmcm9tDQo+ID4g
J3N0cnVjdCBydHdfY2hpcF9pbmZvJyB0byAnc3RydWN0IHJ0d19oYWwnPw0KPiA+DQo+ID4gSWYg
eW91IGFncmVlIHRoaXMsIEkgY2FuIHByZXBhcmUgYSBwYXRjaC4NCj4gPg0KPiANCj4gSWYgdGhh
dCBmaXhlcyB0aGUgY3Jhc2hlcywgdGhhdCBpcyBmaW5lIHdpdGggbWUuIFRoZSBvdGhlciAzIGRl
dmljZXMgd2lsbCBuZWVkDQo+IHRoZSBzYW1lIGZpeC4NCj4gDQoNClRoZSBjaF9wYXJhbVszXSBp
cyBvbmx5IHVzZWQgYnkgODgyMWMsIHNvIGl0IGRvZXNuJ3QgYWZmZWN0IG90aGVyIGRldmljZXMu
DQpJIHdpbGwgcHJlcGFyZSBhIHBhdGNoIHRvIGZpeCBpdC4NCg0KUGluZy1LZQ0KDQo=
