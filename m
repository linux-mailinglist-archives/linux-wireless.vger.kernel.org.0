Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6D6E22E0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDNML6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjDNML5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A29EDC
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5193264717
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88E2C433EF;
        Fri, 14 Apr 2023 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681474309;
        bh=zMPeIY0kqAtYEBPYCzbb1y6SR0gfRiq8sdxWR35CDZI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZNDsHgToIV7KjLuWgvf0gVLG+Y64iJJDKmknuQdG+BcYZNNkXqx/q2q4H/VhV7Z8m
         c50Bd0cnZHGHp58rM863JqZ3QHjyYh2byD6T2bXQHoJyDF3FsSttlDdu9OQAjDN0IG
         2usepbvLNuU7Z8vgyG7y9vOxzoKMJ6fog5WuKNpFMEL/MhRVNtuLhHWYjplcQrwQQV
         f/Mx9hbBN/8cSBffCFTD1fUWr73Gbohs36781L9fpf3E1G0d+K3wAzId5yUUE/KES9
         z5MPkzleL9OuDkWp154Ei/kuE4I+GWKsYa/wistciEDItuIenWleXMU5OZcaL6K5r4
         xBFs4YVVcZ7pQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/5] wifi: rtw89: 8852c: add beacon filter and CQM
 support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230411124832.14965-2-pkshih@realtek.com>
References: <20230411124832.14965-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147430584.16522.8827637833204761088.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:11:48 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Adding this supports beacon filter and connection quality monitor.
> To make host CPU wake up less, let firmware perform signal
> monitoring and beacon processing, then notify driver upon signal
> changes or beacon loss.
> 
> This feature needs firmware 0.27.56 or newer to support it.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

d2b6da242454 wifi: rtw89: 8852c: add beacon filter and CQM support
1ae5ca615285 wifi: rtw89: add function to wait for completion of TX skbs
a0e97ae3f332 wifi: rtw89: add ieee80211::remain_on_channel ops
6cfb6cc20a61 wifi: rtw89: add flag check for power state
c5280e5f6763 wifi: rtw89: fix authentication fail during scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230411124832.14965-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

