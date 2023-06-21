Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBF7382BF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjFULX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjFULXv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:23:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12B5E170F
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:23:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35LBMFPt8024612, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35LBMFPt8024612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 21 Jun 2023 19:22:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 21 Jun 2023 19:22:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 21 Jun 2023 19:22:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 21 Jun 2023 19:22:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] [v4] wifi: rtw88: delete timer and free skb queue when unloading
Thread-Topic: [PATCH 1/3] [v4] wifi: rtw88: delete timer and free skb queue
 when unloading
Thread-Index: AQHZpCIHrL40d7wEp02hNp6w9+wjQ6+UlviA
Date:   Wed, 21 Jun 2023 11:22:36 +0000
Message-ID: <9fdea7c3c26ede8e744b50dba008cef8da866d09.camel@realtek.com>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
In-Reply-To: <20230621092313.65965-1-dmantipov@yandex.ru>
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
Content-ID: <08A3CF83C3D98043956EAD41A79D77A6@realtek.com>
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDEyOjIyICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IEZpeCBwb3NzaWJsZSBjcmFzaCBhbmQgbWVtb3J5IGxlYWsgb24gZHJpdmVyIHVubG9h
ZCBieSBkZWxldGluZw0KPiBUWCBwdXJnZSB0aW1lciBhbmQgZnJlZWluZyBDMkggcXVldWUgaW4g
J3J0d19jb3JlX2RlaW5pdCgpJywNCj4gc2hyaW5rIGNyaXRpY2FsIHNlY3Rpb24gaW4gdGhlIGxh
dHRlciBieSBmcmVlaW5nIENPRVggcXVldWUNCj4gb3V0IG9mIFRYIHJlcG9ydCBsb2NrIHNjb3Bl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgu
cnU+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4u
Ll0NCg0KDQoNCg==
