Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25963FD19
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLBAcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 19:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiLBAbp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 19:31:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D31493A5A
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 16:28:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B20RNc74011007, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B20RNc74011007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 08:27:23 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Dec 2022 08:28:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Dec 2022 08:28:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 2 Dec 2022 08:28:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v4 1/3] wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h
Thread-Topic: [PATCH v4 1/3] wifi: rtl8xxxu: Add __packed to struct
 rtl8723bu_c2h
Thread-Index: AQHZBY8qD/kmmxy1Pk6uOftd/g6rAq5ZvqZw
Date:   Fri, 2 Dec 2022 00:28:08 +0000
Message-ID: <66b8f61cd52147efa2bd58daee9e340d@realtek.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
In-Reply-To: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
LCAyMDIyIDEwOjE0IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMS8zXSB3aWZpOiBydGw4
eHh4dTogQWRkIF9fcGFja2VkIHRvIHN0cnVjdCBydGw4NzIzYnVfYzJoDQo+IA0KPiBUaGlzIHN0
cnVjdCBpcyB1c2VkIHRvIGFjY2VzcyBhIHNlcXVlbmNlIG9mIGJ5dGVzIHJlY2VpdmVkIGZyb20g
dGhlDQo+IHdpZmkgY2hpcC4gSXQgbXVzdCBub3QgaGF2ZSBhbnkgcGFkZGluZyBieXRlcyBiZXR3
ZWVuIHRoZSBtZW1iZXJzLg0KPiANCj4gVGhpcyBkb2Vzbid0IGNoYW5nZSBhbnl0aGluZyBvbiBt
eSBzeXN0ZW0sIHBvc3NpYmx5IGJlY2F1c2UgY3VycmVudGx5DQo+IG5vbmUgb2YgdGhlIG1lbWJl
cnMgbmVlZCBtb3JlIHRoYW4gYnl0ZSBhbGlnbm1lbnQuDQo+IA0KPiBGaXhlczogYjJiNDNiNzgz
N2JhICgicnRsOHh4eHU6IEluaXRpYWwgZnVuY3Rpb25hbGl0eSB0byBoYW5kbGUgQzJIIGV2ZW50
cyBmb3IgODcyM2J1IikNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gdjQ6DQo+ICAtIE5vIGNoYW5nZS4NCj4gDQo+IHYzOg0K
PiAgLSBObyBjaGFuZ2UuDQo+IA0KPiB2MjoNCj4gIC0gUGF0Y2ggaXMgbmV3IGluIHYyLg0KPiAt
LS0NCg0KWy4uLl0NCg0K
