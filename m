Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42673729A11
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbjFIMbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjFIMbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 08:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C43ABF
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 05:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E02165710
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 12:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD73C433D2;
        Fri,  9 Jun 2023 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686313835;
        bh=fHSDsbEM3pf6iExg+U/gM7Vi6dgz9Oowtp7sAe41Cmk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=unDjQkK799pa3m5ecnhBKjznXRPk39B7Qe6kDqXvuxyrgsgWafMZaS8okOnurcu8g
         TkcgjM4BPS6KYMHDXRoy1rl1CEl7kvpNZHY1W0QJXwcDWLNLPvdEJvvJubvSapIY7N
         BuYkLbi7D+oNhnSWtcIWH9jxiDb83QggGD27DY/4yJFdr7eukg2//xTc2ZQrLxs61F
         t5TPKnQP8kSy4M08Tj2oz3Q4RN79+qJBwz67FOWMO/+nmPxZPjrX6cybsZfMG1gFPA
         XnxNsJY7rAY7wLwT7fPa479NX5MYbghnvf/laVdpH8xk6BuEbHfvF532tUiGW+fq7R
         WmKKBcN/CUEXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath11k: update proper pdev/vdev id for testmode
 command
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230601143214.13006-1-quic_rajkbhag@quicinc.com>
References: <20230601143214.13006-1-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631382682.10496.11328415965005011674.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 12:30:34 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

37fdb33c87c2 wifi: ath11k: update proper pdev/vdev id for testmode command

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230601143214.13006-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

