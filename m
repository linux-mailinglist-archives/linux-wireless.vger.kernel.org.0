Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE46EEE85
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbjDZGtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZGt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:49:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902710EB
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 23:49:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33Q6nF5L1023181, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33Q6nF5L1023181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 26 Apr 2023 14:49:15 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 26 Apr 2023 14:49:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 26 Apr 2023 14:49:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 26 Apr 2023 14:49:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
Thread-Index: AQHZd5tasrPlKIiNeUKI8XDI8zOKla87+iOAgAEsD4A=
Date:   Wed, 26 Apr 2023 06:49:16 +0000
Message-ID: <c9902f6b088b4b40bc4b9e0426f6a1fc@realtek.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
 <c5efcbd258282c05ba0d15210ea325c5bf36b94c.camel@sipsolutions.net>
In-Reply-To: <c5efcbd258282c05ba0d15210ea325c5bf36b94c.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyNiwg
MjAyMyA0OjUyIEFNDQo+IFRvOiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2Vu
IDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0bDh4eHh1OiBTdXBwb3J0IG5ldyBj
aGlwIFJUTDgxOTJGVQ0KPiANCj4gDQo+IExvb2tzIGxpa2UgeW91J3JlIGFkZGluZyBydGx3aWZp
L3J0bDgxOTJmdWZ3LmJpbiBhbmQgSSBndWVzcyB0aGF0J3MNCj4gbWFpbnRhaW5lZCBieSBzb21l
b25lIGluIFJlYWx0ZWssIHNvIHBlcmhhcHMgaXQgbWFrZXMgbGVzcyBzZW5zZSB0bw0KPiBhdHRh
Y2ggdGhlIHRhYmxlcyB0byB0aGUgc2FtZSBmaWxlLg0KPiANCg0KWWVzLCB1c2UgYSBzZXBhcmF0
ZSBmaWxlIHdpbGwgYmUgYmV0dGVyLiBMaW51eCBmaXJtd2FyZSBtYWludGFpbmVyIEpvc2ggYXNr
ZWQNClJlYWx0ZWsgcGVvcGxlIHRvIHN1Ym1pdCBSZWFsdGVrIGZpcm13YXJlLCBhbmQgdGhlIHBl
b3BsZSBpcyBtZSBub3JtYWxseS4NCkJlZm9yZSBzdWJtaXR0aW5nLCBJIG5lZWQgdG8gY2hlY2sg
ZmlybXdhcmUgaXMgaWRlbnRpY2FsIGFzIGV4cGVjdGF0aW9uLg0KV2l0aCBpbmRpdmlkdWFsIGZp
cm13YXJlLCBJIGNhbiB1c2UgbWQ1c3VtIHRvIGNoZWNrIHRoZW0gcXVpY2tseS4NCg0KUGluZy1L
ZQ0KDQoNCg==
