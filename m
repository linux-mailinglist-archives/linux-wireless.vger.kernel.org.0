Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AB4E275B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiCUNTt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiCUNTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 09:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF921E0B
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 06:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69385611B9
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 13:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12768C340E8;
        Mon, 21 Mar 2022 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647868697;
        bh=ftffsuXOcwkiieVfrAlyrUHaIDDIzRoaoNdHv5VLSLU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NCbWox8UHMMpiJX5vj+rqlLcVsXQHuCmsMtmpYyVeiHmDZwrkuLUy2mYAOk5b8Rb4
         LesbXP0D3yMrX3Tetk2EX4Hc9RXQN8yFzYVOIMLgrzoImylvE0q7i3Rw0/Js/Blgwm
         T2m2riiTEX1H7yL23Y+iLIkYTHlmdgAJkBS3FRax0zKVpFlRuKOlEKtuTllDUdzD8+
         OpKMs/R8PHsTZFl25LltCJNvaBykPWKdTxAS3QQ5HcxJgiVL4q6e3iQ/l65ctyVW/S
         ybZHFIL/aXHbsXjypYbDVGearb4FkTjcVBq3eDgvH1Ogu5PebiWbgfTGwO/0RE5W6k
         Ea1WpIU6aENGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Advertise PLATFORM_CAP_PCIE_GLOBAL_RESET in qmi
 msg
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211011055602.77342-1-bqiang@codeaurora.org>
References: <20211011055602.77342-1-bqiang@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164786869187.26064.10113094982951147703.kvalo@kernel.org>
Date:   Mon, 21 Mar 2022 13:18:16 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> wrote:

> Inform firmware that host is capable of triggering a global reset.
> This is requested by firmware team.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>

In the pending branch I fixed the trivial conflicts and enabled this feature on
both wcn6855 hw2.0 and hw2.1.

I also now have more information what this is about so changed the commit log to:

---------------------------------------------------------------------

ath11k: enable PLATFORM_CAP_PCIE_GLOBAL_RESET QMI host capability

In Qualcomm ARM platforms there is WL_EN pin and other power regulators
which can be controlled at platform side to completely reset the chip.
For most of x86 and other platforms, the chip is connected via PCIe M.2
interface, and there is no way to control WL_EN pin. Instead the host
driver needs to reset the chip via PCIE_SOC_GLOBAL_RESET hardware
register, just like ath11k does currently.

But when using PCIE_SOC_GLOBAL_RESET there are some hardware registers
which are not cleared/restored. To handle those cases we can enable
PLATFORM_CAP_PCIE_GLOBAL_RESET QMI host capability to tell the firmware
to do some platform specific operations after firmware download.

This does not fix any known issues, but is recommended by the firmware
team, so enable the capability on QCA6390 and WCN6855 PCI devices. It is
currently unclear if this should be enabled also on QCN9074, so leave it
disabled for now. On AHB devices this is not needed as they don't use
PCIE_SOC_GLOBAL_RESET.

---------------------------------------------------------------------

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011055602.77342-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

