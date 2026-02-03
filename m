Return-Path: <linux-wireless+bounces-31500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILSIJfUAgmmYNgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 15:06:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139C4DA55C
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974FE300DE24
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51E3A4F4E;
	Tue,  3 Feb 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q5pW1+jc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805D3A1CEA
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127549; cv=none; b=tU87o6x5f0Qnh7PuZuTzJV6QbOwFRFIaCqb4Ybl6w6x8pAmGYaxfKcIF7e3G19hj725JBeQu1TzT4OTU2IlUGYI04gVmdSRiz973LLydV64+bRiHnNC6VxyjmZuhkfb6i3rF8JhwWIur9vgTSvBgkrJ2fGoQD7z0vywYgpabgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127549; c=relaxed/simple;
	bh=miKLVGeEPt9D6pIZwfzOF4DtHQY0S02fvhE65nbCzik=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=EDA4hRV68XnnHyTC2l94YVFXSm5siI0qrH0kzqZ8g8CLeLRVcbMPRXDIpBwCqmBrTSL8qcVtfipZFfemaAoDi5c/RtR9/sGgz/kE2qVWAtmtJMQsxdAQOY0Pn1mcO+3UnpFTel3mjsTM/GrZWsrySRtFFuhLLeMjlAF2VdpG1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q5pW1+jc; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260203140545euoutp014c75665259def7ab84f76388a02224c8~QwZ_-7Ny42688726887euoutp01P
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 14:05:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260203140545euoutp014c75665259def7ab84f76388a02224c8~QwZ_-7Ny42688726887euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770127545;
	bh=XtZKLgcAjIYbsVyOvUoQoIzqakWuMELBg1dZ5DJpY/8=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=q5pW1+jc+mIpbrJNRZymSc6QMWhO6XTzsrhDi0d+OvAStQebNEEaox99Mdx8MFgng
	 4rzeIH1ozkOwWeZG1xybyFagB2do/dXeuI/TDu+WVKim7fQ2GnMC8WTfCGLvpuBQwK
	 M8mvy54qvd2na8NGVrA0iVJ0uAEfFTAY0AvkwhtY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260203140545eucas1p2fd5f6e9d64af80f660b1c6d01afb5bf1~QwZ_tkcGn2647926479eucas1p2W;
	Tue,  3 Feb 2026 14:05:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260203140544eusmtip14d60553b692633c9ac276876dc61b5e7~QwZ_cOAcb1721117211eusmtip1-;
	Tue,  3 Feb 2026 14:05:44 +0000 (GMT)
Message-ID: <385988d9-9b83-4f20-97ae-d935b1141500@samsung.com>
Date: Tue, 3 Feb 2026 15:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential kernel oops when probe
 fails
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <b49e525c-6dfc-4cf4-9aae-b22485341c67@broadcom.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260203140545eucas1p2fd5f6e9d64af80f660b1c6d01afb5bf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59
X-EPHeader: CA
X-CMS-RootMailID: 20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59
References: <CGME20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59@eucas1p1.samsung.com>
	<20260203102133.1478331-1-m.szyprowski@samsung.com>
	<b49e525c-6dfc-4cf4-9aae-b22485341c67@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31500-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 139C4DA55C
X-Rspamd-Action: no action

On 03.02.2026 12:45, Arend van Spriel wrote:
> On 03/02/2026 11:21, Marek Szyprowski wrote:
>> When probe of the sdio brcmfmac device fails for some reasons (i.e.
>> missing firmware), the sdiodev->bus is set to error instead of NULL, 
>> thus
>> the cleanup later in brcmf_sdio_remove() tries to free resources via
>> invalid bus pointer. This happens because sdiodev->bus is set 2 times:
>> first in brcmf_sdio_probe() and second time in brcmf_sdiod_probe(). Fix
>> this by chaning the brcmf_sdio_probe() function to return the error code
>> and set sdio->bus only there.
>
> Looks much better, but wanted to see what was done in the commit 
> referenced in the Fixes: tag.
>
>> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable 
>> support")
>
That was the commit which introduced this regression, 
earlierbrcmf_sdio_probe() returned NULL in case of error and the check 
for sdio->bus was fine.

> So that patch wanted to propagate the result of 
> devm_clk_get_optional_enabled() call in brcmf_of_probe():of.c to retry 
> later. It ends up in brcmf_sdio_probe_attach() which is called in 
> brcmf_sdio_probe(). Anyway, it seems okay to me. Will give it a spin 
> in my setup just to be sure.
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


