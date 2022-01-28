Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21B49F6F2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbiA1KQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245062AbiA1KQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:16:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6CC061714;
        Fri, 28 Jan 2022 02:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9D7761E47;
        Fri, 28 Jan 2022 10:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E016C340E0;
        Fri, 28 Jan 2022 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643364977;
        bh=wBS1aRv8RBZk+XEloyXKx+zfsuc5T0JiJLuJbWY0NBI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VKPa2eGqVcj0n4uwza6XCCOBMGt5Q1W8el5/LCN9rQtlYFZUyH6LXG+xHpTXDYFtK
         ldt3UO2F9cYCA4jscnRad9etBQbOO7kvTQdgUdhjPmqmeHMar2KgpJalgBVEjfW7Q/
         FD9tNfWjOCVWaLzaujLCMuC2sx4DG0ZpU4SnGhfhzw6EKJBKrXuX4IfikAHewPWirL
         wroPufVF4rrQSVXBTXdxlsVenfPF2CbUPOgdvL/ONQSv9M6vW4v5wUeTRxgD87B4DH
         jgjhE5Aki/4ZmE1iZ3qu2FzCEGVj1miJQMwwBSczJZRhwnDCH9GjHRwBIn7gFv+rhR
         GcneXS/1fPn7w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 02/19] ath11k: Refactor PCI code to support hybrid bus devices
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 12:16:14 +0200
In-Reply-To: <1642337235-8618-3-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:16:58 +0530")
Message-ID: <87ee4sgo7l.fsf@kernel.org>
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

> --- a/drivers/net/wireless/ath/ath11k/Makefile
> +++ b/drivers/net/wireless/ath/ath11k/Makefile
> @@ -29,7 +29,7 @@ obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
>  ath11k_ahb-y += ahb.o
>  
>  obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
> -ath11k_pci-y += mhi.o pci.o
> +ath11k_pci-y += mhi.o pci.o pci_cmn.o

So the end result looks like this:

obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
ath11k_ahb-y += ahb.o pci_cmn.o

obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
ath11k_pci-y += mhi.o pci.o pci_cmn.o

Linking pci_cmn.o to both ath11k_pci.ko and ath11k_ahb.ko looks wrong.
Does that even compile if ath11k is linked to the kernel, eg. with
allyesconfig?

One way to solve is to link pci_cmn.o to ath11k.ko. But for another
approach, for a long time I have been thinking about what's the point to
have separate ath11k_pci.ko and ath11k_ahb.ko modules?,They are very
small anyway compared to ath11k.ko. So my ideais that should we have
just one ath11k.ko module, it contains all AHB and PCI code as well, and
ath11k_pci.ko and ath11k_ahb.ko would not be created anymore. It would
simplify things a bit, especially here.

Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
