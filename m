Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EDF612E8D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 02:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJaBI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 21:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJaBIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 21:08:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82AFABE30
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 18:08:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29V18BuS4009768, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29V18BuS4009768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 31 Oct 2022 09:08:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 31 Oct 2022 09:08:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 31 Oct 2022 09:08:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 31 Oct 2022 09:08:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v3 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Thread-Topic: [PATCH v3 4/5] wifi: rtl8xxxu: Set
 IEEE80211_HW_SUPPORT_FAST_XMIT
Thread-Index: AQHY6uvFc5RjH8OxpkqerVUQ2rCZgq4ntLtA
Date:   Mon, 31 Oct 2022 01:08:46 +0000
Message-ID: <1b05a1042c7f48dca928563066cd342e@realtek.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
 <fd9bec2a-466c-4670-068f-e2aea101f2de@gmail.com>
In-Reply-To: <fd9bec2a-466c-4670-068f-e2aea101f2de@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzMwIOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI5
LCAyMDIyIDEyOjM5IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYzIDQvNV0gd2lmaTogcnRsOHh4eHU6IFNldCBJRUVFODAyMTFfSFdfU1VQUE9SVF9GQVNU
X1hNSVQNCj4gDQo+IEFjY29yZGluZyB0byBjb21taXQgNjBkNzkwMGRjYjk4ICgid2xjb3JlOiBl
bmFibGUNCj4gSUVFRTgwMjExX0hXX1NVUFBPUlRfRkFTVF9YTUlUIiksIHdlIGNhbiB1c2UgdGhp
cyBiZWNhdXNlIGFsbCB0aGUgY2hpcHMNCj4gaGF2ZSBoYXJkd2FyZSByYXRlIGNvbnRyb2wuDQo+
IA0KPiBUaGlzIGlzIG9uZSBvZiB0aGUgdGhpbmdzIG1hYzgwMjExIHJlcXVpcmVzIGJlZm9yZSBp
dCB3aWxsIGhhbmRsZSBNU0RVDQo+IGFnZ3JlZ2F0aW9uIGZvciB1cy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZp
ZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYz
Og0KPiAgLSBObyBjaGFuZ2UuDQo+IA0KPiB2MjoNCj4gIC0gTm8gY2hhbmdlLg0KPiAtLS0NCg0K
DQpbLi4uXQ0KDQo=
