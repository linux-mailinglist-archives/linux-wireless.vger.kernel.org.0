Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F176F9D14
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjEHAth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 May 2023 20:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHAtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 May 2023 20:49:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0DE6E
        for <linux-wireless@vger.kernel.org>; Sun,  7 May 2023 17:49:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3480n5hL5031864, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3480n5hL5031864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 08:49:05 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 08:49:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 8 May 2023 08:49:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 8 May 2023 08:49:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: RCU WARNING Splat from rtw8822bu
Thread-Topic: RCU WARNING Splat from rtw8822bu
Thread-Index: AQHZgRmGn3prOveaRE+ga6xN3f/Wjq9PiKrg
Date:   Mon, 8 May 2023 00:49:10 +0000
Message-ID: <3c2eabc6fc89496fb7e200d0710ba2f2@realtek.com>
References: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
In-Reply-To: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxs
YXJyeS5maW5nZXJAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgTGFycnkgRmluZ2VyDQo+IFNlbnQ6
IE1vbmRheSwgTWF5IDgsIDIwMjMgMzoyNCBBTQ0KPiBUbzogU2FzY2hhIEhhdWVyIDxzLmhhdWVy
QHBlbmd1dHJvbml4LmRlPjsgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENj
OiBsaW51eC13aXJlbGVzcyA8bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSQ1UgV0FSTklORyBTcGxhdCBmcm9tIHJ0dzg4MjJidQ0KPiANCj4gSGksDQo+IA0KPiBJ
IGdvdCB0aGUgZm9sbG93aW5nIFdBUk5JTkcgc3BsYXQgZnJvbSBydHc4ODIyYnUuIERyaXZlciBy
dHc4OV84ODUyYmUgd2FzDQo+IGxvYWRlZCwgYnV0IGluYWN0aXZlLiBUaGlzIGlzIHRoZSBvbmx5
IGluc3RhbmNlIG9mIHRoaXMgd2FybmluZyBpbiBteSBsb2dzIGV2ZW4NCj4gdGhvdWdoIEkgaGF2
ZSBiZWVuIHRlc3RpbmcgdGhpcyBkcml2ZXIgcXVpdGUgYSBsb3QuDQo+IA0KDQpbLi4uXQ0KDQo+
IFsxODE3Ny41NzY0MThdIFdvcmtxdWV1ZTogcGh5MyBpZWVlODAyMTFfY2hzd2l0Y2hfd29yayBb
bWFjODAyMTFdDQo+IFsxODE3Ny41NzY0NjldIFJJUDogMDAxMDpyY3Vfbm90ZV9jb250ZXh0X3N3
aXRjaCsweDU3MS8weDVkMA0KPiBbMTgxNzcuNTc2NDcyXSBDb2RlOiAwMCAwMCAwMCAwMCAwZiA4
NSA2NSBmZCBmZiBmZiA0OSA4OSA4NCAyNCBhMCAwMCAwMCAwMCBlOSA1OA0KPiBmZCBmZiBmZiA0
OCBjNyBjNyA2MCA2NiBlYyBiMCBjNiAwNSA5NiA1ZiA3NiAwMSAwMSBlOCBhZiAwZCBmNiBmZiA8
MGY+IDBiIGU5IGRlDQo+IGZhIGZmIGZmIGM2IDQzIDExIDAwIDQ4IDhiIDczIDIwIGJhIDAxIDAw
IDAwIDAwIDQ4IDhiDQo+IFsxODE3Ny41NzY0NzNdIFJTUDogMDAxODpmZmZmYTkzN2NiMGFmYTUw
IEVGTEFHUzogMDAwMTAwODYNCj4gWzE4MTc3LjU3NjQ3NV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAw
IFJCWDogZmZmZjhkNWIyMzIzM2U4MCBSQ1g6IDAwMDAwMDAwMDAwMDAwMjcNCj4gWzE4MTc3LjU3
NjQ3Nl0gUkRYOiBmZmZmOGQ1YjIzMjIyNGM4IFJTSTogMDAwMDAwMDAwMDAwMDAwMSBSREk6IGZm
ZmY4ZDViMjMyMjI0YzANCj4gWzE4MTc3LjU3NjQ3N10gUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIw
ODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmZmZhOTM3Y2IwYWY4ZjgNCj4gWzE4MTc3LjU3NjQ3
OF0gUjEwOiAwMDAwMDAwMDAwMDAwMDAzIFIxMTogZmZmZjhkNWIyZjU0NmZhOCBSMTI6IGZmZmY4
ZDViMjMyMzMwNDANCj4gWzE4MTc3LjU3NjQ3OV0gUjEzOiBmZmZmOGQ1OWEzNDc1MTAwIFIxNDog
ZmZmZjhkNTlhMzQ3NTEwMCBSMTU6IGZmZmZhOTM3Y2IwYWZjMDANCj4gWzE4MTc3LjU3NjQ4MF0g
RlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ZDViMjMyMDAwMDAoMDAwMCkNCj4g
a25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBbMTgxNzcuNTc2NDgxXSBDUzogIDAwMTAgRFM6IDAw
MDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsxODE3Ny41NzY0ODNdIENSMjog
MDAwMDdmMGI3MDIzMGZjNCBDUjM6IDAwMDAwMDAxMGRjMzQwMDQgQ1I0OiAwMDAwMDAwMDAwMTcw
NmYwDQo+IFsxODE3Ny41NzY0ODRdIENhbGwgVHJhY2U6DQo+IFsxODE3Ny41NzY0ODVdICA8VEFT
Sz4NCj4gWzE4MTc3LjU3NjQ4Nl0gIF9fc2NoZWR1bGUrMHhiMC8weDE0NjANCj4gWzE4MTc3LjU3
NjQ5Ml0gID8gX19tb2RfdGltZXIrMHgxMTYvMHgzNjANCj4gWzE4MTc3LjU3NjQ5NV0gIHNjaGVk
dWxlKzB4NWEvMHhjMA0KPiBbMTgxNzcuNTc2NDk3XSAgc2NoZWR1bGVfdGltZW91dCsweDg3LzB4
MTUwDQo+IFsxODE3Ny41NzY1MDBdICA/IHRyYWNlX3Jhd19vdXRwdXRfdGlja19zdG9wKzB4NjAv
MHg2MA0KPiBbMTgxNzcuNTc2NTAyXSAgd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KzB4N2Iv
MHgxNDANCj4gWzE4MTc3LjU3NjUwNV0gIHVzYl9zdGFydF93YWl0X3VyYisweDgyLzB4MTYwIFt1
c2Jjb3JlDQo+IDMyMjZkMzE0Y2IxZWFkNTA5M2Y4NzJiN2VjNzgzYTA2NjdjOWJkYWFdDQo+IFsx
ODE3Ny41NzY1MjldICB1c2JfY29udHJvbF9tc2crMHhlMy8weDE0MCBbdXNiY29yZQ0KPiAzMjI2
ZDMxNGNiMWVhZDUwOTNmODcyYjdlYzc4M2EwNjY3YzliZGFhXQ0KPiBbMTgxNzcuNTc2NTQ3XSAg
cnR3X3VzYl9yZWFkKzB4ODgvMHhlMCBbcnR3X3VzYg0KPiBlYTdjOWVmNDA0NWFlNDdmMjU1ZjZj
ODI1OWQxM2I4MjU5YWQ2ZmNkXQ0KPiBbMTgxNzcuNTc2NTUyXSAgcnR3X3VzYl9yZWFkOCsweGYv
MHgxMCBbcnR3X3VzYg0KPiBlYTdjOWVmNDA0NWFlNDdmMjU1ZjZjODI1OWQxM2I4MjU5YWQ2ZmNk
XQ0KPiBbMTgxNzcuNTc2NTU2XSAgcnR3X2Z3X3NlbmRfaDJjX2NvbW1hbmQrMHhhMC8weDE3MCBb
cnR3X2NvcmUNCj4gZDZhZTQ3NWQ4YjkxYTM3MWZlZWUzZDYxYzdiNmE4MTgwYTk3NDk5MV0NCj4g
WzE4MTc3LjU3NjU3MV0gIHJ0d19md19zZW5kX3JhX2luZm8rMHhjOS8weGYwIFtydHdfY29yZQ0K
PiBkNmFlNDc1ZDhiOTFhMzcxZmVlZTNkNjFjN2I2YTgxODBhOTc0OTkxXQ0KPiBbMTgxNzcuNTc2
NTg0XSAgZHJ2X3N0YV9yY191cGRhdGUrMHg3Yy8weDE2MCBbbWFjODAyMTENCj4gYzI3NmJkNDAz
ZGJiMDY4YjY2YWM5ZmZiMGE4ZjI3ZDZlNjNlNWM3Y10NCj4gWzE4MTc3LjU3NjYxM10gIGllZWU4
MDIxMV9jaGFuX2J3X2NoYW5nZSsweGZiLzB4MTEwIFttYWM4MDIxMQ0KPiBjMjc2YmQ0MDNkYmIw
NjhiNjZhYzlmZmIwYThmMjdkNmU2M2U1YzdjXQ0KDQpUaGUgaWVlZTgwMjExX29wczo6c3RhX3Jj
X3VwZGF0ZSBtdXN0IGJlIGF0b21pYywgYmVjYXVzZSBpZWVlODAyMTFfY2hhbl9id19jaGFuZ2Uo
KQ0KaG9sZHMgcmN1X3JlYWQgbG9jayB3aGlsZSBjYWxsaW5nIGRydl9zdGFfcmNfdXBkYXRlKCks
IHNvIEkgdGhpbmsgYSBzaW1wbGUgd2F5IGlzDQp0byBjcmVhdGUgYSB3b3JrIHRvIGRvIG9yaWdp
bmFsIHRoaW5ncy4gSSB3aWxsIG1ha2UgYSBmaXggbGF0ZXIuDQoNClBpbmctS2UNCg0K
