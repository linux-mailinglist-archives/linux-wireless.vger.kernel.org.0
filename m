Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300D651A72
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 06:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLTF7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 00:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTF7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 00:59:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD49FCF1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 21:59:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BK5wI0h9007240, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BK5wI0h9007240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Dec 2022 13:58:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 20 Dec 2022 13:59:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Dec 2022 13:59:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 20 Dec 2022 13:59:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v3 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
Thread-Topic: [PATCH v3 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping
 code
Thread-Index: AQHZEiGZSuZlbFwk8UOXGjOjrZZWF652S/Pg
Date:   Tue, 20 Dec 2022 05:59:08 +0000
Message-ID: <5e6186b8158d4a22a5d838324eb63760@realtek.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
In-Reply-To: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIwIOS4iuWNiCAwMjoyNDowMA==?=
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAx
NywgMjAyMiAxMDoxMiBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MyAxLzVdIHdpZmk6IHJ0bDh4eHh1OiBEZWR1cGxpY2F0ZSB0aGUgZWZ1c2UgZHVtcGlu
ZyBjb2RlDQo+IA0KPiBFdmVyeSBjaGlwIGZhbWlseSBleGNlcHQgUlRMODcyM0FVIGhhcyBhIGNv
cHkgb2YgdGhlIGVmdXNlIGR1bXBpbmcNCj4gY29kZS4gUmVtb3ZlIHRoaXMgYW5kIGR1bXAgdGhl
IGVmdXNlIGZyb20gYSBzaW5nbGUgcGxhY2UgdXNpbmcgYSBuZXcNCj4gZnVuY3Rpb24gcnRsOHh4
eHVfZHVtcF9lZnVzZSgpLg0KPiANCj4gQWxzbywgdXNlIHByaW50X2hleF9kdW1wKCkgdG8gcHJp
bnQgdGhlIGVmdXNlIGluc3RlYWQgb2YgYSBsb29wIGFuZA0KPiBkZXZfaW5mbygpLiBJdCBzaG93
cyB0aGUgQVNDSUkgaW50ZXJwcmV0YXRpb24gb2YgdGhlIGJ5dGVzLCB3aGljaCBpcw0KPiBuaWNl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KPiAtLS0NCj4gdjM6DQo+ICAtIEltcGxlbWVudCBzdWdnZXN0aW9uIGZyb20gUGluZy1L
ZSBTaGloOg0KPiAgICAtIFVzZSBFRlVTRV9NQVBfTEVOIGluc3RlYWQgb2YgRUZVU0VfUkVBTF9D
T05URU5UX0xFTl84NzIzQS4NCj4gICAgICBUaGV5IGhhdmUgdGhlIHNhbWUgdmFsdWUuDQo+IA0K
PiB2MjoNCj4gIC0gUGF0Y2ggaXMgbmV3IGluIHYyLg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV84MTg4Zi5jICB8IDExIC0tLS0tLS0tLS0tDQo+
ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfODE5MmMuYyAgfCAx
MCAtLS0tLS0tLS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4
eHVfODE5MmUuYyAgfCAgOSAtLS0tLS0tLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV84NzIzYi5jICB8IDExIC0tLS0tLS0tLS0tDQo+ICAuLi4vbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jICAgfCAxMyArKysrKysrKysr
KysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygt
KQ0KPiANCg0KWy4uLl0NCg0K
