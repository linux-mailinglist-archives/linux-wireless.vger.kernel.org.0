Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1450997706
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfHUKU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 06:20:58 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:19607 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbfHUKU6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 06:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566382856; x=1597918856;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ce6W1lGosJ6tdqCxwLZgMOwlQsNLvnMc2ZDAfih4LfA=;
  b=LdW4tsNEmO+WQX9PeCyuJfFs205chENy1OmxKUn3c43MLu6R0bd157yE
   9Qk3TxJmQ76p0485H505RuxKIF/hwXb2+6MenO9xLanegaLIUKsvLBQJ8
   3rscSoKmbXh8REsoytMZJghhmDZoeiMOCv9W9yVg/90jrej8htTfDuI7i
   I=;
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 21 Aug 2019 18:20:55 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Aug 2019 18:20:50 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Wed, 21 Aug 2019 18:20:48 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Wed, 21 Aug 2019 18:20:48 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV1IyEev87vakM0G2WVqJ6I35M6cFHQig//+/hoCAAIiLIA==
Date:   Wed, 21 Aug 2019 10:20:48 +0000
Message-ID: <86d0eabcc63849efa914f2c14a3cd59f@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
 <87blwkt480.fsf@toke.dk>
 <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com>
 <8736husub0.fsf@toke.dk>
In-Reply-To: <8736husub0.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.80.80.8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb2tlIEjDuGlsYW5kLUrDuHJn
ZW5zZW4gPHRva2VAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjEsIDIw
MTkgNjoxMCBQTQ0KPiBUbzogV2VuIEdvbmcgPHdnb25nQHF0aS5xdWFsY29tbS5jb20+OyBXZW4g
R29uZw0KPiA8d2dvbmdAY29kZWF1cm9yYS5vcmc+OyBhdGgxMGtAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRd
IFJFOiBbUEFUQ0ggNC83XSBhdGgxMGs6IGRpc2FibGUgVFggY29tcGxldGUgaW5kaWNhdGlvbiBv
ZiBodHQNCj4gZm9yIHNkaW8NCj4gDQo+IFdlbiBHb25nIDx3Z29uZ0BxdGkucXVhbGNvbW0uY29t
PiB3cml0ZXM6DQo+IA0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBhdGgxMGsgPGF0aDEway1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uIEJlaGFsZiBP
ZiBUb2tlDQo+ID4+IEjDuGlsYW5kLUrDuHJnZW5zZW4NCj4gPj4gU2VudDogVHVlc2RheSwgQXVn
dXN0IDIwLCAyMDE5IDg6MjQgUE0NCj4gPj4gVG86IFdlbiBHb25nIDx3Z29uZ0Bjb2RlYXVyb3Jh
Lm9yZz47IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4+IENjOiBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCA0LzddIGF0
aDEwazogZGlzYWJsZSBUWCBjb21wbGV0ZSBpbmRpY2F0aW9uIG9mDQo+IGh0dA0KPiA+IFdoZW4g
dGhpcyBwYXRjaCBhcHBsaWVkLCBmaXJtd2FyZSB3aWxsIG5vdCBpbmRpY2F0ZSB0eCBjb21wbGV0
ZSBmb3IgdHgNCj4gPiBEYXRhLCBpdCBvbmx5IGluZGljYXRlIEhUVF9UMkhfTVNHX1RZUEVfVFhf
Q1JFRElUX1VQREFURV9JTkQsDQo+ID4gVGhpcyBodHQgbXNnIHdpbGwgdGVsbCBob3cgbWFueSBk
YXRhIHR4IGNvbXBsZXRlIHdpdGhvdXQgc3RhdHVzKHN0YXR1cw0KPiBtYXliZSBzdWNjZXNzL2Zh
aWwpLg0KPiANCj4gQWgsIHNvIHRoaXMgaXMgYmFzaWNhbGx5IGEgY291bnRlciBvZiBob3cgbXVj
aCBkYXRhIGlzIGN1cnJlbnRseSBxdWV1ZWQNCj4gaW4gdGhlIGZpcm13YXJlPw0KWWVzLg0KPiAN
Cj4gPj4gQW5kIGNvdWxkIHlvdSBleHBsYWluIHdoYXQgdGhlIGNyZWRpdHMgdGhpbmcgaXMgZm9y
LCBwbGVhc2U/IDopDQo+ID4gRm9yIGhpZ2ggbGF0ZW5jeSBidXMgY2hpcCwgYWxsIHRoZSB0eCBk
YXRhJ3MgY29udGVudChpbmNsdWRlIGlwL3VkcC90Y3ANCj4gaGVhZGVyDQo+ID4gYW5kIHBheWxv
YWQpIHdpbGwgYmUgdHJhbnNmZXIgdG8gZmlybXdhcmUncyBtZW1vcnkgdmlhIGJ1cy4NCj4gPiBB
bmQgZmlybXdhcmUgaGFzIGxpbWl0ZWQgbWVtb3J5IGZvciB0eCBkYXRhLCB0aGUgdHggZGF0YSdz
IGNvbnRlbnQgbXVzdA0KPiA+IFNhdmVkIGluIGZpcm13YXJlIG1lbW9yeSBiZWZvcmUgaXQgdHgg
Y29tcGxldGUsIGlmIGF0aDEwayB0cmFuc2ZlciB0eA0KPiA+IGRhdGEgbW9yZSB0aGFuIHRoZSBs
aW1pdCwgZmlybXdhcmUgd2lsbCBvY2N1ciBlcnJvci4gVGhlIGNyZWRpdCBpcyB1c2VkDQo+ID4g
dG8gYXZvaWQgYXRoMTBrIGV4Y2VlZCB0aGUgbGltaXQuDQo+IA0KPiBXaGF0J3MgYSB0eXBpY2Fs
IGxpbWl0IGluIHRoZSBmaXJtd2FyZT8NCkl0IGlzIDk2IGRhdGEgcGFja2V0IGluIG15IHRlc3Qu
IEl0IGNhbiBjaGFuZ2VkIGluIGZpcm13YXJlIGNvZGUuDQo+IA0KPiAtVG9rZQ0K
