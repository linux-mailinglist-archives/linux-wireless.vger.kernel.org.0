Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04944646040
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 18:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGRak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGRai (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 12:30:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0C25C5
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 09:30:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C48B81F86
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 17:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4930C433C1;
        Wed,  7 Dec 2022 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434235;
        bh=30i1vXqRb3fMeCdIQOP0sPfJGVmd4GE1adx1PgZVO/s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iQX7AiLw9v9RLbs4vo2ck/Iu5vCrtRiV8NS1Ilt8Ei9zPMslNDkCxditq5nGKeLCE
         O5WeZHJ5XMlJQ1UuF1z9fAMV9loazCwDy/0jCvoWCLhKaOOA2qtJzQm3152u7EiC1R
         ukXYpViDd19MQbKJJzjDboEW7PY51mTQ1NFIalnBzNtYPU7Qh294eXLbCzx9ZUMqXJ
         OGijK9BwEvDPZkXfe17YldjKpD7X6qgrRv54aA9cmpx1/iS1bgfI+21TRtC64JD3YJ
         dGNag5BYmwld2n7oBLoHifVVMcnZfojwt1za/zgs5ZTsLQCaiSt9X8SMi1EXI4AGkj
         qLEPoT6hw5XHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix scan request param frame size warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221205192125.13533-1-quic_kathirve@quicinc.com>
References: <20221205192125.13533-1-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167043423029.3611.17612431328299564721.kvalo@kernel.org>
Date:   Wed,  7 Dec 2022 17:30:34 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> Following warning was observed
> 
> drivers/net/wireless/ath/ath11k/mac.c:2351:1: warning: the frame
> size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> A local variable is declared with a size larger than 1024 bytes
> this causing a compilation warning. Change the local variable to
> heap memory to fix the warning.
> 
> Tested-on: IPQ8074 AHB WLAN.HK.2.7.0.1-01701-QCAHKSWPL_SILICONZ-1 v2
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

"wifi:" prefix missing, I added that in the pending branch.

Also fixed one warning:

drivers/net/wireless/ath/ath11k/mac.c:3677: Alignment should match open parenthesis

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221205192125.13533-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

