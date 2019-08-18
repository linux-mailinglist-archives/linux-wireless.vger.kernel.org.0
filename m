Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3789D916F3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHRN76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 09:59:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRN75 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 09:59:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91F3662492; Sun, 18 Aug 2019 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136796;
        bh=zlY2zPmS8+a5QeWHHi4liK8ee4hArmt8tldD99nyucY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oNLKFEhb4+wZJJY2D/o0oyf3kiac3BiYm/EtlH8LVg9pBxN9Pwdtdr09/U4smQXeS
         nPMiD4I+VWc0kRAknQPwBLmTxViQ4o8/YtufWVYXKMzccGtt6J9yRtIL7MUdhX2sT7
         ptI4YHs1TJDplLB610NsaHxbIB5QSPgJ4CPmp02M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFED462579;
        Sun, 18 Aug 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566136791;
        bh=zlY2zPmS8+a5QeWHHi4liK8ee4hArmt8tldD99nyucY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mBN6VuOzmrjcDvidsJcYjUo/4OQOdkTi18Y82AfX103vubQ0LKDviU05+Y2jxKXk8
         IuKD0aex97MiNyHeCd9fjeEyIUMXpq+isxis6XByypAYsZ7epUU5lFyjfPfx4u1mUi
         zlwFCIt7vDV+9nd7KbC3K2Ajz4ce7c9d7DxTyhIw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFED462579
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 22/22] iwlwifi: remove the code under IWLWIFI_PCIE_RTPM
References: <20190817065200.9701-1-luca@coelho.fi>
        <20190817065200.9701-23-luca@coelho.fi>
Date:   Sun, 18 Aug 2019 16:59:48 +0300
In-Reply-To: <20190817065200.9701-23-luca@coelho.fi> (Luca Coelho's message of
        "Sat, 17 Aug 2019 09:52:00 +0300")
Message-ID: <8736hybmln.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> This is never set.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig    | 14 ----
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 71 -------------------
>  .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 --
>  3 files changed, 89 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> index 235349a33a3c..7dbc0d38bb3b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -92,20 +92,6 @@ config IWLWIFI_BCAST_FILTERING
>  	  If unsure, don't enable this option, as some programs might
>  	  expect incoming broadcasts for their normal operations.
>  
> -config IWLWIFI_PCIE_RTPM
> -       bool "Enable runtime power management mode for PCIe devices"
> -       depends on IWLMVM && PM && EXPERT
> -       help
> -         Say Y here to enable runtime power management for PCIe
> -         devices.  If enabled, the device will go into low power mode
> -         when idle for a short period of time, allowing for improved
> -         power saving during runtime. Note that this feature requires
> -         a tight integration with the platform. It is not recommended
> -         to enable this feature without proper validation with the
> -         specific target platform.
> -
> -	 If unsure, say N.

I would like to have more understanding why you are removing an existing
Kconfig option? "Never set" tells nothing.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
