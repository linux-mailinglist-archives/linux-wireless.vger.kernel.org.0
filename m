Return-Path: <linux-wireless+bounces-14716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31B9B6116
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D1281870
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF81E572C;
	Wed, 30 Oct 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JwX+yrx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529951E5000
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286495; cv=none; b=KtchZWyrVjewZLW8RkhcWflRssDtgHYP4ioLb4CxGzcSH878fKqddD1qzS4+mdhoS3c15A1jpJY9WZe1aTWlsgVdb33s+5Sf8e2JtF1zUlv3cXAibHzgbKxFkVkc9nzx0WHRGX9Lvs6NgCYHpn0vyRjKWfRgLr8bpQeiDMa01Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286495; c=relaxed/simple;
	bh=mQhweHZtfQd/nfsfIKR/19URa4f+qVo3ER/TW2Dj1Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWx8Etz+MTQtwO/fcvNwcWq3cohuqkRdWfajkR6z9dEnv6OzCtlNV6UT6OlbyWcSv5+m410sBrYZmDKsQspNvj11KM3GbyeCyU+Fn5QwnBmZIJp2lZgV/A3cbMxbM60lZ8klzgvG7h3aAxQoR9G+t2acPp0RiiLoi53Gia7OKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JwX+yrx2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71ec997ad06so4665928b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730286492; x=1730891292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDC5+p/fN+8HeECl2TRb5z1+IbrstnK0lNDWpJYgTbY=;
        b=JwX+yrx2D94Gjd4RigybSbwxVY/A0OgPLd6ouhUrDD40of8iU2nrSkNonIeEhMTTqc
         ZYr2istoJr9pPvfKGB5bf1NJ24PXj+Dx+516n4yYiBT+6weuP9mQVgW55tupOpCi+jEd
         tVakPsaHYhSeCXYEjR4bszH/IOB+q1j0ijbFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286492; x=1730891292;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDC5+p/fN+8HeECl2TRb5z1+IbrstnK0lNDWpJYgTbY=;
        b=t9hGWSiEP8o+FdfTtISBBNUNIEtSYquAVMHfsWVcvYEkvll3V1uAlmBwWDt17FpSKC
         iSsEv2+eYw9PDPQ7MaKzy6sU/APl4Jbq3iYhw+9xFYWph3lB4NCkbzVha6wWqQyQrko4
         Cw8Am0Mg7+SM5h596zoPM/8AYOLbzPEI7ULmpjHvNOhRMyeDU9cc8tneI+B650f0vyQe
         6dJ90t8/Wrnr6ruEgy0Fuuy3N9DW9LDv0U88YXcE9jiosHi5QeRQBaBvE+J75X74dsQ1
         4KlU1+XhcZYtD8j5ScAw2FfzGLScuQIEGu0jf9v+EGRz8zctUrKNh5no+YDxxE4pmq0/
         HD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMCnFIOv11+wfSgHt+Do14fdNjTNAwuecyo5MZ/r/QTAsqQFAObckdaj5YrFBpXZ9e81mfrCterWhTK/GOmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIG+Oay4B//8YWnNNwgkzBjJViVZpakOaCupdhj68WEWpzIBUF
	7oiGWtNRKZc9/iiT6jtdutr4AnUgxSK+zQG/3iiOblEZpzCCJsq6wuc6v5WMDg==
X-Google-Smtp-Source: AGHT+IGaKpkSr3ONj/8tkf0uNIDs04G8IQUfN4JFdlW6rWyabr4OE6nAnW+LkU/GJjSgkungmU1zJg==
X-Received: by 2002:a05:6a00:811:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-720ab4c705fmr3538687b3a.28.1730286492478;
        Wed, 30 Oct 2024 04:08:12 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793189esm8950018b3a.58.2024.10.30.04.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:08:11 -0700 (PDT)
Message-ID: <467fd994-01f0-4057-964c-4184a23e59c4@broadcom.com>
Date: Wed, 30 Oct 2024 12:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: incorrect shift and mask operation in
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>
References: <9c02683d-c688-4e39-913e-6b20b3bd76a0@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <9c02683d-c688-4e39-913e-6b20b3bd76a0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/2024 1:02 AM, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis on drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/ 
> phy_n.c has found an issue with a mask and shift operation in function 
> wlc_phy_rxcal_radio_setup_nphy() as follows:
> 
> lines 26326-26330:
> 
>          offtune_val =
>                  (pi->tx_rx_cal_radio_saveregs
>                   [2] & 0xF0) >> 8;
>          offtune_val =
>                  (offtune_val <= 0x7) ? 0xF : 0;
> 
> and similar in lines 26376-26381 too.
> 
> The issue is that the expression pi->tx_rx_cal_radio_saveregs[2] & 0xF0
> when shifted 8 places right is always zero, so this looks like a mistake 
> since some value value between 0..0xf is expected in the second statement.
> 
> Since pi->tx_rx_cal_radio_saveregs[2] is a u16 value the expression 
> could plausible be:
> 
>      (pi->tx_rx_cal_radio_saveregs[2] & 0xf0) >> 4
> or
>      (pi->tx_rx_cal_radio_saveregs[2] & 0xf00) >> 8
> 
> I don't have knowledge of the hardware so I'm not sure what a suitable 
> fix is.

Thanks, Colin

That looks pretty redundant indeed. I look into the history of it, but 
ended up in an old end-of-life development tree and the code was pretty 
much the same. It is one of the finer dark arts of our phy/radio 
development team I guess ;-)

I see that Dmitry Antipov submitted a patch to address this. Again 
thanks for reporting.

Regards,
Arend

