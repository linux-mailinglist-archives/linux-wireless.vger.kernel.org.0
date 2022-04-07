Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6954F7BC3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiDGJhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiDGJhb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 05:37:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4367939D
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 02:35:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2379ZQO90001733, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2379ZQO90001733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 17:35:26 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 17:35:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 17:35:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Thu, 7 Apr 2022 17:35:26 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "honyuenkwun@gmail.com" <honyuenkwun@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID
Thread-Topic: [PATCH 2/2] rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using
 chip ID
Thread-Index: AQHYSlU/yKsMbHMCLk6kc9XVbi/MxKzjqtWA
Date:   Thu, 7 Apr 2022 09:35:26 +0000
Message-ID: <588c70fc890c8aa30728c3eb40f6cc6a5a9bbf16.camel@realtek.com>
References: <20220407075123.420696-1-honyuenkwun@gmail.com>
         <20220407075123.420696-3-honyuenkwun@gmail.com>
In-Reply-To: <20220407075123.420696-3-honyuenkwun@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.82.63]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyDkuIrljYggMDY6NTE6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <19BD01618298E2408A66C30F65B51BF6@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDAyOjUxIC0wNTAwLCBKaW1teSBIb24gd3JvdGU6DQo+IE1h
a2Ugd29ya2Fyb3VuZCB3b3JrIGZvciBvdGhlciA4ODIxQ0UgZGV2aWNlcyB3aXRoIGRpZmZlcmVu
dCBQQ0kgSUQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbW15IEhvbiA8aG9ueXVlbmt3dW5AZ21h
aWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wY2ku
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNpLmMNCj4gaW5kZXggYTA5
OTFkM2YxNWMwLi4wZWRiNTcxMWI1NDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODgvcGNpLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9wY2kuYw0KPiBAQCAtMTc3MCw3ICsxNzcwLDcgQEAgaW50IHJ0d19wY2lfcHJv
YmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+ICAJfQ0KPiAgDQo+ICAJLyogRGlzYWJsZSBQQ0ll
IEFTUE0gTDEgd2hpbGUgZG9pbmcgTkFQSSBwb2xsIGZvciA4ODIxQ0UgKi8NCj4gLQlpZiAocGRl
di0+ZGV2aWNlID09IDB4YzgyMSAmJiBicmlkZ2UtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0lO
VEVMKQ0KPiArCWlmIChydHdkZXYtPmNoaXAtPmlkID09IFJUV19DSElQX1RZUEVfODgyMUMgJiYg
YnJpZGdlLT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9JTlRFTCkNCj4gIAkJcnR3cGNpLT5yeF9u
b19hc3BtID0gdHJ1ZTsNCj4gIA0KPiAgCXJ0d19wY2lfcGh5X2NmZyhydHdkZXYpOw0K
