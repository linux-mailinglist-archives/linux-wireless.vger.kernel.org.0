Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67C7125AA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbjEZLgw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjEZLgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 07:36:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1419C
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 04:36:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34QBY6wkC020641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34QBY6wkC020641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 26 May 2023 19:34:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 26 May 2023 19:34:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 May 2023 19:34:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 26 May 2023 19:34:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "g0000ga@gmail.com" <g0000ga@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andreas@fatal.se" <andreas@fatal.se>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "linux@ulli-kroll.de" <linux@ulli-kroll.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "morrownr@gmail.com" <morrownr@gmail.com>,
        "petter@technux.se" <petter@technux.se>,
        "tpkuester@gmail.com" <tpkuester@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
Thread-Topic: [PATCH] wifi: rtw88: usb: silence log flooding error message
Thread-Index: AQHZjiwhpaOYDLChaE6ysR4gEzG9Hq9qJPMQgAGizoCAACHEAA==
Date:   Fri, 26 May 2023 11:34:17 +0000
Message-ID: <8fcb481dae3114ddf18590d5aaa3a87f0c379887.camel@realtek.com>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
         <290b05447cc542a9b35c25ff89ba8ff3@realtek.com>
         <20230526093319.GR17518@pengutronix.de>
In-Reply-To: <20230526093319.GR17518@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.76.140]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFB4A2C60D03BE42AE2E237D2D5830DB@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDExOjMzICswMjAwLCBTYXNjaGEgSGF1ZXIgd3JvdGU6DQo+
IA0KPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMjo0NToyM0FNICswMDAwLCBQaW5nLUtlIFNo
aWggd3JvdGU6DQo+ID4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMjQsIDIwMjMgNjo0MCBQTQ0KPiA+ID4gVG86IGxpbnV4LXdpcmVsZXNz
IDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gPiBDYzogSGFucyBVbGxpIEty
b2xsIDxsaW51eEB1bGxpLWtyb2xsLmRlPjsgTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdm
aW5nZXIubmV0PjsgUGluZy1LZQ0KPiA+ID4gU2hpaA0KPiA+ID4gPHBrc2hpaEByZWFsdGVrLmNv
bT47IFRpbSBLIDx0cGt1ZXN0ZXJAZ21haWwuY29tPjsgQWxleCBHIC4gPG1yLm51a2UubWVAZ21h
aWwuY29tPjsgTmljaw0KPiA+ID4gTW9ycm93DQo+ID4gPiA8bW9ycm93bnJAZ21haWwuY29tPjsg
VmlrdG9yIFBldHJlbmtvIDxnMDAwMGdhQGdtYWlsLmNvbT47IEFuZHJlYXMgSGVucmlrc3NvbiA8
DQo+ID4gPiBhbmRyZWFzQGZhdGFsLnNlPjsNCj4gPiA+IFZhbGRpa1NTIDxpYW1AdmFsZGlrc3Mu
b3JnLnJ1Pjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBwZXR0ZXJAdGVjaG51eC5zZTsgU2FzY2hh
IEhhdWVyDQo+ID4gPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFN1YmplY3Q6IFtQ
QVRDSF0gd2lmaTogcnR3ODg6IHVzYjogc2lsZW5jZSBsb2cgZmxvb2RpbmcgZXJyb3IgbWVzc2Fn
ZQ0KPiA+ID4gDQo+ID4gPiBXaGVuIHJlY2VpdmluZyBtb3JlIHJ4IHBhY2tldHMgdGhhbiB0aGUg
a2VybmVsIGNhbiBoYW5kbGUgdGhlIGRyaXZlcg0KPiA+ID4gZHJvcHMgdGhlIHBhY2tldHMgYW5k
IGlzc3VlcyBhbiBlcnJvciBtZXNzYWdlLg0KPiA+IA0KPiA+IFRoZSB3b3JrcXVldWUgcnR3ODhf
dXNiIGlzIHVzaW5nIGlzOg0KPiA+IA0KPiA+ICAgICAgIHJ0d3VzYi0+cnh3cSA9IGNyZWF0ZV9z
aW5nbGV0aHJlYWRfd29ya3F1ZXVlKCJydHc4OF91c2I6IHJ4IHdxIik7DQo+ID4gDQo+ID4gSGF2
ZSB5b3UgdHJpZWQgd29ya3F1ZXVlIHdpdGggZmxhZ3MgV1FfVU5CT1VORCBhbmQgV1FfSElHSFBS
ST8gTGlrZSwNCj4gPiANCj4gPiAgICAgICBydHd1c2ItPnJ4d3EgPSBhbGxvY193b3JrcXVldWUo
InJ0dzg4X3VzYjogcnggd3EiLCBXUV9VTkJPVU5EIHwgV1FfSElHSFBSSSwgMCk7DQo+ID4gb3IN
Cj4gPiAgICAgICBydHd1c2ItPnJ4d3EgPSBhbGxvY19vcmRlcmVkX3dvcmtxdWV1ZSgicnR3ODhf
dXNiOiByeCB3cSIsIFdRX0hJR0hQUkkpOw0KPiA+IA0KPiA+IFRoZW4sIGRyaXZlciBnZXQgbW9y
ZSB0aW1lIHRvIHByb2Nlc3MgUlgsIHNvIGl0IGNvdWxkIGVhc2UgZmxvb2RpbmcgbWVzc2FnZXMu
DQo+IA0KPiBObywgSSBoYXZlbid0IHRyaWVkIHRoaXMuIFJlZ2FyZGxlc3Mgb2YgdGhhdCwgSSB0
aGluayBpdCBzdGlsbCBtYWtlcw0KPiBzZW5zZSB0byByYXRlIGxpbWl0IHRoZSBtZXNzYWdlcy4g
VGhlcmUgd2lsbCBhbHdheXMgYmUgYSBzbG93ZXIgc3lzdGVtDQo+IHRoYXQgY2FuJ3QgY29wZSB3
aXRoIHRoZSBudW1iZXIgb2YgcGFja2V0cyBldmVuIHdpdGggYSBoaWdoZXIgcHJpb3JpdHkNCj4g
d29ya3F1ZXVlLg0KPiANCg0KTXkgb3BpbmlvbiBpcyBqdXN0IHJlbGF0ZWQgdGhpbmcgdGhhdCBp
cyBhbiBpZGVhIHRvIGdldCBhIGxpdHRsZSBiaXQNCmltcHJvdmVtZW50LiBCdXQsIHlvdSBhcmUg
cmlnaHQuIFRoaXMgbWF5IGJlIHVzZWxlc3MgZm9yIHNsb3dlciBzeXN0ZW0uDQpBbHNvLCB5b3Vy
IHBhdGNoIHRvdGFsbHkgbWFrZSBzZW5zZSB0byBtZS4gDQoNClJldmlld2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=
