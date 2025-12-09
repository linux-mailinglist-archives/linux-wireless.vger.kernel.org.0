Return-Path: <linux-wireless+bounces-29620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02210CAF44D
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DE59300F66B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BD22258C;
	Tue,  9 Dec 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CALZj6aC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75015746E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268456; cv=none; b=Ajt5y9dGJNJGlIBFStwqC5YnEii15kZrLE76PjYGRIoqGaRJVuJs9WBMdjed/UiSVTgvyPsj5to4Ewdjyrjd7oc84V/gopITOrY8iZgh7MN4Fu/1bcAqlRjvd9wHHEUyPQGjQGVRfxkHEfIubk3MaaxY6qvj7WG3G+8BeaHx88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268456; c=relaxed/simple;
	bh=7ybXvfS3C6+TXKSHojIqG148WgZUe+c95r/+2ZkE5tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un+LNw+jPlEWSguswex2CBEsnL5BsHJvtTYEUWfNy14pLH0GgStaGwAm7jqFPpnXe83QxfZC9KemhH/FoOr3hfEN4FBfTSu19bkiUZOtlyaKd+qsI1WZiZf0O/jQANdfzV6hxc2Zen/hflsjHgfSOhgyuYFRSvrtPQIo3878Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CALZj6aC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765268455; x=1796804455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7ybXvfS3C6+TXKSHojIqG148WgZUe+c95r/+2ZkE5tE=;
  b=CALZj6aCN1eMoFTt01Kdvq61ggDZCtQAZzN+Nm3pCpfc4F9+DOd44Z6R
   d7i8/aLE+cGXGBouTG2fv//MGsWG/VSHercIB31hwfPk+IMxf1KY47RwL
   wfmsBp1Nm8r40EeCCXWNbdli8dq2Ax/+EHBVocZT14Hwydqd+1zXIWf+x
   UpV1kkjVcGW+ZcIGHJnnpzD4kiIgzNH13L6JLEQekBafkbfn6BzBBDr+N
   VlNqSPGMT1nHw279+h9p+GDw3WYBNxIxFcJ+ZrrC672T1RrtsNknAnJTr
   7j8zcndoOYA4e7s9n411lmK299YZh23chIf1GOuWYJ0yUgZhuadNRqJpz
   Q==;
X-CSE-ConnectionGUID: wMxfVFbhSPugAAEu8tm1YQ==
X-CSE-MsgGUID: I3ydbUHvQlCaS4cwoxwdrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="78336727"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="78336727"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 00:20:55 -0800
X-CSE-ConnectionGUID: OtI6qai1S+Kk63VTq28XCA==
X-CSE-MsgGUID: gsu6d9G6QmWPZAP54f9IPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="201277801"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 00:20:54 -0800
Date: Tue, 9 Dec 2025 10:20:50 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: Fix firmware version handling
Message-ID: <aTfb4sRxlIVE9jB1@intel.com>
References: <20251113222852.15896-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113222852.15896-1-ville.syrjala@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 14, 2025 at 12:28:52AM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> On my system the arithmetic done on the firmware numbers
> results in a negative number, but since the types are
> unsigned it gets interpreted as a large positive number.
> 
> The end result is that the firmware gets rejected and wifi
> is defunct.
> 
> Switch to signed types to handle this case correctly.
> 
> iwlwifi 0000:0c:00.0: Driver unable to support your firmware API. Driver supports FW core 4294967294..2, firmware is 2.
> iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-4.ucode failed with error -2
> iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-3.ucode failed with error -2
> iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-2.ucode failed with error -2
> iwlwifi 0000:0c:00.0: Direct firmware load for iwlwifi-5000-1.ucode failed with error -2
> iwlwifi 0000:0c:00.0: no suitable firmware found!
> iwlwifi 0000:0c:00.0: minimum version required: iwlwifi-5000-1
> iwlwifi 0000:0c:00.0: maximum version supported: iwlwifi-5000-5
> iwlwifi 0000:0c:00.0: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> 
> Cc: linux-wireless@vger.kernel.org
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Fixes: 5f708cccde9d ("wifi: iwlwifi: add a new FW file numbering scheme")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

This regression is now in 6.18.

Cc: stable@vger.kernel.org

> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> index 607fcea6f4ef..0f002ef261fc 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> @@ -1599,7 +1599,7 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
>   */
>  static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
>  {
> -	unsigned int min_core, max_core, loaded_core;
> +	int min_core, max_core, loaded_core;
>  	struct iwl_drv *drv = context;
>  	struct iwl_fw *fw = &drv->fw;
>  	const struct iwl_ucode_header *ucode;
> @@ -1678,7 +1678,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
>  	if (loaded_core < min_core || loaded_core > max_core) {
>  		IWL_ERR(drv,
>  			"Driver unable to support your firmware API. "
> -			"Driver supports FW core %u..%u, firmware is %u.\n",
> +			"Driver supports FW core %d..%d, firmware is %d.\n",
>  			min_core, max_core, loaded_core);
>  		goto try_again;
>  	}
> -- 
> 2.49.1

-- 
Ville Syrjälä
Intel

