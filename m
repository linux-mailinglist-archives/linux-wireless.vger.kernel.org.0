Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123957BF09B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 04:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379392AbjJJCEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 22:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379391AbjJJCEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 22:04:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC978F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 19:04:32 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39A246Aa82011536, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39A246Aa82011536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:04:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 10 Oct 2023 10:04:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Oct 2023 10:04:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 10 Oct 2023 10:04:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/6] wifi: radiotap: add bandwidth definition of EHT U-SIG
Thread-Topic: [PATCH 5/6] wifi: radiotap: add bandwidth definition of EHT
 U-SIG
Thread-Index: AQHZ+FcEBfkBj4NvD0WPu3LPpGPdcLBBGVYAgACr5oA=
Date:   Tue, 10 Oct 2023 02:04:05 +0000
Message-ID: <13a339725c8d1ca75bfbc8d9ee26a957172d7c86.camel@realtek.com>
References: <20231006131327.16806-1-pkshih@realtek.com>
         <20231006131327.16806-6-pkshih@realtek.com>
         <e65522be907a2bb3094a209ec2ebe87d6302351a.camel@sipsolutions.net>
In-Reply-To: <e65522be907a2bb3094a209ec2ebe87d6302351a.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.25]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <959ACDC4EE0B3C418488E3DFCBE2A114@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDE3OjQ4ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiANCj4gT24gRnJpLCAyMDIzLTEwLTA2IGF0IDIxOjEzICswODAwLCBQaW5nLUtlIFNoaWggd3Jv
dGU6DQo+ID4gaHR0cHM6Ly93d3cucmFkaW90YXAub3JnL2ZpZWxkcy9VLVNJRy5odG1sIGRlZmlu
ZXMgYmFuZHdpZHRoIGZpZWxkIGJ1dA0KPiA+IG5vIGVudW1lcmF0b3JzIHRoZXJlLCBzbyByZWZl
cmVuY2UgdG8gdGhlIHZhbHVlcyBkZWZpbmVkIGJ5IHdpcmVzaGFyayBbMV0uDQo+ID4gDQo+ID4g
WzFdIA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS93aXJlc2hhcmsvd2lyZXNoYXJrL2Jsb2IvbWFz
dGVyL2VwYW4vZGlzc2VjdG9ycy9wYWNrZXQtaWVlZTgwMjExLXJhZGlvdGFwLmMjTDI0NjYNCj4g
PiANCj4gDQo+IFdlbGwuIFRoZSBlbnRyaWVzIGhlcmUgc2hvdWxkIGJlIGNvbWluZyBmcm9tIHRo
ZSBzcGVjLCBzZWUgVGFibGUgMzYtMjgNCj4gIlUtU0lHIGZpZWxkIG9mIGFuIEVIVCBNVSBQUERV
IiBpbiA4MDIuMTFiZSAoRDMuMCkgKG9yIDM2LTMxLCBpdCdzIHRoZQ0KPiBzYW1lIHNpbmNlIGl0
J3MgVS1TSUctMSBjb21tb24gcGFydCkuDQo+IA0KPiBTbyBtYXliZSB3ZSBzaG91bGQgZGVmaW5l
IHRoZW0gaW4gaWVlZTgwMjExLmg/DQo+IA0KPiBCdXQgYXQgdGhlIHZlcnkgbGVhc3QgSSB0aGlu
ayB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gKGFuZCBwZXJoYXBzDQo+IGNvbW1lbnRzIGluIHRoZSBj
b2RlKSBzaG91bGQgcmVmZXJlbmNlIHRoYXQsIHJhdGhlciB0aGFuIHdpcmVzaGFyaw0KPiBzb3Vy
Y2VzIDopDQo+IA0KDQpUaGFua3MuIFRoYXQgc2hvdWxkIGJlIGZyb20gODAyLjExYmUgZGVmaW5p
dGVseSwgYW5kIEkgZmVlbCB0aGVzZSBlbnRyaWVzDQppbiBkcml2ZXJzIGFyZSBvbmx5IHVzZWQg
YnkgcmFkaW90YXAgKG1vc3RseSBoYXJkd2FyZSBzaG91bGQgaGFuZGxlIHRoYXQNCmZpZWxkKSwg
c28gSSBkZWNpZGUgdG8ga2VlcCB0aGVtIGluIGllZWU4MDIxMV9yYWRpb3RhcC5oLCBhbmQgb25s
eSBtb2RpZnkNCmNvbW1pdCBtZXNzYWdlLg0KDQpQaW5nLUtlDQoNCg==
