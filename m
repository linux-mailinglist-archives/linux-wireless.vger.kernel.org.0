Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403A6E78E0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjDSLqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjDSLqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 07:46:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585DB13F84
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 04:45:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33JBjqcP7009728, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33JBjqcP7009728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 19 Apr 2023 19:45:52 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 19 Apr 2023 19:45:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 19 Apr 2023 19:45:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 19 Apr 2023 19:45:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: [PATCH 1/5] wifi: rtw89: release bit in rtw89_fw_h2c_del_pkt_offload()
Thread-Topic: [PATCH 1/5] wifi: rtw89: release bit in
 rtw89_fw_h2c_del_pkt_offload()
Thread-Index: AQHZcrR9Osl2uZogzEeLKGRhJ2En9Q==
Date:   Wed, 19 Apr 2023 11:45:51 +0000
Message-ID: <8cf5d45c5b04e7b680d4eb9dda62056cdce14cec.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.139]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DF0A47FECE78F46B9CC07F9C0538E89@realtek.com>
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

RnJvbTogWm9uZy1aaGUgWWFuZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NCg0KV2UgaGF2ZSBh
IHBhaXIgb2YgRlcgZnVuY3Rpb25zLCBydHc4OV9md19oMmNfYWRkX3BrdF9vZmZsb2FkKCkgYW5k
DQpydHc4OV9md19oMmNfZGVsX3BrdF9vZmZsb2FkKCkuIFRoZSBydHc4OV9md19oMmNfYWRkX3Br
dF9vZmZsb2FkKCkNCmFjcXVpcmVzIHRoZSBiaXQgaXRzZWxmLCBidXQgdGhlIGJpdCBuZWVkcyB0
byBiZSByZWxlYXNlZCBieSB0aGUNCmNhbGxlciBvZiBydHc4OV9md19oMmNfZGVsX3BrdF9vZmZs
b2FkKCkuIFRoaXMgbG9va3MgYXN5bW1ldHJpY2FsDQphbmQgaXMgbm90IGZyaWVuZGx5IHRvIGNh
bGxlcnMuDQoNClNlY29uZCwgaWYgY2FsbGVycyBhbHdheXMgcmVsZWFzZXMgdGhlIGJpdHMsIGl0
IG1pZ2h0IG1ha2UgZHJpdmVyDQp1bmFsaWduZWQgdG8gYml0bWFwIHN0YXR1cyBvZiBGVyBhZnRl
ciBzb21lIGZhaWx1cmVzIG9mIGNhbGxpbmcNCnJ0dzg5X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQo
KS4gU28sIHRoaXMgY29tbWl0IG1vdmUgYml0IHJlbGVhc2UNCmludG8gcnR3ODlfZndfaDJjX2Rl
bF9wa3Rfb2ZmbG9hZCgpLg0KDQpJbiBnZW5lcmFsLCBkcml2ZXIgd2lsbCBjYWxsIHJ0dzg5X2Z3
X2gyY19hZGRfcGt0X29mZmxvYWQoKSBhbmQNCnJ0dzg5X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQo
KSwgYW5kIHRoZW4sIFNXIGJpdG1hcCBjYW4gYWxpZ24NCndpdGggRlcgb25lLiBUaGVyZSBpcyBv
bmUgZXhjZXB0aW9uIHdoZW4gbm90aWZ5X2Z3IGlzIGZhbHNlLg0KSXQgaGFwcGVucyB3aGVuIGRy
aXZlciBkZXRlY3RzIEZXIHByb2JsZW1zIGFuZCBpcyBnb2luZyB0bw0KcmVzZXQgRlcuIE9ubHkg
aW4gdGhpcyBjYXNlLCBkcml2ZXIgbmVlZHMgdG8gcmVsZWFzZSBiaXRzDQpvdXRzaWRlIHJ0dzg5
X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQoKS4NCg0KU2lnbmVkLW9mZi1ieTogWm9uZy1aaGUgWWFu
ZyA8a2V2aW5feWFuZ0ByZWFsdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9mdy5jIHwgNyArKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0K
aW5kZXggYjliNjc1YmY5ZDA1MC4uNDA1MWQzMzdlZjRlZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9mdy5jDQpAQCAtOTk3LDggKzk5Nyw4IEBAIHZvaWQgcnR3ODlfZndf
cmVsZWFzZV9nZW5lcmFsX3BrdF9saXN0X3ZpZihzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsDQog
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShpbmZvLCB0bXAsIHBrdF9saXN0LCBsaXN0KSB7DQog
CQlpZiAobm90aWZ5X2Z3KQ0KIAkJCXJ0dzg5X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQocnR3ZGV2
LCBpbmZvLT5pZCk7DQotCQlydHc4OV9jb3JlX3JlbGVhc2VfYml0X21hcChydHdkZXYtPnBrdF9v
ZmZsb2FkLA0KLQkJCQkJICAgaW5mby0+aWQpOw0KKwkJZWxzZQ0KKwkJCXJ0dzg5X2NvcmVfcmVs
ZWFzZV9iaXRfbWFwKHJ0d2Rldi0+cGt0X29mZmxvYWQsIGluZm8tPmlkKTsNCiAJCWxpc3RfZGVs
KCZpbmZvLT5saXN0KTsNCiAJCWtmcmVlKGluZm8pOw0KIAl9DQpAQCAtMjQ2Niw2ICsyNDY2LDcg
QEAgaW50IHJ0dzg5X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQoc3RydWN0IHJ0dzg5X2RldiAqcnR3
ZGV2LCB1OCBpZCkNCiAJCWdvdG8gZmFpbDsNCiAJfQ0KIA0KKwlydHc4OV9jb3JlX3JlbGVhc2Vf
Yml0X21hcChydHdkZXYtPnBrdF9vZmZsb2FkLCBpZCk7DQogCXJldHVybiAwOw0KIGZhaWw6DQog
CWRldl9rZnJlZV9za2JfYW55KHNrYik7DQpAQCAtMzAyMCw4ICszMDIxLDYgQEAgc3RhdGljIHZv
aWQgcnR3ODlfcmVsZWFzZV9wa3RfbGlzdChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQogDQog
CQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaW5mbywgdG1wLCAmcGt0X2xpc3RbaWR4XSwgbGlz
dCkgew0KIAkJCXJ0dzg5X2Z3X2gyY19kZWxfcGt0X29mZmxvYWQocnR3ZGV2LCBpbmZvLT5pZCk7
DQotCQkJcnR3ODlfY29yZV9yZWxlYXNlX2JpdF9tYXAocnR3ZGV2LT5wa3Rfb2ZmbG9hZCwNCi0J
CQkJCQkgICBpbmZvLT5pZCk7DQogCQkJbGlzdF9kZWwoJmluZm8tPmxpc3QpOw0KIAkJCWtmcmVl
KGluZm8pOw0KIAkJfQ0KLS0gDQoyLjI1LjENCg==
