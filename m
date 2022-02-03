Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144074A8030
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 09:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiBCIQK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 03:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiBCIQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 03:16:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E5C061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 00:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA878617F0
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 08:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA0EC340E4;
        Thu,  3 Feb 2022 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643876168;
        bh=2vnm1AHkcWOA7A+zVzTxeHC8nUwJkepDiAdNzZnm5fY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Igzek+jNvDspq73TzovZUU2IGSaohBQxw+ezBLayf1PWArm1KeV+p+pC7iJNc7/ia
         RmVtaXavxR1PeGo06FnWR2xN94BM+cvf3nadd3UUCS7omYx9ZXOWGd1N/gmNMHsdyk
         onMQRACy4ZBB62ZdHildSEFlTq2vSbr61Cd0QJuXBSaJcasuQ17siaxK6EftUvppT8
         zIlJTTrpYXkmg9m5vOY7Z5A36f4tIyJ4L6XdDbzf5HwMuYz5MTTxIYgOJn+5uPGlBR
         RU2IeQcK9hGKuEDnFTphfwXuedh5H8sqU9kzxHlkDCLTv9qes51byEC68C6zlm77wR
         AHCwX6BhH4IUg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.17 6/8] iwlwifi: mei: retry mapping the shared area
References: <20220128123057.524038-1-luca@coelho.fi>
        <iwlwifi.20220128142706.cc51e6a6d635.I4b74a082eb8d89f9e4f556a27c4339c15444dc6c@changeid>
Date:   Thu, 03 Feb 2022 10:16:03 +0200
In-Reply-To: <iwlwifi.20220128142706.cc51e6a6d635.I4b74a082eb8d89f9e4f556a27c4339c15444dc6c@changeid>
        (Luca Coelho's message of "Fri, 28 Jan 2022 14:30:55 +0200")
Message-ID: <87leyscqm4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> The shared area is a DMA memory allocated in the host and
> mapped so that the host and the CSME firmware can
> exchange data. It is mapped through a dedicated PCI device
> that is driven by the mei bus driver.
>
> The bus driver is in charge of allocating and mapping this
> memory. It also needs to configure the CSME firmware with
> a specific set of commands, so that the CSME firmware will
> know that this memory is meant to be used by its internal
> WLAN module.
>
> For this, the CSME firmware first needs to completely
> initialize its WLAN module and only then get the mapping
> request.
>
> The problem is that the mei bus enumeration completes
> before the WLAN is completely ready. This means that
> the WLAN module's initialization is racing with iwlmei's
> allocation and mapping flow.
>
> Testing showed a problem in resume flows where iwlmei
> was too fast and the DMA mapping failed.
>
> Add a retry mechanism to make sure that we will succeed
> to map the memory.
>
> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Fixes: bcbddc4f9d02 ("iwlwifi: mei: wait before mapping the shared area")

I'll move the latter Fixes before s-o-b tag.

> -	/*
> -	 * The CSME firmware needs to boot the internal WLAN client. Wait here
> -	 * so that the DMA map request will succeed.
> -	 */
> -	msleep(20);
> +	do {
> +		ret = iwl_mei_alloc_shared_mem(cldev);
> +		if (!ret)
> +			break;
> +		/*
> +		 * The CSME firmware needs to boot the internal WLAN client.
> +		 * This can take time in certain configurations (usually
> +		 * upon resume and when the whole CSME firmware is shut down
> +		 * during suspend).
> +		 *
> +		 * Wait a bit before retrying and hope we'll succeed next time.
> +		 */
>  
> -	ret = iwl_mei_alloc_shared_mem(cldev);
> -	if (ret)
> +		dev_dbg(&cldev->dev,
> +			"Couldn't allocate the shared memory: %d, attempt %d / %d\n",
> +			ret, alloc_retry, ALLOC_SHARED_MEM_RETRY_MAX_NUM);
> +		msleep(100);
> +		alloc_retry--;
> +	} while (alloc_retry);

Nitpicking, but this could have been:

while (alloc_retry--);

But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
