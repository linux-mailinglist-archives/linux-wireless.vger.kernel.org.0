Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10A0788318
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjHYJKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243552AbjHYJJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 05:09:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9F71FDF
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 02:09:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P99COc8005117, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P99COc8005117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 17:09:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Aug 2023 17:09:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Aug 2023 17:09:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 17:09:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "gregory.greenman@intel.com" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: limit reorder_buf_filtered <=64 to avoid shift-out-of-bounds UBSAN warning
Thread-Topic: [PATCH] wifi: mac80211: limit reorder_buf_filtered <=64 to avoid
 shift-out-of-bounds UBSAN warning
Thread-Index: AQHZ0XUpNy58XGDaGUO/LdMvK1mru6/6OP4AgACLHiA=
Date:   Fri, 25 Aug 2023 09:09:35 +0000
Message-ID: <8d203944e39340d6b6260948f44e24af@realtek.com>
References: <20230818014004.16177-1-pkshih@realtek.com>
 <CAOiHx=mo1WUYKKb5HtiPg0fiomem-QBqR2g9385tuEc-v_889A@mail.gmail.com>
In-Reply-To: <CAOiHx=mo1WUYKKb5HtiPg0fiomem-QBqR2g9385tuEc-v_889A@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXMgR29yc2tpIDxq
b25hcy5nb3Jza2lAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyNSwgMjAyMyA0
OjQ5IFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ7IGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tOyBsaW51
eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gd2lmaTog
bWFjODAyMTE6IGxpbWl0IHJlb3JkZXJfYnVmX2ZpbHRlcmVkIDw9NjQgdG8gYXZvaWQgc2hpZnQt
b3V0LW9mLWJvdW5kcyBVQlNBTg0KPiB3YXJuaW5nDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFN1biwg
MjAgQXVnIDIwMjMgYXQgMTM6MjAsIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFRoZSBjb21taXQgMDY0NzBmNzQ2OGM4ICgibWFjODAyMTE6IGFkZCBB
UEkgdG8gYWxsb3cgZmlsdGVyaW5nIGZyYW1lcyBpbiBCQSBzZXNzaW9ucyIpDQo+ID4gYWRkcyBy
ZW9yZGVyX2J1Zl9maWx0ZXJlZCB0byBtYXJrIGZyYW1lcyBmaWx0ZXJlZCBieSBmaXJtd2FyZSwg
YW5kIGl0IGNhbg0KPiA+IG9ubHkgd29yayBjb3JyZWN0bHkgaWYgaHcubWF4X3J4X2FnZ3JlZ2F0
aW9uX3N1YmZyYW1lcyA8PSA2NCBiZWNhdXNlDQo+ID4gbWF4aW11bSBCbG9ja0FjayBpcyA2NCBh
dCB0aGF0IG1vbWVudC4NCj4gPg0KPiA+IEhvd2V2ZXIsIG5ldyBIRSBvciBFSFQgZGV2aWNlcyBj
YW4gc3VwcG9ydCBCbG9ja0FjayBudW1iZXIgdXAgdG8gMjU2IG9yDQo+ID4gMTAyNCwgYW5kIGxl
YWRzIFVCU0FOIHdhcm5pbmc6DQo+ID4NCj4gPiAgVUJTQU46IHNoaWZ0LW91dC1vZi1ib3VuZHMg
aW4gbmV0L21hYzgwMjExL3J4LmM6MTEyOTozOQ0KPiA+ICBzaGlmdCBleHBvbmVudCAyMTUgaXMg
dG9vIGxhcmdlIGZvciA2NC1iaXQgdHlwZSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCcNCj4gPiAg
Q2FsbCBUcmFjZToNCj4gPiAgIDxJUlE+DQo+ID4gICBkdW1wX3N0YWNrX2x2bCsweDQ4LzB4NzAN
Cj4gPiAgIGR1bXBfc3RhY2srMHgxMC8weDIwDQo+ID4gICBfX3Vic2FuX2hhbmRsZV9zaGlmdF9v
dXRfb2ZfYm91bmRzKzB4MWFjLzB4MzYwDQo+ID4gICBpZWVlODAyMTFfcmVsZWFzZV9yZW9yZGVy
X2ZyYW1lLmNvbnN0cHJvcC4wLmNvbGQrMHg2NC8weDY5IFttYWM4MDIxMV0NCj4gPiAgIGllZWU4
MDIxMV9zdGFfcmVvcmRlcl9yZWxlYXNlKzB4OWMvMHg0MDAgW21hYzgwMjExXQ0KPiA+ICAgaWVl
ZTgwMjExX3ByZXBhcmVfYW5kX3J4X2hhbmRsZSsweDEyMzQvMHgxNDIwIFttYWM4MDIxMV0NCj4g
PiAgID8gX19wZnhfamhhc2grMHgxMC8weDEwDQo+ID4gICA/IHJodF9rZXlfZ2V0X2hhc2guaXNy
YS4wKzB4MTkvMHgzMCBbbWFjODAyMTFdDQo+ID4gICBpZWVlODAyMTFfcnhfbGlzdCsweGFlZi8w
eGY2MCBbbWFjODAyMTFdDQo+ID4gICA/IGtmcmVlX3NrYm1lbSsweDU4LzB4YjANCj4gPiAgID8g
cnR3ODlfdmlmX3J4X3N0YXRzX2l0ZXIrMHgyYmIvMHgyZTEgW3J0dzg5X2NvcmVdDQo+ID4gICBp
ZWVlODAyMTFfcnhfbmFwaSsweDUzLzB4ZDAgW21hYzgwMjExXQ0KPiA+DQo+ID4gU2luY2Ugb25s
eSBvbGQgaGFyZHdhcmUgdGhhdCBzdXBwb3J0cyA8PTY0IEJsb2NrQWNrIHVzZXMNCj4gPiBpZWVl
ODAyMTFfbWFya19yeF9iYV9maWx0ZXJlZF9mcmFtZXMoKSwgbGltaXQgdGhlIHVzZSBhcyBpdCBp
cywgc28gYWRkIGENCj4gPiBXQVJOX09OQ0UoKSBhbmQgY29tbWVudCB0byBub3RlIHRvIGF2b2lk
IHVzaW5nIHRoaXMgZnVuY3Rpb24gaWYgaGFyZHdhcmUNCj4gPiBjYXBhYmlsaXR5IGlzIG5vdCBz
dWl0YWJsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL25ldC9tYWM4MDIxMS5oIHwgIDEgKw0K
PiA+ICBuZXQvbWFjODAyMTEvcnguYyAgICAgIHwgMTIgKysrKysrKysrKy0tDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL25ldC9tYWM4MDIxMS5oIGIvaW5jbHVkZS9uZXQvbWFjODAyMTEu
aA0KPiA+IGluZGV4IDNhOGEyZDJjNThjMy4uMmE1NWFlOTMyYzU2IDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbmV0L21hYzgwMjExLmgNCj4gPiArKysgYi9pbmNsdWRlL25ldC9tYWM4MDIxMS5o
DQo+ID4gQEAgLTY2MTIsNiArNjYxMiw3IEBAIHZvaWQgaWVlZTgwMjExX3N0b3BfcnhfYmFfc2Vz
c2lvbihzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCB1MTYgYmFfcnhfYml0bWFwLA0KPiA+ICAg
KiBtYXJrcyBmcmFtZXMgbWFya2VkIGluIHRoZSBiaXRtYXAgYXMgaGF2aW5nIGJlZW4gZmlsdGVy
ZWQuIEFmdGVyd2FyZHMsIGl0DQo+ID4gICAqIGNoZWNrcyBpZiBhbnkgZnJhbWVzIGluIHRoZSB3
aW5kb3cgc3RhcnRpbmcgZnJvbSBAc3NuIGNhbiBub3cgYmUgcmVsZWFzZWQNCj4gPiAgICogKGlu
IGNhc2UgdGhleSB3ZXJlIG9ubHkgd2FpdGluZyBmb3IgZnJhbWVzIHRoYXQgd2VyZSBmaWx0ZXJl
ZC4pDQo+ID4gKyAqIChPbmx5IHdvcmsgY29ycmVjdGx5IGlmIEBtYXhfcnhfYWdncmVnYXRpb25f
c3ViZnJhbWVzIDw9IDY0IGZyYW1lcykNCj4gPiAgICovDQo+ID4gIHZvaWQgaWVlZTgwMjExX21h
cmtfcnhfYmFfZmlsdGVyZWRfZnJhbWVzKHN0cnVjdCBpZWVlODAyMTFfc3RhICpwdWJzdGEsIHU4
IHRpZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYg
c3NuLCB1NjQgZmlsdGVyZWQsDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9yeC5jIGIv
bmV0L21hYzgwMjExL3J4LmMNCj4gPiBpbmRleCA0ZjcwN2QyYTE2MGYuLjBhZjI1OTljMTdlOCAx
MDA2NDQNCj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvcnguYw0KPiA+ICsrKyBiL25ldC9tYWM4MDIx
MS9yeC5jDQo+ID4gQEAgLTEwODMsNyArMTA4Myw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpZWVl
ODAyMTFfcnhfcmVvcmRlcl9yZWFkeShzdHJ1Y3QgdGlkX2FtcGR1X3J4ICp0aWRfYWdnX3J4LA0K
PiA+ICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnRhaWwgPSBza2JfcGVla190YWlsKGZyYW1lcyk7
DQo+ID4gICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqc3RhdHVzOw0KPiA+DQo+
ID4gLSAgICAgICBpZiAodGlkX2FnZ19yeC0+cmVvcmRlcl9idWZfZmlsdGVyZWQgJiBCSVRfVUxM
KGluZGV4KSkNCj4gPiArICAgICAgIGlmICh0aWRfYWdnX3J4LT5yZW9yZGVyX2J1Zl9maWx0ZXJl
ZCAmJg0KPiA+ICsgICAgICAgICAgIHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkICYg
QklUX1VMTChpbmRleCkpDQo+IA0KPiBXaGlsZSBpdCB3aWxsIHNpbGVuY2UgdGhlIFVCU0FOIHdh
cm5pbmcsIHVubGVzcyB5b3Uga25vdyB3aHkgdGhlIGNvZGUNCj4gd2FzIHdyaXR0ZW4gdGhpcyB3
YXkgaXQgd2lsbCBsb29rIGxpa2UgYSBwb2ludGxlc3MgbWljcm8tb3B0aW1pemF0aW9uLg0KPiAN
Cj4gU28gSSBzdWdnZXN0IGNoYW5naW5nIHRoZSBjb25kaXRpb24gdG8NCj4gDQo+ICAgICAgICBp
ZiAoaW5kZXggPCBCSVRTX1BFUl9MT05HX0xPTkcgJiYNCj4gICAgICAgICAgICB0aWRfYWdnX3J4
LT5yZW9yZGVyX2J1Zl9maWx0ZXJlZCAmIEJJVF9VTEwoaW5kZXgpKQ0KPiANCj4gdG8gbWFrZSBp
dCBtb3JlIG9idmlvdXMgd2hhdCB0aGUgaW50ZW50aW9uIG9mIHRoZSBleHRyYSBjb25kaXRpb24g
aXMuDQo+IA0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPg0KPiA+ICAgICAg
ICAgaWYgKCF0YWlsKQ0KPiA+IEBAIC0xMTI0LDcgKzExMjUsOCBAQCBzdGF0aWMgdm9pZCBpZWVl
ODAyMTFfcmVsZWFzZV9yZW9yZGVyX2ZyYW1lKHN0cnVjdCBpZWVlODAyMTFfc3ViX2lmX2RhdGEg
KnNkYXRhLA0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gIG5vX2ZyYW1lOg0KPiA+IC0gICAgICAg
dGlkX2FnZ19yeC0+cmVvcmRlcl9idWZfZmlsdGVyZWQgJj0gfkJJVF9VTEwoaW5kZXgpOw0KPiA+
ICsgICAgICAgaWYgKHRpZF9hZ2dfcngtPnJlb3JkZXJfYnVmX2ZpbHRlcmVkKQ0KPiA+ICsgICAg
ICAgICAgICAgICB0aWRfYWdnX3J4LT5yZW9yZGVyX2J1Zl9maWx0ZXJlZCAmPSB+QklUX1VMTChp
bmRleCk7DQo+IA0KPiBsaWtld2lzZQ0KPiANCj4gPiAgICAgICAgIHRpZF9hZ2dfcngtPmhlYWRf
c2VxX251bSA9IGllZWU4MDIxMV9zbl9pbmModGlkX2FnZ19yeC0+aGVhZF9zZXFfbnVtKTsNCj4g
PiAgfQ0KPiA+DQo+ID4gQEAgLTQyNjQsNiArNDI2Niw3IEBAIHZvaWQgaWVlZTgwMjExX21hcmtf
cnhfYmFfZmlsdGVyZWRfZnJhbWVzKHN0cnVjdCBpZWVlODAyMTFfc3RhICpwdWJzdGEsIHU4IHRp
ZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MTYgc3Nu
LCB1NjQgZmlsdGVyZWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTE2IHJlY2VpdmVkX21wZHVzKQ0KPiA+ICB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaWVl
ZTgwMjExX2xvY2FsICpsb2NhbDsNCj4gPiAgICAgICAgIHN0cnVjdCBzdGFfaW5mbyAqc3RhOw0K
PiA+ICAgICAgICAgc3RydWN0IHRpZF9hbXBkdV9yeCAqdGlkX2FnZ19yeDsNCj4gPiAgICAgICAg
IHN0cnVjdCBza19idWZmX2hlYWQgZnJhbWVzOw0KPiA+IEBAIC00MjgxLDYgKzQyODQsMTEgQEAg
dm9pZCBpZWVlODAyMTFfbWFya19yeF9iYV9maWx0ZXJlZF9mcmFtZXMoc3RydWN0IGllZWU4MDIx
MV9zdGEgKnB1YnN0YSwgdTggdGlkLA0KPiA+DQo+ID4gICAgICAgICBzdGEgPSBjb250YWluZXJf
b2YocHVic3RhLCBzdHJ1Y3Qgc3RhX2luZm8sIHN0YSk7DQo+ID4NCj4gPiArICAgICAgIGxvY2Fs
ID0gc3RhLT5zZGF0YS0+bG9jYWw7DQo+ID4gKyAgICAgICBXQVJOX09OQ0UobG9jYWwtPmh3Lm1h
eF9yeF9hZ2dyZWdhdGlvbl9zdWJmcmFtZXMgPiA2NCwNCj4gPiArICAgICAgICAgICAgICAgICAi
UlggQkEgbWFya2VyIGNhbid0IHN1cHBvcnQgbWF4X3J4X2FnZ3JlZ2F0aW9uX3N1YmZyYW1lcyAl
dSA+IDY0XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgIGxvY2FsLT5ody5tYXhfcnhfYWdncmVn
YXRpb25fc3ViZnJhbWVzKTsNCj4gDQo+IEFuZCBtYXliZSB1c2UgQklUU19QRVJfTE9OR19MT05H
IGhlcmUgYXMgd2VsbC4NCj4gDQo+IE9yIGludHJvZHVjZSB5b3VyIG93biBtYWNyby4gTm90IHN1
cmUgd2hhdCdzIG5pY2VyLg0KPiANCj4gPiArDQo+ID4gICAgICAgICBpZiAoIWllZWU4MDIxMV9y
eF9kYXRhX3NldF9zdGEoJnJ4LCBzdGEsIC0xKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KDQpQbGVhc2UgcmVmZXJlbmNlIHRvIFJG
QyBkaXNjdXNzaW9uIFsxXSB0aGF0IG1lbnRpb25lZCB5b3VyIHF1ZXN0aW9ucy4NCg0KUGluZy1L
ZSANCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzNkYjA5MmVh
MGFhNmI3NThlMjNkZjU3N2Y0MTVmMTQyZTgyNzc2YTIuY2FtZWxAcmVhbHRlay5jb20vDQoNCg==
