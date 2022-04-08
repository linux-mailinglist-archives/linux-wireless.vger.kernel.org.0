Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2704F8F19
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiDHGlu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHGlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 02:41:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28807340D9
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 23:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0A0EB829A6
        for <linux-wireless@vger.kernel.org>; Fri,  8 Apr 2022 06:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E42C385A3;
        Fri,  8 Apr 2022 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649399984;
        bh=XG3wJvjxBHxkehar7RaskZvhRZ3hh7lEvkxTqLdY7I0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BG2o7oJ29lGlJSs+7EYhHO3006qSL8t7p0EAc75SdJNIZW7RZYZIaQeix8a2cNhOE
         UmPTyl6ygYJ3QcInA2spJamj7zQBKIifkOkwoDqHAOYzJM2JHd5nbBxIWNG3I74uEI
         glYFvuntQN56S9mh2WSBJt56XJUiu/IHs/hh8h5BEdUsjTHGIXV8lL6fZGe7aLRAcB
         5tW/iKyzgxQ2rt7i9vGqovm6n3uoNf0ZvGLyaMRV+YFM2PMjmQGPnPYSIcPw3wpNm4
         ga7qWuzuGe5Su76343XHueAehh5wqAAq4KwKmwX9HTRTIpvFIojSbyZAUlK/y9HiKs
         cZAKZ97FFM1Gg==
From:   Kalle Valo <kvalo@kernel.org>
To:     <quic_haric@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: disable spectral scan during spectral deinit
References: <1649396345-349-1-git-send-email-quic_haric@quicinc.com>
Date:   Fri, 08 Apr 2022 09:39:40 +0300
In-Reply-To: <1649396345-349-1-git-send-email-quic_haric@quicinc.com> (quic
        haric's message of "Fri, 8 Apr 2022 11:09:05 +0530")
Message-ID: <87fsmooz83.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<quic_haric@quicinc.com> writes:

> From: Hari Chandrakanthan <quic_haric@quicinc.com>
>
> When ath11k modules are removed using rmmod with spectral scan enabled,
> crash is observed. Different crash trace is observed for each crash.
>
> Send spectral scan disable WMI command to firmware before cleaning
> the spectral dbring in the spectral_deinit API to avoid this crash.
>
> call trace from one of the crash observed:
> [ 1252.880802] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [ 1252.882722] pgd = 0f42e886
> [ 1252.890955] [00000008] *pgd=00000000
> [ 1252.893478] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [ 1253.093035] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.89 #0
> [ 1253.115261] Hardware name: Generic DT based system
> [ 1253.121149] PC is at ath11k_spectral_process_data+0x434/0x574 [ath11k]
> [ 1253.125940] LR is at 0x88e31017
> [ 1253.132448] pc : [<7f9387b8>]    lr : [<88e31017>]    psr: a0000193
> [ 1253.135488] sp : 80d01bc8  ip : 00000001  fp : 970e0000
> [ 1253.141737] r10: 88e31000  r9 : 970ec000  r8 : 00000080
> [ 1253.146946] r7 : 94734040  r6 : a0000113  r5 : 00000057  r4 : 00000000
> [ 1253.152159] r3 : e18cb694  r2 : 00000217  r1 : 1df1f000  r0 : 00000001
> [ 1253.158755] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [ 1253.165266] Control: 10c0383d  Table: 5e71006a  DAC: 00000055
> [ 1253.172472] Process swapper/0 (pid: 0, stack limit = 0x60870141)
> [ 1253.458055] [<7f9387b8>] (ath11k_spectral_process_data [ath11k]) from [<7f917fdc>] (ath11k_dbring_buffer_release_event+0x214/0x2e4 [ath11k])
> [ 1253.466139] [<7f917fdc>] (ath11k_dbring_buffer_release_event [ath11k]) from [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx+0x1840/0x29cc [ath11k])
> [ 1253.478807] [<7f8ea3c4>] (ath11k_wmi_tlv_op_rx [ath11k]) from [<7f8fe868>] (ath11k_htc_rx_completion_handler+0x180/0x4e0 [ath11k])
> [ 1253.490699] [<7f8fe868>] (ath11k_htc_rx_completion_handler [ath11k]) from [<7f91308c>] (ath11k_ce_per_engine_service+0x2c4/0x3b4 [ath11k])
> [ 1253.502386] [<7f91308c>] (ath11k_ce_per_engine_service [ath11k]) from [<7f9a4198>] (ath11k_pci_ce_tasklet+0x28/0x80 [ath11k_pci])
> [ 1253.514811] [<7f9a4198>] (ath11k_pci_ce_tasklet [ath11k_pci]) from [<8032227c>] (tasklet_action_common.constprop.2+0x64/0xe8)
> [ 1253.526476] [<8032227c>] (tasklet_action_common.constprop.2) from [<803021e8>] (__do_softirq+0x130/0x2d0)
> [ 1253.537756] [<803021e8>] (__do_softirq) from [<80322610>] (irq_exit+0xcc/0xe8)
> [ 1253.547304] [<80322610>] (irq_exit) from [<8036a4a4>] (__handle_domain_irq+0x60/0xb4)
> [ 1253.554428] [<8036a4a4>] (__handle_domain_irq) from [<805eb348>] (gic_handle_irq+0x4c/0x90)
> [ 1253.562321] [<805eb348>] (gic_handle_irq) from [<80301a78>] (__irq_svc+0x58/0x8c)
>
> Tested on : WLAN.HK.2.6.0.1-00851-QCAHKSWPL_SILICONZ-1

Tested-on tag is not in correct format, but I can fix that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
