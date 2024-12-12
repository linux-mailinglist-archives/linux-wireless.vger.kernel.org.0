Return-Path: <linux-wireless+bounces-16300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EB9EE30F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B174280C64
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BEEADC;
	Thu, 12 Dec 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cnYiqyja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305618B467
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995840; cv=none; b=iq9g9p6U9Ms4n1v37XA9rrSI7CFHPlVSIAlleO+bD5WRitpU6vSd3p9CVb5f7qDgI7I8PbR3H3QUGfwyDa+nbZHb4HnFYkr8IkTt7eHz6vjzHSsDBVoKQ01IJnFC+gY1g4AAjSd8lTwI3Wx2NDap/A4xTsU77vzZSQrj9nuzyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995840; c=relaxed/simple;
	bh=6Owr0sSbujecwRz7epyTJEO59p8ls3mz3pTtyP/dTtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNvkveRzfgkQgjdvTyCihqMKY263Cf4VMhMq8wYtt1b/H3lA75MC9peEd3Qjvnngq5H7F+1LhgB2+G574xmdx5R3wF5ZhiOqn8M/AhPSxJNHCxbXap7w/uXLER731yDfYZiCFM48u2LkMPcqqHY8lQHHhn1ZaG8Wc7kH0tDyVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cnYiqyja; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso3186845ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733995838; x=1734600638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujkq6Aw55qfMJv8yqJ9/9Kat4ace8LcDBlPR3pqn3ec=;
        b=cnYiqyjaOD+OmA+nvrypxiyO8OQuNUQRfHGy4Gp/XPsroPJxmYPRAZ4DnYo39GrxiT
         KYCo4usiLuhkn2dbpuqo4DNmU+w/V6Cqrcbq+Y1JYEwHr8RLbV3UzzyG0JakAeGIZO5z
         NiDeh/CGxeiZiwUq/eflfXFgVCa7jV9byLnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995838; x=1734600638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujkq6Aw55qfMJv8yqJ9/9Kat4ace8LcDBlPR3pqn3ec=;
        b=OU4aCxbua4kK32DrZZZBF8XPEnEYFprLOCEmh6GF1cW8N9fdFb+pkOWWhN3Jkal2bc
         u5jaExJfTcAz4IOfyHWxwZFSKbSS6dsY6WUdmeZIbPndPsOZrnE57dbOlqWFrSWQ4nG7
         8N99mFrXvvpJfkIKj98oHfI/Hy4dERnK9mz7lNIT+D6USkvc/OY/q5tNbDVUTZXoB5P1
         EgGnDwAQfX8BcvYPEcgPM2rvF2FFffgKkKjjTOXqylTsSBXPxGf+p/LRKj1F+casm1W6
         rGFfbAuAeUOga7n2xHz1UTIlp4/74lZGzNTSeNP1gDNky0kQFSct+Ws7i+UhWpgvSwva
         WQcA==
X-Gm-Message-State: AOJu0YzjxpeeTbCyVfez84O4iPoPbbySNqwNTb2QNCwBtpoXxSYB7730
	j1HOey3lpdWN4/qhM+DeLNh8A/MxZPz9jvrdHychvX6buuM/uCRZLBSJ12YJo0Tm+nyfKNfLfmV
	zpA==
X-Gm-Gg: ASbGncvqF+ieBfr7xD3iqxibGKmI8tT0naP5N+sRSs8xQBCM+AafH+vw3+vqfff9Et+
	MflDwRN5wPW21acYHlR89+Lxprds8VKe/uUHcIFUSK2oQ8LbPo3xNEmNItJCoYeJz2AzRkwLMcr
	cTGxONt24W1/YFnui7gteOPkyqW/MQ8WaJdL9NitufXUlCdop6uhKaPagi+xmqiFaFMzGqlItgG
	inQNlFS2jN42PE8nxURqlUYI7pyWfwvjmk96SAQdHxwdX/3JWl5Ldwy7oV7DGa+J7qX8HkFdWuZ
	FJqcMlA=
X-Google-Smtp-Source: AGHT+IFPVbKE2J1DexXIAvITd5N1BJg5X1UKs1MKo3x8UIPXvypN4zmS+/POcsKkwzjly4AMY1NrCA==
X-Received: by 2002:a17:902:db09:b0:215:352c:af73 with SMTP id d9443c01a7336-217783ab34emr92879795ad.18.1733995838266;
        Thu, 12 Dec 2024 01:30:38 -0800 (PST)
Received: from [10.176.68.84] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21622f3a5f1sm95460725ad.37.2024.12.12.01.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:30:37 -0800 (PST)
Message-ID: <7c85313c-58e2-4bff-a525-a40f8aadcab9@broadcom.com>
Date: Thu, 12 Dec 2024 10:30:31 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: remove misleading log messages
To: Alex Shumsky <alexthreed@gmail.com>
Cc: linux-wireless@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Kalle Valo <kvalo@kernel.org>, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241122180435.1637479-1-alexthreed@gmail.com>
 <be2f054e-5ff8-4fcb-ad50-0dc0d5c03bf5@broadcom.com>
 <CAF4oh-NtqAX6gqz3DnLes6oR3RhZyOEvSfOk=rPPPm=1XzGAWQ@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAF4oh-NtqAX6gqz3DnLes6oR3RhZyOEvSfOk=rPPPm=1XzGAWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/2024 9:08 PM, Alex Shumsky wrote:
> On Tue, Nov 26, 2024 at 2:02 PM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 11/22/2024 7:04 PM, Alex Shumsky wrote:
>>> Currently when debug info enabled, dmesg spammed every few minutes with
>>> misleading messages like:
>>>     brcmf_netdev_start_xmit phy0-sta0: insufficient headroom (0)
>>>
>>> Do not log this when headroom is actually sufficient.
>>
>> Thanks for your patch. The message may be misleading, but it is actually
>> information that we need to cow the packet. The zero value indicates
>> that this is needed because skb_header_cloned(skb) is true. So it is
>> still useful in my opinion. If you want to make the message less
>> misleading for that case I would be happy to ack the patch.
>>
>> Regards,
>> Arend
> 
> Thanks for the review and sorry for the delayed response.
> Do "%s: clone skb header\n" rephrase make sense to you?

I would say:

brcmf_dbg(INFO, "%s: %s headroom\n", brcmf_ifname(ifp),
           head_delta ? "insufficient" : "unmodifiable");

> I have no deep knowledge of this code, and if you think the original message
> is actually useful, I'm ok to leave a log message as it is.
> Initially I had guessed it was an unintentional log message because it has
> misleading text and logs spammed every few minutes - too rarely to consider
> It as a real performance issue.

If you enable debug prints you should expect performance impact. If you 
want to capture debug message with negligible performance loss you 
should use ftrace. Debug prints in brcmfmac are setup as trace events.

Regards,
Arend

