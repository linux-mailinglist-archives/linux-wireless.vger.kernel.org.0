Return-Path: <linux-wireless+bounces-31490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPRLGFiBgWk6GwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:02:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4512D4876
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 06:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 681CF3030ED0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 05:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315C286A7;
	Tue,  3 Feb 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/K661Lz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28903EBF15
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094932; cv=none; b=GFhyM+9HwedmqYdzuKFO/lM5gQJcf53XPYujvVMjqDdQfGhN3fyFBsTQMLVOkiDPcdCbU29abt38UtTdLg9M+VcO5cVIO132CydWSSndblQneqgX1+Fd5e5hjcui4/yrzS2Gl8h2ozE62uMrOpZiTjNyy46e4WHt5bB1xupOcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094932; c=relaxed/simple;
	bh=oUZNxn0AkBvCSElifaEzxbofihH10AvUXckx7NBTcy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRROr1yJqFLVbdusHwH8IsvM0cKRHGoUbGEnHu1ZPtqy600KYcRecuTVkBW1rNEniGJmrISaAygzisKq5/t6h6cYMSGVFKx8bHDexuCLEN/w8zjze7sV4LHZGdEOx7d67lOtQUC2S1AdbHA1TlaOc923KGxcgfA/tUVVaJyXpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/K661Lz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-823081bb15fso2743569b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770094930; x=1770699730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxSEjdF3GcjRCJJjZuZzgfiWY7Eb+I3otWHzu60Ku0E=;
        b=E/K661LzWXpNEhTxtUDa2qy/zRbSDwVB1Jg0FQ657FXU7ddMjz3zJ0TPm0+Q4eV4az
         PAQnDIIVZviDiyBVS82cZeWQuhMmXs4Ba6j1js8wipXKOy0NcA0CAJWbfC/7/p1/se/S
         I9zFK4U34EmzbdRJcUARKptmlHHASdvH1G24BDGAUPS3/FLOXTK4gPAB7541vkApsgig
         3BDDomZg+I3MYcFnd463X4R87EWWmYxbxsqHe10+Sx4WIhG/oHbz0kVPWaiMh4iZ1Nph
         1uc/ClybKoqi6bTT3x6lhW99U28CsWMPT2Lv2wqwpUyY1+EfrmMVR63jfWkUXdFnqSQl
         a7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770094930; x=1770699730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxSEjdF3GcjRCJJjZuZzgfiWY7Eb+I3otWHzu60Ku0E=;
        b=p3a/R4GayBfnJ5R9We08Fns+Jj08MPSb2EfykGmp+2x4JRYD3FT/L2za32iR9kmmhj
         aQEwb9ZIQ2EW56m0zVnjKxmj9BrzJfGTbZlltYdIHABDSHyX85BH33rZIEr+lgtgAt3J
         jDUmf/lCbkIcIIS/pC4SJradHvOidVeieHdHXekNxoVgE9NtHzey/r0p32Er9+R9HEY5
         zJZ4AjZ/NP/oY2obLpZg33CUfuebO4eVoeq1ilM/pzNK0u7Wn/K85sVizIbur0hln8JJ
         bzW0JKsxvR0ODtDB6sheZJtLQkDbK2f5NsvyKSE6B34DpABBN2TCLJyhw9i4+Brjwe/R
         czWA==
X-Forwarded-Encrypted: i=1; AJvYcCXx88r1W6iRrl0p2ve8T6MkKDRdsVqETgPiA35mZK4KlBCqfgOR6+6jzDJeoNksgvEuIrxOXce44soNJh12Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQCnMZM24L9EqHI2elUGI9A8KCvi4KqCMNKss1df8Bx9Yhsnq
	WRZR6C/QdlozJVraZa7ugqUrszWEwuKtltNjxU053vaRZQ23imN3DeEJ
