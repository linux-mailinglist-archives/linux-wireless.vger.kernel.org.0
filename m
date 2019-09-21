Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9356B9CF8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfIUHoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 03:44:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbfIUHoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 03:44:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FAB061418; Sat, 21 Sep 2019 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569051876;
        bh=gA8cGjniPi0jJ64mrNJLr1YFpWaOETKiC3O3WaorSWw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dBuCwvCbwbCmLyon0bVwz5hqGtg4peC0cIfPwWav4rHAg5Ea4xIjvfsHTj5iNO/Bo
         nQ7u0VNFvzYQC2SdFZW/hiYpltj/y1jC8MPQoht/idA+gCVGv7osFNnjZB/dTmXNZ2
         CddFUv8Eq03LzKTWRmS8JeCIqkOD3Lxo5ur3Q95I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93B5661197;
        Sat, 21 Sep 2019 07:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569051875;
        bh=gA8cGjniPi0jJ64mrNJLr1YFpWaOETKiC3O3WaorSWw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O4ChcviMDaRHzsMeoTLDx0iohPpWM9kCm0YWi66r+UfW804FhFBlZKx5DfF0CG1PQ
         zUQ8DdNoDG12/R6/8l4I5ehZKCALU1MzuJ5P2TmN5vL+g/6l24xldXCeEvu+BuwjYp
         kz9pUnz0N9sHa87VO2HMlrUaVvzV6RKmvvha6h7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93B5661197
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Subject: Re: [PATCH] rtlwifi: rtl_pci: Fix errors when CONFIG_RTLWIFI_DEBUG is not set
References: <20190920022533.23085-1-Larry.Finger@lwfinger.net>
Date:   Sat, 21 Sep 2019 10:44:31 +0300
In-Reply-To: <20190920022533.23085-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Thu, 19 Sep 2019 21:25:33 -0500")
Message-ID: <87h856ayao.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> When rtlwifi debugging is disabled, missing globals occur due to the
> attempt execution of code that is never generated.

Do you have the exact error message? I don't know why this is failing.

> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
> index 6087ec7a90a6..2f8aad28f1c0 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -2298,8 +2298,10 @@ int rtl_pci_probe(struct pci_dev *pdev,
>  	}
>  	rtlpriv->mac80211.mac80211_registered = 1;
>  
> +#ifdef CONFIG_RTLWIFI_DEBUG
>  	/* add for debug */
>  	rtl_debug_add_one(hw);
> +#endif
>  
>  	/*init rfkill */
>  	rtl_init_rfkill(hw);	/* Init PCI sw */
> @@ -2349,8 +2351,10 @@ void rtl_pci_disconnect(struct pci_dev *pdev)
>  	wait_for_completion(&rtlpriv->firmware_loading_complete);
>  	clear_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
>  
> +#ifdef CONFIG_RTLWIFI_DEBUG
>  	/* remove form debug */
>  	rtl_debug_remove_one(hw);
> +#endif

Then I checked debug.h I see that it's supposed to be handled already:

#ifdef CONFIG_RTLWIFI_DEBUG
void rtl_debug_add_one(struct ieee80211_hw *hw);
void rtl_debug_remove_one(struct ieee80211_hw *hw);
void rtl_debugfs_add_topdir(void);
void rtl_debugfs_remove_topdir(void);
#else
#define rtl_debug_add_one(hw)
#define rtl_debug_remove_one(hw)
#define rtl_debugfs_add_topdir()
#define rtl_debugfs_remove_topdir()
#endif

But the else part looks weird, I'm used to using inline functions
instead of defines:

static inline void rtl_debug_add_one(struct ieee80211_hw *hw) {}
static inline void rtl_debug_remove_one(struct ieee80211_hw *hw) {}
static inline void rtl_debugfs_add_topdir(void) {}
static inline void rtl_debugfs_remove_topdir(void) {}

Inline functions also make it possible for the compiler to check the
types are correct.

-- 
Kalle Valo
