Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEC6650E9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 02:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjAKBJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 20:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjAKBJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 20:09:49 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 506044883E
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 17:09:47 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30B18iYzA030849, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30B18iYzA030849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Jan 2023 09:08:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Jan 2023 09:09:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Jan 2023 09:09:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 11 Jan 2023 09:09:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Print the ROM version too
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Print the ROM version too
Thread-Index: AQHZJQoPKcIOFW3z/0CCk6jXfihow66YaKAg
Date:   Wed, 11 Jan 2023 01:09:42 +0000
Message-ID: <ef4c98a428c84b04b1e3973588855d71@realtek.com>
References: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
In-Reply-To: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTAg5LiL5Y2IIDExOjAwOjAw?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTAs
IDIwMjMgMTE6NDIgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIHdpZmk6IHJ0bDh4eHh1
OiBQcmludCB0aGUgUk9NIHZlcnNpb24gdG9vDQo+IA0KPiBNYWtlIHJ0bDh4eHh1X3ByaW50X2No
aXBpbmZvKCkgcHJpbnQgdGhlIFJPTSB2ZXJzaW9uLiBUaGlzIGlzIHJlbGV2YW50DQo+IGF0IGxl
YXN0IGZvciB0aGUgUlRMODcyM0FVIGFuZCBwb3NzaWJseSByZWxldmFudCBmb3IgdGhlIFJUTDg3
MTBCVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYyB8IDkgKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggZmQ5
N2MwNDA5NDhhLi5kNTIxNDM1ZTFjMDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC0xNTgyLDEw
ICsxNTgyLDExIEBAIHN0YXRpYyB2b2lkIHJ0bDh4eHh1X3ByaW50X2NoaXBpbmZvKHN0cnVjdCBy
dGw4eHh4dV9wcml2ICpwcml2KQ0KPiAgCQljdXQgPSAnQScgKyBwcml2LT5jaGlwX2N1dDsNCj4g
DQo+ICAJZGV2X2luZm8oZGV2LA0KPiAtCQkgIlJUTCVzIHJldiAlYyAoJXMpICVpVCVpUiwgVFgg
cXVldWVzICVpLCBXaUZpPSVpLCBCVD0laSwgR1BTPSVpLCBISSBQQT0laVxuIiwNCj4gLQkJIHBy
aXYtPmNoaXBfbmFtZSwgY3V0LCBwcml2LT5jaGlwX3ZlbmRvciwgcHJpdi0+dHhfcGF0aHMsDQo+
IC0JCSBwcml2LT5yeF9wYXRocywgcHJpdi0+ZXBfdHhfY291bnQsIHByaXYtPmhhc193aWZpLA0K
PiAtCQkgcHJpdi0+aGFzX2JsdWV0b290aCwgcHJpdi0+aGFzX2dwcywgcHJpdi0+aGlfcGEpOw0K
PiArCQkgIlJUTCVzIHJldiAlYyAoJXMpIHJvbXZlciAlZCwgJWlUJWlSLCBUWCBxdWV1ZXMgJWks
IFdpRmk9JWksIEJUPSVpLCBHUFM9JWksIEhJIFBBPSVpXG4iLA0KPiArCQkgcHJpdi0+Y2hpcF9u
YW1lLCBjdXQsIHByaXYtPmNoaXBfdmVuZG9yLCBwcml2LT5yb21fcmV2LA0KPiArCQkgcHJpdi0+
dHhfcGF0aHMsIHByaXYtPnJ4X3BhdGhzLCBwcml2LT5lcF90eF9jb3VudCwNCj4gKwkJIHByaXYt
Pmhhc193aWZpLCBwcml2LT5oYXNfYmx1ZXRvb3RoLCBwcml2LT5oYXNfZ3BzLA0KPiArCQkgcHJp
di0+aGlfcGEpOw0KPiANCj4gIAlkZXZfaW5mbyhkZXYsICJSVEwlcyBNQUM6ICVwTVxuIiwgcHJp
di0+Y2hpcF9uYW1lLCBwcml2LT5tYWNfYWRkcik7DQo+ICB9DQo+IC0tDQo+IDIuMzguMA0KPiAN
Cj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcg
dGhpcyBlLW1haWwuDQo=
