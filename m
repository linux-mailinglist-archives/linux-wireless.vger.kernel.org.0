Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E71621F3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgBRIBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 03:01:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58605 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgBRIBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 03:01:30 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01I81ESJ021808, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01I81ESJ021808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 16:01:14 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 18 Feb 2020 16:01:14 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 18 Feb 2020 16:01:13 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Tue, 18 Feb 2020 16:01:13 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "anbeltra@microsoft.com" <anbeltra@microsoft.com>
Subject: RE: [PATCH] rtw88: set WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, mac80211 supports it
Thread-Topic: [PATCH] rtw88: set WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, mac80211
 supports it
Thread-Index: AQHV4iunB0uxwvYUW0iv/UaRD7VTE6gYXWgAgAABrICACD7PgA==
Date:   Tue, 18 Feb 2020 08:01:13 +0000
Message-ID: <d6cadaa3aa0e4f4092291df0fa926a76@realtek.com>
References: <20200213050819.13467-1-yhchuang@realtek.com>
 <3121eb67-f303-01e4-a006-a39947381175@broadcom.com>
 <c02f6e1f-c345-0ca0-0a7b-0997926d3860@broadcom.com>
In-Reply-To: <c02f6e1f-c345-0ca0-0a7b-0997926d3860@broadcom.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBPbiAyLzEzLzIwMjAgMTA6NTYgQU0sIEFyZW5kIFZhbiBTcHJpZWwgd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+IE9uIDIvMTMvMjAyMCA2OjA4IEFNLCB5aGNodWFuZ0ByZWFsdGVrLmNvbSB3cm90ZToN
Cj4gPj4gRnJvbTogWWFuLUhzdWFuIENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+ID4+
DQo+ID4+IFNldCB3aXBoeSBmbGFnIFdJUEhZX0ZMQUdfSEFTX1JFTUFJTl9PTl9DSEFOTkVMLCBi
ZWNhdXNlDQo+IG1hYzgwMjExDQo+ID4+IGFjdHVhbGx5IHN1cHBvcnRzIGl0LiBXaXRoIHRoZSBm
bGFnIHNldCwgZHJpdmVyIGNhbiBhY2NlcHQgUk9DDQo+ID4+IGV2ZW50IGZyb20gd3BhX3N1cHBs
aWNhbnQgb3Igc29tZSBvdGhlciB1c2VyIHNwYWNlIHRvb2xzLg0KPiA+DQo+ID4gVGhpcyBkb2Vz
IG5vdCBzZWVtIHJpZ2h0LiBtYWM4MDIxMSBkb2VzIHNldCB0aGlzIGZsYWcgaXRzZWxmIHdoZW4g
dGhlDQo+ID4gZHJpdmVyIHByb3ZpZGVzIHJlbWFpbl9vbl9jaGFubmVsIGNhbGxiYWNrLiBEb2Vz
IHRoYXQgbWVhbiB5b3UgYWxyZWFkeQ0KPiA+IGhhdmUgdGhhdCBjYWxsYmFjaz8gVGhpcyBwYXRj
aCBpcyBlaXRoZXIgd3Jvbmcgb3IgdW5uZWNlc3NhcnkuDQo+IA0KPiBSZS1yZWFkaW5nIHRoZSBj
b21taXQgbWVzc2FnZSBJIGd1ZXNzIGl0IGlzIG9rIHRvIGNsYWltDQo+IHJlbWFpbi1vbi1jaGFu
bmVsIHN1cHBvcnQgd2hlbiB1c2luZyBzd19zY2FuLiBJZiB0aGlzIGlzIHRydWUgaXQgc2VlbXMN
Cj4gYmV0dGVyIHRvIGV4dGVuZCB0aGUgY29uZGl0aW9uIGluIGllZWU4MDIxMV9hbGxvY19od19u
bSgpIGZvciBzZXR0aW5nDQo+IHRoZSBmbGFnLg0KPiANCg0KSXQgbG9va3MgbGlrZSB3ZSBjYW4g
c2V0IHRoZSBmbGFnIGluIGllZWU4MDIxMV9hbGxvY19od19ubSgpLiBTdWNoIGFzOg0KaWYgKCF1
c2VfY2hhbl9jdHggfHwgKHVzZV9jaGFuX2N0eCAmJiBvcHMtPnJlbWFpbl9vbl9jaGFubmVsKSku
DQoNCllhbi1Ic3Vhbg0K
