Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9F036B9CD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhDZTMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:12:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49846 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234229AbhDZTMO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:12:14 -0400
X-UUID: ff762dbe13384c90b7ded19508ef7655-20210427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CQizQsUhJwGeUX8UCIeiU1Bi7+NJCgQWE99CedcvQtU=;
        b=TqWWWwhkjBYvtkxlVswuEHL3f1S5h2abOj4IBiohQK9slv8cqIa0/u3X3IygzN9WF5iiJSlgEvylaNDRiwn6KlmSBN6o70yoYj4CW4b5LurjKgo+I1BXlO+ghi6S+NkATPx70ALHHAWW5Jn1V0I2p1+ZW1fQKNKYmUjGyseGgUg=;
X-UUID: ff762dbe13384c90b7ded19508ef7655-20210427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 823824630; Tue, 27 Apr 2021 03:11:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 03:11:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Apr 2021 03:11:27 +0800
Message-ID: <1619464287.15845.2.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] mt76: mt7915: add .set_bitrate_mask() callback
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Ben Greear <greearb@candelatech.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 27 Apr 2021 03:11:27 +0800
In-Reply-To: <7776c0d1-0578-5922-1003-f8498cc0357a@candelatech.com>
References: <22e4a169831b6b54661b6eb4ef4f3a4a18dceb19.1619453772.git.ryder.lee@mediatek.com>
         <d422f0c844c5da1ee027250820b67f615a8b50e5.1619453772.git.ryder.lee@mediatek.com>
         <7776c0d1-0578-5922-1003-f8498cc0357a@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0D5CD2055A3D98DF91B752F15436670F9F853D1953D45325ABD51BB99ACBC1CF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTI2IGF0IDExOjQxIC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiBP
biA0LzI2LzIxIDk6MjkgQU0sIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiBBZGQgcnVudGltZSBjb25m
aWd1cmF0aW9uIGZvciBiaXRyYXRlIG1hc2suIE5vdGUgdGhhdCBHSSBjYW5ub3QgYmUgc2V0dXAu
DQo+ID4gDQo+ID4gRXhhbXBsZToNCj4gPiBpdyBkZXYgd2xhbjAgc2V0IGJpdHJhdGVzIHZodC1t
Y3MtNSAxOjkgaGUtbWNzLTUgMjo3DQo+ID4gaXcgZGV2IHdsYW4wIHNldCBiaXRyYXRlcyBsZWdh
Y3ktNSA2IGhlLW1jcy01IDI6MC0xMQ0KPiANCj4gSXMgdGhpcyBvbmx5IGZvciBkYXRhIGZyYW1l
cz8gIEluIG90aGVyIHdvcmRzLCBpcyBpdCBPSyB0bw0KPiBzZXQgZXhhY3RseSBvbmUgSEUvVkhU
IE1DUyByYXRlIGFuZCBsZXQgbWd0LCBiY2FzdCwgbWNhc3QsIHN0aWxsDQo+IHdvcmsgT0sgYXQg
bGVnYWN5IHJhdGVzPw0KPiANCj4gVGhhbmtzLA0KPiBCZW4NCj4gDQpZZXMuIEFuZCB0aGlzJ3Mg
bW9yZSBsaWtlIGEgJ2xpbWl0JywgYW5kIGl0IGFjdHVhbGx5IHJlLWluaXRpYWxpemVzDQpmaXJt
d2FyZSByYXRlIGNvbnRyb2wgZm9yIGVhY2ggcGVlciB0byBhZGQgYSBib3VuZHJ5IG9uIHRvcCBv
ZiByYXRlDQp0YWJsZS4gV2hlbiB5b3Ugc3BlY2lmeSBzb21ldGhpbmcgbGlrZSAnaXcgZGV2IHds
YW4wIHNldCBiaXRyYXRlcw0Kdmh0LW1jcy01IDE6OScsIHdoaWNoIG1lYW5zIG5zcz0xIG1jczAt
OSBhY3R1YWxseS4gSWYgeW91IHdvdWxkIGxpa2UNCnN0aWNrIHRvIGEgZml4ZWQgcmF0ZSB0aGVu
IHRoZXJlJ3MgYSBrbm9iIGluIG10NzkxNSBkZWJ1Z2ZzLg0KQXMgZm9yIG90aGVyIHRoZSBtZ210
LCBtY2FzdCwgYmNhc3Qgc2hvdWxkIHNpbGwgcmVtYWluIGluIGxvdyByYXRlLg0KDQo=

