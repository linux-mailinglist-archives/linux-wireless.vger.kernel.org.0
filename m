Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25398444BEA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Nov 2021 01:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhKDAUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 20:20:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44695 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhKDAUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 20:20:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A40HI380025632, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A40HI380025632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 4 Nov 2021 08:17:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 08:17:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 08:17:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Thu, 4 Nov 2021 08:17:17 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Bogdan Nicolae <bogdan.nicolae@acm.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: No support for Realtek 8821CE RFE Type 6
Thread-Topic: No support for Realtek 8821CE RFE Type 6
Thread-Index: AQHXy7lkSRIUIcq7CEaFpFpEp9A8RqvxU6VAgAAlr2CAABi2AIAA9urQ
Date:   Thu, 4 Nov 2021 00:17:17 +0000
Message-ID: <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
 <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
 <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
In-Reply-To: <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzMg5LiL5Y2IIDEwOjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/04/2021 00:07:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167084 [Nov 03 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;www.amazon.com:7.1.1;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/04/2021 00:10:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJvZ2RhbiBOaWNvbGFlIDxi
b2dkYW4ubmljb2xhZUBhY20ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNCwgMjAy
MSAxOjI2IEFNDQo+IFRvOiBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogTm8gc3VwcG9ydCBmb3Ig
UmVhbHRlayA4ODIxQ0UgUkZFIFR5cGUgNg0KPiANCj4gVGhhbmtzIFBpbmctS2UsDQo+IA0KPiBU
aGUgUmVhbHRlayBXaWZpIDg4MjFDRSBSRkUgVHlwZSA2IGlzIHVzZWQgaW4gYSBicm9hZCByYW5n
ZSBvZg0KPiBlbWJlZGRlZCBzeXN0ZW1zIGJhc2VkIG9uIEludGVsIENlbGVyb24gSjQxMjUgU29D
cy4gQSBwb3B1bGFyIGV4YW1wbGUNCj4gaXMgR0szIE1pbmkgUEMsIHNvbGQgdW5kZXIgYSBsYXJn
ZSBudW1iZXIgb2YgYnJhbmRzLCBmb3IgZXhhbXBsZToNCj4gaHR0cHM6Ly93d3cuYW1hem9uLmNv
bS9ncC9wcm9kdWN0L0IwOUZUQ1BCSEsvDQo+IFRoZXNlIHN5c3RlbXMgYXJlIHJpc2luZyBpbiBw
b3B1bGFyaXR5IGluIGZhdm9yIG9mIGxhcHRvcHMsIGFzIHBlb3BsZQ0KPiB0ZW5kIHRvIHN0YXkg
YXQgaG9tZSBhbmQgYXJlIGxvb2tpbmcgZm9yIGFmZm9yZGFibGUgdXBncmFkZXMuDQo+IFVuZm9y
dHVuYXRlbHksIGxhY2sgb2YgV2lmaSBMaW51eCBzdXBwb3J0IGlzIGEgbWFqb3IgZHJhd2JhY2su
DQo+IA0KDQpDb3VsZCB5b3UgaGVscCB0byBjb25maXJtIGZvbGxvd2luZyB0aGluZ3M6DQoNCjEu
IERvIHlvdSBzZWUgInJmZSA2IGlzbid0IHN1cHBvcnRlZCIgaW4ga2VybmVsIGxvZz8NCiAgIEkg
d2FudCB0byBjb25maXJtIHRoZSB0eXBlIGFnYWluLg0KMi4gSWYgeW91IGJvb3QgdGhpcyBzeXN0
ZW0gaW50byBXaW5kb3dzIDEwLCBkb2VzIHRoZSA4ODIxQ0Ugd29yayBwcm9wZXJseT8NCiAgIElm
IHNvLCBwbGVhc2UgZ2l2ZSBtZSBpdHMgVklEL1BJRCBvZiBQQ0kuDQozLiBDb3VsZCBJIGhhdmUg
dGhlIHBpY3R1cmVzIG9mIHRoZSBtb2R1bGUgb2YgYm90aCBzaWRlcz8gDQogICBJIHdvdWxkIGxp
a2UgdG8ga25vdyB0aGUgbW9kdWxlIG1hcmtlcjsgYXMgd2VsbCBhcyBhbnRlbm5hIGxvY2F0aW9u
Lg0KDQotLQ0KUGluZy1LZQ0KDQo=
