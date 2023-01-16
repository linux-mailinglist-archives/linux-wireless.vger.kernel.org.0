Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031166BFED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 14:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjAPNh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 08:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAPNh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 08:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42DC72AC
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 05:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D06B80E71
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 13:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6C5C433EF;
        Mon, 16 Jan 2023 13:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673876275;
        bh=C1qB4653XEoxY6bIu8LRh3mfvlZhJ8v/sTQu8JmSZBA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VkvNMoFFjfYs6lJFx2NvuZMdXnNxx2I907VTq2u3qRwMIv8368/QIAhWf8DQ/ByE0
         kQTIKKqn2QAK31PYRSYB+WSJfNQa2UK+8W4GlWU4yNSYk4yozEQwUiLD4CQLWKgEBR
         tpLAzr4fwCqmtcV1kV3aoHl+6nMSnE6VKZbiCw4uIqe4vIFeiAvezpRTvAE0tohCXC
         fTHd/EUCdd8A8s3AWQ/rjN6bUKTPWLOzq5yf/O6v2GUrAv06I1KSdMVC4hauJqV3ZP
         xD2A9fvAcf4lP6sJgAMLMf0Mrh7W5FHq6+dyMspje1vP4ubG83vmKQE+kZ3oiJE5h+
         W1wAa6W5y0+qg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: fix null vif pointer when get management
 frame date rate
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230106121517.19841-1-pkshih@realtek.com>
References: <20230106121517.19841-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167387627226.32134.6141531433166352792.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 13:37:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> When transmitting a packet that gets from ieee80211_nullfunc_get(),
> the vif in tx_info->control was no assigned, which will cause
> dereferencing a null pointer.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

95dafeabe477 wifi: rtw89: fix null vif pointer when get management frame date rate
877287f971b1 wifi: rtw89: set the correct mac_id for management frames

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230106121517.19841-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

