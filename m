Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053F35FAD9B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJKHjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKHjB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC167D1F8
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B076112E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5985C433C1;
        Tue, 11 Oct 2022 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473939;
        bh=xptYkDlC4J+vOpYOBqv0P4p4o4h9yrwgjF3mhdV4x/Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ew6wpZZSPXopA73Rw8S2FTSq89swBKHfaOsaUrqNW7iyts/OJ89bGn/PfwxodVVnp
         EFN4Jt/21yvZK2TVyi0Jfk+KGV7ZKIlNE7sDIxaQ5kFd5BQ/0QX3KMrVuUVMSEtE81
         zTpbAmuiv/IjqJyVfCx5CUSHMx/FvTwu5RMQrwmPm1+AR3LQ0mrQjhjIBzCIdfiFnS
         1kYR0rV1Ae/COqD8CmDSC1yDNRIJgaPrK37P0Z/VmlAKITMsRoNlnkcfWsksZtW/1i
         7ckRuWO4u7bJH/S4EPVsRstwIzbEaqUMOfGHV2ZWsX8LEZ3YztXASDUKQ4Bd0O7PjC
         qkrgGaKV5PDrA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/8] wifi: ath11k: Add support for IPQ5018
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
Date:   Tue, 11 Oct 2022 10:38:55 +0300
In-Reply-To: <20221006105913.18356-1-quic_kathirve@quicinc.com> (Karthikeyan
        Kathirvel's message of "Thu, 6 Oct 2022 16:29:05 +0530")
Message-ID: <877d16q06o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> This patchset adds support for IPQ5018.
>    - IPQ5018 is a AHB based 2G 2x2 device.
>    - The CE reg space in IPQ5018 is not part of WCSS as in IPQ8074
>     or IPQ6018 and these sections (CE register space and WCSS) are not
>     contiguous, hence the ce space is io remapped separately and
>     the registers are handle accordingly based on the offset.
>    - The rx descriptors are similar to QCN9074
>    - The hw ops are similar to QCN9074 except for rx hash computation which
>      is defined newly
>    - The UMAC registers are different, hence new MACROS are defined for
>     their usage.
>
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

This should be:

Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

The format is documented here:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag

Also you seem to be using an old firmware, please update to the version
we are using in upstream:

https://github.com/kvalo/ath11k-firmware/tree/master/IPQ5018/hw1.0/2.6.0.1/WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

And remember to use ath11k-check, this patchset has a lot of new
warnings:

drivers/net/wireless/ath/ath11k/core.h:1151: Please don't use multiple blank lines
drivers/net/wireless/ath/ath11k/ahb.c:287: Alignment should match open parenthesis
drivers/net/wireless/ath/ath11k/hw.c:2159: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2164: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2169: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2174: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2179: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2184: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2189: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2194: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2199: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2204: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2210: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2215: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2221: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2226: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2231: line length of 103 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2236: line length of 102 exceeds 90 columns
drivers/net/wireless/ath/ath11k/hw.c:2241: line length of 102 exceeds 90 columns

And most importantly this patchset breaks my tests with WCN6855:

[  366.915173] ath11k_pci 0000:06:00.0: chip_id 0x2 chip_family 0xb board_id 0x106 soc_id 0x400c0200
[  366.915425] ath11k_pci 0000:06:00.0: fw_version 0x11090c35 fw_build_timestamp 2022-04-18 20:23 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
[  367.030091] ath11k_pci 0000:06:00.0: ignore reset dev flags 0xc800
[  368.111239] ath11k_pci 0000:06:00.0: failed to receive control response completion, polling..
[  368.352229] Run module-load (3/3)
[  369.135172] ath11k_pci 0000:06:00.0: ctl_resp never came in (-110)
[  369.135269] ath11k_pci 0000:06:00.0: failed to connect to HTC: -110
[  369.171910] ath11k_pci 0000:06:00.0: failed to start core: -110
[  369.180182] failed to send QMI message
[  369.180373] ath11k_pci 0000:06:00.0: failed to send wlan mode request (mode 4): -5
[  369.180432] ath11k_pci 0000:06:00.0: qmi failed to send wlan mode off: -5

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
