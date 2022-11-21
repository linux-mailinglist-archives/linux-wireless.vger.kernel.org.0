Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA96328FB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKUQIA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKUQH7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:07:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1282870F
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 458C6611FB
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0BC433D6;
        Mon, 21 Nov 2022 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669046877;
        bh=67GCw5OPzotwvypM8EHVRxELHO+KAiuQ9DGkcTfK7K0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QXfNKKOpy9RerLTwb5tVhId3YqDmbhGmWOfY4MVrss963JGqs+c//Y0U+Q/WJZ1JZ
         cOTpg78tEa/s5+Q04MmNtiO3bpBQp9i0bIcqu1My/ecJXE59cGgjxGCU0AdDtaEoQo
         XEVkpO3ldrM74mEb9Zv2EHC7/sJ3qZwKWUJ8ABKQE82Na0WrKoPynWpuiolMWoKhmo
         w5h57bUuKhXnplqHFzNTNhdkEBCMNBKqC1dFE5PVxR83jCwobKlVdTe+ZGNK9wRiG7
         wPzkNWxLJbtH0HllHxnA7yZxPfS6KSoHSHZOwOmzQe9NY7o/88YGscyURDPR3KuFwK
         y30OmvtcWE92A==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: Re: [PATCH 4/9] wifi: iwlwifi: mvm: add support for EHT 1K aggregation size
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
        <20221120185147.d82e3d7bf651.Ie4d90c376c822694f4523ff0fb5731f20004c24d@changeid>
Date:   Mon, 21 Nov 2022 18:07:52 +0200
In-Reply-To: <20221120185147.d82e3d7bf651.Ie4d90c376c822694f4523ff0fb5731f20004c24d@changeid>
        (gregory greenman's message of "Sun, 20 Nov 2022 19:00:34 +0200")
Message-ID: <87sfic8f53.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com writes:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
>
> In 11be we can receive 1K aggregation size so update our max HW rx
> aggregation for mac80211 usage.
>
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> index 9699433137bc..310eb3fde386 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> @@ -1077,6 +1077,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
>  	static const u8 no_reclaim_cmds[] = {
>  		TX_CMD,
>  	};
> +	u32 max_agg = trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ ?
> +			   IEEE80211_MAX_AMPDU_BUF_EHT : IEEE80211_MAX_AMPDU_BUF_HE;

IMHO a proper if statement is cleaner than this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
