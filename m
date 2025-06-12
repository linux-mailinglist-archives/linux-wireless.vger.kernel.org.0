Return-Path: <linux-wireless+bounces-24079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E25AD7B0F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732BC3B3593
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05651F4607;
	Thu, 12 Jun 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yU+cjZyz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13012F4309
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756830; cv=none; b=bRLMMaIhhROhsEWigTssK3tVcHRZCA/bdEzNGQmT5X0P26aDzB7VKd71iMWRvRSApps7VT5Ip6mury7Vtae8DgZUMutXgQyzjquHU03PpXVC5E4y2SjlpZyx8W63Ow3OycKpXTbyRjegwWll1sSN0t4yH7MQ+gzUsdpiA8otoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756830; c=relaxed/simple;
	bh=tHNKtJGZojCVgfiRCe2QQAOxiXNgWesrIsBW6OU1mYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBkETWyj9Akfnp70v/AQHsD8YzScGOqIXMbTzu2b/7mWtSDvYrHU8/KY3J0Sm4JG5I+9ezkfwBilJrpVMeNZzypVfSxT5YAjhB6NxvXBTeXgvhRalTWmwVz55eD44/RdkT8PCdKLYKvnnsUTYXjC06ymNea5zKP885kWjKcNWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yU+cjZyz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55367f03b0fso118487e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749756827; x=1750361627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RxPpRZAeOeEdln261y+O89TUnaxHjb/5Wo9Nm9MPBo=;
        b=yU+cjZyz/lDB57ZndIfQJdvE95Mqrt4Rid6SlewWb6JWQbtjl+1vt0FY7GZzaP3Nb8
         PS2pZFSVTpnIz6CjKVH2WZ+kMQtu1pshT4sBWe8d9w56k6Mo23hD6+R+x7pxuNMZPD1z
         cMaYN7+pzm5UYPksCH7uLjJrx2AwwsZrfzf9KHDQqa04KXSmgKz7r1sgcUQqZuFZwhcD
         /LbLWhL/ZeiNSmttpTu0auTtVEX+5kuPR6bRiYxGL2mYKe6DedNl1u19SbAF43XCj4zl
         7ctrugnc9VL3pCUWUsnZJmpurTpaL+oznsMGBw/uZ4VKRJsKmciwMnQh7BM7mDrTfvYL
         RfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749756827; x=1750361627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RxPpRZAeOeEdln261y+O89TUnaxHjb/5Wo9Nm9MPBo=;
        b=Ldl6Asx0+3QAzATgyo+V8yo+I0wZ/RfEI9V8mNefWMbpL5bBLjSIVHon6KRMj0Q0FV
         e4ajTXqFVvskGiQvKBuWrpn5J4dg9oUwbkIfo/AUrIbcTNiCECosVBuqBgFdvqfpVNrK
         +oW/mrarIXdiQVwIXmeEHp4j4AIGMZTijNhw2jrxD3UAepcsxH3MFEGbTXrHINy8xPQB
         ke7qDEmOFEMnxdT4Zm9PALvPDBuhlmom/PtI1qp0pGJy3S0f6vlUzBacscnM81IVjKLb
         4WXRtn+JCa/NXhKu9u3MQ1makUkeYzxs17XO3z31uKc/+h5SN+gKFH7xyh8InzKffED3
         5OUA==
X-Forwarded-Encrypted: i=1; AJvYcCVfBx1l/H1Rf9NIxFnRMhCPsFS6B6aqIl5kIuNKWw9IXv5g3IpKk9ub/afzSF3yrUkw3Rk6C6zr1RH/O+QS8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRckxLtyur5zskHIJixIHxb8IgeWk5spTaCx8GmsBuX5lkaIaU
	dTro9pP5ZkkEnYOh9diKasjGq3IBZGKAwZY7nBl8ZYAy3qmnqxFHy4BGi14es7iF6HE=
X-Gm-Gg: ASbGncvBf33AoUdwqQGvAaIMb+cRxScDbRG3zRDjJoBQnQo1VuHq1ZbVzjruUkVrn4z
	guP2buXSI4nT0h0TnRyF1+VqutBHzsp6FdyecDh6i+dgyWrCjKXx44FbI2L6y/Ue/aFB03CMXyA
	JGQLYmDp+WNpBAP9E5ZJFaO1qGnrC/9nkf10KT6mfHgAMS5jOdO53NiSnM9CBx3qiBp3J+zwhb0
	x9o9nDgiaycxiJ7wdH4EP0ZiqgsvHX0bUqMF1vkMzs4eJhYXoAp8tPAaxqPXA04JjCQPWOSbKkD
	L1kN4huT7gVlNKu8oCKt4pZUbPz+ZgJglv/4qzd4sfw+eOB9PJXdsBW9bsWt4Pokk5X5/nBivdG
	OMjW9cCpxOs/yaB3LG4ziig==
X-Google-Smtp-Source: AGHT+IHQD/Oxp/xYFAVT+SeSQ3hxs65KexX868fUYdr9i0VayB1JjyQaBIHqK89BIcXGncJ6LOCqew==
X-Received: by 2002:a05:6512:3da6:b0:553:647a:e47a with SMTP id 2adb3069b0e04-553af9a101fmr27172e87.14.1749756826958;
        Thu, 12 Jun 2025 12:33:46 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-553ac1dbcd2sm199883e87.183.2025.06.12.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:33:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 21:33:44 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, dan.carpenter@linaro.org,
	arnd@arndb.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits
 bitfield for gcc-8|9
Message-ID: <aEsrmH7sDVvsmgLs@monster>
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
 <d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>

On 2025-06-12 17:21, Johannes Berg wrote:
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > index cb36baac14da..1854d071aff2 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
> > @@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
> >  
> >  	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
> >  	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
> > -	control_flags |=
> > -		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
> > -				IWL_CTXT_INFO_RB_CB_SIZE);
> > +	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
> > +	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
> > +		RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> > +		FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
> > 
> 
> The coding style is really confusing now though - what are arguments to
> the macro and all that.

Would it help if I indent like this?

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cb36baac14da..5bb81ed7db79 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
 	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
-	control_flags |=
-		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
-				IWL_CTXT_INFO_RB_CB_SIZE);
+	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
+	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
+				    RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
+				    FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
 	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
 	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
 

Cheers,
Anders

