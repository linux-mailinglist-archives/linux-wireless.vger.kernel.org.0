Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D466DDB8D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDKNCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 09:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDKNCr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 09:02:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB04EEB
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 06:02:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33BD1F150028891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33BD1F150028891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Apr 2023 21:01:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 11 Apr 2023 21:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 11 Apr 2023 21:01:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Tue, 11 Apr 2023 21:01:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
Thread-Topic: [PATCH 2/5] wifi: rtw89: add function to wait for completion of
 TX skbs
Thread-Index: AQHZUwMd+NR5pgHPjU6+dSB+fp1fy677jXH9gAAE8zCAHfbw3oAAh2SAgAuuoIA=
Date:   Tue, 11 Apr 2023 13:01:36 +0000
Message-ID: <56831ba4f216daee09b3d9c9a7deaf5810cade34.camel@realtek.com>
References: <20230310034631.45299-1-pkshih@realtek.com>
         <20230310034631.45299-3-pkshih@realtek.com>    <87v8j2mmqt.fsf@kernel.org>
         <360e6dd64e3645c68742fc4c603b3c2b@realtek.com> <875yadb6i1.fsf@kernel.org>
         <761e605b96d734881dc51be4679f3a04c75abb89.camel@realtek.com>
In-Reply-To: <761e605b96d734881dc51be4679f3a04c75abb89.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.20.144]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <480CB474A7D17744BEC278A44D08C34F@realtek.com>
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

T24gVHVlLCAyMDIzLTA0LTA0IGF0IDEwOjM3ICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMy0wNC0wMyBhdCAxMzozMiArMDMwMCwgS2FsbGUgVmFsbyB3cm90ZToNCj4g
PiBJIHdvdWxkIGV4cGVjdCB0aGF0IHRoZXJlJ3MgcG9sbGluZyBpZiB5b3UgYXJlIHdhaXRpbmcg
c29tZXRoaW5nIGZyb20NCj4gPiBoYXJkd2FyZSwgb3IgbWF5YmUgd2hlbiBpbXBsZW1lbnRpbmcg
YSBzcGluIGxvY2ssIGJ1dCBub3Qgd2hlbiB3YWl0aW5nDQo+ID4gZm9yIGFub3RoZXIga2VybmVs
IHRocmVhZC4gVGhpcyBqdXN0IGRvZXNuJ3QgZmVlbCByaWdodCBidXQgSSBkb24ndCBoYXZlDQo+
ID4gdGltZSB0byBwcm9wb3NlIGEgZ29vZCBhbHRlcm5hdGl2ZSBlaXRoZXIsIHNvcnJ5Lg0KPiA+
IA0KPiANCj4gSSBoYXZlIGZvdW5kIGEgc29sdXRpb24gdGhhdCB1c2VzIGFuIG93bmVyIHZhcmlh
YmxlIHdpdGggYSBzcGluIGxvY2sNCj4gdG8gZGV0ZXJtaW5lIHdoaWNoIHNpZGUgdG8gZnJlZSBj
b21wbGV0aW9uIG9iamVjdC4gU2ltcGx5IHNob3cgdHdvIHVzZQ0KPiBjYXNlcyBiZWxvdzoNCj4g
DQo+IFVzZSBjYXNlIDE6IChub3JtYWwgY2FzZTsgZnJlZSBjb21wbGV0aW9uIG9iamVjdCBieSB3
b3JrIDEpDQo+ICAgICB3b3JrIDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdvcmsg
Mg0KPiAgICAgd2FpdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoc3Bpbl9sb2NrKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb21wbGV0ZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
aGVjayAmIHNldCBvd25lciAtLT4gb3duZXIgPSB3b3JrMQ0KPiAJCSAgICAgICAgICAgICAgICAg
ICAgICAgICAgKHNwaW5fdW5sb2NrKQ0KPiAgICAgd2FpdCBvaw0KPiAgICAgKHNwaW5fbG9jaykN
Cj4gICAgIGNoZWNrICYgY2hlY2sgb3duZXIgLS0+IGZyZWUgYnkgd29yayAxDQo+ICAgICAoc3Bp
bl91bmxvY2spDQo+ICAgICBmcmVlIGNvbXBsZXRpb24NCj4gDQo+IA0KPiBVc2UgY2FzZSAyOiAo
dGltZW91dCBjYXNlOyBmcmVlIGNvbXBsZXRpb24gb2JqZWN0IGJ5IHdvcmsgMikNCj4gICAgIHdv
cmsgMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29yayAyDQo+ICAgICB3YWl0DQo+
ICAgICB3YWl0IHRpbWVvdXQNCj4gICAgIChzcGluX2xvY2spDQo+ICAgICBjaGVjayAmIHNldCBv
d25lciAtLT4gb3duZXIgPSB3b3JrIDINCj4gICAgIChzcGluX3VubG9jaykNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Bpbl9sb2NrKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBsZXRpb24NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGVjayAmIHNldCBvd25lciAtLT4gZnJlZSBi
eSB3b3JrIDINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Bp
bl91bmxvY2spDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJl
ZSBjb21wbGV0aW9uDQo+IA0KPiBJIHdpbGwgYXBwbHkgdGhpcyBieSB2NS4NCj4gDQoNCldlIGhh
dmUgYSBiZXR0ZXIgaWRlYSB0aGF0IHVzZSBrZnJlZV9yY3UoKSB0byBmcmVlIGNvbXBsZXRpb24s
IHNvIG5vDQpuZWVkIHNwaW5fbG9jaygpLiBUaGVuLCB0aGUgdXNlIGNhc2VzIGJlY29tZSBiZWxv
dywgYW5kIEkgaGF2ZSBzZW50DQp0aGlzIGNoYW5nZSBieSB2Ni4NCg0KVXNlIGNhc2UgMTogKG5v
cm1hbCBjYXNlKQ0KICAgIHdvcmsgMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29y
ayAyDQogICAgKHJjdV9hc3NpZ25fcG9pbnRlcih3YWl0KSkNCiAgICB3YWl0DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAocmN1X3JlYWRfbG9jaykNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdhaXQgPSByY3VfZGVyZWZlcmVuY2Uo
KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh3YWl0KSAg
ICAtLT4gd2FpdCAhPSBOVUxMDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGxldGUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChyY3VfcmVhZF91bmxvY2spDQogICAgd2FpdCBvaw0KICAgIChyY3VfYXNzaWduX3BvaW50
ZXIoTlVMTCkpDQogICAga2ZyZWVfcmN1KGNvbXBsZXRpb24pDQoNCg0KVXNlIGNhc2UgMjogKHRp
bWVvdXQgY2FzZSkNCiAgICB3b3JrIDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdv
cmsgMg0KICAgIChyY3VfYXNzaWduX3BvaW50ZXIod2FpdCkpDQogICAgd2FpdA0KICAgIHdhaXQg
dGltZW91dA0KICAgIChyY3VfYXNzaWduX3BvaW50ZXIoTlVMTCkpDQogICAga2ZyZWVfcmN1KGNv
bXBsZXRpb24pDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAocmN1
X3JlYWRfbG9jaykNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdh
aXQgPSByY3VfZGVyZWZlcmVuY2UoKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmICh3YWl0KSAgICAtLT4gd2FpdCA9PSBOVUxMDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGxldGUNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIChyY3VfcmVhZF91bmxvY2spDQoNCg0KUGluZy1LZQ0K
DQo=
