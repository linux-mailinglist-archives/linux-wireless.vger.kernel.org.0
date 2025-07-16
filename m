Return-Path: <linux-wireless+bounces-25533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EBB071BC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 11:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679217B7126
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C82F0E5E;
	Wed, 16 Jul 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hlx14o4A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FA2F1987
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658327; cv=none; b=l7vHoxGzPhYS1sizXcX6HlwZtp+q+UlNJYtk1EYPvnFvBLa/aG36vDt9vDxWjz1JXcJPwDghnBaPYA1Msll3goAeRf661MFjpF7n+DgH92VWvttnoN2IAnVwmCUJzF2rWHjgjoDO2pI1lZFLhEdiGNu/WhLXSQXezcRNWTbIgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658327; c=relaxed/simple;
	bh=KoC0Gnw4tQwX09Mh2nGi8LKThqV4C12CyHgjb/vzF98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhJtpGScDFH3BbD7YFh1Nr8DlwlWXCFoSLMAerwF3bo7Nc/Ds0WMbGqIU6xz8UhfS9q641QI6aCwuWs9czoeI4vccX9vvGMkr7+MEl49ybRBQc0vmKXPSks4GfujJnsAcBga8Y6DiCaqbd2++EbiCh2Pp8AwKhX1OANCQaaCWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hlx14o4A; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a77ffcb795so59864661cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752658324; x=1753263124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYGQ+EFxCY8Kqn3gT5PrXpdAsZ+hUnOgnFL6azab8Q0=;
        b=Hlx14o4AaAzgxNDBo/s01E5I1FwRWVVIfVz5qmvLKS0ZTW7//tVgdsYMyNQi93eTcH
         HJYYdTZqX3+LZtO1oVP2TA32YyuzTgf2fOaQ/Y7MgVgEyi7EQi9nmBeu51f5GkzG2sXz
         F4qiYl2SPLGyayiU4HGuNxm0y52HvVMcyHpgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658324; x=1753263124;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYGQ+EFxCY8Kqn3gT5PrXpdAsZ+hUnOgnFL6azab8Q0=;
        b=V4WmOpc11nRJkWbedKE36DxPSEZyC59UzEEJ2ayLp2eX8QgWIme6TlGHdQDha7O25h
         ENcKtm+4i8PmZ29VgOGbVLYISiSW70BIT2Ker/FSVXX8A6uWM/7WAE68HDb9fntwS21E
         kGmwHgnCaZSw+4KMVXwG6xevwCQaNWHMMm8VtKROgtGAaQhEUVL3M8pi5Fr5hb9eVohd
         6YoXz4YcDChf83FiFqC5ruQaFPVVFV8mpm9k3nARWfo/ALobcF6FkaLHp25FzFjJxDR6
         Eby5y3b4b0TGI6Zh696BRqwqh1XXNQk42DIdUZ7yHoXJ1DubNWBltk4m9AIEetu7pGfP
         ybvA==
X-Gm-Message-State: AOJu0YyKMeJayovZc+AhMUPv4PmZmeQth6WmnQABZajH+3dlds09CKSP
	WMNwj6rPURNCs8ZiA1WMvY7FguuwA9MBfPlde62tWnLh7Dv9zWtAddK+/okBqZHU+w==
X-Gm-Gg: ASbGncvzoLVkMg704IFrfV09xdSr5Y3vhgCLZh4LVjnxstMClLJff9iGe7NPNeZPgkF
	ePQZf2tZXVQCob4iZ7veMFZrz+vK9erbB5m3kwDls1EWbAwh/jWLS35Tvyy37MR5DIZYiS4Ml/c
	W40olJuhttUJNEIi/ztcYuZ1Hlef/vwFJSjBCsM7yzxtDbHS9KYihHyCgj3FwxEGZ1iSV+efvsy
	a/258TjqO+jAjTvAwvuXffzpoqSKT8/yymQqY0SbMosr6bpH6THgR1wvpmMPHYXS2vngZUA6wvf
	PYEW6GGZ3ymc5UAx1Klj8dcecOs+MmNmwufEa47GegFLmCOKdAEV1OnUfwS+LwbrnLUIKXpM7h3
	i7fJdyUIWFfVlMJsfMMKK5OiEzZiRRCiNCdQ6jT64QixVTW402+oc
X-Google-Smtp-Source: AGHT+IFp5F4xszFRerdbJYejB3SFipyFazjaIzmM2lu+vwPOe+RMBqGUutuRN/hMwoxSJmKwSFPD7w==
X-Received: by 2002:a05:622a:4a16:b0:4ab:63b8:32da with SMTP id d75a77b69052e-4ab90c8eb25mr35840481cf.45.1752658323928;
        Wed, 16 Jul 2025 02:32:03 -0700 (PDT)
Received: from [10.176.2.178] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab85620d80sm14469101cf.61.2025.07.16.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:32:03 -0700 (PDT)
Message-ID: <caaaa276-71fa-403a-9557-b8d3edadeb81@broadcom.com>
Date: Wed, 16 Jul 2025 11:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmsmac: Remove const from tbl_ptr parameter in
 wlc_lcnphy_common_read_table()
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, llvm@lists.linux.dev,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20250715-brcmsmac-fix-uninit-const-pointer-v1-1-16e6a51a8ef4@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250715-brcmsmac-fix-uninit-const-pointer-v1-1-16e6a51a8ef4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/2025 4:45 AM, Nathan Chancellor wrote:
> A new warning in clang [1] complains that diq_start in
> wlc_lcnphy_tx_iqlo_cal() is passed uninitialized as a const pointer to
> wlc_lcnphy_common_read_table():
> 
>    drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:2728:13: error: variable 'diq_start' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>     2728 |                                                      &diq_start, 1, 16, 69);
>          |                                                       ^~~~~~~~~
> 
> The table pointer passed to wlc_lcnphy_common_read_table() should not be
> considered constant, as wlc_phy_read_table() is ultimately going to
> update it. Remove the const qualifier from the tbl_ptr to clear up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2108
> Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

