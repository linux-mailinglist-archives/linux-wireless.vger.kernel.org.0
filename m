Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEBF2EEB3F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbhAHC0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jan 2021 21:26:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55208 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726113AbhAHC0M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jan 2021 21:26:12 -0500
X-UUID: b0385c3ff01444b5bb6588fab7052502-20210108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=I3SpUDHCtA6dMxMYwIXLmn6LKY44+n+kL11eKoRrlrk=;
        b=FGznwx9AouX3h4yv486YuWbrFvvv41b9IdtB1/UDaMkaUdI8PlthYpIpzhbW5TzYzvrQUHUNePqym9EHNY4+hPDv8UuDYfOFwEj7ukeuEw0IfI6mPIqnH3/NI3MRVGuDSe9CjkzZND94bxng0eju5yPgTGZ8vuN80fT83yRmkF0=;
X-UUID: b0385c3ff01444b5bb6588fab7052502-20210108
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2112544535; Fri, 08 Jan 2021 10:25:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 10:25:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 10:25:27 +0800
Message-ID: <1610072726.27505.3.camel@mtkswgap22>
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 8 Jan 2021 10:25:26 +0800
In-Reply-To: <87a6tkki7m.fsf@toke.dk>
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
         <87r1my49us.fsf@toke.dk> <68ab89bc-70f4-e822-3d96-21ba3bd6511f@nbd.name>
         <87k0sq3wfl.fsf@toke.dk> <1609985461.9743.2.camel@mtkswgap22>
         <87a6tkki7m.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DA70B471866AF3664737057511791DB6EC031F379C592A5FD4A03F240628765F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTA3IGF0IDE0OjA4ICswMTAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBPbiBXZWQsIDIwMjEtMDEtMDYgYXQgMTY6NDEgKzAxMDAsIFRva2UgSMO4aWxhbmQt
