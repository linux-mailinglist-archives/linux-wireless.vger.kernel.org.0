Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9597B6BA8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjJCOcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjJCOcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 10:32:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE0C9
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 07:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09B7C433CA;
        Tue,  3 Oct 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696343517;
        bh=R5knwHQOjR4bemaMdQJFUcGFqhQhw6tbKDueE1VtNyI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JQVeDhfVTRwSCypU6Hx6PhuZkTJYBvYmUWu1tDnhTTDR5G7G5xzVIcZi00rh7LpfU
         xfLk9JO9u6uU8e051oVzbqQdp+2TYi3rSVnhiaGr4jPtvwruNCrHflev7KfNtdvqEI
         zCbVKyPw5RZd40Z/Fkv+kJ3Ru0YlPeBgpvSWmrBRrNGS8lLWI7GMwsHJUrkU2MN+Hz
         LHg0G5t+7l3lYX+to4DLSfmDRf4bTZV6+8d/OSJCUw7fR93NfuOrXeR9V4CH11kz4d
         cDPPmAAevmSsHM+eLj2vJJY5UpfMu8T9Bzhvx9juHDRCmqA5v5rfDEBmJbE8f+SqUM
         eUMoG8W1iuKRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] wifi: ath11k: fix Tx power value during active CAC
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230912051857.2284-4-quic_adisi@quicinc.com>
References: <20230912051857.2284-4-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634351476.120947.13624704208026863471.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 14:31:56 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Tx power is fetched from firmware's pdev stats. However, during active
> CAC, firmware does not fill the current Tx power and sends the max
> initialised value filled during firmware init. If host sends this power
> to user space, this is wrong since in certain situations, the Tx power
> could be greater than the max allowed by the regulatory. Hence, host
> should not be fetching the Tx power during an active CAC.
> 
> Fix this issue by returning Tx power as 0 during active CAC since it
> is known that during CAC, there will be no transmission happening.

The returning as 0 doesn't seem to match the code. Should I change the sentence to:

"Fix this issue by returning -EAGAIN error so that the user space knows there's
no value available right now."


-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230912051857.2284-4-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

