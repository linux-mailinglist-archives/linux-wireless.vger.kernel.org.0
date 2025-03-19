Return-Path: <linux-wireless+bounces-20565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB085A68EF8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798BC167825
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672081AA1F4;
	Wed, 19 Mar 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="UMWJqkxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.126.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75901185935;
	Wed, 19 Mar 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.126.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393978; cv=none; b=YQ/fy0+6xUa8QNC5pdLNhXULYXiI4IYONbkE2TFJ5F9FoMliwRib/brEtpWumfnj76+YjEX3ZiV6UrU3W6760zKWqdvdT9NoIDt785KYiyMzqNefoK15PX67U2YI7EI8HOok36HhZtRsNiwXWGwDe4puYIHdPwPKxRT0f/0aEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393978; c=relaxed/simple;
	bh=yim/YTQweP5vISXeJrw3tEHDFuoIMj7xnzYfKm1jwTw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MgRoAyFx5PsQkdjFqdmQPziBWmAmyUG6vFjWUHR1eh/cn+7Xxc7plILIUPdax/pmxhehTQw26WVOjDM4UXaS2zGijbW6/A3sTpSbS+AzJuQKzljPO2FtCiq4AmaSVYVQ3VW0N4vrdciScT7TJmuMWliJ8jRNONue9sbzlLSIId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com; spf=pass smtp.mailfrom=orange.com; dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b=UMWJqkxb; arc=none smtp.client-ip=80.12.126.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1742393975; x=1773929975;
  h=message-id:date:mime-version:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:from;
  bh=yim/YTQweP5vISXeJrw3tEHDFuoIMj7xnzYfKm1jwTw=;
  b=UMWJqkxbLlBbM42RcfuY4dw5u4yQR4mO2fEBc10AeuglxHo9I6X0nZkl
   Wi1Bfp0jitUxgO/oRaBoGz4biWzmdTG19EB1nqYekvLK2MDFtEub2SRn7
   qhSpj1wdBeUiwbFMY8xW5KiI6t1/n3YtpYfiVeMIBOwpcj142h7H0rXB0
   OdLzE52tyj70QNonFWXaaHHfM/ZuEMmL/8v2Gqgy0udg0Mzdsng1BPbny
   yZvv0IVAP5jN6q3WUYBZiT1NaGiazmaaWtq+zq7AVC2SIyf+qtQsKUBFV
   wz2wIOwuSSnyek8gLzXtEK+QjJdsyA2+k2bx+vuXFdmvK9Jnpn8lh/Gws
   A==;
