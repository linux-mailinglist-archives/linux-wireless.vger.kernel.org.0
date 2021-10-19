Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF7432B3E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJSApx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 20:45:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52172 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJSApx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 20:45:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 19J0hb923006053, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 19J0hb923006053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Oct 2021 08:43:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 19 Oct 2021 08:43:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 18 Oct 2021 17:43:36 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Tue, 19 Oct 2021 08:43:36 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Josh Boyer <jwboyer@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: pull request: rtw89: 8852a: update fw to v0.13.30.0
Thread-Topic: pull request: rtw89: 8852a: update fw to v0.13.30.0
Thread-Index: AdfAFs+Noya6ABOFSO2DBhPxcrac4QDx6n8AACjdoiA=
Date:   Tue, 19 Oct 2021 00:43:36 +0000
Message-ID: <2b6bb42ae75f4a6dae59e0773f21367a@realtek.com>
References: <b3dc77916dc7486eb312e1e44119116b@realtek.com>
 <CA+5PVA5qbQEr5d-dKa77vQWmztyRc_JrBi2WTCNcuL4BCQ=z7Q@mail.gmail.com>
In-Reply-To: <CA+5PVA5qbQEr5d-dKa77vQWmztyRc_JrBi2WTCNcuL4BCQ=z7Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzE4IOS4i+WNiCAwODoyNjowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/19/2021 00:24:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166808 [Oct 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: github.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/19/2021 00:27:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvc2ggQm95ZXIgPGp3Ym95
ZXJAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDE4LCAyMDIxIDk6MTEgUE0N
Cj4gVG86IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgtZmlybXdhcmVA
a2VybmVsLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBwdWxsIHJlcXVlc3Q6IHJ0dzg5OiA4ODUyYTogdXBkYXRlIGZ3IHRvIHYwLjEzLjMwLjANCj4g
DQo+IE9uIFdlZCwgT2N0IDEzLCAyMDIxIGF0IDU6NDYgQU0gUGtzaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBVcGRhdGUgZmlybXdhcmUgb2Yg
cnR3ODkgZHJpdmVyIHRoYXQgZ2V0IG1lcmdlZC4NCj4gPg0KPiA+IFBpbmctS2UNCj4gPg0KPiA+
IC0tDQo+ID4NCj4gPiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGVjMTdiNjM3
YjdhYjkyOGNhN2ViYzAzODllMGUzOTIxZjFjYzdkMTc6DQo+ID4NCj4gPiAgIHJ0dzg5OiA4ODUy
YTogdXBkYXRlIGZ3IHRvIHYwLjEzLjMwLjAgKDIwMjEtMTAtMTMgMTc6NDA6NDYgKzA4MDApDQo+
ID4NCj4gPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4gPg0KPiA+
ICAgaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9saW51eC1maXJtd2FyZS5naXQNCj4gPg0KPiA+
IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlYzE3YjYzN2I3YWI5MjhjYTdlYmMwMzg5
ZTBlMzkyMWYxY2M3ZDE3Og0KPiA+DQo+ID4gICBydHc4OTogODg1MmE6IHVwZGF0ZSBmdyB0byB2
MC4xMy4zMC4wICgyMDIxLTEwLTEzIDE3OjQwOjQ2ICswODAwKQ0KPiANCj4gSXMgdGhpcyBmcm9t
IHRoZSA4ODUyQUUtMC4xMy4zMC4wIGJyYW5jaD8gIFRoZSBnaXRodWIgcmVwbyBkZWZhdWx0cyB0
bw0KPiA4ODUyQUUtdjYgd2hpY2ggZG9lcyBub3QgaGF2ZSB0aGlzIGNvbW1pdC4NCj4gDQoNClll
cy4gVG8gYXZvaWQgY29uZnVzaW5nLCBJIHB1c2ggdGhpcyB0byBtYXN0ZXIgYnJhbmNoIGFuZCB1
c2UgaXQgYXMgZGVmYXVsdC4NCg0KVGhhbmsgeW91DQotLQ0KUGluZy1LZQ0KDQo=
