Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DBF1FD3CF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFQRzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 13:55:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43330 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726496AbgFQRzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 13:55:11 -0400
X-UUID: b0e7abc121b04e139ab35c4498a2517c-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lEpnsooQOqyPsIAb2Bved/k0mjvxmhpJkAiq6dVcAAM=;
        b=FGpUqpFYaB2Avpnop7Edcki10zvd7nCdnMPiTj0yyBj+2RRRLj82ieBoKxz1GysADmrA448ZI4HPCYq3O9KhL/ybNhWMxSxIa3PzD2b0x6K4h0cG97rJl1RDlpTuZZ8YExw9ZAspiMOiUBJscpgYgMaV9wDJvMd9i7qPsPuqMwY=;
X-UUID: b0e7abc121b04e139ab35c4498a2517c-20200618
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1995106208; Thu, 18 Jun 2020 01:55:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Jun
 2020 01:55:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Jun
 2020 01:55:02 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 01:55:02 +0800
Message-ID: <1592416505.14098.2.camel@mtkswgap22>
Subject: Re: mediatek mt7915 status and devices?
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Marek Behun <marek.behun@nic.cz>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>
Date:   Thu, 18 Jun 2020 01:55:05 +0800
In-Reply-To: <20200617185912.631766ff@nic.cz>
References: <20200617185912.631766ff@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDE4OjU5ICswMjAwLCBNYXJlayBCZWh1biB3cm90ZToNCj4g
SGVsbG8sDQo+IA0KPiB3aGF0IGlzIHRoZSBjdXJyZW50IHN0YXR1cyBvZiB0aGlzIGRyaXZlcj8g
SXMgaXQgYWxyZWFkeSB1c2FibGUgYXMgYQ0KPiBzdGFibGUgQVAgZm9yIDgwMi4xMWF4Pw0KPiAN
Cj4gQW5kIGFyZSB0aGVyZSBzb21lIFdpRmkgY2FyZHMgdXRpbGl6aW5nIHRoaXMgY2hpcHNldD8g
V2Ugd291bGQgbGlrZSB0bw0KPiBsb29rIGludG8gdGhpcyBmb3IgdGhlIFR1cnJpcyByb3V0ZXJz
Lg0KPiANCj4gTWFyZWsNCg0Kc3RpbGwgbmVlZCBzb21lIGZpbmUtdHVuaW5nLiBJIHRoaW5rIHdl
IHdpbGwgZ2V0IGl0IGRvbmUgaW4gUTQuDQoNClJ5ZGVyDQoNCg0K

