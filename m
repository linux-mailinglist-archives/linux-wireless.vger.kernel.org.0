Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436A6E5641
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 03:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDRBQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 21:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDRBQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 21:16:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE13A8C
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 18:16:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I1GDnG4022309, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I1GDnG4022309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 09:16:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 18 Apr 2023 09:16:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Apr 2023 09:16:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 18 Apr 2023 09:16:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/3] wifi: rtl8xxxu: Don't print the vendor/product/serial
Thread-Topic: [PATCH 1/3] wifi: rtl8xxxu: Don't print the
 vendor/product/serial
Thread-Index: AQHZcU7dDSiPpZYChUq7s2ysEjm9sq8wQ/uA
Date:   Tue, 18 Apr 2023 01:16:13 +0000
Message-ID: <438efe7172584a77a0c6ec544481b11a@realtek.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
In-Reply-To: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE4LCAy
MDIzIDE6MDYgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIHdpZmk6IHJ0bDh4eHh1OiBE
b24ndCBwcmludCB0aGUgdmVuZG9yL3Byb2R1Y3Qvc2VyaWFsDQo+IA0KPiBNb3N0IGRldmljZXMg
aGF2ZSBhIHZlbmRvciBuYW1lLCBwcm9kdWN0IG5hbWUsIGFuZCBzZXJpYWwgbnVtYmVyIGluIHRo
ZQ0KPiBlZnVzZSwgYnV0IGl0J3MgcHJldHR5IHVzZWxlc3MuIEl0IGR1cGxpY2F0ZXMgdGhlIGlu
Zm9ybWF0aW9uIGFscmVhZHkNCj4gcHJpbnRlZCBieSB0aGUgVVNCIHN1YnN5c3RlbToNCj4gDQo+
ICAgIHVzYiAxLTQ6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wYmRhLCBpZFByb2R1
Y3Q9ODE3OCwgYmNkRGV2aWNlPSAyLjAwDQo+ICAgIHVzYiAxLTQ6IE5ldyBVU0IgZGV2aWNlIHN0
cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0zDQo+ICAgIHVzYiAxLTQ6IFBy
b2R1Y3Q6IDgwMi4xMW4gV0xBTiBBZGFwdGVyDQo+ICAgIHVzYiAxLTQ6IE1hbnVmYWN0dXJlcjog
UmVhbHRlaw0KPiAgICB1c2IgMS00OiBTZXJpYWxOdW1iZXI6IDAwZTA0YzAwMDAwMQ0KPiAtPiB1
c2IgMS00OiBWZW5kb3I6IFJlYWx0ZWsNCj4gLT4gdXNiIDEtNDogUHJvZHVjdDogODAyLjExbiBX
TEFOIEFkYXB0ZXINCj4gDQo+ICAgIHVzYiAxLTQ6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZl
bmRvcj0wYmRhLCBpZFByb2R1Y3Q9ODE4YiwgYmNkRGV2aWNlPSAyLjAwDQo+ICAgIHVzYiAxLTQ6
IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0z
DQo+ICAgIHVzYiAxLTQ6IFByb2R1Y3Q6IDgwMi4xMW4gTklDDQo+ICAgIHVzYiAxLTQ6IE1hbnVm
YWN0dXJlcjogUmVhbHRlaw0KPiAgICB1c2IgMS00OiBTZXJpYWxOdW1iZXI6IDAwZTA0YzAwMDAw
MQ0KPiAtPiB1c2IgMS00OiBWZW5kb3I6IFJlYWx0ZWsNCj4gLT4gdXNiIDEtNDogUHJvZHVjdDog
ODAyLjExbiBOSUMNCj4gLT4gdXNiIDEtNDogU2VyaWFsIG5vdCBhdmFpbGFibGUuDQo+IA0KPiAg
ICB1c2IgMS00OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MGJkYSwgaWRQcm9kdWN0
PWYxNzksIGJjZERldmljZT0gMC4wMA0KPiAgICB1c2IgMS00OiBOZXcgVVNCIGRldmljZSBzdHJp
bmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9Mw0KPiAgICB1c2IgMS00OiBQcm9k
dWN0OiA4MDIuMTFuDQo+ICAgIHVzYiAxLTQ6IE1hbnVmYWN0dXJlcjogUmVhbHRlaw0KPiAgICB1
c2IgMS00OiBTZXJpYWxOdW1iZXI6IDAwMkUyREMwMDQxRg0KPiAtPiB1c2IgMS00OiBWZW5kb3I6
IFJlYWx0ZWsNCj4gLT4gdXNiIDEtNDogUHJvZHVjdDogODAyLjExbg0KPiANCj4gICAgdXNiIDEt
NDogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD04MTc5LCBi
Y2REZXZpY2U9IDAuMDANCj4gICAgdXNiIDEtNDogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZy
PTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTMNCj4gICAgdXNiIDEtNDogUHJvZHVjdDogODAy
LjExbiBOSUMNCj4gICAgdXNiIDEtNDogTWFudWZhY3R1cmVyOiBSZWFsdGVrDQo+ICAgIHVzYiAx
LTQ6IFNlcmlhbE51bWJlcjogMDBFMDRDMDAwMQ0KPiAtPiB1c2IgMS00OiBWZW5kb3I6IFJlYWx0
ZWsNCj4gLT4gdXNiIDEtNDogUHJvZHVjdDogODAyLjExbiBOSUMNCj4gLT4gdXNiIDEtNDogU2Vy
aWFsOiAwMEUwNEMwMDAxDQo+IA0KPiBBbHNvLCB0aGF0IGRhdGEgaXMgbm90IGludGVycHJldGVk
IGNvcnJlY3RseSBpbiBhbGwgY2FzZXM6DQo+IA0KPiB1c2IgMy0xLjEuMjogTmV3IFVTQiBkZXZp
Y2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD04MTc5LCBiY2REZXZpY2U9IDAuMDAN
Cj4gdXNiIDMtMS4xLjI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIs
IFNlcmlhbE51bWJlcj0zDQo+IHVzYiAzLTEuMS4yOiBQcm9kdWN0OiA4MDIuMTFuIE5JQw0KPiB1
c2IgMy0xLjEuMjogTWFudWZhY3R1cmVyOiBSZWFsdGVrDQo+IHVzYiAzLTEuMS4yOiBWZW5kb3I6
IFJlYWx0ZWsNCj4gdXNiIDMtMS4xLjI6IFByb2R1Y3Q6IFx4MDM4MDIuMTFuIE5JDQo+IHVzYiAz
LTEuMS4yOiBTZXJpYWw6IFx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZc
eGZmDQo+IA0KPiBMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dp
P2lkPTIxNzIzMQ0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KDQpbLi4uXQ0KDQo=
