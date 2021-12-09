Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F046E6D2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhLIKkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLIKkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 05:40:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB54C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 02:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B1E4CE255A
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 10:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D1C004DD;
        Thu,  9 Dec 2021 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046195;
        bh=1GHthKtcS/GtdAuJZVLCvo7YEviQRgYTYs/I3neTWLs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RkrZZnDaTMb+I+zqZvjhYxCM7vbvgsABDFPrOKcR4cJmqNF4OIC+3d25TcpnDrSYd
         DOS+ma5jnybOdajCwPTOFFSn84bJRN1xKnvdz9x2VkRn3o/SSlUdhdDdZNdDLlJ/eP
         7FOc7+ew7u6Jm8QxlkY4bb7PfnuOtqxa8utcuiB8TCEfMO5qUsu9dtEnH0b2rcm8pi
         IQw1bf1UIFW+JkemkwKgw2u77chB5ckzzH+OfhSJ1Jvvj5EXUbyu7BLLihEj7yEKAc
         khPcBKF6+FXfOsAdtN+2quYcCteOFt24CjNUFYPdi0eku1JLr6Z1/Uk8xBVF2GImO+
         EfrzIQnZf3tTQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: Re: [PATCH v2] ath11k: Change qcn9074 fw to operate in mode-2
References: <1638971390-7160-1-git-send-email-akolli@codeaurora.org>
Date:   Thu, 09 Dec 2021 12:36:28 +0200
In-Reply-To: <1638971390-7160-1-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Wed, 8 Dec 2021 19:19:50 +0530")
Message-ID: <87a6ha3w0j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> From: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>
> In mode-2 QCN9074 firmware uses 15MB of host memory and firmware
> request 1MB size segements in QMI, whereas in mode-0 firmware
> uses 45MB of host memory and each segment is of 2MB size.
> In mode-2 firmware operates with reduced number of vdevs and peers.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -12,9 +12,9 @@
>  /* Target configuration defines */
>  
>  /* Num VDEVS per radio */
> -#define TARGET_NUM_VDEVS	(16 + 1)
> +#define TARGET_NUM_VDEVS	(ab->hw_params.num_vdevs)
>  
> -#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
> +#define TARGET_NUM_PEERS_PDEV	(ab->hw_params.num_peers + TARGET_NUM_VDEVS)
>  
>  /* Num of peers for Single Radio mode */
>  #define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
> @@ -26,7 +26,7 @@
>  #define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
>  
>  /* Max num of stations (per radio) */
> -#define TARGET_NUM_STATIONS	512
> +#define TARGET_NUM_STATIONS	(ab->hw_params.num_peers)

Don't know how I missed this previously, but the macros should be
converted to FOO(ab). I'll send v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
