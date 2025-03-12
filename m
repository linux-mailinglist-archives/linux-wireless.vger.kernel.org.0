Return-Path: <linux-wireless+bounces-20250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C7A5E03F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E406116D8A8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B81D5CFB;
	Wed, 12 Mar 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJLSYGBx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1415539A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793105; cv=none; b=KthMepeyDxWoX0Z7823P3A9QRnoZAxUbqeix0E/W7qWMcmXixm+4hOcEejknoex2pWWiMM4XM9bSsQTT3yVDg/aGaevgUxLB9by/fiDriYTC89YTDUvmFEwmrAxV5PhMCt2tGtcYMZuJNc94G5OJ2Nl6Z3cmYE3VrY5f9ocZ0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793105; c=relaxed/simple;
	bh=Emp6Z3aIQvwk7fgn4fyq/ADmvkKqA6pgqsXlO4s06/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m79tzAulbk3lJnQxO5hl2edJWKUK3mTA5dAOapGlTNbbfr1HfuDVhULWRkOSdjZu5l612MicDElaFoQqa7dDDBAAFMREXCWCVPU9s3GZVk7lfqBDF5FEqFYfTHRPr2vUohwW2AFsdyhkbrlsOqWcpVRXmVuMIp2SVIj7tJ6CDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJLSYGBx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390fdaf2897so6384918f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741793102; x=1742397902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLzKPMExXtwTBCfsr8dbxK/LiBLIFtL0pBVuR4STJfg=;
        b=EJLSYGBxA0Gl6eQ60LDZb/afzU9576enjDJ6bpfkzzd/V1MPVl+Zj4k97gZw398DUo
         h+mo/0/QqIdOXXQvXs2n450nr5KuUwsKL10AGQ6fLuxWgNQrpPBYPjAk3FEHI4BYkZow
         RdgkPh1rMrEWCmdnbGjmy+AXhzU9DFUNYAQJcbHRicdHEppoGnwJx6DJAXaMIsxrlTuX
         xvR3yQDPGaW4nOJjj1H6ejwMJV3lCczXVW0A3z2O05UUr977Ryltld26jwmjdMY+okdd
         IlEv42cQ5dcenJSrY4CrfhQEX4wyMlFqmi8hqMyGZRI8fhwCk74/DoKiBAE9kwYi2L3f
         ChtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793102; x=1742397902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLzKPMExXtwTBCfsr8dbxK/LiBLIFtL0pBVuR4STJfg=;
        b=cOLTHOvzbBzH0ktys3m5mTFqPRomi/kxfBxOMDkk29XNTmK0QH2lm3TBjcS6RaP4fl
         an6qU4FXY1lBjW4+I8Ggvej4WAt2qVCmi6f77JvVarYObFYRA6aUkiWVK/KY76y/JnEP
         eoyNZ81zIG4NgEqP78ncrhUSal4fM0fbTRXG3uwZzgnMASqdvc6c1TOBoEsSUA5JrsFP
         C1odMhBiBzvq7HM588TBLI96ZfKyo2798nXIzLTf19zmfjEGWZIdeVZKjbx1X4+NFxYU
         hIri17VFad5QgokAD4MwMoKZ8axM4pb9Z+B3JCeFMzyeCdYQR2fIgOzJtXXfR+2tyiRa
         DJyg==
X-Forwarded-Encrypted: i=1; AJvYcCVXcniAAVz0FdgM56/p22cuoOmF9t0r5KacYEmJt+aU+vhW6sS6BrWGvFPJaOz5OcQUnC1+06f01OilxK2AyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZl6DQDak+aF5lvzoNxsrzU+Bn+hip8Ffjiff+kBN6JKfEMP6U
	rjnirS3v6wj+ndxyd3B+DDWb1XweGSiqUOawEYQHSzh32zoyF5kU2UE2ryNNNR0=
X-Gm-Gg: ASbGncsV3zBkM6/bEOn4lLD5NZUX4zRR0scWbSWOvJe7FXHb7aYSU0vkTYjJJr0/2Iz
	fDPLw1fAsfejXM1E3keq/mwyRvCACVerIog+w/CtvnNp3H2wiJwjksUA4m8X9TZUgZHusNgbZO+
	AswaD6P2MRY556QvrUCbkzN88AYJwrwGasHydvAUyN14lFDF9itCiED7ou1UoH2Y5GgkKTNGzKz
	0NPksJKgBoBQAdcZJGN5mhWc1O9l33vWGFDBFti1wKWtX6Nku/2Pwe0mpzdxFDZ6vL2vYNWaSvF
	5OuRyp878F6eFJ8/L4b44hSJtK5zuaIjPzbtzYD8R3I2a6CjAw==
X-Google-Smtp-Source: AGHT+IHn215KXGxBksWYO6IGqlkECpcXD3aN6+wMQCz0c2YurmIv585IQFuPkM2YCeNe5QHeih3GEA==
X-Received: by 2002:a05:6000:1849:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-39132d21141mr22108859f8f.15.1741793101874;
        Wed, 12 Mar 2025 08:25:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a8c5cbfsm23813665e9.30.2025.03.12.08.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:25:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:24:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with
 __free()
Message-ID: <341d748f-55ae-451b-983a-ca9684d265b7@stanley.mountain>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
 <a21610ae-e155-44bc-bcc5-b9b8b1c8cbd1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21610ae-e155-44bc-bcc5-b9b8b1c8cbd1@oss.qualcomm.com>

On Wed, Mar 12, 2025 at 08:15:18AM -0700, Jeff Johnson wrote:
> On 3/12/2025 1:31 AM, Dan Carpenter wrote:
> > Pointers declared with the __free(kfree) attribute need to be initialized
> > because they will be passed to kfree() on every return path.  There are
> > two return statement before the "cmd" pointer is initialized so this
> > leads to an uninitialized variable bug.
> > 
> > Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> > index c759c5c68dc0..1d4b2ad5d388 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> > @@ -556,8 +556,8 @@ iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, char *buf, size_t count,
> >  	};
> >  	struct ieee80211_vif *vif = data;
> >  	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
> > +	struct iwl_dhc_cmd *cmd __free(kfree) = NULL;
> 
> hmm, I thought the recommended convention was to define __free() pointers at
> the point of allocation. cleanup.h explicitly says:
> 
>  * Given that the "__free(...) = NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
> 

People do it either way.  I'm agnostic so long as it doesn't have bugs.

regards,
dan carpenter


