Return-Path: <linux-wireless+bounces-15049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CC9C0129
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D38B21A00
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D21DFDB4;
	Thu,  7 Nov 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fgDPVEJS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7E1CC16C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971921; cv=none; b=fOHlmHTDHzqtHhd3VST8uICREn+Skccg+dG5HwjqBQLyH8RAHm3msNqrWSeTSjGCo9MVydoYU+AA5ldFTeNNyJDVMRy1swSSjJygsrdVCxwbVrSWfW3QFjbPgCE46Zr4jc89h7ynXh14zWPEjN8NmO9GX3/g/flpx40zTXkULnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971921; c=relaxed/simple;
	bh=m159+IikMR3y2vKuU2Fs+gJHeCK/8ga5kge5Q604QDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6bginJM0JyiZyJvBr4zHSNqHefRoX3wHFIqpSwV/Pp8xuu9YJFnAZZcaOE+WdUTPS6GvdepmTwid2yM/VRykmajdpvDSA/VwIAoou6rkOsW00rfTm8HYkRmPHW22sQgLyR1Ms/HQJLsawVrhz4sBvzpaEdoNLg9C/SgxLY2BCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fgDPVEJS; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f968230bso392152b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730971918; x=1731576718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsNUbsPgw0RjJ66KLm+4vytCboSyWhQuYpFnd2nRI3g=;
        b=fgDPVEJSVocGvC2lvq756qbRaj2NUieGzrdrRDPptErK9R4803zOidEGkO2hy6HNgM
         rf6ajdVm43vU6uoaaUHpKLxgSjo2TTZCwZUWKEYjBp5tYylks1zynEGxKMzXtFerjiv+
         3Ik/+ocuUhwMJKT5NLRcoWIySeHDOUP2GaMBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971918; x=1731576718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsNUbsPgw0RjJ66KLm+4vytCboSyWhQuYpFnd2nRI3g=;
        b=msqisSeRpUprrrw+PPaWFZsOskWXzxGUkRobQ+Pe9ukRMy0FKhMVblO2BIQjxWazby
         FgSHPGvjB4g7FLG/YMhEtC3JnCwGDXFa6IXYpRK58lVdBbqMPYYQLrVCI9meat7/o6Tl
         FztToEngvlbm9IZQ7LM7fy/D7P+V18+N69WCbKiwZ5FuCs8mQ81CItNURv1kBp5Jo5vf
         SBwfZ1cvcc18bak4VtyqbjCq+NPTl0JFZ4/N5AI0tzl9WGOuSC4tH4dJNnujKCXY8LZ2
         xyE6YkwvclJC3UQFgR5gyajrZxvkyX0rvmGVePIMlxtkmqwa/Mx0jm0JrZxGQ1xd6vQ2
         gGtQ==
X-Gm-Message-State: AOJu0YwnWlG4bA66DXDB1U+bFuf6G7vG6Q/9v95TIoS9fTcVUT2E3WVI
	/PfpCcTEfLLmhsj+pxY9Vc640UR8k9M3DW9N5xsLCbAK3AhwF2myUDy9JuEi2A==
X-Google-Smtp-Source: AGHT+IGai+gAxPsxcfHdBseu8rVbMWVhrTXJOGNdSYkqWjWZPnseKjYWXEgUDBS41NkC1iO82N9vWQ==
X-Received: by 2002:a54:4813:0:b0:3e7:6020:4a53 with SMTP id 5614622812f47-3e760204d5emr16765266b6e.20.1730971918134;
        Thu, 07 Nov 2024 01:31:58 -0800 (PST)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f4843fasm823508a12.11.2024.11.07.01.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:31:57 -0800 (PST)
Message-ID: <a2699327-0f86-4c70-8ca4-1225f3e712d1@broadcom.com>
Date: Thu, 7 Nov 2024 10:31:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Fix oops due to NULL pointer dereference
 in 'brcmf_sdiod_sglist_rw'
To: Kalle Valo <kvalo@kernel.org>, Norbert van Bolhuis <nvbolhuis@gmail.com>
Cc: linux-wireless@vger.kernel.org,
 Norbert van Bolhuis <norbert.vanbolhuis@ev-box.com>
References: <20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com>
 <87bjyrxy9r.fsf@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <87bjyrxy9r.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/2024 9:07 AM, Kalle Valo wrote:
> Norbert van Bolhuis <nvbolhuis@gmail.com> writes:
> 
>> This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
>> when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
>> are sent from the pkt queue.
>>
>> The problem is the number of entries in the pre-allocated sgtable, it is
>> nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
>> Given the default [rt]xglom_size=32 it's actually 35 which is too small.
>> Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
>> is added for each original SKB if tailroom isn't enough to hold tail_pad.
>> At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
>> in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
>> NULL and this causes the oops.
> 
> BTW it would be good to fix (in a separate patch) the sg handling so
> that the kernel won't oops when sg entries rung. That's not really
> robust behaviour.
> 
>> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
>> the worst-case.
>> Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
>> additional bytes of memory.
> 
> s-o-b missing, please read our documentation from the link below.

I have not seen the actual patch. Which mailing list was it sent to?

Regards,
Arend

