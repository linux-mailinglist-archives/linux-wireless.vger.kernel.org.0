Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48E42BD63
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 04:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfE1Ctk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 22:49:40 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:46326 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727468AbfE1Ctk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 22:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1559011779; x=1590547779;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=nRkNCMt05aLNGjQ9q8m2WKD2+ZjBBj2uPIxe4Au82VQ=;
  b=fH8+MJPZXUlUc0p5SWaI0uFy8ulNLA+3s8I2R08wEGygdqLTtcOy8hbc
   6cS0OFF3JWRj596ZOmQ68DQY1SkdVqkwsW+Bb0z64DDXe5AIIrIe1aRA9
   Xziw+6qKbIAaps8aZbuXtslClcEtgV7HgByzRktAlEaPnWBTy9L6m7GJ4
   8=;
Subject: RE: [PATCH] ath10k: Remove ATH10K_STATE_RESTARTED in simulate fw crash
Thread-Topic: [PATCH] ath10k: Remove ATH10K_STATE_RESTARTED in simulate fw crash
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 28 May 2019 10:49:38 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9270"; a="30539829"
Received: from aptaiexm02b.ap.qualcomm.com ([10.249.150.12])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 May 2019 10:49:32 +0800
Received: from aptaiexm02f.ap.qualcomm.com (10.249.150.16) by
 aptaiexm02b.ap.qualcomm.com (10.249.150.12) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Tue, 28 May 2019 10:49:30 +0800
Received: from aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1]) by
 aptaiexm02f.ap.qualcomm.com ([fe80::4152:1436:e436:faa1%19]) with mapi id
 15.00.1395.000; Tue, 28 May 2019 10:49:30 +0800
From:   Wen Gong <wgong@qti.qualcomm.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     =?utf-8?B?TWljaGHFgiBLYXppb3I=?= <kazikcz@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Thread-Index: AQHUpmQJz5XVQIMvMUei5K703fyTnaYnTmZwgAtNzTD///F7AIABLCiAgADKTICAAL2CYIBLcTDg
Date:   Tue, 28 May 2019 02:49:30 +0000
Message-ID: <301c4b127ea74abd8a9d8221d93656fd@aptaiexm02f.ap.qualcomm.com>
References: <1542163824-795-1-git-send-email-wgong@codeaurora.org>
 <CABvG-CWg-VXAtoN8HZumW-ZdP6dX9cO_8fWJ58C22kD2yDcXdw@mail.gmail.com>
 <195f3bb0c88c43a6b1ca0ad336f947c0@aptaiexm02f.ap.qualcomm.com>
 <CABvG-CWAfB8jjCDW4ggjJ8_YC++CjttJOMOt4s24F3mymvNR9A@mail.gmail.com>
 <02904ba8682441e1a89668c1345cbec9@aptaiexm02f.ap.qualcomm.com>
 <54b4dab1191d41b8b329f3ceb7017626@aptaiexm02f.ap.qualcomm.com>
 <CABvG-CWz0rBCXfF7mX9L62=fmdcYhpOaO5JNLtvSE87o_XJFng@mail.gmail.com>
 <1fec49e1b6794860a1eff2330bcdea28@aptaiexm02f.ap.qualcomm.com>
 <CA+ASDXP1Ftpi93p=Bp2w1rRd3xVtNn_+diwkKTMXbTqK0B3ahA@mail.gmail.com>
 <b073fa90e9a3437c9846ce2d22fab15f@aptaiexm02f.ap.qualcomm.com>
In-Reply-To: <b073fa90e9a3437c9846ce2d22fab15f@aptaiexm02f.ap.qualcomm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhdGgxMGsgPGF0aDEway1ib3Vu
Y2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uIEJlaGFsZiBPZiBXZW4gR29uZw0KPiBTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDEwLCAyMDE5IDEwOjQ1IEFNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJy
aWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gQ2M6IE1pY2hhxYIgS2F6aW9yIDxrYXppa2N6QGdt
YWlsLmNvbT47IGxpbnV4LXdpcmVsZXNzIDxsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnPjsgYXRoMTBrQGxpc3RzLmluZnJhZGVhZC5vcmc7IFdlbiBHb25nDQo+IDx3Z29uZ0Bjb2Rl
YXVyb3JhLm9yZz4NCj4gU3ViamVjdDogW0VYVF0gUkU6IFtQQVRDSF0gYXRoMTBrOiBSZW1vdmUg
QVRIMTBLX1NUQVRFX1JFU1RBUlRFRCBpbg0KPiBzaW11bGF0ZSBmdyBjcmFzaA0KPiANCj4gSWYg
Q2hyb21lT1MgaXMgZWFzeSB0byBjaGFuZ2UgdG9vbCwNCj4gSSB0aGluayBJIHdpbGwgY2hhbmdl
IHRoZSBtZWNoYW5pc20gb2YgdGhlIHNpbXVsYXRlX2Z3X2NyYXNoLg0KPiBUaGVuIGFsbCB0b29s
cyB3aWxsIHdvcmsgbm9ybWFsbHkuDQo+IA0KTmV3IHBhdGNoIHVwbG9hZGVkDQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwODk3NTg3Lw0KW3YyXSBhdGgxMGs6IFJlbW92ZSBB
VEgxMEtfU1RBVEVfUkVTVEFSVEVEIGluIHNpbXVsYXRlIGZ3IGNyYXNoDQo=
