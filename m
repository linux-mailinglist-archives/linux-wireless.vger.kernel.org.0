Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC23018F6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jan 2021 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAWXnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 18:43:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53241 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725922AbhAWXnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 18:43:25 -0500
X-UUID: e18900ae32d04a14b8e871f6bceeb6a6-20210124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RmcVveeIefgDUgOwS+Ih+AHcK2gejgiXviQUCSu/0RI=;
        b=C+hs7af7OZ/zY/WW9Ipr/O6irl48fLqHhIkK8yUH9eVZwIjGHYT2tb9Nroymj2A90c0HEBoYWbl1UT83gvH600nLWiK4VNM7Adf09MEA/oQ3zc72YhERAgoNyFy4p0w2erXJsGIHV8RAOTdYwYCKQP+0ysb11od1nc/b4d8CEKo=;
X-UUID: e18900ae32d04a14b8e871f6bceeb6a6-20210124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 938142839; Sun, 24 Jan 2021 07:42:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 24 Jan 2021 07:42:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Jan 2021 07:42:34 +0800
Message-ID: <1611445355.17464.1.camel@mtkswgap22>
Subject: Re: [PATCH -next v7 22/22] mt76: mt7921: add sta statistics
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sun, 24 Jan 2021 07:42:35 +0800
In-Reply-To: <8885b6803848b5a4302b523d9cf7430c05478280.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
         <8885b6803848b5a4302b523d9cf7430c05478280.1611389300.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTIzIGF0IDE2OjM1ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgc3RhIHN0YXRpc3RpY3Mgc3VwcG9ydCB0byBxdWVyeSBjdXJyZW50IHR4IGJpdHJhdGUN
Cj4gDQo+IENvLWRldmVsb3BlZC1ieTogU291bCBIdWFuZyA8U291bC5IdWFuZ0BtZWRpYXRlay5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFNvdWwgSHVhbmcgPFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tYWluLmMgIHwg
MjYgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KykNCg0KDQp3aHkgZGlkbid0IHlvdSBqdXN0IG1lcmdlIHRoaXMgaW50byBbLW5leHQsdjcsMDUv
MjJdIG10NzY6IG10NzkyMTogYWRkDQppZWVlODAyMTFfb3BzPw0KDQpSeWRlcg0K

