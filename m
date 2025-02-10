Return-Path: <linux-wireless+bounces-18697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB5A2E826
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9497418844F8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04411C5499;
	Mon, 10 Feb 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="TCccnZ5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067602E628
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180909; cv=none; b=BPl/a84ouDv/B0shHPVropJlblyYQeyopk+OuGF6Skf4wUOoFldL8XeEmpBcA09/Gw2XlS7TVJbO30Vw/pF6isI6ZEYdvr0T6bnR2aguTw5eOjKn7hkuG3j72UKVJiLQrbuQbSw8dgrQe2xg+elQzh2mf2QfFNvmd2Mz34v4qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180909; c=relaxed/simple;
	bh=Uq9LEFwqXD/ohngq9zlUzUQyXKiamR8ZOhOnBCMIfoo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dc+xDFx0VzjMPxGt7KXoNqt5lETMDytTDyHd1tRSQBPhdHatK4nZARoPbSDXr9j+I0skfs+tQxuyaBU1SfkFfCXpDT4sMknmMfEZJu7mO5Poaz4E92BevSIHAlWLKtaaGgDxtdfvwoYfSX/UljAxL3rNzzYsz97MtEAUGQ+doWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=TCccnZ5L; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436281c8a38so26814155e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1739180904; x=1739785704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9sWAuiljb6qgt2soNGlWZPwj09N7VzIfmlBHhiUbhLQ=;
        b=TCccnZ5LsFw4rYRxnzOgGlGdv5PLrFAlfcGOy7MYMsZPvnadO6Gizq+klrrUDGp/Z0
         OzFKcR70xcmfb9WxVwlr6VqMagrgA4rnCnW9XNzjBi+lz5DBlVMuwAUB8xF+KUqF77Sn
         SgQ5G6kz3Id/dNe36VRUi+bWekUwyt7oC1kI+lPHPEh5oSSomoQJK7y5mFYApDtOXg4i
         nE23/DpGF9HP5cwCqAmrSjhd5ii3qtCGrE1nAUC69j4o+nPs5OgFfzxDYtABM7StKR71
         0FsMsuUvMvskT9VoEyn/9MhjIRkkX+kPvBJ2BOKXwXruLGjbXWSsRnz6vDx2eAGcGLoq
         LzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739180904; x=1739785704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sWAuiljb6qgt2soNGlWZPwj09N7VzIfmlBHhiUbhLQ=;
        b=KuoLcHuZc9Q3STEMYK+mdAjtGX0CigyI1O/kkUHbiaIDW8kYHGYSvTSMFwHOQPYd10
         rfqtSytnkgFWiDqx02ohgY3jwwjY67NEM0TA/vy87BMK+wHQvLDqJ4qBY5m0m2HHch5J
         0E5c5dUxPPf1v30MN4s/1bpykdj57sEbTveHEcvTTqE5F0NBewnhJTNEau+KX4g7Z/pc
         wCSVgUJZ2cslMW5RHFq5mxQCEsVF8OCDqgbDaIZEdgJRsbdF2mE2MPmW2FHeNpJPDC2N
         hQTzUl/0coNiNIsGwrw9+4wKj7kO/hURX4YxGL2p9XB9vGuyPR3epRrsDm8vFI+ri5ea
         LhOQ==
X-Gm-Message-State: AOJu0YxPqat7egyWWbAWJyg7IV8GCfZGaxT8pNWF6Njv5lW1UHHXkQnO
	GDxmGYs3crWbl1yY0iO27SWbodo0XSKrE38icM5e2AMtwYdMH4E4ciri+Hm97PE=
X-Gm-Gg: ASbGncsSNSaJvtvpmqsdXe0g2jIf26NgNm4d+E+MuzCbxfClg6ql/PooDEeyp9RL7Hk
	9QmhZ3a7CNqKWjUf4yAtl/IKwRWz3UgqAXZvkhRdLdPcLHdTRQNt/LLqRwNgSl7b0OIJFicDFIa
	OIzLJlL0jBWh8vj9WVR4b11soRUmZZ48QSSp9WriynQL+pTuyC+3ukZqKeKxFlhz9znhQix4DQw
	19oP3mTz6FCvyQqPccxnGGwVYZTvL3vptz2et3xciYpKs8OulPMoXxguichGSYh2s+kMa2Mjlo9
	Hqplnifajc40M9uXpVJ9Jh+07pxGl5+esYc7voymizqzCoo=
X-Google-Smtp-Source: AGHT+IFQo8xzQ94CgaklwWkOTUBMlFg9l5Wqvm7POmCkzaGuaqB1WbSYEchbGaMfjn/MbKEPCg+lxA==
X-Received: by 2002:a05:600c:a4b:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43924987b41mr101980005e9.7.1739180903971;
        Mon, 10 Feb 2025 01:48:23 -0800 (PST)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391d5283b2sm145015155e9.0.2025.02.10.01.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 01:48:23 -0800 (PST)
Message-ID: <17a9044d-4bab-40df-a119-8c43ebd60bc2@freebox.fr>
Date: Mon, 10 Feb 2025 10:48:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: Re: [PATCH] ieee80211: fix interopt issue with MT7927 chipset
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250120114551.1542812-1-pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20250120114551.1542812-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2025 12:45, Pablo Martin-Gomez wrote:
> -	/* on 2.4 GHz, if it supports 40 MHz, the result is 3 */
> -	if (he_cap->phy_cap_info[0] &
> -	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
> -		return 3;
> +	/* 20 MHz-only non-AP STA */
> +	if (!from_ap && (he_cap->phy_cap_info[0] &
> +	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
> +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
> +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
> +		return 4;
>   
> -	/* on 2.4 GHz, these three bits are reserved, so should be 0 */
>   	if (he_cap->phy_cap_info[0] &
> -	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
> +	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> +	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
>   		count += 3;
>   
>   	if (he_cap->phy_cap_info[0] &

This patch is still reading reserved bits depending on the band being 
used. I wanted to do a new version of the patch to avoid doing that by 
passing the current band to ieee80211_eht_mcs_nss_size(). Unfortunately, 
ieee80211_eht_mcs_nss_size() is called by ieee80211_eht_capa_size_ok() 
which itself is called in places where the band is not known. So I'm not 
sure I can do better than this.

Best regards,

Pablo MG


