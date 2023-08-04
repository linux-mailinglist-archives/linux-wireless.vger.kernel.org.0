Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1637076F6B0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 02:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHDAzG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 20:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHDAzE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 20:55:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CB1E3A89
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 17:55:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3740sdYG3024578, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3740sdYG3024578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 08:54:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 4 Aug 2023 08:54:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Aug 2023 08:54:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 4 Aug 2023 08:54:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Regression in rtw89
Thread-Topic: Regression in rtw89
Thread-Index: AQHZxlfTPgsrp0ON2UeQ37Bkk7RKaa/ZRqLA
Date:   Fri, 4 Aug 2023 00:54:53 +0000
Message-ID: <c58758f5e2134ca19d9a11a0d54b96f1@realtek.com>
References: <813e9c3d-7fbd-7589-ebd0-6c61f03f970b@lwfinger.net>
In-Reply-To: <813e9c3d-7fbd-7589-ebd0-6c61f03f970b@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IEZyaWRheSwgQXVndXN0IDQsIDIwMjMgNjoxNCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzcyA8bGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZWdyZXNzaW9uIGluIHJ0dzg5DQo+IA0KPiBQaW5n
LUtlLA0KPiANCj4gQSB1c2VyIG9mIG15IEdpdEh1YiByZXBvIGhhcyByZXBvcnRlZCBhIHJlZ3Jl
c3Npb24gYmVnaW5uaW5nIHdpdGggY29tbWl0DQo+IDI2YTEyNWY1NTBhMyAoIndpZmk6IHJ0dzg5
OiBjb3JyZWN0IFBTIGNhbGN1bGF0aW9uIGZvciBTVVBQT1JUU19EWU5BTUlDX1BTIikuDQo+IFRo
ZSB1c2VyIGZpbmRzIGludGVyZmVyZW5jZSBiZXR3ZWVuIHdpZmkgYW5kIHRoZSBCVCBkZXZpY2Ug
dGhhdCBpcyBwYXJ0IG9mIHRoZQ0KPiBwYWNrYWdlLg0KPiANCj4gV2Ugd2VyZSBhYmxlIHRvIGRl
dGVybWluZSB0aGF0IGxvYWRpbmcgcnR3ODlfY29yZSB3aXRoIHRoZSAiZGlzYWJsZV9wc19tb2Rl
PXkiDQo+IG9wdGlvbiBkb2VzIGZpeCB0aGUgcHJvYmxlbS4gT3VyIGRpc2N1c3Npb24gb2YgdGhl
IHByb2JsZW0gY2FuIGJlIHNlZW4gYXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0
dzg5L2lzc3Vlcy8yNjIjaXNzdWVjb21tZW50LTE2NjQ2NTg3NjQuDQo+IA0KDQpBcyB0aGUgY29t
bWl0IG1lc3NhZ2Ugb2YgdGhlIDI2YTEyNWY1NTBhMywgUFMgd2FzIGJyb2tlbiBzaW5jZSB2NS4y
MCwgYW5kIHRoYXQNCnBhdGNoIGZpeGVzIGl0LiBUaGUgY29ycmVjdCBiaXNlY3Rpb24gaXMgZnJv
bSBpbml0aWFsIHZlcnNpb24gb2YgODg1MkJFICsgdGhpcyBwYXRjaC4NCig4ODUyQkUgaXMgaW50
cm9kdWNlZCBieSBrZXJuZWwgdjYuMiwgYW5kIFBTIHdhcyBicm9rZW4gYXQgdGhhdCB0aW1lLikN
Cg0KQXMgdGhlIGRpc2N1c3Npb24gaW4gZ2l0aHViLCBpdCBsb29rcyBsaWtlIGEgQlQtY29leGlz
dGVuY2UgcHJvYmxlbSwgYmVjYXVzZQ0KQm90aCBXaUZpLW9ubHkgYW5kIEJULW9ubHkgd29yay4g
UGxlYXNlIHVwZGF0ZSBCVCBkcml2ZXIgYW5kIGZpcm13YXJlIHRvIGhhdmUNCmJlbG93Og0KIEJU
IGRyaXZlcjogDQogICAtIEJsdWV0b290aDogYnRydGw6IEZpcm13YXJlIGZvcm1hdCB2MiBzdXBw
b3J0DQogICAtIEJsdWV0b290aDogYnRydGw6IEFkZCB0aGUgc3VwcG9ydCBmb3IgUlRMODg1MUIN
CiBCVCBmaXJtd2FyZTogKGNvcHkgYWxsIGZpbGVzIGZyb20gbGludXgtZmlybXdhcmUuZ2l0Oi9y
dGxfYnQvKQ0KICAgLSBydGxfYnQ6IEFkZCBmaXJtd2FyZSBhbmQgY29uZmlnIGZpbGVzIGZvciBS
VEw4ODUxQg0KDQpUaGVuLCByZWFkIGJ0Y19pbmZvIGluIHBlcmlvZCBvZiAyIHNlY29uZHMgYmVm
b3JlIGFuZCBhZnRlciBlbnRlcmluZyBQUy4NCkEgc2FtcGxlIHNjcmlwdCB0byBjYXB0dXJlIGxv
Zw0KICAgd2hpbGUgWyB0cnVlIF07IGRvIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAyMTEv
cGh5MC9ydHc4OS9idGNfaW5mbzsgZGF0ZTsgc2xlZXAgMjsgZG9uZQ0KQW5kLCB1c2UgJ2l3IHds
YW4wIHNldCBwb3dlcl9zYXZlIG9uL29mZicgdG8gc3dpdGNoIFBTIHN0YXRlLiBBbHNvLCBwbGVh
c2UNCnBvaW50IG91dCB0aGUgdGltZSB3aGVuIEJUIGdvZXMgd3JvbmcuIA0KDQo+IFJlYWRpbmcg
dGhlIHBhdGNoIGluIHF1ZXN0aW9uLCBpdCBzZWVtcyB0aGF0IGEgdmlmIGNvdW50IG9mIDEgaXMg
bm90IHN1ZmZpY2llbnQNCj4gdG8gZW5hYmxlIFBTLCBhbmQgdGhhdCBpdCBpcyBhbHNvIG5lY2Vz
c2FyeSB0byBtYWtlIHN1cmUgdGhhdCBCVCBpcyBub3QgYWN0aXZlDQo+IGFzIHdlbGwuDQoNCid2
aWYnIGNvdW50IHJlZmVycyB0byBXaUZpIHZpZiB0aGF0IGlzIG5vcm1hbGx5IG9uZSBmb3IgcmVn
dWxhciB1c2UgKFNUQSBtb2RlIG9ubHkpLg0KV2hlbiBpdCBlbnRlcnMvbGVhdmVzIFBTLCBydHc4
OV9idGNfbnRmeV9yYWRpb19zdGF0ZSgpIGlzIGNhbGxlZCB0byBub3RpZnkgDQpCVC1jb2V4aXN0
ZW5jZSBtZWNoYW5pc20gdG8gcmVmbGVjdCBjdXJyZW50IFdpRmkgUFMgc3RhdGUuIEJ5IHRoZSB3
YXksIHRoaW5ncw0KcmVsYXRlZCB0byBCVCBhcmUgZXhpc3RpbmcgaW4gY29leC5jLiANCg0KUGlu
Zy1LZQ0KDQo=
