Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C449F6D6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiA1KHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiA1KH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:07:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA55C061714;
        Fri, 28 Jan 2022 02:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF8F761E1B;
        Fri, 28 Jan 2022 10:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B13C340E6;
        Fri, 28 Jan 2022 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643364446;
        bh=f6PBkZrbiXplSyJ9SctAtOlwopu9lunMvBAUlYg6D7g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BxXiOoMbcRuJmnVWD08edF4mMqvedPC7E0EuIxK0D5sTwf2JXOMtHgd8BG9wGFdGX
         0pEZrtdYyrsnhw69G9Bv5jw+A1mv1Z5QnN3ysjbfrJQquqqrYN4pQ0a8aAtI8i6On3
         RSRwZRpIxWJ+XQWL3qY8gJvHY4snzRfEY0kFos898pBXR9oVz/4/BD2E7NyFU06aZs
         /Tgg/hxG0666i3CY53idv7Sosaz5nxO6SiCGeJDdy6nq7z6mxPfUvd7pnjo7VhH0cO
         hMHrW4Op5D+xXfdqlBiSmMYMO3GUjF6PLP2tPmzWzCZGgFIm7lxIOwQMkiTZSG2pWO
         vJksRwr+x3f/w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 00/19] add support for WCN6750
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 12:07:22 +0200
In-Reply-To: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:16:56 +0530")
Message-ID: <87ilu4gomd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390/WCN6855 which
> are DBS (dual band simultaneous) solutions (2 LMACs), WCN6750 has a
> single LMAC supporting 2G, 5G and 6G bands. It can be operated only
> on one band at any given point.
>
> WCN6750 is a PCIe device. Unlike other supported ATH11K PCIe devices
> which are directly attached to APSS (Application Processor SubSystem),
> WCN6750 is not attached to APSS, it is attached to the WPSS
> (Wireless Processor SubSystem) Q6 processor, the FW which runs on the
> Q6 processor will enumerate the PCIe device. Since APSS is unaware of
> such a device, it has to be registered as a platform device(AHB) to the
> kernel for device probing. Like other AHB devices, remoteproc APIs are
> used to boot up or shutdown of WCN6750.
>
> WCN6750 uses both AHB and PCIe ATH11K APIs for it's operation.
> It uses AHB APIs for device probe and booting of the remote processor.
> Once device is booted up, it uses ATH11K PCIe APIs for initialization
> and register access. Hence, it is referred as hybrid bus device in
> the rest of this series.
>
> Since the chip is enumerated by WPSS Q6, device information like
> BAR and BAR size is not known to the APSS processor. A new QMI message
> called device info QMI request will be sent to the target for fetching
> these details.
>
> STA and AP modes are supported; Basic connectivity and ping are
> verified in both the modes.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Note:
> *	Remoteproc driver changes for WCN6750 which takes care of
> 	downloading the FW and booting of Q6 processor are under
> 	upstream review.
> 	Link: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=582475

This is a very good overview, thanks for that. But I think something
which is not clearly mentioned here is that this only works on Qualcomm
Snapdragon SoC, right? So even though WCN6750 is a PCI device, it cannot
be attached to any platform. It would be good to emphasise that.

> Manikanta Pubbisetty (19):
>   ath11k: PCI changes to support WCN6750
>   ath11k: Refactor PCI code to support hybrid bus devices
>   ath11k: Choose MSI config based on HW revision
>   ath11k: Refactor MSI logic
>   ath11k: Remove core PCI references from PCI common code
>   ath11k: Add HW params for WCN6750
>   ath11k: Add bus params for WCN6750
>   ath11k: Add register access logic for WCN6750
>   ath11k: Fetch device information via QMI for WCN6750
>   ath11k: Add QMI changes for WCN6750
>   ath11k: HAL changes to support WCN6750
>   ath11k: Datapath changes to support WCN6750
>   ath11k: Fix RX de-fragmentation issue on WCN6750
>   ath11k: Do not put HW in DBS mode for WCN6750
>   ath11k: WMI changes to support WCN6750
>   ath11k: Update WBM idle ring HP after FW mode on
>   ath11k: Add support for WCN6750 device
>   ath11k: Add support for targets without trustzone
>   dt: bindings: net: add bindings of WCN6750 for ath11k

19 patches is a lot to chew on in one go, my recommendation is to have
max 10-12 patches per set.

In this case having three patchsets would make it a lot easier for
reviewers, but not sure how to split them. Maybe you could submit these
patches separate for preparing WCN6750 support, after a quick look they
seem pretty independent:

  ath11k: Fetch device information via QMI for WCN6750
  ath11k: HAL changes to support WCN6750
  ath11k: Fix RX de-fragmentation issue on WCN6750
  ath11k: Do not put HW in DBS mode for WCN6750
  ath11k: WMI changes to support WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
