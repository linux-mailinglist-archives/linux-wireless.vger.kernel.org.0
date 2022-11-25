Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF36388E9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKYLjj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 06:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 06:39:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F11788E
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 03:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6286623B5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 11:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2476FC433D7;
        Fri, 25 Nov 2022 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669376373;
        bh=HnT47jn1b2f+jUwOPSH3bufQf+SsU7lXvXnNQX6JnKI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DvWP+8b8z0LEiP/d6XX9TUZQ7hHGOo92/Kkg+Aipe4leCohLdBr8d0Gw1XftL6XQT
         1U72hZPo9ECr0R/GdIGeUqQlg5BcMEgyXHCSg8NFYxSMQZphH9fEgavtR7zEUtukxJ
         gT4Q/S2QmeDhm3SfLadEXn/2Yjd/R3I9o1B7uEiiaN9in+3VRVwECeWUQ0MlWa5X7C
         ToAMDKXc6IlI+AXOWU9bCd8xIrKUVkZQQxVtX/xXfNJvp6d+IC8BMqe/8mTiu/0wKa
         1S0NYrR5npYBhZtJ4V0gC6mI1pT9B5ToJpVttNeBXRsZQa+yZ1mlBhcd8A/bA4RXMF
         4CaBIkiJHr0Dg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 4/8] wifi: ath11k: remap ce register space for IPQ5018
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221122132152.17771-5-quic_kathirve@quicinc.com>
References: <20221122132152.17771-5-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166937636895.32083.4258390402302531375.kvalo@kernel.org>
Date:   Fri, 25 Nov 2022 11:39:31 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> In IPQ5018 ce register space is moved out of wcss unlike
> ipq8074 or ipq6018 and the space is not contiguous,
> hence remap the CE registers to a new space to access them.
> 
> Register read/write is modified to check if the register to be written
> falls in the CE register space and corresponding register is written.
> Also adjust the interrupt register address to ce irq enable/disable.
> 
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch added a new checkpatch warning:

drivers/net/wireless/ath/ath11k/ahb.c:287: Alignment should match open parenthesis

I fixed that in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221122132152.17771-5-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

