Return-Path: <linux-wireless+bounces-12922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D697B302
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842981F2287C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23396183CB2;
	Tue, 17 Sep 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfpwKYjf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925715B54F;
	Tue, 17 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590662; cv=none; b=Sp7wpdsrHKGmkqiVp9KvUGZQIyLLtwG+jd86LA2Zt8uAPBDqXoQ1ib1Za9Jq868Ugx3G3EAFnpM2gFNCan64LW8Lk9GIie+zBA7PS0iO3PPJXpjuv/gJhGqLiJ67b9FKEMDaUo+NYXfEF2hDYjUzDfPNIx5GVCTFNSE8EYZTsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590662; c=relaxed/simple;
	bh=T0xCbAguwVe8L3zNEYirqsW01OcDvzdTUFRziwZJH14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1y0qApsmnR7GYxLJ62xS2BFMdPuz/9thqcoK0jtkkTZkMVR6uQgVj5rNSIcCaAlH3RV5eCkw3NFZ7cgw85RZi54MQXed9xJer9MY4LcRAYGziOxUer98V/I1cvvc9MeBGkk+hoWQj6p7Fb2SSEkPQj2cmD0SzU+qZe5pqZMaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfpwKYjf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726590660; x=1758126660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0xCbAguwVe8L3zNEYirqsW01OcDvzdTUFRziwZJH14=;
  b=AfpwKYjf1OYofDq7wimAxxzkIMqifWp4eM08PFO1hePTRR/Vy4dWFfPZ
   ZbrbjLSFc7h4LMROKD6qfANCUtTBESuqpCR9GrJomtuYchZjhGaxY+ARq
   8eig0tHfW5kp8DMLOEfzHsDAMPctwQYRmbyRWsODY4AIMNq7diT/5wV3P
   ZLDudCELNdiPjIZulcXPKqLFzGjQaq/m40g+pSH00oUwYuMaagWSp5F12
   6lEOR2kI9LWssgrHTgRzDpT7jVB2fHTSA8cpm1PkcwB5s8DnCxRyIJOzN
   tW5+cO2Qh2C7AUaXq2xl19QJg3j43RISdMJ9bH/tb1CTdDcv/Bl8cXLku
   A==;
X-CSE-ConnectionGUID: n3gVHtPtTCWKuk6x/aVRKQ==
X-CSE-MsgGUID: rZEsyTyTS5CdBlNilUfDXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="13560061"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="13560061"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 09:30:59 -0700
X-CSE-ConnectionGUID: ahD0hZrcQO2ez3iJtGdOiw==
X-CSE-MsgGUID: aW6W1bJsQNupTu5l7O00Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69114330"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 09:30:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqb6L-00000009sna-1A5j;
	Tue, 17 Sep 2024 19:30:53 +0300
Date: Tue, 17 Sep 2024 19:30:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sascha Hauer <s.hauer@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix memcpy() field-spanning write warning
 in mwifiex_config_scan()
Message-ID: <ZumuvP3aHiHHzGjp@smile.fi.intel.com>
References: <20240917150938.843879-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917150938.843879-1-alpernebiyasak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 17, 2024 at 06:08:41PM +0300, Alper Nebi Yasak wrote:
> Replace one-element array with a flexible-array member in `struct
> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
> on a MT8173 Chromebook (mt8173-elm-hana):
> 
> [  356.775250] ------------[ cut here ]------------
> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
> 
> The "(size 6)" above is exactly the length of the SSID of the network
> this device was connected to. The source of the warning looks like:
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
>     [...]
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> Also adjust a #define that uses sizeof() on this struct to keep the
> value same as before.

...

>  #define WILDCARD_SSID_TLV_MAX_SIZE  \
>  	(MWIFIEX_MAX_SSID_LIST_LENGTH *					\
>  		(sizeof(struct mwifiex_ie_types_wildcard_ssid_params)	\
> -			+ IEEE80211_MAX_SSID_LEN))
> +			+ IEEE80211_MAX_SSID_LEN + 1))
>  

This hunk has to be carefully checked by wireless people. I'm not sure
that we need  + 1 here.

Otherwise, LGTM.

-- 
With Best Regards,
Andy Shevchenko



