Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD26E563D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDRBOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDRBOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 21:14:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3A3A8C
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 18:14:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I1E2gxC019624, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I1E2gxC019624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 09:14:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Apr 2023 09:14:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Apr 2023 09:14:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 18 Apr 2023 09:14:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 2/3] wifi: rtl8xxxu: Add rtl8xxxu_write{8,16,32}_{set,clear}
Thread-Topic: [PATCH 2/3] wifi: rtl8xxxu: Add
 rtl8xxxu_write{8,16,32}_{set,clear}
Thread-Index: AQHZcU8P8tI4B3UFl06c+BxWSUXw9a8wQ2BA
Date:   Tue, 18 Apr 2023 01:14:02 +0000
Message-ID: <364968c8959340f1a4139ae0b818d962@realtek.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
 <9430b841-1048-b27c-14ec-fca447dc32af@gmail.com>
In-Reply-To: <9430b841-1048-b27c-14ec-fca447dc32af@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE4LCAy
MDIzIDE6MDcgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAyLzNdIHdpZmk6IHJ0bDh4eHh1OiBB
ZGQgcnRsOHh4eHVfd3JpdGV7OCwxNiwzMn1fe3NldCxjbGVhcn0NCj4gDQo+IEFsc28gYWRkIHJ0
bDh4eHh1X3dyaXRlMzJfbWFzaywgcnRsOHh4eHVfd3JpdGVfcmZyZWdfbWFzay4NCj4gDQo+IFRo
ZXNlIGhlbHBlciBmdW5jdGlvbnMgbWFrZSBpdCBlYXNpZXIgdG8gbW9kaWZ5IG9ubHkgcGFydHMg
b2YgYSByZWdpc3Rlcg0KPiBieSBlbGltaW5hdGluZyB0aGUgY2FsbCB0byB0aGUgcmVnaXN0ZXIg
cmVhZGluZyBmdW5jdGlvbiBhbmQgdGhlIGJpdA0KPiBtYW5pcHVsYXRpb25zLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoN
ClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4uLl0N
Cg0K
