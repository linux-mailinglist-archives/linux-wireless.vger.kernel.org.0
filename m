Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536976BFA98
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Mar 2023 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCRN7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Mar 2023 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCRN7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Mar 2023 09:59:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3130185
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 06:59:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32IDwa1O3006872, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32IDwa1O3006872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 18 Mar 2023 21:58:36 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 18 Mar 2023 21:58:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 18 Mar 2023 21:58:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Sat, 18 Mar 2023 21:58:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "rb0171610@gmail.com" <rb0171610@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "tiwai@suse.de" <tiwai@suse.de>
Subject: pull request: rtw89: 8852b: rollback firmware to v0.27.32.1 and introduce new file to new format
Thread-Topic: pull request: rtw89: 8852b: rollback firmware to v0.27.32.1 and
 introduce new file to new format
Thread-Index: AQHZWaHC1CjNCqm+pUmEqr8KKerHCA==
Date:   Sat, 18 Mar 2023 13:58:47 +0000
Message-ID: <889f3db6ca4008047595f4392388acc1f165e03c.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.31]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMTgg5LiK5Y2IIDA5OjAxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <56FBB7C3B85FE347A55B725CB835E590@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCkluIGRpc2N1c3Npb24gdGhyZWFkcyBbMV0gWzJdLCB0aGUgbmV3IGZvcm1hdCBvZiA4
ODUyYiBicmVhayB1c2VyIHNwYWNlLg0KVG8gYXZvaWQgdGhpcywgaW50cm9kdWNlIG5ldyBmaWxl
bmFtZSBydHc4OS9ydHc4ODUyYl9mdy0xLmJpbiB0aGF0IG9sZA0KZHJpdmVycyB3aWxsIG5vdCB0
cnkgdG8gbG9hZCBpdC4NCg0KUm9sbGJhY2sgZmlybXdhcmUgdmVyc2lvbiBvZiBydHc4OS9ydHc4
ODUyYl9mdy5iaW4gdG8gdGhlIGxhdGVzdA0KdmVyc2lvbiBvZiBvcmlnaW5hbCBmb3JtYXQgKGku
ZS4gdjAuMjcuMzIuMSkgc3VwcG9ydGVkIGJ5IG9sZCBkcml2ZXIuDQoNClRoZSBwYXRjaGVzIHRv
IHN1cHBvcnQgbmV3IGZpbGVuYW1lIGluIG5ldyBkcml2ZXIgYXJlIGFsbW9zdCBkb25lLA0KYW5k
IEkgd2lsbCBzdWJtaXQgdGhlbSBzb29uLiBUaGFua3MgZm9yIHRoZSBhZHZpY2UgaW4gbWFpbCBh
bmQNCmJ1ZyB0aHJlYWRzLg0KDQoNClsxXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXdpcmVsZXNzL2RmMWNlOTk0LTMzNjgtYTU3ZS03MDc4LThiZGNjY2Y0YTFmZEBnbWFpbC5jb20v
VC8jbTI0Y2I0M2JlMzFhNzYyZDBlYTcwYmYwN2YyN2FlOTZjNTlmNjkzMWINClsyXSBodHRwczov
L2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzIwNw0KDQoNClRoYW5rIHlv
dQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYzc2
MWRiZTgwNGY5MDNjYzJkZjgxZjI1MWQzNjdjY2EyODVlY2EwNjoNCg0KICBNZXJnZSB0YWcgJ2l3
bHdpZmktZnctMjAyMy0wMy0xMycgb2YgDQpodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUgKDIwMjMtMDMtMTMgMDk6MjA6
NDcgLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQog
IGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUuZ2l0IEhFQUQNCg0KZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDJjMDdmMDE3ZmY0MjM5OGUyNWI4NTUyYmM4ZTAx
YzdjNjY3Yjg1OTI6DQoNCiAgcnR3ODk6IDg4NTJiOiB1cGRhdGUgZm9ybWF0LTEgZncgdG8gdjAu
MjkuMjkuMCAoMjAyMy0wMy0xOCAyMTo0NDozMCArMDgwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUGluZy1LZSBT
aGloICgzKToNCiAgICAgIHJ0dzg5OiA4ODUyYjogcm9sbGJhY2sgZmlybXdhcmUgdG8gdjAuMjcu
MzIuMQ0KICAgICAgcnR3ODk6IDg4NTJiOiBhZGQgZm9ybWF0LTEgZncgdjAuMjkuMjYuMA0KICAg
ICAgcnR3ODk6IDg4NTJiOiB1cGRhdGUgZm9ybWF0LTEgZncgdG8gdjAuMjkuMjkuMA0KDQogV0hF
TkNFICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIHJ0dzg5L3J0dzg4NTJiX2Z3LTEuYmluIHwg
QmluIDAgLT4gMTE4ODQ4OCBieXRlcw0KIHJ0dzg5L3J0dzg4NTJiX2Z3LmJpbiAgIHwgQmluIDEx
ODg0ODggLT4gMTAzNTIzMiBieXRlcw0KIDMgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4NCg0K
