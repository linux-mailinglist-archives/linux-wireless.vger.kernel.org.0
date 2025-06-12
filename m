Return-Path: <linux-wireless+bounces-24072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF53AD709B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119377A921B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5417BED0;
	Thu, 12 Jun 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JZcMz+ge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A98BEE
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731943; cv=none; b=bIL5zBC3LJD9WkB+dvqL1JN61F8/BMd+yjHCDRGuErZ8/ydYI0JKcMmoblYY/brClIzQR4v4+E0GQPI/3dzrIinifGuVCZ9KXkc9GKW91ARyR5q/4jHDcY8YJCzheMy+P3iDYyyRIit1P1hyUh/kTrb+UzP+Y+EgwJfsPaZj53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731943; c=relaxed/simple;
	bh=hPthV2m6xwqO/ek/Ye0/fI+s6Y3mepYQgUiCinLhfjo=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XKUPq4AxGg93+YR94ohV2wu9EkM7nh3q07JBEC53dCYVcsUS5Vv8fTNnoCYzhizxTkijuaCR22idce5RF8B/uVX5bPDuRZLXnCDuqxaEx50cVjm1DyEUcz86AgkQ5VzWdLS9wAa3TidnUjHCxbiqo/jcaWAWYGLO3KO2CRPt0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JZcMz+ge reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=11NYePxDlX9GCUuOoutyor13ZOTsszDCKV174D9W/JE=; b=J
	ZcMz+ge2xSoDP0BpwiB2pBlqHDoSMcpj3WAatznTjj78OTtU4Fzxk0IrGE9PI8vi
	4QumbX+Kjf0PDXsnZa1iszHRqH5xBUR4Pt16T7MsEuUyMaR+gJeuDWu08PNhH2lx
	1UJDIZl2MnUuNAFGuY4ngBK1Mxaa9LJSlPSd4RNCC0=
Received: from lonthn$163.com ( [2409:8a1e:9891:4ec0:ec2e:b1d1:6cfd:bc7] )
 by ajax-webmail-wmsvr-40-121 (Coremail) ; Thu, 12 Jun 2025 20:38:52 +0800
 (CST)
Date: Thu, 12 Jun 2025 20:38:52 +0800 (CST)
From: lonthn  <lonthn@163.com>
To: linux-wireless@vger.kernel.org
Subject: Re: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu
 host/OpenWrt guest)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <684A83E1.25166C.00001@m16.mail.163.com>
References: <684A83E1.25166C.00001@m16.mail.163.com>
X-NTES-SC: AL_Qu2fC/uYvkEo5CWfY+kfmUsUhO85UMawuP0g3I9VO5l4jArp0ScZTWVSPnrr/8a0KQOgmgmGXCVt7eldbJhgdYEWa8er71RvySdDkdM45iAN1g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <757a4801.a04e.197642679a4.Coremail.lonthn@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgDXf7RdykpoYlcaAA--.43880W
X-CM-SenderInfo: horq3xrq6rljoofrz/1tbiXQlqB2hKgWE8YAADsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI1LTA2LTEyIDE1OjM4OjA5LCBsb250aG5AMTYzLmNvbSB3
cm90ZToKPlRoYW5rcyBmb3IgeW91ciBxdWljayByZXNwb25zZS4KPgo+PiBUaGlzIGxvb2tzIGxp
a2UgaW50ZXJvcGVyYWJpbGl0eSBwcm9ibGVtIG9mIDM2LWJpdCBETUEuCj4+IElmIHlvdSBoYXZl
IGJlbG93IGNvbW1pdCBpbiB5b3VyIGd1ZXN0IE9TOgo+PiAxZmQ0YjNmZTUyZWYgKCJ3aWZpOiBy
dHc4OTogcGNpOiBzdXBwb3J0IDM2LWJpdCBQQ0kgRE1BIGFkZHJlc3MiKQo+PiAKPj4gUGxlYXNl
IGFsc28gaGF2ZSBiZWxvdyBjb21taXQgdG8gcm9sbGJhY2sgMzItYml0IERNQS4KPj4gYWE3MGZm
MDk0NWZlICgid2lmaTogcnR3ODk6IHBjaTogZWFybHkgY2hpcHMgb25seSBlbmFibGUgMzYtYml0
IERNQSBvbiBzcGVjaWZpYyBQQ0kgaG9zdHMiKQo+PiAKPj4gV2l0aCB0aGUgbGF0ZXN0IGtlcm5l
bCwgeW91IGNhbiBqdXN0IGNvbW1lbnQgY29kZSBhcyBiZWxvdyB0byB1c2UgMzItYml0IERNQS4K
Pgo+SSB0cmllZCBpdCBhbmQgZm91bmQgdGhhdCBpdCBzdGlsbCBkb2Vzbid0IHdvcmsKPgo+PiBJ
IGhhdmUgbm90IGV2ZXIgdHJpZWQgcGFzc3Rocm91Z2gsIHNvIEknbSBub3Qgc3VyZSBpZiBpdCBj
YW4gd29yay4KPj4gQ2FuIEkga25vdyBob3cgZGlmZmVyZW50IHRoZSBwYXNzdGhyb3VnaCBpcz8K
Pgo+WW91IGNhbiByZWZlciB0byB0aGlzOiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9kcml2ZXIt
YXBpL3ZmaW8uaHRtbAo+Cj4+IERvZXMgcnRsODg1MmJlIHdvcmsgb24gaG9zdCBPUz8KPgo+SSdt
IHRyeWluZywgYnV0IHdoZW4gSSBsb2FkIHRoZSA4ODUyYmUgZHJpdmVyLCBzdHJhbmdlbHksIEkg
Z2V0IG5vdGhpbmcuIAo+JD4gZG1lc2cgfGdyZXAgODg1MmJlCj5ubyBtZXNzYWdlIQo+JD4gbHNt
b2QgfGdyZXAgcnR3Cj5ydHdfODg1MmJlICAgICAgICAgICAgIDE2Mzg0ICAwCj5ydHdfODg1MmIg
ICAgICAgICAgICAgMzUyMjU2ICAxIHJ0d184ODUyYmUKPnJ0dzg5cGNpICAgICAgICAgICAgICAg
NjE0NDAgIDEgcnR3Xzg4NTJiZQo+cnR3ODljb3JlICAgICAgICAgICAgIDU2OTM0NCAgMiBydHc4
OXBjaSxydHdfODg1MmIKPkl0IGxvb2tzIGxpa2UgbXkgZGV2aWNlIGlzIG5vdCBkZXRlY3RlZAoK
SSd2ZSBjb25maXJtZWQgdGhhdCB0aGUgaG9zdCBzeXN0ZW0gaXMgd29ya2luZwo=

