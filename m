Return-Path: <linux-wireless+bounces-30836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7972D21BAB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3879D300A3FB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D92FC006;
	Wed, 14 Jan 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L3+H26Ba"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22726F2A0
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432595; cv=none; b=unYKJuB3v3pFgdyUF6wU/SVVWcBm1EWIUbxoqqojd5E10HRzMYzJSBpobLl2OmyNHPr7mLA6oRLGHfEHejZJnvKGPdx7/mhDBl1Qk7BYQC86Yi29PvwPUwmvLRuIvwJwefkMJvyjIRIAYgv/Ggfc+YKkOwHwWbMWbY938Q0v8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432595; c=relaxed/simple;
	bh=lL+eRe3ATart73Wr2RHXzJKq3uaRaLZiPZcHscRAc7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=M2fgcKK3W/Ixn9ZCoAjmjfSq0pLnKUaNPtT8SR93e0NlRBPmEzJeHOXz9Sz+VT0JYA8VVwP2FjfH6NtnrDBmYfCO5hvVpoQRJApGYkK9wESvEmujz+aZHXbQRR56NipecpZTXhHiYnBo99cOHHssck3LRQlY6nM7dH8lzN2/Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L3+H26Ba; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260114231630euoutp02228ae0b340cfbb64bce3548d23130819~KvBJarUEL1111011110euoutp02w
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 23:16:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260114231630euoutp02228ae0b340cfbb64bce3548d23130819~KvBJarUEL1111011110euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768432590;
	bh=jp1zL6vqiComiuZbdY62XP/xe/O5UGBTESSkK4unQds=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=L3+H26Bam8+NSHjr9khzESLVGmS0Nk0vlIZuqz+JvJBjF8P5fxFFTjQZPAKFBNrSr
	 p7J5UNKpBGd7cqXWq4SPhbtfPBWMHSteDg9hTmQ36Wf1CS2HD8x4ePm0TtevhcsWT7
	 NwvRqSF0/JG/LN71tdPzRiC3jYLIaDorrQZoL4yQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260114231629eucas1p2e5a6a703d0e1b3fb87c1b8225fb4e5ce~KvBITRi511370613706eucas1p2f;
	Wed, 14 Jan 2026 23:16:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260114231629eusmtip2a1670c5b1c80e00d589c0812e8d6a8a6~KvBH2pP6r2574325743eusmtip2K;
	Wed, 14 Jan 2026 23:16:28 +0000 (GMT)
Message-ID: <062fde49-7438-4001-a06e-50175547b54c@samsung.com>
Date: Thu, 15 Jan 2026 00:16:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] wifi: brcmfmac: Fix potential kernel oops when probe
 fails
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <74e3bb49-ebbe-4692-b278-c04f2a30bf96@broadcom.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260114231629eucas1p2e5a6a703d0e1b3fb87c1b8225fb4e5ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251231143556eucas1p141b278048039730d03edf85c6f3e5350
X-EPHeader: CA
X-CMS-RootMailID: 20251231143556eucas1p141b278048039730d03edf85c6f3e5350
References: <CGME20251231143556eucas1p141b278048039730d03edf85c6f3e5350@eucas1p1.samsung.com>
	<20251231143544.4158840-1-m.szyprowski@samsung.com>
	<74e3bb49-ebbe-4692-b278-c04f2a30bf96@broadcom.com>

On 14.01.2026 14:45, Arend van Spriel wrote:
> On 12/31/2025 3:35 PM, Marek Szyprowski wrote:
>> When probe of the sdio brcmfmac device fails for some reasons (i.e.
>> missing firmware), the sdiodev->bus is set to error instead of NULL, 
>> thus
>> the cleanup later in brcmf_sdio_remove() tries to free resources via
>> invalid bus pointer. Fix this.
>
> Hi Marek,
>
> Thanks for the fix. Please consider my suggestion below...
>
>> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable 
>> support")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> index 6a3f187320fc..6615748fa5bb 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> @@ -954,6 +954,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev 
>> *sdiodev)
>
> Maybe use a local variable bus and assign it only on success:
>
>>       bus = brcmf_sdio_probe(sdiodev);
>>       if (IS_ERR(bus)) {
>>           ret = PTR_ERR(bus);
>>           goto out;
>>       }
>> +    sdiodev->bus = bus;
>> brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
>
Well, that would look much better, but sdiodev->bus is also assigned 
inside brcmf_sdio_probe() and I didn't check if this is required by the 
functions called there or not. Maybe brcmf_sdio_probe() should simply 
return error code to make things easier to track?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


