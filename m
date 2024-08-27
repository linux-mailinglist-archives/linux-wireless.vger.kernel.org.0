Return-Path: <linux-wireless+bounces-12023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAC960335
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA601C20F89
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20E156C49;
	Tue, 27 Aug 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="hk7IiyAP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38712F5B1;
	Tue, 27 Aug 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744105; cv=none; b=YohGEonqNqE4m2966wvU6XkDOQi57pKeDOtR/CWjXkI9wQvFGkbFqIWgHt2fm1UYgowFBq2M1Sa8VW42xcWXArmk8eyspqsldc9ufYhMSop4IV/kZvMnuUvGI0autBmBZp+/vzYeUmBlA6rzlfuNYEaVCDVzLwVN+7rlEO/mqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744105; c=relaxed/simple;
	bh=SQrtQXwfSCQ/wfiVHxw8cV/z3ueJTE1OXJDhsMY6Bm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OhVar05UOELlCuRvwbIwXjXT/rtpvokF5CebMftbbyjPHlCJAbu1LXRZnn+0SV2JxHdUyIgaoumMQX21rnJOImG5Ne86pZg/KzRKULzbn1qySBzCFHpf8fwf4Y3NI7XzQX1m7BuGbP19dyGlOii/cClNidmgSROgWeXJg1eTBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=hk7IiyAP reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=6yDorCpR3hyCOKQ208KL/yDdTBLn9b/agsmTLgOTroY=; b=h
	k7IiyAPGei1oLahXWZkTpXkS6+xXXIbx4KXEKLE1AE2+Vhl8bvRWmJLOS6MlEiMX
	MLqcK4yulRoVrU2fT+fnvxVyPCdCXm4ZxrNqRMzsaPv5iep2kQ2kipfuB07f+gp5
	k3az8MLSuhk5wIoHios19J/TbRClaiq1z4d3HRdyRw=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Tue, 27 Aug 2024 15:34:34 +0800
 (CST)
Date: Tue, 27 Aug 2024 15:34:34 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: miriam.rachel.korenblit@intel.com, johannes.berg@intel.com, 
	gregory.greenman@intel.com, pagadala.yesu.anjaneyulu@intel.com, 
	dan.carpenter@linaro.org, daniel.gabay@intel.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: acpi/dsm: cache error retcode for
 iwl_acpi_get_dsm
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <871q2afplp.fsf@kernel.org>
References: <20240827005114.4950-1-00107082@163.com>
 <871q2afplp.fsf@kernel.org>
