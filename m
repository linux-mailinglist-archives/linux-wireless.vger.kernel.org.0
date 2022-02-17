Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DBB4BA10E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 14:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiBQNZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 08:25:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiBQNZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 08:25:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44724D224F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 05:25:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB902B8216D
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 13:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18424C340E8;
        Thu, 17 Feb 2022 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645104323;
        bh=fWtd0aIOM026OJVSrBhrOgsECAEbx8lNhZymhuMnQu8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ml8CjeuQ97JfKMfEZBpHKt+gTZjjrX5J3M/2HaqEuzwrOWuLpyuex3C4/1+ry9ktZ
         JUrQRI7+VxF70HdYikRYSW9DSIW8jBAVmcZZ+RgwEQqYPs5K87P0woUcxhYsaLKgmE
         OPidzfnv+WLzVl0pmW5BLFeSWv3KNehjZNowMXHqWJMwQ7aAQR4ZN68fBBoat7ehrL
         EnyCRyznbsm2INw1MLth2Y1UJlYuWEmYJH7w22qI/D9Qlq5skdBS6WBA5YZZgguE9a
         cNJpdiPJK/LbCyuFiC62vOtmrBM6kkJ8Jem5Bu5vsvc1xLybAR/VcZxK6nAqxBheyN
         rQD0mIqr4XbMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 13/13] iwlwifi: mvm: starting from 22000 we have 32 Rx AMPDU sessions
References: <20220128133433.591765-1-luca@coelho.fi>
        <iwlwifi.20220128153014.7120a90ed7d2.I9d6d907a2c1b965d1e42ff9f0886b1df627e4761@changeid>
Date:   Thu, 17 Feb 2022 15:25:20 +0200
In-Reply-To: <iwlwifi.20220128153014.7120a90ed7d2.I9d6d907a2c1b965d1e42ff9f0886b1df627e4761@changeid>
        (Luca Coelho's message of "Fri, 28 Jan 2022 15:34:33 +0200")
Message-ID: <87pmnlzku7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> Those devices have more BAIDs, which is the hardware module
> that tracks the BA session.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 3 +++
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         | 1 -
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c         | 6 +++---
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> index b0b8f067d544..5539d402daa9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
> @@ -264,6 +264,9 @@ struct iwl_rlc_config_cmd {
>  	u8 reserved[3];
>  } __packed; /* RLC_CONFIG_CMD_API_S_VER_2 */
>  
> +#define IWL_MAX_BAID_OLD	16 /* MAX_IMMEDIATE_BA_API_D_VER_2 */
> +#define IWL_MAX_BAID		32 /* MAX_IMMEDIATE_BA_API_D_VER_3 */

Nitpicking, but using "old" or "new" creates problems as often there
could be a third option :) No need to resend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
