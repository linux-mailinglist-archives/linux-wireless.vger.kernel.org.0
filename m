Return-Path: <linux-wireless+bounces-3253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91E84BCEE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 19:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292F51F25556
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573513AC9;
	Tue,  6 Feb 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPRniyjf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BD13AC6
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244190; cv=none; b=hpy1i6eUHt+Yniasen8h4AQLnGIneRFfX57gXOIDNz6lcYtP5KT7imWsqd/O5DBrsh3dmgXeMKoM1UCXqh3LWDK+t3u8krEAT9GHBTWk96M1BKuaZl6WgZtLIaVPJiUEhuzEWhJhK1xN90wgGh6oQgIuga06fchrdfMbalkHjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244190; c=relaxed/simple;
	bh=BUOquwLWLt01wMe0RZawNAn/DoGoKckY8/5pT4ZGko0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/ZTyBLLYPyyX+fx1W3j8l9W57BGAWauBq4q3Hctiaq0gbzk1JtZs5PUm41Ht4Iqsoeq+9BkAxFi3Nx0CPcNC1uiso3duBDKOrvsRYSqT/cokuqa2ydq7hRm3QmYQKFQMgBBCgfTt7Ow5bNYCAjDSKE86SVoDIHESUL9W5ru4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kPRniyjf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d91397bd22so9651855ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707244188; x=1707848988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHuc2cs/yJLVP6ISElunRDTShvSYh7RoYJQ5lUhlcmw=;
        b=kPRniyjf8RSdGksHzpAFU4C3Nb5olzH+eDLUQq2N28pwkCDOcFi1iFN+xX0LT/FkJb
         R5zl6a5KtVLnoTBQmqRyi2AapZJ7c34vDKG3uFSFPvVrY1ASNRn8bXROcoe5VsRmYD0y
         0gccxmVKaf6wvNJbIaZVjdiqvdE4DA9eDzRD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244188; x=1707848988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHuc2cs/yJLVP6ISElunRDTShvSYh7RoYJQ5lUhlcmw=;
        b=E4b34BRW6Evdz15xiNur+wdSCU3hmdBKavQSXS9mQpla+1tS3/QGlZxdfDhLqEPDeq
         NlPtlqPq9omnVlF3/VOUUEYBf1T2IipJAOZe1yri6j+9ebNYjNuE2fYndVK4gcmj5W+j
         FzzKfZCMApyrVMgA6WT7O/RRMrfPAU5d7iwi8hcASwe3dULEDZk6mys8H7mB9XUMJeV9
         PUFVq0rBBMfEuPtEmqp2EaV4hlp8X1gQnzZ/v0k5PsrFbYXJN45EX+u/ZtIr4rTvT4b4
         njjRq8/3G4xDzZlYPTR00kqhl8TkSgnlC2dyIPww5zbvPZVQnRlVkgiCwQ4SKSZUrOtx
         d62w==
X-Gm-Message-State: AOJu0Yz+nmifiOrfpilGDnAnFudoyR8eiyQOnk8+NzIvxAK+j1zvQL6q
	Gbfi0fLs32jgE2scB3dAqUvepYySzQuHuiuuvs2i7neSHRf8vMxBrgn8t6CoUA==
X-Google-Smtp-Source: AGHT+IFCKBN5hGzEzxMLXw8xy0PgG9ZqC85fvG/hg0KhV/yQZx8KiRUuobiEhsXw/ffASJ1QYzaHiw==
X-Received: by 2002:a17:902:eb86:b0:1d9:42fa:c238 with SMTP id q6-20020a170902eb8600b001d942fac238mr2729938plg.14.1707244187881;
        Tue, 06 Feb 2024 10:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtW5PU9sKMsQ2i9tSdfSv+ivEGaZFD0UvIbwgqb3ZrNtOEq/svazi5KAyocpsJlee+xBDl+9VuyAVyBkDaYV+JlRYt2iE+CVjYuWIhUeGskpU5FMB+ukWL1p6ec6okzsL2IZHMIdp25fmGxrkR6dFN5hAChXaybJjbSMbODSjOIt/efu/fH9ULrc7LSXK34pF9FNdoJ9w0lfF4+d65c4AYo3asd0HaMwBKfVWIyIzGoczW7BcKw6CFFp5k0A0PDECvffvHns8xKkCxLdRZDBEFssC0UtgS4rWJVX2z3jqJIetODbxUfDH4Wh9jXz+jSym+jIapQlVjbFHGQiL+v5j4KOkXgkPeJgSkZZaI+UITd5BU9jX4jVVLgRKAz9a6Ro4BTpM038n+opkhe6LKoyRfpA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001d7439bf914sm2193952plb.235.2024.02.06.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:29:47 -0800 (PST)