X-NTES-SC: AL_Qu2ZBvufu0gs4iOQY+kZnEYQheY4XMKyuPkg1YJXOp80pCTQ6wwNY3tsBnLY+tCLLAGmtByXQhdl0MBCUZVGYKi3doYaIkyz3snGFqhROR0g
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b7cfbd0.678e.19192c20498.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H6OLgc1mAnJHAA--.21131W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRVIqmVOCd2mtQADsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDgtMjcgMTQ6MjY6NDIsICJLYWxsZSBWYWxvIiA8a3ZhbG9Aa2VybmVsLm9yZz4g
d3JvdGU6Cj5EYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cml0ZXM6Cj4KPj4gT24gc29t
ZSBIVywgYWNwaSBfRFNNIHF1ZXJ5IHdvdWxkIGZhaWxlZCBmb3IgaXdsd2lmaSBkZXZpY2UKPj4g
YW5kIGV2ZXJ5dGltZSB3aGVuIG5ldHdvcmsgaXMgcmVhY3RpYXZlZCAoYm9vdCwKPj4gc3VzcGVu
ZC9yZXN1bWUsIG1hbnVhbGx5IHJlc3RhcnQgbmV0d29yaywgZXRjLiksCj4+IGJ1bmNoIG9mIGtl
cm5lbCB3YXJuaW5nIHNob3dzIHVwIHRvZ2V0aGVyOgo+PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBl
dmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAx
KQo+PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0
ZC1hNWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBldmFs
dWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+
PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1h
NWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0
ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiAg
IEFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIz
LTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiAgIEFDUEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBf
RFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFmNzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiAgIEFD
UEk6IFw6IGZhaWxlZCB0byBldmFsdWF0ZSBfRFNNIGJmMDIxMmYyLTc4OGYtYzY0ZC1hNWIzLTFm
NzM4ZTI4NWFkZSAoMHgxMDAxKQo+PiBzaW5jZSBpd2x3aWZpIHdvdWxkIG1ha2UgOCBhY3BpL2Rz
bSBxdWVyaWVzIGZvciBsYXJpIGNvbmZpZy4KPj4gQnV0IGZvciBpd2x3aWZpLCBpdCBpcyBzYWZl
IHRvIGNhY2hlIHRoZSBfRFNNIGVycm9ycywKPj4gc2luY2UgaXQgaXMgbm90IHBvc3NpYmxlIHRv
IGNvcnJlY3QgaXQgd2l0aG91dCB1cGdyYWRpbmcgQklPUy4KPj4gV2l0aCB0aGlzIHBhdGNoLCB0
aG9zZSBrZXJuZWwgd2FybmluZ3Mgd291bGQgb25seSBzaG93IHVwIG9uY2Ugd2hlbgo+PiBib290
aW5nIHRoZSBzeXN0ZW0gYW5kIHVubmVjZXNzYXJ5IGFjcGkvZHNtIHF1ZXJpZXMgYXJlIGF2b2lk
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPgo+PiAt
LS0KPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5jIHwgNyAr
KysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FjcGkuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5jCj4+IGluZGV4IDc5Nzc0Yzhj
N2ZmNC4uM2Y5OGY1MjJkYWFjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L2FjcGkuYwo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2Z3L2FjcGkuYwo+PiBAQCAtMzAsNiArMzAsOCBAQCBzdGF0aWMgY29uc3Qgc2l6
ZV90IGFjcGlfZHNtX3NpemVbRFNNX0ZVTkNfTlVNX0ZVTkNTXSA9IHsKPj4gIAlbRFNNX0ZVTkNf
RU5BQkxFXzExQkVdID0JCXNpemVvZih1MzIpLAo+PiAgfTsKPj4gIAo+PiArc3RhdGljIGludCBh
Y3BpX2RzbV9mdW5jX3JldGNvZGVbRFNNX0ZVTkNfTlVNX0ZVTkNTXSA9IHswfTsKPj4gKwo+PiAg
c3RhdGljIGludCBpd2xfYWNwaV9nZXRfaGFuZGxlKHN0cnVjdCBkZXZpY2UgKmRldiwgYWNwaV9z
dHJpbmcgbWV0aG9kLAo+PiAgCQkJICAgICAgIGFjcGlfaGFuZGxlICpyZXRfaGFuZGxlKQo+PiAg
ewo+PiBAQCAtMTY5LDYgKzE3MSwxMCBAQCBpbnQgaXdsX2FjcGlfZ2V0X2RzbShzdHJ1Y3QgaXds
X2Z3X3J1bnRpbWUgKmZ3cnQsCj4+ICAJaWYgKFdBUk5fT04oZnVuYyA+PSBBUlJBWV9TSVpFKGFj
cGlfZHNtX3NpemUpKSkKPj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4+ICAKPj4gKwkvKiBJZiBIVyBy
ZXR1cm4gYW4gZXJyb3Igb25jZSwgZG8gbm90IGJvdGhlciB0cnkgYWdhaW4uICovCj4+ICsJaWYg
KGFjcGlfZHNtX2Z1bmNfcmV0Y29kZVtmdW5jXSkKPj4gKwkJcmV0dXJuIGFjcGlfZHNtX2Z1bmNf
cmV0Y29kZVtmdW5jXTsKPgo+U3RhdGljIHZhcmlhYmxlcyBhcmUgdXN1YWxseSBhdm9pZGVkIGJl
Y2F1c2UgdGhleSBhcmUgcHJvYmxlbWF0aWMgaWYKPnRoZXJlIGFyZSBtdWx0aXBsZSBpd2x3aWZp
IGRldmljZXMgb24gdGhlIHNhbWUgaG9zdC4gU2hvdWxkIHRoZSBlcnJvcgo+bWVzc2FnZSBiZSBq
dXN0IHJlbW92ZWQgZW50aXJlbHk/CgpUaGFua3MgZm9yIHRoZSByZXZpZXd+ClllcCwgIHlvdSdy
ZSBxdWl0ZSByaWdodCEgSSBkaWQgbm90IGNvbnNpZGVyIG11bHRpcGxlIGl3bHdpZmkgZGV2aWNl
cy4KClRoZSByZXBlYXRlZCBlcnJvciBtZXNzYWdlcyByZWFsbHkgYm90aGVyICBtZSwgIGJ1dCB0
aGV5IGFyZSBmcm9tIGFjcGkgZHJpdmVyLCBJIGRvbid0IHRoaW5rIGl0IGNhbiBiZSByZW1vdmVk
ICBlbnRpcmVseS4uLi4KCldvdWxkIG1vdmluZyB0aGUgY2FjaGUgaW50byBkZXZpY2Ugc3RydWN0
dXJlIGFjY2VwdGFibGU/CgoKVGhhbmtzCkRhdmlkIAoKPgo+LS0gCj5odHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8KPgo+aHR0cHM6Ly93aXJl
bGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRp
bmdwYXRjaGVzCg==

