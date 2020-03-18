Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE218A722
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRVer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 17:34:47 -0400
Received: from the.earth.li ([93.93.131.124]:53762 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgCRVer (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 17:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=e25JK8fF5LtigMkLxNmEl1NMJCMEEzOfon65uy5ebKo=; b=EJ8sWMyAqK3JiWpt32gK+tQe6l
        K7pWKz/vLwaJ+atlzwzkjW3acoVp9N/BMk1q4kkY9xcPwIfX5hqaULKjmAqZTjf8wqi3i3RIJIwlw
        1doUMpMWJUZSDp4Uq7SkHRQ7Zavm1DazOgLe+wllKtNtbCj6RJAfCQgcYZnUcQYgyJJ6DXQ7Vj93Y
        4uchqcaTFc9cuxLLU5ZfUqOXFj1/IQ8njiybn43HnrB1ZwpK/sKd1gTHjfpdc8U2uZDZcDUdSoR3U
        CKMwmaPEkuy2DquR6LUVEGaZUQOopeJqKxX2AsoCjp+9aZ7A3Zet5csfJ6bJM23YDnGc3yYpjE6/8
        7no2dEIw==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1jEgKm-0006TI-Ab; Wed, 18 Mar 2020 21:34:40 +0000
Date:   Wed, 18 Mar 2020 21:34:40 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds
 table
Message-ID: <20200318213440.GO311@earth.li>
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 18, 2020 at 08:12:54AM +0200, Luca Coelho wrote:
> From: Golan Ben Ami <golan.ben.ami@intel.com>
> 
> The GEO_TX_POWER_LIMIT command was sent although
> there is no wgds table, so the fw got wrong SAR values
> from the driver.
> 
> Fix this by avoiding sending the command if no wgds
> tables are available.
> 
> Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
> Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Thanks Luca.

Works for me on an AC 3168 with firmware 29.1044073957.0

Tested-By: Jonathan McDowell <noodles@earth.li>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206395
Cc: stable@vger.kernel.org # 5.5.10+

> ---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 14 ++++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 14 ++++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  9 ++++++++-
>  3 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> index 48d375a86d86..ba2aff3af0fe 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> @@ -6,7 +6,7 @@
>   * GPL LICENSE SUMMARY
>   *
>   * Copyright(c) 2017        Intel Deutschland GmbH
> - * Copyright (C) 2019 Intel Corporation
> + * Copyright (C) 2019 - 2020 Intel Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of version 2 of the GNU General Public License as
> @@ -27,7 +27,7 @@
>   * BSD LICENSE
>   *
>   * Copyright(c) 2017        Intel Deutschland GmbH
> - * Copyright (C) 2019 Intel Corporation
> + * Copyright (C) 2019 - 2020 Intel Corporation
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -491,13 +491,13 @@ int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
>  }
>  IWL_EXPORT_SYMBOL(iwl_validate_sar_geo_profile);
>  
> -void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> -		      struct iwl_per_chain_offset_group *table)
> +int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> +		     struct iwl_per_chain_offset_group *table)
>  {
>  	int ret, i, j;
>  
>  	if (!iwl_sar_geo_support(fwrt))
> -		return;
> +		return -EOPNOTSUPP;
>  
>  	ret = iwl_sar_get_wgds_table(fwrt);
>  	if (ret < 0) {
> @@ -505,7 +505,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
>  				"Geo SAR BIOS table invalid or unavailable. (%d)\n",
>  				ret);
>  		/* we don't fail if the table is not available */
> -		return;
> +		return -ENOENT;
>  	}
>  
>  	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
> @@ -530,5 +530,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
>  					i, j, value[1], value[2], value[0]);
>  		}
>  	}
> +
> +	return 0;
>  }
>  IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> index 4a6e8262974b..5590e5cc8fbb 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
> @@ -6,7 +6,7 @@
>   * GPL LICENSE SUMMARY
>   *
>   * Copyright(c) 2017        Intel Deutschland GmbH
> - * Copyright(c) 2018 - 2019        Intel Corporation
> + * Copyright(c) 2018 - 2020        Intel Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of version 2 of the GNU General Public License as
> @@ -27,7 +27,7 @@
>   * BSD LICENSE
>   *
>   * Copyright(c) 2017        Intel Deutschland GmbH
> - * Copyright(c) 2018 - 2019       Intel Corporation
> + * Copyright(c) 2018 - 2020       Intel Corporation
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -171,8 +171,9 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
>  int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
>  				 struct iwl_host_cmd *cmd);
>  
> -void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> -		      struct iwl_per_chain_offset_group *table);
> +int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> +		     struct iwl_per_chain_offset_group *table);
> +
>  #else /* CONFIG_ACPI */
>  
>  static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
> @@ -243,9 +244,10 @@ static inline int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
>  	return -ENOENT;
>  }
>  
> -static inline void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> -				    struct iwl_per_chain_offset_group *table)
> +static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
> +				   struct iwl_per_chain_offset_group *table)
>  {
> +	return -ENOENT;
>  }
>  
>  #endif /* CONFIG_ACPI */
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 54c094e88474..98263cd37944 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -762,10 +762,17 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
>  	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
>  	union geo_tx_power_profiles_cmd cmd;
>  	u16 len;
> +	int ret;
>  
>  	cmd.geo_cmd.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
>  
> -	iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
> +	ret = iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
> +	/*
> +	 * It is a valid scenario to not support SAR, or miss wgds table,
> +	 * but in that case there is no need to send the command.
> +	 */
> +	if (ret)
> +		return 0;
>  
>  	cmd.geo_cmd.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
>  
> -- 
> 2.25.1
> 

J.

-- 
     I don't know. I'm a dog.      |  .''`.  Debian GNU/Linux Developer
                                   | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.
