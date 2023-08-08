Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B212677359E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 03:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjHHA77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 20:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHHA76 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 20:59:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E3DD171E;
        Mon,  7 Aug 2023 17:59:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3780xUkzD028838, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3780xUkzD028838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 08:59:30 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 8 Aug 2023 08:59:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 8 Aug 2023 08:59:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 8 Aug 2023 08:59:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Damian Bronecki <bronecki.damian@gmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: fix 8852AE disconnection caused by RX full flags
Thread-Topic: [PATCH] wifi: rtw89: fix 8852AE disconnection caused by RX full
 flags
Thread-Index: AQHZxsSHnOPBrFLIPUGaqDN0/DDt96/d4fSAgAG27aA=
Date:   Tue, 8 Aug 2023 00:59:46 +0000
Message-ID: <34fd2fef462c4f79812d8cbe02446bd5@realtek.com>
References: <20230804105002.5781-1-pkshih@realtek.com>
 <CAEvXze=dbg9iR2Ym2YVKcph+6QG1rx+fcQeJSdqgPN6Jrqy=8g@mail.gmail.com>
In-Reply-To: <CAEvXze=dbg9iR2Ym2YVKcph+6QG1rx+fcQeJSdqgPN6Jrqy=8g@mail.gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFtaWFuIEJyb25lY2tp
IDxicm9uZWNraS5kYW1pYW5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCA3LCAy
MDIzIDI6NDYgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBD
Yzoga3ZhbG9Aa2VybmVsLm9yZzsgU3RhYmxlQHZnZXIua2VybmVsLm9yZzsgbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0dzg5OiBm
aXggODg1MkFFIGRpc2Nvbm5lY3Rpb24gY2F1c2VkIGJ5IFJYIGZ1bGwgZmxhZ3MNCj4gDQo+ID4g
UlggZnVsbCBmbGFncyBhcmUgcmFpc2VkIGlmIGNlcnRhaW4gdHlwZXMgb2YgUlggRklGTyBhcmUg
ZnVsbCwgYW5kIHRoZW4NCj4gPiBkcm9wIGFsbCBmb2xsb3dpbmcgTVNEVSBvZiBBUE1EVS4gSW4g
b3JkZXIgdG8gcmVzdW1lIHRvIHJlY2VpdmUgTVNEVQ0KPiA+IHdoZW4gUlggRklGTyBiZWNvbWVz
IGF2YWlsYWJsZSwgd2UgY2xlYXIgdGhlIHJlZ2l0c3RlciBiaXRzIGJ5IHRoZQ0KPiA+IGNvbW1p
dCBhMGQ5OWViYjNlY2QgKCJ3aWZpOiBydHc4OTogaW5pdGlhbGl6ZSBETUEgb2YgQ01BQyIpLiBC
dXQsIDg4NTJBRQ0KPiA+IG5lZWRzIG1vcmUgc2V0dGluZ3MgdG8gc3VwcG9ydCB0aGlzLiBUbyBx
dWlja2x5IGZpeCBkaXNjb25uZWN0aW9uIHByb2JsZW0sDQo+ID4gcmV2ZXJ0IHRoZSBiZWhhdmlv
ciBhcyBiZWZvcmUuDQo+ID4NCj4gPiBGaXhlczogYTBkOTllYmIzZWNkICgid2lmaTogcnR3ODk6
IGluaXRpYWxpemUgRE1BIG9mIENNQUMiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBEYW1pYW4gQiA8YnJv
bmVja2kuZGFtaWFuQGdtYWlsLmNvbT4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3NzEwDQo+ID4gQ2M6IDxTdGFibGVAdmdlci5rZXJu
ZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlZCBjb25uZWN0aW9uIGRyb3BzIGZvciBtZS4gVGhh
bmtzIQ0KPiANCj4gVGVzdGVkLWJ5OiBEYW1pYW4gQiA8YnJvbmVja2kuZGFtaWFuQGdtYWlsLmNv
bT4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciB0ZXN0LiANCg0KRHVlIHRvIHR5cG8gb2YgY29tbWl0
IG1lc3NhZ2UsIEkgc2VudCB2MiB3aXRoIHRoZSBUZXN0ZWQtYnkuDQoNClBpbmctS2UNCg0KDQo=
