Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EED51106E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357777AbiD0FSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiD0FR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:17:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3DC7489;
        Tue, 26 Apr 2022 22:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93281B82488;
        Wed, 27 Apr 2022 05:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29CCC385A7;
        Wed, 27 Apr 2022 05:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651036487;
        bh=yBv2EE30DRLNaYudcx9cZFvb01QnSzSCcKtunw7AoZU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fAj1h1TQ6UJdlIpNipwed9Rv9mASfJZquqKtNWdObZcsD99g6wgT7bPlM0gX2FCYM
         m7cDFz4FVVBjeZ5iLhWJevN6SQxO7Ez/rbEdLtroJ5YfmtpP6ZYhdLe3cFcQ0i0FMW
         jxyMoaCeJOQt3VPRZ235Ckv1qPExLTKnB+PcAwWNm1tNs6D2g7OuhuEATRk/DWjxHH
         cds+jYochLsNAZfPGwMotbcrAMYRsuftHNz5Ahqg9KqVPixQbUNmQb7tpBT4f7zZ3r
         n+aLVt/Xp5mNpPNFtMRTLtW+Lak1Eju5n6HlP68YPlsFmheXYqamMsexlhfgnMri6n
         brswvqjtFb0EQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v5 00/12] add support for WCN6750
References: <20220426145456.8055-1-quic_mpubbise@quicinc.com>
Date:   Wed, 27 Apr 2022 08:14:43 +0300
In-Reply-To: <20220426145456.8055-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Tue, 26 Apr 2022 20:24:44 +0530")
Message-ID: <87v8uvhzuk.fsf@kernel.org>
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
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
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
> ---
> V5:
>  - Rebased on ToT SHAID: 01be26cde012478db958d9bde530877c46031e76

I already had v4 applied to the pending branch so I'm going to drop v5
and look at v4 instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
