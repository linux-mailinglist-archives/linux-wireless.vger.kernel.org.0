Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF10372DD5C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbjFMJLf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjFMJLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 05:11:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C0218E
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 02:11:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35D9B3wcC020333, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35D9B3wcC020333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 13 Jun 2023 17:11:03 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 13 Jun 2023 17:11:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Jun 2023 17:11:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 13 Jun 2023 17:11:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] [v3] wifi: rtw89: cleanup private data structures
Thread-Topic: [PATCH 1/2] [v3] wifi: rtw89: cleanup private data structures
Thread-Index: AQHZmeLF7I5y4wIvdkS4xSw0zcu4uK+H6ukAgAAFEQCAAInLAA==
Date:   Tue, 13 Jun 2023 09:11:21 +0000
Message-ID: <35e41f3fa2cd4985a514655373384462@realtek.com>
References: <20230608082457.36020-1-dmantipov@yandex.ru>
 <168664549483.24637.5306969377701572999.kvalo@kernel.org>
 <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
In-Reply-To: <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
PGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTMsIDIwMjMgNDo1
NiBQTQ0KPiBUbzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4NCj4gQ2M6IFBpbmctS2Ug
U2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBbdjNdIHdpZmk6IHJ0dzg5OiBjbGVhbnVwIHBy
aXZhdGUgZGF0YSBzdHJ1Y3R1cmVzDQo+IA0KPiBPbiA2LzEzLzIzIDExOjM4LCBLYWxsZSBWYWxv
IHdyb3RlOg0KPiANCj4gPiBGYWlsZWQgdG8gYnVpbGQNCj4gDQo+IEhtbS4uLiB3b3JrcyBmb3Ig
bWUgYWdhaW5zdCB1cHN0cmVhbSBhdCBmYjA1NDA5NmFlYTAgdXNpbmcgZm9sbG93aW5nIGNvbmZp
Z3VyYXRpb246DQo+IA0KPiBDT05GSUdfUlRXODk9bQ0KPiBDT05GSUdfUlRXODlfQ09SRT1tDQo+
IENPTkZJR19SVFc4OV9QQ0k9bQ0KPiBDT05GSUdfUlRXODlfODg1MkE9bQ0KPiBDT05GSUdfUlRX
ODlfODg1MkI9bQ0KPiBDT05GSUdfUlRXODlfODg1MkM9bQ0KPiBDT05GSUdfUlRXODlfODg1MkFF
PW0NCj4gQ09ORklHX1JUVzg5Xzg4NTJCRT1tDQo+IENPTkZJR19SVFc4OV84ODUyQ0U9bQ0KPiBD
T05GSUdfUlRXODlfREVCVUc9eQ0KPiBDT05GSUdfUlRXODlfREVCVUdNU0c9eQ0KPiBDT05GSUdf
UlRXODlfREVCVUdGUz15DQo+IA0KDQpSZWJhc2UgeW91ciBwYXRjaCBvbiB0b3Agb2YgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpcmVsZXNzL3dpcmVsZXNz
LW5leHQuZ2l0DQpUaGVuLCBlbmFibGUgDQpDT05GSUdfUlRXODlfODg1MUI9bQ0KQ09ORklHX1JU
Vzg5Xzg4NTFCRT1tDQoNClBpbmctS2UNCg0K
