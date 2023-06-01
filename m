Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1D718FBD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 02:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFAAyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjFAAyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 20:54:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337B125
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 17:54:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3510rCqK5013695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3510rCqK5013695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 1 Jun 2023 08:53:12 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 1 Jun 2023 08:53:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 1 Jun 2023 08:53:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 1 Jun 2023 08:53:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: RE: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and RTX_POWER_AFTER_IQK_A reads
Thread-Topic: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and
 RTX_POWER_AFTER_IQK_A reads
Thread-Index: AQHZkxBmPVoxZYMjUEiVPr+B6yKXPa9yj+sAgAAMRgCAAAgdAIAA4Yuw///Vs4CAAcMWUA==
Date:   Thu, 1 Jun 2023 00:53:25 +0000
Message-ID: <598d8c97c3c248d9a9cb5685ec807509@realtek.com>
References: <20230530155446.555091-1-dmantipov@yandex.ru>
 <b747b45e-e176-4c55-0886-abfcb1e33717@lwfinger.net>
 <09191d90-c29d-bdf5-4192-19553f8911fd@yandex.ru>
 <bee18794-8c4a-2af9-cf1c-807969be3dd2@lwfinger.net>
 <c861d21d606441c9bf40ff963090d098@realtek.com>
 <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
In-Reply-To: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IEFudGlwb3Yg
PGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDMxLCAyMDIzIDE6
NTEgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgTGFycnkgRmlu
Z2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBDYzogS2FsbGUgVmFsbyA8a3ZhbG9A
a2VybmVsLm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RA
bGludXh0ZXN0aW5nLm9yZzsgRG1pdHJpeQ0KPiBBbnRpcG92IDxEbWl0cml5LkFudGlwb3ZAc29m
dGxpbmUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBydGx3aWZpOiBydGw4MTg4ZWU6IGRy
b3AgUlRYX1BPV0VSX0JFRk9SRV9JUUtfQSBhbmQgUlRYX1BPV0VSX0FGVEVSX0lRS19BIHJlYWRz
DQo+IA0KPiAzLiBJbiBnZW5lcmFsLCBpcyBpdCBhbHdheXMgKG9yIGp1c3Qgc29tZXRpbWVzKSBy
ZXF1aXJlZCB0byByZWFkIChzb21lDQo+IHN1YnNldCBvZj8pIEJCIHJlZ2lzdGVycyBldmVuIGlm
IHdlIGRvbid0IGludGVyZXN0ZWQgaW4gdGhlaXIgdmFsdWVzPw0KPiBJcyBpdCBleHBsaWNpdGx5
IHJlcXVpcmVkIGJ5IHRoZSBoYXJkd2FyZSBkZXNpZ24/DQo+IA0KDQpJIHRoaW5rIGl0IGlzbid0
IGFsd2F5cyByZXF1aXJlZCBiYXNpY2FsbHkuIEhvd2V2ZXIsIGZvciB0aGlzIGNhc2UsIEkgY2Fu
J3QgZmluZA0KdGhlIGF1dGhvciB0byBrbm93IGlmIHdlIGNhbiByZW1vdmUgdGhlIHN0YXRlbWVu
dHMuIFRoZXJlIGlzIGEgZGVsYXkgdG8NCm1ha2Ugc3VyZSB0aGVzZSByZWFkIG9wZXJhdGlvbnMg
Y2FuIGdldCBjb3JyZWN0IHZhbHVlcywgc28gSSBzdWdnZXN0IHRvIGhhdmUNCnNpbWlsYXIgY2hh
bmdlcyBsaWtlIDZjNzVlYWIwNDE3YjllNWIwNWExOGRiZmMzNzNlMjdhOGVmODc2ZDggeW91IG1l
bnRpb25lZCBpZg0Kd2UgcmVhbGx5IHdhbnQgdGhpcyBwYXRjaC4NCg0KUGluZy1LZQ0KDQo=
