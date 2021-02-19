Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0631F55C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBSH3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 02:29:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58399 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSH3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 02:29:46 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11J7SqLF2021017, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11J7SqLF2021017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Feb 2021 15:28:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 15:28:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 15:28:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a98b:ac3a:714:c542]) by
 RTEXMBS04.realtek.com.tw ([fe80::a98b:ac3a:714:c542%6]) with mapi id
 15.01.2106.006; Fri, 19 Feb 2021 15:28:52 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] rtlwifi: 8821ae: upgrade PHY and RF parameters
Thread-Topic: [PATCH] rtlwifi: 8821ae: upgrade PHY and RF parameters
Thread-Index: AQHXBn/nSez1PcdjjUaqHv4RaW6HoapfEeaZ//98twA=
Date:   Fri, 19 Feb 2021 07:28:51 +0000
Message-ID: <1613719728.11718.3.camel@realtek.com>
References: <20210219052607.7323-1-pkshih@realtek.com>
         <87zh00jzlk.fsf@codeaurora.org>
In-Reply-To: <87zh00jzlk.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42EDB9504DF160408E06A0CA7D4321D0@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTE5IGF0IDA5OjE3ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBOZXcgcGFy
YW1ldGVycyB3aXRoIG5ldyBmb3JtYXQgYW5kIGl0cyBwYXJzZXIgYXJlIHVwZGF0ZWQgYnkgdGhl
DQo+ID4gY29tbWl0IDg0ZDI2ZmRhNTJlMiAoInJ0bHdpZmk6IFVwZGF0ZSA4ODIxYWUgbmV3IHBo
eSBwYXJhbWV0ZXJzIGFuZCBpdHMgcGFyc2VyLiIpLA0KPiA+IGJ1dCBzb21lIHBhcmFtZXRlcnMg
YXJlIG1pc3NpbmcuIFVzZSB0aGlzIGNvbW1pdCB0byB1cGRhdGUgdG8gdGhlIG5vdmVsDQo+ID4g
cGFyYW1ldGVycyB0aGF0IHVzZSBuZXcgZm9ybWF0Lg0KPiA+DQo+ID4gRml4ZXM6IDg0ZDI2ZmRh
NTJlMiAoInJ0bHdpZmk6IFVwZGF0ZSA4ODIxYWUgbmV3IHBoeSBwYXJhbWV0ZXJzIGFuZCBpdHMg
cGFyc2VyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEthaS1IZW5nIEZlbmcgPGthaS5oZW5nLmZlbmdAY2Fub25p
Y2FsLmNvbT4NCj4gDQo+IFdoYXQgZG9lcyB0aGlzIGZpeCBmcm9tIHVzZXIncyBwb2ludCBvZiB2
aWV3Pw0KPiANCg0KVGhlIHNpZ25hbCBzdHJlbmd0aCBvZiA1RyBpcyBxdWl0ZSBsb3csIHNvIHVz
ZXIgY2FuJ3QgY29ubmVjdCB0byBhbiBBUCBmYXIgYXdheS4NCg0KLS0tDQpQaW5nLUtlDQoNCg==
