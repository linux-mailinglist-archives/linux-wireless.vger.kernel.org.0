Return-Path: <linux-wireless+bounces-3965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EE8616A2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A411C25477
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6C1272A4;
	Fri, 23 Feb 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On/2ePtm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4B85C41
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703903; cv=none; b=DcJJDla5XlGjcUGOvIkX+YZC9hEZr9Yyov8C63aus9+NtQmPBgZ7K7XXS8bmwd3WpM4zQYTd+XOETVaJurBzN0Sl0RJ0aTV5RId/F26B2L8csvPDSdO1nU4gEwK8xvudITc8sFQQcDqPxyI6HL/Z+KxDGKF+ReKH5XmvBkecfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703903; c=relaxed/simple;
	bh=ExiD0VwMwZVmmyTeDSk3zDfmeAQIestAxliemJOguNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0xe4iH6tMW6AOy57T4XsJQ44Kwd+Y/jedNsWHuDxWjQStb6mpaUkQm7KW8pZmb5NXgFMXrocPs/PtFX/ruuwaRiqd5KO21mu16ZWuT+Itr0VcUfPW8/1W8f0D9Wht5jFXCHXDoUjra6rrX34ag/fF/IO0tP0E6Rg/fOC2js1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On/2ePtm; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21fb368b468so220804fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708703900; x=1709308700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v1lI9jVRb9FzUJc+RjSGWl8VjgPL+BaD1by8z04MQwY=;
        b=On/2ePtmVboLaK6ZkDkM9rJEUsdIBGNxEnlnN0npm84ZYZeewgllQkiAK3Kmt/7W3D
         x34XDKMlRdeNggyXH+OkybZWceNW2jlG7WZgVXnyiCL6mWS93lpNyvXuJoCs3m7equE0
         5raIc+RN5quixRD9EJxQZaNAGPipspzONaER4LJtxExVFgvNRA2S0RQscJDZV1Z0fbxZ
         J+g3lzaPHvySmjn45mpJWKZR/KtuApQpkbE5WE76IDdrSjsa1bYBuOMAemVwFR0Joelv
         Fyuior3cVNC7x/VZzmsc3JkJTHFG7sBsaJGaue7JIN2Gzdqf2r+5seQb1iVitpNCEWaY
         OB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703900; x=1709308700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1lI9jVRb9FzUJc+RjSGWl8VjgPL+BaD1by8z04MQwY=;
        b=vqktAGisRK9CEdxcrOyaWsTbAV0Cgkyno5pPA/SmE+m4ggseeYe69DdR6DNQO90aPc
         nLSafHpM8IdECEKIiy7ANH0Y6wpTPJ+RibAC69Qha8dJX4C5/WgBTBg9QVx+QL1t5OaV
         cBFv+HrFCXtePqobc45PZqt+61fhC4BZMJa8/beK4GTMb/GnxE9iIAT1sZQkCGo9LKIR
         WZqhIMcewz+ZVUx8Gs9eBMmq20WkKabKYUq6I7/vURKe9IXk+rdhFvc1NVO/tJjbtHvS
         O9BF3UHjx2QzSxwQubHfbj5LfWI2F6Gbbh+VANWKUmaLIrnQlg7VqiGc/pqnE3d+54sB
         Qriw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7DOdeGBMiVeqg65xhB1tRPej1WzuQs9gBUcgHPelgS5f8PWByF67i1sfTr5xU5eG2YvokpmLrHksyXuURwD2wqe6mIzmNJ1KJU3H2fM=
X-Gm-Message-State: AOJu0Yw6/tj3xWEli5aRjMS1vFAtAtslNAfXdRba7uXModYmijAOqKWq
	BXOQqUwvK7LVu7UslAU3kbKtyU6Nt7pEjm7qqsVyBtW2PeMYQxKM
X-Google-Smtp-Source: AGHT+IEeqimz8n+WIJPmOSdfx4K5q3jl6unUzEpL51E+rpn2WrIVdf6HekOJLh8p7c8TVdoslA0J7Q==
X-Received: by 2002:a05:6870:231b:b0:21f:c33c:322d with SMTP id w27-20020a056870231b00b0021fc33c322dmr212979oao.15.1708703900093;
        Fri, 23 Feb 2024 07:58:20 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id pf7-20020a0568717b0700b0021eb31be7b6sm3057959oac.14.2024.02.23.07.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:58:19 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <dd5700d2-d4ff-4fa4-92d3-96faaddc3bfe@lwfinger.net>
Date: Fri, 23 Feb 2024 09:58:18 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: b43: silence sparse warnings
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 04:40, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> sparse complains on this code about casts that lose bits
> due to the usage of bitwise not, but really we do want
> 16 bits only, so clarify that by using masks.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/net/wireless/broadcom/b43/phy_ht.c | 6 +++---
>   drivers/net/wireless/broadcom/b43/phy_n.c  | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/phy_ht.c b/drivers/net/wireless/broadcom/b43/phy_ht.c
> index d050971d150a..26a226126bc4 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_ht.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_ht.c
> @@ -322,8 +322,8 @@ static void b43_phy_ht_bphy_reset(struct b43_wldev *dev, bool reset)
>   			    B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX);
>   	else
>   		b43_phy_mask(dev, B43_PHY_B_BBCFG,
> -			     (u16)~(B43_PHY_B_BBCFG_RSTCCA |
> -				    B43_PHY_B_BBCFG_RSTRX));
> +			     0xffff & ~(B43_PHY_B_BBCFG_RSTCCA |
> +					B43_PHY_B_BBCFG_RSTRX));
>   
>   	b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp);
>   }
> @@ -551,7 +551,7 @@ static void b43_phy_ht_tx_power_ctl(struct b43_wldev *dev, bool enable)
>   				phy_ht->tx_pwr_idx[i] =
>   					b43_phy_read(dev, status_regs[i]);
>   		}
> -		b43_phy_mask(dev, B43_PHY_HT_TXPCTL_CMD_C1, ~en_bits);
> +		b43_phy_mask(dev, B43_PHY_HT_TXPCTL_CMD_C1, 0xffff & ~en_bits);
>   	} else {
>   		b43_phy_set(dev, B43_PHY_HT_TXPCTL_CMD_C1, en_bits);
>   
> diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
> index 2c0c019a815d..4bb005b93f2c 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_n.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_n.c
> @@ -6246,7 +6246,7 @@ static void b43_nphy_channel_setup(struct b43_wldev *dev,
>   		b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp16 | 4);
>   		/* Take BPHY out of the reset */
>   		b43_phy_mask(dev, B43_PHY_B_BBCFG,
> -			     (u16)~(B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX));
> +			     ~(B43_PHY_B_BBCFG_RSTCCA | B43_PHY_B_BBCFG_RSTRX) & 0xffff);
>   		b43_write16(dev, B43_MMIO_PSM_PHY_HDR, tmp16);
>   	}
>   
> @@ -6377,7 +6377,7 @@ static int b43_nphy_set_channel(struct b43_wldev *dev,
>   	} else if (channel_type == NL80211_CHAN_HT40MINUS) {
>   		b43_phy_mask(dev, B43_NPHY_RXCTL, ~B43_NPHY_RXCTL_BSELU20);
>   		if (phy->rev >= 7)
> -			b43_phy_mask(dev, 0x310, (u16)~0x8000);
> +			b43_phy_mask(dev, 0x310, 0x7fff);
>   	}
>   
>   	if (phy->rev >= 19) {


Acked_by: Larry Finger <Larry,Finger@lwfinger.net>

Thanks.

Larry


