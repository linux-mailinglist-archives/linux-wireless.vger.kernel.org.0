Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844A76CCEA4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 02:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjC2ASg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2ASe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 20:18:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2141737
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 17:18:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32T0HqTrA014776, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32T0HqTrA014776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 29 Mar 2023 08:17:52 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 29 Mar 2023 08:18:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 29 Mar 2023 08:18:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 29 Mar 2023 08:18:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
Thread-Topic: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
Thread-Index: AQHZXOKRYT+MvfsxukK4ImPrnPVroK8OGxAAgAAx6ICAACcpgIACeVPA
Date:   Wed, 29 Mar 2023 00:18:09 +0000
Message-ID: <1551928be8fe4ed1b8891e60d017f6a7@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-2-martin.kaistra@linutronix.de>
 <62bf7fa9-e041-c8d8-c63e-42b3674fc9d8@gmail.com>
 <7efd83bd-f6f9-eb2c-3b6a-1795307d4e2f@linutronix.de>
 <c8d45f50-28b4-6f5c-9754-43d8eb0bb084@gmail.com>
In-Reply-To: <c8d45f50-28b4-6f5c-9754-43d8eb0bb084@gmail.com>
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI4LCAy
MDIzIDI6MjkgQU0NCj4gVG86IE1hcnRpbiBLYWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJv
bml4LmRlPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKZXMgU29yZW5z
ZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3Jn
PjsgUGluZy1LZSBTaGloDQo+IDxwa3NoaWhAcmVhbHRlay5jb20+OyBTZWJhc3RpYW4gQW5kcnpl
aiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIDAxLzE0XSB3aWZpOiBydGw4eHh4dTogQWRkIHN0YXJ0X2FwKCkgY2FsbGJhY2sNCj4gDQo+
IE9uIDI3LzAzLzIwMjMgMTk6MDgsIE1hcnRpbiBLYWlzdHJhIHdyb3RlOg0KPiA+IEFtIDI3LjAz
LjIzIHVtIDE1OjEwIHNjaHJpZWIgQml0dGVyYmx1ZSBTbWl0aDoNCj4gPj4gT24gMjIvMDMvMjAy
MyAxOToxOCwgTWFydGluIEthaXN0cmEgd3JvdGU6DQo+ID4+PiBUaGlzIGdldHMgY2FsbGVkIGF0
IHRoZSBzdGFydCBvZiBBUCBtb2RlIG9wZXJhdGlvbi4gU2V0IGJzc2lkLCBiZWFjb24NCj4gPj4+
IGludGVydmFsIGFuZCBzZW5kIGEgY29ubmVjdCByZXBvcnQgdG8gdGhlIEhXLg0KPiA+Pj4NCj4g
Pj4NCj4gPj4gSG1tLCBidXQgd2h5IHNlbmQgYSBjb25uZWN0IHJlcG9ydCB3aGVuIHlvdSBkb24n
dCBoYXZlIGFueXRoaW5nDQo+ID4+IGNvbm5lY3RlZCB5ZXQ/DQo+ID4NCj4gPiBJIHRyaWVkIGZv
bGxvd2luZyB0aGUgdmVuZG9yIGRyaXZlciBoZXJlLCBJIGRvbid0IGtub3cgd2hhdCBleGFjdGx5
IGhhcHBlbnMgaW4gdGhlIGZpcm13YXJlLg0KPiA+IEkgY2FuIHRlc3QsIHRob3VnaCwgaWYgdGhl
cmUgaXMgYW55IGRpZmZlcmVuY2UsIGlmIEkgcmVtb3ZlIGl0Lg0KPiA+DQo+IEFoLCBva2F5LiBJ
IHdhcyBqdXN0IHdvbmRlcmluZy4NCg0KVGhpcyBpcyB0byB0ZWxsIGZpcm13YXJlIHdlIGFyZSBn
b2luZyB0byB1c2UgdGhlIGVudHJ5IG9mIG1hY19pZCA9IDAsDQpwbGVhc2UgYWxsb2NhdGUgdGhp
cyBlbnRyeSBhbmQgc2V0IGl0IGFzIHZhbGlkLg0KDQo+IA0KPiA+Pg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+ID4+
PiAtLS0NCj4gPj4+ICAgLi4uL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1
X2NvcmUuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMTUg
aW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4+PiBpbmRleCBjMTUy
YjIyODYwNmYxLi45MGI5OGI5ZGNiZDlkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gPj4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4+
PiBAQCAtNDg5OSw2ICs0ODk5LDIwIEBAIHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQoc3RydWN0
IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQo+ID4+PiAgICAg
ICByZXR1cm47DQo+ID4+PiAgIH0NCj4gPj4+ICAgK3N0YXRpYyBpbnQgcnRsOHh4eHVfc3RhcnRf
YXAoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQo+
ID4+PiArICAgICAgICAgICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2Jzc19jb25mICpsaW5rX2Nv
bmYpDQo+ID4+PiArew0KPiA+Pj4gKyAgICBzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdiA9IGh3
LT5wcml2Ow0KPiA+Pj4gKyAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcHJpdi0+dWRldi0+ZGV2
Ow0KPiA+Pj4gKw0KPiA+Pj4gKyAgICBkZXZfZGJnKGRldiwgIlN0YXJ0IEFQIG1vZGVcbiIpOw0K
PiA+Pj4gKyAgICBydGw4eHh4dV9zZXRfYnNzaWQocHJpdiwgdmlmLT5ic3NfY29uZi5ic3NpZCk7
DQo+ID4+PiArICAgIHJ0bDh4eHh1X3dyaXRlMTYocHJpdiwgUkVHX0JDTl9JTlRFUlZBTCwgdmlm
LT5ic3NfY29uZi5iZWFjb25faW50KTsNCj4gPj4+ICsgICAgcHJpdi0+Zm9wcy0+cmVwb3J0X2Nv
bm5lY3QocHJpdiwgMCwgdHJ1ZSk7DQo+ID4+PiArDQo+ID4+PiArICAgIHJldHVybiAwOw0KPiA+
Pj4gK30NCj4gPj4+ICsNCj4gPj4+ICAgc3RhdGljIHUzMiBydGw4eHh4dV84MDIxMV90b19ydGxf
cXVldWUodTMyIHF1ZXVlKQ0KPiA+Pj4gICB7DQo+ID4+PiAgICAgICB1MzIgcnRscXVldWU7DQo+
ID4+PiBAQCAtNzAyNiw2ICs3MDQwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
b3BzIHJ0bDh4eHh1X29wcyA9IHsNCj4gPj4+ICAgICAgIC5jb25maWcgPSBydGw4eHh4dV9jb25m
aWcsDQo+ID4+PiAgICAgICAuY29uZl90eCA9IHJ0bDh4eHh1X2NvbmZfdHgsDQo+ID4+PiAgICAg
ICAuYnNzX2luZm9fY2hhbmdlZCA9IHJ0bDh4eHh1X2Jzc19pbmZvX2NoYW5nZWQsDQo+ID4+PiAr
ICAgIC5zdGFydF9hcCA9IHJ0bDh4eHh1X3N0YXJ0X2FwLA0KPiA+Pj4gICAgICAgLmNvbmZpZ3Vy
ZV9maWx0ZXIgPSBydGw4eHh4dV9jb25maWd1cmVfZmlsdGVyLA0KPiA+Pj4gICAgICAgLnNldF9y
dHNfdGhyZXNob2xkID0gcnRsOHh4eHVfc2V0X3J0c190aHJlc2hvbGQsDQo+ID4+PiAgICAgICAu
c3RhcnQgPSBydGw4eHh4dV9zdGFydCwNCj4gPj4NCj4gDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29u
c2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
