Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6A2F262B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbhALCRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 21:17:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47856 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbhALCRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 21:17:46 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10C2H0Bz8016073, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10C2H0Bz8016073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 10:17:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 12 Jan 2021 10:17:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Tue, 12 Jan 2021 10:17:00 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Vincent Fan <vincent_fann@realtek.com>
Subject: Re: [PATCH] rtw88: 8821c: apply CCK PD level which calculates from dynamic mechanism
Thread-Topic: [PATCH] rtw88: 8821c: apply CCK PD level which calculates from
 dynamic mechanism
Thread-Index: AQHW3PMmF/B62Nkk00OM1X/+fgPEeKoiJZqfgACsPwA=
Date:   Tue, 12 Jan 2021 02:16:59 +0000
Message-ID: <1610417786.3495.3.camel@realtek.com>
References: <20201228082516.16488-1-pkshih@realtek.com>
         <87sg77lxap.fsf@codeaurora.org>
In-Reply-To: <87sg77lxap.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8DD5FF6F1BD3941B087E2566DCD0F91@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTExIGF0IDA3OjU4ICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiB2
aW5jZW50X2Zhbm4gPHZpbmNlbnRfZmFubkByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IEhhbCBmdW5j
dGlvbiBtdXN0IGZvbGxvdyB0aGUgdmFsdWUgdGhhdCBjYWxjdWxhdGVzIGZyb20gZHluYW1pYyBt
ZWNoYW5pc20uDQo+ID4gRm9yY2UgdG8gc2V0IG5ld19sdmwgdG8gNCBkYW1hZ2VzIHJlY2Vpdmlu
ZyBhYmlsaXR5LiBTeXN0ZW0gd2lsbCBub3QgYWJsZQ0KPiA+IHRvIHJlY29ubmVjdCB0byB0aGUg
QVAgaWYgd2lmaSB1bmV4cGVjdGVkIGRpc2Nvbm5lY3RpbmcgYXQgdGhpcyBtb21lbnQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiB2aW5jZW50X2Zhbm4gPHZpbmNlbnRfZmFubkByZWFsdGVrLmNv
bT4NCj4gDQo+IFRoZSByZWFsIG5hbWUgbG9va3MgdG8gYmUganVzdCBhIGNvcHkgb2YgdXNlcm5h
bWUsIGJhZGx5IGNvbmZpZ3VyZWQgZ2l0DQo+IG1heWJlPyBJIGNhbiBmaXggaXQgZHVyaW5nIGNv
bW1pdCwgaG93IGRvZXMgVmluY2VudCBmb3JtYXQgaGlzIG5hbWUgaW4NCj4gcmVndWxhciBlbWFp
bD8gRG9lcyB0aGlzIGxvb2sgb2s6DQo+IA0KPiBWaW5jZW50IEZhbm4gPHZpbmNlbnRfZmFubkBy
ZWFsdGVrLmNvbT4NCj4gDQoNClllcywgaXQgZG9lcy4NClBsZWFzZSBoZWxwIHRvIGZpeCBpdC4N
Cg0KVGhhbmsgeW91DQotLS0NClBpbmctS2UNCg0KDQo=
