Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD37316C0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 13:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbjFOLfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjFOLfx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 07:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92598ED
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 04:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230AC62833
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 11:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9735AC433C0;
        Thu, 15 Jun 2023 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686828951;
        bh=HRKs8EDAMspjkc4t+uSo5TJHix7Rge5uKAkGMWz4HuM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TtpHxPUX/FT1K6E8TAqgXlrquSrQWTe7UjZkbStkfBNjBK54jy9Dq91tOMX0ZurWq
         zg8Q9iQ6WjoxQnftPEJx0gtUeeKKN004PJrdO2V3v6F2PRXBHa7CCO5yd4A/SvL1LH
         35Aj9aLy1R3cdBCRfF6oggdybHQ3YfPDGiGToRqd9wqTH3fWQoRoaxiWefcn3SilHF
         15FbPFChl4BFFqQr9L55+NRQlQ3SgQNr8AQOQGWdFp1rfGry75lX1uJji5IEYvzc87
         2bKdJ8VxRByT2BA6aJH0x9kgeV3mUwioUDowi1NvfZbLMdmxlYmBEbcCKvC4rV3KYR
         cyZCV6YZcY1sA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix conf_mutex in
 ath12k_mac_op_unassign_vif_chanctx()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230608104444.3134-1-quic_wgong@quicinc.com>
References: <20230608104444.3134-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168682894712.15751.14642356726851590142.kvalo@kernel.org>
Date:   Thu, 15 Jun 2023 11:35:50 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> "mutex_unlock(&ar->conf_mutex);" is always called at end of function
> ath12k_mac_op_unassign_vif_chanctx(), so delete this unlock to make
> sure lock/unlock is paired.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3a5d50f8eb4f wifi: ath12k: fix conf_mutex in ath12k_mac_op_unassign_vif_chanctx()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230608104444.3134-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

