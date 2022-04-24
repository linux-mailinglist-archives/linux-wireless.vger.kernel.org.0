Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8E50CEC7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 04:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiDXDCD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 23:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiDXDCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 23:02:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DAC13FB53
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 19:59:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23O2wncX7011520, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23O2wncX7011520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 Apr 2022 10:58:49 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 10:58:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 24 Apr 2022 10:58:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Sun, 24 Apr 2022 10:58:49 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low power mode
Thread-Topic: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low
 power mode
Thread-Index: AQHYVXjKft0nRNIh+Uy/BSkulDfRKqz862uAgACHaQeAAGqCAA==
Date:   Sun, 24 Apr 2022 02:58:48 +0000
Message-ID: <dcdf7eed815fb6e557a85910ad91d4a2f4614f5c.camel@realtek.com>
References: <20220421120903.73715-5-pkshih@realtek.com>
         <165071716438.1434.8811355640487410145.kvalo@kernel.org>
         <875yn0q8lf.fsf@tynnyri.adurom.net>
In-Reply-To: <875yn0q8lf.fsf@tynnyri.adurom.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.67.176]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjMg5LiL5Y2IIDEwOjMzOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <C666F3924C7FFA4985C0F6BE8836C199@realtek.com>
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

T24gU2F0LCAyMDIyLTA0LTIzIGF0IDE1OjM3ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBL
YWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPiB3cml0ZXM6DQo+IA0KPiA+IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IEluIGxvd2VyIHBvd2Vy
IG1vZGUsIHRoZXJlIGFyZSB2ZXJ5IGxvdyBhbW91bnQgb2YgUlgsIGFuZCBpdCBtdXN0IHByb2Nl
c3MNCj4gPiA+IGluIGEgc2VwYXJhdGVkIGZ1bmN0aW9uIGluc3RlYWQgb2Ygc2NoZWR1bGVfbmFw
aSgpLCBiZWNhdXNlIHRoZSBleGlzdGluZw0KPiA+ID4gbmFwaV9wb2xsIGRvZXMgbWFueSB0aGlu
Z3MgdG8gb3B0aW1pemUgcGVyZm9ybWFuY2UsIGJ1dCBub3QgYWxsIHJlZ2lzdGVycw0KPiA+ID4g
Y2FuIGFjY2VzcyBpbiBsb3cgcG93ZXIgbW9kZS4gVGhlIHNpbXBsZSB3YXkgaXMgdG8gdXNlIHRo
cmVhZGZuIHRvIHByb2Nlc3MNCj4gPiA+IHRoZSBzaW1wbGUgdGhpbmcuDQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+IA0K
PiA+IFRoZSB0aXRsZSBpcyBoYXJkIHRvIHVuZGVyc3RhbmQuDQo+IA0KPiBJZiB5b3UgY2FuIHBy
b3ZpZGUgYSBuZXcgdGl0bGUgSSBjYW4gZml4IGl0IGR1cmluZyBjb21taXQuDQo+IA0KDQpQbGVh
c2UgaGVscCByZS10aXRsZSB0byAicnR3ODk6IHBjaTogYWRkIGEgc2VwYXJhdGVkIGludGVycnVw
dCBoYW5kbGVyIGZvciBsb3cgcG93ZXIgbW9kZSIuDQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQoN
Cg==
