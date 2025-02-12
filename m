Return-Path: <linux-wireless+bounces-18843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C595A32762
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBD61621C3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4EE20E32D;
	Wed, 12 Feb 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSqxjR8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5C20E320
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367744; cv=none; b=EWte5x7KZeYLI82EJn0uhu7TurWKSC+zSBEyuYJWkOAKboDTPT2CvMqboSSBuK8ue0mpYbGj+HGP0pSHk19r+pUXh/zaTOkbADvZ+wW1y5xc3koMpPGn9j9NEwzzIjxcB3Vxukp36+wa3DD0dq4heZfFhJ8nvfhT+VpPu46O20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367744; c=relaxed/simple;
	bh=Z0fxZBAzfIYmUMXhU2cA1/PmrwTC6A92uK2aSyK7QNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc6IsitKVRZcjHRTtkwDGQc6BooFm8nnCGYBY5sVh+MlvAd2bcmxT4+mKVWUQSffmITB/Ua0ExiVVq1yKoJeFeZoCaBdJXndZDFE7pwg/VbgUy9QxMmikZtl6f/C+V5HIqh+3iawkKZ3MndO1hbOx7fqmGUBAG2Y5pHyXGopPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSqxjR8I; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e4554e1c26so9153666d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739367741; x=1739972541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgqcJMrN+oO4Lcfjo9FO29l2+bXN3T74siFMzmQQ8Ps=;
        b=LSqxjR8I39xFPoQZy0JF0koje/u6xSSiZHjt52sAiDC9dX0IPkkoUfUM5eaUxv5J+8
         zRrFO55TkDKRdoR5y94uBuK4EG7gtvoB6n1HNPb2motd9SAgrigtTkZK4ygme0XIdH3v
         NfxzhJAEAwQIwObpSKxWwNKuq7So+P/eF5ESGu5F9hHHon7ufCZvGmUeQUJ0uPsIF9lA
         9blxEwxWrGb4Nbrvo7C4fKKy9BRb+qpK5WV12s1cHhgSAl2hdrk3O0WPxvCh07f6uqe/
         uGIgEhcjEt3Sjef8XobbLPlLIdjyVztJpnpraTkCmE+TMS5TNZwtWeSQFRo06b8eVfHC
         7a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367741; x=1739972541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgqcJMrN+oO4Lcfjo9FO29l2+bXN3T74siFMzmQQ8Ps=;
        b=rclcFSk99z52LJPV9Vin3C+SOUDFbcqgZ2UkBXujmfByVjgBuIbmCjRGauEuUXjR1J
         g6bUMgEYq4Fnf8W1yqdIxIL7ETH5vJ4fDrZLqJpHETG1n/2ftt/e7vdlHFoJ/OXKf8SA
         gsbIDXhedpjtwbeTIwpj/QYfQuD+92NLbvOO8QGWeIxkUX8qeB86xP4gJCzb0NKZ+CWK
         c0ZVX9fq05K5XXo6ve8ZNRwHG/8ds4S6+uFjAGJPmwOxs9cSwpW32Wt2LE2qCZGIxrGK
         VaO7H1mHOk6XIdp/TFuK9hXeGeR0gmaLC02uj2eeGfAqs8ZOR13apSBSTAq/NOnic8Hz
         PTfw==
X-Gm-Message-State: AOJu0YwjVGp6/cERBUfdf+br2T8Hh7ncE6Zd79rRrEsaxWBUIa0PTZiV
	cu5pmtU70Ol8T+on/ih2ja2MDKZcyI56EwV9PyrtTRUxG7pznyCA0gT//A==
X-Gm-Gg: ASbGncsQQ3/gRgBSfH6Sc4CP2JT9i8UW7+TVMC3r9KlxV7blYe2qPpiNpT0GfaP+jcm
	HFJpZIaIBb+AnHRZtinMxLYCe6bwVxLSlgDvR+5DGQaGEx+FgyXoja6B59ycRGpHQUsLWYVMU8u
	wh9Yd6Mb1PFHbPemBOo8lXR7HZQDvlQa4cPvl/fQLKEAzaazPlQB6InEya2+p12pseSTwd/j8fo
	A4xrXmBFkadV0Y0fpZr7m2QxTLpxnthAz8rx6kcgsDMurrKcm97O97ZJ0Xo/HBJ6IJGVDrhfBkr
	lRADOZmm7vUipWo8l1E=
X-Google-Smtp-Source: AGHT+IGvLi0Vi9L+OJ7SRIrHcZ/sC6Mlffs6Z6HHzv/IgRwyJcIWLK5MakJyGmFrnokUQyGDt0+M1A==
X-Received: by 2002:a05:6214:2481:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6e46f18da31mr47019176d6.9.1739367741469;
        Wed, 12 Feb 2025 05:42:21 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44087b4afsm74860386d6.19.2025.02.12.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 05:42:21 -0800 (PST)
Message-ID: <69874369-495c-4698-af1f-502d21371f7d@gmail.com>
Date: Wed, 12 Feb 2025 05:42:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT] brcmfmac: Fix structure size for WPA3 external SAE
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 KeithG <ys3al35l@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ting-Ying Li <tingying.li@cypress.com>,
 Ting-Ying Li <tingying.li@infineon.com>
References: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <20241215120401.238320-1-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20241215120401.238320-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arend,

On 12/15/24 4:04 AM, Arend van Spriel wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
>
> Add pmkid parameter in "brcmf_auth_req_status_le" structure to
> align the buffer size defined in firmware "wl_auth_req_status"
> structure.
>
> Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
> [arend: adapted path to apply to per-vendor variant]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> index 18129adb5dc2..1cbe66526d82 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> @@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
>   	u8 peer_mac[ETH_ALEN];
>   	__le32 ssid_len;
>   	u8 ssid[IEEE80211_MAX_SSID_LEN];
> +	u8 pmkid[WLAN_PMKID_LEN];
>   };
>   
>   /**
>
> base-commit: 1cac3bd863bef434d43e6b0554ac5d7f7f6350fe
> prerequisite-patch-id: d5b3eb93d54bd6a0508a91f4627ec3e59a810928
> prerequisite-patch-id: 653281e1349a038c7f48b3513243f3211fffab9e
> prerequisite-patch-id: 0e47ab711ef159237e20c860834d3ac269b05eb2

I've tested this and can also confirm it does fix external auth on 
brcmfmac. I adapted it to work with the upstream 6.6 raspi kernel and 
had no issues using IWD + external auth to connect to a WPA3 network. Is 
this something that can be upstreamed?

This is the firmware I'm using (no changes to the default raspi distro):

Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 
CY) FWID 01-b677b91b

Thanks,

James


