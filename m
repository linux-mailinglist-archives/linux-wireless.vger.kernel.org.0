Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA273BC4BE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 04:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGFC0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jul 2021 22:26:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39921 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229760AbhGFC0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jul 2021 22:26:30 -0400
X-UUID: a3de7fc174274b1db267cde38c84c1ff-20210706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=S5q2VFppu4KoAu2S+UaRDV/ckuPmh1QtZnSnhK3+8RQ=;
        b=ALeqrIWrRmdlfB0I8jHhdb8JoQoBJ1KiEtfdE5BH0rzIIZRmuz35NlaTb6rhHvGhJGUEmeaRD+QZ9dtu8PDAyf6N4bVCyYrJAFHsfV0e4+UGiZFSssyI/pA2CLvNmycHg6+ABjaASJZdwNWjYAv/i+X0cvgxfknBuE6JyT2eoks=;
X-UUID: a3de7fc174274b1db267cde38c84c1ff-20210706
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 637571671; Tue, 06 Jul 2021 10:23:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Jul
 2021 10:23:44 +0800
Received: from [10.19.240.15] (10.19.240.15) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Jul 2021 10:23:43 +0800
Message-ID: <1625538223.21641.1.camel@mcddlt001.gcn.mediatek.inc>
Subject: Re: [PATCH] mt76: mt7915: cleanup miscellaneous errors and
 redundant codes
From:   WCDSE <bo.jiao@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Tue, 6 Jul 2021 10:23:43 +0800
In-Reply-To: <87sg0sgbov.fsf@tynnyri.adurom.net>
References: <20210702083949.4431-1-bo.jiao@mediatek.com>
         <87sg0sgbov.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 477F0D29A4D6719797CFD3710DFAC2E470CF6F177F235CAC9C0B684527F33AA92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTA1IGF0IDE1OjU3ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBC
byBKaWFvIDxiby5qaWFvQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBCbyBK
aWFvIDxCby5KaWFvQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IGNsZWFudXAgbWlzY2VsbGFuZW91
cyBlcnJvcnMgYW5kIHJlZHVuZGFudCBjb2Rlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJv
IEppYW8gPEJvLkppYW9AbWVkaWF0ZWsuY29tPg0KPiANCj4gUGxlYXNlIHNwbGl0IHRoaXMgdG8g
c21hbGxlciBwYXRjaGVzLCBvbmUgZml4IHBlciBwYXRjaCBhbmQgd3JpdGUgcHJvcGVyDQo+IGNv
bW1pdCBsb2dzLiBTZWUgbW9yZSBpbmZvIGluIHRoZSB3aWtpIGJlbG93Lg0KPiANCmhpIEthbGxl
LCBnb3QgaXQsIGkgd2lsbCBtb2RpZnkgaXQgQVNBUC4NCmhpIEZlbGl4LCBwbGVhc2UgZHJvcCB0
aGlzIG9uZSwgaSB3aWxsIHNwbGl0IHRoaXMgdG8gc21hbGxlciBwYXRjaGVzDQp3aXRoIHByb3Bl
ciBsb2dzLiB0aGFua3MNCg0K

