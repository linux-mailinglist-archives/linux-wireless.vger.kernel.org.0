Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB53C411B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhGLByh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jul 2021 21:54:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55598 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhGLByh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jul 2021 21:54:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16C1pQ5t9028120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16C1pQ5t9028120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Jul 2021 09:51:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 09:51:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Jul 2021 09:51:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Mon, 12 Jul 2021 09:51:25 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 07/24] rtw89: add MAC files
Thread-Topic: [PATCH 07/24] rtw89: add MAC files
Thread-Index: AQHXZA3RWJVK/ScoVU6riR52Vdh9Zqs6hC6AgAAKxgCAALNWAIADdOWA
Date:   Mon, 12 Jul 2021 01:51:25 +0000
Message-ID: <49a23eabcdd348ea964198b40802a365@realtek.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-8-pkshih@realtek.com>
 <20210709173817.GB2099@pengutronix.de>
 <310161353e627903f2a828ac28c69ae49b81568b.camel@sipsolutions.net>
 <20210710045842.ykovwmod7hnsbvnj@pengutronix.de>
In-Reply-To: <20210710045842.ykovwmod7hnsbvnj@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTEg5LiL5Y2IIDAxOjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTIg5LiK5Y2IIDEyOjIzOjAw?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/12/2021 01:39:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164962 [Jul 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/12/2021 01:42:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzaWogUmVtcGVsIFtt
YWlsdG86by5yZW1wZWxAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDEw
LCAyMDIxIDEyOjU5IFBNDQo+IFRvOiBKb2hhbm5lcyBCZXJnDQo+IENjOiBQa3NoaWg7IGt2YWxv
QGNvZGVhdXJvcmEub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAwNy8yNF0gcnR3ODk6IGFkZCBNQUMgZmlsZXMNCj4gDQo+IE9uIEZyaSwg
SnVsIDA5LCAyMDIxIGF0IDA4OjE2OjUwUE0gKzAyMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6DQo+
ID4gT24gRnJpLCAyMDIxLTA3LTA5IGF0IDE5OjM4ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgSnVuIDE4LCAyMDIxIGF0IDAyOjQ2OjA4UE0gKzA4MDAsIFBpbmct
S2UgU2hpaCB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IFt0aG91c2FuZHMgb2YgcXVvdGVkIGxpbmVz
XQ0KPiA+DQo+ID4gRldJVywgaXQgd291bGQgcmVhbGx5IGhlbHAgaWYgeW91IHdlcmUgdG8gYWN0
dWFsbHkgcXVvdGUgb25seSB0aGUgYml0cw0KPiA+IHlvdSdyZSByZXBseWluZyB0by4uLg0KPiAN
Cj4gYWNrLiBJIHdhcyB0aGlua2luZyBhYm91dCBwcm92aWRpbmcgcGF0Y2ggYXMgcmVzcG9uc2Ug
dG8gcmVtb3ZlIG9ubHkNCj4gdW51c2VkIGNvZGUuIFRoaXMgcGF0Y2ggc2V0IGlzIDgwSyBsaW5l
cyBhbmQgaXQgaXMgbm90IHBvc3NpYmxlIHRvIHJldmlldyBpdA0KPiBqdXN0IGluIGJldHdlZW4g
dGhlIHdvcmsgYW5kIGNoaWxkcmVuIHdpdGhpbiBteSBob2JieSB0aW1lLg0KPiANCj4gQFBpbmct
S2UsIGlmIHlvdSB3b250IHRvIHNwZWVkIHVwIHRoZSByZXZpZXcsIEkgd291bGQgcmVjb21tZW5k
IHlvdXINCj4gY29tcGFueSB0byBjb250cmFjdCBtZSBvciBzb21lb25lIGVsc2UgdG8gZG8gaXQg
aW4gdGhlIG1haW4gd29ya2luZw0KPiB0aW1lLg0KPiANCg0KWWVzLCB3ZSBoYXZlIGNvbnRhY3Rl
ZCBSb2JlcnQsIGFuZCB3ZSB3aWxsIGhhdmUgaW50ZXJuYWwgZGlzY3Vzc2lvbiBmdXJ0aGVyLg0K
DQotLQ0KUGluZy1LZQ0KDQoNCg==
