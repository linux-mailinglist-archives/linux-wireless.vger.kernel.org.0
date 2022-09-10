Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285A5B44D9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiIJHAB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Sep 2022 03:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiIJHAA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Sep 2022 03:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE401252A6;
        Fri,  9 Sep 2022 23:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4538960BED;
        Sat, 10 Sep 2022 06:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED87C433C1;
        Sat, 10 Sep 2022 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662793197;
        bh=H1aoyF1uXDfRBKooemHT/8QDr5kWAqldZd79V0FSS58=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HkVhrj8ZkFAQeYHVojvPSgOc1WVVOxlAoXPqHcO2Z6yb0wUaVL9FPyhgG9Zz374NC
         iGu3kEdcNhqji2wnhaf2btSUDwzx3pBR600fLRdy1F2Aw/wYAdu9Kc1+atHsq+fYLC
         6r9ZOJn3UVe3f82vukvu126twrCN7rG9JfNFvFhJ90h/9bX6h3VG5JD7p0kUWdo6sI
         Jb5o7KD4rjUzrwwbXtKyNCQX25yXFNDMvA815pubAf2svV7IB9qtDcQ8YCaikOuXYE
         HSOt6CU/T8f/n1Ylu5L711uUzIZQ6neDiODjBsXprO4tE5WSiphM6UqxcK3O0oDYM1
         Tl44ZAw1s5PlQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] ath11k: Add WoW support for WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220902112520.24804-3-quic_mpubbise@quicinc.com>
References: <20220902112520.24804-3-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Manikanta Pubbisetty" <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166279319008.7195.445410596806378846.kvalo@kernel.org>
Date:   Sat, 10 Sep 2022 06:59:55 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Add support for WoW on WCN6750 chipset.
> 
> Unlike other chips where WoW exit happens after sending WoW wakeup
> WMI command, exit from WoW suspend in the case of WCN6750 happens
> upon sending a WoW exit SMP2P (Shared memory point to point) message
> to the firmware.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Failed to build:

ERROR: modpost: "ath11k_pci_disable_ce_irqs_except_wake_irq" [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!
ERROR: modpost: "ath11k_pci_enable_ce_irqs_except_wake_irq" [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!

This is because EXPORT_SYMBOL() macros were missing, added those in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e522bd3df8ab17f661547603a44f4b7d84223d73

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220902112520.24804-3-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

