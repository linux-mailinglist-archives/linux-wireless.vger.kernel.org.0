Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96624E4EED
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 10:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiCWJIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiCWJIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 05:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB87523A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 02:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8424FB81E3F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 09:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57767C340E8;
        Wed, 23 Mar 2022 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648026393;
        bh=clh4+CymOPTgHreEHI+45avY3CyQG9AV2/v77vhmwJs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tB3Cwi9q9q47F8/zfvt+ykFp4M+SWhpa9r2AVNkQ4ScWDb3P7XNGndgxdbBPnIElq
         t+eSWOs4W9PC7EY/qyC9dnsoDXJFg/giKXWZSs3Y/QXcvmeZojHBgJgVNGbl1DIMf7
         1G0RcG2uUDuq9gRZfzcTHm7hoeEHbGq2gxyVk+vHgw1CEsXps2BSEfIwVeP5qARmG9
         QlgpWFZWobN51e8/IXdnJFcZBMUPBhKYWHOShSaHP6Y8CLylFiseFZuPDtf2a7BC1w
         x7ewt2fJtIEZysM7wfH7x8l5xbuhko1nm+IbvLN8fAeMXweIkc87pIR5/chClFyTal
         fEIKhFwPQXw5Q==
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
Message-ID: <164802639004.545.3440948645378979467.kvalo@kernel.org>
Date:   Wed, 23 Mar 2022 09:06:32 +0000 (UTC)
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

> In Qualcomm ARM platforms there is WL_EN pin and other power regulators
> which can be controlled at platform side to completely reset the chip.
> For most of x86 and other platforms, the chip is connected via PCIe M.2
> interface, and there is no way to control WL_EN pin. Instead the host
> driver needs to reset the chip via PCIE_SOC_GLOBAL_RESET hardware
> register, just like ath11k does currently.
> 
> But when using PCIE_SOC_GLOBAL_RESET there are some hardware registers
> which are not cleared/restored. To handle those cases we can enable
> PLATFORM_CAP_PCIE_GLOBAL_RESET QMI host capability to tell the firmware
> to do some platform specific operations after firmware download.
> 
> This does not fix any known issues, but is recommended by the firmware
> team, so enable the capability on QCA6390 and WCN6855 PCI devices. It is
> currently unclear if this should be enabled also on QCN9074, so leave it
> disabled for now. On AHB devices this is not needed as they don't use
> PCIE_SOC_GLOBAL_RESET.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e4ac7173c93 ath11k: enable PLATFORM_CAP_PCIE_GLOBAL_RESET QMI host capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211011055602.77342-1-bqiang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