X-Gm-Gg: AZuq6aLDXVQ1XZeCWyxYUfxsDb1wYm7+04ZxYFeVuWivJDJ6gKbzh5NGS236mogyR0P
	4KAMLJsfkS9knjGs6zOMj6mCjJiOXgMZ02KNwGioWK7bUIJngOENCSMsr9L2pqfxJqwIcSNIUlr
	4D4hhyiKO5eKXEs4Eq8BSofTEx9tXBlOVbaDfjSQhUahcjTjjf199+w8K3B3Yl5a1dlLLWInR6/
	/bIvblBK/WOHs8pvx6/g91vPkXa17rsUv4wJbo6rI2ZVFbACW2d1rf7HBg04Suy/tnKpYqgf8jH
	UYVfmIKi8KVtEkVw8HkgFSWmMnIdhUNcQ+cIoE+UZlfdDYK3T8jH+XB5kG6ETbWMfQ+og/na2xz
	VYv5eINJKr+1780slvc8jEQGdGfhULf3u7/iiFfGOEKzR7yeqLlvs0Bkh+Lwa9Ik1lbJ446N+tj
	w2N44OHT/A34YTYvk6BwdoqigspBip68DJ50G7Q2QO29kfkVHR4VA0wpgrSYqJ
X-Received: by 2002:a05:6a00:21d3:b0:81e:a228:f0d8 with SMTP id d2e1a72fcca58-823aa6ee9a5mr14141035b3a.34.1770094930127;
        Mon, 02 Feb 2026 21:02:10 -0800 (PST)
Received: from ?IPV6:2402:e280:3d17:646:b60a:307f:3199:d66f? ([2402:e280:3d17:646:b60a:307f:3199:d66f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b65068sm19821711b3a.27.2026.02.02.21.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:02:09 -0800 (PST)
Message-ID: <399d4ea0-5f70-4678-b0d6-9a80c3399ceb@gmail.com>
Date: Tue, 3 Feb 2026 10:32:06 +0530
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
Content-Language: en-US
From: Jayasaikiran Banigallapati <bjsaikiran@gmail.com>
In-Reply-To: <125f0ecb-79a5-4806-aa93-aecaf937885e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31490-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C4512D4876
X-Rspamd-Action: no action


On 2/3/26 08:21, Baochen Qiang wrote:
>
> On 2/2/2026 11:17 PM, Saikiran wrote:
>> Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
>> system suspend/resume support but caused a critical regression where
>> CMA pages are corrupted during resume.
>>
>> 1. CMA page corruption:
>>     Calling mhi_unprepare_after_power_down() during suspend (via
>>     ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
>>     DMA buffers. When these pages are accessed during resume, the kernel
>>     detects corruption (Bad page state).
> How, FBC image and RDDM image get re-allocated at resume, no?
>
> To clarify, the BUG: Bad page state crash actually occurs during the 
> suspend phase, specifically when ath12k_mhi_stop() calls 
> mhi_unprepare_after_power_down().
>
> The stack trace shows the panic happens inside mhi_free_bhie_table() 
> while trying to free the pages:
>
>  mhi_free_bhie_table+0x50/0xa0 [mhi]
>  mhi_unprepare_after_power_down+0x30/0x70 [mhi]
>  ath12k_mhi_stop+0xf8/0x210 [ath12k]
>  ath12k_core_suspend_late+0x94/0xc0 [ath12k]
>
> The kernel reports nonzero _refcount when attempting to free the CMA 
> pages (fbc_image/rddm_image). This suggests that something is still 
> holding a reference to these pages when DEINIT attempts to free them, 
> causing the kernel to panic before we reach the resume stage.
>
> Since the pages cannot be safely freed during suspend, skipping DEINIT 
> (and using MHI_POWER_OFF_KEEP_DEV) avoids this invalid free operation. 
> This also aligns with the existing comment in ath12k_mhi_stop which 
> suggests using mhi_power_down_keep_dev() for suspend.
>
> Thanks & Regards,
> Saikiran

