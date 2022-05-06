Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEA51E29A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 May 2022 01:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356164AbiEFXzs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 19:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356080AbiEFXzr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 19:55:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2247ACB
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 16:52:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 246NpotZ7030265, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 246NpotZ7030265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 7 May 2022 07:51:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 07:51:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 16:51:50 -0700
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Sat, 7 May 2022 07:51:50 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: Re: [PATCH] rtw88: adjutst adaptivity option to 1
Thread-Topic: [PATCH] rtw88: adjutst adaptivity option to 1
Thread-Index: AQHYYF+q2c+ooO8RDEaLF9Rund/6fK0RrxCAgABSjYA=
Date:   Fri, 6 May 2022 23:51:49 +0000
Message-ID: <90cc751ddc20e5793812bdf42e7ae2fdf4f09448.camel@realtek.com>
References: <20220505090745.158892-1-pkshih@realtek.com>
         <56483fa2-c743-86c8-8790-db00ec79e331@quicinc.com>
In-Reply-To: <56483fa2-c743-86c8-8790-db00ec79e331@quicinc.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.21]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvNiDkuIvljYggMTA6MDA6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <152FF38FEDD237418B8C95527F1E2ECA@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTA2IGF0IDExOjU2IC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6DQo+
IE9uIDUvNS8yMDIyIDI6MDcgQU0sIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBGcm9tOiBDaGlu
LVllbiBMZWUgPHRpbWxlZUByZWFsdGVrLmNvbT4NCj4gPiANCj4gPiBGaW5lIHR1bmUgYWxnb3Jp
dGhtIG9mIGFkYXB0aXZpdHkgc2Vuc2l0aXZpdHkgdG8gYXZvaWQgZGlzY29ubmVjdGluZw0KPiA+
IGZyb20gQVAgc3VkZGVubHkgaW4gZmllbGQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hp
bi1ZZW4gTGVlIDx0aW1sZWVAcmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1L
ZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IA0KPiBuaXQ6IHMvYWRqdXRzdC9hZGp1c3Qv
IGluIHN1YmplY3QNCg0KRml4ZWQgYnkgdjIuDQpUaGFua3MuDQoNCi0tDQpQaW5nLUtlDQoNCg==
