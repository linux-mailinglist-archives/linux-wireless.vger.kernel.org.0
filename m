Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDF719D23
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjFANRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjFANRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 09:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5797;
        Thu,  1 Jun 2023 06:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84FA643D2;
        Thu,  1 Jun 2023 13:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF70C433D2;
        Thu,  1 Jun 2023 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685625428;
        bh=uHA2wAXM4LSQn/5kIWbNPzoShRHoiSA7gHIIstYntA8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=D2p4SMwUA8YhEQ5YIKtTg8+gO0invp0x7bqf/yIKI7SzFwN6PQieI7qlc2sMqfJUV
         rCQK0raZYLXHK14qtqr3bIV1rXDKjcP6Kbbv19Tsx2w/Gqb13DqZeiNspqCfYu7mKn
         ta5167g6SStja+sOM9LRsGDTgPOr9t+pLgFoLJXr4v6h2Z67Ui3u3NAKR6jW9WyW/n
         YbskrDZvBj++199sw5gJaL1oNb/79kRkaffK+2nLk2wcWNViAPPJp3w1JggcMOKAxy
         h2FtXx2/dfsimOW+sIIs3tYb0Mmjhs2MUmWy1P63XAQeDMDBAMZgKdQ9fXf+uVpXHt
         lzjSmtB2cJCKA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw88: correct PS calculation for
 SUPPORTS_DYNAMIC_PS
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230527082939.11206-2-pkshih@realtek.com>
References: <20230527082939.11206-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <stable@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168562542522.17673.4276220170409263199.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 13:17:07 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> This driver relies on IEEE80211_CONF_PS of hw->conf.flags to turn off PS or
> turn on dynamic PS controlled by driver and firmware. Though this would be
> incorrect, it did work before because the flag is always recalculated until
> the commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
> is introduced by kernel 5.20 to skip to recalculate IEEE80211_CONF_PS
> of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.
> 
> Correct this by doing recalculation while BSS_CHANGED_PS is changed and
> interface is added or removed. It is allowed to enter PS only if single
> one station vif is working. Without this fix, driver doesn't enter PS
> anymore that causes higher power consumption.
> 
> Fixes: bcde60e599fb ("rtw88: remove misleading module parameter rtw_fw_support_lps")
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless.git, thanks.

3918dd0177ee wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
26a125f550a3 wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
b408f33b35a4 wifi: rtw89: remove redundant check of entering LPS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230527082939.11206-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

