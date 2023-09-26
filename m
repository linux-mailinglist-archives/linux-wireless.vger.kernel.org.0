Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E977AE30E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 02:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjIZArZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 20:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIZArY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 20:47:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED81210E
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 17:47:17 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38Q0lDuoD152244, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38Q0lDuoD152244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 08:47:13 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 26 Sep 2023 08:47:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 08:47:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Tue, 26 Sep 2023 08:47:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: On spatial multiplexing power save in rtlwifi (rtl8192de)
Thread-Topic: On spatial multiplexing power save in rtlwifi (rtl8192de)
Thread-Index: AQHZ7Vw3lfMaOFz5bUyjspm8JXQNYbAsR+/g
Date:   Tue, 26 Sep 2023 00:47:14 +0000
Message-ID: <cde3d672cc2a48cf8f41928b38ca2f25@realtek.com>
References: <16576ef1-55a1-5efd-9f0e-1a0d8aa8cada@yandex.ru>
In-Reply-To: <16576ef1-55a1-5efd-9f0e-1a0d8aa8cada@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IEFudGlwb3Yg
PGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIyLCAyMDIz
IDk6NTQgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IE9uIHNwYXRpYWwgbXVs
dGlwbGV4aW5nIHBvd2VyIHNhdmUgaW4gcnRsd2lmaSAocnRsODE5MmRlKQ0KPiANCj4gU2hvdWxk
bid0ICdydGw5MmRlX3VwZGF0ZV9oYWxfcmF0ZV90YWJsZSgpJyBhdm9pZCBoYXJkY29kZWQgJ21p
bW9fcHMnDQo+IGJ1dCByYXRoZXIgZXh0cmFjdCBpdCBmcm9tICdzdHJ1Y3QgcnRsX3N0YV9pbmZv
JyBsaWtlIGl0J3MgZG9uZSBpbg0KPiAncnRsOTJkZV91cGRhdGVfaGFsX3JhdGVfbWFzaygpJz8N
Cj4gDQoNClRoZSBpbml0aWFsIGNvbW1pdCAzYWZmZGY0MjM3M2UgKCJydGx3aWZpOiBydGw4MTky
ZGU6IE1lcmdlIGhhcmR3YXJlIHJvdXRpbmVzIikNCmlzIGFzIGl0IGlzLCBhbmQgSSdtIG5vdCBj
bGVhciB0aGUgcmVhc29uIHdoeSBoYXJkY29kZSAnbWlub19wcycuIElJUkMsDQp0aGlzIGNoaXAg
aGFzIHR3byBQSFksIHNvIGl0IGNvdWxkIGJlIGNvbmZpZ3VyZWQgYXMgdHdvIGludGVyZmFjZXMs
IGFuZCBlYWNoDQpvbmUgd29ya3MgYXMgMVQxUiBtb2RlLiBNYXliZSwgdGhpcyBpcyB0aGUgcmVh
c29uLi4uIA0KDQpDcnJlbnRseSwgcnRscHJpdi0+ZG0udXNlcmFtYXNrIGlzIGFsd2F5cyB0cnVl
IGZvciBydGw4MTkyZGUsIHNvDQpydGw5MmRlX3VwZGF0ZV9oYWxfcmF0ZV90YWJsZSgpIHNob3Vs
ZCBub3QgYmUgY2FsbGVkOiANCg0KCWlmIChydGxwcml2LT5kbS51c2VyYW1hc2spDQoJCXJ0bDky
ZGVfdXBkYXRlX2hhbF9yYXRlX21hc2soaHcsIHN0YSwgcnNzaV9sZXZlbCwgdXBkYXRlX2J3KTsN
CgllbHNlDQoJCXJ0bDkyZGVfdXBkYXRlX2hhbF9yYXRlX3RhYmxlKGh3LCBzdGEpOw0KDQpTaW5j
ZSBJIGRvbid0IGhhdmUgYSBoYXJkd2FyZSB0byBkbyBhIHJlYWwgdGVzdCwgbm8gaWRlYSB0byB5
b3VyIHF1ZXN0aW9uLiANCg0KUGluZy1LZQ0KDQo=
