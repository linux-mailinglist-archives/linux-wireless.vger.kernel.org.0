Return-Path: <linux-wireless+bounces-17246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1697A07992
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA46F188A808
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7082AD25;
	Thu,  9 Jan 2025 14:48:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B242AAF
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434084; cv=none; b=I348+0+VnP2YCt2FbE4p4NBiMOsggerFuWLLxXpqQ4vd3XEBSQ+a3Qh2YvrHNcz9Hd/1RFExDESOFre99qXB8fbzEGHnAH9R3dAlRPEfDzhrweKfEGrNMBi8fQE0ugq4TKwyjjwvk+7lL2DgCTpOFbM3jCOF3kN2EX55+/j5P1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434084; c=relaxed/simple;
	bh=ScVaYW3vHaRpkvsF/79jvWronX8NKsX9Ua8d9IHEGUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPF5EO0Vc1bsb6vSfLMXrHFrOPaYM0/FeklqrnQBICY8Sg84D64xL3xi3bLhllMKtcY4FHD8zO59ZZnO0zi8xneYiDlK3L+0EoQqEaQmdZX5eJwDDCjv5RFpcCfLW7/TSVtLa+rSQk8KVWIjZ14iPV1bK/vhzusDfQNcPEmIzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id B00F820967;
	Thu,  9 Jan 2025 15:42:36 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 981C820886;
	Thu,  9 Jan 2025 15:42:36 +0100 (CET)
Message-ID: <380c254f0b2f19fb185ec0e89f4c321802a0455f.camel@freebox.fr>
Subject: Re: [PATCH v3 1/2] wifi: cfg80211: define and use wiphy guard
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>
Date: Thu, 09 Jan 2025 15:42:36 +0100
In-Reply-To: <20241122094225.88765cbaab65.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
References: 
	<20241122094225.88765cbaab65.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CgpPbiBGcmksIDIwMjQtMTEtMjIgYXQgMDk6NDIgKzAxMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6
CgpIZWxsbyBKb2hhbm5lcywKCj4gQEAgLTEwMTEzLDM1ICsxMDA4MCwyOSBAQCBzdGF0aWMgaW50
IG5sODAyMTFfc3RhcnRfcmFkYXJfZGV0ZWN0aW9uKHN0cnVjdCBza19idWZmICpza2IsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoMKgwqDCoMKg
wqDCoMKgfQo+IMKgCj4gWy4uLi5dCj4gCj4gLXVubG9jazoKPiAtwqDCoMKgwqDCoMKgwqB3aXBo
eV91bmxvY2sod2lwaHkpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAoKVGhpcyBodW5rIGlzIGluY29ycmVjdCwg
YW55IGVycm9yIGZyb20gbGFzdCBjYWxsZWQgZnVuY3Rpb24KcmRldl9zdGFydF9yYWRhcl9kZXRl
Y3Rpb24oKSBpcyBubyBsb25nZXIgcHJvcGFnYXRlZC4KCgotLSAKTWF4aW1lCgoKCg==


