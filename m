Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753369A967
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBQKww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 05:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQKwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 05:52:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151D213D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 02:52:48 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31HAqW5j9020769, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31HAqW5j9020769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 17 Feb 2023 18:52:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 18:52:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Feb 2023 18:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 17 Feb 2023 18:52:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Bernie Huang" <phhuang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: add RNR support for 6 GHz scan
Thread-Topic: [PATCH] wifi: rtw89: add RNR support for 6 GHz scan
Thread-Index: AQHZQaxGkR2qtrBt2EKQWwKbTNW+3a7SckQA
Date:   Fri, 17 Feb 2023 10:52:34 +0000
Message-ID: <c3602dc76325b0842679d3707a5aa6239dd6ea1b.camel@realtek.com>
References: <20230216021239.9133-1-pkshih@realtek.com>
In-Reply-To: <20230216021239.9133-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.75.62]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzIvMTcg5LiK5Y2IIDA4OjI4OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E174BD91A144F44B3F0FB0A33A5365C@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTE2IGF0IDEwOjEyICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IEZyb206IFBvLUhhbyBIdWFuZyA8cGhodWFuZ0ByZWFsdGVrLmNvbT4NCj4gDQo+IFNpbmNlIDYg
R0h6IGJhbmQgaGFzIGFyb3VuZCA2MCBjaGFubmVscyBhbmQgbW9yZSBzdHJpY3QgcnVsZXMgZm9y
DQo+IGFjdGl2ZSBwcm9iaW5nLiBSZWR1Y2VkIG5laWdoYm9yIHJlcG9ydCBjYW4gYmUgdXNlZCB0
byByZWR1Y2UgdGhlDQo+IGNoYW5uZWxzIHdlIHNjYW4gYW5kIGdldCBzcGVjaWZpYyB0YXJnZXQg
QlNTIGluZm8gdG8gcHJvYmUgZm9yLg0KPiANCj4gRGVjbGFyZSBmbGFnIFdJUEhZX0ZMQUdfU1BM
SVRfU0NBTl82R0haIHNvIHRoZSBzY2FuIHJlcXVlc3QgY291bGQgYmUNCj4gZGl2aWRlZCBpbnRv
IHR3byBwb3J0aW9uczogbGVnYWN5IGJhbmRzIGFuZCA2IEdIeiBiYW5kcy4gU28gUk5SDQo+IGlu
Zm9ybWF0aW9uIGZyb20gbGVnYWN5IGJhbmRzIGNvdWxkIGxhdGVyIGJlIHVzZWQgd2hlbiA2IEdI
eiBzY2FuLg0KPiANCj4gV2hlbiB0aGUgc2NhbiBmbGFnIE5MODAyMTFfU0NBTl9GTEFHX0NPTE9D
QVRFRF82R0haIGlzIHNldCwgY2ZnODAyMTENCj4gd2lsbCBwYXNzIGRvd24gYSByZWR1Y2VkIGNo
YW5uZWwgc2V0IHdoaWNoIGNvbnRhaW5zIFBTQ3MgYW5kIG5vbi1QU0MNCj4gd2l0aCBSTlIgaW5m
byByZWNlaXZlZCBpbiB0aGUgMiBHSHovNSBHSHogYmFuZC4gVGhpcyByZWR1Y2VzIHRoZQ0KPiBz
Y2FuIGR1cmF0aW9uIGJ5IGFsbG93aW5nIHVzIHRvIG9ubHkgc2NhbiBmb3IgY2hhbm5lbHMgaW4g
d2hpY2ggQVBzDQo+IGFyZSBjdXJyZW50bHkgb3BlcmF0aW5nLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJlYWx0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQoNCnNtYXRjaCByZXBvcnRzIHRo
aXMgdmVyc2lvbiBjb250YWlucyBhIGJ1Zywgc28gcGxlYXNlIGRyb3AgdGhpcy4NCkknbGwgZml4
IGl0IGFuZCBzZW5kIHYyIHNvb24uDQoNClBpbmctS2UNCg0KDQo=
