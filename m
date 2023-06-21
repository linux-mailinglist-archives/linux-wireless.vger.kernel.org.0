Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17EE7382FB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjFULYH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFULX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:23:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A9C41991
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:23:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35LBNGI90024734, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35LBNGI90024734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 21 Jun 2023 19:23:16 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 21 Jun 2023 19:23:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Jun 2023 19:23:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 21 Jun 2023 19:23:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] [v4] wifi: rtw88: remove unused and set but unused leftovers
Thread-Topic: [PATCH 2/3] [v4] wifi: rtw88: remove unused and set but unused
 leftovers
Thread-Index: AQHZpCIIySSWIlbw2UeHneRAjKkd2a+Ul0AA
Date:   Wed, 21 Jun 2023 11:23:36 +0000
Message-ID: <07f423018a29279a01432f92b11e30dbea846a59.camel@realtek.com>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
         <20230621092313.65965-2-dmantipov@yandex.ru>
In-Reply-To: <20230621092313.65965-2-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.25]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FFF6D641659094FB340F1C6AE7E3054@realtek.com>
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDEyOjIyICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IERyb3AgdW51c2VkIGFuZCBzZXQgYnV0IHVudXNlZCAnbGFzdF9wdXNoJyBvZiAnc3Ry
dWN0IHJ0d190eHEnLA0KPiAnd2lyZWxlc3Nfc2V0JyBvZiAnc3RydWN0IHJ0d19zdGFfaW5mbycs
ICd1c2JfdHhhZ2dfbnVtJyBvZg0KPiAnc3RydWN0IHJ0d191c2InIGFuZCAnbicgb2YgJ3N0cnVj
dCByeF91c2JfY3RybF9ibG9jaycsIGFkanVzdA0KPiByZWxhdGVkIGNvZGUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4NCg0KUmV2aWV3
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQpbLi4uXQ0KDQoNCg0K
