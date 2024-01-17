Return-Path: <linux-wireless+bounces-2097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181583074C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2701C21015
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6AF200A4;
	Wed, 17 Jan 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G5zXySJ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA561DDEA
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499155; cv=none; b=XTk8b2Gl6/mdITYIEi2qSb2P6LzwlY2Y8v+/QNleHEC7PzU/hLKqSrEJzXxjW8iNTfmJn3aq0on6jhskQApnTeOAo6+/b66QRmM1DM5W8FOQzqC9IlwWV3OMDklTiHQe86IPyO/zLsjBtx9MsUvjGUM7nXlmrtXaqqhO6TltUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499155; c=relaxed/simple;
	bh=UfsIXnTkBhHMlmz11MJhHA623/hMO4UT6zL4TkqpQiQ=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=ltxBukJmsPchl3vqBmshRC7X80gIjR75AbGQiOmkyvTjk8F9Nva9tYxKKfSXpsHGtwhifoCjZv11PUhFzMrPq5ey+mxqNXaLtLVsqpMO/APAd4QJXQxHxF0e5XkYHlhAO29lOP7kx5otDQEsF9AZ2w5BtzY9DTP6aLa0JJQQlvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G5zXySJ+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UfsIXnTkBhHMlmz11MJhHA623/hMO4UT6zL4TkqpQiQ=;
	t=1705499152; x=1706708752; b=G5zXySJ+H4ruUnd8RPh0aHDgmQ5SYZb1R2XMVLyHcgsVxA0
	keZ3QItSN4ZdOa69wOg6hwq8Wi4pAW5hRWlIx4b4wjvMQbmk7uti498fDcpwSd3YRILqCjz5fvZlH
	fXkCvBS6f11il4U9Oemu3jrj4WYEv6GvP7RZtyY38nDZ3T51mYOrD5p/AClj1AUmyBpRO/hGAd4+H
	vZXnPc0RH9Cgsm6uBeJcvX+HWf1iDOLKK2ul2eo09Ab8iBKuONzVTdWNDoW1QdvKEKZ7tFxCYPpwG
	0wsPTcpkUpjjQHxHr5mvt0sDWKVErY+sGXg6DZuEPUa8d2x2f+zbv9hG/Mu0yNwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rQ6Eg-00000006VpS-0Bpo;
	Wed, 17 Jan 2024 14:45:43 +0100
Message-ID: <1a9dacc582da8ee06eadb2805caa43af3b8d5c10.camel@sipsolutions.net>
Subject: Re: [PATCH 03/15] wifi: cfg80211: add RNR with reporting AP
 information
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Date: Wed, 17 Jan 2024 14:45:40 +0100
In-Reply-To: <20240102213313.4cb3dbb1d84f.I7c74edec83c5d7598cdd578929fd0876d67aef7f@changeid>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
	 <20240102213313.4cb3dbb1d84f.I7c74edec83c5d7598cdd578929fd0876d67aef7f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

