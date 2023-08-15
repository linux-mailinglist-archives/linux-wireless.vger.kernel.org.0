Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35977CC53
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjHOMH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 08:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjHOMHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 08:07:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8538C10F9
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 05:07:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37FC6patE025489, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37FC6patE025489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Aug 2023 20:06:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 15 Aug 2023 20:07:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 15 Aug 2023 20:07:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 15 Aug 2023 20:07:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH v2] wifi: rtw89: regd: update regulatory map to R64-R42
Thread-Topic: [PATCH v2] wifi: rtw89: regd: update regulatory map to R64-R42
Thread-Index: AQHZxmiwHogBN0SpWUOmufub0xB3m6/qzvMA
Date:   Tue, 15 Aug 2023 12:07:10 +0000
Message-ID: <67e282c68f08d237480f4141e6a26bff8fc6fd2c.camel@realtek.com>
References: <20230804001322.4131-1-pkshih@realtek.com>
In-Reply-To: <20230804001322.4131-1-pkshih@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.65]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE75788BC203594EA1D92E288DC99F3C@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDA4OjEzICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
IEZyb206IFpvbmctWmhlIFlhbmcgPGtldmluX3lhbmdAcmVhbHRlay5jb20+DQo+IA0KPiBTeW5j
IFJlYWx0ZWsgUmVndWxhdG9yeSBSNDIgYW5kIFJlYWx0ZWsgQ2hhbm5lbCBQbGFuIFI2NCwgd2hp
Y2ggY29uZmlndXJlcw0KPiBSZWFsdGVrIDYgR0h6IHJlZ2QgZm9yIHNvbWUgY291bnRyaWVzIGFz
IGJlbG93Lg0KPiAgKiBBUiwgTVgsIEhUIC0+IEZDQw0KPiAgKiBMQiwgWkEsIFRILCBCRiwgTEEs
IE1OIC0+IEVUU0kNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpvbmctWmhlIFlhbmcgPGtldmluX3lh
bmdAcmVhbHRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQpTaW5jZSBuZXdlciBSZWFsdGVrIHJlZ3VsYXRvcnkvY2hhbm5lbCBwbGFu
IChSNjQtUjQzKSBpcyByZWxlYXNlZCwNCkkgaGF2ZSBzZW50IHYzIHRvIHJlcGxhY2UgdGhpcy4g
U28sIHBsZWFzZSBkcm9wIHRoaXMgcGF0Y2guIA0KDQpUaGFua3MNClBpbmctS2UNCg0K
