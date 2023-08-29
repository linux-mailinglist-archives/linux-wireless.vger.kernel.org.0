Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD078C3B3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 13:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjH2LyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjH2Lxw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 07:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13E194
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 04:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10BE65306
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 11:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8236EC433C8;
        Tue, 29 Aug 2023 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693310029;
        bh=awCMTnDtvvGRTd8dGFD1IkkYqZZrzBBX9jyzuOvu4Mw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=agFtrIaz1YjzBj7XhxU4BIT6GF03xbYREjgBbWoY4enl1ZbCUnQ+s9XD7jSb4DCZA
         XwYSOAIfpoKghEM+R/qcVCILrwUG8skQGKzDVvpog6Gn0JWfQy00JLeqKYqBC3ERVz
         HYBtVOEYaco6FmaW1/3H0HbKb2ofuFjsoWkYmjeddmFTkFLKpXyuh/EZmk5FWfsV73
         6rBwrJe1sZGZp8wTlb5O+0W2qImUqkxTUsfevQZSxzmPQsfURXL7oQoXw7TO3GgtD5
         HesYxkhtR5WiY3mN8uQXJx85pjVVTYC4Z4jUkWR4REI2tyqQjvhMxRM4ttHo433QCR
         HfqJ7iuXa7Xtw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arowa Suliman <arowa@chromium.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [v4] wifi: ath11k: Add crash logging
References: <20230714001126.463127-1-arowa@chromium.org>
Date:   Tue, 29 Aug 2023 14:53:46 +0300
In-Reply-To: <20230714001126.463127-1-arowa@chromium.org> (Arowa Suliman's
        message of "Thu, 13 Jul 2023 17:10:54 -0700")
Message-ID: <87h6oif4j9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Arowa Suliman <arowa@chromium.org> writes:

> Currently, the ath11k driver does not print a crash signature when a
> crash happens. Checked by triggering a simulated crash using the command
> [1] and checking dmesg for logs.
>
> [1] echo assert > /sys/kernel/debug/ath11k/../simulate_fw_crash
>
> Change the crash logging from debug to informational and add a warning
> when firmware crash MHI_CB_EE_RDDM happens.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Signed-off-by: Arowa Suliman <arowa@chromium.org>

I did some cosmetic cleanup to the commit log.

> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -325,14 +325,15 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
>  {
>  	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
>  
> -	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
> -		   ath11k_mhi_op_callback_to_str(cb));
> +	ath11k_info(ab, "notify status reason %s\n",
> +		    ath11k_mhi_op_callback_to_str(cb));

In my view info, warning and error messages need to be at least somewhat
understandable to the user. I think this message is not understandable
and it should remain as a debug message. So I removed this change.

Please check my changes in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f9325b14e830f3e8b5a557352e7c65f321bb7b05

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