SGksCgpqdXN0IG5vdGljZWQgdGhpcyBwYXRjaCBoYXMgYW4gb2ZmLWJ5LW9uZSBlcnJvciBhbmQg
aXQgZHJvcHMgdGhlIGxhc3QKYnl0ZSBvZiB0aGUgZ2VuZXJhdGVkIFJOUi4KCk9uIFR1ZSwgMjAy
NC0wMS0wMiBhdCAyMTozNSArMDIwMCwgTWlyaSBLb3JlbmJsaXQgd3JvdGU6Cj4gRnJvbTogQmVu
amFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRlbC5jb20+Cj4gCj4gSWYgdGhlIHJlcG9ydGlu
ZyBBUCBpcyBwYXJ0IG9mIHRoZSBzYW1lIE1MRCwgdGhlbiBhbiBlbnRyeSBpbiB0aGUgUk5SCj4g
aXMKPiByZXF1aXJlZCBpbiBvcmRlciB0byBkaXNjb3ZlciBpdCBhZ2FpbiBmcm9tIHRoZSBCU1Mg
Z2VuZXJhdGVkIGZyb20KPiB0aGUKPiBwZXItU1RBIHByb2ZpbGUgaW4gdGhlIE11bHRpLUxpbmsg
UHJvYmUgUmVzcG9uc2UuCj4gCj4gV2UgbmVlZCB0aGlzIGJlY2F1c2Ugd2UgZG8gbm90IGhhdmUg
YSBkaXJlY3QgY29uY2VwdCBvZiBhbiBNTEQgQVAgYW5kCj4ganVzdCBkbyB0aGUgbG9va3VwIGZy
b20gb25lIHRvIHRoZSBvdGhlciBvbiB0aGUgZmx5IGlmIG5lZWRlZC4gQXMKPiBzdWNoLAo+IHdl
IG5lZWQgdG8gZW5zdXJlIHRoYXQgdGhpcyBsb29rdXAgd2lsbCB3b3JrIGJvdGggd2F5cy4KPiAK
PiBGaXhlczogMjQ4MWI1ZGE5YzZiICgid2lmaTogY2ZnODAyMTE6IGhhbmRsZSBCU1MgZGF0YSBj
b250YWluZWQgaW4gTUwKPiBwcm9iZSByZXNwb25zZXMiKQo+IFNpZ25lZC1vZmYtYnk6IEJlbmph
bWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPgo+IFJldmlld2VkLWJ5OiBKb2hhbm5l
cyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaXJpIEtv
cmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPgo+IC0tLQo+IMKgbmV0
L3dpcmVsZXNzL3NjYW4uYyB8IDEzNAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9zY2FuLmMgYi9uZXQvd2ly
ZWxlc3Mvc2Nhbi5jCj4gaW5kZXggNDI1NTU3NTNiOTQ3Li5kYmI1ODg1ZDQwZTcgMTAwNjQ0Cj4g
LS0tIGEvbmV0L3dpcmVsZXNzL3NjYW4uYwo+ICsrKyBiL25ldC93aXJlbGVzcy9zY2FuLmMKPiBA
QCAtMjYxNCw2ICsyNjE0LDEwMyBAQCBjZmc4MDIxMV90YnR0X2luZm9fZm9yX21sZF9hcChjb25z
dCB1OCAqaWUsCj4gc2l6ZV90IGllbGVuLCB1OCBtbGRfaWQsIHU4IGxpbmtfaWQsCj4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4gK3N0YXRpYyBzdHJ1Y3QgZWxlbWVudCAq
Cj4gK2NmZzgwMjExX2dlbl9yZXBvcnRlcl9ybnIoc3RydWN0IGNmZzgwMjExX2JzcyAqc291cmNl
X2JzcywgYm9vbAo+IGlzX21ic3NpZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgc2FtZV9tbGQsIHU4IGxpbmtfaWQsIHU4Cj4gYnNzX2No
YW5nZV9jb3VudCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdmcF90IGdmcCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBjZmc4
MDIxMV9ic3NfaWVzICppZXM7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGllZWU4MDIxMV9uZWln
aGJvcl9hcF9pbmZvIGFwX2luZm87Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGllZWU4MDIxMV90
YnR0X2luZm9fZ2VfMTEgdGJ0dF9pbmZvOwo+ICvCoMKgwqDCoMKgwqDCoHUzMiBzaG9ydF9zc2lk
Owo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBlbGVtZW50ICplbGVtOwo+ICvCoMKgwqDC
oMKgwqDCoHN0cnVjdCBlbGVtZW50ICpyZXM7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8Kg
wqDCoMKgwqDCoMKgICogV2Ugb25seSBnZW5lcmF0ZSB0aGUgUk5SIHRvIHBlcm1pdCBNTCBsb29r
dXBzLiBGb3IgdGhhdCB3ZQo+IGRvIG5vdAo+ICvCoMKgwqDCoMKgwqDCoCAqIG5lZWQgYW4gZW50
cnkgZm9yIHRoZSBjb3JyZXNwb25kaW5nIHRyYW5zbWl0dGluZyBCU1MsIGxldHMKPiBqdXN0IHNr
aXAKPiArwqDCoMKgwqDCoMKgwqAgKiBpdCBldmVuIHRob3VnaCBpdCB3b3VsZCBiZSBlYXN5IHRv
IGFkZC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAoIXNhbWVfbWxk
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgLyogV2UgY291bGQgdXNlIHR4X2RhdGEtPmllcyBpZiB3ZSBjaGFuZ2UKPiBj
Zmc4MDIxMV9jYWxjX3Nob3J0X3NzaWQgKi8KPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF9sb2Nr
KCk7Cj4gK8KgwqDCoMKgwqDCoMKgaWVzID0gcmN1X2RlcmVmZXJlbmNlKHNvdXJjZV9ic3MtPmll
cyk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGFwX2luZm8udGJ0dF9pbmZvX2xlbiA9IG9mZnNldG9m
ZW5kKHR5cGVvZih0YnR0X2luZm8pLAo+IG1sZF9wYXJhbXMpOwo+ICvCoMKgwqDCoMKgwqDCoGFw
X2luZm8udGJ0dF9pbmZvX2hkciA9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1OF9lbmNvZGVfYml0cyhJRUVFODAyMTFfVEJUVF9JTkZPX1RZUEVfVEJU
VCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBJRUVFODAyMTFfQVBfSU5GT19UQlRUX0hEUl9UWVBF
KSB8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1OF9l
bmNvZGVfYml0cygwLAo+IElFRUU4MDIxMV9BUF9JTkZPX1RCVFRfSERSX0NPVU5UKTsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgYXBfaW5mby5jaGFubmVsID0gaWVlZTgwMjExX2ZyZXF1ZW5jeV90b19j
aGFubmVsKHNvdXJjZV9ic3MtCj4gPmNoYW5uZWwtPmNlbnRlcl9mcmVxKTsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgLyogb3BlcmF0aW5nIGNsYXNzICovCj4gK8KgwqDCoMKgwqDCoMKgZWxlbSA9Cj4g
Y2ZnODAyMTFfZmluZF9lbGVtKFdMQU5fRUlEX1NVUFBPUlRFRF9SRUdVTEFUT1JZX0NMQVNTRVMs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWVzLT5kYXRhLCBpZXMtPmxlbik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGVs
ZW0gJiYgZWxlbS0+ZGF0YWxlbiA+PSAxKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFwX2luZm8ub3BfY2xhc3MgPSBlbGVtLT5kYXRhWzBdOwo+ICvCoMKgwqDCoMKgwqDCoH0g
ZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjZmc4MDIxMV9j
aGFuX2RlZiBjaGFuZGVmOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyog
VGhlIEFQIGlzIG5vdCBwcm92aWRpbmcgdXMgd2l0aCBhbnl0aGluZyB0byB3b3JrCj4gd2l0aC4g
U28KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogbWFrZSB1cCBhIHNvbWV3aGF0
IHJlYXNvbmFibGUgb3BlcmF0aW5nIGNsYXNzLCBidXQKPiBkb24ndAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBib3RoZXIgd2l0aCBpdCB0b28gbXVjaCBhcyBubyBvbmUgd2ls
bCBldmVyIHVzZQo+IHRoZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpbmZv
cm1hdGlvbi4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNmZzgwMjExX2NoYW5kZWZfY3JlYXRlKCZjaGFuZGVmLCBz
b3VyY2VfYnNzLQo+ID5jaGFubmVsLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBOTDgwMjExX0NI
QU5fTk9fSFQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpZWVl
ODAyMTFfY2hhbmRlZl90b19vcGVyYXRpbmdfY2xhc3MoJmNoYW5kZWYsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiAmYXBfaW5mby5v
cF9jbGFzcykpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBnb3RvIG91dF91bmxvY2s7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKg
wqAvKiBKdXN0IHNldCBUQlRUIG9mZnNldCBhbmQgUFNEIDIwIHRvIGludmFsaWQvdW5rbm93biAq
Lwo+ICvCoMKgwqDCoMKgwqDCoHRidHRfaW5mby50YnR0X29mZnNldCA9IDI1NTsKPiArwqDCoMKg
wqDCoMKgwqB0YnR0X2luZm8ucHNkXzIwID0gSUVFRTgwMjExX1JOUl9UQlRUX1BBUkFNU19QU0Rf
UkVTRVJWRUQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG1lbWNweSh0YnR0X2luZm8uYnNzaWQsIHNv
dXJjZV9ic3MtPmJzc2lkLCBFVEhfQUxFTik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNmZzgwMjEx
X2NhbGNfc2hvcnRfc3NpZChpZXMsICZlbGVtLCAmc2hvcnRfc3NpZCkpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3VubG9jazsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
cmN1X3JlYWRfdW5sb2NrKCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHRidHRfaW5mby5zaG9ydF9z
c2lkID0gY3B1X3RvX2xlMzIoc2hvcnRfc3NpZCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHRidHRf
aW5mby5ic3NfcGFyYW1zID0gSUVFRTgwMjExX1JOUl9UQlRUX1BBUkFNU19TQU1FX1NTSUQ7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoGlmIChpc19tYnNzaWQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdGJ0dF9pbmZvLmJzc19wYXJhbXMgfD0KPiBJRUVFODAyMTFfUk5SX1RCVFRf
UEFSQU1TX01VTFRJX0JTU0lEOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0YnR0
X2luZm8uYnNzX3BhcmFtcyB8PQo+IElFRUU4MDIxMV9STlJfVEJUVF9QQVJBTVNfVFJBTlNNSVRU
RURfQlNTSUQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqB0YnR0X2lu
Zm8ubWxkX3BhcmFtcy5tbGRfaWQgPSAwOwo+ICvCoMKgwqDCoMKgwqDCoHRidHRfaW5mby5tbGRf
cGFyYW1zLnBhcmFtcyA9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlMTZfZW5j
b2RlX2JpdHMobGlua19pZCwKPiBJRUVFODAyMTFfUk5SX01MRF9QQVJBTVNfTElOS19JRCkgfAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsZTE2X2VuY29kZV9iaXRzKGJzc19jaGFu
Z2VfY291bnQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgCj4gSUVFRTgwMjExX1JOUl9NTERfUEFSQU1TX0JTU19DSEFOR0Vf
Q09VTlQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXMgPSBremFsbG9jKHN0cnVjdF9zaXplKHJl
cywgZGF0YSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoYXBfaW5mbykgKwo+IGFwX2luZm8udGJ0dF9pbmZv
X2xlbiksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2ZwKTsK
PiArwqDCoMKgwqDCoMKgwqBpZiAoIXJlcykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIE5VTEw7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIENvcHkgdGhlIGRhdGEgKi8K
PiArwqDCoMKgwqDCoMKgwqByZXMtPmlkID0gV0xBTl9FSURfUkVEVUNFRF9ORUlHSEJPUl9SRVBP
UlQ7Cj4gK8KgwqDCoMKgwqDCoMKgcmVzLT5kYXRhbGVuID0gc2l6ZW9mKGFwX2luZm8pICsgYXBf
aW5mby50YnR0X2luZm9fbGVuOwo+ICvCoMKgwqDCoMKgwqDCoG1lbWNweShyZXMtPmRhdGEsICZh
cF9pbmZvLCBzaXplb2YoYXBfaW5mbykpOwo+ICvCoMKgwqDCoMKgwqDCoG1lbWNweShyZXMtPmRh
dGEgKyBzaXplb2YoYXBfaW5mbyksICZ0YnR0X2luZm8sCj4gYXBfaW5mby50YnR0X2luZm9fbGVu
KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJlczsKPiArCj4gK291dF91bmxvY2s6Cj4g
K8KgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IE5VTEw7Cj4gK30KPiArCj4gwqBzdGF0aWMgdm9pZAo+IMKgY2ZnODAyMTFfcGFyc2VfbWxfZWxl
bV9zdGFfZGF0YShzdHJ1Y3Qgd2lwaHkgKndpcGh5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QKPiBjZmc4MDIx
MV9pbmZvcm1fc2luZ2xlX2Jzc19kYXRhICp0eF9kYXRhLAo+IEBAIC0yNjI3LDEzICsyNzI0LDE0
IEBAIGNmZzgwMjExX3BhcnNlX21sX2VsZW1fc3RhX2RhdGEoc3RydWN0IHdpcGh5Cj4gKndpcGh5
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnNvdXJjZV9ic3MgPSBzb3VyY2Vf
YnNzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmJzc19zb3VyY2UgPSBCU1Nf
U09VUkNFX1NUQV9QUk9GSUxFLAo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBlbGVtZW50ICpyZXBvcnRlcl9ybnIgPSBOVUxMOwo+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgaWVlZTgwMjExX211bHRpX2xpbmtfZWxlbSAqbWxfZWxlbTsKPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IGNmZzgwMjExX21sZSAqbWxlOwo+IMKgwqDCoMKgwqDCoMKgwqB1MTYgY29udHJv
bDsKPiDCoMKgwqDCoMKgwqDCoMKgdTggbWxfY29tbW9uX2xlbjsKPiAtwqDCoMKgwqDCoMKgwqB1
OCAqbmV3X2llOwo+ICvCoMKgwqDCoMKgwqDCoHU4ICpuZXdfaWUgPSBOVUxMOwo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgY2ZnODAyMTFfYnNzICpic3M7Cj4gLcKgwqDCoMKgwqDCoMKgaW50IG1s
ZF9pZDsKPiArwqDCoMKgwqDCoMKgwqB1OCBtbGRfaWQsIHJlcG9ydGVyX2xpbmtfaWQsIGJzc19j
aGFuZ2VfY291bnQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHUxNiBzZWVuX2xpbmtzID0gMDsKPiDCoMKg
wqDCoMKgwqDCoMKgY29uc3QgdTggKnBvczsKPiDCoMKgwqDCoMKgwqDCoMKgdTggaTsKPiBAQCAt
MjY1NSw4ICsyNzUzLDE0IEBAIGNmZzgwMjExX3BhcnNlX21sX2VsZW1fc3RhX2RhdGEoc3RydWN0
IHdpcGh5Cj4gKndpcGh5LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG1sX2NvbW1vbl9sZW4gPSBt
bF9lbGVtLT52YXJpYWJsZVswXTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC8qIGxlbmd0aCArIE1M
RCBNQUMgYWRkcmVzcyArIGxpbmsgSUQgaW5mbyArIEJTUyBQYXJhbXMKPiBDaGFuZ2UgQ291bnQg
Ki8KPiAtwqDCoMKgwqDCoMKgwqBwb3MgPSBtbF9lbGVtLT52YXJpYWJsZSArIDEgKyA2ICsgMSAr
IDE7Cj4gK8KgwqDCoMKgwqDCoMKgLyogbGVuZ3RoICsgTUxEIE1BQyBhZGRyZXNzICovCj4gK8Kg
wqDCoMKgwqDCoMKgcG9zID0gbWxfZWxlbS0+dmFyaWFibGUgKyAxICsgNjsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgcmVwb3J0ZXJfbGlua19pZCA9IHBvc1swXTsKPiArwqDCoMKgwqDCoMKgwqBwb3Mg
Kz0gMTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgYnNzX2NoYW5nZV9jb3VudCA9IHBvc1swXTsKPiAr
wqDCoMKgwqDCoMKgwqBwb3MgKz0gMTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodTE2X2dl
dF9iaXRzKGNvbnRyb2wsCj4gSUVFRTgwMjExX01MQ19CQVNJQ19QUkVTX01FRF9TWU5DX0RFTEFZ
KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBvcyArPSAyOwo+IEBAIC0yNjg3
LDEwICsyNzkxLDIxIEBAIGNmZzgwMjExX3BhcnNlX21sX2VsZW1fc3RhX2RhdGEoc3RydWN0IHdp
cGh5Cj4gKndpcGh5LAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1sZSkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoC8qIE5vIHBv
aW50IGluIGRvaW5nIGFueXRoaW5nIGlmIHRoZXJlIGlzIG5vIHBlci1TVEEgcHJvZmlsZQo+ICov
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFtbGUtPnN0YV9wcm9mWzBdKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoG5ld19pZSA9
IGttYWxsb2MoSUVFRTgwMjExX01BWF9EQVRBX0xFTiwgZ2ZwKTsKPiDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFuZXdfaWUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsK
PiDCoAo+ICvCoMKgwqDCoMKgwqDCoHJlcG9ydGVyX3JuciA9IGNmZzgwMjExX2dlbl9yZXBvcnRl
cl9ybnIoc291cmNlX2JzcywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oAo+IHUxNl9nZXRfYml0cyhjb250cm9sLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBJRUVFODAyMTFfTUxDX0JBU0lD
X1BSRVNfTUxEX0lEKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
bGRfaWQgPT0gMCwKPiByZXBvcnRlcl9saW5rX2lkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJzc19jaGFuZ2VfY291bnQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ2ZwKTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKG1sZS0+c3RhX3Byb2YpICYmIG1sZS0KPiA+c3RhX3Byb2ZbaV07IGkr
Kykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGllZWU4
MDIxMV9uZWlnaGJvcl9hcF9pbmZvICphcF9pbmZvOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZW51bSBubDgwMjExX2JhbmQgYmFuZDsKPiBAQCAtMjgwMCw3ICsyOTE1LDE1IEBA
IGNmZzgwMjExX3BhcnNlX21sX2VsZW1fc3RhX2RhdGEoc3RydWN0IHdpcGh5Cj4gKndpcGh5LAo+
IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhLmllbGVuICs9IHNpemVv
ZigqbWxfZWxlbSkgKyBtbF9jb21tb25fbGVuOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC8qIFRPRE86IEFkZCBhbiBSTlIgY29udGFpbmluZyBvbmx5IHRoZSByZXBvcnRp
bmcgQVAKPiAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVwb3J0ZXJf
cm5yICYmICh1c2VfZm9yICYKPiBOTDgwMjExX0JTU19VU0VfRk9SX05PUk1BTCkpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkYXRhLmllbGVu
ICsgMSArIHJlcG9ydGVyX3Juci0+ZGF0YWxlbiA+Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSUVFRTgwMjExX01BWF9EQVRBX0xFTikKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb250aW51ZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBtZW1jcHkobmV3X2llICsgZGF0YS5pZWxlbiwgcmVwb3J0ZXJfcm5yLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDEgKyByZXBvcnRlcl9ybnItPmRhdGFsZW4pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF0YS5pZWxlbiArPSAxICsgcmVwb3J0ZXJfcm5yLT5kYXRh
bGVuOwoKaS5lLiBldmVyeXdoZXJlIGhlcmUgaXQgbmVlZHMgdG8gYWRkIDIgKDEgYnl0ZSBFSUQs
IDEgYnl0ZSBkYXRhbGVuKS4KCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnNzID0gY2ZnODAyMTFfaW5mb3Jt
X3NpbmdsZV9ic3NfZGF0YSh3aXBoeSwgJmRhdGEsCj4gZ2ZwKTsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICghYnNzKQo+IEBAIC0yODA5LDYgKzI5MzIsNyBAQCBjZmc4MDIx
MV9wYXJzZV9tbF9lbGVtX3N0YV9kYXRhKHN0cnVjdCB3aXBoeQo+ICp3aXBoeSwKPiDCoMKgwqDC
oMKgwqDCoMKgfQo+IMKgCj4gwqBvdXQ6Cj4gK8KgwqDCoMKgwqDCoMKga2ZyZWUocmVwb3J0ZXJf
cm5yKTsKPiDCoMKgwqDCoMKgwqDCoMKga2ZyZWUobmV3X2llKTsKPiDCoMKgwqDCoMKgwqDCoMKg
a2ZyZWUobWxlKTsKPiDCoH0KCkJlbmphbWluCg==


