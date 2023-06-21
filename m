Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4409D7382E6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFULZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjFULZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:25:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20029135
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:25:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35LBPN9A0027196, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35LBPN9A0027196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 21 Jun 2023 19:25:23 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 21 Jun 2023 19:25:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 21 Jun 2023 19:25:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 21 Jun 2023 19:25:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] [v4] wifi: rtw88: delete timer and free skb queue when unloading
Thread-Topic: [PATCH 1/3] [v4] wifi: rtw88: delete timer and free skb queue
 when unloading
Thread-Index: AQHZpCIHrL40d7wEp02hNp6w9+wjQ6+UlviAgAAA4IA=
Date:   Wed, 21 Jun 2023 11:25:43 +0000
Message-ID: <375301a4de81b1059429824ea694e224d3c67d19.camel@realtek.com>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
         <9fdea7c3c26ede8e744b50dba008cef8da866d09.camel@realtek.com>
In-Reply-To: <9fdea7c3c26ede8e744b50dba008cef8da866d09.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.25]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <056CE3D0E98615438C6F0410E2BDE08F@realtek.com>
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDExOjIyICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIFdlZCwgMjAyMy0wNi0yMSBhdCAxMjoyMiArMDMwMCwgRG1pdHJ5IEFudGlwb3Ygd3JvdGU6
DQo+ID4gRml4IHBvc3NpYmxlIGNyYXNoIGFuZCBtZW1vcnkgbGVhayBvbiBkcml2ZXIgdW5sb2Fk
IGJ5IGRlbGV0aW5nDQo+ID4gVFggcHVyZ2UgdGltZXIgYW5kIGZyZWVpbmcgQzJIIHF1ZXVlIGlu
ICdydHdfY29yZV9kZWluaXQoKScsDQo+ID4gc2hyaW5rIGNyaXRpY2FsIHNlY3Rpb24gaW4gdGhl
IGxhdHRlciBieSBmcmVlaW5nIENPRVggcXVldWUNCj4gPiBvdXQgb2YgVFggcmVwb3J0IGxvY2sg
c2NvcGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBv
dkB5YW5kZXgucnU+DQo+IA0KPiBBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQo+IA0KDQpTb3JyeSwgSSdtIG5vdCBtYWludGFpbmVyIG9mIHJ0dzg4LCBzbyBJIHNo
b3VsZCBhZGQgcmV2aWV3ZWQtYnkuDQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hp
aEByZWFsdGVrLmNvbT4NCg0KDQo=
