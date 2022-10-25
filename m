Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C460C11B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJYBg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJYBgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:36:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C7DCBFC3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 18:13:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P1DB2X0031116, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P1DB2X0031116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 09:13:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 25 Oct 2022 09:13:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Oct 2022 09:13:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Tue, 25 Oct 2022 09:13:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
Thread-Topic: [PATCH v2 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
Thread-Index: AQHY5/iCk+G3R/zf0Ua0mglELx/Bi64eTeiw
Date:   Tue, 25 Oct 2022 01:13:44 +0000
Message-ID: <56aa801563af4861aad189857de15aa4@realtek.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
In-Reply-To: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI0IOS4i+WNiCAxMToyMzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI1LCAy
MDIyIDQ6NTMgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djIgMS81XSB3aWZpOiBydGw4eHh4dTogQWRkIGNlbnRyYWwgZnJlcXVlbmN5IG9mZnNldCB0cmFj
a2luZw0KPiANCj4gQWNjb3JkaW5nIHRvIFJlYWx0ZWsgcHJvZ3JhbW1lcnMsICJ0byBhZGp1c3Qg
b3NjaWxsYXRvciB0byBhbGlnbg0KPiBjZW50cmFsIGZyZXF1ZW5jeSBvZiBjb25uZWN0ZWQgQVAu
IFRoZW4sIGl0IGNhbiB5aWVsZCBiZXR0ZXINCj4gcGVyZm9ybWFuY2UuIiBGcm9tIGNvbW1pdCBm
Yjg1MTdmNGZhZGUgKCJydHc4ODogODgyMmM6IGFkZCBDRk8NCj4gdHJhY2tpbmciKS4NCj4gDQo+
IFRoZSBSVEw4MTkyQ1UgYW5kIGEgdmVyc2lvbiBvZiBSVEw4NzIzQVUgYXBwYXJlbnRseSBkb24n
dCBoYXZlIHRoZQ0KPiBhYmlsaXR5IHRvIGFkanVzdCB0aGUgb3NjaWxsYXRvciwgc28gdGhpcyBk
b2Vzbid0IGFwcGx5IHRvIHRoZW0uDQo+IA0KPiBUaGlzIGFsc28gZG9lc24ndCBhcHBseSB0byB0
aGUgd2lmaSArIGJsdWV0b290aCBjb21ibyBjaGlwcyAoUlRMODcyM0FVDQo+IGFuZCBSVEw4NzIz
QlUpIGJlY2F1c2UgdGhlIENGTyB0cmFja2luZyBzaG91bGQgb25seSBiZSBkb25lIHdoZW4NCj4g
Ymx1ZXRvb3RoIGlzIGRpc2FibGVkLCBhbmQgZGV0ZXJtaW5pbmcgdGhhdCBsb29rZWQgY29tcGxp
Y2F0ZWQuDQo+IA0KPiBUaGF0IGxlYXZlcyBvbmx5IHRoZSBSVEw4MTkyRVUgYW5kIFJUTDgxODhG
VSBjaGlwcy4gSSB0ZXN0ZWQgdGhpcyB3aXRoDQo+IHRoZSBsYXR0ZXIuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiB2
MjoNCj4gIC0gU3VnZ2VzdGlvbnMgZnJvbSBQaW5nLUtlIFNoaWg6DQo+ICAgIC0gVXNlIEZJRUxE
X1BSRVAoKS4NCj4gICAgLSBMZXQgcGFja2V0X2NvdW50IHdyYXAgYXJvdW5kLg0KPiAgICAtIFVz
ZSBjbGFtcCgpLg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dS5oICB8ICAyMSArKy0NCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1Xzgx
ODhmLmMgICAgICAgICB8ICAzOSArKysrLQ0KPiAgLi4uL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4
eHVfODE5MmUuYyAgICAgICAgIHwgICA0ICstDQo+ICAuLi4vcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dV84NzIzYS5jICAgICAgICAgfCAgMzggKysrKy0NCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1Xzg3MjNiLmMgICAgICAgICB8ICAgNCArLQ0KPiAgLi4uL3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jIHwgMTM3ICsrKysrKysrKysrKysrKystLQ0KPiAg
Li4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfcmVncy5oIHwgICAxICsNCj4g
IDcgZmlsZXMgY2hhbmdlZCwgMjEyIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPiAN
Cg0KWy4uLl0NCg0K
