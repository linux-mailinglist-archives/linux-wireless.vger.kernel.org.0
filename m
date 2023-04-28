Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54496F1D0E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjD1Q7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjD1Q7i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 12:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB922703
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 09:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059C16449D
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F310C433D2;
        Fri, 28 Apr 2023 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682701176;
        bh=7esWrEVtpM0D1QFAqlbVaGPSU+0prTZHbm36nyQD0yU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TAD/ph12mpVD9wU73jLRz/U0goAYl8O/IrMsCsATDk86SQsWjYciJ5hKXddbxMV/k
         GXtwhGVcMNSa6ESKdKCKpw6w+B4XxF/ff2sjYLx5jFMXVai45h6w5qF7FkPRWF5/VW
         ER4maO6m9wfv+VQKml0bumebaDxW0khih19sQ2jjwCxofakRBtadmqher99aUHy3A9
         TVdkFf/Z/fpDKin7knOappwZ9PrRQbUXZ9hgY/7E/FEbM9qJfaofalR+pTA11SUueb
         P+4D07+++/eOFQ5VsVWBTEQ/rP5n8ulHWeCan/ZCORg5jk7G7Hw3FmCcebDw8sstMg
         u6udrq8k9DzZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix registration of 6Ghz-only phy without the
 full
 channel range
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230421145445.2612280-1-mbizon@freebox.fr>
References: <20230421145445.2612280-1-mbizon@freebox.fr>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168270117368.13772.4483657458244576422.kvalo@kernel.org>
Date:   Fri, 28 Apr 2023 16:59:35 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> wrote:

> Because of what seems to be a typo, a 6Ghz-only phy for which the BDF
> does not allow the 7115Mhz channel will fail to register:
> 
>   WARNING: CPU: 2 PID: 106 at net/wireless/core.c:907 wiphy_register+0x914/0x954
>   Modules linked in: ath11k_pci sbsa_gwdt
>   CPU: 2 PID: 106 Comm: kworker/u8:5 Not tainted 6.3.0-rc7-next-20230418-00549-g1e096a17625a-dirty #9
>   Hardware name: Freebox V7R Board (DT)
>   Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : wiphy_register+0x914/0x954
>   lr : ieee80211_register_hw+0x67c/0xc10
>   sp : ffffff800b123aa0
>   x29: ffffff800b123aa0 x28: 0000000000000000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000006 x24: ffffffc008d51418
>   x23: ffffffc008cb0838 x22: ffffff80176c2460 x21: 0000000000000168
>   x20: ffffff80176c0000 x19: ffffff80176c03e0 x18: 0000000000000014
>   x17: 00000000cbef338c x16: 00000000d2a26f21 x15: 00000000ad6bb85f
>   x14: 0000000000000020 x13: 0000000000000020 x12: 00000000ffffffbd
>   x11: 0000000000000208 x10: 00000000fffffdf7 x9 : ffffffc009394718
>   x8 : ffffff80176c0528 x7 : 000000007fffffff x6 : 0000000000000006
>   x5 : 0000000000000005 x4 : ffffff800b304284 x3 : ffffff800b304284
>   x2 : ffffff800b304d98 x1 : 0000000000000000 x0 : 0000000000000000
>   Call trace:
>    wiphy_register+0x914/0x954
>    ieee80211_register_hw+0x67c/0xc10
>    ath11k_mac_register+0x7c4/0xe10
>    ath11k_core_qmi_firmware_ready+0x1f4/0x570
>    ath11k_qmi_driver_event_work+0x198/0x590
>    process_one_work+0x1b8/0x328
>    worker_thread+0x6c/0x414
>    kthread+0x100/0x104
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>   ath11k_pci 0002:01:00.0: ieee80211 registration failed: -22
>   ath11k_pci 0002:01:00.0: failed register the radio with mac80211: -22
>   ath11k_pci 0002:01:00.0: failed to create pdev core: -22
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e2ceb1de2f83 wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230421145445.2612280-1-mbizon@freebox.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

