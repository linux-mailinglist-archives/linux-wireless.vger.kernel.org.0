Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1596A3AA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfGPIPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 04:15:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40439 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfGPIPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 04:15:36 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6G8FSLF014703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6G8FSLF014703
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 16 Jul 2019 16:15:28 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0439.000; Tue, 16 Jul 2019 16:15:28 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 09/11] rtw88: remove all RTW_MAX_POWER_INDEX macro
Thread-Topic: [PATCH 09/11] rtw88: remove all RTW_MAX_POWER_INDEX macro
Thread-Index: AQHVFfPS6D83e0nErUeevNRiNtjH/6bFt4WAgAd5SeA=
Date:   Tue, 16 Jul 2019 08:15:27 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D1868F19@RTITMBSVM04.realtek.com.tw>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
 <1559116487-5244-10-git-send-email-yhchuang@realtek.com>
 <CA+ASDXMWYhORB7=bCh84BO1wuPdAa7dpTSyTWuUYzanfTYA=Pw@mail.gmail.com>
In-Reply-To: <CA+ASDXMWYhORB7=bCh84BO1wuPdAa7dpTSyTWuUYzanfTYA=Pw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA5LzExXSBydHc4ODogcmVtb3ZlIGFsbCBSVFdfTUFYX1BP
V0VSX0lOREVYDQo+IG1hY3JvDQo+IA0KPiBJIHJlYWxpemUgdGhpcyBpcyBhbHJlYWR5IHVwc3Ry
ZWFtLCBidXQgSSB0aG91Z2h0IEknZCBhc2sgaGVyZSwgc2luY2UNCj4gSSB3YXMgZ29pbmcgYmFj
ayBhbmQgcmV2aWV3aW5nIHNvbWUgb2YgdGhpczoNCj4gDQo+IE9uIFdlZCwgTWF5IDI5LCAyMDE5
IGF0IDEyOjU1IEFNIDx5aGNodWFuZ0ByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBUenUtRW4gSHVhbmcgPHRlaHVhbmdAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBTaW5jZSB0aGlz
IG1hY3JvIGRlZmluaXRpb24gaGFzIGRpZmZlcmVudCB2YWx1ZXMgaW4gZGlmZmVyZW50IGNoaXBz
ZXQsDQo+ID4gdGhlIGN1cnJlbnQgZGVmaW5lZCBtYWNybyB2YWx1ZSBpcyBmb3IgODgyMmIuIFRo
aXMgd2lsbCBjYXVzZSB0aGUNCj4gPiBzZXR0aW5ncyBvZiA4ODIyYyBiZSBpbmNvcnJlY3QuDQo+
IA0KPiBeXiBJcyB0aGlzIGFjdHVhbGx5IGNvcnJlY3QsIHRoYXQgODgyMmIgd2FzIGNvcnJlY3Qg
YW5kIDg4MjJjIHdhcw0KPiB3cm9uZz8gQmVjYXVzZSBJIHNlZSBSVFdfTUFYX1BPV0VSX0lOREVY
IHVzZWQgdG8gYmUgZGVmaW5lZCBhcyAweDdmLA0KPiBhbmQgcnR3ODgyMmNfaHdfc3BlYy5tYXhf
cG93ZXJfaW5kZXggYWxzbyBhcHBlYXJzIHRvIGJlIDB4N2YuIFdoaWNoDQo+IHdvdWxkIHNvdW5k
IGxpa2UgODgyMmIgKCpiKiwgbm90IGMpIHdhcyB3cm9uZywgYXMgaXQgbGlzdHMgMHgzZi4NCj4g
DQo+IEFueXdheSwgSSdtIGdvaW5nIHRvIGFzc3VtZSB5b3UgZ290IHRoZSBjaGFuZ2UgcmlnaHQs
IGFuZCB5b3UganVzdA0KPiBtaXMtc3Bva2UgaW4gdGhlIGRlc2NyaXB0aW9uLg0KDQpZZXMsIEkg
dGhpbmsgaGUganVzdCBtaXMtc3Bva2UgaXQsIGFuZCB0aGUgY29kZSBpcyByaWdodC4NCg0KVGhh
bmtzDQpZYW4tSHN1YW4NCg==
