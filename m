Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C16BDDB2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 01:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCQAf4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 20:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQAfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 20:35:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786B1A4A9
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 17:35:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32H0ZbTW2028085, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32H0ZbTW2028085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 17 Mar 2023 08:35:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 08:35:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Mar 2023 08:35:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 17 Mar 2023 08:35:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     rb <rb0171610@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: New binary rtw8852b_fw.bin not loading firmware not recognized
Thread-Topic: New binary rtw8852b_fw.bin not loading firmware not recognized
Thread-Index: AQHZWFlk5g7N8N8lZkeI1EtTn3KuVa7+FaKg
Date:   Fri, 17 Mar 2023 00:35:27 +0000
Message-ID: <386367223a2547669c60f7d1dcb42b40@realtek.com>
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
In-Reply-To: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcmIgPHJiMDE3MTYxMEBn
bWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTcsIDIwMjMgNjo0OCBBTQ0KPiBUbzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IE5ldyBiaW5hcnkgcnR3
ODg1MmJfZncuYmluIG5vdCBsb2FkaW5nIGZpcm13YXJlIG5vdCByZWNvZ25pemVkDQo+IA0KPiBC
cmllZmx5LA0KPiANCj4gSSB1c2UgcnR3ODlfODg1MmJlIGluIGtlcm5lbCBkcml2ZXINCj4gDQo+
IEhBUkRXQVJFOg0KPiBOZXR3b3JrIGNvbnRyb2xsZXIgWzAyODBdOiBSZWFsdGVrIFNlbWljb25k
dWN0b3IgQ28uLCBMdGQuIERldmljZSBbMTBlYzpiODUyXQ0KPiANCj4gTGVub3ZvIElkZWFwYWQg
MWkNCj4gDQo+IElTU1VFOg0KPiBOZXdlc3QgdmVyc2lvbiBvZiBiaW5hcnkgZmlybXdhcmUgMjAy
M18wM18xMCwNCj4gcnR3ODkvcnR3ODg1MmJfZncuYmluLCB3aWxsIG5vdCBsb2FkL2Zpcm13YXJl
IG5vdCByZWNvZ25pemVkIG9uIExpbnV4IEtlcm5lbCA2LjIuNSAoYW5kIG90aGVycyk6DQo+IA0K
PiBbXSBsb2FkaW5nIGZpcm1hcmU6IHJ3dDg5L3J0dzg4NTJiX2Z3LmJpbg0KPiBbXSBydHc4OV84
ODUyYmUgMDAwMDowMzowMC4wOiBubyBzdWl0YWJsZSBmaXJtd2FyZSBmb3VuZA0KPiBbXSBydHc4
OV84ODUyYmUgMDAwMDowMzowMC4wOiBmYWlsZWQgdG8gcmVjb2duaXplIGZpcm13YXJlDQo+IA0K
PiBJc3N1ZSBwZXJzaXN0cyByZWdhcmRsZXNzIG9mIHdoaWNoIDYuMiBzZXJpZXMga2VybmVsIGlz
IHVzZWQuDQo+IA0KPiBBbGwgcHJldmlvdXMgcnd0ODkvcnR3ODg1MmJfZncuYmluIGZpcm13YXJl
IGZyb20gbGludXgtZmlybXdhcmUgMjAyM18wMl8xMCBhbmQgZWFybGllciBsb2FkcyBhbmQgd29y
a3MNCj4gY29ycmVjdGx5Lg0KPiANCj4gSSBkaWQgZmlsZSBhIGJ1ZyByZXBvcnQgd2l0aCB0aGUg
ZGV0YWlsczoNCj4gDQo+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MjE3MjA3DQo+IA0KDQpUaGUgZmlybXdhcmUgZm9ybWF0IGlzIGNoYW5nZWQsIGFuZCB3aXJl
bGVzcy1uZXh0IHRyZWUgb3IgdXBjb21pbmcgNi4zIHdpbGwNCnN1cHBvcnQgaXQuIEkgd2lsbCBh
bHNvIHBvc3QgdGhpcyBpbmZvcm1hdGlvbiBvbiB0aGUgYnVnLg0KDQpQaW5nLUtlDQoNCg==
