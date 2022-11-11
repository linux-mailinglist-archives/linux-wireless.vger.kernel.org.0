Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E399C62542E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 07:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiKKG6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 01:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiKKG6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 01:58:34 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ECD465840
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 22:58:32 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AB6vorsF014472, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AB6vorsF014472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 11 Nov 2022 14:57:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 11 Nov 2022 14:58:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 11 Nov 2022 14:58:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 11 Nov 2022 14:58:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 3/3] wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip
Thread-Topic: [PATCH v2 3/3] wifi: rtl8xxxu: Use u32_get_bits in
 *_identify_chip
Thread-Index: AQHY9Qztn9V8ncNpcUmx2zhqFCQAma45S8tg
Date:   Fri, 11 Nov 2022 06:58:29 +0000
Message-ID: <6a7a92dd39cd4206ab1911083517c3a1@realtek.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
 <68f94284-3728-7b75-2b7b-64fae8af6bc5@gmail.com>
In-Reply-To: <68f94284-3728-7b75-2b7b-64fae8af6bc5@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzExIOS4iuWNiCAwMjoxMDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAx
MCwgMjAyMiAxMDowMSBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDMvM10gd2lmaTogcnRs
OHh4eHU6IFVzZSB1MzJfZ2V0X2JpdHMgaW4gKl9pZGVudGlmeV9jaGlwDQo+IA0KPiBJdCBzaW1w
bGlmaWVzIHRoZSBjb2RlIGEgYml0Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gdjI6DQo+ICAtIE5vIGNoYW5nZS4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhm
LmMgfCAzICstLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV84MTkyYy5jIHwgNSArKy0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV84MTkyZS5jIHwgNSArKy0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYS5jIHwgNSArKy0tLQ0KPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jIHwgNSArKy0t
LQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdz
LmggIHwgMSAtDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+IA0KDQpbLi4uXQ0KDQo=
