Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270783018F7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jan 2021 00:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAWXto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 18:49:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbhAWXto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 18:49:44 -0500
X-UUID: baf8a03389214aa7bdc81b50ca66475b-20210124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sipCTNiyfLcu08xZ57wmAIKixRkKdm7AYW5KCq64fzg=;
        b=UuViojXI7BS1c9tQYeeDeRnFOKF58qVbJYWKkQ60L2+0Y0QLyeVs/WB2MLV3ncMaCHH8GKz2oTH4n1ujzKnBqKTqMLzHJQBHjtqzwMoxiCtywBcXjfQpsNENEfEehbZC8KVMiGysjcg2iaeE1OariWbMrk8kY/E5PorcN69Yjdw=;
X-UUID: baf8a03389214aa7bdc81b50ca66475b-20210124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2056609033; Sun, 24 Jan 2021 07:48:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 24 Jan 2021 07:48:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Jan 2021 07:48:01 +0800
Message-ID: <1611445681.17541.2.camel@mtkswgap22>
Subject: Re: [PATCH -next v7 08/22] mt76: mt7921: add module support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sun, 24 Jan 2021 07:48:01 +0800
In-Reply-To: <feac135d366a16bd554eeccd18ecdc5f6ab619e2.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
         <feac135d366a16bd554eeccd18ecdc5f6ab619e2.1611389300.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTIzIGF0IDE2OjM0ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgbXQ3OTIxIGFzIHRoZSBwY2kgZHJpdmVyIG1vZHVsZS4NCj4gDQo+IFRoZSBwdXJwb3Nl
IG9mIHRoZSBwYXRjaCBpcyB0byBjaGVjayBhYm91dCBpZiB0aGUgZm9sbG93aW5nIHBhdGNoZXMg
YXJlDQo+IGFibGUgdG8gY29tcGlsZSBwcm9wZXJseS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTog
TG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBM
b3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IENvLWRldmVsb3BlZC1ieTog
U291bCBIdWFuZyA8U291bC5IdWFuZ0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNv
dWwgSHVhbmcgPFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFu
IFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9LY29uZmlnICAgICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L01ha2VmaWxlICAgICAgICB8ICAxICsNCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL0tjb25maWcgIHwgMTAgKysrKysr
KysrKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvTWFrZWZp
bGUgfCAgNSArKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MjEvS2NvbmZpZw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTIxL01ha2VmaWxlDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9LY29uZmlnIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9LY29uZmlnDQo+IGluZGV4IDc0Zjk5ZjA4ZDBiNS4uOWZmNDNmMWZjNTBk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9LY29uZmlnDQo+
IEBAIC0zMywzICszMyw0IEBAIHNvdXJjZSAiZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2eDIvS2NvbmZpZyINCj4gIHNvdXJjZSAiZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MDMvS2NvbmZpZyINCj4gIHNvdXJjZSAiZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvS2NvbmZpZyINCj4gIHNvdXJjZSAiZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvS2NvbmZpZyINCj4gK3NvdXJjZSAiZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvS2NvbmZpZyINCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvTWFrZWZpbGUgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L01ha2VmaWxlDQo+IGluZGV4IGVhYzQxOWM2NDc4
OC4uOTRlZmUzYzI5MDUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvTWFrZWZpbGUNCj4gQEAgLTM0LDMgKzM0LDQgQEAgb2JqLSQoQ09ORklHX01UNzZ4Ml9D
T01NT04pICs9IG10NzZ4Mi8NCj4gIG9iai0kKENPTkZJR19NVDc2MDNFKSArPSBtdDc2MDMvDQo+
ICBvYmotJChDT05GSUdfTVQ3NjE1X0NPTU1PTikgKz0gbXQ3NjE1Lw0KPiAgb2JqLSQoQ09ORklH
X01UNzkxNUUpICs9IG10NzkxNS8NCj4gK29iai0kKENPTkZJR19NVDc5MjFFKSArPSBtdDc5MjEv
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzky
MS9LY29uZmlnIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvS2Nv
bmZpZw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI0OTMy
ZDJlOGRlZQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTIxL0tjb25maWcNCj4gQEAgLTAsMCArMSwxMCBAQA0KPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogSVNDDQo+ICtjb25maWcgTVQ3OTIxRQ0KPiArCXRyaXN0YXRl
ICJNZWRpYVRlayBNVDc5MjFFIChQQ0llKSBzdXBwb3J0Ig0KPiArCXNlbGVjdCBNVDc2X0NPUkUN
Cj4gKwlkZXBlbmRzIG9uIE1BQzgwMjExDQo+ICsJZGVwZW5kcyBvbiBQQ0kNCj4gKwloZWxwDQo+
ICsJICBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgTVQ3OTIxRSA4MDIuMTFheCAyeDI6MlNTIHdpcmVs
ZXNzIGRldmljZXMuDQo+ICsNCj4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1
bGUsIGNob29zZSBNIGhlcmUuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9NYWtlZmlsZSBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTIxL01ha2VmaWxlDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uMDlkMTQ0NmFkOTMzDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvTWFrZWZpbGUNCj4gQEAgLTAs
MCArMSw1IEBADQo+ICsjU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IElTQw0KPiArDQo+ICtvYmot
JChDT05GSUdfTVQ3OTIxRSkgKz0gbXQ3OTIxZS5vDQo+ICsNCj4gK210NzkyMWUteSA6PSBwY2ku
byBtYWMubyBtY3UubyBkbWEubyBlZXByb20ubyBtYWluLm8gaW5pdC5vIGRlYnVnZnMubw0KDQpJ
IHRoaW5rIGl0J3MgbW9yZSByZWFzb25hYmxlIHRvIG1vdmUgdGhpcyBpbnRvICdtdDc2OiBtdDc5
MjE6IGludHJvZHVjZQ0KbXQ3OTIxZSBzdXBwb3J0JyB0byBtYWtlIGl0IGNvbXBsZXRlLg0KDQpS
eWRlcg0K

