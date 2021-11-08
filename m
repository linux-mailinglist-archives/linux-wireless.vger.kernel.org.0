Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A34478E6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 04:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhKHDbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Nov 2021 22:31:11 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56240 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhKHDbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Nov 2021 22:31:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1A83S9SN0030715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1A83S9SN0030715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 8 Nov 2021 11:28:09 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 8 Nov 2021 11:28:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:28:07 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584]) by
 RTEXMBS04.realtek.com.tw ([fe80::dc53:1026:298b:c584%5]) with mapi id
 15.01.2308.015; Mon, 8 Nov 2021 11:28:07 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Bogdan Nicolae <bogdan.nicolae@acm.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: No support for Realtek 8821CE RFE Type 6
Thread-Topic: No support for Realtek 8821CE RFE Type 6
Thread-Index: AQHXy7lkSRIUIcq7CEaFpFpEp9A8RqvxU6VAgAAlr2CAABi2AIAA9urQgAEuBYCABUrmwA==
Date:   Mon, 8 Nov 2021 03:28:07 +0000
Message-ID: <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
 <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
 <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
 <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
 <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
In-Reply-To: <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzcg5LiL5Y2IIDExOjQ2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/08/2021 03:13:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167096 [Nov 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;fcc.report:7.1.1;realtek.com:7.1.1;www.amazon.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/08/2021 03:15:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQm9nZGFuLA0KDQpUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uIA0KU2luY2Ugd2UgZG9u
J3QgaGF2ZSB0aGlzIG1vZHVsZSwgSSdsbCBoYXZlIGludGVybmFsIGRpc2N1c3Npb24gZnVydGhl
ci4NCg0KSSBoYXZlIGEgcXVpY2sgbG9vayBvZiBSRkUgdHlwZSAwLCAyLCA0IGFuZCA2LiBJIHRo
aW5rIHR5cGUgMCBhbmQgNg0KYXJlIHNpbWlsYXIuIFNvLCBjb3VsZCB5b3UgdHJ5IGZvbGxvd2lu
ZyBwYXRjaCB0byBzZWUgaWYgaXQgd29ya3M/DQoNCmRpZmYgLS1naXQgYS9ydHc4ODIxYy5jIGIv
cnR3ODgyMWMuYw0KaW5kZXggODBhNmY0ZGEuLjFiODZhMjFiIDEwMDY0NA0KLS0tIGEvcnR3ODgy
MWMuYw0KKysrIGIvcnR3ODgyMWMuYw0KQEAgLTE1MTMsNiArMTUxMyw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcnR3X3JmZV9kZWYgcnR3ODgyMWNfcmZlX2RlZnNbXSA9IHsNCiAgICAgICAgWzBd
ID0gUlRXX0RFRl9SRkUoODgyMWMsIDAsIDApLA0KICAgICAgICBbMl0gPSBSVFdfREVGX1JGRV9F
WFQoODgyMWMsIDAsIDAsIDIpLA0KICAgICAgICBbNF0gPSBSVFdfREVGX1JGRV9FWFQoODgyMWMs
IDAsIDAsIDIpLA0KKyAgICAgICBbNl0gPSBSVFdfREVGX1JGRSg4ODIxYywgMCwgMCksDQogfTsN
Cg0KLS0NClBpbmctS2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBC
b2dkYW4gTmljb2xhZSA8Ym9nZGFuLm5pY29sYWVAYWNtLm9yZz4NCj4gU2VudDogRnJpZGF5LCBO
b3ZlbWJlciA1LCAyMDIxIDEwOjEwIEFNDQo+IFRvOiBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
Tm8gc3VwcG9ydCBmb3IgUmVhbHRlayA4ODIxQ0UgUkZFIFR5cGUgNg0KPiANCj4gUGluZy1LZSwN
Cj4gDQo+IEhhcHB5IHRvIGhlbHAsIGFuc3dlcnMgYmVsb3c6DQo+IA0KPiAxLiBZZXMsIHRoZSBr
ZXJuZWwgc2hvd3MgdGhlIGZvbGxvd2luZyAodGhhdCdzIHdoeSBJIHN0YXJ0ZWQgdGhpcyBlbWFp
bCB0aHJlYWQpOg0KPiANCj4gWyAgICAzLjU0MTQ5NF0gcnR3Xzg4MjFjZSAwMDAwOjAzOjAwLjA6
IEZpcm13YXJlIHZlcnNpb24gMjQuOC4wLCBIMkMgdmVyc2lvbiAxMg0KPiBbICAgIDMuNTU4NzYw
XSBydHdfODgyMWNlIDAwMDA6MDM6MDAuMDogcmZlIDYgaXNuJ3Qgc3VwcG9ydGVkDQo+IFsgICAg
My41NTg4OTBdIHJ0d184ODIxY2UgMDAwMDowMzowMC4wOiBmYWlsZWQgdG8gc2V0dXAgY2hpcCBl
ZnVzZSBpbmZvDQo+IFsgICAgMy41NTg4OTNdIHJ0d184ODIxY2UgMDAwMDowMzowMC4wOiBmYWls
ZWQgdG8gc2V0dXAgY2hpcCBpbmZvcm1hdGlvbg0KPiANCj4gMi4gVW5mb3J0dW5hdGVseSwgSSBk
b24ndCBoYXZlIGEgV2luZG93cyAxMCBzZXR1cCByZWFkaWx5IGF2YWlsYWJsZQ0KPiANCj4gMy4g
VGhlIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBtb3RoZXJib2FyZCwgc28gSSBjYW4gb25s
eSBzaG93IHlvdQ0KPiBvbmUgc2lkZS4gUGljdHVyZSBpcyBhdHRhY2hlZC4NCj4gSXQgbG9va3Mg
bGlrZSBpdCdzIHByb2R1Y2VkIGJ5IENEVGVjaCAoQ2hpbmEgRHJhZ29uPyk6DQo+IGh0dHBzOi8v
ZmNjLnJlcG9ydC9GQ0MtSUQvUk9XLTYxODIxQ0UvNTE4OTcyMC5wZGYNCj4gVGhlcmUgYXJlIHR3
byBhbnRlbm5hcywgb25lIGZvciAyRywgYW5vdGhlciBmb3IgNUcgc2hhcmVkIHdpdGgNCj4gQmx1
ZXRvb3RoLiBNYXliZSB0aGUgdHlwZSA0IGRyaXZlciB3aWxsIHdvcmsgZm9yIGl0IG91dCBvZiB0
aGUgYm94Pw0KPiANCj4gQmVzdCwNCj4gQm9nZGFuDQo+IA0KPiBPbiBXZWQsIE5vdiAzLCAyMDIx
IGF0IDc6MTcgUE0gUGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCb2dkYW4gTmlj
b2xhZSA8Ym9nZGFuLm5pY29sYWVAYWNtLm9yZz4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciA0LCAyMDIxIDE6MjYgQU0NCj4gPiA+IFRvOiBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCj4gPiA+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBObyBzdXBwb3J0IGZvciBSZWFsdGVrIDg4MjFDRSBSRkUgVHlwZSA2DQo+ID4gPg0K
PiA+ID4gVGhhbmtzIFBpbmctS2UsDQo+ID4gPg0KPiA+ID4gVGhlIFJlYWx0ZWsgV2lmaSA4ODIx
Q0UgUkZFIFR5cGUgNiBpcyB1c2VkIGluIGEgYnJvYWQgcmFuZ2Ugb2YNCj4gPiA+IGVtYmVkZGVk
IHN5c3RlbXMgYmFzZWQgb24gSW50ZWwgQ2VsZXJvbiBKNDEyNSBTb0NzLiBBIHBvcHVsYXIgZXhh
bXBsZQ0KPiA+ID4gaXMgR0szIE1pbmkgUEMsIHNvbGQgdW5kZXIgYSBsYXJnZSBudW1iZXIgb2Yg
YnJhbmRzLCBmb3IgZXhhbXBsZToNCj4gPiA+IGh0dHBzOi8vd3d3LmFtYXpvbi5jb20vZ3AvcHJv
ZHVjdC9CMDlGVENQQkhLLw0KPiA+ID4gVGhlc2Ugc3lzdGVtcyBhcmUgcmlzaW5nIGluIHBvcHVs
YXJpdHkgaW4gZmF2b3Igb2YgbGFwdG9wcywgYXMgcGVvcGxlDQo+ID4gPiB0ZW5kIHRvIHN0YXkg
YXQgaG9tZSBhbmQgYXJlIGxvb2tpbmcgZm9yIGFmZm9yZGFibGUgdXBncmFkZXMuDQo+ID4gPiBV
bmZvcnR1bmF0ZWx5LCBsYWNrIG9mIFdpZmkgTGludXggc3VwcG9ydCBpcyBhIG1ham9yIGRyYXdi
YWNrLg0KPiA+ID4NCj4gPg0KPiA+IENvdWxkIHlvdSBoZWxwIHRvIGNvbmZpcm0gZm9sbG93aW5n
IHRoaW5nczoNCj4gPg0KPiA+IDEuIERvIHlvdSBzZWUgInJmZSA2IGlzbid0IHN1cHBvcnRlZCIg
aW4ga2VybmVsIGxvZz8NCj4gPiAgICBJIHdhbnQgdG8gY29uZmlybSB0aGUgdHlwZSBhZ2Fpbi4N
Cj4gPiAyLiBJZiB5b3UgYm9vdCB0aGlzIHN5c3RlbSBpbnRvIFdpbmRvd3MgMTAsIGRvZXMgdGhl
IDg4MjFDRSB3b3JrIHByb3Blcmx5Pw0KPiA+ICAgIElmIHNvLCBwbGVhc2UgZ2l2ZSBtZSBpdHMg
VklEL1BJRCBvZiBQQ0kuDQo+ID4gMy4gQ291bGQgSSBoYXZlIHRoZSBwaWN0dXJlcyBvZiB0aGUg
bW9kdWxlIG9mIGJvdGggc2lkZXM/DQo+ID4gICAgSSB3b3VsZCBsaWtlIHRvIGtub3cgdGhlIG1v
ZHVsZSBtYXJrZXI7IGFzIHdlbGwgYXMgYW50ZW5uYSBsb2NhdGlvbi4NCj4gPg0KPiA+IC0tDQo+
ID4gUGluZy1LZQ0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9y
ZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
