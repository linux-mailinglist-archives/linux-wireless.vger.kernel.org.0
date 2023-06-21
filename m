Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018F873834E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjFULYk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjFULYg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:24:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9201172C
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:24:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35LBNxRC2025252, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35LBNxRC2025252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 21 Jun 2023 19:24:00 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 21 Jun 2023 19:24:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 21 Jun 2023 19:24:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 21 Jun 2023 19:24:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "dmantipov@yandex.ru" <dmantipov@yandex.ru>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/3] [v4] wifi: rtw88: remove unused USB bulkout size set
Thread-Topic: [PATCH 3/3] [v4] wifi: rtw88: remove unused USB bulkout size set
Thread-Index: AQHZpCIIGGkIsvLkfke8qU+O4y4Tj6+Ud6wAgAAfyIA=
Date:   Wed, 21 Jun 2023 11:24:19 +0000
Message-ID: <1b30b037a2b8a404331305ce169768837818be71.camel@realtek.com>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
         <20230621092313.65965-3-dmantipov@yandex.ru>
         <20230621093032.GF18491@pengutronix.de>
In-Reply-To: <20230621093032.GF18491@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.25]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <46AF74CB13F05E4685CB7ACA043A987A@realtek.com>
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDExOjMwICswMjAwLCBTYXNjaGEgSGF1ZXIgd3JvdGU6DQo+
IA0KPiBPbiBXZWQsIEp1biAyMSwgMjAyMyBhdCAxMjoyMjoxNVBNICswMzAwLCBEbWl0cnkgQW50
aXBvdiB3cm90ZToNCj4gPiBEcm9wIG5vIGxvbmdlciB1c2VkICdidWxrb3V0X3NpemUnIG9mICdz
dHJ1Y3QgcnR3X3VzYicgYXMgd2VsbA0KPiA+IGFzIHJlbGF0ZWQgbWFjcm9zIGZyb20gdXNiLmgg
YW5kIGxlZnRvdmVycyBpbiAncnR3X3VzYl9wYXJzZSgpJy4NCj4gPiBUaGlzIGZvbGxvd3MgY29t
bWl0IDQ2MmM4ZGI2YTAxMSAoIndpZmk6IHJ0dzg4OiB1c2I6IGRyb3ANCj4gPiBub3cgdW5uZWNl
c3NhcnkgVVJCIHNpemUgY2hlY2siKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkg
QW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4NCj4gDQo+IFJldmlld2VkLWJ5OiBTYXNjaGEg
SGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IA0KDQpSZXZpZXdlZC1ieTogUGluZy1L
ZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNClsuLi5dDQoNCg0K
