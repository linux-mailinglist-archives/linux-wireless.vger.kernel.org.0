Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C56E78DD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDSLp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjDSLp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 07:45:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684A4231
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 04:45:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33JBjlqT7009724, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33JBjlqT7009724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 19 Apr 2023 19:45:47 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 19 Apr 2023 19:45:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 19 Apr 2023 19:45:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 19 Apr 2023 19:45:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: [PATCH 0/5] wifi: rtw89: wait for firmware ack for certain H2C commands
Thread-Topic: [PATCH 0/5] wifi: rtw89: wait for firmware ack for certain H2C
 commands
Thread-Index: AQHZcrR7E24lA9wuLUieNbPlauh+Xw==
Date:   Wed, 19 Apr 2023 11:45:47 +0000
Message-ID: <fc48a6204102e09f49e99ada80fb571ba0add5d9.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.139]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <33634438B49274469746A351E57A4000@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VHdvIEgyQyBjb21tYW5kcyByZWxhdGVkIHNjYW5uaW5nIGFyZSBuZWVkZWQgdG8gd2FpdCBmb3Ig
ZmlybXdhcmUgYWNrDQpiZWZvcmUgc2VuZGluZyBhbm90aGVyIG9uZSwgYmVjYXVzZSBmaXJtd2Fy
ZSBjYW4ndCBhbHdheXMgaGFuZGxlIGJ1cnN0IEgyQw0KcHJvcGVybHkuIFRvIHJlc29sdmUgdGhp
cyBwb3RlbnRpYWwgcHJvYmxlbSwgYWRkIGEgd2FpdCBtZWNoYW5pc20uIEFsc28sDQpyZWZpbmUg
cmVsYXRlZCBmbG93IHRvIGRlbGV0ZSBvZmZsb2FkIHBhY2tldHMuDQoNClpvbmctWmhlIFlhbmcg
KDUpOg0KICB3aWZpOiBydHc4OTogcmVsZWFzZSBiaXQgaW4gcnR3ODlfZndfaDJjX2RlbF9wa3Rf
b2ZmbG9hZCgpDQogIHdpZmk6IHJ0dzg5OiByZWZpbmUgcGFja2V0IG9mZmxvYWQgZGVsZXRlIGZs
b3cgb2YgNiBHSHogcHJvYmUNCiAgd2lmaTogcnR3ODk6IHBhY2tldCBvZmZsb2FkIHdhaXQgZm9y
IEZXIHJlc3BvbnNlDQogIHdpZmk6IHJ0dzg5OiBtYWM6IGhhbmRsZSBDMkggcmVjZWl2ZS9kb25l
IEFDSyBpbiBpbnRlcnJ1cHQgY29udGV4dA0KICB3aWZpOiBydHc4OTogc2NhbiBvZmZsb2FkIHdh
aXQgZm9yIEZXIGRvbmUgQUNLDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L2NvcmUuYyB8IDQ0ICsrKysrKysrKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L2NvcmUuaCB8IDIwICsrKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvZncuYyAgIHwgNzIgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuaCAgIHwgNzAgKysrKysrKysrKysrKystLS0tLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyAgfCA3NSArKysrKysrKysr
KysrKysrKysrKy0tLQ0KIDUgZmlsZXMgY2hhbmdlZCwgMjA4IGluc2VydGlvbnMoKyksIDczIGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMjUuMQ0K