SsO4cmdlbnNlbiB3cm90ZToNCj4gPj4gRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPiB3cml0
ZXM6DQo+ID4+IA0KPiA+PiA+IE9uIDIwMjEtMDEtMDYgMTE6NTEsIFRva2UgSMO4aWxhbmQtSsO4
cmdlbnNlbiB3cm90ZToNCj4gPj4gPj4gUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29t
PiB3cml0ZXM6DQo+ID4+ID4+IA0KPiA+PiA+Pj4gVGhlIHNlbGVjdGVkIHR4cSBzaG91bGQgYmUg
c2NoZWR1bGVkIHVuY29uZGl0aW9uYWxseSBpZg0KPiA+PiA+Pj4gTkw4MDIxMV9FWFRfRkVBVFVS
RV9BSVJUSU1FX0ZBSVJORVNTIGlzIG5vdCBzZXQgYnkgZHJpdmVyLg0KPiA+PiA+Pj4NCj4gPj4g
Pj4+IEFsc28gcHV0IHRoZSBzdGEgdG8gdGhlIGVuZCBvZiB0aGUgYWN0aXZlX3R4cXMgbGlzdCBp
Zg0KPiA+PiA+Pj4gZGVmaWNpdCBpcyBuZWdhdGl2ZSB0aGVuIG1vdmUgb24gdG8gdGhlIG5leHQg
dHhxLg0KPiA+PiA+PiANCj4gPj4gPj4gV2h5IGlzIHRoaXMgbmVlZGVkPyBJZiB0aGUgZmVhdHVy
ZSBpcyBub3Qgc2V0LCBubyBhaXJ0aW1lIHNob3VsZCBldmVyIGJlDQo+ID4+ID4+IGFjY291bnRl
ZCB0byB0aGUgc3RhdGlvbiwgYW5kIHNvIHN0YS0+YWlydGltZVt0eHFpLT50eHEuYWNdLmRlZmlj
aXQgd2lsbA0KPiA+PiA+PiBhbHdheXMgYmUgMCAtIHNvIHlvdSdyZSBqdXN0IGFkZGluZyBhbm90
aGVyIGNoZWNrIHRoYXQgZG9lc24ndCBhY3R1YWxseQ0KPiA+PiA+PiBjaGFuZ2UgdGhlIGJlaGF2
aW91ciwgYXJlbid0IHlvdT8NCj4gPj4gPg0KPiA+PiA+IEkgdGhpbmsgaXQgbWlnaHQgbWFrZSBz
ZW5zZSB0byBrZWVwIGFpcnRpbWUgcmVwb3J0aW5nIGV2ZW4gd2hlbiBhaXJ0aW1lDQo+ID4+ID4g
ZmFpcm5lc3MgaXMgZGlzYWJsZWQgYXQgcnVuIHRpbWUsIHNvIHRoaXMgcGF0Y2ggbWFrZXMgc2Vu
c2UgdG8gbWUuDQo+ID4+ID4gSW5zdGVhZCBvZiB0aGlzIHBhdGNoLCB0aGUgcmlnaHQgcGxhY2Ug
dG8gZGVhbCB3aXRoIHRoaXMgd291bGQgcHJvYmFibHkNCj4gPj4gPiBiZSBpZWVlODAyMTFfc3Rh
X3JlZ2lzdGVyX2FpcnRpbWUuDQo+ID4+IA0KPiA+PiBXaGVuIHRoZSBmYWlybmVzcyBtZWNoYW5p
c20gaXMgdXNlci1kaXNhYmxlZCBJIGFncmVlIGl0IG1ha2VzIHNlbnNlIHRvDQo+ID4+IHN0aWxs
IGtlZXAgdGhlIGFjY291bnRpbmc7IGFuZCBpbiBmYWN0IHRoYXQncyB3aGF0DQo+ID4+IGllZWU4
MDIxMV9zdGFfcmVnaXN0ZXJfYWlydGltZSgpIGFscmVhZHkgZG9lcyB3aGVuIHRoZSBhY2NvdW50
aW5nIGlzDQo+ID4+IHR1cm5lZCBvZmYgYnkgd2F5IG9mIHRoZSBhaXJ0aW1lX2ZsYWdzIGZpZWxk
Li4uIFNvIGRvbid0IHRoaW5rIGFueXRoaW5nDQo+ID4+IGVsc2UgaXMgbmVlZGVkIHRoZXJlIGVp
dGhlcj8NCj4gPj4gDQo+ID4+IC1Ub2tlDQo+ID4NCj4gPiBOb3Qgc3VyZSBJIGdldCB0aGlzIHJp
Z2h0LiBBcmUgeW91IHRhbGtpbmcgYWJvdXQgbG9jYWwtPmFpcnRpbWVfZmxhZ3MgPQ0KPiA+IEFJ
UlRJTUVfVVNFX1RYIHwgQUlSVElNRV9VU0VfUlggPyBJIHRoaW5rIHRoYXQncyBkaWZmZXJlbnQg
YW5kIHdlIHN0aWxsDQo+ID4gbmVlZCB0byB0YWtlIE5MODAyMTFfRVhUX0ZFQVRVUkVfQUlSVElN
RV9GQUlSTkVTUyBpbnRvIGFjY291bnQsIHJpZ2h0Pw0KPiANCj4gSSBqdXN0IG1lYW50IHRoYXQg
d2hhdCBGZWxpeCB3YXMgYXNraW5nIGZvciAoYSB3YXkgKmZvciB0aGUgdXNlciogdG8NCj4gZGlz
YWJsZSBhaXJ0aW1lIGZhaXJuZXNzIHdoaWxlIHN0aWxsIGdldHRpbmcgdGhlIGFpcnRpbWUgdXNh
Z2UNCj4gYWNjb3VudGVkKSBpcyBwb3NzaWJsZSBieSBzZXR0aW5nIHRob3NlIGZsYWdzLiBUaGUg
RVhUX0ZFQVRVUkUgZmxhZyBpcw0KPiBtZWFudCBhcyBhIHdheSBmb3IgdGhlIGRyaXZlciB0byBz
aWduYWwgdG8gbWFjODAyMTEgdGhhdCBpdCBzdXBwb3J0cw0KPiByZXBvcnRpbmcgYWlydGltZSBh
dCBhbGw7IHNvIGlkZWFsbHkgaXQgc2hvdWxkIGJlIGEgZmxhZyB0aGF0IGlzIG9ubHkNCj4gc2V0
IG9uY2UuDQo+IA0KPiBHb2luZyBiYWNrIGFuZCByZWFkaW5nIHlvdXIgaW5pdGlhbCByZXNwb25z
ZSBpdCBzZWVtcyBsaWtlIHlvdSBtYXkgYmUNCj4gdG9nZ2xpbmcgdGhlIGZsYWcgZHluYW1pY2Fs
bHkgaW4gdGhlIGRyaXZlciwgdGhvdWdoPyBJcyB0aGlzIGFjY3VyYXRlPw0KPiBBbmQgaWYgc28s
IHdoeT8gSXMgaXQgbm90IGVub3VnaCBmb3IgeW91IHRvIGZpZGRsZSB3aXRoIHRoZQ0KPiBVU0Vf
VFgvVVNFX1JYIGZsYWdzPyA6KQ0KPiANCj4gLVRva2UNCg0KR290Y2hhLiBXZSBqdXN0IHNldCBp
dCBvbmNlIGluZGVlZC4gU28gdGhlIHdheSB5b3UgdGhpbmsgaXMgZGlzYWJsZSB0aGUNCkVYVF9G
RUFUVVJFIGZsYWcgYW5kIGNsZWFyIEFJUlRJTUVfVVNFX1RYIHRocm91Z2ggZGVidWdmcw0KKERF
QlVHRlNfQUREX01PREUoYWlydGltZV9mbGFncywgMDYwMCkpIGluIHRoZSBtZWFudGltZS4NCg0K
UnlkZXINCg==

