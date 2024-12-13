Return-Path: <linux-wireless+bounces-16382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5F9F0D52
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC932161131
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D01E009E;
	Fri, 13 Dec 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gvsbLUAz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE91AB6D8
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096760; cv=none; b=EHL/+ptV9JRTLQ2fY535s50pHww51/5aznZ7qdY/uSCyftABp/j7mWmqFfF3uKtugzS1LOXq0jSPBzHgF6dxrUkAE/YAq4HJ3rkvWklQQEclRxJpfkJj7+4fRMiR/TazVZ0/zay4wrrhQCpBHiPhDKT4laYKD29ZfG3u3W8NPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096760; c=relaxed/simple;
	bh=UaQZsDkd+B1A07SI0lWEiaYS38mm+HnAA4NfPmXgsSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyPYO7guPP4d9ZoO2gVDlJYNGW5jmcffZkwGH4PpzNGIjaJUT8zEvdlcaxKeS/sk0CuNkGsv2Pa+v5pjvEjH/GZoX/vYjMTW7deDvNNtso7W1debrnnQmMXy2/o5EjbYjhuTmGoZ3nSdznwDSVmryKCIiwlbNwVpfev11gIeT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gvsbLUAz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso16017145ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 05:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734096758; x=1734701558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o6w5USa9s1QNn+1ezXty7PMBbfv5OsXZnA28H4J0kmA=;
        b=gvsbLUAzD24YkTdyvqXop9ZDZdbnRmIdcWhbVvO+yLzDvOvbZkCt/Eb+jWKZVkOO3e
         da0rz2VDRkuMr/xr2BS94ykDeMgYrJ1O5I76eY6kEW2mUvdYX9IjeATc89p6WJm0QFb2
         4J3Q1/zWnhpX4HcnXqj8uDuSEdprcRtKEi9rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734096758; x=1734701558;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6w5USa9s1QNn+1ezXty7PMBbfv5OsXZnA28H4J0kmA=;
        b=NdHt+M64j6TAgfY0X/QdAm0yRZEvU2YicIGNTSsmRGxXXJJzC15jeoW0s1ynwfPPp3
         RyKGu6d79dCvN2/I2zfoVgSXNuli+LiiCcCxsIgk82FFUAObzM2Be2EHEGyLi/uocWW7
         P+6bNAmQHLXT+vkhD02bezwxYoPBz+uH3auauAzt1Lhaia2n6fJIfbb4ILg+MGBXbBGn
         fahXxJPT23A3Gn4pBJWe98Tr3tUxqN89SOw1R4YgrBa+kAb1zY5P7rQ41bQdqclD6Pz9
         MVmQ6QJcrdzRWDRn19KulMGaVZC7fjcsrqUJLn/0BkDwsZY9UiRFzwZJgXpFSdoGx9P+
         8Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCVqkvMiV+xC1FGCAAugY0XJ/NJiMAYg/LBMm2sLY1H1PgB4NYm6EDUnXc6mccGB6PJFQAugd9F6v8W/tbjnIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQeIRleKy1jGP32R2HV97wigcGHetEjmdZDfbyKM1fj6+GPwZ
	ttsvYyOYDKhQD0GQc0czMitkqIWCzvzbybiqGcxcfxeba2QWMcvzHPNI+VhrSA==
X-Gm-Gg: ASbGnctwyyjSvbr83Hu5iZI/hyl+857fY3qJO2UOljeORxRoTGG0p67vDrsQlcqehHO
	5Zaf29x7cROB104/gCEOtkfjnvWtNskUAOxnzETyzWWbi4RAc8DNVuduWCW8zGpMl+e6KyBUwHB
	6HwJFQKxckM0xN01dU5yU8lIGVWop82nX4ZuherchqlQsXFD7cc/3sEjeiveNOg5Y1OM5jP13Zz
	m1dmZL+kpRWQLlQKRhrXL8EBFzq9RAEnyuYXlW8V4/condzT0J3TCspMica9TmmF4bUSuE/1OzC
	k5oVVWPbUgbCY5YZ0vQ2JEzALAZkx/Fm
X-Google-Smtp-Source: AGHT+IE0qGaUbFZoGusMOweMOfwSLmnmQahwkZgehkh9CKTcMpQsEjZpQ4Wtc0TIsuaU4ho4RUT4hA==
X-Received: by 2002:a17:902:f908:b0:216:69ca:7714 with SMTP id d9443c01a7336-21892980b8dmr31144465ad.11.1734096758207;
        Fri, 13 Dec 2024 05:32:38 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216432f3809sm92088945ad.153.2024.12.13.05.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 05:32:37 -0800 (PST)
Message-ID: <75bf61d4-ad43-4272-a6d8-4c78dbedee2c@broadcom.com>
Date: Fri, 13 Dec 2024 14:32:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: clarify unmodifiable headroom log
 message
To: Alex Shumsky <alexthreed@gmail.com>, linux-wireless@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241213081402.625003-1-alexthreed@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241213081402.625003-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/2024 9:14 AM, Alex Shumsky wrote:
> Replace misleading log "insufficient headroom (0)" with more clear
> "unmodifiable headroom".

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
> Changes in v2:
> - don't remove log completely, but reword it
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

