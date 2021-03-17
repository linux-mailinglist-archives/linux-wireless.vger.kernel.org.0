Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BF33EC1D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Mar 2021 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhCQJCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 05:02:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45090 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229791AbhCQJCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 05:02:11 -0400
X-UUID: 55ea8d88e39648cebb49f755b1cd679d-20210317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bP1JIVhz8tGSM0Ac7THmvms6DCOPcIoJsm1v6ns4Eq4=;
        b=K2PDRcpm1CcraQX+GXMSvL1EHDwq0RHX87wqjcq58HRzYsuUbA167V5+gg34BcfoJCJ9xMdypJvC0zrKbJ4AEhIsGEN0avsvQn0ISaWo4TaiM86KcBhVkF/dldyOj8r6yIXUZn9Xhm3oamhO/fkQ7NfIQhpsj1Z0b2AB30x/FPs=;
X-UUID: 55ea8d88e39648cebb49f755b1cd679d-20210317
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2003114022; Wed, 17 Mar 2021 17:02:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar
 2021 17:02:05 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Mar 2021 17:02:04 +0800
Message-ID: <1615971725.19256.0.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: move de-amsdu buffer per-phy
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        <lorenzo.bianconi@redhat.com>
Date:   Wed, 17 Mar 2021 17:02:05 +0800
In-Reply-To: <3cebac3977b265fb6207baeaadd577a286548cb3.1615971393.git.lorenzo@kernel.org>
References: <3cebac3977b265fb6207baeaadd577a286548cb3.1615971393.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTE3IGF0IDA5OjU3ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBtdDc2MTVkIHVzZXJzIHJlcG9ydCB0aGUgZm9sbG93aW5nIGNyYXNoIHJ1bm5pbmcgYm90
aCBwaHkgY29uY3VycmVudGx5Og0KPiANCj4gWyAgMTQ3LjI3MzkwOV0gQ1BVIDEgVW5hYmxlIHRv
IGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAw
LCBlcGMgPT0gOGU0ZjI4OGMsIHJhID09IDhlNThhOTY4DQo+IFsgIDE0Ny4yODQ1NzBdIE9vcHNb
IzFdOg0KPiBbICAxNDcuMjg2ODU0XSBDUFU6IDEgUElEOiAzNzI0IENvbW06IGt3b3JrZXIvdTk6
MyBOb3QgdGFpbnRlZCA1LjQuMTA1ICMwDQo+IFsgIDE0Ny4yOTM0MDNdIFdvcmtxdWV1ZTogbmFw
aV93b3JrcSBuYXBpX3dvcmtmbg0KPiBbICAxNDcuMjk3NzQyXSAkIDAgICA6IDAwMDAwMDAwIDAw
MDAwMDAxIDhlNTk1ZWMwIDAwMDAwMDAwDQo+IFsgIDE0Ny4zMDI5NTBdICQgNCAgIDogOGU1OTVl
YzAgMDAwMDAwMDAgOGU1Y2E2MDAgMDAwMDAwMDANCj4gWyAgMTQ3LjMwODE2MV0gJCA4ICAgOiAw
MDAwMDAwMCAwMDAwMDRjMSA4MDgwODA4MCBmZWZlZmVmZg0KPiBbICAxNDcuMzEzMzcwXSAkMTIg
ICA6IDAwMDAwMDAwIDAwMDAwMDAwIDgwNzA0ZjFjIDAwMDAwMDQwDQo+IFsgIDE0Ny4zMjM3ODFd
ICQyMCAgIDogMDAwMDAwNTAgMDAwMDAwNDQgMDAwMDAwMTEgMDFjZTk1MDINCj4gWyAgMTQ3LjMz
NDE5NV0gJDI4ICAgOiA4ZTAwNDAwMCA4ZTAwNWQxOCA4ZGRmMjAyMCA4ZTU4YTk2OA0KPiBbICAx
NDcuMzQyMjY2XSBMbyAgICA6IDAwMDAwMDAwDQo+IFsgIDE0Ny4zNTAzOTddIHJhICAgIDogOGU1
OGE5NjggbXQ3NjE1X3F1ZXVlX3J4X3NrYisweDk0Yy8weGQwYyBbbXQ3NjE1X2NvbW1vbl0NCj4g
WyAgMTQ3LjM2MTU4MF0gQ2F1c2UgOiA0MDgwMDAwYyAoRXhjQ29kZSAwMykNCj4gWyAgMTQ3LjM2
ODQzNF0gUHJJZCAgOiAwMDAxOTkyZiAoTUlQUyAxMDA0S2MpDQo+IFsgIDE0Ny40NTY5NjVdIFBy
b2Nlc3Mga3dvcmtlci91OTozIChwaWQ6IDM3MjQsIHRocmVhZGluZm89OWVjZTY4ZDYsIHRhc2s9
YjE2ZDE1NWYsIHRscz0wMDAwMDAwMCkNCj4gWyAgMTQ3LjQ3Mzg1N10gICAgICAgICAwMDAxY2U5
NSAwMDAwNDE4OCAwMDAwMDAwMCAwMDAwMDA4MCAwMDAwNGMxMCAwMDAwMDAwMiA4MDc0YTJiOCA4
MDA0M2RjYw0KPiBbICAxNDcuNDkwNTA1XSAgICAgICAgIDAwMDAwMDAwIDhlNGYwMTEwIDgwNjlk
ZGY0IDgwNmFiMTQ4IDhkZmMwMDAwIDAwMDAxMDAwIDAwMDAwMDAwIDAwMDAwMDUwDQo+IFsgIDE0
Ny41MDcxNTBdICAgICAgICAgLi4uDQo+IFsgIDE0Ny41MTIwMzNdIFs8OGU0ZjI4OGM+XSBtdDc2
X3J4KzB4MTI0LzB4MzIwIFttdDc2XQ0KPiBbICAxNDcuNTI2NjMzXQ0KPiBbICAxNDcuNTI4NTEy
XSAtLS1bIGVuZCB0cmFjZSAzZDEzN2U3NWJiMTA5MTQ5IF0tLS0NCj4gDQo+IFRoZSBpc3N1ZSBo
YXMgYmVlbiBpbnRyb2R1Y2UgZW5hYmxpbmcgaHcgcnggZGUtYW1zZHUgc2luY2UgdGhlIGh3IGNh
bg0KPiBpbnRlcmxlYXZlIGFtc2R1IGZyYW1lcyBmcm9tIGJvdGggcGh5LiBGaXggdGhlIGlzc3Vl
IG1vdmluZyB0aGUgZGUtYW1zZHUNCj4gYnVmZmVyIHBlci1waHkuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQoNCkFja2VkLWJ5OiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQoNCg==