Date: Tue, 6 Feb 2024 10:29:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	zuoqilin <zuoqilin@yulong.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Refactor 1-element array into flexible
 array in struct mwifiex_ie_types_chan_list_param_set
Message-ID: <202402061029.F0937444B2@keescook>
References: <20240206163501.work.158-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206163501.work.158-kees@kernel.org>

Apologies -- this patch is incomplete. My "git add" failed me. ;) I'll
send a v2!

-Kees


On Tue, Feb 06, 2024 at 08:35:04AM -0800, Kees Cook wrote:
> struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
> as a flexible array, so convert it into one so that it doesn't trip the
> array bounds sanitizer[1]. The code was already calculating sizes by not
> including the trailing single element, so no sizeof() change are needed.
> 
> Link: https://github.com/KSPP/linux/issues/51 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: zuoqilin <zuoqilin@yulong.com>
> Cc: Ruan Jinjie <ruanjinjie@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
> index a2ddac363b10..0326b121747c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/scan.c
> +++ b/drivers/net/wireless/marvell/mwifiex/scan.c
> @@ -664,15 +664,14 @@ mwifiex_scan_channel_list(struct mwifiex_private *priv,
>  
>  			/* Copy the current channel TLV to the command being
>  			   prepared */
> -			memcpy(chan_tlv_out->chan_scan_param + tlv_idx,
> +			memcpy(&chan_tlv_out->chan_scan_param[tlv_idx],
>  			       tmp_chan_list,
> -			       sizeof(chan_tlv_out->chan_scan_param));
> +			       sizeof(*chan_tlv_out->chan_scan_param));
>  
>  			/* Increment the TLV header length by the size
>  			   appended */
>  			le16_unaligned_add_cpu(&chan_tlv_out->header.len,
> -					       sizeof(
> -						chan_tlv_out->chan_scan_param));
> +					       sizeof(*chan_tlv_out->chan_scan_param));
>  
>  			/*
>  			 * The tlv buffer length is set to the number of bytes
> @@ -2369,12 +2368,11 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
>  		     chan_idx < MWIFIEX_BG_SCAN_CHAN_MAX &&
>  		     bgscan_cfg_in->chan_list[chan_idx].chan_number;
>  		     chan_idx++) {
> -			temp_chan = chan_list_tlv->chan_scan_param + chan_idx;
> +			temp_chan = &chan_list_tlv->chan_scan_param[chan_idx];
>  
>  			/* Increment the TLV header length by size appended */
>  			le16_unaligned_add_cpu(&chan_list_tlv->header.len,
> -					       sizeof(
> -					       chan_list_tlv->chan_scan_param));
> +					       sizeof(*chan_list_tlv->chan_scan_param));
>  
>  			temp_chan->chan_number =
>  				bgscan_cfg_in->chan_list[chan_idx].chan_number;
> @@ -2413,7 +2411,7 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
>  							   chan_scan_param);
>  		le16_unaligned_add_cpu(&chan_list_tlv->header.len,
>  				       chan_num *
> -			     sizeof(chan_list_tlv->chan_scan_param[0]));
> +			     sizeof(*chan_list_tlv->chan_scan_param));
>  	}
>  
>  	tlv_pos += (sizeof(chan_list_tlv->header)
> -- 
> 2.34.1
> 

-- 
Kees Cook

