Return-Path: <linux-wireless+bounces-15111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823759C0F04
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 20:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F931F23803
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A04217F5A;
	Thu,  7 Nov 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A6rTHcXo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2ED217F43
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008019; cv=none; b=iueVYLUr9dGMSVTFdbI968gd75MmP16zY7+Cm+44Cxb/5TUbKIg2XzyXR/N9lbQxbxRWva8P7yOjtnTaVEbB+UzoSJlkEhsuxrdpXr7Z97pBy60uzONApKXHMHfhtN9jXuo4e/AfhoaCudbYsduPxYa/ylwWYciRAesu2vBKRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008019; c=relaxed/simple;
	bh=aqelv5vWt5lbaTebo+lyhaH+0KHlWlYq05m4ngTCpqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BgOjI7D+mknjKtNfLGvrkfNLkLya26tS3P4RIQXdcYtjFN1uoOMNKHxKQ7UN3JAafebBUx+U7mYSNsqIfZkNCs2vupFzgshq5SnzbsN+FLbGPN+NcgUjWhL0oUOynMmEpcd7u//+r4OcGVLOdEWxj96h1vMH6m2JnizknjQwNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A6rTHcXo; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b157c9ad12so96807685a.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 11:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731008016; x=1731612816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QgWta8y8zlvuLspKqB8M5mTztc8dpQe+1jItWxtNgCI=;
        b=A6rTHcXo1Cgq0hgFvmG5tzKYxJkX4F97vfTnPb8WiW7y6lqo9OuzNy4rg9TQddIr7t
         zVP3jBeym5Y4LO/W14BCfBtqCU+5IrUNzLrfNVJ9g6mUATvrpsH7wAt++xUDc70c6BhW
         MCAVQAwHiU74tWuZNnlvplsJdBm9qa0cwGrLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731008016; x=1731612816;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgWta8y8zlvuLspKqB8M5mTztc8dpQe+1jItWxtNgCI=;
        b=OlkUmPC87Yo/YNowQhsBaJfv2pwjgTnu3vDd7VXxFGkMY7LfSFk7KAsfcx0Q0tHYxD
         N4P4/O7QKwTNr7lSGDcsFjwEXgBeCsfl6dPMTg9HKCm29caQJvl4bDzcTjWjr/fBTDwH
         9d4/ghCxeIyMeYZAOKAjdTkBKnSO0W+iFmtQdqcpEguhl387AQRd8g7NZe7/W49xTeyf
         1UnF13E2PJcsp6wJ79X49R3I264arlMT2xN6Fh1V1Qg58iD+XfXTXvz+ge38izcBzRjI
         ZplIPeiEBumBRjGIluD8+3dHsJaQG9l+pYExUAQ8GH8UqgH2BWYrqmgYoUYq59xS/BnU
         KCAA==
X-Forwarded-Encrypted: i=1; AJvYcCWe6c4ACzCnzCNIRgwZXOMNucnrkwYdssveFUtQSgudgzXzYLKBZfc7OD1ykbywXP3R5aNz4tP+ul4fjzQTfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmeENHP2DybTGfAn7kaQRZrOKK9EYEXKg2i3UPDRPwgudH0Nz
	rznOYhJZPRAX/x37rMEODlVpEX35GoPP0na7xWIR+ykUsTRu5DcBIvQ5kEVSbQ==
X-Google-Smtp-Source: AGHT+IGgd5RO4cFBGpf80jbbG0uUWs4IWnrAzHcdrMZ5hLDrv7MCNA28boIsqYv6kVeDU6C5t5rDMg==
X-Received: by 2002:a05:620a:191c:b0:7b1:453c:56b3 with SMTP id af79cd13be357-7b331f20c77mr40495185a.38.1731008016300;
        Thu, 07 Nov 2024 11:33:36 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2e180sm91961885a.23.2024.11.07.11.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:33:35 -0800 (PST)
Message-ID: <e922af14-8881-4019-8b6d-f36ae8e7e1f2@broadcom.com>
Date: Thu, 7 Nov 2024 20:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: N van Bolhuis <nvbolhuis@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
References: <20241107132903.13513-1-nvbolhuis@gmail.com>
 <87ed3n5dxu.fsf@kernel.org>
 <CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
 <7c03993b-be89-45a9-bcec-6649e01e054b@broadcom.com>
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <7c03993b-be89-45a9-bcec-6649e01e054b@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/2024 8:31 PM, Arend van Spriel wrote:
> On 11/7/2024 5:09 PM, N van Bolhuis wrote:
>> Op do 7 nov 2024 om 15:14 schreef Kalle Valo <kvalo@kernel.org>:
>>>
>>> nvbolhuis@gmail.com writes:
>>>
>>>> From: Norbert van Bolhuis <nvbolhuis@gmail.com>
>>>>
>>>> This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
>>>> when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of 
>>>> queued SKBs
>>>> are sent from the pkt queue.
>>>>
>>>> The problem is the number of entries in the pre-allocated sgtable, 
>>>> it is
>>>> nents = max(rxglom_size, txglom_size) + max(rxglom_size, 
>>>> txglom_size) >> 4 + 1.
>>>> Given the default [rt]xglom_size=32 it's actually 35 which is too 
>>>> small.
>>>> Worst case, the pkt queue can end up with 64 SKBs. This occurs when 
>>>> a new SKB
>>>> is added for each original SKB if tailroom isn't enough to hold 
>>>> tail_pad.
>>>> At least one sg entry is needed for each SKB. So, eventually the 
>>>> "skb_queue_walk loop"
>>>> in brcmf_sdiod_sglist_rw may run out of sg entries. This makes 
>>>> sg_next return
>>>> NULL and this causes the oops.
>>>>
>>>> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able 
>>>> handle
>>>> the worst-case.
>>>> Btw. this requires only 64-35=29 * 16 (or 20 if 
>>>> CONFIG_NEED_SG_DMA_LENGTH) = 464
>>>> additional bytes of memory.
>>>>
>>>> Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
>>>
>>> What changed from v1? Please include a list of changes after '--' line,
>>> but no need to resend because of this.
>>>
>>
>> Nothing changed, I just added the s-o-b.
> 
> Hoi Norbert,
> 
> Welkom in de wondere wereld van linux kernel development. De proces 
> beschrijving van Kalle is een goede referentie. Go with the flow.
> 
> Jouw naam klonk mij bekend in de oren al is de Lucent tijd al ver achter 
> ons. Mijn kamergenoot hier op kantoor, Hante Meuleman, kon zich jou ook 
> herinneren, maar dat is dan ook minder lang geleden.

Yikes. Sorry for the (dutch) spam. Blindly hit the 'reply to all' button.

Regards,
Arend

