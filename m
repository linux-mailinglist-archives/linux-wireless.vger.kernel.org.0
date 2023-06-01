Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3327199FF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjFAKkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjFAKjt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1131C0
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43DD564361
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 10:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8006BC433EF;
        Thu,  1 Jun 2023 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615985;
        bh=XlMDOWiwV7JBxac9ef6jjtVZODT4kRA0z7MFn4Sq78M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hOD0Vl0q8jYUUWUMrJmYcK/s04TGD0CONGXeRQOcAhSTbnmbG1xEc1JDOPnGZZelh
         IF15cH6AQ48cvdwbcbjL4KBfeB0BOmpqV6UMb2BXgCfI1fUmzWQ9wnOGamCYBS3s6J
         u/qNaoR2LybbgRA8+r4fTC0XIF8n1V4XDlaL0DxUFU88ySHi08ktMNCMNYDkeyXCNh
         kxIM0aPJypug2xrsGa1bATVOqKbOS6FZTQxOAUW43zZ9F/4j8Ms+p6AaUrCDV2AmDz
         JKhwmDyTWccAtGzzV9li5v3bn5R/QK1QfrUBFPHgw08Y8BmP6nOf8iY0JU4+1YEda2
         7bX9rFr+vFJ0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: update proper pdev/vdev id for testmode
 command
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230601051907.13679-1-quic_rajkbhag@quicinc.com>
References: <20230601051907.13679-1-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168561597885.12237.8170515167122761875.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 10:39:44 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> User can extend test mode command support to set vdev and pdev params
> for debug purpose at run time by sending vdev/pdev param set command
> through the testmode command interface.
> 
> Fill the proper pdev/vdev id in driver since, pdev/vdev id details may
> not be available at user space. It will make sure that the proper
> vdev/pdev ids are sent to firmware.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Failed to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/testmode.c:320
error: drivers/net/wireless/ath/ath11k/testmode.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230601051907.13679-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

