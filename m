Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A075763FD1B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLBAco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 19:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiLBAcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 19:32:03 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B6FDCD7BF
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 16:29:17 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B20SSylC011449, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B20SSylC011449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 08:28:28 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 2 Dec 2022 08:29:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 08:29:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 2 Dec 2022 08:29:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v4 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Topic: [PATCH v4 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Index: AQHZBY9V9Vc1zO5SKUayGY0rkaeTLK5Zvs8A
Date:   Fri, 2 Dec 2022 00:29:13 +0000
Message-ID: <2e944ad482ee49188e3eb571a5ba32c6@realtek.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
 <5b41f1ae-72e7-6b7a-2459-b736399a1c40@gmail.com>
In-Reply-To: <5b41f1ae-72e7-6b7a-2459-b736399a1c40@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzEg5LiL5Y2IIDEwOjA4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAx
LCAyMDIyIDEwOjE1IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMi8zXSB3aWZpOiBydGw4
eHh4dTogRml4IHRoZSBjaGFubmVsIHdpZHRoIHJlcG9ydGluZw0KPiANCj4gVGhlIGdlbiAyIGNo
aXBzIFJUTDgxOTJFVSBhbmQgUlRMODE4OEZVIHBlcmlvZGljYWxseSBzZW5kIHRoZSBkcml2ZXIN
Cj4gcmVwb3J0cyBhYm91dCB0aGUgVFggcmF0ZSwgYW5kIHRoZSBkcml2ZXIgcGFzc2VzIHRoZXNl
IHJlcG9ydHMgdG8NCj4gc3RhX3N0YXRpc3RpY3MuIFRoZSByZXBvcnRzIGZyb20gUlRMODE5MkVV
IG1heSBvciBtYXkgbm90IGluY2x1ZGUgdGhlDQo+IGNoYW5uZWwgd2lkdGguIFRoZSByZXBvcnRz
IGZyb20gUlRMODE4OEZVIGRvIG5vdCBpbmNsdWRlIGl0Lg0KPiANCj4gT25seSBhY2Nlc3MgdGhl
IGMyaC0+cmFfcmVwb3J0LmJ3IGZpZWxkIGlmIHRoZSByZXBvcnQgKHNrYikgaXMgYmlnDQo+IGVu
b3VnaC4NCj4gDQo+IFRoZSBvdGhlciBwcm9ibGVtIGZpeGVkIGhlcmUgaXMgdGhhdCB0aGUgY29k
ZSB3YXMgYWN0dWFsbHkgbmV2ZXINCj4gY2hhbmdpbmcgdGhlIGNoYW5uZWwgd2lkdGggaW5pdGlh
bGx5IHJlcG9ydGVkIGJ5DQo+IHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQgYmVjYXVzZSB0aGUg
dmFsdWUgb2YgUkFURV9JTkZPX0JXXzIwIGlzIDAuDQo+IA0KPiBGaXhlczogMDk4NWQzYTQxMGFj
ICgicnRsOHh4eHU6IEZlZWQgY3VycmVudCB0eHJhdGUgaW5mb3JtYXRpb24gZm9yIG1hYzgwMjEx
IikNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0KPiAtLS0NCj4gdjQ6DQo+ICAtIFVzZSB0aGUgbW9yZSBjb252ZW5pZW50IG9mZnNldG9mZW5k
IG1hY3JvLg0KPiANCj4gdjM6DQo+ICAtIERvbid0IGFzc3VtZSBidyB3aWxsIGFsd2F5cyBiZSAx
IGJ5dGUuDQo+IA0KPiB2MjoNCj4gIC0gRWxpbWluYXRlIHRoZSBtYWdpYyBudW1iZXJzLg0KPiAt
LS0NCg0KWy4uLl0NCg0K
