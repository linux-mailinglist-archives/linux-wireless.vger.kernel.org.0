Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E57A1385
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 04:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjIOCDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjIOCDq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 22:03:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 485421AE
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 19:03:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38F22uE821916782, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38F22uE821916782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 10:02:56 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 15 Sep 2023 10:02:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 15 Sep 2023 10:02:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 15 Sep 2023 10:02:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "pagadala.yesu.anjaneyulu@intel.com" 
        <pagadala.yesu.anjaneyulu@intel.com>,
        =?utf-8?B?VGhvbWFzIEjDvGhu?= <thomas.huehn@hs-nordhausen.de>
Subject: RE: [PATCH wireless] wifi: mac80211: fix mesh id corruption on 32 bit systems
Thread-Topic: [PATCH wireless] wifi: mac80211: fix mesh id corruption on 32
 bit systems
Thread-Index: AQHZ5f9l3dLA861qLUuiEWPplpm2dbAbIkOg
Date:   Fri, 15 Sep 2023 02:02:55 +0000
Message-ID: <7e241b77171741a99dfb68ded905492e@realtek.com>
References: <20230913050134.53536-1-nbd@nbd.name>
In-Reply-To: <20230913050134.53536-1-nbd@nbd.name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXggRmlldGthdSA8
bmJkQG5iZC5uYW1lPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxMywgMjAyMyAxOjAy
IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGpvaGFubmVz
QHNpcHNvbHV0aW9ucy5uZXQ7IHBhZ2FkYWxhLnllc3UuYW5qYW5leXVsdUBpbnRlbC5jb207IFRo
b21hcyBIw7xobg0KPiA8dGhvbWFzLmh1ZWhuQGhzLW5vcmRoYXVzZW4uZGU+DQo+IFN1YmplY3Q6
IFtQQVRDSCB3aXJlbGVzc10gd2lmaTogbWFjODAyMTE6IGZpeCBtZXNoIGlkIGNvcnJ1cHRpb24g
b24gMzIgYml0IHN5c3RlbXMNCj4gDQo+IFNpbmNlIHRoZSBjaGFuZ2VkIGZpZWxkIHNpemUgd2Fz
IGluY3JlYXNlZCB0byB1NjQsIG1lc2hfYnNzX2luZm9fY2hhbmdlZA0KPiBwdWxscyBpbnZhbGlk
IGJpdHMgZnJvbSB0aGUgZmlyc3QgMyBieXRlcyBvZiB0aGUgbWVzaCBpZCwgY2xlYXJzIHRoZW0s
IGFuZA0KPiBwYXNzZXMgdGhlbSBvbiB0byBpZWVlODAyMTFfbGlua19pbmZvX2NoYW5nZV9ub3Rp
ZnksIGJlY2F1c2UNCj4gaWZtc2gtPm1ic3NfY2hhbmdlZCB3YXMgbm90IHVwZGF0ZWQgdG8gbWF0
Y2ggaXRzIHNpemUuDQo+IEZpeCB0aGlzIGJ5IHR1cm5pbmcgaW50byBpZm1zaC0+bWJzc19jaGFu
Z2VkIGludG8gYW4gdW5zaWduZWQgbG9uZyBhcnJheSB3aXRoDQo+IDY0IGJpdCBzaXplLg0KPiAN
Cj4gRml4ZXM6IDE1ZGRiYTVmNDMxMSAoIndpZmk6IG1hYzgwMjExOiBjb25zaXN0ZW50bHkgdXNl
IHU2NCBmb3IgQlNTIGNoYW5nZXMiKQ0KPiBSZXBvcnRlZC1ieTogVGhvbWFzIEjDvGhuIDx0aG9t
YXMuaHVlaG5AaHMtbm9yZGhhdXNlbi5kZT4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggRmlldGth
dSA8bmJkQG5iZC5uYW1lPg0KPiAtLS0NCj4gIG5ldC9tYWM4MDIxMS9pZWVlODAyMTFfaS5oIHwg
MiArLQ0KPiAgbmV0L21hYzgwMjExL21lc2guYyAgICAgICAgfCA4ICsrKystLS0tDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9uZXQvbWFjODAyMTEvaWVlZTgwMjExX2kuaCBiL25ldC9tYWM4MDIxMS9pZWVlODAy
MTFfaS5oDQo+IGluZGV4IGI4NDY1ZDIwNTA3Ni4uM2M1ZGJmOTU2ODVkIDEwMDY0NA0KPiAtLS0g
YS9uZXQvbWFjODAyMTEvaWVlZTgwMjExX2kuaA0KPiArKysgYi9uZXQvbWFjODAyMTEvaWVlZTgw
MjExX2kuaA0KPiBAQCAtNjgyLDcgKzY4Miw3IEBAIHN0cnVjdCBpZWVlODAyMTFfaWZfbWVzaCB7
DQo+ICAgICAgICAgc3RydWN0IHRpbWVyX2xpc3QgbWVzaF9wYXRoX3Jvb3RfdGltZXI7DQo+IA0K
PiAgICAgICAgIHVuc2lnbmVkIGxvbmcgd3JrcV9mbGFnczsNCj4gLSAgICAgICB1bnNpZ25lZCBs
b25nIG1ic3NfY2hhbmdlZDsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIG1ic3NfY2hhbmdlZFs2
NCAvIEJJVFNfUEVSX0xPTkddOw0KDQptYnNzX2NoYW5nZWQgaXMgYSBiaXRtYXAsIHNvDQoNCkRF
Q0xBUkVfQklUTUFQKG1ic3NfY2hhbmdlZCwgNjQpOw0KDQo+IA0KPiAgICAgICAgIGJvb2wgdXNl
cnNwYWNlX2hhbmRsZXNfZGZzOw0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9tZXNo
LmMgYi9uZXQvbWFjODAyMTEvbWVzaC5jDQo+IGluZGV4IDBkMGZiYWU1MWI2MS4uMDkyYTFkYzcz
MTRkIDEwMDY0NA0KPiAtLS0gYS9uZXQvbWFjODAyMTEvbWVzaC5jDQo+ICsrKyBiL25ldC9tYWM4
MDIxMS9tZXNoLmMNCj4gQEAgLTExNzUsNyArMTE3NSw3IEBAIHZvaWQgaWVlZTgwMjExX21ic3Nf
aW5mb19jaGFuZ2Vfbm90aWZ5KHN0cnVjdCBpZWVlODAyMTFfc3ViX2lmX2RhdGEgKnNkYXRhLA0K
PiANCj4gICAgICAgICAvKiBpZiB3ZSByYWNlIHdpdGggcnVubmluZyB3b3JrLCB3b3JzdCBjYXNl
IHRoaXMgd29yayBiZWNvbWVzIGEgbm9vcCAqLw0KPiAgICAgICAgIGZvcl9lYWNoX3NldF9iaXQo
Yml0LCAmYml0cywgc2l6ZW9mKGNoYW5nZWQpICogQklUU19QRVJfQllURSkNCj4gLSAgICAgICAg
ICAgICAgIHNldF9iaXQoYml0LCAmaWZtc2gtPm1ic3NfY2hhbmdlZCk7DQo+ICsgICAgICAgICAg
ICAgICBzZXRfYml0KGJpdCwgaWZtc2gtPm1ic3NfY2hhbmdlZCk7DQo+ICAgICAgICAgc2V0X2Jp
dChNRVNIX1dPUktfTUJTU19DSEFOR0VELCAmaWZtc2gtPndya3FfZmxhZ3MpOw0KPiAgICAgICAg
IHdpcGh5X3dvcmtfcXVldWUoc2RhdGEtPmxvY2FsLT5ody53aXBoeSwgJnNkYXRhLT53b3JrKTsN
Cj4gIH0NCj4gQEAgLTEyNTcsNyArMTI1Nyw3IEBAIHZvaWQgaWVlZTgwMjExX3N0b3BfbWVzaChz
dHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpzZGF0YSkNCj4gDQo+ICAgICAgICAgLyogY2xl
YXIgYW55IG1lc2ggd29yayAoZm9yIG5leHQgam9pbikgd2UgbWF5IGhhdmUgYWNjcnVlZCAqLw0K
PiAgICAgICAgIGlmbXNoLT53cmtxX2ZsYWdzID0gMDsNCj4gLSAgICAgICBpZm1zaC0+bWJzc19j
aGFuZ2VkID0gMDsNCj4gKyAgICAgICBtZW1zZXQoaWZtc2gtPm1ic3NfY2hhbmdlZCwgMCwgc2l6
ZW9mKGlmbXNoLT5tYnNzX2NoYW5nZWQpKTsNCg0KYml0bWFwX3plcm8oaWZtc2gtPm1ic3NfY2hh
bmdlZCwgNjQpOw0KDQpiaXRtYXBfemVybygpIGNhbiBjaG9vc2UganVzdCAnPTAnIG9yIG1lbXNl
dCgwKSBhY2NvcmRpbmcgdG8gQklUU19QRVJfTE9ORy4gDQoNCj4gDQo+ICAgICAgICAgbG9jYWwt
PmZpZl9vdGhlcl9ic3MtLTsNCj4gICAgICAgICBhdG9taWNfZGVjKCZsb2NhbC0+aWZmX2FsbG11
bHRpcyk7DQo+IEBAIC0xNzIyLDkgKzE3MjIsOSBAQCBzdGF0aWMgdm9pZCBtZXNoX2Jzc19pbmZv
X2NoYW5nZWQoc3RydWN0IGllZWU4MDIxMV9zdWJfaWZfZGF0YSAqc2RhdGEpDQo+ICAgICAgICAg
dTMyIGJpdDsNCj4gICAgICAgICB1NjQgY2hhbmdlZCA9IDA7DQo+IA0KPiAtICAgICAgIGZvcl9l
YWNoX3NldF9iaXQoYml0LCAmaWZtc2gtPm1ic3NfY2hhbmdlZCwNCj4gKyAgICAgICBmb3JfZWFj
aF9zZXRfYml0KGJpdCwgaWZtc2gtPm1ic3NfY2hhbmdlZCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihjaGFuZ2VkKSAqIEJJVFNfUEVSX0JZVEUpIHsNCj4gLSAgICAgICAgICAg
ICAgIGNsZWFyX2JpdChiaXQsICZpZm1zaC0+bWJzc19jaGFuZ2VkKTsNCj4gKyAgICAgICAgICAg
ICAgIGNsZWFyX2JpdChiaXQsIGlmbXNoLT5tYnNzX2NoYW5nZWQpOw0KPiAgICAgICAgICAgICAg
ICAgY2hhbmdlZCB8PSBCSVQoYml0KTsNCj4gICAgICAgICB9DQo+IA0KPiAtLQ0KPiAyLjQxLjAN
Cg0K
