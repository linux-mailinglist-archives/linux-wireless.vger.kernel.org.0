Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D36E563C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 03:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDRBNe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 21:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDRBNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 21:13:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6C3A8C
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 18:13:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I1DMiwC019065, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I1DMiwC019065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 09:13:22 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Apr 2023 09:13:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Apr 2023 09:13:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 18 Apr 2023 09:13:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 3/3] wifi: rtl8xxxu: Simplify setting the initial gain
Thread-Topic: [PATCH 3/3] wifi: rtl8xxxu: Simplify setting the initial gain
Thread-Index: AQHZcU861Y00xArNhUSvs+Hi7YjwYK8wQo/Q
Date:   Tue, 18 Apr 2023 01:13:22 +0000
Message-ID: <5d839cb6cea043de9f79f6490f9ccfb2@realtek.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
 <cf91ca69-70e3-4c20-c0b1-e59d452356a1@gmail.com>
In-Reply-To: <cf91ca69-70e3-4c20-c0b1-e59d452356a1@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
MDIzIDE6MDggQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzNdIHdpZmk6IHJ0bDh4eHh1OiBT
aW1wbGlmeSBzZXR0aW5nIHRoZSBpbml0aWFsIGdhaW4NCj4gDQo+IFRoZSBnb2FsIG9mIHdyaXRp
bmcgMHg2OTU0MzQxZSAvIDB4Njk1NTM0MWUgdG8gUkVHX09GRE0wX1hBX0FHQ19DT1JFMQ0KPiBh
cHBlYXJzIHRvIGJlIHNldHRpbmcgdGhlIGluaXRpYWwgZ2Fpbiwgd2hpY2ggaXMgc3RvcmVkIGlu
IGJpdHMgMC4uNi4NCj4gQml0cyA3Li4zMSBhcmUgdGhlIHNhbWUgYXMgd2hhdCB0aGUgcGh5IGlu
aXQgdGFibGVzIHdyaXRlLg0KPiANCj4gTW9kaWZ5IG9ubHkgYml0cyAwLi42IHNvIHRoYXQgd2Ug
ZG9uJ3QgaGF2ZSB0byBjYXJlIGFib3V0IHRoZSB2YWx1ZXMNCj4gb2YgdGhlIG90aGVycy4gVGhp
cyB3YXkgd2UgZG9uJ3QgaGF2ZSB0byBhZGQgYW5vdGhlciAiZWxzZSBpZiIgZm9yIHRoZQ0KPiBS
VEw4MTkyRlUuDQo+IA0KPiBXaHkgd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGluaXRpYWwgZ2FpbiBm
cm9tIHRoZSBkZWZhdWx0IDB4MjAgdG8gMHgxZT8NCj4gTm90IHN1cmUuIFNvbWUgb2YgdGhlIHZl
bmRvciBkcml2ZXJzIGNoYW5nZSBpdCB0byAweDFlIGJlZm9yZSBzY2FubmluZw0KPiBhbmQgdGhl
biByZXN0b3JlIGl0IHRvIHRoZSBvcmlnaW5hbCB2YWx1ZSBhZnRlci4NCg0KV2hlbiBXaUZpIGdl
dHMgY29ubmVjdGVkLCBpdCB3aWxsIHRyeSB0byBhZGp1c3QgaW5pdGlhbCBnYWluIGZvciB0YXJn
ZXQgQVAuDQpJZiB3ZSBzY2FuIGluIHRoaXMgc2l0dWF0aW9uLCBjaGFuZ2UgaXQgdG8gMHgxZSB0
byBoYXZlIGJldHRlciBjb3ZlcmFnZSB0bw0KZmluZCBBUHMuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDYgKyst
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggMDNjMGFhYTkxNDFjLi5mZDhjOGM2ZDUzZDYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4
eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQo+IEBAIC03MDM0LDEwICs3MDM0LDggQEAgc3RhdGljIGludCBydGw4
eHh4dV9zdGFydChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCj4gICAgICAgICBydGw4eHh4dV93
cml0ZTE2KHByaXYsIFJFR19SWEZMVE1BUDIsIDB4ZmZmZik7DQo+ICAgICAgICAgcnRsOHh4eHVf
d3JpdGUxNihwcml2LCBSRUdfUlhGTFRNQVAwLCAweGZmZmYpOw0KPiANCj4gLSAgICAgICBpZiAo
cHJpdi0+cnRsX2NoaXAgPT0gUlRMODE4OEUpDQo+IC0gICAgICAgICAgICAgICBydGw4eHh4dV93
cml0ZTMyKHByaXYsIFJFR19PRkRNMF9YQV9BR0NfQ09SRTEsIDB4Njk1NTM0MWUpOw0KPiAtICAg
ICAgIGVsc2UNCj4gLSAgICAgICAgICAgICAgIHJ0bDh4eHh1X3dyaXRlMzIocHJpdiwgUkVHX09G
RE0wX1hBX0FHQ19DT1JFMSwgMHg2OTU0MzQxZSk7DQo+ICsgICAgICAgcnRsOHh4eHVfd3JpdGUz
Ml9tYXNrKHByaXYsIFJFR19PRkRNMF9YQV9BR0NfQ09SRTEsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE9GRE0wX1hfQUdDX0NPUkUxX0lHSV9NQVNLLCAweDFlKTsNCj4gDQo+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC0tDQo+IDIuMzkuMg0KPiANCj4gLS0tLS0tUGxlYXNl
IGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
