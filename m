Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4412C2E7EAA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLaIKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Dec 2020 03:10:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52149 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbgLaIKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Dec 2020 03:10:04 -0500
X-UUID: cf74a61f49934849a61f51b8b2d1ea71-20201231
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0YIiBbPcnXnoRpcQRpSuIjCOquv1iDX2d7sxAgSif/8=;
        b=MrkeYOUZowizVdZj0HsVkgAMa/Ch/JPuAJLnG0Q21a/EN/ZjgOcIqZ3KmDeRHlWYzQlR/M1V+sQ+ko0+9dw89zwWZ1uY3Vopwx7DRQ5LySvh182KnF+ZTuCfBbezgW3PpoppnVWvB4JrHmsu74VrKRSwjjqoX1whUq7FBuSGwK4=;
X-UUID: cf74a61f49934849a61f51b8b2d1ea71-20201231
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 283783325; Thu, 31 Dec 2020 16:09:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 31 Dec 2020 16:09:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Dec 2020 16:09:16 +0800
Message-ID: <1609402157.22614.3.camel@mtkswgap22>
Subject: Re: [PATCH -next v4 03/13] mt76: mt7921: add MAC support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Thu, 31 Dec 2020 16:09:17 +0800
In-Reply-To: <3969b56ae9211955428fad2aeba695416362a095.1609347310.git.objelf@gmail.com>
References: <cover.1609347310.git.objelf@gmail.com>
         <3969b56ae9211955428fad2aeba695416362a095.1609347310.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTMxIGF0IDAyOjA2ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgUnggcGFja2V0IGRlc2NyaXB0aW9uIHBhcnNpbmcsIFR4IHBhY2tldCBkZXNjcmlwdGlv
biBjb21wb3NpdG9uLCBoYW5kbGUNCj4gcGFja2V0IHJlY3ljbGluZyBhbmQgcHJvdmlkZSBNQUMg
aW5mb3JtYXRpb24gbXQ3NiBjb3JlIG5lZWRzIHRvIHN1cHBvcnQNCj4gbWFjODAyMTEuDQo+IA0K
PiBDby1kZXZlbG9wZWQtYnk6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4N
Cj4gU2lnbmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0K
PiBDby1kZXZlbG9wZWQtYnk6IFNvdWwgSHVhbmcgPFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTb3VsIEh1YW5nIDxTb3VsLkh1YW5nQG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0N
Cg0KVHJpbSB0aGUgY29kZS4gUGxlYXNlIHRha2UgdGhlc2UgZml4dXBzIGludG8gYWNjb3VudC4N
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRj
aC82NTMzNjE0OGI1ZDQ0MGRjZWI5NjdhNDAxNDg4YjExOWUxNGI5YzVhLjE2MDcxMjQ2NTIuZ2l0
LnJ5ZGVyLmxlZUBtZWRpYXRlay5jb20vDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvNjlkNjJjZDQwYWU1MmUwZGRkNWIyNmJhOTZiYzc0
ODAzODU1ODVhNS4xNjA3NTc4NjAxLmdpdC5yeWRlci5sZWVAbWVkaWF0ZWsuY29tLw0KDQpSeWRl
cg0KDQo=

