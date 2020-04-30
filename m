Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068491BF39A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3I6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 04:58:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:3533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgD3I6k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 04:58:40 -0400
IronPort-SDR: hag3hn/eIZ2cAbGcW+ETW7HAwAeLoHldreFwwMwPYSQvInw5ieXVqWiQK0xOzFifRQvUTweIhC
 AI70gorY2XCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 01:58:40 -0700
IronPort-SDR: fQup+oKPTPZMZ4ooLPtXFuvORBuqsK7f/UtzDl9s1y4AiSJZVmDW2Qr+fxosBzs6DWgb0hl5VC
 E9wY5qfvcDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="368077231"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2020 01:58:40 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 01:58:39 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 01:58:39 -0700
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.7]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Thu, 30 Apr 2020 16:58:37 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "luca@coelho.fi" <luca@coelho.fi>
Subject: RE: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
Thread-Topic: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
Thread-Index: AQHWHrivmvF3aVRc5kel0SLDGSPp4KiQ1F8AgACH7GA=
Date:   Thu, 30 Apr 2020 08:58:37 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926377CFB787@SHSMSX108.ccr.corp.intel.com>
References: <20200430063229.6182-1-rui.zhang@intel.com>
 <20200430063229.6182-3-rui.zhang@intel.com>
 <f6d7dcae-ccf1-eee1-2ac1-eaa8472e2f87@collabora.com>
In-Reply-To: <f6d7dcae-ccf1-eee1-2ac1-eaa8472e2f87@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJ6ZWogUGlldHJhc2ll
d2ljeiA8YW5kcnplai5wQGNvbGxhYm9yYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAz
MCwgMjAyMCA0OjQ3IFBNDQo+IFRvOiBaaGFuZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPjsg
bGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc7IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7DQo+IGIuem9sbmllcmtpZUBzYW1zdW5n
LmNvbTsgbHVjYUBjb2VsaG8uZmkNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzZdIHRoZXJtYWw6
IGNvcmU6IGRlbGV0ZSB0aGVybWFsX25vdGlmeV9mcmFtZXdvcmsoKQ0KPiBJbXBvcnRhbmNlOiBI
aWdoDQo+IA0KPiBIaSBSdWksDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBzZXJpZXMsDQo+IA0KPiBX
IGRuaXUgMzAuMDQuMjAyMCBvwqAwODozMiwgWmhhbmcgUnVpIHBpc3plOg0KPiA+IERlbGV0ZSB0
aGVybWFsX25vdGlmeV9mcmFtZXdvcmsoKSBhcyB0aGVyZSBpcyBubyB1c2VyIG9mIGl0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgMTggLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgICAgfCAgNCAtLS0t
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDIyIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBnaXQg
Z3JlcCB0aGVybWFsX25vdGlmeV9mcmFtZXdvcmsNCj4gRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBp
L3RoZXJtYWwvc3lzZnMtYXBpLnJzdDo0LjMuDQo+IHRoZXJtYWxfbm90aWZ5X2ZyYW1ld29yaw0K
PiANCj4gU2hvdWxkIHRoZSBkb2N1bWVudGF0aW9uIGJlIHN0aWxsIGRvY3VtZW50aW5nIGEgbm9u
LWV4aXN0ZW50IGZ1bmN0aW9uPw0KPiANClJpZ2h0LCB0aGFua3MgZm9yIHRoZSByZW1pbmRlci4N
CldpbGwgY2xlYW4gaXQgdXAgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IEJUVywgZ2V0X3R6X3RyZW5k
KCkgaXMgb25seSB1c2VkIGluIGRyaXZlcnMvdGhlcm1hbC9zdGVwX3dpc2UuYywgYnV0IGlzIHN0
aWxsDQo+IGV4cG9ydGVkIHdpdGggRVhQT1JUX1NZTUJPTCgpLiBQcm9iYWJseSBkb2VzIG5vdCBu
ZWVkIHRvIGJlIGV4cG9ydGVkDQo+IGFueW1vcmUuDQo+IA0KUmlnaHQsIHRoYXQgd29ydGggYSBz
ZXBhcmF0ZSBjbGVhbnVwIHBhdGNoLg0KDQpDYW4geW91IHBsZWFzZSB0cnkgdGhpcyBwYXRjaCBh
bmQgY29uZmlybSB0aGUgcG9sbGluZyB0aW1lcnMgYXJlIHF1ZXVlZC9jYW5jZWxsZWQgYXMgZXhw
ZWN0ZWQ/DQoNCnRoYW5rcywNCnJ1aQ0K
