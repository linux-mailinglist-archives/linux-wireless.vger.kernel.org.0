Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5908F482D77
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jan 2022 02:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiACBnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 20:43:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:57502 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiACBnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 20:43:31 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2031hBrM5025893, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2031hBrM5025893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 3 Jan 2022 09:43:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 09:43:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 09:43:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Mon, 3 Jan 2022 09:43:11 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>
Subject: RE: [PATCH 1/2] rtw89: limit RX status rate of VHT to MCS 9
Thread-Topic: [PATCH 1/2] rtw89: limit RX status rate of VHT to MCS 9
Thread-Index: AQHX/Rrux6tkmbbln0acDu+8YuwYI6xLBrGAgAWD7SA=
Date:   Mon, 3 Jan 2022 01:43:11 +0000
Message-ID: <99e83e4f61194afbae7caa0afcb3ca0f@realtek.com>
References: <20211230011607.8823-1-pkshih@realtek.com>
 <e71124fb6941ceb8022347a19deb954e54f653f3.camel@sipsolutions.net>
In-Reply-To: <e71124fb6941ceb8022347a19deb954e54f653f3.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMiDkuIvljYggMDY6NDk6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMzEsIDIw
MjEgNToyNCBBTQ0KPiBUbzogUGtzaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBrdmFsb0BrZXJu
ZWwub3JnDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IHJnb2xkd3luQHN1
c2UuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBydHc4OTogbGltaXQgUlggc3RhdHVz
IHJhdGUgb2YgVkhUIHRvIE1DUyA5DQo+IA0KPiBPbiBUaHUsIDIwMjEtMTItMzAgYXQgMDk6MTYg
KzA4MDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA4ODUyQUUgY2FuIHJlY2VpdmUgcGFja2V0
cyB3aXRoIFZIVCBNQ1MxMC8xMSB0aGF0IGlzIG91dCBvZiBzcGVjaWZpY2F0aW9uLA0KPiA+IHNv
IG1hYzgwMjExIHdhcm5zIGFuZCBkcm9wcyB0aGUgcGFja2V0cywgYW5kIGl0IGxlYWRzIGxvdyBU
Q1AgdGhyb3VnaHB1dC4NCj4gPg0KPiA+ICAgUmF0ZSBtYXJrZWQgYXMgYSBWSFQgcmF0ZSBidXQg
ZGF0YSBpcyBpbnZhbGlkOiBNQ1M6IDEwLCBOU1M6IDINCj4gPg0KPiANCj4gV2UgYWxyZWFkeSBz
dXBwb3J0IHRoZXNlIGluIGNmZzgwMjExIGZvciBicmNtZm1hYywgYXJndWFibHkgd2UgY291bGQN
Cj4ganVzdCBhZGQgc3VwcG9ydCBpbiBtYWM4MDIxMSBpbnN0ZWFkPw0KPiANCg0KSSBoYXZlIHNl
bnQgb3V0IGEgcGF0Y2hzZXQgWzFdIGluY2x1ZGluZyBkcml2ZXIgcGF0Y2hlcy4gDQoNClsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDIyMDEwMzAxMzYyMy4xNzA1
Mi0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyNtOWRhMTU3NGNjOTRhNDNhYzIwYWU5YzNiYmRhMzMx
YWEwOTg5MjI0OQ0KDQotLQ0KUGluZy1LZQ0KDQo=
