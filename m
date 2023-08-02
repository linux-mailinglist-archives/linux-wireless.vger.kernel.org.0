Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4976CBF5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjHBLp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjHBLpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:45:53 -0400
Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AA213D
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
        s=relay; t=1690976742;
        bh=82jp7QSJfAsHPjJW7NQYaWO0HKlOjFvXfRyVEkmdIOU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M6bsTLirwFf7fKMxt2WQxieoMw+M+FxyVcGZKWzK/LasANBkEzOH9HC4h4yZJUKbY
         1cbd0n/MpMqguofrDLGbO9O3MpA15V0s2PV+dMfOhpomKtG2f5hItgIhzfAYSFMjrb
         Uirfi25ofr3cz+R+l9sGhqx5J141W7HSrmgWQIS+uX03v/Ah9m8ns38hzK7xowERej
         FzEV7gPdFbqEY/6FJ0jNZxD2HgDKFWSOS8SlioZQ33EWPtKt78extLIoJJsIIgyd73
         Vo3s1ecs3re9OwQhZT/JT3eg+25xDNN1o6LcF4A/UBJo1pV3zP99MBVJNVGaZ2tHPo
         RqjnOb/PbnswA==
X-AuditID: 0a02150a-45bd3700000002e2-37-64ca41e69a26
From:   "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "briannorris@chromium.org" <briannorris@chromium.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH 2/2] [v2] wifi: mwifiex: cleanup TX error
 handling
Thread-Topic: [lvc-project] [PATCH 2/2] [v2] wifi: mwifiex: cleanup TX error
 handling
Thread-Index: AQHZxTbdB3AhrBAsrkeltl6f0HbBaQ==
Date:   Wed, 2 Aug 2023 11:45:41 +0000
Message-ID: <a82ffa610b9e9d4b7500304967882de34d9ce9e2.camel@softline.com>
References: <ZMFzBStAKemf+dLL@google.com>
         <20230728084407.101930-1-dmantipov@yandex.ru>
         <20230728084407.101930-2-dmantipov@yandex.ru> <ZMlHCmjf2ZovExsP@google.com>
In-Reply-To: <ZMlHCmjf2ZovExsP@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F2782F60C53644DAEFEA9E02B69B5D4@softline.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDEwOjU1IC0wNzAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQoN
Cj4gRG8geW91IGFjdHVhbGx5IHJ1biB0aGlzIGRyaXZlciBvbiBhbnl0aGluZywgb3IgYXJlIHlv
dSBqdXN0IGNvbXBpbGUNCj4gdGVzdGluZyAvIHJ1bm5pbmcgc3RhdGljIGFuYWx5c2lzPw0KDQpT
aG9ydCBhbnN3ZXI6IGNvbXBpbGUgdGVzdGluZyBhbmQgc3RhdGljIGFuYWx5c2lzLg0KDQpMb25n
IGFuc3dlcjogdGhpcyBpcyBub3QganVzdCBtZSwgYW5kIGFuIG92ZXJhbGwgcGljdHVyZSBpcyBm
YXIgbW9yZQ0KaW50ZXJlc3RpbmcuIElTUFJBUyAoaHR0cHM6Ly93d3cuaXNwcmFzLnJ1L2VuKSBt
YW5hZ2VzIGEgc29waGlzdGljYXRlZA0Kc3RhdGljIGFuYWx5c2lzIHRvb2wuIFJ1bm5pbmcgb3Zl
ciBMaW51eCBrZXJuZWwgc291cmNlcywgdGhpcyB0b29sDQpwcm9kdWNlcyBhIGxvdCAoSSBkb24n
dCBrbm93IGV4YWN0bHksIGJ1dCBwcm9iYWJseSB0ZW5zIG9mIHRob3VzYW5kcykNCndhcm5pbmdz
IGFib3V0IHBvc3NpYmx5IHVuc2FmZSBhbmQvb3IgaW5jb3JyZWN0IGNvZGUuIFRoZXNlIHdhcm5p
bmdzDQpzaG91bGQgYmUgaW52ZXN0aWdhdGVkIGFuZCwgYWZ0ZXIgZmlsdGVyaW5nIG91dCBpcnJl
bGV2YW50LCBmYWxzZQ0KcG9zaXRpdmUgZXRjLiBjYXNlcywgc29tZSBvZiB0aGVtIG1heSAoYW5k
IHNob3VsZCkgYmUgZml4ZWQuIFRoaXMgd29yaw0KaXMgZGlzdHJpYnV0ZWQgYW1vbmcgbW9yZSB0
aGFuIDMwIGNvbXBhbmllcywgaGFzIGl0cyBvd24gKG5vdCB0b28gdGlnaHQNCmJ1dCBzdGlsbCkg
c2NoZWR1bGUsIGFuZCBpdCdzIG5vdCBhbHdheXMgZWFzeSB0byBpbmNvcnBvcmF0ZSBpdCBpbnRv
DQp0aGUgcmVndWxhciB3b3JrZmxvd3Mgb2YgYSBrZXJuZWwgY29tbXVuaXRpZXMuDQoNCkFzIGZv
ciB0aGUgdGhlIHJlc3Qgb2YgeW91ciBjb21tZW50cywgSSdsbCB0cnkgdG8gYWRkcmVzcyB0aGVt
IGluIGFuDQppbmNvbWluZyB2My4gQW5kIG9mIGNvdXJzZSBncmVhdCB0aGFua3MgZm9yIHlvdXIg
cmV2aWV3cy4NCg0KRG1pdHJ5DQo=
