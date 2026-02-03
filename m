Return-Path: <linux-wireless+bounces-31492-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJY9MpKNgWl/HAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31492-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:54:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509DD4D8E
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC10309C2A4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCEC36403F;
	Tue,  3 Feb 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dicK38ix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B636606E
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097915; cv=none; b=jQe6guBHzuWXwyAtXCbU+Dg5RUvbeAyOVIprEWQ/3EJB2RRRYrkx+f25SC4Yi6C/IhEOqvntOqEIVxf9hc/OevEN+jamY7PEyDz9IPKjMDLZTxgA8ci9yLskKyoOyE/JVTvUZ610+wbvDRtmFg1ZdxUueZ2K9Lq5ah3MfSYPNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097915; c=relaxed/simple;
	bh=UZx9xcftwYSJJ1oz/jgODJhfzba/tZ3zgrjwQBjI/Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzO3EMm2/YcwA9bNoDVgqFbyFlgdvknvIM2DAwr269cj1+CkTFCJSa8l88QeBO1war4cDTdGCG3gkNFDaxY6GCOt3QxVVOrJzHfsHLWnzOq4gz2CKY5D//srUSfZAn2nKbPGsGs0nrY6Whb4tWHJzP4EO2vXvPedFMELF8iNLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dicK38ix; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a9296b3926so1126365ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770097913; x=1770702713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dl8cFanWWi/ieSsGUqpoQ78qPinKwYMKkeP8w58AS80=;
        b=dicK38ixI5XFxGIuC8QM8OlkyK9275l6bPIOuGDdanEM7Yea1yIW7GDY3QyCrzCP2O
         TCi/FSdpFgXeoHro5GpSZcGvaodvTrGFp2C8Z72j907sFVvb1A9/hmhe9z2K/B2fu1jt
         BxqykvVJ3XpKxmOBhO1LvE2/dtKkIMENNgUJBD1iWilHpmM83bUG53AZOIaW6uwNqvsB
         ek9/+SQMiku15Q1tae1URiQ9McLQLy5DVkGZ2xOFAf84o69UE1hXAdWgfeux2ZbNRZVH
         NJveizClufKK2cW9JNRXOaIcGQmsWlkLszj2GCU3C8mvH2G0JNKhrR+IXYG0rtUInSVj
         0fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770097913; x=1770702713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl8cFanWWi/ieSsGUqpoQ78qPinKwYMKkeP8w58AS80=;
        b=c8jNnqJGxmFAhodCeqeI/kD1qRUri7Sy9PuvQopYZc0FS/cwDxG+eBi6gxqk9ceQQJ
         GDHcnPrwiv1b8f+0n3H68ayDvGEWvpRAJEe/kJyu8/Q/XjyFsUHtSNW2m9g+V2wdbCbb
         7mzVXM7EKpZPPo4yGvxJ+Xl9txOKaaKTcdDc7c5i0/QRfIy7NKUOi7JASXHjLdEYhZqh
         wLpWG9X48+Tk/Wz9/hrWslhIwjBX2VdvajMdfLJ+bvJBpuK67rMuVE5XOhV7dGSzTh32
         US0IzJyFjoVzGU6GGwzrY3tWLf+dJYnJe3ypjYJSbnAFZWJ+8hOam8adXRd7c3CiHpjW
         EH2g==
X-Forwarded-Encrypted: i=1; AJvYcCVfKPxaWmMMftVHSSzvD0YCwx7mS4jnM0+RByXSU3kpXINMbBb39Fm8v+lD4D9R1F278WFgu+Bj70F5wxyvXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjpNlhBYMv/Bi8zMFAICUjMTPUS28nFya5hr7XXJVL1ZX8SWhu
	kc3keGF085Z/AXLxqBlqyxOF8hG0/n7BNSilF4O5TyG3nr0A1MIPKbek
X-Gm-Gg: AZuq6aL2Z1dKEWWxIeuytXZh33PnIfzB/xTkQ40+r3WHclp+tuePpSuhcSgtQBx6TJt
	ol5Wsezpp3BdnZCxQQi9zf5VHo2qSe31FS23aWbOXeRcduFDm4049gvWjKU4NYWrCeojj5KTbXL
	JIU3N/rKJObA6EciKrGvvi5xNPVr8xvMLYdF1Em/5oPzVQIP533JZda1PcS1e2FJdbFN/j3wsBq
	4S349D0+/A8oFMjyPx/1F7XzG0lPxH4l22306bxsZwKZKRSAis0cQ93pl07GBOtaYjp+OQUgpk/
	Vi+yGEqZaqGoMxIIVG6U3n9NGtFDklkPn0XDjMriJ6wlMcSQn6uJ3Kqq8z58s8UpFydgC9i7JGz
	SkDA1XHcKQ0wnok3FzJRWrisL/kbP6hFYMQSyeFfjY6B20MwC4ebUbaW0lwBmPsVmrsOmzleZLQ
	aVMSvy8BCx/mXJsNqsaJbTEEX4JL7AgKxmkYk5lKbymao7IWeFalDmaqEhJ2yQ
