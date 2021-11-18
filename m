Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB85D4551E7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbhKRBDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 20:03:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44385 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbhKRBDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 20:03:21 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AI0xpMkB002749, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AI0xpMkB002749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 08:59:51 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 08:59:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 16:59:50 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Thu, 18 Nov 2021 08:59:50 +0800
From:   Pkshih <pkshih@realtek.com>
To:     rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Thread-Topic: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Thread-Index: AQHXRQqRhhXHdZWwI0aN+a9lRFPOsarbZCOAgAC1bwCAABzvgIAOnVIAgACUeICACCv9AIAT6HGAgAByOQCBAMgDgIAA7ccQ
Date:   Thu, 18 Nov 2021 00:59:50 +0000
Message-ID: <6908095907d442e08060a8488baf4860@realtek.com>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
 <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
 <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com>
 <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
 <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com>
 <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net>
 <hXlLGR-ccu9ozKXl1rsCyt7jWfmH0ufgepYDXU9dkZUYJWDmwjflabUNuxh-XWDeey4GQRjaSmtSIEqFsY5mieunEOMCTawMpyFzW9dbA0A=@protonmail.com>
 <37f988a9-8966-3482-f0ad-812a8cecce00@lwfinger.net>
 <Gm8GBswaSIZmUcurR4ygkbaFYfBiC8pIiBV5Ovz2GIorPykklbSraab7Z00LIX5pnfCJyWlI1-jUqnkl8NmxSuqfr-k_gYNhvWDg3kIkPkY=@protonmail.com>
 <9y_PDr3Fwwe-Tlg_OW2NgajfltnUS0Zflhoi19wd0p3OmpkAnqGqxuszx6ySZG9nBMg2JRGwnEgg59X1c0TFf6iqt951g3yqzSZ7CNDuXVQ=@protonmail.com>
