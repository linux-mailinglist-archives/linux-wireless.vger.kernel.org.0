Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC4426396
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhJHEQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 00:16:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44446 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhJHEQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 00:16:35 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1984EZkZ4009514, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1984EZkZ4009514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Oct 2021 12:14:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 12:14:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 8 Oct 2021 12:14:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Fri, 8 Oct 2021 12:14:34 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Topic: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Thread-Index: AQHXlXz6iS5M0zbbfkSyaj358Nztiqu+mXDngAQPmeCAAYZwOYAArHWAgAPuLyA=
Date:   Fri, 8 Oct 2021 04:14:34 +0000
Message-ID: <bd869c651d984fb1b728185f77295a43@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
 <8735pkiu0t.fsf@codeaurora.org>
 <9b54e3c321a4414cbae62616d8a913f4@realtek.com>
 <877desggrm.fsf@codeaurora.org>
 <CA+ASDXPeNZVVWGPyYGAnxcf2nhhjXQE5yOxmgCKx1Hauj62NJg@mail.gmail.com>
In-Reply-To: <CA+ASDXPeNZVVWGPyYGAnxcf2nhhjXQE5yOxmgCKx1Hauj62NJg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzgg5LiK5Y2IIDAyOjM2OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/08/2021 03:53:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166592 [Oct 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/08/2021 03:56:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJyaWFuIE5vcnJpcyA8YnJp
YW5ub3JyaXNAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNiwgMjAy
MSA4OjEwIEFNDQo+IFRvOiBLYWxsZSBWYWxvIDxrdmFsb0Bjb2RlYXVyb3JhLm9yZz4NCj4gQ2M6
IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDAvMjRdIHJ0dzg5OiBhZGQgUmVhbHRlayA4
MDIuMTFheCBkcml2ZXINCj4gDQo+IE9uIE1vbiwgT2N0IDQsIDIwMjEgYXQgMTA6NTIgUE0gS2Fs
bGUgVmFsbyA8a3ZhbG9AY29kZWF1cm9yYS5vcmc+IHdyb3RlOg0KPiA+IFRoaXMgcmVtaW5kcyBt
ZSwgaWYgYW55b25lIGhhcyBhbnkgb2JqZWN0aW9ucyBhYm91dCB0YWtpbmcgdGhpcyB0bw0KPiA+
IHdpcmVsZXNzLWRyaXZlcnMtbmV4dCBzcGVhayB1cCBub3cuIE90aGVyd2lzZSBJIGFzc3VtZSBl
dmVyeW9uZSBhcmUNCj4gPiBoYXBweSB3aXRoIHRoZSBkcml2ZXIuDQo+IA0KPiBJIHJlYWxpemUg
SSBuZXZlciBwcm92aWRlZCBhbnkgZm9ybWFsIHRhZ3MgdG8gdGhpcyBzZXJpZXMuIEknbSBub3QN
Cj4gc3VyZSBJIGNhbiBjb3VudCBhIGZ1bGwgUmV2aWV3ZWQtYnksIGJ1dCB3ZSd2ZSBiZWVuIHBs
YXlpbmcgd2l0aCBpdA0KPiBoZXJlIGZvciBzb21lIHRpbWUsIGFuZCB3aGlsZSBub3QgcGVyZmVj
dCwgaXQncyBjZXJ0YWlubHkgYSBzdGFydDoNCj4gDQo+IFRlc3RlZC1ieTogQnJpYW4gTm9ycmlz
IDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQoNClRoYW5rIHlvdSwgQnJpYW4sDQpJIGFkZCB5
b3VyIFRlc3RlZC1ieSB0byBjb3ZlciBsZXR0ZXIgb2YgdjcuIEkgdGhpbmsgdGhpcyB3b3VsZCBi
ZQ0KY29udmVuaWVudCB0byBLYWxsZS4NCg0KLS0NClBpbmctS2UNCg0K
