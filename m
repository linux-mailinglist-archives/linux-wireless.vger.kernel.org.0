Return-Path: <linux-wireless+bounces-23809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBDCAD03CF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D006E174A65
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BD1805E;
	Fri,  6 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CvO81td3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94DBA38
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219400; cv=none; b=LJyjxBCMroWpY2PdjJjKl3bLR7Lp2vOGpmJNIM6B8etc5r8e2Yh4D5K6yMr8Obdsg0ZXX7HiG5QZ8VNOXVPU+9fpNDAymaTIgDJ9ITUo9cM4UussyBWbvGmfcTtqvwgvDDFUnK02QcIHB1VNQg/o60p3rjIv/KppcVyl49MS9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219400; c=relaxed/simple;
	bh=IeNIre+MuPibbVdFxys+iLRv8iFeZ3xVzdWkJP/vS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzuUUYWzfMNYs1jvj7Kccp++IaqQSb0L8WAc1BVswejrPEklEiUMx3maWMCPpYwSblZga4M7NboOxfzbs9i9RJNPY7hZoovFKyE0NOXcr1+nWiET7pMMHz/d9XGZTaM7tKxlXCYdEOwTpyWjSft+72WZsFo70ZzgwG5WtAp20Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CvO81td3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742af84818cso1608762b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749219398; x=1749824198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0qoIq9MoDwoCUGEwR+DSI41rka0ilkJlnsiGp3Cyf4=;
        b=CvO81td3O0Z9RoqDkR1O9sQ630qW9jNVszY7mosGF+1IUlwL0zjc4UdoV9Hrw3qOHe
         0U6P9gqdaCPoqpU3HAqjWVpIvLOUB1zmHSiJ4dMW1N6EdGlCKqCSxxvaXVhJgM7Vg3vT
         JDu4TZngtWuiCp5yOW/xdFbMyxPh8YiZVxnXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219398; x=1749824198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0qoIq9MoDwoCUGEwR+DSI41rka0ilkJlnsiGp3Cyf4=;
        b=uA6kkPEnEPeDLK5c0UUZuleQ4VyYATYRJn8cXJps3HBhBde12zJcFeFCSMCDOs2QfZ
         N3ys8F5NdaHBgmRv9GSVT3PS3Zwkz9RLB6QBNDzXkStvCp9JsjqSyRfJ9NTcDilKvR5K
         mNeRiC2YUrYKDbOc6F5VIObW2VTpabja4WiXXFlIej+uRWkPL4lWUVE7S3erQiZxv5p6
         ZWx08fLxKJa5SVxdxrZpEMMbac422Wjf8MbIF+R2nt2ZzbhVSH5tEDZxmADNyXxJOMg+
         mwgYrqbiewrmcSdr9qX07Q0LdJ1E7bJxtMFQONcEdf8sLgqRDBNprf7TMG9mlCUhxXm3
         zdog==
X-Gm-Message-State: AOJu0YxudhDWlE5hLzkBLN33IaBQfM10AFUOLoGpZguejOpEaeXpzy33
	7mDUOn4edG24oveJnIVY1CcRVriNbPuXqUd3dSTwLP5t8dfJPVsi+vUUWZJYTeYEJxNIyeHRbMA
	OyTbUgQ==
X-Gm-Gg: ASbGncviW+OrRAMCBsjAMBvlNvMY972CYRP7gULt1V5lAKkKounT/D0A+wtPI9VcXWs
	wre8NMJln4qoSdNS1kKW7hJ2kuoHXwM6WZUqt6g8T/oigc9ptCFKJAXREYaT0jh66vQzLs3R1ZH
	JfYzcHtzNoFc8b3FcnpZxvqfq3Fas9hZX/LoDxnC244iiNg+Il9op3hTeW54mgO2pp+7tTjT2ID
	jyBqJV0u75KOgeTaPrF8c1YWhwtklgwlclgyzSvs7AR48DHHFCxoTClfwDh1exa/QF/z8qqsCF8
	OuddE+sm3ZQqwx3PwzbWnpgB9PxGDD65nHEmwaYqRI8OZjACg65/+l15ev+GgQFe2L7xAD7RSWl
	iwmn94r9tm1fkLJX9kwX9ifEDbjLtTsU=
X-Google-Smtp-Source: AGHT+IEdLPZfjEUSFjHavxarBIzG9lfWo0dN8rDIpY7wyNxwmHusoXkIjd5qMbSD3LzP7L9A7XsGtw==
X-Received: by 2002:a05:6a21:9988:b0:215:e1a0:805f with SMTP id adf61e73a8af0-21ee685cd85mr4378845637.31.1749219398433;
        Fri, 06 Jun 2025 07:16:38 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58e9bsm1232150a12.10.2025.06.06.07.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 07:16:37 -0700 (PDT)
Message-ID: <5387a3fb-ce1c-4aa8-ab9c-1ce21a2dad36@broadcom.com>
Date: Fri, 6 Jun 2025 16:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: don't allow arp/nd offload
 to be enabled if ap mode exists
To: Ian Lin <ian.lin@infineon.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 carter.chen@infineon.com, double.lo@infineon.com,
 vinoth.sampath@infineon.com, gokulkumar.sivakumar@infineon.com
References: <20250606093444.15753-1-ian.lin@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250606093444.15753-1-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/2025 11:34 AM, Ian Lin wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> Add a check to determine whether arp/nd offload enabling
> request is allowed. If there is any interface acts as ap
> mode and is operating, reject the request of arp offload
> enabling from cfg80211.

My ACK got lost so here it is once more...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
>   .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
>   .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
>   3 files changed, 22 insertions(+), 1 deletion(-)

