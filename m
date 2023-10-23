Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781697D2888
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 04:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjJWC3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 22:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJWC3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 22:29:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343FE6
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 19:29:51 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39N2TkhZ62651633, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39N2TkhZ62651633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 10:29:46 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 23 Oct 2023 10:29:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Oct 2023 10:29:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 23 Oct 2023 10:29:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: On EDCCA control in rtlwifi
Thread-Topic: On EDCCA control in rtlwifi
Thread-Index: AQHaBOwXhDluU+APuE+XL71P5h+TLrBWpkiw
Date:   Mon, 23 Oct 2023 02:29:46 +0000
Message-ID: <de2a980043f74d4fb151b0fcbac379d4@realtek.com>
References: <df9c1998-70ed-4bf8-95cc-9d851d7ccfcd@yandex.ru>
In-Reply-To: <df9c1998-70ed-4bf8-95cc-9d851d7ccfcd@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.71.113]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
PGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IFNlbnQ6IFN1bmRheSwgT2N0b2JlciAyMiwgMjAyMyA5
OjMxIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBPbiBFRENDQSBjb250cm9s
IGluIHJ0bHdpZmkNCj4gDQo+IEkndmUgbm90aWNlZCB0aGF0ICdydGw5MmVlX2RtX2R5bmFtaWNf
ZWRjY2EoKScgYW5kICdydGw4NzIzYmVfZG1fZHluYW1pY19lZGNjYSgpJw0KPiBhcmUgYWxtb3N0
IGlkZW50aWNhbCBhbmQgYm90aCBkZXBlbmRzIG9uICdwcmVfZWRjY2FfZW5hYmxlJyBvZiAnc3Ry
dWN0IHJ0bF9oYWwnLA0KPiBidXQgb25seSB0aGUgZmlyc3Qgb25lIGNhbiB0b2dnbGUgaXQuIElz
bid0IGl0IGEgYnVnIHNvbWV3aGVyZT8NCj4gDQoNCkV2ZXJ5IGNoaXAgaGFzIGl0cyBoYXJkd2Fy
ZSBjaGFyYWN0ZXJpc3RpYywgc28gaXQgbWF5IGRvIHRoYXQgaW50ZW50aW9uYWxseSwgYW5kDQpJ
IGNhbid0IGZpbmQgdGhlIHJlYXNvbiB3aHkgcGVvcGxlIGRpZCB0aGlzLiBJIHN1Z2dlc3Qgd2Ug
ZG9uJ3QgdG91Y2ggRURDQ0EsDQpiZWNhdXNlIGV2ZW4gSSBoYXZlIGEgaGFyZHdhcmUsIEkgc3Rp
bGwgY2FuJ3QgY29uZmlybSB0ZXN0IHJlc3VsdCBpcyBwb3NpdGl2ZQ0KZm9yIHRoZSBjYXNlIHRo
ZSBjb2RlIGludGVuZHMgdG8gZG8uIA0KDQpQaW5nLUtlDQoNCg==