In-Reply-To: <9y_PDr3Fwwe-Tlg_OW2NgajfltnUS0Zflhoi19wd0p3OmpkAnqGqxuszx6ySZG9nBMg2JRGwnEgg59X1c0TFf6iqt951g3yqzSZ7CNDuXVQ=@protonmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzE3IOS4i+WNiCAxMDoxNjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/18/2021 00:42:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167321 [Nov 17 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;bugs.launchpad.net:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/18/2021 00:45:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHJ0bDg4MjFjZXJmZTIgPHJ0
bDg4MjFjZXJmZTJAcHJvdG9ubWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAx
OCwgMjAyMSAyOjQ4IEFNDQo+IFRvOiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdl
ci5uZXQ+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IHJ0
dzg4OiBHdWFyYW50ZWVkIHN5c3RlbSBmcmVlemUgd2l0aCBSVEw4ODIxQ0Ugd2l0aCBSRkUgMiB0
eXBlDQo+IA0KPiDigJDigJDigJDigJDigJDigJDigJAgT3JpZ2luYWwgTWVzc2FnZSDigJDigJDi
gJDigJDigJDigJDigJANCj4gDQo+IE9uIE1vbmRheSwgSnVuZSA3dGgsIDIwMjEgYXQgMTI6Mjkg
UE0sIHJ0bDg4MjFjZXJmZTIgPHJ0bDg4MjFjZXJmZTJAcHJvdG9ubWFpbC5jb20+IHdyb3RlOg0K
PiANCj4gPiBPbiBNb25kYXksIEp1bmUgNywgMjAyMSA1OjQwIEFNLCBMYXJyeSBGaW5nZXIgTGFy
cnkuRmluZ2VyQGx3ZmluZ2VyLm5ldCB3cm90ZToNCj4gPg0KPiA+ID4gSSBqdXN0IHB1c2ggYSBw
YXRjaCBmcm9tIFJlYWx0ZWsgd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1pdCBtZXNzYWdlOg0KPiA+
ID4gODgyMUNFIHdpdGggQVNQTSBjYW5ub3Qgd29yayBwcm9wZXJseSBvbiBQcm90ZW1wbyBMdGQg
TDExNkhUTjZTUFcuIEFkZCBhDQo+ID4gPiBxdWlyayB0byBkaXNhYmxlIHRoZSBjYXAuDQo+ID4g
PiBUaGUgcmVwb3J0ZXIgZGVzY3JpYmVzIHRoZSBzeW1wdG9tIGlzIHRoYXQgdGhpcyBtb2R1bGUg
KGRyaXZlcikgY2F1c2VzDQo+ID4gPiBmcmVxdWVudCBmcmVlemVzLCByYW5kb21seSBidXQgdXN1
YWxseSB3aXRoaW4gYSBmZXcgbWludXRlcyBvZiBydW5uaW5nDQo+ID4gPiAodGh1cyB2ZXJ5IHNv
b24gYWZ0ZXIgYm9vdCk6IHNjcmVlbiBkaXNwbGF5IHJlbWFpbnMgZnJvemVuLCBubyByZXNwb25z
ZQ0KPiA+ID4gdG8gZWl0aGVyIGtleWJvYXJkIG9yIG1vdXNlIGlucHV0LiBBbGwgSSBjYW4gZG8g
aXMgdG8gaG9sZCB0aGUgcG93ZXINCj4gPiA+IGJ1dHRvbiB0byBwb3dlciBvZmYsIHRoZW4gcmVi
b290Lg0KPiA+ID4gUGxlYXNlIGRvIGEgJ2dpdCBwdWxsJyBhbmQgdHJ5IHRoZSBuZXcgY29kZS4g
SWYgeW91IHN0aWxsIGhhdmUgdGhlIHByb2JsZW0sIHRoZQ0KPiA+ID4gcXVpcmsgbWF5IG5lZWQg
dG8gYmUgZXh0ZW5kZWQgZm9yIHlvdXIgc3lzdGVtLiBQbGVhc2UgcnVuIHRoZSBjb21tYW5kOg0K
PiA+ID4gc3VkbyBkbWlkZWNvZGUgPiBkbWlkZWNvZGUudHh0DQo+ID4gPiBUaGVuIHBvc3QgdGhh
dCAudHh0IGZpbGUuDQo+ID4gPiBMYXJyeQ0KPiA+DQo+ID4gVGhhdCBwYXRjaCBzZWVtcyB0byBk
byB0aGUgc2FtZSB0aGluZyBhcyB0aGUgcnR3X3BjaSBvcHRpb24gZGlzYWJsZV9hc3BtPTEuIEkg
dHJpZWQgdGhhdCBvcHRpb24sIHdpdGgNCj4gYW5kIHdpdGhvdXQgZGlzYWJsZV9tc2k9MSwgYW5k
IGl0IGRpZG4ndCBoZWxwLg0KPiA+DQo+ID4gSSdtIGF0dGFjaGluZyBkbWlkZWNvZGUudHh0Lg0K
PiANCj4gDQo+IFJlY2VudGx5IEkgc2F3IHRoZSBpbnN0cnVjdGlvbnMgZnJvbSBQaW5nLUtlIFNo
aWggaW4gdGhpcyBVYnVudHUgYnVnIHJlcG9ydDoNCj4gaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5u
ZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8xOTI3ODA4DQo+IGFuZCByZWFsaXNlZCBJIG5l
dmVyIHBvd2VyZWQgb2ZmIHRoZSBsYXB0b3Agd2hlbiBJIHRlc3RlZCBkaXNhYmxlX2FzcG09MS4N
Cj4gSSBhbHdheXMgcmVib290ZWQuDQo+IA0KPiBTbyBJIGFkZGVkIGFnYWluICJvcHRpb25zIHJ0
dzg4X3BjaSBkaXNhYmxlX2FzcG09MSIgaW4gYSBmaWxlIGluIC9ldGMvbW9kcHJvYmUuZC8NCj4g
YW5kIHBvd2VyZWQgb2ZmIHRoZSBsYXB0b3AuIEl0IHNlZW1zIHRvIHdvcmsuIEl0J3MgYmVlbiAx
MSBkYXlzIHdpdGggbm8gZnJlZXplIG5vdy4NCj4gDQo+IEhlcmUgaXMgbXkgaW5mb3JtYXRpb24g
Zm9yIGRtaWRlY29kZSBhZ2FpbjoNCj4gU3lzdGVtIEluZm9ybWF0aW9uDQo+IAlNYW51ZmFjdHVy
ZXI6IEhQDQo+IAlQcm9kdWN0IE5hbWU6IEhQIDI1MCBHNyBOb3RlYm9vayBQQw0KDQpUaGFua3Mg
Zm9yIHRoZSByZXBvcnQgYW5kIHVwZGF0ZS4NCkkgd2lsbCBhZGQgYSBxdWlyayB0byB0aGlzIHBs
YXRmb3JtLg0KDQotLQ0KUGluZy1LZQ0KDQo=
