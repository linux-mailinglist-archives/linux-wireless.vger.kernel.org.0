Return-Path: <linux-wireless+bounces-17568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD3A12BBC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 20:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C87F3A1F20
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93D196D9D;
	Wed, 15 Jan 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nc65NtcD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7819343B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969436; cv=none; b=H4HcLTcaxTB/Co2pAbIAdSboAPht7VFOie0m8UP+uot2/o9yE/WtuTfb+aasisetKh0DHbH1wnPWosVk4PG/C3ftmbHJUDevlNxBogmkj7d2OgWJzBS6B/UFgG1IvMGltTsJDx+pLDEITR1ooHIyX4zSnxdzTv4CnV6zhE34Jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969436; c=relaxed/simple;
	bh=MbiPS+cI03BZu7Fkiw4/2txsbVyc1HhRx2VoO4aUgzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2p0liydW3nkpi4GnBghc+OCIgPvOfjKiF2ftlt9+sDKcw/SPBoxP8KewIAI86gBh84JhPwSiJo5riT8zNYgNkNViMgVmyKNikKn7rDBnFjhUMCuQ6J9t0k3OtH6aFGJkO2TEc545y1JJQPMJzw3XBwxJTejw3bxyhFAtYUWjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nc65NtcD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54263b52b5aso179531e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736969432; x=1737574232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74XkFS9DzZ2OkyiCSpmU2WovRKw4oJ8QjJazyagugLE=;
        b=nc65NtcDfstiDT3gC0Ajpg2cwj3be4W8UfGkdqvVCjeF1IROLk5kgZXU+Cfr8IHsFB
         T3MhzGkxZXYXl1sUd7n1YrhFS5JIO3z6WUXOMdp6CRy0XKjIcd6a4JLLUQHMNCzJ/ZC+
         oJ62tq5Niagp7G4vvdNCY3nAhexpWy1pmKY+OC9VKS6ONMIrP5qHE26jXQkV86/NB2EE
         m0v3w7u4oMiOhrUWEi+4Fs2o2mujGclaHi6NqjUfEPqBb2eDtxla/2gA5aSavXkSvrL5
         BSSnnm9dkJkXqp1KZ5tA+M7YNQ6ntzFPhm8e83ySlBRtZ+kPYDkjTxrDuQfo4NusI68M
         ZKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736969432; x=1737574232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74XkFS9DzZ2OkyiCSpmU2WovRKw4oJ8QjJazyagugLE=;
        b=KH6cGLL2BZKOwJkWc4sWx+GNWxQw9Z+7EaprceBXJs1TuhU6fpIxn+D3/+GuMEg3dz
         1rI9raHDxi0RXCuQm2IRJc8/zEdbsFyp7mnMsU8uui3POzRg1FQeurUM1GTTsgPstloU
         hFuTlx7qxZv/kKBxQTMEe6wTY6catBm69xePbvxox5oMdcMp4vaHoQqQU0CFqiKCT8Jp
         Vc0087q/cacP7fhJmYwRBSqaXZBivX5DsabLf1Tn2AVt1GwcotAdum1TbYbJJCsOYDOM
         I/yljSYe66J5PskaTiwUaXk/wYC2nRSz5+BRRhUjcRKmMtoL4zuwQq/Q376qGbhwdJJ9
         oKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JYKYGAMTCrN5/Eq7vOzJEXXmQ351ixlMOGk9YMRWUSYHGFzMAgcuzxGgz+nh+tMjC2PdcBrbTW7VRL9H0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwHJbdAhMnMkDF4242OFg/hLS66F8594JK3hTmIbqX7BEbcTI
	W9N9jik4p4LbrOLY8MyTz55VizGFe7IEsruRBqIvSJ32nhZkk/SqlF2CRqZ2cP8=
X-Gm-Gg: ASbGncu2JcUBOkkDfRYKptw2zZ5cXh0dp5fFUB5+RTUiQvI+jSOznGDRQedVnu+5Ikr
	IVgq58qLFm97QgkCYXm9rDgPfAcP2oxdxYJzarurOIdNPzZCUPIieCHkFC7Dr8FWFBWhSfbKooH
	mzaS05ntlJa0DU86M3l+sV2Oe77UZs8bioL4acPxU1tRG0R5EJ4Ar9ULQQ53VTbgxtF3onQsygj
	/xmjuBp1Vu8WqaVMOuLDbEFRWaZZvxMb/oScr4wZNmaSP5B0cj/XLtTiI6MDBu94tfIsLsx6J8o
	9ANLMmWUFxi1i+lbC4tqOJJq0R2UdaeSSMM7
X-Google-Smtp-Source: AGHT+IGS0gsniHAb1265t2ZInspYgL6rWfoxkSpJFSOe+oC2DXSzdeDmFJAzWdYH+4C429519LL8Aw==
X-Received: by 2002:a05:6512:1188:b0:540:1a0c:9bac with SMTP id 2adb3069b0e04-542845d61d7mr10774580e87.34.1736969432101;
        Wed, 15 Jan 2025 11:30:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be54154sm2133263e87.68.2025.01.15.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 11:30:30 -0800 (PST)
Date: Wed, 15 Jan 2025 21:30:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ajay.Kathat@microchip.com
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org, alexis.lothore@bootlin.com, marex@denx.de, 
	Sripad.Balwadgi@microchip.com
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Message-ID: <ismsffcidddb3dqr54mdhzsxrwpqfvsauq77fmuzsekhnxyeb6@3imjhwdg34fx>
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115171751.7308-1-ajay.kathat@microchip.com>

On Wed, Jan 15, 2025 at 05:18:49PM +0000, Ajay.Kathat@microchip.com wrote:
> This commit adds WLAN firmware for wilc3000 which is supported in mainline
> Linux with commit [1].
> 
> FW version: 16.1.2
> 
> 1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/microchip/wilc1000?id=e1408c115ef9b
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  WHENCE                             |   5 +++--
>  atmel/wilc3000_wifi_firmware-1.bin | Bin 0 -> 140712 bytes
>  2 files changed, 3 insertions(+), 2 deletions(-)
>  create mode 100644 atmel/wilc3000_wifi_firmware-1.bin
> 
> diff --git a/WHENCE b/WHENCE
> index 920d6093..3842bed7 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -5712,14 +5712,15 @@ Licence: Redistributable. See LICENCE.nvidia for details
>  
>  --------------------------------------------------------------------------
>  
> -Driver: wilc1000 - Atmel 802.11n WLAN driver for WILC1000
> +Driver: wilc1000 - Atmel 802.11n WLAN driver for WILC1000 & WILC3000
>  
>  File: atmel/wilc1000_fw.bin
>  File: atmel/wilc1000_ap_fw.bin
>  File: atmel/wilc1000_p2p_fw.bin
>  File: atmel/wilc1000_wifi_firmware.bin
>  File: atmel/wilc1000_wifi_firmware-1.bin
> -Version: 16.0

Why? You haven't updated old firmware, so it should still be 16.0

> +File: atmel/wilc3000_wifi_firmware-1.bin
> +Version: 16.1.2
>  
>  License: Redistributable. See LICENSE.atmel for details
>  

-- 
With best wishes
Dmitry

