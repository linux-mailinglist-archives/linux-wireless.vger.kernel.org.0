Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0749F901
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiA1MOD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiA1MOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74767C061714;
        Fri, 28 Jan 2022 04:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA97618CC;
        Fri, 28 Jan 2022 12:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B94C340E6;
        Fri, 28 Jan 2022 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643372041;
        bh=Gl0idB2Sk6mpsfiD/yCwRa26c7O/F/PjGnyjeYSw0QY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k1tDv3aQd6V7ZaOzFVGTMG6poo5NV4P38Pe4gM67NZsrgBTY6umJx87MdVxTJZJ+m
         UK1Nfb8nBBpNkb2w1ku9n+hNjOngR1doVyedmxQmrkv2c4mg+mVg0rd0/JRPUSuiO4
         ICaf0bm6alsaJIcMVoyhljDn+iCFHcZcQxnKQXNnQb4OW9Kzbs5lgWiX7LKR3+YmdQ
         j1nNYlXE8nKHAswzLcGIeKfkLJ57qN3yez5zjGjpqnDVLx+fGkxQLFycemeIykyCZi
         e+sMnlQ4ajYif0BjUQJR+XJKDS9FmVa5K6xX+bGm+RNgyJQFW5FOw2lPqw4qhAd3aJ
         HBUoFo3ugWAhQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 02/19] ath11k: Refactor PCI code to support hybrid bus devices
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 14:13:55 +0200
In-Reply-To: <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:16:58 +0530")
Message-ID: <87h79of470.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Unlike other ATH11K PCIe devices which are enumerated by APSS
> processor (Application Processor SubSystem), WCN6750 gets
> enumerated by the WPSS Q6 processor (Wireless Processor SubSystem);
> In simple terms, though WCN6750 is PCIe device, it is not attached
> to the APSS processor, APSS will not know of such a device being
> present in the system and therefore WCN6750 will be registered as
> a platform device to the kernel core like other supported AHB
> devices.
>
> WCN6750 uses both AHB and PCI APIs for it's operation, it uses
> AHB APIs for device probe/boot and PCI APIs for device setup
> and register accesses; Because of this nature, it is referred
> as a hybrid bus device.
>
> Refactor PCI code to support hybrid bus devices like WCN6750.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c

[...]

> +static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
> +{
> +	struct ath11k_base *ab = ab_pci->ab;
> +
> +	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
> +
> +	lockdep_assert_held(&ab_pci->window_lock);
> +
> +	if (window != ab_pci->register_window) {
> +		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
> +			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
> +		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
> +		ab_pci->register_window = window;
> +	}
> +}

So the style used in ath11k is ath11k_<filename>_foo, so that a function
ath11k_pci_foo() should be in pci.c. This patch is now breaking that
style. Maybe pci_cmn.c should renamed to cpci.c, pcic.c or something
like that? Then the function prefix could be ath11k_cpci_, ath11k_pcic_
or similar.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
