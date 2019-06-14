Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA08446005
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFNOGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:06:34 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:45461 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728313AbfFNOGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:06:34 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id 18/E7-08344-8E9A30D5; Fri, 14 Jun 2019 14:06:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRWlGSWpSXmKPExsXi5LtOQPfFSuZ
  Ygx+L1Cw+bvjEYvFmxR12ByaP/t5tLB6fN8kFMEWxZuYl5VcksGac+bWWsWCfWMWe579ZGxhn
  iHUxcnEICaxmlPj7cCozhLOXUeLpmVNMXYycHGwChhKrFxxhB7FFBHQlLk66zQJiMwu4Spy5/
  5oZxBYWiJZYOHsWE0RNjMSpaw9YIGw3icXtaxhBbBYBVYmDjzpYQWxeAWuJxdv2sYHYQgIPGS
  WavyWC2JwCfhJ7exaC1TMKyEq8aJ/ABLFLXOLWk/lgtoSAgMSSPeeZIWxRiZeP/4HNFBUIl5i
  46g9UXEGir7MbyOYA6tWUWL9LH2KMucT171eZIWxFiSndD9khzhGUODnzCQvEOSoS26Z0s01g
  FJ+FZPMshEmzkEyahWTSLCSTFjCyrmK0SCrKTM8oyU3MzNE1NDDQNTQ00jU0NgfS5nqJVbrJe
  qXFuuWpxSW6RnqJ5cV6xZW5yTkpenmpJZsYgXGaUtBZuoNxxoHXeocYJTmYlER5nUuYY4X4kv
  JTKjMSizPii0pzUosPMcpwcChJ8C5eAZQTLEpNT61Iy8wBpgyYtAQHj5II7z+QNG9xQWJucWY
  6ROoUozHHhJdzFzFzHJm7dBGzEEtefl6qlDgvGzAZCQmAlGaU5sENgqWyS4yyUsK8jAwMDEI8
  BalFuZklqPKvGMU5GJWEeYVApvBk5pXA7XsFdAoT0CmzNjCBnFKSiJCSamCSXZM74wTjRZXJ+
  Y9FazddsVrnXqbK4un7wGyiUfa3BeHTJi9y8bqQtPD/Ev6+vIssnKsP/CyOFDVk+uLy4MnvjZ
  KtWn//Nmy/+39dX9/C53lJ1lsnnOZfJHcr+MzH/amrCjKD07fmNlsLvd8440ntZtdl7cUrz7W
  cW7HtpN60jg9iJ3hKLtn8cdUomKHdkCNelm2v2sF94FjGmv1hByqLdv/lN1p0btrxrQLVzkyB
  7XPm/rx1bumnJwYrl0auObzitfMZ6TwTpsO75u9s0fI8VrnB4X7aDYfZEWf5vzqu/DJNyPy7x
  pGztUvf3F54Q2Djz5M2B2rsG2RmHJuz7mvpbse3YkveizPt7b2l++NB30slluKMREMt5qLiRA
  B4YFPU4AMAAA==
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-9.tower-365.messagelabs.com!1560521192!12878019!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13259 invoked from network); 14 Jun 2019 14:06:32 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-9.tower-365.messagelabs.com with SMTP; 14 Jun 2019 14:06:32 -0000
Received: from MTK-SMS-XCH05.digi.com (10.10.8.199) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 14 Jun 2019
 09:06:31 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH05.digi.com ([fe80::a576:56af:8463:b976%15]) with mapi id
 14.03.0415.000; Fri, 14 Jun 2019 09:06:31 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
Thread-Topic: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
Thread-Index: AQHVIrNP/gN6lxCOEkmu6xBChwu2HqabeTaAgAAHxgCAAACgAIAAAYiA
Date:   Fri, 14 Jun 2019 14:06:31 +0000
Message-ID: <d31d9fa0-302d-8bf9-4e37-52b213583003@digi.com>
References: <20190614131600.GA13897@a1-hr>
 <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
 <32951d52-3f9d-aaee-fa07-75585c03edba@digi.com>
 <6a9c7642a2fcca60658036c605438ff2ac982bd0.camel@sipsolutions.net>
