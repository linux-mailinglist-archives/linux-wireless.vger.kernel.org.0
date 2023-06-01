Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737F719C20
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFAM2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAM2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 08:28:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD66119
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 05:28:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 351CS6XE0007181, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 351CS6XE0007181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 20:28:06 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 1 Jun 2023 20:28:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 1 Jun 2023 20:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 20:28:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] [v5] wifi: rtlwifi: remove unused timer and related code
Thread-Topic: [PATCH] [v5] wifi: rtlwifi: remove unused timer and related code
Thread-Index: AQHZlGZiF4N8NKxyU0G+QcjrKH/AC691WiCA
Date:   Thu, 1 Jun 2023 12:28:19 +0000
Message-ID: <b3f86a03bbdf60078f03859df6deb5b572808729.camel@realtek.com>
References: <20230601083103.45862-1-dmantipov@yandex.ru>
         <20230601085144.6545-1-dmantipov@yandex.ru>
In-Reply-To: <20230601085144.6545-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.22.87]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01BBEA6E5D89A408D64D9C5B8E40889@realtek.com>
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

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDExOjUxICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gDQo+IERyb3AgdW51c2VkICdkdWFsbWFjX2Vhc3ljb25jdXJyZW50X3JldHJ5dGltZXInIG9m
ICdzdHJ1Y3QgcnRsX3dvcmtzJywNCj4gY29ycmVzcG9uZGluZyAncnRsX2Vhc3lfY29uY3VycmVu
dF9yZXRyeXRpbWVyX2NhbGxiYWNrKCknIGhhbmRsZXIsDQo+ICdkdWFsbWFjX2Vhc3lfY29uY3Vy
cmVudCcgZnVuY3Rpb24gcG9pbnRlciBvZiAnc3RydWN0IHJ0bF9oYWxfb3BzJw0KPiBhbmQgcmVs
YXRlZCBjYWxsIHRvICd0aW1lcl9zZXR1cCgpJyBpbiAnX3J0bF9pbml0X2RlZmVycmVkX3dvcmso
KScuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRl
eC5ydT4NCg0KIA0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQoNCg==
