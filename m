Return-Path: <linux-wireless+bounces-14718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CE9B612A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD21F21FD1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC81E3DF3;
	Wed, 30 Oct 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XD+PZo+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753F1DDA31
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286791; cv=none; b=pudgHR+hOERo1jALUa9dIcJwx9Sdz+sQ99PIR0bL6Otv4uCzc4h4fOd8D+NJTR0h6vDEBzLlxXJcMCieRKR3m4OL8GCF/gp7dP5EuGdeTP8pbsPPjeMqX8yDR1HsFAFdLL2KnvbVxIVDdEyqyUDBgzhFimId+SV4GwP4O1n8IxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286791; c=relaxed/simple;
	bh=s3WOqAaRggXtG9U3QmYeq8Iju+1oJET+keeI0ma9SQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnmxEimrdnzC4JCBFlskCnst3xfvXlYUfbEBcAjXvsuBTblSlJtZnsFV5EirhGJxL4RA0MX3SyO5Sx8H1lvvbHd3Bm5vluKk8U2wPm3x2RYO5Io2fiARG7lGlOmscHv/EguCDzalafzDoc04GZJTO9m9w/3ObbO0DEG++K7rEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XD+PZo+e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cceb8d8b4so4855145ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730286789; x=1730891589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7C9xzsjuF2YsT4462+eFJIe/LNzFrPuL7hm0FZX2TlU=;
        b=XD+PZo+e/sVqYf9f6J+hvykec95faV/4o9Me4Ngj96KYQ+xjKDZH8Sjs29sw2+EsPs
         IiujDe8h0/gm36ns1jbJjUrX3t08T6vy18d7cJ4JEJDSzE4ujmGXh3uwjZu8LhHz2DY9
         mH42u1voEl6wkpVj2PNwTS3w1o9ZqrV+Wrc0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286789; x=1730891589;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C9xzsjuF2YsT4462+eFJIe/LNzFrPuL7hm0FZX2TlU=;
        b=OBVK/qjyIolIZJYzggHeaIJoAXEAHQXrExeLlCuJyTeipWNsyAm+FDkODDoOiDtKL5
         uToJJk4omLdQZZ77xW1KuGDWyUH6nn8dtzOkRZHKlVEIxckGr1a3yTZzb3P808Icfda2
         Su1jsoIgQlVzZqw16B9R3l6hy9ZqBY2sGgEhl7r9GkXU+11SYuX9D5ntcxxKbYEz6036
         RrwNMI0KCiLuDAvjMuK04562pSo1wVwoGJ9oVTDom6EUEgGqaDf5tkxUwiVIq+hldjPP
         lThw2tM95PKtVKn24b01LOJwmC2fW7ByGhZ+cLTtRebDR8t0nqYYYJEnxImr6HsuoPYc
         rQYw==
X-Forwarded-Encrypted: i=1; AJvYcCXA5px6KSQpTFi7i2gDSGTZyndMVYgee1QqpTjMhDxTs4C57ybWOAiIUrgHMMHmsHCGCnHQrDj7jKL94vZruw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTKaRL/cP1kMbqWx/+qTRFF2plxebJynKwRWmufGeZfSpXt/o
	QAF46kCZbYF7Wg26wyNz+O0dDSuvqm1jfvQpIurx4HLOs0HbE+tf4T2n7k+bNw==
X-Google-Smtp-Source: AGHT+IHQT+JJliJ2TytT/6xFEfdWn7W6YA0Luor3NwwUfy4M21WwgE6AI60dFmIcMmh4EnIKxB72rA==
X-Received: by 2002:a17:903:2448:b0:205:8b84:d5e8 with SMTP id d9443c01a7336-210ed42e24amr74998515ad.18.1730286789132;
        Wed, 30 Oct 2024 04:13:09 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02eb81sm78811965ad.207.2024.10.30.04.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:13:08 -0700 (PDT)
Message-ID: <706a7971-71c1-4847-9c62-f9033557f746@broadcom.com>
Date: Wed, 30 Oct 2024 12:13:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmsmac: simplify wlc_phy_rxcal_radio_setup_nphy()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, "Colin King (gmail)" <colin.i.king@gmail.com>
References: <20241029114912.1534179-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20241029114912.1534179-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/2024 12:49 PM, Dmitry Antipov wrote:
> Since 'tx_rx_cal_radio_saveregs[]' of 'struct brcms_phy' is 'u16',
> 'pi->tx_rx_cal_radio_saveregs[2] & 0xF0) >> 8' is always zero, so
> a few duplicated snippets in 'wlc_phy_rxcal_radio_setup_nphy()'
> may be reduced to compile-time constant (in fact, the same thing is
> actually done by both gcc and clang I've tried). Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Thanks, Dmitry

This was already reported earlier bij Colin (Ian) King. Can you agree to 
add a Reported-by: tag?

As for the change it is true that it boils down to a constant, but I 
doubt is that would be the intended behavior. I have to consult my 
co-workers in radio/phy team.

Regards,
Arend

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   | 44 ++-----------------
>   1 file changed, 4 insertions(+), 40 deletions(-)