X-CSE-ConnectionGUID: I3l1ymV5Rwe0Cyn+o4LYjw==
X-CSE-MsgGUID: 1RvcvINFSFylmNKG8ZvAdA==
Received: from unknown (HELO opfedv1rlp0h.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 15:18:22 +0100
Received: from mailhost.rd.francetelecom.fr (HELO l-mail-int) ([x.x.x.x]) by
 opfedv1rlp0h.nor.fr.ftgroup with ESMTP; 19 Mar 2025 15:18:21 +0100
Received: from lat6466.rd.francetelecom.fr ([x.x.x.x])	by l-mail-int with esmtp (Exim
 4.94.2)	(envelope-from <alexandre.ferrieux@orange.com>)	id 1tuuFP-001UIg-Pw;
 Wed, 19 Mar 2025 15:18:20 +0100
From: alexandre.ferrieux@orange.com
X-CSE-ConnectionGUID: yc2F3bwzSNimrSWVOJ2GUw==
X-CSE-MsgGUID: 1pBmdscdSHOVQjXGX2zHgA==
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="265202694"
Message-ID: <2b5c91c6-49db-42bb-803c-c01dc785e1f1@orange.com>
Date: Wed, 19 Mar 2025 15:18:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mac80211: clip ADDBA instead of bailing out
To: James Prestwood <prestwoj@gmail.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20250317163902.1893378-1-sashal@kernel.org>
 <20250317163902.1893378-2-sashal@kernel.org>
 <69c63a19-5419-4bbe-858f-6ca100345a28@orange.com>
 <1560b292-6366-4588-ad4d-654377613b84@gmail.com>
Content-Language: fr, en-US
In-Reply-To: <1560b292-6366-4588-ad4d-654377613b84@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFtZXMsCgpUaGVyZSBpcyByb3VnaGx5IGEgOHggc2xvd2Rvd24gOn0KSSBnb3QgdGhlc2Ug
bnVtYmVycyBmcm9tIHRoZSBjb2xsZWFndWVzIHdobyBkZXRlY3RlZCB0aGUgaXNzdWUKCiAgLSBw
aHlzaWNhbCBhdmFpbGFibGUgYmFuZHdpZHRoIDEuNzMzIEdicHMgKGFzIHBlciBpd2NvbmZpZykK
ICAtIEFEREJBIG9mZmVyIHNpemU9MjU2CiAgLSBlZmZlY3RpdmUgYmFuZHdpZHRoIG9ic2VydmVk
IDEuMkdicHMgd2l0aCBhY2NlcHQtYW5kLWNsaXAtQUREQkEgKHNpemU9NjQpCiAgLSB2cy4gMTUw
IE1icHMgd2l0aCByZWplY3QtQUREQkEKCk5vdGUsIGFzIGEgV2lmaSByb29raWUgaXQgaXMgbm90
IGltbWVkaWF0ZWx5IG9idmlvdXMgdG8gbWUgaG93IHRoZSBzZW1hbnRpY3Mgb2YKYWNrIGFnZ3Jl
Z2F0aW9uIHdvdWxkIGludGVyZmVyZSB3aXRoIGJyb2FkY2FzdCBhY3Rpb25zLCBhcyBBRERCQSBh
cmUgc3VwcG9zZWRseQp1bmljYXN0LiBCdXQgeW91J3JlIHRoZSBleHBlcnQgOikKCgoKT24gMTkv
MDMvMjAyNSAxNDoyMSwgSmFtZXMgUHJlc3R3b29kIHdyb3RlOgo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gQ0FVVElPTiA6IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBvdXRzaWRlIHRoZSBjb21wYW55LiBEbyBub3QgY2xpY2sgb24gYW55IGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBhcmUgZXhwZWN0aW5nIHRoZW0gZnJv
bSB0aGUgc2VuZGVyLgo+IAo+IEFUVEVOVElPTiA6IENldCBlLW1haWwgcHJvdmllbnQgZGUgbCdl
eHTDqXJpZXVyIGRlIGwnZW50cmVwcmlzZS4gTmUgY2xpcXVleiBwYXMgc3VyIGxlcyBsaWVucyBv
dSBuJ291dnJleiBwYXMgbGVzIHBpw6hjZXMgam9pbnRlcyDDoCBtb2lucyBkZSBjb25uYWl0cmUg
bCdleHDDqWRpdGV1ci4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+IAo+IEhpIEFsZXhhbmRyZSwKPiAKPiBPbiAzLzE5LzI1IDM6NTggQU0s
IEFsZXhhbmRyZSBGZXJyaWV1eCB3cm90ZToKPj4gV2hlbiBhIExpbnV4IFdpZml7NCw1fSBkZXZp
Y2UgdGFsa3MgdG8gYSBXaWZpNiBBUCwgaWYgdGhlIEFQIHByb3Bvc2VzIGEgQmxvY2sKPj4gQWNr
bm93bGVkZ2VtZW50IGFnZ3JlZ2F0aW9uIHNpemUgKEFEREJBKSBleGNlZWRpbmcgaXRzIGV4cGVj
dGF0aW9ucywgdGhlIGNvZGUgaW4KPj4gbWFjODAyMTEganVzdCBiYWlscyBvdXQsIHJlamVjdGlu
ZyB0aGUgYWdncmVnYXRpb24uIFRoaXMgeWllbGRzIGEgYmlnCj4+IHBlcmZvcm1hbmNlIHBlbmFs
dHkgb24gdGhlIGFjayBwYXRoLCB3aGljaCBpcyBvYnNlcnZhYmxlIGluIGNvbXBhcmlzb24gd2l0
aAo+PiBvdGhlciBPU2VzIChXaW5kb3dzIGFuZCBNYWNPUykgd2hpY2ggInBsYXkgc21hcnRlciIg
YW5kIGFjY2VwdCB0aGUgcHJvcG9zYWwgd2l0aAo+PiBhICJjbGlwcGVkIiBzaXplLgo+IE91dCBv
ZiBjdXJpb3NpdHkgZG8geW91IGhhdmUgYW55IHBlcmZvcm1hbmNlIG51bWJlcnMgZm9yIHRoaXMs
IGxpa2UgCj4gTGludXggdnMgV2luZG93cyB2cyBNYWNPUz8gV2UgcmFuIGludG8gYSBzaWduaWZp
Y2FudCBwZXJmb3JtYW5jZSBoaXQgCj4gYWZ0ZXIgSSBhZGRlZCBtdWx0aWNhc3QgUlggc3VwcG9y
dCBvbiBhdGgxMGsgKGFmdGVyIH4zMCBjbGllbnRzIHdlcmUgb24gCj4gdGhlIHNhbWUgY2hhbm5l
bCkuIEFmdGVyIGxvb2tpbmcgaW50byB0aGUgcGNhcHMgd2Ugc2F3IG1hbnkgQUREQkEgCj4gZmFp
bHVyZXMgYW5kIHVsdGltYXRlbHkgaGFkIHRvIGRpc2FibGUgbXVsdGljYXN0IFJYLiBJIHdhbnQg
dG8gZ2l2ZSB0aGlzIAo+IHBhdGNoIGEgdHJ5IGVpdGhlciB3YXksIGJ1dCBJIHdhcyBjdXJpb3Vz
IGlmIHlvdSBoYWQgYW55IGRhdGEgb24gCj4gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLgo+Pgo+
PiBBIHR5cGljYWwgc2NlbmFyaW8gd291bGQgYmU6Cj4+Cj4+ICAgIEFQIC0+IERldmljZSA6IEFE
REJBX3JlcXVlc3Qoc2l6ZT0yNTYpCj4+Cj4+IEN1cnJlbnQgTGludXggcmVhY3Rpb246Cj4+Cj4+
ICAgIERldmljZSAtPiBBUCA6IEFEREJBX3JlcGx5KGZhaWx1cmUpCj4+Cj4+IE90aGVyIE9TZXMg
cmVhY3Rpb246Cj4+Cj4+ICAgIERldmljZSAtPiBBUCA6IEFEREJBX3JlcGx5KHNpemU9NjQpCj4+
Cj4+IE5vdGUgdGhhdCB0aGUgSUVFRTgwMi4xMSBzdGFuZGFyZCBhbGxvd3MgZm9yIGJvdGggcmVh
Y3Rpb25zLCBidXQgaXQgc291bmRzCj4+IHJlYWxseSBzdWJvcHRpbWFsIHRvIGJlIGJhaWxpbmcg
b3V0IGluc3RlYWQgb2YgY2xpcHBpbmcuIFRoZSBwYXRjaCBiZWxvdyBkb2VzCj4+IHRoZSBsYXR0
ZXIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBGZXJyaWV1eCA8YWxleGFuZHJlLmZl
cnJpZXV4QGdtYWlsLmNvbT4KPj4gLS0tCj4+Cj4+IGRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEv
YWdnLXJ4LmMgYi9uZXQvbWFjODAyMTEvYWdnLXJ4LmMKPj4gaW5kZXggZjNmYmU1YTQzOTVlLi4y
NjRkYWQ4NDc4NDIgMTAwNjQ0Cj4+IC0tLSBhL25ldC9tYWM4MDIxMS9hZ2ctcnguYwo+PiArKysg
Yi9uZXQvbWFjODAyMTEvYWdnLXJ4LmMKPj4gQEAgLTMxNywxOCArMzE3LDIwIEBAIHZvaWQgX19p
ZWVlODAyMTFfc3RhcnRfcnhfYmFfc2Vzc2lvbihzdHJ1Y3Qgc3RhX2luZm8gKnN0YSwKPj4gICAg
ICAgICAgICAgICAgICBtYXhfYnVmX3NpemUgPSBJRUVFODAyMTFfTUFYX0FNUERVX0JVRl9IVDsK
Pj4KPj4gICAgICAgICAgLyogc2FuaXR5IGNoZWNrIGZvciBpbmNvbWluZyBwYXJhbWV0ZXJzOgo+
PiAtICAgICAgICAqIGNoZWNrIGlmIGNvbmZpZ3VyYXRpb24gY2FuIHN1cHBvcnQgdGhlIEJBIHBv
bGljeQo+PiAtICAgICAgICAqIGFuZCBpZiBidWZmZXIgc2l6ZSBkb2VzIG5vdCBleGNlZWRzIG1h
eCB2YWx1ZSAqLwo+PiArICAgICAgICAqIGNoZWNrIGlmIGNvbmZpZ3VyYXRpb24gY2FuIHN1cHBv
cnQgdGhlIEJBIHBvbGljeSAqLwo+PiAgICAgICAgICAvKiBYWFg6IGNoZWNrIG93biBodCBkZWxh
eWVkIEJBIGNhcGFiaWxpdHk/PyAqLwo+PiAgICAgICAgICBpZiAoKChiYV9wb2xpY3kgIT0gMSkg
JiYKPj4gLSAgICAgICAgICAgICghKHN0YS0+c3RhLmRlZmxpbmsuaHRfY2FwLmNhcCAmIElFRUU4
MDIxMV9IVF9DQVBfREVMQVlfQkEpKSkgfHwKPj4gLSAgICAgICAgICAgKGJ1Zl9zaXplID4gbWF4
X2J1Zl9zaXplKSkgewo+PiAtICAgICAgICAgICAgICAgc3RhdHVzID0gV0xBTl9TVEFUVVNfSU5W
QUxJRF9RT1NfUEFSQU07Cj4+ICsgICAgICAgICAgICAoIShzdGEtPnN0YS5kZWZsaW5rLmh0X2Nh
cC5jYXAgJiBJRUVFODAyMTFfSFRfQ0FQX0RFTEFZX0JBKSkpKSB7Cj4+ICsgICAgICAgICAgICAg
ICBzdGF0dXMgPSBXTEFOX1NUQVRVU19JTlZBTElEX1FPU19QQVJBTTsKPj4gICAgICAgICAgICAg
ICAgICBodF9kYmdfcmF0ZWxpbWl0ZWQoc3RhLT5zZGF0YSwKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIkFkZEJBIFJlcSB3aXRoIGJhZCBwYXJhbXMgZnJvbSAlcE0gb24g
dGlkCj4+ICV1LiBwb2xpY3kgJWQsIGJ1ZmZlciBzaXplICVkXG4iLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdGEtPnN0YS5hZGRyLCB0aWQsIGJhX3BvbGljeSwgYnVm
X3NpemUpOwo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZW5kOwo+PiAgICAgICAgICB9Cj4+ICsg
ICAgICAgaWYgKGJ1Zl9zaXplID4gbWF4X2J1Zl9zaXplKSB7Cj4+ICsgICAgICAgICBidWZfc2l6
ZSA9IG1heF9idWZfc2l6ZSA7IC8vIENsaXAgaW5zdGVhZCBvZiBiYWlsaW5nIG91dAo+PiArICAg
ICAgIH0KPj4gKwo+PiAgICAgICAgICAvKiBkZXRlcm1pbmUgZGVmYXVsdCBidWZmZXIgc2l6ZSAq
Lwo+PiAgICAgICAgICBpZiAoYnVmX3NpemUgPT0gMCkKPj4gICAgICAgICAgICAgICAgICBidWZf
c2l6ZSA9IG1heF9idWZfc2l6ZTsKPj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KQ2UgbWVzc2FnZSBldCBzZXMgcGllY2VzIGpvaW50ZXMg
cGV1dmVudCBjb250ZW5pciBkZXMgaW5mb3JtYXRpb25zIGNvbmZpZGVudGllbGxlcyBvdSBwcml2
aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBkb25jDQpwYXMgZXRyZSBkaWZmdXNlcywgZXhwbG9pdGVz
IG91IGNvcGllcyBzYW5zIGF1dG9yaXNhdGlvbi4gU2kgdm91cyBhdmV6IHJlY3UgY2UgbWVzc2Fn
ZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBsZSBzaWduYWxlcg0KYSBsJ2V4cGVkaXRldXIgZXQgbGUg
ZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBwaWVjZXMgam9pbnRlcy4gTGVzIG1lc3NhZ2VzIGVsZWN0
cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGlibGVzIGQnYWx0ZXJhdGlvbiwNCk9yYW5nZSBkZWNsaW5l
IHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNpIGNlIG1lc3NhZ2UgYSBldGUgYWx0ZXJlLCBkZWZvcm1l
IG91IGZhbHNpZmllLiBNZXJjaS4NCg0KVGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMg
bWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24gdGhhdCBt
YXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsNCnRoZXkgc2hvdWxkIG5vdCBiZSBkaXN0cmlidXRlZCwg
dXNlZCBvciBjb3BpZWQgd2l0aG91dCBhdXRob3Jpc2F0aW9uLg0KSWYgeW91IGhhdmUgcmVjZWl2
ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZWxl
dGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMuDQpBcyBlbWFpbHMgbWF5IGJlIGFs
dGVyZWQsIE9yYW5nZSBpcyBub3QgbGlhYmxlIGZvciBtZXNzYWdlcyB0aGF0IGhhdmUgYmVlbiBt
b2RpZmllZCwgY2hhbmdlZCBvciBmYWxzaWZpZWQuDQpUaGFuayB5b3UuCg==


