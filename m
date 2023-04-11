Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798CD6DCFC6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 04:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDKCiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 22:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKCiC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 22:38:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45246FA
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 19:38:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33B2baaxF000804, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33B2baaxF000804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 10:37:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 11 Apr 2023 10:37:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 11 Apr 2023 10:37:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 11 Apr 2023 10:37:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 2/2] wifi: rtl8xxxu: Support devices with 5-6 out endpoints
Thread-Topic: [PATCH v2 2/2] wifi: rtl8xxxu: Support devices with 5-6 out
 endpoints
Thread-Index: AQHZa8JHfxSxGe1E8UKqBumMbAn9/68lZW9Q
Date:   Tue, 11 Apr 2023 02:37:04 +0000
Message-ID: <3cfc735017b146fcb968df3984fe39f1@realtek.com>
References: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
 <ef4bc66d-84f5-4021-efd7-1787d097519c@gmail.com>
In-Reply-To: <ef4bc66d-84f5-4021-efd7-1787d097519c@gmail.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTAsIDIw
MjMgMTE6MzcgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzJdIHdpZmk6IHJ0bDh4eHh1
OiBTdXBwb3J0IGRldmljZXMgd2l0aCA1LTYgb3V0IGVuZHBvaW50cw0KPiANCj4gSGFuZGxlIHRo
ZW0gdGhlIHNhbWUgd2F5IGFzIHRoZSBkZXZpY2VzIHdpdGggMy00IFVTQiBvdXQgZW5kcG9pbnRz
Lg0KPiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlIFJUTDgxOTJGVS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYyOg0K
PiAgLSBObyBjaGFuZ2UuDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dS5oICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+IGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+IGluZGV4IDM5ZmVl
MDc5MTdlNy4uODJhMDI5MGNjYjI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+IEBAIC0yNyw3ICsyNyw3IEBADQo+ICAj
ZGVmaW5lIFJUTDhYWFhVX01BWF9SRUdfUE9MTCAgICAgICAgICA1MDANCj4gICNkZWZpbmUgICAg
ICAgIFVTQl9JTlRSX0NPTlRFTlRfTEVOR1RIICAgICAgICAgNTYNCj4gDQo+IC0jZGVmaW5lIFJU
TDhYWFhVX09VVF9FTkRQT0lOVFMgICAgICAgICA0DQo+ICsjZGVmaW5lIFJUTDhYWFhVX09VVF9F
TkRQT0lOVFMgICAgICAgICA2DQo+IA0KPiAgI2RlZmluZSBSRUFMVEVLX1VTQl9SRUFEICAgICAg
ICAgICAgICAgMHhjMA0KPiAgI2RlZmluZSBSRUFMVEVLX1VTQl9XUklURSAgICAgICAgICAgICAg
MHg0MA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCA2MmRkNTNhNTc2NTkuLjYxMDZiNDdkMGMzNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTE2NjMsNiArMTY2Myw4IEBAIGludCBydGw4eHh4dV9j
b25maWdfZW5kcG9pbnRzX25vX3NpZShzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gICAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcHJpdi0+dWRldi0+ZGV2Ow0KPiANCj4gICAgICAg
ICBzd2l0Y2ggKHByaXYtPm5yX291dF9lcHMpIHsNCj4gKyAgICAgICBjYXNlIDY6DQo+ICsgICAg
ICAgY2FzZSA1Og0KPiAgICAgICAgIGNhc2UgNDoNCj4gICAgICAgICBjYXNlIDM6DQo+ICAgICAg
ICAgICAgICAgICBwcml2LT5lcF90eF9sb3dfcXVldWUgPSAxOw0KPiAtLQ0KPiAyLjM5LjINCj4g
DQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZS1tYWlsLg0K
