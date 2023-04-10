Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95C6DC94C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDJQ23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDJQ2R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 12:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B67184
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 09:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD7BE60FF9
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 16:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04833C433EF;
        Mon, 10 Apr 2023 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681144096;
        bh=ONDMXYVLseUOmNf1DtjPRcvusrOIHPyOQzISf4oCBEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzcApbIOXsgBaF6Kf0skEntuwNs4rU6pDh3WwW9evfYLtA6EDdwoJaIUblj0lOXqU
         SUiMnsvHnno/kevjjXBOmGLmrNOGPFzypKtvpL3gP+wdxQIvVm/zskr5yWoM/NhHfl
         dhyaU7DmzTzrlCnkftZVx+TocEqD93t7GLfNYd5kTeHWA1Fm+GgNx0qivPFp0TUUmQ
         crEL0i7AIK51hBiTmFP93F0gUWcpjitnEqtbWH9efC0B/NnnsJRHqgMYpx0CqOJkGw
         IsL2bC4sJAtm2F/EUqPa/rA9kzHpSWKPLRlnCuTxWrOeRe7eBX3vACGHIdGiLwC7nh
         QN0r3Qj+nqbZw==
Date:   Mon, 10 Apr 2023 09:28:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: iwlwifi: mvm: fix the order of
 TIMING_MEASUREMENT notifications
Message-ID: <20230410162814.GA2775@dev-arch.thelio-3990X>
References: <20230410140721.897683-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410140721.897683-1-gregory.greenman@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 10, 2023 at 05:07:20PM +0300, gregory.greenman@intel.com wrote:
> From: Gregory Greenman <gregory.greenman@intel.com>
> 
> Host commands and notifications are expected to be ordered in
> iwl_mvm_groups array. Fix the order of two new TIMING_MEASUREMENT
> notifications.
> 
> Fixes: c7eca79def44 ("wifi: iwlwifi: mvm: report hardware timestamps in RX/TX status")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/linux-wireless/20230331175121.GA3127046@dev-arch.thelio-3990X/
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>

Thanks for the quick fix! It appears to work for me.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> index 56a4e9d6ae33..6f082059025a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> @@ -472,8 +472,8 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
>  	HCMD_NAME(SCAN_OFFLOAD_PROFILES_QUERY_CMD),
>  	HCMD_NAME(BT_COEX_UPDATE_REDUCED_TXP),
>  	HCMD_NAME(BT_COEX_CI),
> -	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
>  	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION),
> +	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
>  	HCMD_NAME(PHY_CONFIGURATION_CMD),
>  	HCMD_NAME(CALIB_RES_NOTIF_PHY_DB),
>  	HCMD_NAME(PHY_DB_CMD),
> -- 
> 2.38.1
> 
