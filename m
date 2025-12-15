Return-Path: <linux-wireless+bounces-29741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6193CBC75D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 05:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6AA30041BF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 04:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6828151C;
	Mon, 15 Dec 2025 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQ4Vjxxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA219258E;
	Mon, 15 Dec 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765772536; cv=none; b=Ox6d4epUs2uKj0vjP5Ue6U9wFAZj0ARuNmrQMpOPMBflJjKxyRDs3FTG6gExxwJ7ulwJc+yzNkTerJPIt/6t/PyLfIUg+rGsIIwgg9vzRbknPXkWQfGq8BFEDU80yXCd8jNsgzqUtPHb8TkSktTDtEKEUegMhTSFsUOcEB5k1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765772536; c=relaxed/simple;
	bh=sHbrYLaauTmnUdbRMtVJCVmpyp6JPetQFcchtY6iAqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Y948SM4yRh+L1VLzuoK8Lq8EWEcvDPVP0klOW/prvFoLkSYRZdhGLFX0dZaprYa2FcTZLfdr/+5WDTeaC5omydX/WFEQ7iCllnTtrBhjXbfCpJ0WwIUokQoT4RqvtMCkYAe6qB8kM5P9pyYYMBX78deak8tUDebeDHtSApl327U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQ4Vjxxb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sHbrYLaauTmnUdbRMtVJCVmpyp6JPetQFcchtY6iAqk=; b=j
	Q4VjxxbYHqkOOwZokaoy3FyIu4b5sMqSulkVzlIt3isVSYYzDaigGPLMHNbtsggc
	uFefduM+yjJDZF01Uwg9mTCfwOQzk8Dn5LFKULaOY00Jd9BDUDzUGuEEcy9h+ArV
	5X0KMKg31EVrCY6Ne/Y2+cuu8Nwembhr96UFTi8j6c=
