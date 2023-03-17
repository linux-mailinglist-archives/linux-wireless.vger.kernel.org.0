Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D76BE1E7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCQH30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCQH3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 03:29:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6295848F
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 00:29:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32H7T18f8006586, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32H7T18f8006586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 17 Mar 2023 15:29:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 15:29:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Mar 2023 15:29:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 17 Mar 2023 15:29:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rb0171610@gmail.com" <rb0171610@gmail.com>
Subject: Re: New binary rtw8852b_fw.bin not loading firmware not recognized
Thread-Topic: New binary rtw8852b_fw.bin not loading firmware not recognized
Thread-Index: AQHZWFlk5g7N8N8lZkeI1EtTn3KuVa7+FaKggABX+Lz//5+sgA==
Date:   Fri, 17 Mar 2023 07:29:13 +0000
Message-ID: <e99f1dc26c83b24cb2bb7d6f8f92669b375d7512.camel@realtek.com>
References: <df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com>
         <386367223a2547669c60f7d1dcb42b40@realtek.com> <87a60cvu3v.fsf@kernel.org>
In-Reply-To: <87a60cvu3v.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.81.227]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2CA0CF025E5AC428933F7AADB3490C3@realtek.com>
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

T24gRnJpLCAyMDIzLTAzLTE3IGF0IDA3OjEyICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiByYiA8cmIwMTcxNjEwQGdtYWlsLmNv
bT4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTcsIDIwMjMgNjo0OCBBTQ0KPiA+ID4gVG86
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogTmV3IGJpbmFy
eSBydHc4ODUyYl9mdy5iaW4gbm90IGxvYWRpbmcgZmlybXdhcmUgbm90IHJlY29nbml6ZWQNCj4g
PiA+IA0KPiA+ID4gQnJpZWZseSwNCj4gPiA+IA0KPiA+ID4gSSB1c2UgcnR3ODlfODg1MmJlIGlu
IGtlcm5lbCBkcml2ZXINCj4gPiA+IA0KPiA+ID4gSEFSRFdBUkU6DQo+ID4gPiBOZXR3b3JrIGNv
bnRyb2xsZXIgWzAyODBdOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIERldmljZSBb
MTBlYzpiODUyXQ0KPiA+ID4gDQo+ID4gPiBMZW5vdm8gSWRlYXBhZCAxaQ0KPiA+ID4gDQo+ID4g
PiBJU1NVRToNCj4gPiA+IE5ld2VzdCB2ZXJzaW9uIG9mIGJpbmFyeSBmaXJtd2FyZSAyMDIzXzAz
XzEwLA0KPiA+ID4gcnR3ODkvcnR3ODg1MmJfZncuYmluLCB3aWxsIG5vdCBsb2FkL2Zpcm13YXJl
IG5vdCByZWNvZ25pemVkIG9uIExpbnV4IEtlcm5lbCA2LjIuNSAoYW5kDQo+ID4gPiBvdGhlcnMp
Og0KPiA+ID4gDQo+ID4gPiBbXSBsb2FkaW5nIGZpcm1hcmU6IHJ3dDg5L3J0dzg4NTJiX2Z3LmJp
bg0KPiA+ID4gW10gcnR3ODlfODg1MmJlIDAwMDA6MDM6MDAuMDogbm8gc3VpdGFibGUgZmlybXdh
cmUgZm91bmQNCj4gPiA+IFtdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAzOjAwLjA6IGZhaWxlZCB0byBy
ZWNvZ25pemUgZmlybXdhcmUNCj4gPiA+IA0KPiA+ID4gSXNzdWUgcGVyc2lzdHMgcmVnYXJkbGVz
cyBvZiB3aGljaCA2LjIgc2VyaWVzIGtlcm5lbCBpcyB1c2VkLg0KPiA+ID4gDQo+ID4gPiBBbGwg
cHJldmlvdXMgcnd0ODkvcnR3ODg1MmJfZncuYmluIGZpcm13YXJlIGZyb20gbGludXgtZmlybXdh
cmUgMjAyM18wMl8xMCBhbmQgZWFybGllciBsb2Fkcw0KPiA+ID4gYW5kIHdvcmtzDQo+ID4gPiBj
b3JyZWN0bHkuDQo+ID4gPiANCj4gPiA+IEkgZGlkIGZpbGUgYSBidWcgcmVwb3J0IHdpdGggdGhl
IGRldGFpbHM6DQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MjE3MjA3DQo+ID4gPiANCj4gPiANCj4gPiBUaGUgZmlybXdhcmUgZm9ybWF0
IGlzIGNoYW5nZWQsIGFuZCB3aXJlbGVzcy1uZXh0IHRyZWUgb3IgdXBjb21pbmcgNi4zIHdpbGwN
Cj4gPiBzdXBwb3J0IGl0LiBJIHdpbGwgYWxzbyBwb3N0IHRoaXMgaW5mb3JtYXRpb24gb24gdGhl
IGJ1Zy4NCj4gDQo+IFdlIGNhbm5vdCBicmVhayB1c2VyIHNwYWNlIGxpa2UgdGhhdCwgbGludXgt
ZmlybXdhcmUgbmVlZHMgdG8gYmUNCj4gYmFja3dhcmRzIGNvbXBhdGlibGUuIEluIG90aGVyIHdv
cmRzLCBhbnl0aGluZyB5b3Ugc3VibWl0IHRvDQo+IGxpbnV4LWZpcm13YXJlIG5lZWRzIHRvIHdv
cmsgd2l0aCBvbGQga2VybmVscy4gU2hvdWxkIHRoaXMgbmV3IGZpcm13YXJlDQo+IGJlIHJldmVy
dGVkIGZyb20gbGludXgtZmlybXdhcmU/DQoNCkkgdGhpbmsgSSBzaG91bGQgc3VwcG9ydCB0d28g
b3IgbW9yZSBmaXJtd2FyZSB3aXRoIGRpZmZlcmVudCBuYW1lLCBsaWtlDQpyd3Q4OS9ydHc4ODUy
Yl9mdy0yLmJpbiwgaWYgZm9ybWF0IGlzIGNoYW5nZWQuIFNvLCB0aGVyZSB3aWxsIGJlIHR3bw0K
ZmlybXdhcmUgZXhpc3RpbmcgaW4gbGludXgtZmlybXdhcmUuDQoNClRoZW4sIGZvciBvbGQgZHJp
dmVyLCBpdCBvbmx5IHN1cHBvcnRzIHJ3dDg5L3J0dzg4NTJiX2Z3LmJpbi4gRm9yIG5ldyBkcml2
ZXIsDQppdCB3aWxsIGxvYWQgcnd0ODkvcnR3ODg1MmJfZnctMi5iaW4gZmlyc3QsIGJ1dCBpZiAn
LTInIHZlcnNpb24gZG9lc24ndCBwcmVzZW50LA0KaXQgd2lsbCB0cnkgdG8gbG9hZCBvcmlnaW5h
bCB2ZXJzaW9uLg0KDQpJIHRoaW5rIGl0IHdvdWxkIHdvcmssIGJ1dCBJIHdhbnQgdG8gY29uZmly
bSBpZiB0aGlzIGlzIGFjY2VwdGFibGUgcnVsZXMNCmZvciBMaW51eC4NCg0KPiANCj4gV2hhdCBh
Ym91dCBjaGFuZ2VzIGluIHRoZSBydHc4OSBkcml2ZXI/IERvIHRoZXkgc3RpbGwgd29yayB3aXRo
IG9sZA0KPiBmaXJtd2FyZT8NCj4gDQoNCk5ldyBkcml2ZXIgY2FuIHdvcmsgd2l0aCBvbGQgb3Ig
bmV3IGZpcm13YXJlLiBUaGUgb25seSBjYXNlIHRoYXQgZG9lc24ndA0Kd29yayBpcyBvbGQgZHJp
dmVyICsgbmV3IGZpcm13YXJlLg0KDQoNClBpbmctS2UNCg0K
