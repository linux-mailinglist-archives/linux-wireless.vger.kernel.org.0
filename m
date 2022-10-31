Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74723612E85
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJaBIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJaBI2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 21:08:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC334A194
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 18:08:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29V17LUE0008995, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29V17LUE0008995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 31 Oct 2022 09:07:21 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 31 Oct 2022 09:07:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 31 Oct 2022 09:07:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Mon, 31 Oct 2022 09:07:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v3 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Thread-Topic: [PATCH v3 2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
Thread-Index: AQHY6uuGA3yGzo5p9k+BNIGrUMT+lq4ntGOw
Date:   Mon, 31 Oct 2022 01:07:56 +0000
Message-ID: <3c5c02b734b646bf95315defc9644710@realtek.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
 <69627c1a-7e85-ff97-ac4e-7097c3ed91b6@gmail.com>
In-Reply-To: <69627c1a-7e85-ff97-ac4e-7097c3ed91b6@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzMwIOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI5
LCAyMDIyIDEyOjM2IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYzIDIvNV0gd2lmaTogcnRsOHh4eHU6IEZpeCB0aGUgQ0NLIFJTU0kgY2FsY3VsYXRpb24N
Cj4gDQo+IFRoZSBDQ0sgUlNTSSBjYWxjdWxhdGlvbiBpcyBpbmNvcnJlY3QgZm9yIHRoZSBSVEw4
NzIzQlUsIFJUTDgxOTJFVSwNCj4gYW5kIFJUTDgxODhGVS4gQWRkIG5ldyBmdW5jdGlvbnMgZm9y
IHRoZXNlIGNoaXBzIHdpdGggY29kZSBjb3BpZWQgZnJvbQ0KPiB0aGVpciB2ZW5kb3IgZHJpdmVy
cy4gVXNlIHRoZSBvbGQgY29kZSBvbmx5IGZvciB0aGUgUlRMODcyM0FVIGFuZA0KPiBSVEw4MTky
Q1UuDQo+IA0KPiBJIGRpZG4ndCBub3RpY2UgYW55IGRpZmZlcmVuY2UgaW4gdGhlIHJlcG9ydGVk
IHNpZ25hbCBzdHJlbmd0aCB3aXRoIG15DQo+IFJUTDgxODhGVSwgYnV0IEkgZGlkbid0IGxvb2sg
dmVyeSBoYXJkIGVpdGhlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IHYzOg0KPiAgLSBGZWVkYmFjayBmcm9tIFBp
bmctS2UgU2hpaDoNCj4gICAgLSBVc2UgdGhlIG5hbWUgUkVHX0FHQ19SUFQgZm9yIHJlZ2lzdGVy
IDB4YTgwLg0KPiAgICAtIFVzZSB0aGUgbmFtZSBBR0NfUlBUX0NDSyBmb3IgYml0IDcgb2YgUkVH
X0FHQ19SUFQuDQo+IA0KPiB2MjoNCj4gIC0gTm8gY2hhbmdlLg0KPiAtLS0NCg0KDQpbLi4uXQ0K
DQo=
