Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF76452B1
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 04:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLGDx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 22:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLGDxy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 22:53:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB76827168
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 19:53:53 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B73plzZ7002450, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B73plzZ7002450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 7 Dec 2022 11:51:47 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 7 Dec 2022 11:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Dec 2022 11:52:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Wed, 7 Dec 2022 11:52:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
Thread-Topic: [PATCH resend 1/3] rtlwifi: rtl8821ae: don't call kfree_skb()
 under spin_lock_irqsave()
Thread-Index: AQHZCXTBd7UL9gBmHkG5RI2in6WwBq5hxFHw//9/AACAAIdsYA==
Date:   Wed, 7 Dec 2022 03:52:33 +0000
Message-ID: <1bbd83a4cd6f48e5878c256c3e8f6334@realtek.com>
References: <20221206131249.2181693-1-yangyingliang@huawei.com>
 <20221206131249.2181693-2-yangyingliang@huawei.com>
 <758b8caa9e8243bb84471baf50706e6d@realtek.com>
 <c9096bc2-8765-8bf5-484b-da949c99e236@huawei.com>
In-Reply-To: <c9096bc2-8765-8bf5-484b-da949c99e236@huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzcg5LiK5Y2IIDAxOjI4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlhbmcgWWluZ2xpYW5nIDx5
YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgNywg
MjAyMiAxMTo0NCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBr
dmFsb0BrZXJuZWwub3JnDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IHlh
bmd5aW5nbGlhbmdAaHVhd2VpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHJlc2VuZCAxLzNd
IHJ0bHdpZmk6IHJ0bDg4MjFhZTogZG9uJ3QgY2FsbCBrZnJlZV9za2IoKSB1bmRlciBzcGluX2xv
Y2tfaXJxc2F2ZSgpDQo+IA0KPiANCj4gT24gMjAyMi8xMi83IDExOjMxLCBQaW5nLUtlIFNoaWgg
d3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFlhbmcg
WWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IERlY2VtYmVyIDYsIDIwMjIgOToxMyBQTQ0KPiA+PiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+OyBrdmFsb0BrZXJuZWwub3JnDQo+ID4+IENjOiBsaW51eC13aXJlbGVzc0B2
Z2VyLmtlcm5lbC5vcmc7IHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbQ0KPiA+PiBTdWJqZWN0OiBb
UEFUQ0ggcmVzZW5kIDEvM10gcnRsd2lmaTogcnRsODgyMWFlOiBkb24ndCBjYWxsIGtmcmVlX3Nr
YigpIHVuZGVyIHNwaW5fbG9ja19pcnFzYXZlKCkNCj4gPj4NCj4gPj4gSXQgaXMgbm90IGFsbG93
ZWQgdG8gY2FsbCBrZnJlZV9za2IoKSBmcm9tIGhhcmR3YXJlIGludGVycnVwdA0KPiA+PiBjb250
ZXh0IG9yIHdpdGggaW50ZXJydXB0cyBiZWluZyBkaXNhYmxlZC4gU28gYWRkIGFsbCBza2IgdG8N
Cj4gPj4gYSBmcmVlIGxpc3QsIHRoZW4gZnJlZSB0aGVtIGFmdGVyIHNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoKSBhdA0KPiA+PiBvbmNlLg0KPiA+IFRoZSBwYXRjaCBkb2Vzbid0IGNoYW5nZSBsb2dp
Yywgc28gaXQgc2hvdWxkIHdvcmsuIEJ1dCwgSSB3b3VsZCBsaWtlIHRvIGtub3cNCj4gPiBpZiB0
aGVyZSBpcyBhIGNvbW1lbnQgYWJvdXQgdGhpcyBpbiBrZXJuZWwgY29kZS4gQ291bGQgeW91IHBv
aW50IGl0IG91dD8NCj4gWW91IGNhbiBzZWUgY29tbWVudCBvZiBkZXZfa2ZyZWVfc2tiX2lycSgp
IGluIGluY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmgNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvaW5jbHVkZS9s
aW51eC9uZXRkZXZpY2UuaD9oPXY2DQo+IC4xLXJjOA0KPiANCg0KSXQgc2VlbXMgbGlrZSB3ZSBj
YW4gcmVwbGFjZSBrZnJlZV9za2IoKSBieSBkZXZfa2ZyZWVfc2tiX2lycSgpLCByaWdodD8NCkJ1
dCB5b3VyIG1ldGhvZCBpcyBtb3JlIGVmZmljaWVudC4gSXMgdGhhdCB5b3VyIHBvaW50Pw0KDQpQ
aW5nLUtlDQoNCg==
