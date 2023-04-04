Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD42A6D56D4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 04:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDDCjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 22:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 22:39:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9010DA
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 19:39:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3342cWtuD027973, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3342cWtuD027973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 4 Apr 2023 10:38:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 4 Apr 2023 10:38:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 4 Apr 2023 10:38:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 4 Apr 2023 10:38:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
Thread-Topic: [PATCH 2/5] wifi: rtw89: add function to wait for completion of
 TX skbs
Thread-Index: AQHZUwMd+NR5pgHPjU6+dSB+fp1fy677jXH9gAAE8zCAHfbw3oAAh2SA
Date:   Tue, 4 Apr 2023 02:38:51 +0000
Message-ID: <761e605b96d734881dc51be4679f3a04c75abb89.camel@realtek.com>
References: <20230310034631.45299-1-pkshih@realtek.com>
         <20230310034631.45299-3-pkshih@realtek.com>    <87v8j2mmqt.fsf@kernel.org>
         <360e6dd64e3645c68742fc4c603b3c2b@realtek.com> <875yadb6i1.fsf@kernel.org>
In-Reply-To: <875yadb6i1.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [111.252.133.93]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6749800CABA364EB58398F5D7CE4396@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDEzOjMyICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gSSB3b3VsZCBleHBlY3QgdGhhdCB0aGVyZSdzIHBvbGxpbmcgaWYgeW91IGFyZSB3YWl0aW5n
IHNvbWV0aGluZyBmcm9tDQo+IGhhcmR3YXJlLCBvciBtYXliZSB3aGVuIGltcGxlbWVudGluZyBh
IHNwaW4gbG9jaywgYnV0IG5vdCB3aGVuIHdhaXRpbmcNCj4gZm9yIGFub3RoZXIga2VybmVsIHRo
cmVhZC4gVGhpcyBqdXN0IGRvZXNuJ3QgZmVlbCByaWdodCBidXQgSSBkb24ndCBoYXZlDQo+IHRp
bWUgdG8gcHJvcG9zZSBhIGdvb2QgYWx0ZXJuYXRpdmUgZWl0aGVyLCBzb3JyeS4NCj4gDQoNCkkg
aGF2ZSBmb3VuZCBhIHNvbHV0aW9uIHRoYXQgdXNlcyBhbiBvd25lciB2YXJpYWJsZSB3aXRoIGEg
c3BpbiBsb2NrDQp0byBkZXRlcm1pbmUgd2hpY2ggc2lkZSB0byBmcmVlIGNvbXBsZXRpb24gb2Jq
ZWN0LiBTaW1wbHkgc2hvdyB0d28gdXNlDQpjYXNlcyBiZWxvdzoNCg0KVXNlIGNhc2UgMTogKG5v
cm1hbCBjYXNlOyBmcmVlIGNvbXBsZXRpb24gb2JqZWN0IGJ5IHdvcmsgMSkNCiAgICB3b3JrIDEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdvcmsgMg0KICAgIHdhaXQNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzcGluX2xvY2spDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wbGV0ZQ0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2sgJiBzZXQgb3duZXIgLS0+IG93bmVyID0g
d29yazENCgkJICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Bpbl91bmxvY2spDQogICAgd2Fp
dCBvaw0KICAgIChzcGluX2xvY2spDQogICAgY2hlY2sgJiBjaGVjayBvd25lciAtLT4gZnJlZSBi
eSB3b3JrIDENCiAgICAoc3Bpbl91bmxvY2spDQogICAgZnJlZSBjb21wbGV0aW9uDQoNCg0KVXNl
IGNhc2UgMjogKHRpbWVvdXQgY2FzZTsgZnJlZSBjb21wbGV0aW9uIG9iamVjdCBieSB3b3JrIDIp
DQogICAgd29yayAxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3b3JrIDINCiAgICB3
YWl0DQogICAgd2FpdCB0aW1lb3V0DQogICAgKHNwaW5fbG9jaykNCiAgICBjaGVjayAmIHNldCBv
d25lciAtLT4gb3duZXIgPSB3b3JrIDINCiAgICAoc3Bpbl91bmxvY2spDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzcGluX2xvY2spDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBsZXRpb24NCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2hlY2sgJiBzZXQgb3duZXIgLS0+IGZyZWUgYnkgd29yayAy
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzcGluX3VubG9jaykN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJlZSBjb21wbGV0aW9u
DQoNCkkgd2lsbCBhcHBseSB0aGlzIGJ5IHY1Lg0KDQpQaW5nLUtlDQoNCg==
