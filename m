Return-Path: <linux-wireless+bounces-1252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42B81CBFA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B448B2240F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55F23746;
	Fri, 22 Dec 2023 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nLIorZAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914C249EB;
	Fri, 22 Dec 2023 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Date:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Cc:To:From:Subject:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vDuS43fy7mqBUmwlHYvOE3GU5zPv6Q+rTUpwoVGlpZk=;
	t=1703257800; x=1704467400; b=nLIorZATWDZQLh0k4JHCLhKCeH7hFH2DEE2xMHMTHmBaQX9
	MpJ4e6BpwUiBcS9CqE4SpathLdiZ/wZwPL5ubPtU2sy0QgvTmmIydSkuQysv4AhXRbfv4wtRnNFTV
	RCewsZyQZcwEfaYXXlgR2tuC1WA6XJZm0rD88RNElM29+3inVt85T9RpytvtjYsJmw7+7LEISe7hE
	/BhiGxkEQPBS0GbU8z01kyBzlAawnVYnl8Xgu8YqL54dbEQRePLLHBbH+vKbi4xG8ZaHweF6eh7zD
	s1JyplIpkfkqrnuHsdXEp24A/NQW4shJZP3EDcbff220SORaU69iHZlwDn1uSyEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rGh9r-00000004LyN-0YFy;
	Fri, 22 Dec 2023 16:09:51 +0100
Message-ID: <2412a9caed7161459ad95043cbdd74e092fb27d1.camel@sipsolutions.net>
Subject: Re: [PATCH 1/6] kunit: add parameter generation macro using
 description from array
From: Benjamin Berg <benjamin@sipsolutions.net>
To: David Gow <davidgow@google.com>
Cc: linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
In-Reply-To: <CABVgOSkTCk4WRstLM+pKQeKRtPYPCOE_LCV9GfoRVdZLfW1Zaw@mail.gmail.com>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
	 <20231220151952.415232-2-benjamin@sipsolutions.net>
	 <CABVgOSkTCk4WRstLM+pKQeKRtPYPCOE_LCV9GfoRVdZLfW1Zaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 22 Dec 2023 15:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-malware-bazaar: not-scanned

