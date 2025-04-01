Return-Path: <linux-wireless+bounces-21030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF57A780E8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF093ADEC4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667B20DD47;
	Tue,  1 Apr 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cW5mZKyF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB620D4F4
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526671; cv=none; b=h9eSzMVPIsmjpvdPQ7Izc3XaScuvE9pRfDbgUupLq0adoM8GXwlZHxLwMN4jKgTfClS/DqhbnNad3pALn4QFEWMM6QkgqOqwqRlyFgeCwbFpsTwPkkZ9o7tiMN0nuwBU2JxKg/MekGRitrUoWLKtfJctcyIWZ3yaJE+zxNBD2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526671; c=relaxed/simple;
	bh=F0V2cxyptzlCagkPfeXyVKb1UCEuS/E5+mcuEtZlLrw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=K6UbFUE/Ys7EitxeoOuuz8FlpMdwbQ4GiOB7HU2NO9OEQOZ4xeZloJY5AKH/MUQ3jnQCJcnYOa3JHQvQOZXHRKWhoH4qQezqBtWVQPTSaKjaP9xkyK0Oy6yX5atILlx/jrC63Ut6bdZ0ZqGymWT+MsZr8w39mCV+HZXJP3uzGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cW5mZKyF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f7f7b70aebso3624674b6e.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743526669; x=1744131469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq1eST4XdAuqIXqauWM348TcT38DynoDIrbdBB+uK9Y=;
        b=cW5mZKyFOXP5n1yH/xv8m6AT3P5IHyqWgB5RV9lZwBab+kwhbTk7RV6kkVnKxYvt7Z
         PtnCZQCDeI8fvIoz7MYskSKt79i/Gmmbxut3xoFflX9TLpTIjBhkI47X2fsVSUtN0T03
         hJChLF/I94d3xh2jAKVe5y1c8aBMB/yk3pCGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526669; x=1744131469;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq1eST4XdAuqIXqauWM348TcT38DynoDIrbdBB+uK9Y=;
        b=Y+HFnfi+NtlMGRujBPv8LeIXuUFZAIqj8PrSA5wx/zrhLVo1kFQui7/1mJRpLYVUgl
         QLcDYK3fDgFt6gNJhmD3IbIKcmhaaNOGHJmsSL9YGG4fBM4+JdY85qPrPjoWgug1q7jq
         UHb7r5eN0/ElqJPBfEctZXKct/4JHFQeANiM9M6OISdkh2XqCxQAanvgpE7q7oeETxx5
         lkaI4Ib77mAxzvKNhcKXYfofZsz7h7+Dtk9HIswpwhIZx7sAhZtIi7TFnNpVW114S/F7
         9pXbVwzKMpr3YiRKF7N3g8z8YnpCncZwgek6++JgDkjE7t9YCZUg8LTx9tkRZUdNGtwe
         0Nvw==
X-Gm-Message-State: AOJu0YyF6Lof6huxYRaqnvSrmcb8lB2ty094nnrUVbJQ+DNCUC96o4Hn
	G/ClWoNDkFcujuSSp/VCVUVbMd4Q/iCKiSwN+h0Sy6g3z8/YcT2z61zj4ekRoun8MnH6OcEqeTb
	QAEb0
X-Gm-Gg: ASbGncszr6k7Rwty6Nph2syryudqCl7LmU3tdj1GL0vqFh+PcH76PnX+7leQ4d+KFIW
	F60SwwvnNbYdRF3mdoiDklTsG6DQ6JnivMKalhSJDSUsbtwEHaYAGntG2hU8Xz1w0EZignLWRbc
	jafZzJ8EbLVvA5iYMj64cxi0S80EOBDh7Egr5Q6jZf5DaBraAcIPamgYblVQ6C2xnLFtFKE5GcC
	VWyAfED6cL9IFTUsbH3QZJwjqEHFgzFj09dLcdTelMM9rxZLisHkc80Mbmp11YZ31zrKVCPSmuw
	slxYFxt12JKBBcFiTxBieJMvUMSvkvl04wS3JRmj66d6vJfRYkbEv4nfZUTxZO2DWMJxcFS8yhl
	kQZWuGzU=
X-Google-Smtp-Source: AGHT+IGBx1noyN3TJ313n9Kthyl/Yjyce+VVSvoH/kFWvJU9RS3mJIOp7wnfQiVem0qSyin3ne6N0w==
X-Received: by 2002:a05:6808:3448:b0:3fa:39cc:3be9 with SMTP id 5614622812f47-3ff0f4eb1a7mr9016782b6e.2.1743526668749;
        Tue, 01 Apr 2025 09:57:48 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff05278de3sm2002721b6e.36.2025.04.01.09.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:57:47 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 01 Apr 2025 18:57:42 +0200
Message-ID: <195f2498f70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250401140924.29168-1-bsdhenrymartin@gmail.com>
References: <20250401140924.29168-1-bsdhenrymartin@gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v1] wifi: brcmfmac: acpi: Add NULL check in brcmf_acpi_probe()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 1, 2025 4:09:36 PM Henry Martin <bsdhenrymartin@gmail.com> wrote:

> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> brcmf_acpi_probe() does not check for this case, which results in a NULL
> pointer dereference.
>
> Add NULL check after devm_kasprintf() to prevent this issue.
>
> Fixes: 0f485805d008 ("wifi: brcmfmac: acpi: Add support for fetching Apple 
> ACPI properties")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> index c4a54861bfb4..4885d5d0a0af 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
> @@ -25,6 +25,8 @@ void brcmf_acpi_probe(struct device *dev, enum 
> brcmf_bus_type bus_type,
>  settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
>       "apple,%s",
>       o->string.pointer);
> + if (!settings->board_type)
> + return -ENOMEM;

brcmf_acpi_probe() has void return type so this would give a compiler 
warning. I expect submitted patches at least do pass compilation.

After digging through the driver code I see a null check everywhere it is 
used. Can you please provide a kernel log with a null deref so I may have a 
clue where it goes wrong? If any.

Regards,
Arend
>




