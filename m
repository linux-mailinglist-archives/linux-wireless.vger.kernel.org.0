Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA66F0F95
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 02:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjD1A2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 20:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbjD1A2G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 20:28:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265002711
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 17:28:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33S0RwAxA007913, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33S0RwAxA007913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 28 Apr 2023 08:27:58 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Apr 2023 08:28:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Apr 2023 08:28:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 28 Apr 2023 08:28:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Support USB RX aggregation for the newer chips
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Support USB RX aggregation for the
 newer chips
Thread-Index: AQHZd3YBRqvsvBx7M0Gly4YN2+20G68/4YBQ
Date:   Fri, 28 Apr 2023 00:28:00 +0000
Message-ID: <803d82eeb9e8458ca439f23134142b2d@realtek.com>
References: <16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com>
In-Reply-To: <16d2d1ff-6438-10c9-347f-6e14dd358ccf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI1LCAy
MDIzIDk6MDEgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gd2lmaTogcnRsOHh4eHU6IFN1
cHBvcnQgVVNCIFJYIGFnZ3JlZ2F0aW9uIGZvciB0aGUgbmV3ZXIgY2hpcHMNCj4gDQo+IFRoZSBk
cml2ZXIgY2FuIHJlY2VpdmUgc2V2ZXJhbCBmcmFtZXMgaW4gdGhlIHNhbWUgVVNCIHRyYW5zZmVy
Lg0KPiBBZGQgdGhlIGNvZGUgdG8gaGFuZGxlIHRoaXMgaW4gcnRsOHh4eHVfcGFyc2VfcnhkZXNj
MjQoKSwgZXZlbiB0aG91Z2gNCj4gY3VycmVudGx5IGFsbCB0aGUgcmVsZXZhbnQgY2hpcHMgc2Vu
ZCBvbmx5IG9uZSBmcmFtZSBwZXIgVVNCIHRyYW5zZmVyDQo+IChSVEw4NzIzQlUsIFJUTDgxOTJF
VSwgUlRMODE4OEZVLCBSVEw4NzEwQlUpLg0KPiANCj4gVGhpcyB3YXMgdGVzdGVkIHdpdGggUlRM
ODE4OEZVLCBSVEw4MTkyRVUsIFJUTDg3MTBCVSwgYW5kIFJUTDgxOTJGVS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+
IHYyOg0KPiAgLSBTdWdnZXN0aW9uIGJ5IFBpbmctS2UgU2hpaDoNCj4gICAgLSBBZGQgdmFyaWFi
bGUgaGRyIHRvIG1ha2UgYSBsb25nIGxpbmUgc2hvcnRlci4NCj4gIC0gRG9uJ3Qgc2F5IHJ0bDh4
eHh1X3BhcnNlX3J4ZGVzYzE2KCkgYWxyZWFkeSBoYW5kbGVzIFJYIGFnZ3JlZ2F0aW9uLg0KPiAg
ICBUaGF0IGZ1bmN0aW9uIG5lZWRzIG1vcmUgd29yay4NCj4gLS0tDQoNClsuLi5dDQoNCg==
