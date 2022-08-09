Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE858D362
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 07:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiHIFyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 01:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiHIFyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 01:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6101CFF7
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 22:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4415661188
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 05:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA88C433D6;
        Tue,  9 Aug 2022 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660024446;
        bh=jQ0kU5VacR4/MhpAU4KNFqJoD8xssRrISESwfGrjIPU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JH1ULRoyIqeYNmWnJioqTm4zk8fDSp5CE4Z0+zwID8hwmmjzl9LKzUhW//cUZfROf
         P/327bp/BHRbrVp/IT6ATZ5KghW2ueCToqbMTh9r1JaGcq1EFp2ZvJw6hjg9UW3A3G
         Yo+Wuel/gBsMbTdZSedQYhDH1NudhZ5UADKPM1DHqqlr10LEkmSl8fA4H+JEwUZJ3S
         oe4kTX7XpzRIiJFIFqYq8ZcFTs/8sbCakd1LjukLuosbw76EIUEOiXAOC49Dql6PBV
         uH6bRmQeJYzmRo4/RsNYZK+WFHnxMvL6tbPkQTbnZem7dQwOlkXZGQav6gxxYUMnMO
         /AzCLzD3XVXHg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw88: add mutex when set SAR
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220713084758.41654-2-pkshih@realtek.com>
References: <20220713084758.41654-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002444357.8958.15363617243443832259.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 05:54:05 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Applying SAR will access hal data, it should hold rtwdev::mutex
> to avoid hal data changed during setting flow.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw88/main.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtw88: add the update channel flow to support setting by parameters
Patch failed at 0001 wifi: rtw88: add the update channel flow to support setting by parameters

7 patches set to Changes Requested.

12916288 [1/7] wifi: rtw88: add mutex when set SAR
12916289 [2/7] wifi: rtw88: add mutex when set regulatory and get Tx power table
12916291 [3/7] wifi: rtw88: add the update channel flow to support setting by parameters
12916293 [4/7] wifi: rtw88: fix WARNING:rtw_get_tx_power_params() during HW scan
12916294 [5/7] wifi: rtw88: add flushing queue before HW scan
12916292 [6/7] wifi: rtw88: add flag check before enter or leave IPS
12916295 [7/7] wifi: rtw88: prohibit enter IPS during HW scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220713084758.41654-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