X-Received: by 2002:a17:903:41d2:b0:2a0:ccef:a5d3 with SMTP id d9443c01a7336-2a8d7eb531amr148064685ad.3.1770097913351;
        Mon, 02 Feb 2026 21:51:53 -0800 (PST)
Received: from ?IPV6:2402:e280:3d17:646:6c0c:5f7b:2f06:7cb1? ([2402:e280:3d17:646:6c0c:5f7b:2f06:7cb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3db4sm170016365ad.50.2026.02.02.21.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:51:53 -0800 (PST)
Message-ID: <aa252da5-a9fc-4c86-ae78-1de1f7c34bb2@gmail.com>
Date: Tue, 3 Feb 2026 11:21:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] wifi: ath12k: fix CMA error and MHI state mismatch during
 resume
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org,
 kvalo@kernel.org
Cc: quic_bqiang@quicinc.com, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260202151720.49904-1-bjsaikiran@gmail.com>
 <125f0ecb-79a5-4806-aa93-aecaf937885e@oss.qualcomm.com>
 <399d4ea0-5f70-4678-b0d6-9a80c3399ceb@gmail.com>
 <eda602b5-6d6c-4ef1-b07a-53af4b226549@oss.qualcomm.com>
Content-Language: en-US
From: Jayasaikiran Banigallapati <bjsaikiran@gmail.com>
In-Reply-To: <eda602b5-6d6c-4ef1-b07a-53af4b226549@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-31492-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4509DD4D8E
X-Rspamd-Action: no action


On 2/3/26 11:00, Baochen Qiang wrote:
>
> On 2/3/2026 1:02 PM, Jayasaikiran Banigallapati wrote:
>> On 2/3/26 08:21, Baochen Qiang wrote:
>>> On 2/2/2026 11:17 PM, Saikiran wrote:
>>>> Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
>>>> system suspend/resume support but caused a critical regression where
>>>> CMA pages are corrupted during resume.
>>>>
>>>> 1. CMA page corruption:
>>>>      Calling mhi_unprepare_after_power_down() during suspend (via
>>>>      ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
>>>>      DMA buffers. When these pages are accessed during resume, the kernel
>>>>      detects corruption (Bad page state).
>>> How, FBC image and RDDM image get re-allocated at resume, no?
>>>
>>> To clarify, the BUG: Bad page state crash actually occurs during the suspend phase,
>>> specifically when ath12k_mhi_stop() calls mhi_unprepare_after_power_down().
>>>
>>> The stack trace shows the panic happens inside mhi_free_bhie_table() while trying to
>>> free the pages:
>>>
>>>   mhi_free_bhie_table+0x50/0xa0 [mhi]
>>>   mhi_unprepare_after_power_down+0x30/0x70 [mhi]
>>>   ath12k_mhi_stop+0xf8/0x210 [ath12k]
>>>   ath12k_core_suspend_late+0x94/0xc0 [ath12k]
>>>
>>> The kernel reports nonzero _refcount when attempting to free the CMA pages (fbc_image/
>>> rddm_image). This suggests that something is still holding a reference to these pages
>>> when DEINIT attempts to free them, causing the kernel to panic before we reach the
>>> resume stage.
> this seems like a bug either in MHI stack or in kernel DMA/MM subsystems, rather than in
> ath12k
>
>>> Since the pages cannot be safely freed during suspend, skipping DEINIT (and using
>>> MHI_POWER_OFF_KEEP_DEV) avoids this invalid free operation. This also aligns with the
>>> existing comment in ath12k_mhi_stop which suggests using mhi_power_down_keep_dev() for
>>> suspend.
> first of all, this is a workaround rather than fix. Ideally we should try to root cause
> the issue and fix it in the right way.


The original comment in existing code:


/* During suspend we need to use mhi_power_down_keep_dev()
  * workaround, otherwise ath12k_core_resume() will timeout
  * during resume.
  */

This patch aligns the code with this existing intent. The driver was 
previously

calling DEINIT (and freeing resources) despite the comment advising to 
use keep_dev.

If the intention of the driver authors was to use keep_dev for suspend,

then my understanding is DEINIT is incorrect here (Correct me if I am 
wrong)

regardless of the underlying MM behavior.

>
> Secondly the workaround here seems problematic: you skip INIT druing resume. However note
> several hardware registers need to be re-programmed during this stage, how could the
> target work if its power is cutoff during suspend and the register context is not restored
> during resume?


In my testing, WiFi functionality was fully restored after resume.

The device associates and passes traffic immediately.

My understanding is that:

ATH12K_MHI_INIT primarily handles host memory allocation (which we 
preserved by skipping DEINIT).

ATH12K_MHI_POWER_ON calls mhi_sync_power_up(). This function triggers 
the MHI state machine,

which handles the necessary BHI/BHIE programming and firmware download 
(SBL) sequence.

Since mhi_sync_power_up() is still called during resume, the target is 
correctly re-initialized and

registers are programmed, even if we skip the redundant host memory 
allocation step (INIT).

Thanks & Regards,
Saikiran