Received: from 00107082$163.com ( [111.35.191.189] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Mon, 15 Dec 2025 12:20:43 +0800
 (CST)
Date: Mon, 15 Dec 2025 12:20:43 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Yao Zi" <me@ziyao.cc>
Cc: thostet@google.com, daniel.gabay@intel.com, jeffbai@aosc.io,
	johannes.berg@intel.com, kexybiscuit@aosc.io,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com, nathan@kernel.org,
	netdev@vger.kernel.org, pagadala.yesu.anjaneyulu@intel.com,
	richardcochran@gmail.com, "Kuniyuki Iwashima" <kuniyu@google.com>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as
 stub for MVM/MLD PTP
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aT-DmZTh_8I13Mg1@pie>
References: <20251204123204.9316-1-ziyao@disroot.org>
 <20251214101257.4190-1-00107082@163.com> <aT-DmZTh_8I13Mg1@pie>
X-NTES-SC: AL_Qu2dB/ucvUwv5SWRYekZnEYQheY4XMKyuPkg1YJXOp80hyXO2yctVkVHJHDd3uONAQGLkwivTghyxMl2dKpBW6DrUAhNHAp/QMhlHx/TMkJv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1218241a.4a90.19b203d3fd8.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgDnf4ScjD9prok5AA--.1283W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbCxhx0H2k-jJySPAAA3Z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTItMTUgMTE6NDI6MTcsICJZYW8gWmkiIDxtZUB6aXlhby5jYz4gd3JvdGU6Cj5P
biBTdW4sIERlYyAxNCwgMjAyNSBhdCAwNjoxMjo1N1BNICswODAwLCBEYXZpZCBXYW5nIHdyb3Rl
Ogo+PiBPbiBUaHUsIERlYyAwNCwgMjAyNSBhdCAxMjozMjowNFBNICswMDAwLCBZYW8gWmkgd3Jv
dGU6Cj4+ID4gU2luY2UgY29tbWl0IGRmYjA3M2QzMmNhYyAoInB0cDogUmV0dXJuIC1FSU5WQUwg
b24gcHRwX2Nsb2NrX3JlZ2lzdGVyIGlmCj4+ID4gcmVxdWlyZWQgb3BzIGFyZSBOVUxMIiksIFBU
UCBjbG9jayByZWdpc3RlcmVkIHRocm91Z2ggcHRwX2Nsb2NrX3JlZ2lzdGVyCj4+ID4gaXMgcmVx
dWlyZWQgdG8gaGF2ZSBwdHBfY2xvY2tfaW5mby5zZXR0aW1lNjQgc2V0LCBob3dldmVyLCBuZWl0
aGVyIE1WTQo+PiA+IG5vciBNTEQncyBQVFAgY2xvY2sgaW1wbGVtZW50YXRpb24gc2V0cyBpdCwg
cmVzdWx0aW5nIGluIHdhcm5pbmdzIHdoZW4KPj4gPiB0aGUgaW50ZXJmYWNlIHN0YXJ0cyB1cCwg
bGlrZQo+PiA+IAo+PiA+IFdBUk5JTkc6IGRyaXZlcnMvcHRwL3B0cF9jbG9jay5jOjMyNSBhdCBw
dHBfY2xvY2tfcmVnaXN0ZXIrMHgyYzgvMHg2YjgsIENQVSMxOiB3cGFfc3VwcGxpY2FudC80NjkK
Pj4gPiBDUFU6IDEgVUlEOiAwIFBJRDogNDY5IENvbW06IHdwYV9zdXBwbGljYW50IE5vdCB0YWlu
dGVkIDYuMTguMCsgIzEwMSBQUkVFTVBUKGZ1bGwpCj4+ID4gcmE6IGZmZmY4MDAwMDI3MzJjZDQg
aXdsX212bV9wdHBfaW5pdCsweDExNC8weDE4OCBbaXdsbXZtXQo+PiA+IEVSQTogOTAwMDAwMDAw
MmZkYzQ2OCBwdHBfY2xvY2tfcmVnaXN0ZXIrMHgyYzgvMHg2YjgKPj4gPiBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogRmFpbGVkIHRvIHJlZ2lzdGVyIFBIQyBjbG9jayAoLTIyKQo+PiA+IAo+PiA+IEkg
ZG9uJ3QgZmluZCBhbiBhcHByb3ByaWF0ZSBmaXJtd2FyZSBpbnRlcmZhY2UgdG8gaW1wbGVtZW50
IHNldHRpbWU2NCgpCj4+ID4gZm9yIGl3bHdpZmkgTUxEL01WTSwgdGh1cyBpbnN0ZWFkIGNyZWF0
ZSBhIHN0dWIgdGhhdCByZXR1cm5zCj4+ID4gLUVPUFROT1RTVVBQIG9ubHksIHN1cHByZXNzaW5n
IHRoZSB3YXJuaW5nIGFuZCBhbGxvd2luZyB0aGUgUFRQIGNsb2NrIHRvCj4+ID4gYmUgcmVnaXN0
ZXJlZC4KPj4gCj4+IFRoaXMgc2VlbXMgZGlzdHVyYmluZy4uLi5JZiBhIG51bGwgc2V0dGltZTY0
IGRlc2VydmUgYSBrZXJuZWwgV0FSTiBkdW1wLCBzbyBzaG91bGQKPj4gYSBzZXR0aW1lNjQgd2hp
Y2ggcmV0dXJucyBlcnJvci4KPgo+VGhleSdyZSBzZXBhcmF0ZSB0aGluZ3MuIEEgcHRwIGNsb2Nr
IGltcGxlbWVudGluZyBub3QgcHJvdmluZGluZwo+c2V0dGltZTY0KCkgb3IgZ2V0dGltZTY0KCkv
Z2V0dGltZXg2NCgpIGNhbGxiYWNrIHdpbGwgY3Jhc2ggd2hlbgo+dXNlcnNwYWNlIHRyaWVzIHRv
IGNhbGwgY2xvY2tfZ2V0dGltZSgpL2Nsb2NrX3NldHRpbWUoKSBvbiBpdCwgc2luY2UKPmVpdGhl
ciBwdHBfY2xvY2tfc2V0dGltZSgpIG9yIHB0cF9jbG9ja19nZXR0aW1lKCkgaW52b2tlcyB0aGVz
ZQo+Y2FsbGJhY2tzIHVuY29uZGl0aW9uYWxseS4KPgo+SG93ZXZlciwgZmFpbGluZyB3aXRoIC1F
Tk9UU1VQUC8tRU9QTk9UU1VQUCB3aGVuIGNsb2NrX3NldHRpbWUoKSBpc24ndAo+c3VwcG9ydGVk
IGJ5IGEgZHluYW1pYyBQT1NJWCBjbG9jayBkZXZpY2UgaXMgYSBkb2N1bWVudGVkIGJlaGF2aW9y
LCBzZWUKPm1hbi1wYWdlIGNsb2NrX2dldHJlcygyKS4KPgo+PiBCZWZvcmUgZml4aW5nIHRoZSB3
YXJuaW5nLCB0aGUgZXhwZWN0ZWQgYmVoYXZpb3Igb2Ygc2V0dGltZTY0IHNob3VsZCBiZSBzcGVj
aWZpZWQgY2xlYXJseSwKPgo+SSB0aGluayBmYWlsaW5nIHdpdGggLUVPUE5PVFNVUFAgKHdoaWNo
IGlzIHRoZSBzYW1lIGFzIC1FTk9UU1VQUCBvbgo+TGludXgpIHdoZW4gdGhlIG9wZXJhdGlvbiBp
c24ndCBzdXBwb3J0ZWQgaXMgd2VsbC1kb2N1bWVudGVkLCBhbmQgaXMKPnN1aXRhYmxlIGZvciB0
aGlzIGNhc2UuCj4KPk9uZSBtYXkgYXJndWUgdGhhdCBpdCdkIGJlIGhlbHBmdWwgZm9yIHB0cF9j
bG9ja19yZWdpc3RlcigpIHRvIHByb3ZpZGUKPmEgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBvZiBz
ZXR0aW1lNjQoKSB0aGF0IGFsd2F5cyBmYWlscyB3aXRoCj4tRU9QTk9UU1VQUCB3aGVuIHRoZSBk
cml2ZXIgZG9lc24ndCBwcm92aWRlIG9uZS4KPgo+SG93ZXZlciwgaXQncyBsaWtlbHkgYSBwcm9n
cmFtbWluZyBidWcgd2hlbiBnZXR0aW1lNjQoKS9zZXR0aW1lNjQoKSBpcwo+bWlzc2luZywgc28g
dGhlIGN1cnJlbnQgYmVoYXZpb3Igb2Ygd2FybmluZyBzb3VuZHMgcmVhc29uYWJsZSB0byBtZS4K
Pgo+PiBoZW5jZSB3aHkgdGhlIGRmYjA3M2QzMmNhYyAoInB0cDogUmV0dXJuIC1FSU5WQUwgb24g
cHRwX2Nsb2NrX3JlZ2lzdGVyIGlmIHJlcXVpcmVkIG9wcyBhcmUgTlVMTCIpPwo+Cj5Zb3UgbWF5
IGJlIGludGVyZXN0ZWQgaW4gdGhlIG9yaWdpbmFsIHNlcmllc1sxXSB3aGVyZSB0aGUgaWRlYSBv
Zgo+d2FybmluZyBmb3IgbWlzc2luZyBzZXR0aW1lNjQvZ2V0dGltZTY0L2dldHRpbWV4NjQgY2Fs
bGJhY2tzIGNhbWUgdXAuCgpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbiwgdGhpcyBsaW5rIGhv
bGRzIHdheSBtb3JlIHJlbGV2YW50IGluZm9ybWF0aW9uIHRoYW4gdGhlICpMaW5rKiB0YWcgaW4g
ZGZiMDczZDMyY2FjLiAgOikKCkJ1dCBpc24ndCAgdGhlIHBhdGNoIGluIFsxXSAgYW5kIHNpbWls
YXIgY2hhbmdlIHRvIHNldHRpbWU2NCBiZXR0ZXI/IApXaGF0IGlzIHRoZSAgZGlmZmVyZW5jZSBi
ZXR3ZWVuIGEgbnVsbCBjYWxsYmFjayBhbmQgYSBjYWxsYmFjayByZXR1cm5pbmcgZXJyb3I/IGFy
ZW4ndCB0aGV5IHNheWluZyB0aGUgc2FtZQp0aGluZzogInRoaXMgZGV2aWNlIGRvZXMgbm90IHN1
cHBvcnQgaXQiPwoKCgpEYXZpZAoKPgo+QWxzbyBjYyBLdW5peXVraSwgaW4gY2FzZSB0aGF0IEkg
bWlzc2VkIHNvbWV0aGluZyBvciBnb3QgaXQgd3JvbmcuCj4KPj4gCj4+IERhdmlkCj4KPkJlc3Qg
cmVnYXJkcywKPllhbyBaaQo+Cj4+ID4gCj4+ID4gUmVwb3J0ZWQtYnk6IE5hdGhhbiBDaGFuY2Vs
bG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4KPj4gPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI1MTEwODA0NDgyMi5HQTMyNjI5MzZAYXgxNjIvCj4+ID4gU2lnbmVkLW9mZi1i
eTogWWFvIFppIDx6aXlhb0BkaXNyb290Lm9yZz4KPj4gPiAtLS0KPj4gCj4KPlsxXTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMDI4MDk1MTQzLjM5NjM4NS0xLWp1bmppZS5jYW9A
aW50ZWwuY29tLwo=

