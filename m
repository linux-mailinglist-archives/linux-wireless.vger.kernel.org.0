Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C997C71FD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjJLQEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbjJLQEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 12:04:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA0CA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 09:04:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B49C433C7;
        Thu, 12 Oct 2023 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126682;
        bh=0a8q07czlG6HQ5qQfZp5nEWDBqfgNcc/HJ7dGSCrRW4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lJEgfKi0fgm90QstBoW3qr7+5m0jzyM3B2PD5yZerbXZqUDiKPm+XKjX2YHhx/7SG
         rO5EOHg7+nOQ6oYntvtGvsno/zbnAYjqVl8zbnbyP5QYOthdMGccoaqUrkjQgCtHkw
         B7ZSsNiquH7NJyvwiaH6ov9zZnQq4PvHv282aMSCqZSPBLHMHj28/Ku/k+uyyA29F8
         uRkv8l5vSH6xpDR1JlgbP59GgIy4xQtDKE9B6NgGj+7LJVsk2ShcjPt2OoZyR1U2XY
         JF5X2MNMHbHCQUwNljwDi/5zsEt24nw0EdV2zzZoAlEtkWJAlZlfzijAw8ixtRza1m
         j+DWIt1I3yrkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: ath11k_debugfs_register(): fix
 format-truncation warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231010062250.2580951-1-kvalo@kernel.org>
References: <20231010062250.2580951-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712667989.3501995.4611783426919308415.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:04:41 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> In v6.6-rc4 with GCC 13.2 I see a new warning:
> 
> drivers/net/wireless/ath/ath11k/debugfs.c: In function 'ath11k_debugfs_register':
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: error: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size 2 [-Werror=format-truncation=]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: 'snprintf' output between 5 and 7 bytes into a destination of size 5
> 
> Increase the size of pdev_name to 10 bytes to make sure there's enough room for
> the string. Also change the format to '%u' as ar->pdev_idx is u8.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a47111663491 wifi: ath11k: ath11k_debugfs_register(): fix format-truncation warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231010062250.2580951-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

