Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEF530313
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 14:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbiEVMbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiEVMbC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 08:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A2DF1
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 05:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFCDCB80B34
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 12:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A221DC385AA;
        Sun, 22 May 2022 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653222656;
        bh=BYVDciy1MFj7bFAO0Jc9HGcx2iNA66NF58AjAeNr7pA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Cm5EzfPS8IR4k+5iuSwFBZXPSF+lkutXa/VARPsRhSTDoF0vhWVDhLLP2Es1E4wtB
         G6r76lXemWx+SZwu86MKepZUeFEDPqnigguZswSBUTdl+OksV7VoYd3Hgx7NbIdwDw
         niep+V9ypsv8WG7KDQOcAIho79es997P8phuDIf1E94pzt+LAmASYaNuSSTeCFJdgd
         YmkbgwoddSU8EIF9URMJDMiigiheMoN6U9A5lleHU65Z240a7lDlEKjE/Nvv07HVGX
         TzQUdLxmaQhg5cduJo0eeYQSh1OH6VQ+2mUUlmfNEqI0e91azBqJOO4D1AVKhsGniv
         wbjqLRhGPlt3A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Init hw_params before setting up AHB resources
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220517055241.15885-1-quic_mpubbise@quicinc.com>
References: <20220517055241.15885-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165322265355.774.15991530710426373571.kvalo@kernel.org>
Date:   Sun, 22 May 2022 12:30:55 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> As part of adding the support of WCN6750 to ath11k, bus_params
> were moved to hw_params and this regressed the initialization
> of WCN6750. By the time AHB resources are setup for WCN6750,
> hw_params will not be initialized and therefore initialization
> for WCN6750 will fail. This is applicable only for WCN6750,
> no other device is impacted.
> 
> Fix this by moving the initialization of hw_params before
> setting up AHB resources.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Fixes: 00402f49d26f ("ath11k: Add support for WCN6750 device")
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

bebcfd2534a6 ath11k: Init hw_params before setting up AHB resources

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220517055241.15885-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

