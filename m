Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F983713371
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjE0Iln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0Ill (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:41:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B6EA
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 01:41:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34R8fB3d9004985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34R8fB3d9004985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 27 May 2023 16:41:11 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 27 May 2023 16:41:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 27 May 2023 16:41:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Sat, 27 May 2023 16:41:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Question about power save
Thread-Topic: Question about power save
Thread-Index: AQHZjyJp/omCEnmceEyfVuCNSiYYRa9qwpaAgAAIjACAASJfgIABXByA
Date:   Sat, 27 May 2023 08:41:23 +0000
Message-ID: <00a86f46c8ebd1f95691c77de7f009bf19c6c6fa.camel@realtek.com>
References: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
         <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
         <6d635666-4973-b498-f67b-64762dbbd768@lwfinger.net>
         <731603cd61e49fece503780a74d0efdef8c7e380.camel@realtek.com>
In-Reply-To: <731603cd61e49fece503780a74d0efdef8c7e380.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.243]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54D6211BAF91E44822A91FF90400957@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDE5OjU1ICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIFRodSwgMjAyMy0wNS0yNSBhdCAxMzozNiAtMDUwMCwgTGFycnkgRmluZ2VyIHdyb3RlOg0K
PiA+IE9uIDUvMjUvMjMgMTM6MDUsIEpvaGFubmVzIEJlcmcgd3JvdGU6DQo+ID4gPiBZZWFoLCBJ
IHRoaW5rIEkgc2F3IHRoZSByZXBvcnQsIGJ1dCBJJ20gdHJhdmVsbGluZyBhbmQgZGlkbid0IGhh
dmUgdGhhdA0KPiA+ID4gbXVjaCB0aW1lIHRvIHJlcGx5Lg0KPiA+IA0KPiA+IEpvaGFubmVzLA0K
PiA+IA0KPiA+IFRoZSBydHc4OCBkcml2ZXJzIGFyZSBkZWZpbml0ZWx5IHNldHRpbmcgYm90aCBT
VVBQT1JUU19QUyBhbmQNCj4gPiBTVVBQT1JUU19EWU5BTUlDX1BTLiBJdCBzZWVtcyB0aGF0IHRo
ZXJlIGlzIGEgYnVnIHNvbWV3aGVyZSBpcyB0aG9zZSBkcml2ZXJzLg0KPiA+IA0KPiA+IEluIG15
IHJlcG8sIEkgd2lsbCByZW1vdmUgdGhlIFNVUFBPUlRTX0RZTkFNSUNfUFMsIHdoaWNoIHdpbGwg
c29sdmUgdGhlIHByb2JsZW0NCj4gPiByYWlzZWQgaW4gdGhlIEdpdEh1YiBpc3N1ZS4gVGhhdCB3
aWxsIGdpdmUgbWUgdGltZSB0byBmaW5kIHRoYXQgYnVnLg0KPiA+IA0KPiANCj4gV2UgYWxzbyBo
YXZlIGJlZW4gYXdhcmUgb2YgdGhpcyBhIGNvdXBsZSBkYXlzIGFnbywgc28gd2UgYXJlIHByZXBh
cmluZyBwYXRjaGVzDQo+IHRvIGNvcnJlY3QgdGhpcyBmb3IgYm90aCBydHc4OC84OS4gVGhlIG1l
dGhvZCBpcyB0aGF0IHJlLWNhbGN1bGF0ZSBpZiB3ZSBjYW4NCj4gZW50ZXIgUFMgYnkgY2hhbmdl
cyBvZiBCU1NfQ0hBTkdFRF9QUyBhbmQgdmlmLT5jZmcucHMuDQo+IEkgd2lsbCBzdWJtaXQgdGhl
IHBhdGNoIHNvb24uIA0KPiANCj4gDQoNCkhpIExhcnJ5LA0KDQpJIGhhdmUgc2VudCBmaXhlcyBb
MV0uIFBsZWFzZSBzZWUgdGhlIHBhdGNoc2V0IGFib3V0IHRoZSBkZXRhaWwuDQoNClsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIzMDUyNzA4MjkzOS4xMTIwNi0x
LXBrc2hpaEByZWFsdGVrLmNvbS9ULyN0DQoNClBpbmctS2UNCg0K
