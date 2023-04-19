Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E6E78E2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDSLqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjDSLqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 07:46:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930C14478
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 04:46:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33JBk1auD009741, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33JBk1auD009741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 19 Apr 2023 19:46:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 19 Apr 2023 19:46:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Apr 2023 19:46:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 19 Apr 2023 19:46:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: [PATCH 4/5] wifi: rtw89: mac: handle C2H receive/done ACK in interrupt context
Thread-Topic: [PATCH 4/5] wifi: rtw89: mac: handle C2H receive/done ACK in
 interrupt context
Thread-Index: AQHZcrSDVkC0UVs+FEqeKc7x9ArKXQ==
Date:   Wed, 19 Apr 2023 11:46:01 +0000
Message-ID: <c4d766885e00b9f9dcf7954a80096c8b9d21149b.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.139]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <E763BDAEFBDAF148B6893EF6BD875D72@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NCg0KV2UgaGF2ZSBz
b21lIE1BQyBIMkNzIChob3N0IHRvIGNoaXAgcGFja2V0cyksIHdoaWNoIGhhdmUgbm8gY2xlYXIN
CmluZGl2aWR1YWwgQzJIcyAoY2hpcCB0byBob3N0IHBhY2tldHMpIHRvIGluZGljYXRlIEZXIGV4
ZWN1dGlvbg0KcmVzcG9uc2UsIGJ1dCB0aGV5IGFyZSBnb2luZyB0byByZXF1aXJlIHRvIHdhaXQg
Zm9yIEZXIGNvbXBsZXRpb24uDQpTbywgd2UgaGF2ZSB0byBkZWFsIHdpdGggdGhpcyB2aWEgY29t
bW9uIE1BQyBDMkggcmVjZWl2ZS9kb25lIEFDS3MuDQoNClRoaXMgY29tbWl0IGNoYW5nZXMgdGhl
IGNvbnRleHQsIHdoZXJlIGNvbW1vbiBNQUMgQzJIIHJlY2VpdmUvZG9uZQ0KQUNLIGhhbmRsZXJz
IGFyZSBleGVjdXRlZCwgdG8gaW50ZXJydXB0IGNvbnRleHQuIEFuZCwgY29kZSBjb21tZW50cw0K
YXJlIGFkZGVkIHRvIHByZXZlbnQgZnV0dXJlIGNvbW1pdHMgZnJvbSB1c2luZyBpdCBpbmNvcnJl
Y3RseS4NCg0KU2lnbmVkLW9mZi1ieTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVr
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyB8IDEyICsrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KaW5kZXggZWUwZDFlNDIzMjk3Yi4uMDAyYzRk
YzJmNWQ1MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
bWFjLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCkBA
IC00MzIzLDYgKzQzMjMsOCBAQCBydHc4OV9tYWNfYzJoX2Jjbl9mbHRyX3JwdChzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpjMmgsDQogc3RhdGljIHZvaWQNCiBydHc4
OV9tYWNfYzJoX3JlY19hY2soc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqYzJoLCB1MzIgbGVuKQ0KIHsNCisJLyogTi5CLiBUaGlzIHdpbGwgcnVuIGluIGludGVycnVw
dCBjb250ZXh0LiAqLw0KKw0KIAlydHc4OV9kZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19GVywNCiAJ
CSAgICAiQzJIIHJldiBhY2sgcmVjdiwgY2F0OiAlZCwgY2xhc3M6ICVkLCBmdW5jOiAlZCwgc2Vx
IDogJWRcbiIsDQogCQkgICAgUlRXODlfR0VUX01BQ19DMkhfUkVWX0FDS19DQVQoYzJoLT5kYXRh
KSwNCkBAIC00MzM0LDYgKzQzMzYsOCBAQCBydHc4OV9tYWNfYzJoX3JlY19hY2soc3RydWN0IHJ0
dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqYzJoLCB1MzIgbGVuKQ0KIHN0YXRpYyB2
b2lkDQogcnR3ODlfbWFjX2MyaF9kb25lX2FjayhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHN0
cnVjdCBza19idWZmICpjMmgsIHUzMiBsZW4pDQogew0KKwkvKiBOLkIuIFRoaXMgd2lsbCBydW4g
aW4gaW50ZXJydXB0IGNvbnRleHQuICovDQorDQogCXJ0dzg5X2RlYnVnKHJ0d2RldiwgUlRXODlf
REJHX0ZXLA0KIAkJICAgICJDMkggZG9uZSBhY2sgcmVjdiwgY2F0OiAlZCwgY2xhc3M6ICVkLCBm
dW5jOiAlZCwgcmV0OiAlZCwgc2VxIDogJWRcbiIsDQogCQkgICAgUlRXODlfR0VUX01BQ19DMkhf
RE9ORV9BQ0tfQ0FUKGMyaC0+ZGF0YSksDQpAQCAtNDU3OSw2ICs0NTgzLDE0IEBAIGJvb2wgcnR3
ODlfbWFjX2MyaF9jaGtfYXRvbWljKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggY2xhc3Ms
IHU4IGZ1bmMpDQogCXN3aXRjaCAoY2xhc3MpIHsNCiAJZGVmYXVsdDoNCiAJCXJldHVybiBmYWxz
ZTsNCisJY2FzZSBSVFc4OV9NQUNfQzJIX0NMQVNTX0lORk86DQorCQlzd2l0Y2ggKGZ1bmMpIHsN
CisJCWRlZmF1bHQ6DQorCQkJcmV0dXJuIGZhbHNlOw0KKwkJY2FzZSBSVFc4OV9NQUNfQzJIX0ZV
TkNfUkVDX0FDSzoNCisJCWNhc2UgUlRXODlfTUFDX0MySF9GVU5DX0RPTkVfQUNLOg0KKwkJCXJl
dHVybiB0cnVlOw0KKwkJfQ0KIAljYXNlIFJUVzg5X01BQ19DMkhfQ0xBU1NfT0ZMRDoNCiAJCXN3
aXRjaCAoZnVuYykgew0KIAkJZGVmYXVsdDoNCi0tIA0KMi4yNS4xDQo=
