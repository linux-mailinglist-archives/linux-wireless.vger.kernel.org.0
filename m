Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02B89A5BF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfHWCqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 22:46:46 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:30307 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfHWCqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 22:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1566528404; x=1598064404;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=u7twx3rZjWo1MRPV3n/6cZgQgybcJO1QhZ/B3wHy5qk=;
  b=n2Lyns9EvmOVC5r3FRgMH9zcUFF84gZ3jA+uG14V2WgtBz8vWjR2gXmV
   TnZlgquVIWqLoyXmPbhPmiAqth8WfyWe/LVPMh/dCveIFtcoHPYXceVRs
   k5WzPcqN9thQDNTj29d7Iq+UzDmLUXwaBTkO3j0kx0yGeCRPxBMu7N6fn
   o=;
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Thread-Topic: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 23 Aug 2019 10:46:43 +0800
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Aug 2019 10:46:38 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Fri, 23 Aug 2019 10:46:36 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1473.005; Fri, 23 Aug 2019 10:46:36 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Wen Gong <wgong@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Thread-Index: AQHVV1IyEev87vakM0G2WVqJ6I35M6cFHQig//+/hoCAAIiLIIABK8GAgAF5MzA=
Date:   Fri, 23 Aug 2019 02:46:36 +0000
Message-ID: <250d064103394dfd864c1281f0da3d83@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
 <87blwkt480.fsf@toke.dk>
 <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com>
 <8736husub0.fsf@toke.dk>
 <86d0eabcc63849efa914f2c14a3cd59f@aptaiexm02f.ap.qualcomm.com>
 <874l29pffy.fsf@toke.dk>
In-Reply-To: <874l29pffy.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.249.136.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb2tlIEjDuGlsYW5kLUrDuHJn
ZW5zZW4gPHRva2VAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAx
OSA4OjEyIFBNDQo+IFRvOiBXZW4gR29uZyA8d2dvbmdAcXRpLnF1YWxjb21tLmNvbT47IFdlbiBH
b25nDQo+IDx3Z29uZ0Bjb2RlYXVyb3JhLm9yZz47IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0g
UkU6IFtQQVRDSCA0LzddIGF0aDEwazogZGlzYWJsZSBUWCBjb21wbGV0ZSBpbmRpY2F0aW9uIG9m
IGh0dA0KPiBmb3Igc2Rpbw0KPiA+PiBXaGF0J3MgYSB0eXBpY2FsIGxpbWl0IGluIHRoZSBmaXJt
d2FyZT8NCj4gPiBJdCBpcyA5NiBkYXRhIHBhY2tldCBpbiBteSB0ZXN0LiBJdCBjYW4gY2hhbmdl
ZCBpbiBmaXJtd2FyZSBjb2RlLg0KPiANCj4gUmlnaHQsIEkgc2VlLiBJcyB0aGlzIGNvdW50ZXIg
YXZhaWxhYmxlIGluIGFsbCBhdGgxMGsgZmlybXdhcmUsIG9yIGlzIGl0DQo+IFNESU8gb25seT8N
Cj4gDQpJdCBpcyBvbmx5IGZvciBTRElPLg0KRm9yIFBDSUUsIGl0IGRvZXMgbm90IGhhdmUgY3Jl
ZGl0IGxpbWl0LCBmaXJtd2FyZSBtZW1vcnkgb25seSBuZWVkIHRvIHNhdmUNClRoZSB0eCBkZXNj
cmlwdG9yLCBub3QgbmVlZCBmb3IgcGFseWxvYWQuDQo+IEknbSBhc2tpbmcgYmVjYXVzZSB0aGlz
IGNvdWxkIGFsc28gYmUgYSB3YXkgb2YgaW1wbGVtZW50aW5nIHNvbWV0aGluZw0KPiBsaWtlIEJ5
dGUgUXVldWUgTGltaXRzICh0aG91Z2ggSSdtIG5vdCBzdXJlIGhvdyBlZmZlY3RpdmUgaXQgd291
bGQgYmUpLg0KPiANCj4gLVRva2UNCg==
