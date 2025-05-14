Return-Path: <linux-wireless+bounces-22960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E61AB75EF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 21:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F816B921
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2C28E616;
	Wed, 14 May 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YP82jBx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50561624DD
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251243; cv=none; b=cTRV3efpihk5D1hCBUv6ftVumfoZTRow7CtfdoPg+kWKlVgc168ByhqPoqxRily6AXuS7l/RdiF5/MEr6GUbGV/FuvTu73Yz2Aac0U+seUzU2725pBQFliODWu6Af55iBBL+olYWnSs904FibsUQixH6jYVhlu1Uo+tHyFb+9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251243; c=relaxed/simple;
	bh=bjv0v2HmWLfU9IGKDDjdyHQzkVF9Sjm/sMUggJZmirI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAGA4b04kR15A9afCh8pwawZlgVPioRKiuV5QRlDNQLAPAiZ8N+A1vIFMusBj+6SUv9EueUN+1ZRz58Wqe08zGWGQNyajITmMm04hpizT24Lrip6ej3htOMU/46Ohita7+co7AhNl+TwCppLxjUAO54yKcpMfjkcpbrmQ6Wv85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YP82jBx2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bjv0v2HmWLfU9IGKDDjdyHQzkVF9Sjm/sMUggJZmirI=;
	t=1747251241; x=1748460841; b=YP82jBx2wlxQEVdqnMsa5SlNRx3wE53XMoDRzvawwkZc7P0
	mUgEqEMnL2DuKeKDgH8Zl1Ya9ZE5WlpNRudS6ClEJT2bLg42mg9dPMIxUmrycy0Lpf/6a1fWqeQmG
	gqNEHmqy92bSUcvriH64uB+F0SpqoPhtdhO14Cp/h53BjEglUM/Hew6lCoTCVEKrplf04ZpEDbSH0
	zmfIbgJUv8mFcGnLeTQfaAxrNqp0Asycasr/WCe2I2oWQE4rtSgAVi7BJu9mtkZdjMf2IpvzQyPVR
	UY0qyV9ivg7yaVtt77zXKhQXxBtiNJiMzRmOA+s+qXZyDzQdBIMxedHcwjZ08xmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFHra-00000008iPC-3haO;
	Wed, 14 May 2025 21:33:59 +0200
Message-ID: <bcadebc3bfef65ea334c983dd8bad75d411d1e77.camel@sipsolutions.net>
Subject: Re: pull-request: iwlwifi-next-2025-05-14
From: Johannes Berg <johannes@sipsolutions.net>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Wireless
	 <linux-wireless@vger.kernel.org>
Date: Wed, 14 May 2025 21:33:58 +0200
In-Reply-To: <MW5PR11MB5810C98CE53692F2644960CBA391A@MW5PR11MB5810.namprd11.prod.outlook.com>
References: 
	<MW5PR11MB5810C98CE53692F2644960CBA391A@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDA4OjI4ICswMDAwLCBLb3JlbmJsaXQsIE1pcmlhbSBSYWNo
ZWwgd3JvdGU6Cj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4ODVlNWNiYWEw
ZWUzNzM4ZmNkOTkxNjc0Mzk0NTllZGUyY2MxMDJjOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqBS
ZXZlcnQgIndpZmk6IGl3bHdpZmk6IGNsZWFuIHVwIGNvbmZpZyBtYWNybyIgKDIwMjUtMDQtMjUg
MTE6NTk6NTQgKzAyMDApwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBhcmUgYXZhaWxhYmxlIGluIHRo
ZSBHaXQgcmVwb3NpdG9yeSBhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+
IMKgwqBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3
aWZpL2l3bHdpZmktbmV4dC5naXQvIGl3bHdpZmktbmV4dC0yMDI1LTA1LTE0Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAKPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMmU3YmVk
YzQ0MmNmYzQ1MjYwZjBjYjU5MGMwN2E5NGVmZWY3MWIzZTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHwKPiDCoMKgd2lmaTogaXdsd2lmaTogbWxkOiBhbGxvdyAyIFJPQ3Mgb24gdGhlIHNhbWUg
dmlmICgyMDI1LTA1LTEzIDEzOjE0OjE5ICswMzAwKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwKPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfAo+IGl3bHdpZmkgZmVhdHVyZXMsIG5vdGFibHkgYSByZXdvcmsgb2YgdGhl
IHRyYW5zIGNvbmZpZ3VyYXRpb27CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfAoKWW91IGhhdmUgYSBsb3Qg
b2YgdHJhaWxpbmcgd2hpdGVzcGFjZSAoSSBhZGRlZCB0aGUgfCBjaGFycyk/IFRoYXQncwp3ZWly
ZD8gTWF5YmUgeW91IGNhbiBjb3B5L3Bhc3RlIGRpZmZlcmVudGx5LCBvciBzb21ldGhpbmc/CgpB
bnl3YXksIG1vcmUgaW1wb3J0YW50bHk6Cgpjb21taXQgNDY0NzU3NTIzM2M1NTI2MGI2YjBmMjk5
ZWNjNDU1NWU2MDYwN2U3YiBoYXMgYSBicm9rZW4gbGluayB0YWc6CgpMaW5rOiBodHRwczovL3Bh
dGNoLm1zZ2lkLmxpbmsvMjAyNTA1MTExOTUxMzcuOWYxN2RmZWYxNmU0LkkwZmZlMjQyZjNhMDAy
MWQxN2IyNGI4YTIxZDI0MmVkNzRkNmMyYWQ1eC1pd2x3aWZpLXN0YWNrLWRldjogYWE0YjZhMzQ0
MTFhMWQwZGYyMTdjMzNmYWEyNmM5OTJjMzFlYmFmMkBjaGFuZ2VpZAoKU2luY2UgeW91IGNhbiBy
ZWJhc2UgeW91ciB0cmVlIHBsZWFzZSBmaXggdGhhdC4KCgpBbHNvIG9uZSBjb21taXQgdXNlZCBh
IGRpZmZlcmVudCBkb21haW46CgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUw
MzE5LWl3bF9wb3dlcl9zY2hlbWUta2RvYy12MS0xLTIwMzNhZTM4YjE3OEBvc3MucXVhbGNvbW0u
Y29tCgpXYXMgdGhhdCBpbnRlbmRlZD8KCmpvaGFubmVzCg==


