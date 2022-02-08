Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177504AD816
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiBHMCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242819AbiBHMCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 07:02:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC78C03FECA
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 04:02:51 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 218C2YasC002372, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 218C2YasC002372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Feb 2022 20:02:34 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 20:02:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 20:02:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Tue, 8 Feb 2022 20:02:33 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Funny log entries for rtw88_8821ce
Thread-Topic: Funny log entries for rtw88_8821ce
Thread-Index: AQHYFvVq2DWVmxZS7E2VYxG/u8dgWqx9tPKAgAQJ/QCAB6gl/f//rFuA
Date:   Tue, 8 Feb 2022 12:02:33 +0000
Message-ID: <6baf4ae2f36c89269f74f0905ce81f38adc3a284.camel@realtek.com>
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
         <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
         <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net>
         <87czjxbukz.fsf@tynnyri.adurom.net>
In-Reply-To: <87czjxbukz.fsf@tynnyri.adurom.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [114.26.213.92]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvOCDkuIrljYggMTE6MDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB323B4FAE814439A7D68466E2D0B63@realtek.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWxsZSBWYWxvIDxrdmFsb0Br
ZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA4LCAyMDIyIDU6MDIgUE0NCj4g
VG86IExhcnJ5IEZpbmdlciA8TGFycnkuRmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gQ2M6IFBrc2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBGdW5ueSBsb2cgZW50cmllcyBmb3IgcnR3ODhfODgyMWNlDQo+IA0KPiBM
YXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+IHdyaXRlczoNCj4gDQo+ID4g
RnJvbSB0aGVzZSBsb2cgZW50cmllcywgSSBzZWUgbm8gcmVhc29uIHdoeSB0aGVyZSBzaG91bGQg
YmUgYSBzdG9wLXZpZg0KPiA+IDQxMiBzZWNvbmRzIGFmdGVyIHRoZSBpbnRlcmZhY2UgaXMgc2V0
IGZyb20gZGlzYWJsZWQgdG8gZGlzY29ubmVjdGVkLg0KPiA+IFRoaXMgY3ljbGluZyBkb2VzIG5v
dCBjYXVzZSBhbnkgcHJvYmxlbXMuIFBlcmhhcHMgdGhlIHN0YXRlbWVudHMgdGhhdA0KPiA+IGRv
IHRoZSBsb2dnaW5nIHNob3VsZCBiZSByZW1vdmVkLg0KPiANCj4gSSBkaWQgYSBxdWljayBjaGVj
ayBvbiBob3cgcnR3ODggdXNlcyBydHdfaW5mbygpIGFuZCBpbmRlZWQgdGhhdCBzaG91bGQNCj4g
YmUgY2xlYW5lZCB1cC4NCj4gDQo+IFRoZXNlIHNob3VsZCBiZSB3YXJuaW5nIG9yIGVycm9yIG1l
c3NhZ2VzOg0KPiANCj4gcnR3X2luZm8ocnR3ZGV2LCAiaW52YWxpZCBIMkMgY29tbWFuZCBmb3Jt
YXQgZm9yIGRlYnVnXG4iKTsNCj4gcnR3X2luZm8ocnR3ZGV2LCAiaW5jb3JyZWN0IGxuYSBpbmRl
eCAoJWQpXG4iLCBsbmFfaWR4KTsNCj4gcnR3X2luZm8ocnR3ZGV2LCAidW5zdXBwb3J0ZWQgdHgg
cGF0aCAweCV4XG4iLCBhbnRlbm5hX3R4KTsNCj4gcnR3X2luZm8ocnR3ZGV2LCAidW5zdXBwb3J0
ZWQgcnggcGF0aCAweCV4XG4iLCBhbnRlbm5hX3J4KTsNCj4gcnR3X2luZm8ocnR3ZGV2LCAidW5z
dXBwb3J0ZWQgdHggcGF0aCAweCV4XG4iLCBhbnRlbm5hX3R4KTsNCj4gcnR3X2luZm8ocnR3ZGV2
LCAidW5zdXBwb3J0ZWQgcnggcGF0aCAweCV4XG4iLCBhbnRlbm5hX3J4KTsNCj4gDQo+IE5vdCBz
dXJlIGlmIHdhcm4gb3IgZGVidWcsIG1vc3QgbGlrZWx5IGRlYnVnOg0KPiANCj4gcnR3X2luZm8o
cnR3ZGV2LCAiSFcgc2NhbiBhYm9ydGVkIHdpdGggY29kZTogJWRcbiIsIHJjKTsNCj4gDQo+IFRo
ZXNlIHNob3VsZCBiZSBkZWJ1ZyBtZXNzYWdlcyB0byBhdm9pZCBzcGFtbWluZyB0aGUgbG9nczoN
Cj4gDQo+IHJ0d19pbmZvKHJ0d2RldiwgInN0YXJ0IHZpZiAlcE0gb24gcG9ydCAlZFxuIiwgdmlm
LT5hZGRyLCBydHd2aWYtPnBvcnQpOw0KPiBydHdfaW5mbyhydHdkZXYsICJzdG9wIHZpZiAlcE0g
b24gcG9ydCAlZFxuIiwgdmlmLT5hZGRyLCBydHd2aWYtPnBvcnQpOw0KPiBydHdfaW5mbyhydHdk
ZXYsICJjaGFuZ2UgdmlmICVwTSAoJWQpLT4oJWQpLCBwMnAgKCVkKS0+KCVkKVxuIiwNCj4gcnR3
X2luZm8ocnR3ZGV2LCAic3RhICVwTSBqb2luZWQgd2l0aCBtYWNpZCAlZFxuIiwNCj4gcnR3X2lu
Zm8ocnR3ZGV2LCAic3RhICVwTSB3aXRoIG1hY2lkICVkIGxlZnRcbiIsDQo+IHJ0d19pbmZvKHJ0
d2RldiwgIk9uIGZyZXEgJXUgdG8gJXUsIHNldCBTQVIgJWQgaW4gMS8lbHUgZEJtXG4iDQo+IA0K
PiBUaGlzIGlzIG9rOg0KPiANCj4gcnR3X2luZm8ocnR3ZGV2LCAiRmlybXdhcmUgdmVyc2lvbiAl
dS4ldS4ldSwgSDJDIHZlcnNpb24gJXVcbiIsDQo+IA0KDQpJIHdpbGwgZml4IHRoZW0gYXMgd2Vs
bCBhcyBydHc4OS4gVG8gYXZvaWQgbWlzdGFrZXMsIEkgZG8gZ29vZ2xlIHNlYXJjaCBmb3INCktF
Uk5fSU5GTywgYW5kIGZpbmQgWzFdDQoJS0VSTl9JTkZPOiB0aGlzIGlzIHRoZSBsb2cgbGV2ZWwg
dXNlZCBmb3IgaW5mb3JtYXRpb25hbCBtZXNzYWdlcw0KCQkgICBhYm91dCB0aGUgYWN0aW9uIHBl
cmZvcm1lZCBieSB0aGUga2VybmVsLg0KDQpUaGVuLCBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0
aGUgbWVzc2FnZSBvZiBzZXR0aW5nIFNBUjoNCglydHdfaW5mbyhydHdkZXYsICJPbiBmcmVxICV1
IHRvICV1LCBzZXQgU0FSICVkIGluIDEvJWx1IGRCbVxuIg0KDQpXaGVuIGEgdXNlciBzZXRzIFNB
UiB2aWEgaXcsIHRoaXMgbWVzc2FnZSBjYW4gcmVmbGVjdCB0aGUgYWN0aW9uIHBlcmZvcm1lZA0K
YnkgZHJpdmVyLiBJcyB0aGlzIHJ0d19pbmZvIGFjY2VwdGFibGU/DQoNCg0KWzFdIGh0dHBzOi8v
bGludXhjb25maWcub3JnL2ludHJvZHVjdGlvbi10by10aGUtbGludXgta2VybmVsLWxvZy1sZXZl
bHMNCg0KLS0NClBpbmctS2UNCg0K
