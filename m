Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4493A912C9
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHQUBz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 16:01:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:21166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfHQUBz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 16:01:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2019 13:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,398,1559545200"; 
   d="scan'208";a="328987633"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2019 13:01:54 -0700
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 17 Aug 2019 13:01:54 -0700
Received: from hasmsx112.ger.corp.intel.com ([169.254.11.117]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.64]) with mapi id 14.03.0439.000;
 Sat, 17 Aug 2019 23:01:51 +0300
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "Peer, Ilan" <ilan.peer@intel.com>,
        "angelsl@in04.sg" <angelsl@in04.sg>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi: 9260: Spurious "Unhandled alg: 0x707" and 0x71b
Thread-Topic: iwlwifi: 9260: Spurious "Unhandled alg: 0x707" and 0x71b
Thread-Index: AQHVVBBiNMsepcYDJEWnYm+n+hVrF6b/kr8A
Date:   Sat, 17 Aug 2019 20:01:51 +0000
Message-ID: <0e1a890d2896791d7291f0174cc0e96832d7ed33.camel@intel.com>
References: <badc218b-ea1f-3697-b1f2-3ebb294d9849@in04.sg>
In-Reply-To: <badc218b-ea1f-3697-b1f2-3ebb294d9849@in04.sg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.3.144]
Content-Type: text/plain; charset="utf-8"
Content-ID: <88263556BF208C4CA4005E734A2568FC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIEZyaSwgMjAxOS0wOC0xNiBhdCAxNjo1NSArMDgwMCwgVGVlIEhhbyBXZWkgd3Jv
dGU6DQo+IEhpLA0KPiANCj4gSSd2ZSBiZWVuIGdldHRpbmcgIlVuaGFuZGxlZCBhbGc6IDB4NzA3
IiBvciAweDcxYiByYW5kb21seQ0KPiBvbiBteSBJbnRlbCA5MjYwLiBJdCBzZWVtcyB0byBoYXBw
ZW4gbW9zdCBvZnRlbiB3aGVuIGl0DQo+IGFzc29jaWF0ZXMgdG8gYSBuZXcgQVAgKG9yIHJvYW1z
IHRvIGEgZGlmZmVyZW50IG9uZSB0aGF0DQo+IGhhcyB0aGUgc2FtZSBTU0lEL2F1dGhlbnRpY2F0
aW9uKS4gSXQgYWxzbyBzZWVtcyB0byBoYXBwZW4NCj4gb25seSB3aXRoIHBhcnRpY3VsYXIgQVBz
LiAoSSBkb24ndCBoYXZlIGFjY2VzcyB0byB0aGUgQVBzLA0KPiBzbyB0aGVyZSdzIG5vdCBtdWNo
IEkga25vdyBhYm91dCB0aGVtLikNCj4gDQo+IEkgYXBwbGllZCB0aGUgdHdvIHBhdGNoZXMgbWVu
dGlvbmVkIGluIEJ1Z3ppbGxhICMyMDM1OTNbMV0NCj4gaS5lLiAiaXdsd2lmaTogbXZtOiBBbGxv
dyBtdWx0aWNhc3QgZGF0YSBmcmFtZXMgb25seSB3aGVuDQo+IGFzc29jaWF0ZWQiIGFuZCAiaXds
d2lmaTogbXZtOiBBbGxvdyBtdWx0aWNhc3QgZGF0YSBmcmFtZXMNCj4gb25seSB3aGVuIGF1dGhv
cml6ZWQiIG9uIHRvcCBvZiBpd2x3aWZpIGluIDUuMi44LCB3aGljaA0KPiBpbXByb3ZlZCB0aGUg
c2l0dWF0aW9uIGEgbG90LCBidXQgaXQgc3RpbGwgaGFwcGVucyBwcmV0dHkNCj4gZnJlcXVlbnRs
eS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMDM1OTMNCg0KVGhpcyBwcmludCBpcyBoYXJtbGVzcyByZWFsbHkuIEFmdGVyIHRoaXMgYnVn
IGhhcyBiZWVuIHJlcG9ydGVkLCBJIGhhdmUNCmJlZW4gY29udGFjdCBieSB0aGUgZmlybXdhcmUg
dGVhbSB3aG8gd2FudGVkIHRvIGRlcHJlY2F0ZSB0aGUgZmxhZyB0aGF0DQp3ZSBjaGFuZ2UgaW4g
dGhlIGJ1ZyBmb3IgdGhhdCBCdWd6aWxsYSwgc28gdGhhdCB0aGUgZml4IHdpbGwgYmUgYSBuby1v
cCANCmZvciBuZXdlciBmaXJtd2FyZS4gQm90dG9tIGxpbmUsIHdlIGFyZSByZW1vdmluZyB0aGlz
IHByaW50LCBvciB3ZSBhcmUNCmxlYXZpbmcgaXQgb25seSBmb3IgdW5pY2FzdCBwYWNrZXRzLiBU
aGlzIGhhcyBiZWVuIG1lcmdlZCBpbiBvdXINCmludGVybmFsIHJlcG9zaXRvcnkgYW5kIGl0IHdp
bGwgYmUgdXBzdHJlYW1lZCBmb2xsb3dpbmcgdGhlIHJlZ3VsYXINCnByb2Nlc3MuDQoNCllvdSBj
YW4gZmluZCBpdCBoZXJlIGluIG91ciBiYWNrcG9ydCBiYXNlZCBkcml2ZXI6DQoNCmh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvYmFja3BvcnQt
aXdsd2lmaS5naXQvY29tbWl0Lz9pZD1mOWI5ZjkyZGQ4NGM1YzQ2N2NiY2M2MjA1ODQ4NjRkZThm
YmZiNTZjDQoNCg0KPiANCj4gSSdsbCB0cnkgdG8gY29sbGVjdCBzb21lIGRlYnVnIGRhdGEgc29v
bi4gQWxzbywgSSdsbCB0cnkNCj4gdG8gc2VlIGlmIG15IDgyNjAgaGFzIHRoZSBzYW1lIGlzc3Vl
cy4NCj4gDQo+IElzIHRoZXJlIGFueXRoaW5nIGVsc2UgSSBzaG91bGQgdHJ5IG9yIGFueSBvdGhl
ciBwYXRjaGVzIEkNCj4gc2hvdWxkIGJhY2twb3J0Pw0KPiANCj4gVGhhbmtzLg0KPiANCg==
