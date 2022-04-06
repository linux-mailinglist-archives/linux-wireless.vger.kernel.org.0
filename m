Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000144F5EDD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiDFNGT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 09:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiDFNGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 09:06:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1720307746
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 18:45:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2361ivndF023423, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2361ivndF023423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 6 Apr 2022 09:44:57 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 09:44:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 09:44:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Wed, 6 Apr 2022 09:44:57 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "honyuenkwun@gmail.com" <honyuenkwun@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: 8821ce: add support for device ID 0xb821
Thread-Topic: [PATCH] rtw88: 8821ce: add support for device ID 0xb821
Thread-Index: AQHYR7cf1DCZfB3cJUGciCqImwI3cqzhmgmA
Date:   Wed, 6 Apr 2022 01:44:57 +0000
Message-ID: <52b3df7b5d5ac976ce3697364447aa001125b6a2.camel@realtek.com>
References: <20220404000107.11327-1-honyuenkwun@gmail.com>
In-Reply-To: <20220404000107.11327-1-honyuenkwun@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.21.190]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNSDkuIvljYggMTA6MTc6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <956F0BD6697CF84F85CE44AB10714DD5@realtek.com>
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

T24gU3VuLCAyMDIyLTA0LTAzIGF0IDE5OjAxIC0wNTAwLCBKaW1teSBIb24gd3JvdGU6DQo+IE5l
dyBkZXZpY2UgSUQgMHhiODIxIGZvdW5kIG9uIFRQLUxpbmsgVDJFDQo+IFRlc3RlZCBpdCB3aXRo
IGM4MjEgZHJpdmVyLiAyLjRHSHogYW5kIDVHSHogd29ya3MuDQo+IA0KPiBQQ0kgaWQ6DQo+IDA1
OjAwLjAgTmV0d29yayBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQu
IERldmljZSBiODIxDQo+ICAgICAgICAgU3Vic3lzdGVtOiBSZWFsdGVrIFNlbWljb25kdWN0b3Ig
Q28uLCBMdGQuIERldmljZSBiODIxDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW1teSBIb24gPGhv
bnl1ZW5rd3VuQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3BjaS5jICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9ydHc4ODIxY2UuYyB8IDQgKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9wY2kuYw0KPiBpbmRleCBhMDk5MWQzZjE1YzAuLjM4ZWQ1YzM1YTJiZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wY2kuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jDQo+IEBAIC0xNzcw
LDcgKzE3NzAsNyBAQCBpbnQgcnR3X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4g
IAl9DQo+ICANCj4gIAkvKiBEaXNhYmxlIFBDSWUgQVNQTSBMMSB3aGlsZSBkb2luZyBOQVBJIHBv
bGwgZm9yIDg4MjFDRSAqLw0KPiAtCWlmIChwZGV2LT5kZXZpY2UgPT0gMHhjODIxICYmIGJyaWRn
ZS0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfSU5URUwpDQo+ICsJaWYgKChwZGV2LT5kZXZpY2Ug
PT0gMHhjODIxIHx8IHBkZXYtPmRldmljZSA9PSAweGM4MjEpICYmIGJyaWRnZS0+dmVuZG9yID09
DQo+IFBDSV9WRU5ET1JfSURfSU5URUwpDQoNClRoaXMgc3RhdG1lbnQgaXMgdXNlZCB0byBmaXgg
MHhjODIxIHdoaWxlIGRvaW5nIE5BUEkgcG9sbC4gQWN0dWFsbHksIHlvdSBkaWRuJ3QNCnJlYWxs
eSBmaWxsIHRoZSBuZXcgSUQgMHhiODIxLCBidXQgaXQgc3RpbGwgd29ya3MuIFNvLCBJIGRvbid0
IHRoaW5rIHlvdSBuZWVkIHRvDQphZGQgMHhiODIxIHRvIHRoaXMgc3RhdGVtZW50LCByaWdodD8N
Cg0KSWYgeW91IHJlYWxseSB3YW50IHRvIGFkZCAweGI4MjEsIHVzZSBjaGlwX2lkIHdvdWxkIGJl
IGJldHRlci4NCg0KLSAgICAgICBpZiAocGRldi0+ZGV2aWNlID09IDB4YzgyMSAmJiBicmlkZ2Ut
PnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0lOVEVMKQ0KKyAgICAgICBpZiAocnR3ZGV2LT5jaGlw
LT5pZCA9PSBSVFdfQ0hJUF9UWVBFXzg4MjFDICYmIGJyaWRnZS0+dmVuZG9yID09IFBDSV9WRU5E
T1JfSURfSU5URUwpDQoNCi0tDQpQaW5nLUtlDQoNCg0K
