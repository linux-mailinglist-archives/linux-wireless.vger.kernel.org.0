Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C28612E83
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 02:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJaBII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 21:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJaBHx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 21:07:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3AB3D2D8
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 18:07:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29V16U0h8007377, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29V16U0h8007377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 31 Oct 2022 09:06:30 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 31 Oct 2022 09:07:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 31 Oct 2022 09:07:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 31 Oct 2022 09:07:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v3 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
Thread-Topic: [PATCH v3 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
Thread-Index: AQHY6uqkD22HaoyOI0ydHUeXy6NaY64ntDUA
Date:   Mon, 31 Oct 2022 01:07:05 +0000
Message-ID: <0bb9d2472fb045fb8a758cfa7fd84073@realtek.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI5
LCAyMDIyIDEyOjMxIEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYzIDEvNV0gd2lmaTogcnRsOHh4eHU6IEFkZCBjZW50cmFsIGZyZXF1ZW5jeSBvZmZzZXQg
dHJhY2tpbmcNCj4gDQo+IEFjY29yZGluZyB0byBSZWFsdGVrIHByb2dyYW1tZXJzLCAidG8gYWRq
dXN0IG9zY2lsbGF0b3IgdG8gYWxpZ24NCj4gY2VudHJhbCBmcmVxdWVuY3kgb2YgY29ubmVjdGVk
IEFQLiBUaGVuLCBpdCBjYW4geWllbGQgYmV0dGVyDQo+IHBlcmZvcm1hbmNlLiIgRnJvbSBjb21t
aXQgZmI4NTE3ZjRmYWRlICgicnR3ODg6IDg4MjJjOiBhZGQgQ0ZPDQo+IHRyYWNraW5nIikuDQo+
IA0KPiBUaGUgUlRMODE5MkNVIGFuZCBhIHZlcnNpb24gb2YgUlRMODcyM0FVIGFwcGFyZW50bHkg
ZG9uJ3QgaGF2ZSB0aGUNCj4gYWJpbGl0eSB0byBhZGp1c3QgdGhlIG9zY2lsbGF0b3IsIHNvIHRo
aXMgZG9lc24ndCBhcHBseSB0byB0aGVtLg0KPiANCj4gVGhpcyBhbHNvIGRvZXNuJ3QgYXBwbHkg
dG8gdGhlIHdpZmkgKyBibHVldG9vdGggY29tYm8gY2hpcHMgKFJUTDg3MjNBVQ0KPiBhbmQgUlRM
ODcyM0JVKSBiZWNhdXNlIHRoZSBDRk8gdHJhY2tpbmcgc2hvdWxkIG9ubHkgYmUgZG9uZSB3aGVu
DQo+IGJsdWV0b290aCBpcyBkaXNhYmxlZCwgYW5kIGRldGVybWluaW5nIHRoYXQgbG9va2VkIGNv
bXBsaWNhdGVkLg0KPiANCj4gVGhhdCBsZWF2ZXMgb25seSB0aGUgUlRMODE5MkVVIGFuZCBSVEw4
MTg4RlUgY2hpcHMuIEkgdGVzdGVkIHRoaXMgd2l0aA0KPiB0aGUgbGF0dGVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoN
ClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0N
Cj4gdjM6DQo+ICAtIE5vIGNoYW5nZS4NCj4gDQo+IHYyOg0KPiAgLSBTdWdnZXN0aW9ucyBmcm9t
IFBpbmctS2UgU2hpaDoNCj4gICAgLSBVc2UgRklFTERfUFJFUCgpLg0KPiAgICAtIExldCBwYWNr
ZXRfY291bnQgd3JhcCBhcm91bmQuDQo+ICAgIC0gVXNlIGNsYW1wKCkuDQo+IC0tLQ0KDQpbLi4u
XQ0KDQo=
