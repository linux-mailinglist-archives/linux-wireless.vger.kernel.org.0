Return-Path: <linux-wireless+bounces-15110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A559C0EE6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AE91F22888
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C21125D6;
	Thu,  7 Nov 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IwSEGqKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F4802
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007875; cv=none; b=lDC8U6tNflImFx1CjWosJuRDcdRvCuPHpurgxTe9LF7Q1KGO0/j0lQShGVq2CU9cyVfg9DS/wSIThf6zkOSxzTRbJzVQr2W/q+3yNvFVgV1NPx5MYc4GKiTUr75PxZ6ft4TJqMCn2ps8aZEd+Kj/mThLQSGyeeG6AHKqL5yeyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007875; c=relaxed/simple;
	bh=knmK2kv+ltXn/nkFf97GXoRKkvrzpYGP7ZMmGKDG5f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT8K/mtgVDIu4Sna3jEMK74f/y+4+bJ7TIaWJ+0nX7HqVZ+t1cqW5k1XzYciPfal9RUdFUAYoscu115CKCTvNSorkDvDMDp0s+K4oFuJNdORLaWtMMF3MhWb6F2fxl6qYufjqlxpiK54XPh9WgbLxE2H02oHiPA7hNOZKMDYB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IwSEGqKQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e625b00bcso1000038b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731007873; x=1731612673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+iCuvSQqJG40d7+s/rONpRYtcKuCDDwr5ynxPe11Yg=;
        b=IwSEGqKQF75vKzVFf/cTJN1dbDWueQzzodZrqKduBH9ESK/HYGy4A/U11nvAZ48Whc
         M0b/2FjgLl190RAcR/hzadvghM33btZXGmtfmW+DL4ppVztH9xmqO7zHaO/C8UTEA85P
         X8T83F+Oi9XJZKrMcB6EKLnuQb0s1GrKbxBt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007873; x=1731612673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+iCuvSQqJG40d7+s/rONpRYtcKuCDDwr5ynxPe11Yg=;
        b=dCFQgIWCS9MIcg222wlqheorSGpo6/TrMZ2q7ltnmjM878C0SCODIQqjCikqKoU+Co
         zbyAS6M/2P3HMNUUOJWZI/M4x33p8/ALroagGZPdJAybSy2jpVN7T5n/dkr25xi5jNaA
         i9kJ81sDjm+v9/Wt+UMoc36igQWqZSpq4Eel7Dsfvp+wV5C11E6OF+wYSFr9OXwu1vgW
         4R1m3R3BEd1UhF9OItG4Qae6qKcVA4JNzAXYNR8rOpKDw1iG4J7O5jB4sV9y73jF4ZeO
         MNkZ2tmha1XDheVUgfo2uBauVD+h2yKvY1MaCadU1Vb900CzrPN8Iw5rGPdISTsGe/Nj
         GbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbAutTUTNNKcvcZIWtvcplLXNpFyt9i21pfDdyqCdGJyw0atTmsSfYRfPkrCPdb3Jjf7k6GkgKhTWt8oQeww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIo9TByTG83jlD0CMEOuMsWwU3GNsegvr35fAVl0xlZ4teTly
	K/kM/fF/zrHNvd44a/+fRqRQf9n1FFU5CZ3jCScIguwmkEoCe765MbZ+P+GSYA==
X-Google-Smtp-Source: AGHT+IHgBuYtqPwLcO+FFlEugXGsvJyL82Klx8Ha/f4mHy0ZbO/ksRdJnXteZX9BNdj7JbG3Em8w/w==
X-Received: by 2002:a05:6a20:7485:b0:1dc:154a:81fb with SMTP id adf61e73a8af0-1dc22b958e0mr132447637.44.1731007873486;
        Thu, 07 Nov 2024 11:31:13 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65bd78sm1840491a12.78.2024.11.07.11.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:31:13 -0800 (PST)
Message-ID: <7c03993b-be89-45a9-bcec-6649e01e054b@broadcom.com>
Date: Thu, 7 Nov 2024 20:31:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix oops due to NULL pointer
 dereference in 'brcmf_sdiod_sglist_rw'
To: N van Bolhuis <nvbolhuis@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
References: <20241107132903.13513-1-nvbolhuis@gmail.com>
 <87ed3n5dxu.fsf@kernel.org>
 <CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAP6rjy=gjbQg6hF4xzKZjabdtGVYijrPhn7zUHiw3ZHFJbQfWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/2024 5:09 PM, N van Bolhuis wrote:
> Op do 7 nov 2024 om 15:14 schreef Kalle Valo <kvalo@kernel.org>:
>>
>> nvbolhuis@gmail.com writes:
>>
>>> From: Norbert van Bolhuis <nvbolhuis@gmail.com>
>>>
>>> This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
>>> when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
>>> are sent from the pkt queue.
>>>
>>> The problem is the number of entries in the pre-allocated sgtable, it is
>>> nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
>>> Given the default [rt]xglom_size=32 it's actually 35 which is too small.
>>> Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
>>> is added for each original SKB if tailroom isn't enough to hold tail_pad.
>>> At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
>>> in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
>>> NULL and this causes the oops.
>>>
>>> The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
>>> the worst-case.
>>> Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
>>> additional bytes of memory.
>>>
>>> Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
>>
>> What changed from v1? Please include a list of changes after '--' line,
>> but no need to resend because of this.
>>
> 
> Nothing changed, I just added the s-o-b.

Hoi Norbert,

Welkom in de wondere wereld van linux kernel development. De proces 
beschrijving van Kalle is een goede referentie. Go with the flow.

Jouw naam klonk mij bekend in de oren al is de Lucent tijd al ver achter 
ons. Mijn kamergenoot hier op kantoor, Hante Meuleman, kon zich jou ook 
herinneren, maar dat is dan ook minder lang geleden.

Groeten,
Arend