In-Reply-To: <6a9c7642a2fcca60658036c605438ff2ac982bd0.camel@sipsolutions.net>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [172.27.2.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70155423C23304D98B5C9C112FA8DEC@digi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoqRnJvbToqIEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQoqU2Vu
dDoqIEZyaWRheSwgSnVuZSAxNCwgMjAxOSA0OjAxUE0NCipUbzoqIEhvZGFzemksIFJvYmVydCA8
Um9iZXJ0LkhvZGFzemlAZGlnaS5jb20+DQoqQ2M6KiBMaW51eC13aXJlbGVzcyA8bGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnPg0KKlN1YmplY3Q6KiBSZTogW1BBVENIIHYyXSBSZXZlcnQg
ImNmZzgwMjExOiBmaXggcHJvY2Vzc2luZyB3b3JsZCANCnJlZ2RvbWFpbiB3aGVuIG5vbiBtb2R1
bGFyIg0KDQo+IE9uIEZyaSwgMjAxOS0wNi0xNCBhdCAxMzo1OCArMDAwMCwgSG9kYXN6aSwgUm9i
ZXJ0IHdyb3RlOg0KPj4gSSBkaWRuJ3QganVzdCByZXNlbmQgdGhhdC4gSSBqdXN0IHJlYWxpemVk
LCBhY2NpZGVudGFsbHkgSSBmb3Jnb3QgdG8gZml4DQo+PiB0aGUgZGVidWcgbWVzc2FnZSBwcmlu
dGluZyBmdW5jdGlvbiwgdGhhdCBkZWZpbmUgZG9lc24ndCBleGlzdCBhbnltb3JlLg0KPj4gU29y
cnkgZm9yIHRoZSBjb25mdXNpb24hDQo+IE9vcHMuIEkgbG9va2VkIHRvbyBzdXBlcmZpY2lhbGx5
IHRoZW4gYW5kIGRpZG4ndCBldmVuIHNlZSB0aGUNCj4gZGlmZmVyZW5jZSwgc29ycnkuDQo+DQo+
IEkgZ3Vlc3MgdGhhdCdzIHdoeSBLYWxsZSBhbHdheXMgc2F5cyB5b3Ugc2hvdWxkIGhhdmUgYSBw
YXRjaCBjaGFuZ2Vsb2cNCj4gOi0pDQpTaGFtZSBvbiBtZSwgSSB3YXMgYWJsZSB0byBtYWtlIGEg
YnVnIGluIGEgb25lLWxpbmUgY2hhbmdlLiA6KQ0KPg0KPj4gVW5kZXIgIm9yaWdpbmFsIGlzc3Vl
IiwgeW91IG1lYW4gdGhlIGlzc3VlLCB3aGljaCBjb21taXQNCj4+IDk2Y2NlMTJmZjZlMGJjOWQ5
ZmNiMjIzNWUwOGI3ZmMxNTBmOTZmZDIgKGNmZzgwMjExOiBmaXggcHJvY2Vzc2luZyB3b3JsZA0K
Pj4gcmVnZG9tYWluIHdoZW4gbm9uIG1vZHVsYXIpIHN1cHBvc2VkIHRvIGZpeD8NCj4gWWVzLg0K
Pg0KPj4gVGhhdCBzdGlsbCB3b24ndCB3b3JrLCBidXQNCj4+IHRoYXQgZGlkbid0IHdvcmsgbmVp
dGhlciBiZWZvcmUgSSByZXZlcnRlZCB0aGUgcGF0Y2gsIGJlY2F1c2UgY3JkYSBjYWxsDQo+PiB0
aW1lb3V0IHdpbGwganVzdCBkcm9wIHRoZSBsYXN0IHBhY2tldC4gQWxzbywgYXMgaXQgcmUtcHJv
Y2Vzc2VkIHRoZQ0KPj4gbGFzdCByZXF1ZXN0LCBub3QganVzdCByZXNlbnQgaXQsIGl0IGNhdXNl
ZCB1bmRlc2lyZWQgc3RhdGVzLiBMaWtlIHdoZW4NCj4+IEkgdXNlZCAyIFdpRmkgbW9kdWxlcyB3
aXRoIFVTIHJlZ3VsYXRvcnkgZG9tYWlucywgYWZ0ZXIgZW51bWVyYXRpb24sIG15DQo+PiBnbG9i
YWwgcmVndWxhdG9yIGRvbWFpbiB3YXMgc2V0IHRvICJDb3VudHJ5IDk4Ii4NCj4+DQo+PiBUbyBm
aXggbXkgaXNzdWUsIHdoeSBJIHJldmVydGVkIHRoZSBwYXRjaCwgYW5kIGFsc28gZml4IHRoZSBp
c3N1ZSB0aGUNCj4+IHJldmVydGVkIGNvbW1pdCBzdXBwb3NlZCB0byBmaXgsIEkgY291bGQgaW1h
Z2luZSBzb21ldGhpbmcgbGlrZSB0aGlzLg0KPj4gQnV0IEknbSBub3Qgc3VyZSwgaXQgZG9lc24n
dCBoYXZlIGFueSBzaWRlIGVmZmVjdDoNCj4gW3NuaXBdDQo+DQo+IE9rLCB0aGFua3MuIEkgZ3Vl
c3MgSSdsbCBoYXZlIHRvIGxvb2sgYXQgdGhpcyBpbiBtb3JlIGRldGFpbC4NCj4NCj4gWW91IGRv
bid0IGhhcHBlbiB0byBoYXZlIGEgd2F5IHRvIHJlcHJvZHVjZSBlaXRoZXIgaXNzdWUgd2l0aCBh
IGh3c2ltDQo+IHRlc3QgY2FzZT8NCj4NCj4gam9oYW5uZXMNCj4NClRvIHRlbGwgdGhlIHRydXRo
LCBJIG5ldmVyIHRyaWVkIGh3c2ltLiBCdXQgaXQncyBwcmV0dHkgdHJpdmlhbCB0byByZXBybyAN
Cml0LiBZb3UganVzdCBuZWVkIDIgV2lGaSBtb2R1bGVzLCBhbmQgcHV0IGUuZy4gYSAic2xlZXAg
MSIgaW50byB0aGUgdWRldiANCm9yIG1kZXYgc2NyaXB0LCBiZWZvcmUgaXQgd291bGQgY2FsbCB0
aGUgImNyZGEiLiBUaGF0IHNob3VsZCB0cmlnZ2VyIHRoZSANCmlzc3VlIGltbWVkaWF0ZWx5LiBB
ZnRlciB0aGF0IGNoYW5nZSwgSSBqdXN0IGRpZCBhbiAicm1tb2QgYXRoMTBrX3BjaTsgDQptb2Rw
cm9iZSBhdGgxMGtfcGNpIiwgYW5kIGJ1bW0sICJpdyByZWcgZ2V0IiB3aWxsIHNob3VsZCAiQ291
bnRyeSA5OCIuDQoNClJvYmVydA0K
