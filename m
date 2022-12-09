Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF96647F12
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 09:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLIIOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 03:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLIIOn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 03:14:43 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AC322B18C
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 00:14:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B98DoxwE027436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B98DoxwE027436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 16:13:51 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 9 Dec 2022 16:14:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Dec 2022 16:14:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 9 Dec 2022 16:14:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Fix assignment to bit field priv->pi_enabled
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Fix assignment to bit field
 priv->pi_enabled
Thread-Index: AQHZCzvSxcg32ezMr0Gw9U1TgWetvq5lNWHw
Date:   Fri, 9 Dec 2022 08:14:38 +0000
Message-ID: <714bac11191a4f048e0285f2e193a67a@realtek.com>
References: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
In-Reply-To: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzkg5LiK5Y2IIDA3OjIzOjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgOSwg
MjAyMiAzOjMyIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSB3aWZpOiBydGw4eHh4dTog
Rml4IGFzc2lnbm1lbnQgdG8gYml0IGZpZWxkIHByaXYtPnBpX2VuYWJsZWQNCj4gDQo+IEp1c3Qg
YmVjYXVzZSBwcml2LT5waV9lbmFibGVkIGlzIG9ubHkgb25lIGJpdCBkb2Vzbid0IG1lYW4gaXQg
d29ya3MNCj4gbGlrZSBhIGJvb2wuIFRoZSB2YWx1ZSBhc3NpZ25lZCB0byBpdCBsb3NlcyBhbGwg
Yml0cyBleGNlcHQgYml0IDAsDQo+IHNvIG9ubHkgYXNzaWduIDAgb3IgMSB0byBpdC4NCj4gDQo+
IFRoaXMgYWZmZWN0cyB0aGUgUlRMODE4OEZVLCBidXQgZml4aW5nIHRoZSBhc3NpZ25tZW50IGRp
ZG4ndCBtYWtlDQo+IGEgZGlmZmVyZW5jZSBmb3IgbXkgZGV2aWNlLg0KDQpUaGUgcmVhc29uIGlz
IHRoZSBiaXQgaXMgYWx3YXlzIDAsIEkgaGF2ZSBzaW1pbGFyIHJldmlldyBkYXlzIGFnbyBbMV0u
DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy9jZjNkMDdmZjU0
M2Q0YzAwOWRiZjUxYWQ3YTRkNGIyMUByZWFsdGVrLmNvbS8NCg0KPiANCj4gRml4ZXM6IGM4ODgx
ODNiMjFmMyAoIndpZmk6IHJ0bDh4eHh1OiBTdXBwb3J0IG5ldyBjaGlwIFJUTDgxODhGVSIpDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
ODhmLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMNCj4gaW5kZXggMmM0ZjQwM2JhNjhmLi45N2U3ZmY3
Mjg5ZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfODE4OGYuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMNCj4gQEAgLTExMjIsNyArMTEyMiw3IEBAIHN0YXRp
YyB2b2lkIHJ0bDgxODhmdV9waHlfaXFjYWxpYnJhdGUoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnBy
aXYsDQo+IA0KPiAgCWlmICh0ID09IDApIHsNCj4gIAkJdmFsMzIgPSBydGw4eHh4dV9yZWFkMzIo
cHJpdiwgUkVHX0ZQR0EwX1hBX0hTU0lfUEFSTTEpOw0KPiAtCQlwcml2LT5waV9lbmFibGVkID0g
dmFsMzIgJiBGUEdBMF9IU1NJX1BBUk0xX1BJOw0KPiArCQlwcml2LT5waV9lbmFibGVkID0gdTMy
X2dldF9iaXRzKHZhbDMyLCBGUEdBMF9IU1NJX1BBUk0xX1BJKTsNCj4gIAl9DQo+IA0KPiAgCS8q
IHNhdmUgUkYgcGF0aCAqLw0KPiAtLQ0KPiAyLjM4LjANCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25z
aWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
