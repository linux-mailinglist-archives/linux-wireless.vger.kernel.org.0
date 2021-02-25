Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599CE3253F4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBYQtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhBYQrn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 11:47:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86780C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Djvy0oEFkEBRJxi5r3RAYnG7iyXk5J+NsNy6hrG/IZs=; b=123Rdb/XZp6ToptFzvcST+48RC
        n8XbHSCPUoTR/AGb9MKX9oNR4tCUkVuAgrFF34B8Fqjv//VsuHr8005hrpSSv1CX984rK4jKMHjdr
        U2iqqnfDxGNGTEJ7j7sx6/07UmwxgyeO8eHLLnwTu3yTbWxwuvbY70NvQQFaabNtrpmWL38qNvgyo
        elf33FqsJcBFY6DF1xAa7O+nUMhe8UMQRW4tIUaMj10vNGeSsEOLEjjHvZLZCOBwoh2xuPvqwf/nK
        nhAMj8QMx+jLtw92IIzSwmcKbUsDazd6Enxq40mMc4Pr1Ucp/N+x7IzFNRv0cnKgjH5HiBq6BKxh7
        afKrWohQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFJmz-0007HE-Hw; Thu, 25 Feb 2021 16:46:57 +0000
Subject: Re: [PATCH 5.12] iwlwifi: pcie: fix iwl_so_trans_cfg link error when
 CONFIG_IWLMVM is disabled
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com
References: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90a94fca-07db-85db-b532-f4248e3dca48@infradead.org>
Date:   Thu, 25 Feb 2021 08:46:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/24/21 11:04 PM, Kalle Valo wrote:
> Randy reported an error on his randconfig builds:
> 
> ERROR: modpost: "iwl_so_trans_cfg" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
> 
> The problem was that when CONFIG_IWLMVM was disabled we were still accessing
> iwl_so_trans_cfg. Fix it by moving IS_ENABLED() check before the access.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> index 314fec4a89ad..ffaf973dae94 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -1106,6 +1106,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +#if IS_ENABLED(CONFIG_IWLMVM)
> +
>  	/*
>  	 * Workaround for problematic SnJ device: sometimes when
>  	 * certain RF modules are connected to SnJ, the device ID
> @@ -1116,7 +1118,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_SNJ)
>  		iwl_trans->trans_cfg = &iwl_so_trans_cfg;
>  
> -#if IS_ENABLED(CONFIG_IWLMVM)
>  	/*
>  	 * special-case 7265D, it has the same PCI IDs.
>  	 *
> 


-- 
~Randy

