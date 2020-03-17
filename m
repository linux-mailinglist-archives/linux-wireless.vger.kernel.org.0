Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29784187E29
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQKVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 06:21:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34442 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgCQKVi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 06:21:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jE9Lq-0003Wc-Sl; Tue, 17 Mar 2020 12:21:35 +0200
Message-ID: <88e116237ccfb75e0e37f0659448a099df2be7c2.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Jonathan McDowell <noodles@earth.li>,
        linux-wireless@vger.kernel.org
Cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        Ihab Zhaika <ihab.zhaika@intel.com>, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, linux-kernel@vger.kernel.org
Date:   Tue, 17 Mar 2020 12:21:33 +0200
In-Reply-To: <20200314105700.GM311@earth.li>
References: <20200314105700.GM311@earth.li>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] iwlwifi: mvm: Avoid use of GEO_TX_POWER_LIMIT when not
 supported
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-03-14 at 10:57 +0000, Jonathan McDowell wrote:
> Commit 39c1a9728f93 refactored the SAR table support and inadvertently
> added a call to GEO_TX_POWER_LIMIT without checking that the firmware
> supported it. This caused a regression for device + firmware
> combinations lacking the support. Add a check in iwl_mvm_sar_init to
> prevent this.
> 
> Fixes: 39c1a9728f93 (iwlwifi: refactor the SAR tables from mvm to acpi)
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206395
> Cc: stable@vger.kernel.org # 5.5
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 54c094e88474..4a8a4cb2c553 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -1007,6 +1007,13 @@ static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
>  	if (ret == -ENOENT)
>  		return 1;
>  
> +	/*
> +	 * If our firmware doesn't support GEO_TX_POWER_LIMIT then skip trying
> +	 * to use it.
> +	 */
> +	if (!iwl_sar_geo_support(&mvm->fwrt))
> +		return 1;
> +
>  	return ret;
>  }

Thanks, Jonathan! We already have an internal patch that fixes this 
(also fixes another symptom of the same bug).  I'll send it out now.

--
Cheers,
Luca.

