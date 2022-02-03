Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424E4A819E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349761AbiBCJl4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 04:41:56 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45641 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbiBCJlz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 04:41:55 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2139fnWcB004783, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2139fnWcB004783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 3 Feb 2022 17:41:49 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 17:41:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 17:41:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Thu, 3 Feb 2022 17:41:49 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
Thread-Topic: [PATCH 13/19] rtw89: extend role_maintain to support AP mode
Thread-Index: AQHYA3i7Zng9D27u60C+yxZ+ujbTSKx4tvl4gAA+sgCACLeKrf//ijuA
Date:   Thu, 3 Feb 2022 09:41:48 +0000
Message-ID: <00ad55606d1886f494197f583af60e2d00407db8.camel@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
         <20220107034239.22002-14-pkshih@realtek.com> <874k5ng8oq.fsf@kernel.org>
         <97e80d86f5b925a0b2337d15c56e88d3808b6efe.camel@realtek.com>
         <877daccpd8.fsf@kernel.org>
In-Reply-To: <877daccpd8.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [101.137.137.211]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMyDkuIrljYggMDc6NTQ6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <3001E35F51B5B749B999918A33CEBD39@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTAzIGF0IDEwOjQyICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
a3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBPbiBGcmksIDIwMjIt
MDEtMjggYXQgMTc6NTEgKzAyMDAsIEthbGxlIFZhbG8gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE1h
eWJlIEkgYWxzbyBtb3ZlIGNoZWNrIGZvciBydHdzdGEgZmlyc3Q/DQo+ID4gPiANCj4gPiANCj4g
PiBUaGUgZnVsbCBsb2dpYyBpcyANCj4gPiANCj4gPiBpZiAocnR3dmlmLT5uZXRfdHlwZSA9PSBS
VFc4OV9ORVRfVFlQRV9BUF9NT0RFKSB7DQo+ID4gICAgIGlmIChydHdzdGEpDQo+ID4gICAgICAg
ICBzZWxmX3JvbGUgPSBSVFc4OV9TRUxGX1JPTEVfQVBfQ0xJRU5UDQo+ID4gICAgIGVsc2UNCj4g
PiAgICAgICAgIHNlbGZfcm9sZSA9IHJ0d3ZpZi0+c2VsZl9yb2xlOw0KPiA+IH0gZWxzZSB7DQo+
ID4gICAgIHNlbGZfcm9sZSA9IHJ0d3ZpZi0+c2VsZl9yb2xlOw0KPiA+IH0NCj4gPiANCj4gPiBB
bmQsIHRoZSBtZWFuaW5nIG9mICdydHdzdGEnIGhlcmUgaXMgdG8gaW5kaWNhdGUgd2UgYXJlIGdv
aW5nIHRvIHNldHVwIA0KPiA+IGEgY29ubmVjdGVkIHN0YXRpb24gdGhhdCBjb25uZWN0cyB0byB0
aGlzIEFQLCBidXQgbm90IGNoZWNrIGlmIHRoZQ0KPiA+IHBvaW50ZXIgaXMgTlVMTC4gVG8gZW1w
aGFzaXMgdGhlIGNhc2UgaXMgb25seSBleGlzdGluZyBpbiBBUF9NT0RFLA0KPiA+IEkgcHJlZmVy
IHRvIGNoZWNrIG5ldF90eXBlIGFoZWFkLiBPciwgdGhpcyBmdWxsIGxvZ2ljIGlzIHByZWZlcnJl
ZD8NCj4gDQo+IEkgZG9uJ3Qga25vdyB3aGF0IG90aGVycyB0aGluaywgYnV0IEkgZmluZCB0aGlz
IGZ1bGwgbG9naWMgc3R5bGUgbW9zdA0KPiByZWFkYWJsZS4NCj4gDQoNCk1heWJlLCBhIHN0YXRp
YyBhbmFseXNpcyB0b29sIHdhcm5zIHR3byBlbHNlIGJyYW5jaGVzIGFyZSB0aGUgc2FtZS4gDQpJ
ZiBzbywgd2UgY2FuIG1ha2UgYSBkZWNpc2lvbiBhdCB0aGF0IHRpbWUuDQogDQpJIHdpbGwgc2Vu
ZCB2MiBuZXh0IHdlZWssIGFuZCB3YWl0IGZvciBwZW9wbGUgd2hvIGhhdmUgb3RoZXIgaWRlYXMu
DQoNCkhhcHB5IE5ldyBZZWFyLg0KLS0NClBpbmctS2UNCg0KDQo=
