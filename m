Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410A6FA2BA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEHI70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjEHI7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:59:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCB18DC8
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:59:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488x6m05026370, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488x6m05026370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:59:06 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 May 2023 16:59:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 8 May 2023 16:59:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 8 May 2023 16:59:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: RCU WARNING Splat from rtw8822bu
Thread-Topic: RCU WARNING Splat from rtw8822bu
Thread-Index: AQHZgRmGn3prOveaRE+ga6xN3f/Wjq9PiKrg//9+noCAAQzUEA==
Date:   Mon, 8 May 2023 08:59:11 +0000
Message-ID: <51ff479741ea4ff88cd317f193acf7db@realtek.com>
References: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
 <3c2eabc6fc89496fb7e200d0710ba2f2@realtek.com>
 <f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net>
In-Reply-To: <f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IE1vbmRheSwgTWF5IDgsIDIwMjMgODo1NiBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENj
OiBsaW51eC13aXJlbGVzcyA8bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSZTogUkNVIFdBUk5JTkcgU3BsYXQgZnJvbSBydHc4ODIyYnUNCj4gDQo+IE9uIDUvNy8y
MyAxOTo0OSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IFRoZSBpZWVlODAyMTFfb3BzOjpzdGFf
cmNfdXBkYXRlIG11c3QgYmUgYXRvbWljLCBiZWNhdXNlIGllZWU4MDIxMV9jaGFuX2J3X2NoYW5n
ZSgpDQo+ID4gaG9sZHMgcmN1X3JlYWQgbG9jayB3aGlsZSBjYWxsaW5nIGRydl9zdGFfcmNfdXBk
YXRlKCksIHNvIEkgdGhpbmsgYSBzaW1wbGUgd2F5IGlzDQo+ID4gdG8gY3JlYXRlIGEgd29yayB0
byBkbyBvcmlnaW5hbCB0aGluZ3MuIEkgd2lsbCBtYWtlIGEgZml4IGxhdGVyLg0KPiANCj4gVGhh
bmtzLg0KPiANCj4gSSBmb3Jnb3QgdG8gc2F5IHRoYXQgdGhlIFdBUk5JTkcgZGlkIG5vdCBjYXVz
ZSB0aGUgd2lmaSBjb25uZWN0aW9uIHRvIGJlDQo+IGRyb3BwZWQsIHRodXMgdGhlIGlzc3VlIGlz
IG9uZSBvZiBsb2cgc3BhbW1pbmcsIG5vdCBzdGFiaWxpdHkuDQo+IA0KDQpJIGhhdmUgc2VudCBh
IGZpeCBbMV0uIFBsZWFzZSB0cnkgaWYgaXQgd29ya3MgaW4geW91ciBzaWRlLg0KDQpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyMzA1MDgwODU0MjkuNDY2NTMt
MS1wa3NoaWhAcmVhbHRlay5jb20vVC8jdQ0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0K
