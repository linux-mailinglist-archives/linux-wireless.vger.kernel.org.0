Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293097DDA63
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbjKAAwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbjKAAwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 20:52:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7A10F
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 17:52:28 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A10qNMZ1806100, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A10qNMZ1806100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 08:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 08:52:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 1 Nov 2023 08:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 1 Nov 2023 08:52:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     4javier <4javiereg4@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Realtek 8852BE: bluetooth interference with wifi power_save enabled on Linux
Thread-Topic: Realtek 8852BE: bluetooth interference with wifi power_save
 enabled on Linux
Thread-Index: AQHZ9iGZXhdWbqhTSEKwYSVIW4Yvo7BkzjXw
Date:   Wed, 1 Nov 2023 00:52:23 +0000
Message-ID: <58cbb526061446d6b236dd83a6a77b96@realtek.com>
References: <CAKPbyNCpkGB3e3adK1+kPrQnGq6dfO8cEEUyULowgaMu4c_9jg@mail.gmail.com>
In-Reply-To: <CAKPbyNCpkGB3e3adK1+kPrQnGq6dfO8cEEUyULowgaMu4c_9jg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogNGphdmllciA8NGphdmll
cmVnNEBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA0LCAyMDIzIDE6NDcg
QU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZWFs
dGVrIDg4NTJCRTogYmx1ZXRvb3RoIGludGVyZmVyZW5jZSB3aXRoIHdpZmkgcG93ZXJfc2F2ZSBl
bmFibGVkIG9uIExpbnV4DQo+IA0KPiANCj4gR29vZCBtb3JuaW5nDQo+IA0KPiBJJ20gZXhwZXJp
ZW5jaW5nIGlzc3VlcyB3aXRoIHRoaXMgUmVhbHRlayBXaUZpL0JUIGNvbWIgY2hpcCBvbiBhbiBI
UCA0NzAgRzkuDQo+IE15IGJsdWV0b290aCBkZXZpY2UgZ2V0cyBjaG9wcHkgYXVkaW8gd2hlbiB3
aWZpX3Bvd2Vyc2F2ZSBpcyBvbi4NCg0KSSBoYXZlIHVwbG9hZGVkIG5ldyBmaXJtd2FyZSBbMV0g
dGhhdCBJIHN1cHBvc2UgaXQgY2FuIGZpeCB0aGlzIHByb2JsZW0uIFBsZWFzZQ0KZG93bmxvYWQg
YW5kIGNvcHkgaXQgdG8gL2xpYi9maXJtd2FyZS9ydHc4OS9ydHc4ODUyYl9mdy0xLmJpbg0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvYmFlZDNmYzM0NzI2OWMz
ZGQzNDI0NGYzNDk0NmUwOWRmZjE4MzgyNS5jYW1lbEByZWFsdGVrLmNvbS9ULyN1DQoNClBpbmct
S2UNCg0K
