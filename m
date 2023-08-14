Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4977B88C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHNMVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 08:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjHNMU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 08:20:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C6C81BC5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 05:20:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37ECKGSa8022648, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37ECKGSa8022648
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 20:20:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 14 Aug 2023 20:20:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 14 Aug 2023 20:20:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 14 Aug 2023 20:20:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "emmanuel.mazurier@gmail.com" <emmanuel.mazurier@gmail.com>
Subject: Re: rtw89_8852ae : failed to recognize firmware elements
Thread-Topic: rtw89_8852ae : failed to recognize firmware elements
Thread-Index: AQHZzpU1V36L2dqrSEeM3aqDGrDKcK/pMAEA
Date:   Mon, 14 Aug 2023 12:20:35 +0000
Message-ID: <ba862f2103d7321484af73f55f31643570625c08.camel@realtek.com>
References: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
In-Reply-To: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.16.65]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <485A50D7E9BB5345BB8F79F7896F1972@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDExOjUyICswMjAwLCBFbW1hbnVlbCBNYXp1cmllciB3cm90
ZToNCj4gDQo+IEhlbGxvLA0KPiBBZnRlciBhIERlYmlhbiAxMSB1cGRhdGUsIG5ldyBoZWFkZXIg
d2FzIGluc3RhbGxlZCA6IDUuMTAuMC0yNC1hbWQ2NCwNCj4gYW5kIGFmdGVyIHVwZ3JhZGluZyBy
dHc4OSBmaXJtd2FyZSwgdGhlIGRyaXZlciB3YXMgbm90IHJlY29nbml6ZWQgYnkNCj4gdGhlIHN5
c3RlbS4NCj4gDQo+IERtZXNnIGVycm9yIDoNCj4gcnR3ODljb3JlOiBsb2FkaW5nIG91dC1vZi10
cmVlIG1vZHVsZSB0YWludHMga2VybmVsLg0KPiBydHc4OV84ODUyYWUgMDAwMDowOTowMC4wOiBu
b3QgbWZ3IGZvcm1hdA0KPiBydHc4OV84ODUyYWUgMDAwMDowOTowMC4wOiBmYWlsZWQgdG8gcmVj
b2duaXplIGZpcm13YXJlIGVsZW1lbnRzDQoNCldpdGggdGhlc2UgZXJyb3JzLCBpdCBzZWVtcyBs
aWtlIHlvdSBpbnN0YWxsZWQgdGhlIGxhdGVzdCB3aXJlbGVzcy1uZXh0IA0Ka2VybmVsIChha2Eg
a2VybmVsIDYuNi1yYyksIGJ1dCB5b3VyIGZpcm13YXJlIGlzIHRoZSBvbGRlc3QgZmlybXdhcmUN
CnRoYXQgd2UgdXNlZCBpdCBpbiBkZXZlbG9wbWVudCBzdGFnZS4gDQoNClBsZWFzZSBwcm92aWRl
IGJlbG93IGluZm9ybWF0aW9uIHRvIGRpYWdub3NlIHRoaXMgcHJvYmxlbS4NCg0KMS4ga2VybmVs
IHZlcnNpb24geW91IGFyZSB1c2luZw0KJCB1bmFtZSAtYSANCg0KMi4gZmlybXdhcmUgeW91IGFy
ZSB1c2luZw0KJCBscyAtYWwgL2xpYi9maXJtd2FyZS9ydHc4OS9ydHc4ODUyYV9mdy5iaW4NCiQg
bWQ1c3VtIC9saWIvZmlybXdhcmUvcnR3ODkvcnR3ODg1MmFfZncuYmluDQoNCj4gcnR3ODlfODg1
MmFlIDAwMDA6MDk6MDAuMDogZmFpbGVkIHRvIHNldHVwIGNoaXAgaW5mb3JtYXRpb24NCj4gcnR3
ODlfODg1MmFlOiBwcm9iZSBvZiAwMDAwOjA5OjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+
IA0KPiBJIGhhdmUgaW5zdGFsbGVkIHRoZSBmaXJtd2FyZS1yZWFsdGVrIHBhY2thZ2UgdG9vLg0K
PiANCj4gRG8geW91IGhhdmUgYW55IGlkZWEgYWJvdXQgdGhlIHByb2JsZW0gPyBJIGNhbid0IHVz
ZSB3aWZpIGZvciB0aGUgbW9tZW50Lg0KDQoNCkEgcG9zc2libGUgZml4IGlzIHRvIHVwZGF0ZSBm
aXJtd2FyZSB0byB0aGUgbGF0ZXN0IHRoYXQgeW91IGNhbiBkb3dubG9hZA0KaXQgdmlhOg0KaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZmlybXdhcmUvbGlu
dXgtZmlybXdhcmUuZ2l0L3RyZWUvcnR3ODkvcnR3ODg1MmFfZncuYmluDQoNCkkgd2lsbCBhbHNv
IHNlbmQgYSBwYXRjaCB0byBiZSBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGggdGhlIG9sZCBmaXJt
d2FyZQ0KaWYgdGhpcyBwcm9ibGVtIGlzIHJlc29sdmVkLiANCg0KUGluZy1LZQ0KDQoNCg0KDQoN
Cg0K