T24gRnJpLCAyMDIzLTEyLTIyIGF0IDE4OjAyICswODAwLCBEYXZpZCBHb3cgd3JvdGU6Cj4gT24g
V2VkLCAyMCBEZWMgMjAyMyBhdCAyMzoyMCwgPGJlbmphbWluQHNpcHNvbHV0aW9ucy5uZXQ+IHdy
b3RlOgo+ID4gCj4gPiBGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNv
bT4KPiA+IAo+ID4gVGhlIGV4aXN0aW5nIEtVTklUX0FSUkFZX1BBUkFNIG1hY3JvIHJlcXVpcmVz
IGEgc2VwYXJhdGUgZnVuY3Rpb24KPiA+IHRvCj4gPiBnZXQgdGhlIGRlc2NyaXB0aW9uLiBIb3dl
dmVyLCBpbiBhIGxvdCBvZiBjYXNlcyB0aGUgZGVzY3JpcHRpb24gY2FuCj4gPiBqdXN0IGJlIGNv
cGllZCBkaXJlY3RseSBmcm9tIHRoZSBhcnJheS4gQWRkIGEgc2Vjb25kIG1hY3JvIHRoYXQKPiA+
IGF2b2lkcyBoYXZpbmcgdG8gd3JpdGUgYSBzdGF0aWMgZnVuY3Rpb24ganVzdCBmb3IgYSBzaW5n
bGUgc3Ryc2NweS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQmVyZyA8YmVuamFt
aW4uYmVyZ0BpbnRlbC5jb20+Cj4gPiAtLS0KPiAKPiBJJ20gZ2VuZXJhbGx5IHByZXR0eSBoYXBw
eSB3aXRoIHRoaXMsIHRob3VnaCBub3RlIHRoZSBjaGVja3BhdGNoCj4gd2FybmluZyBiZWxvdy4K
PiAKPiBUaGVyZSB3YXMgc29tZSBkaXNjdXNzaW9uIGF0IHBsdW1iZXJzIGFib3V0IGV4cGFuZGlu
ZyB0aGUKPiBwYXJhbWV0ZXJpc2VkIHRlc3QgQVBJcywgc28gd2UgbWF5IG5lZWQgdG8gYWRqdXN0
IHRoZSBpbXBsZW1lbnRhdGlvbgo+IG9mIHRoaXMgZG93biB0aGUgbGluZSwgYnV0IEkgZG9uJ3Qg
dGhpbmsgdGhhdCdsbCBoYXBwZW4gZm9yIGEgd2hpbGUsCj4gc28gZG9uJ3Qgd29ycnkuCj4gCj4g
V2l0aCB0aGUgd2FybmluZ3MgZml4ZWQsIHRoaXMgaXM6CgpJIHRoaW5rIHRoZSBjaGVja3BhdGNo
IHdhcm5pbmcgaXMgYSBmYWxzZSBwb3NpdGl2ZS4gSXQgc2VlbXMgdG8gY29uZnVzZQp0aGUgKiBh
cyBhIG11bHRpcGxpY2F0aW9uIGR1ZSB0byB0eXBlb2YoKSBsb29raW5nIGxpa2UgYSBmdW5jdGlv
biBjYWxsCnJhdGhlciB0aGFuIGEgdmFyaWFibGUgZGVjbGFyYXRpb24uCgpCZW5qYW1pbgoKPiBS
ZXZpZXdlZC1ieTogRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUuY29tPgo+IAo+IEknbSBva2F5
IHdpdGggdGhpcyBnb2luZyBpbiB2aWEgdGhlIHdpcmVsZXNzIHRyZWUgaWYgdGhhdCdzIGVhc2ll
cjsKPiBjZXJ0YWlubHkgdGhlcmUgYXJlIHNvbWUgY29uZmxpY3RzIHdpdGggdGhlIGxhdGVyIHBh
dGNoZXMgaW4gdGhpcwo+IHNlcmllcyBhbmQgdGhlIGt1bml0IG9uZS4KPiAKPiBDaGVlcnMsCj4g
LS0gRGF2aWQKPiAKPiA+IMKgRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvdXNhZ2UucnN0
IHwgMTIgKysrKy0tLS0tLS0tCj4gPiDCoGluY2x1ZGUva3VuaXQvdGVzdC5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gPiDC
oDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdAo+
ID4gYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC91c2FnZS5yc3QKPiA+IGluZGV4IGMy
N2UxNjQ2ZWNkOS4uYjk1OWU1YmVmY2JlIDEwMDY0NAo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXYtdG9vbHMva3VuaXQvdXNhZ2UucnN0Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rdW5pdC91c2FnZS5yc3QKPiA+IEBAIC01NjYsMTMgKzU2Niw5IEBAIEJ5IHJldXNpbmcgdGhl
IHNhbWUgYGBjYXNlc2BgIGFycmF5IGZyb20KPiA+IGFib3ZlLCB3ZSBjYW4gd3JpdGUgdGhlIHRl
c3QgYXMgYQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0sCj4gPiDCoMKgwqDC
oMKgwqDCoCB9Owo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIC8vIE5lZWQgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gZ2VuZXJhdGUgYSBuYW1lIGZvciBlYWNoIHRlc3QKPiA+IGNhc2UuCj4gPiAtwqDCoMKg
wqDCoMKgIHN0YXRpYyB2b2lkIGNhc2VfdG9fZGVzYyhjb25zdCBzdHJ1Y3Qgc2hhMV90ZXN0X2Nh
c2UgKnQsCj4gPiBjaGFyICpkZXNjKQo+ID4gLcKgwqDCoMKgwqDCoCB7Cj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJjcHkoZGVzYywgdC0+c3RyKTsKPiA+IC3CoMKgwqDCoMKg
wqAgfQo+ID4gLcKgwqDCoMKgwqDCoCAvLyBDcmVhdGVzIGBzaGExX2dlbl9wYXJhbXMoKWAgdG8g
aXRlcmF0ZSBvdmVyIGBjYXNlc2AuCj4gPiAtwqDCoMKgwqDCoMKgIEtVTklUX0FSUkFZX1BBUkFN
KHNoYTEsIGNhc2VzLCBjYXNlX3RvX2Rlc2MpOwo+ID4gK8KgwqDCoMKgwqDCoCAvLyBDcmVhdGVz
IGBzaGExX2dlbl9wYXJhbXMoKWAgdG8gaXRlcmF0ZSBvdmVyIGBjYXNlc2AKPiA+IHdoaWxlIHVz
aW5nCj4gPiArwqDCoMKgwqDCoMKgIC8vIHRoZSBzdHJ1Y3QgbWVtYmVyIGBzdHJgIGZvciB0aGUg
Y2FzZSBkZXNjcmlwdGlvbi4KPiA+ICvCoMKgwqDCoMKgwqAgS1VOSVRfQVJSQVlfUEFSQU1fREVT
QyhzaGExLCBjYXNlcywgc3RyKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgLy8gTG9va3Mgbm8g
ZGlmZmVyZW50IGZyb20gYSBub3JtYWwgdGVzdC4KPiA+IMKgwqDCoMKgwqDCoMKgIHN0YXRpYyB2
b2lkIHNoYTFfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCj4gPiBAQCAtNTg4LDcgKzU4NCw3IEBA
IEJ5IHJldXNpbmcgdGhlIHNhbWUgYGBjYXNlc2BgIGFycmF5IGZyb20gYWJvdmUsCj4gPiB3ZSBj
YW4gd3JpdGUgdGhlIHRlc3QgYXMgYQo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gCj4gPiDCoMKg
wqDCoMKgwqDCoCAvLyBJbnN0ZWFkIG9mIEtVTklUX0NBU0UsIHdlIHVzZSBLVU5JVF9DQVNFX1BB
UkFNIGFuZCBwYXNzCj4gPiBpbiB0aGUKPiA+IC3CoMKgwqDCoMKgwqAgLy8gZnVuY3Rpb24gZGVj
bGFyZWQgYnkgS1VOSVRfQVJSQVlfUEFSQU0uCj4gPiArwqDCoMKgwqDCoMKgIC8vIGZ1bmN0aW9u
IGRlY2xhcmVkIGJ5IEtVTklUX0FSUkFZX1BBUkFNIG9yCj4gPiBLVU5JVF9BUlJBWV9QQVJBTV9E
RVNDLgo+ID4gwqDCoMKgwqDCoMKgwqAgc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNlIHNoYTFfdGVz
dF9jYXNlc1tdID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEtVTklUX0NB
U0VfUEFSQU0oc2hhMV90ZXN0LCBzaGExX2dlbl9wYXJhbXMpLAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHt9Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rdW5pdC90ZXN0Lmgg
Yi9pbmNsdWRlL2t1bml0L3Rlc3QuaAo+ID4gaW5kZXggMjBlZDlmOTI3NWM5Li4yZGZhODUxZTFm
ODggMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2t1bml0L3Rlc3QuaAo+ID4gKysrIGIvaW5jbHVk
ZS9rdW5pdC90ZXN0LmgKPiA+IEBAIC0xNTE0LDYgKzE1MTQsMjUgQEAgZG8KPiA+IHvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuCj4gPiBOVUxMO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqAg
XAo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gCj4gPiArLyoqCj4gPiArICogS1VOSVRfQVJSQVlf
UEFSQU1fREVTQygpIC0gRGVmaW5lIHRlc3QgcGFyYW1ldGVyIGdlbmVyYXRvciBmcm9tCj4gPiBh
biBhcnJheS4KPiA+ICsgKiBAbmFtZTrCoCBwcmVmaXggZm9yIHRoZSB0ZXN0IHBhcmFtZXRlciBn
ZW5lcmF0b3IgZnVuY3Rpb24uCj4gPiArICogQGFycmF5OiBhcnJheSBvZiB0ZXN0IHBhcmFtZXRl
cnMuCj4gPiArICogQGRlc2NfbWVtYmVyOiBzdHJ1Y3R1cmUgbWVtYmVyIGZyb20gYXJyYXkgZWxl
bWVudCB0byB1c2UgYXMKPiA+IGRlc2NyaXB0aW9uCj4gPiArICoKPiA+ICsgKiBEZWZpbmUgZnVu
Y3Rpb24gQG5hbWVfZ2VuX3BhcmFtcyB3aGljaCB1c2VzIEBhcnJheSB0byBnZW5lcmF0ZQo+ID4g
cGFyYW1ldGVycy4KPiA+ICsgKi8KPiA+ICsjZGVmaW5lIEtVTklUX0FSUkFZX1BBUkFNX0RFU0Mo
bmFtZSwgYXJyYXksCj4gPiBkZXNjX21lbWJlcinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvC
oMKgwqDCoMKgwqAgc3RhdGljIGNvbnN0IHZvaWQgKm5hbWUjI19nZW5fcGFyYW1zKGNvbnN0IHZv
aWQgKnByZXYsIGNoYXIKPiA+ICpkZXNjKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgCj4gPiB7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5cGVvZigoYXJyYXkpWzBdKSAqX19uZXh0ID0gcHJldiA/
Cj4gPiAoKHR5cGVvZihfX25leHQpKSBwcmV2KSArIDEgOiAoYXJyYXkpO8KgwqDCoMKgwqAgXAo+
IAo+IGNoZWNrcGF0Y2ggaXMgY29tcGxhaW5pbmcgaGVyZToKPiBFUlJPUjogbmVlZCBjb25zaXN0
ZW50IHNwYWNpbmcgYXJvdW5kICcqJyAoY3R4Old4VikKPiAjNzE6IEZJTEU6IGluY2x1ZGUva3Vu
aXQvdGVzdC5oOjE1Mjg6Cj4gCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZW9m
KChhcnJheSlbMF0pICpfX25leHQgPSBwcmV2ID8gKCh0eXBlb2YoX19uZXh0KSkKPiBwcmV2KSAr
IDEgOiAoYXJyYXkpO8KgwqDCoMKgwqAgXAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKF9fbmV4dCAtIChhcnJheSkgPCBBUlJBWV9TSVpFKChhcnJheSkpKQo+ID4ge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJzY3B5KGRlc2MsIF9fbmV4dC0+ZGVzY19tZW1iZXIsCj4gPiBLVU5JVF9QQVJBTV9E
RVNDX1NJWkUpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4KPiA+IF9fbmV4dDvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4KPiA+IE5VTEw7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoCBcCj4gPiArwqDC
oMKgwqDCoMKgIH0KPiA+ICsKPiA+IMKgLy8gVE9ETyhkbGF0eXBvdkBnb29nbGUuY29tKTogY29u
c2lkZXIgZXZlbnR1YWxseSBtaWdyYXRpbmcgdXNlcnMKPiA+IHRvIGV4cGxpY2l0bHkKPiA+IMKg
Ly8gaW5jbHVkZSByZXNvdXJjZS5oIHRoZW1zZWx2ZXMgaWYgdGhleSBuZWVkIGl0Lgo+ID4gwqAj
aW5jbHVkZSA8a3VuaXQvcmVzb3VyY2UuaD4KPiA+IC0tCj4gPiAyLjQzLjAKPiA+IAo+ID4gLS0K
PiA+IFlvdSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQg
dG8gdGhlIEdvb2dsZQo+ID4gR3JvdXBzICJLVW5pdCBEZXZlbG9wbWVudCIgZ3JvdXAuCj4gPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBm
cm9tIGl0LAo+ID4gc2VuZCBhbiBlbWFpbCB0byBrdW5pdC1kZXYrdW5zdWJzY3JpYmVAZ29vZ2xl
Z3JvdXBzLmNvbS4KPiA+IFRvIHZpZXcgdGhpcyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQK
PiA+IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9rdW5pdC1kZXYvMjAyMzEyMjAx
NTE5NTIuNDE1MjMyLTItYmVuamFtaW4lNDBzaXBzb2x1dGlvbnMubmV0Cj4gPiAuCgo=


