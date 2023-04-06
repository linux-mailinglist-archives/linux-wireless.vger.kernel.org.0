Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57336D8CAB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 03:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjDFBT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjDFBT4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 21:19:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB83C32
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 18:19:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3361JVH90002077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3361JVH90002077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 09:19:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Apr 2023 09:19:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Apr 2023 09:19:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 09:19:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: Support devices with 5-6 out endpoints
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: Support devices with 5-6 out
 endpoints
Thread-Index: AQHZZA3vh6cStW9V90Obrz8gkscgvK8dg5jw
Date:   Thu, 6 Apr 2023 01:19:50 +0000
Message-ID: <acf5580bb2a442bc96737426a7bec79b@realtek.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
 <41960362-55ec-226f-befa-c3c05c38c94c@gmail.com>
In-Reply-To: <41960362-55ec-226f-befa-c3c05c38c94c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxLCAy
MDIzIDQ6MTggQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzJdIHdpZmk6IHJ0bDh4eHh1OiBT
dXBwb3J0IGRldmljZXMgd2l0aCA1LTYgb3V0IGVuZHBvaW50cw0KPiANCj4gSGFuZGxlIHRoZW0g
dGhlIHNhbWUgd2F5IGFzIHRoZSBkZXZpY2VzIHdpdGggMy00IFVTQiBvdXQgZW5kcG9pbnRzLg0K
PiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlIFJUTDgxOTJGVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaCAgICAgIHwgMiArLQ0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMg
fCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHUuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHUuaA0KPiBpbmRleCAzOWZlZTA3OTE3ZTcuLjgyYTAyOTBjY2IyOSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0K
PiBAQCAtMjcsNyArMjcsNyBAQA0KPiAgI2RlZmluZSBSVEw4WFhYVV9NQVhfUkVHX1BPTEwgICAg
ICAgICAgNTAwDQo+ICAjZGVmaW5lICAgICAgICBVU0JfSU5UUl9DT05URU5UX0xFTkdUSCAgICAg
ICAgIDU2DQo+IA0KPiAtI2RlZmluZSBSVEw4WFhYVV9PVVRfRU5EUE9JTlRTICAgICAgICAgNA0K
PiArI2RlZmluZSBSVEw4WFhYVV9PVVRfRU5EUE9JTlRTICAgICAgICAgNg0KPiANCj4gICNkZWZp
bmUgUkVBTFRFS19VU0JfUkVBRCAgICAgICAgICAgICAgIDB4YzANCj4gICNkZWZpbmUgUkVBTFRF
S19VU0JfV1JJVEUgICAgICAgICAgICAgIDB4NDANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggNjJk
ZDUzYTU3NjU5Li42MTA2YjQ3ZDBjMzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC0xNjYzLDYg
KzE2NjMsOCBAQCBpbnQgcnRsOHh4eHVfY29uZmlnX2VuZHBvaW50c19ub19zaWUoc3RydWN0IHJ0
bDh4eHh1X3ByaXYgKnByaXYpDQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnByaXYt
PnVkZXYtPmRldjsNCj4gDQo+ICAgICAgICAgc3dpdGNoIChwcml2LT5ucl9vdXRfZXBzKSB7DQo+
ICsgICAgICAgY2FzZSA2Og0KPiArICAgICAgIGNhc2UgNToNCj4gICAgICAgICBjYXNlIDQ6DQo+
ICAgICAgICAgY2FzZSAzOg0KPiAgICAgICAgICAgICAgICAgcHJpdi0+ZXBfdHhfbG93X3F1ZXVl
ID0gMTsNCj4gLS0NCj4gMi4zOS4yDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVu
dmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
