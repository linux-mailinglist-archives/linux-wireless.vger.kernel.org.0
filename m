Return-Path: <linux-wireless+bounces-24101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74007AD9B3E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49757AE594
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B01E104E;
	Sat, 14 Jun 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMF+PbvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D087462;
	Sat, 14 Jun 2025 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749889293; cv=none; b=uLFKwSuraSvssKd3f6d8Bf5T15QywsUH9C6ITWLbNBjO7NBGDynahTgRXfuLqTxMlzXCecNPsXcgSvSvWBVbr+c3imJl6mnxxRZL7SZP90+v/E6VYUjWZVKmFFrs4vQ/ov0V/YgEeFbZPlvInDHXq7/keLOs0rL6+kSMBOyY6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749889293; c=relaxed/simple;
	bh=YaufHfeWzU0HA/Ggs1QU36NKrWELGNq4xJuUxE8JU8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqXX2a7yIVh1b7QlhaFjTHoZX7vYUIcu7R03SgtKX8/que5eq3gu4UR8RFb4om8uQuJyYRII5mkgUNhQt7MW7cMJbeleDwpaBa503526UKRAO3ULIGPYtUrPp6mA7uA36eG63G5050bREkRrI9fEeGu8dykyVy6P1KqJtL8R6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMF+PbvL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so2446355f8f.2;
        Sat, 14 Jun 2025 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749889290; x=1750494090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khQAtLGRfdfFU200904AKJuOIJ0Mgpia0c+Uit2sjiw=;
        b=eMF+PbvLcjE1CIWWM3QvGcr7Ze7BbZOZyCSnWNPcJYu0ZtmLoLfREbcnq6vGmHjtha
         2yos5sKK7joSwpZqm4oR2Kzl7Fdk6ZpuCObed/NKBiS6wpQ9291qhYJld33TbcGPp3iv
         EzoMZVJSGDnLxIw7xPdPnPcynek5e0tCDjnkiByyQoGuSiX4+99iw8laaQOtUCv57YQm
         K0hT5CmWVsOAYaGQEXVRATqTrku6bcUtoKKLvGWaE6WhKH9DQ9iuKffcNqmz7wA7YPnu
         EdHE2nDCTj9nHwgE9zVypRX+EGtTo9r0REZSq4sJEWYfF7NXfueZ/pKI7NT1yRF8mlt/
         L1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749889290; x=1750494090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khQAtLGRfdfFU200904AKJuOIJ0Mgpia0c+Uit2sjiw=;
        b=IzV6kP4ruZJUeAvFU9+mQKt5fVz1fQuf3fpeaHbYf5L/heraTjolXMjHcljAM44jQ+
         zxQiJ/5cz1ol9eDIlVw/P1elwfh5ci2HMHOZDSAgxhCSOnV0DBuu6B/rCLmLL5VggcDZ
         kdMdIC/vBobzpe4cvo/vKmdBNfCe59jZPXmPhZ6+tHBn7hmd6dRPxd0H/eJEzLgMaRP4
         lPZnxfbCL/Cs/Zhoom8KHoqEmxvdchTk8B6F+O5jWhXiilIHWmcw9ZbFo5fy9GKWcaFt
         VIE1Pb3a/F3N9BusCHV7CJf+RXWusvboWlR8qmjcbxhzMsA2eeso8CuTvtd0O2XO66Z3
         EvWw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EtH2dXm3QMi6HFxoikAIlSuIbk4ygiCWnElWtQE/wj29k8TZbSVZl/LInWYCQ0SyJcKyP4GfRCksGNc=@vger.kernel.org, AJvYcCXa5yVnuLIyfB1SBOF9QW6dkfBuSA7Jtd0rIML2GVFeQFppSwHM2RyUwp8C8GIcEqnt4kItIbAW9N0WmQo44m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ycaJ++Q6CSFpQwpsVxZ5cEVjrOy8MrffIr2rLF9gws6b+3VQ
	37vwLeORgIz6c36fLGu07BrhzDTTJiWuuDkmx/PCpsjn30iIKIcJk2oo
X-Gm-Gg: ASbGncvatn8Rj/YRok8b21n0l7ZqMdUIzCsxqNeRcWxN6YRehKPmwTCWYRwMI1YfNIq
	mkjydO4jtZjtghg6YQJAkSjekKGzWK1UWNUreQJ9JnKX4emP2Ot4lix5HqihtHUQI72hjYCfwyp
	OxWZEfHNn/hc+6UhnvhdCzNS2UZ5jEiyIWoy3bvVAiTByNPJsUcmhz0vAFoVFMsTlA/Y3t6lW8V
	YtuDB+e655Q4lwLOyrPJRxCT61LyGK0v018wY7NDbfCDyAtvaQO9ehWYSuwgHqfYjqzE85Uz0kF
	uGV3Xz7AmoKWy+kq+d4EIU5Et0FF5NJKy/9iBz1ZoTTSmsrbQkAJOIFAvfvx5qdv/LvD+Fxk+pb
	HEC/J+uHpgi5h9xnCNVZFr3fF
X-Google-Smtp-Source: AGHT+IGXya6evQbx+npRyXK/BYu4agcTZbFXolHKNmcRHxagzN5k8f3w4llMoFQXFX24jjBzI7XlTA==
X-Received: by 2002:a05:6000:400b:b0:3a4:f2ed:217e with SMTP id ffacd0b85a97d-3a5723af786mr2391555f8f.42.1749889290096;
        Sat, 14 Jun 2025 01:21:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4cc7bsm4529830f8f.86.2025.06.14.01.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:21:29 -0700 (PDT)
Date: Sat, 14 Jun 2025 09:21:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 miriam.rachel.korenblit@intel.com, dan.carpenter@linaro.org, arnd@arndb.de,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Kernel
 Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits
 bitfield for gcc-8|9
Message-ID: <20250614092117.355e45c7@pumpkin>
In-Reply-To: <aEsrmH7sDVvsmgLs@monster>
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
	<d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>
	<aEsrmH7sDVvsmgLs@monster>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 21:33:44 +0200
Anders Roxell <anders.roxell@linaro.org> wrote:

> On 2025-06-12 17:21, Johannes Berg wrote:
> > > 
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > > index cb36baac14da..1854d071aff2 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > > @@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
> > >  
> > >  	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
> > >  	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
> > > -	control_flags |=
> > > -		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
> > > -				IWL_CTXT_INFO_RB_CB_SIZE);
> > > +	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
> > > +	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
> > > +		RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> > > +		FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
> > >   
> > 
> > The coding style is really confusing now though - what are arguments to
> > the macro and all that.  
> 
> Would it help if I indent like this?
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> index cb36baac14da..5bb81ed7db79 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> @@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
>  
>  	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
>  	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
> -	control_flags |=
> -		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
> -				IWL_CTXT_INFO_RB_CB_SIZE);
> +	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
> +	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
> +				    RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> +				    FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));

I would always indent the 'continued' part of an arithmetic expression.
Otherwise it looks (in this case) like another argument to FIELD_PREP().
(Not helped by the coding style requiring the '&' on the end of the line
rather than the start of the continuation line.)

	David


>  	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
>  	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
>  
> 
> Cheers,
> Anders
> 


