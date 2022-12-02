Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE163FD1F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 01:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBAdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 19:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiLBAcm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 19:32:42 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1812EB0B72
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 16:30:40 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B20TpBD2020281, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B20TpBD2020281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 08:29:51 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Dec 2022 08:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 08:30:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 2 Dec 2022 08:30:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v4 3/3] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Thread-Topic: [PATCH v4 3/3] wifi: rtl8xxxu: Introduce
 rtl8xxxu_update_ra_report
Thread-Index: AQHZBY+Pi57fm9jOfEyA0cD/cP92k65Zvzyg
Date:   Fri, 2 Dec 2022 00:30:36 +0000
Message-ID: <c148ade99b6b46ac80678e67a86fe70d@realtek.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
 <0777ad35-fe03-473c-2e02-e3390bef5dd0@gmail.com>
In-Reply-To: <0777ad35-fe03-473c-2e02-e3390bef5dd0@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzEg5LiL5Y2IIDEwOjA4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAx
LCAyMDIyIDEwOjE3IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMy8zXSB3aWZpOiBydGw4
eHh4dTogSW50cm9kdWNlIHJ0bDh4eHh1X3VwZGF0ZV9yYV9yZXBvcnQNCj4gDQo+IFRoZSByYV9y
ZXBvcnQgc3RydWN0IGlzIHVzZWQgZm9yIHJlcG9ydGluZyB0aGUgVFggcmF0ZSB2aWENCj4gc3Rh
X3N0YXRpc3RpY3MuIFRoZSBjb2RlIHdoaWNoIGZpbGxzIGl0IG91dCBpcyBkdXBsaWNhdGVkIGlu
IHR3bw0KPiBwbGFjZXMsIGFuZCB0aGUgUlRMODE4OEVVIHdpbGwgbmVlZCBpdCBpbiBhIHRoaXJk
IHBsYWNlLiBNb3ZlIHRoaXMNCj4gY29kZSBpbnRvIGEgbmV3IGZ1bmN0aW9uIHJ0bDh4eHh1X3Vw
ZGF0ZV9yYV9yZXBvcnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2NDoNCj4gIC0gTm8gY2hhbmdlLg0KPiANCj4g
djM6DQo+ICAtIE5vIGNoYW5nZS4NCj4gDQo+IHYyOg0KPiAgLSBDb21wYXJlIGFnYWluc3QgREVT
Q19SQVRFXzU0TSBpbnN0ZWFkIG9mIERFU0NfUkFURV9NQ1MwLg0KPiAtLS0NCg0KWy4uLl0NCg0K
