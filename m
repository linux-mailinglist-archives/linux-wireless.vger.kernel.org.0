Return-Path: <linux-wireless+bounces-11560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6D954EAD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DAA28203A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC531BE85C;
	Fri, 16 Aug 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AP6aOQih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240791BD00B
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825120; cv=none; b=OtJd2xWafoJZnEdYB0lxdQNIRuAE58FvwbKGYMRX9BE+ztTWwYuA/MaHHapIrtEXp2MrOMwwAXdfeZYazgsa9GjovyJJRv5yTRw+IL3O4KBx44kuzjC1R4G8YPps/F0JBk4KrLpE0PGkO4i1/kocSzT3vJ+tSus0zDOPlKnfrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825120; c=relaxed/simple;
	bh=kNMwi6/vL9VQa4GWyVCWAlH1b/iiCl6DKS6u4IVuWZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyE+lf4MT9fngwfp5e6v1gk7BE4d8QS27APdrlXlmU2GgjaiEwg1UFD0zHuYLct5ODozoumek+xtv/mCFMCOyeA5d3ddi+sazTOAjKODOVAgLzjWwzJbVNhWF9/k7aniD2bLb7jJjSvrLzYDyAdEJTko+/9jiyMgA05WU+wlYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AP6aOQih; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-709428a9469so1354612a34.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723825116; x=1724429916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pYrK2RhkUPrRPBfldhyUexgVa7GT5fKFpTAHXDEQoBs=;
        b=AP6aOQihjCPUX9hcJp2rdq03oJJ+s/6znmKutjpOn0YQqPguKKWbRtzjA7y3LXN2Ep
         0dNjEBOUZ1zS9eZtDazBxjKFLHIF2eEFdwIxBzVDTXLltN5uPsc//17l1Xv3yZJ+WvMC
         8Yjo+9sGJPfF0TzLic7qr8LTCg1mx1fDI6aCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723825116; x=1724429916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYrK2RhkUPrRPBfldhyUexgVa7GT5fKFpTAHXDEQoBs=;
        b=FXOmjQSCsTCkTn/vin7PQl+sOsLbymYRLwGr6nsQdxcTEtz3OAwKMiO9E9DFgPsGwL
         34EPJF04C4b7yoWcUyCA5enCyhDw3vMCkBfQX6mALJTIUa5ukt5yuEQBnYCHJIGQ1Su8
         eohQ2lvYV4bjf8f8J/H/RE5q3+sy6ITXoBVsGzlWqKSPx4JhT45bPskHGZf1BKMV/xbu
         g5IBN8RWEKA2BoWiDZB69bJ71ruhJQIjYg+v7pJtqdKVH7w7Vh51G1vvLVMF6y8Kptxu
         P3KvW53seN/f6VV5D5TILKCWEZkwLwbPJcaABwUpB5vI4nfU2fSniWBvG/ZPK4i3V6gk
         RLnw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/eNRt7f+RnQFHjLPSTNwBRpFxK5TZXyXKfBpDcLlgkbjPTSRtgeRIXAAz+/F2yrjD7F9BVy/l9KpGmzKRrJvR+d0ikxqSls8AcY/fOc=
X-Gm-Message-State: AOJu0Yz4x5nMQOcdTVZqQrYg8V5/Xq+rUEeE9ubpNOia4GERH0Vk/hQM
	oLMwmVm1r5ugTtsHBO9RKEMeg+O8HpRS9wNbAhZLGPu0wTBiBFzQ+v1DnvDpPg==
X-Google-Smtp-Source: AGHT+IFGFy80SN39TstUeIUHyNJmrcQez1h79V5ry5FfelR/TvE1aZAi7zD+BNDCMws483yF0eJxHw==
X-Received: by 2002:a05:6830:6d0c:b0:708:b46d:5c76 with SMTP id 46e09a7af769-70cac8619a0mr4254105a34.17.1723825116108;
        Fri, 16 Aug 2024 09:18:36 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0a5a6sm19004846d6.138.2024.08.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:18:35 -0700 (PDT)
Message-ID: <e9b229f5-b796-4bec-87c6-a7b64df51e44@broadcom.com>
Date: Fri, 16 Aug 2024 18:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Jacobe Zang <jacobe.zang@wesion.com>, kvalo@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 saikrishnag@marvell.com, megi@xff.cz, bhelgaas@google.com,
 duoming@zju.edu.cn, minipli@grsecurity.net, yajun.deng@linux.dev,
 stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 christophe.jaillet@wanadoo.fr, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
 <20240816020635.1273911-4-jacobe.zang@wesion.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240816020635.1273911-4-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/2024 4:06 AM, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.

Looks good to me. Not sure if I should Ack this as my SoB is there as 
well. If that is not a problem than here it is:

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +--
>   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++++++++------
>   .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++++++-----
>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>   7 files changed, 49 insertions(+), 24 deletions(-)

