Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F15110AB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiD0F4k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiD0F4j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:56:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077326122;
        Tue, 26 Apr 2022 22:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70B00B823F4;
        Wed, 27 Apr 2022 05:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D0C385A9;
        Wed, 27 Apr 2022 05:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651038805;
        bh=hz7bi9Pgapr+ftLdyJ4V0ycR2cjB1IZVr7lyVIPCgBo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=C68fxvNBssgLv+xl/iQyiIVOG//jPoitzEF1kq4IixGsBDe5e2sDSkV0kVZm2J3K/
         m5mcqmbgYkdzabzxFzEg9bJcMNIbbmwizUkpQ+k2R1SV9XmO+6sxmJQUEQ87ympN2o
         EjWu1dSR8zoXH+eyujUri97YOwpGQcQm2GM1bfG243K0A/GiFUJbmiCmAwfv+Ya0dn
         CdlSY3qYJUORGel6IP9FEj8rBc0ToGZG08Wxm2BP9YinDTEpU1Ae97884+6TKNmFoY
         Gcd7DM9C8bFqrwdcO3ZDbEa3LfXDJ3+QmSL330vOtLEFUWoHewfc85RFO/xlpUqcXa
         nQwQ4zFJV4bnA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v4 00/12] add support for WCN6750
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
Date:   Wed, 27 Apr 2022 08:53:17 +0300
In-Reply-To: <20220406094107.17878-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 6 Apr 2022 15:10:54 +0530")
Message-ID: <874k2fgjhu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
> An important point to note is that though WCN6750 is a PCIe device,
> it cannot be attached to any other platform except on Qualcomm
> Snapdragon SoCs due to the aforementioned reasons.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Manikanta Pubbisetty (12):
>   dt: bindings: net: add bindings of WCN6750 for ath11k
>   ath11k: Add HW params for WCN6750
>   ath11k: Add bus params for WCN6750
>   ath11k: Add register access logic for WCN6750
>   ath11k: Fetch device information via QMI for WCN6750
>   ath11k: Add QMI changes for WCN6750
>   ath11k: HAL changes to support WCN6750
>   ath11k: Datapath changes to support WCN6750
>   ath11k: Do not put HW in DBS mode for WCN6750
>   ath11k: WMI changes to support WCN6750
>   ath11k: Update WBM idle ring HP after FW mode on
>   ath11k: Add support for WCN6750 device

Due to the bus_params problem I had to drop most of the patches, but I
did keep few of them in the pending branch to reduce the patchset size:

495a15b1969a ath11k: Update WBM idle ring HP after FW mode on
8d121dacbe35 ath11k: WMI changes to support WCN6750
e31091e06011 ath11k: Do not put HW in DBS mode for WCN6750

Please submit v6 only after I have applied these, I'm waiting for some
build testing first.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
