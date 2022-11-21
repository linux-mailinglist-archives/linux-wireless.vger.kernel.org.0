Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD263293E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKUQRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKUQRj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:17:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DFB17417
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 094FC61300
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 16:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A526EC433C1;
        Mon, 21 Nov 2022 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669047453;
        bh=yQGbbm63/8Za4tULD4tZDuctTenWp7KiB2LGcuQYF2c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b9JhLlNvcmpedn/Yyqyj/qQF+NVjOrVwJv7OIUtZNDli+ucNsoZ3TnPpIRlQCu1v6
         ek7IlFTCSLmMdQSRrDRGLfoTBlu/jh/HRZ9+8F0XyIlbQCCjrnozS3Ogm+F+mlzhLw
         hJnjWS/uPoEwZD6CtJrtaDqYl/CpKbyS+rxUo4aJ+PlWYbmAJXJPn+7Fp1WhTWf5pP
         9pwhJbGEWP75wp1f29A08cwoTqNiX13IfVhNVO9ltwqC35ngY3MlWo2IGvsoF+aVOP
         X/Ci4i+M34X1hHhju2hbqZCRn8gvy86paoaF5Si3xU1cpEVEE+0znqP37BepPGeipm
         rVDEhmLFFryCw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Enable low power mode when WLAN is not active
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
Date:   Mon, 21 Nov 2022 18:17:30 +0200
In-Reply-To: <20221121110359.4652-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 21 Nov 2022 16:33:56 +0530")
Message-ID: <87h6ys8ep1.fsf@kernel.org>
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

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable for battery operated devices. Same is the case with non-WoW
> suspend, chip will not be put into low power mode when the system is
> suspended resulting in higher battery drain.
>
> Send QMI MODE OFF command to firmware during WiFi OFF to put device
> into low power mode.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>
> Manikanta Pubbisetty (3):
>   ath11k: Fix double free issue during SRNG deinit
>   ath11k: Move hardware initialization logic to start()
>   ath11k: Enable low power mode when WLAN is not active

Nowadays we use "wifi:" prefix, but I can add it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
