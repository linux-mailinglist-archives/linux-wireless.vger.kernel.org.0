Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179897020C9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEOAWf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 20:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEOAWd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 20:22:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E91B1
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 17:22:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34F0MK950015126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34F0MK950015126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 15 May 2023 08:22:20 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 15 May 2023 08:22:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 May 2023 08:22:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 15 May 2023 08:22:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v4 2/2] wifi: rtl8xxxu: Rename some registers
Thread-Topic: [PATCH v4 2/2] wifi: rtl8xxxu: Rename some registers
Thread-Index: AQHZhdxJdScrg5ZRvk25qFqMov2nAa9aetbA
Date:   Mon, 15 May 2023 00:22:28 +0000
Message-ID: <4d9fdf9ac45347828449e2c7583c0732@realtek.com>
References: <7dcf9fb9-1c97-ac28-5286-2236e287a18c@gmail.com>
 <40157253-76bd-8b23-06e0-3365139b5395@gmail.com>
In-Reply-To: <40157253-76bd-8b23-06e0-3365139b5395@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTWF5IDE0LCAyMDIz
IDQ6NDggQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVz
IFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAyLzJdIHdpZmk6IHJ0bDh4eHh1OiBS
ZW5hbWUgc29tZSByZWdpc3RlcnMNCj4gDQo+IEdpdmUgcHJvcGVyIG5hbWVzOg0KPiANCj4gUkY2
MDUyX1JFR19VTktOT1dOXzU2IC0+IFJGNjA1Ml9SRUdfUEFEX1RYRw0KPiBSRjYwNTJfUkVHX1VO
S05PV05fREYgLT4gUkY2MDUyX1JFR19HQUlOX0NDQQ0KPiANCj4gQW5kIGZpeCB0eXBvczoNCj4g
DQo+IFJFR19PRkRNMF9BR0NSX1NTSV9UQUJMRSAtPiBSRUdfT0ZETTBfQUdDX1JTU0lfVEFCTEUN
Cj4gUkVHX0JCX0FDQ0VFU1NfQ1RSTCAtPiBSRUdfQkJfQUNDRVNTX0NUUkwNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K
