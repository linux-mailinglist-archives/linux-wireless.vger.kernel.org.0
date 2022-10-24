Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9760981F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 04:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJXCNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Oct 2022 22:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJXCNl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Oct 2022 22:13:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C82070E59
        for <linux-wireless@vger.kernel.org>; Sun, 23 Oct 2022 19:13:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29O2D19U0023759, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29O2D19U0023759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Oct 2022 10:13:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Oct 2022 10:13:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Oct 2022 10:13:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 24 Oct 2022 10:13:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: How to use the rate control in mac80211?
Thread-Topic: How to use the rate control in mac80211?
Thread-Index: AQHY5lyyL3gBgbd0EU6ThXL7SgPKiq4cyQxQ
Date:   Mon, 24 Oct 2022 02:13:34 +0000
Message-ID: <efd11380ad344257a8f674b1cff0d080@realtek.com>
References: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
In-Reply-To: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIzIOS4i+WNiCAxMTowMzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMjMsIDIw
MjIgNToyNCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IEhvdyB0byB1c2UgdGhlIHJhdGUgY29udHJvbCBpbiBtYWM4MDIxMT8NCj4gDQo+IEhpIQ0K
PiANCj4gV2hhdCBkb2VzIGEgZHJpdmVyIChydGw4eHh4dSkgbmVlZCB0byBkbyB0byBtYWtlIHRo
ZSByYXRlIGNvbnRyb2wgd29yaz8NCj4gDQo+IEkgdGhvdWdodCBpdCdzIGxpa2UgdGhpczoNCj4g
MSkgZG9uJ3Qgc2V0IEhBU19SQVRFX0NPTlRST0wNCj4gMikgdGVsbCB0aGUgY2hpcCB0byB1c2Ug
dGhlIHJhdGUgZnJvbSB0eF9pbmZvLT5jb250cm9sLnJhdGVzWzBdDQo+IDMpIHJlcG9ydCBpZiB0
aGUgZnJhbWUgd2FzIGFja2VkIG9yIG5vdA0KPiANCj4gQnV0IGl0J3Mgbm90IHRoYXQgZWFzeS4g
SSdtIGFsd2F5cyBnZXR0aW5nIE1DUzAuIEN1cnJlbnRseSBydGw4eHh4dQ0KPiBkb2Vzbid0IGFz
ayB0aGUgY2hpcCBmb3IgVFggcmVwb3J0cyBhbmQgYWx3YXlzIHNldHMgSUVFRTgwMjExX1RYX1NU
QVRfQUNLLg0KPiBJIHRob3VnaHQgdGhpcyB3b3VsZCBnZXQgbWUgTUNTNyBmb3IgYWxsIGRhdGEg
ZnJhbWVzLCBidXQgaXQgZG9lc24ndC4NCg0KSSBkb24ndCBkaWcgcmF0ZSBjb250cm9sIG9mIG1h
YzgwMjExLCBidXQgSSB0aGluayBpdCBpcyBoYXJkIHRvIHN1cHBvcnQgdGhpcw0KYnkgUmVhbHRl
ayBjaGlwLCBiZWNhdXNlIHRoZSBpdGVtIDMgeW91IGxpc3RlZC4NCg0KUmVhbHRlayBXaUZpIGNo
aXAgb25seSByZXBvcnRzIFRYIHN0YXR1cyBmb3Igc3BlY2lmaWMgcGFja2V0cywgYmVjYXVzZSBi
dXMNCmJhbmR3aWR0aCBpcyBsaW1pdGVkLCBzbyByZWR1Y2UgdGhlc2UgcmVwb3J0cyB0byBoYXZl
IGJldHRlciBwZXJmb3JtYW5jZS4NCkFuZCwgZmlybXdhcmUgaGFzIGltcGxlbWVudGVkIHJhdGUg
Y29udHJvbCBjYWxsZWQgcmF0ZSBhZGFwdGl2ZSAoUkEpLCBhbmQNCnVzaW5nIGZpcm13YXJlIFJB
IGlzIGV4cGVjdGVkLg0KDQpJZiB5b3UgcmVhbGx5IHdhbnQgdG8gY29udHJvbCByYXRlIGJ5IGRy
aXZlciwgeW91IGNhbiByZWZlciB0byBpbXBsZW1lbnRhdGlvbg0Kb2YgbWFuYWdlbWVudCBmcmFt
ZSBiZWxvdzoNCg0KCWlmIChpZWVlODAyMTFfaXNfbWdtdChoZHItPmZyYW1lX2NvbnRyb2wpKSB7
DQoJCXR4X2Rlc2MtPnR4ZHc1ID0gY3B1X3RvX2xlMzIocmF0ZSk7DQoJCXR4X2Rlc2MtPnR4ZHc0
IHw9IGNwdV90b19sZTMyKFRYREVTQzMyX1VTRV9EUklWRVJfUkFURSk7DQoJCXR4X2Rlc2MtPnR4
ZHc1IHw9IGNwdV90b19sZTMyKDYgPDwgVFhERVNDMzJfUkVUUllfTElNSVRfU0hJRlQpOw0KCQl0
eF9kZXNjLT50eGR3NSB8PSBjcHVfdG9fbGUzMihUWERFU0MzMl9SRVRSWV9MSU1JVF9FTkFCTEUp
Ow0KCX0NCg0KQW5vdGhlciB0aGluZyBpcyB0aGF0IHJldHJ5IHJhdGUgaXMgZGVjaWRlZCBieSBo
YXJkd2FyZSBieSBhbm90aGVyIHJlZ2lzdGVyDQpzZXR0aW5ncywgYnV0IEknbSBub3QgZmFtaWxp
YXIgd2l0aCB0aGVtLCBiZWNhdXNlIEkgYWx3YXlzIHVzZSBSQSBtZW50aW9uZWQNCmFib3ZlLiBN
YXliZSwgeW91IHN0aWxsIGNhbiB1c2UgKmRlZmF1bHQqIHNldHRpbmdzIG9mIHJldHJ5IHJhdGUg
dGhhdCBjb3VsZA0Kd29yayBidXQgbm90IGFsd2F5cyBnb29kIGluIGFsbCBzaXR1YXRpb25zLg0K
DQpQaW5nLUtlDQoNCg==
