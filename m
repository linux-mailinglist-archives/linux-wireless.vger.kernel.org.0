Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A220E728464
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjFHP7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjFHP6j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 11:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C53F1AE
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 08:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65C564EAC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 15:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48974C433EF;
        Thu,  8 Jun 2023 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239917;
        bh=3Plbrxn7KCWpLcC0jv3AVDY+EFmoVpQsW7S/R2Bv8YU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Cpf/t+HAifnE8W2A1/hTftsmop1oLnuTeOk2MfJHkx+SJgaQvAuCiKhPBAOFx3pZT
         LzNmy8/kmb3oAZw4IgacLbzeZtaPhVlAhkKjXmBdNLn8nZJ1LPSyNsq0vmFhCFoqGJ
         hBcqJO+pV4bEsx/ttFghFYCYvyP4tt8+HdONl+yLMReMgG+1Q7zE4HMHQyeeYvEfF7
         zPXhUOy6sOJvwLiXm+SgaOPwVf5mhzgh6pfuoV321q2YkSYMtKcraQ4aKpGPwjBOUB
         kdeVxqfSPz1PUOFYT9tyk17TTedy981y5SMyZNv0CxdZeZoN6dUWWxau3LCz3dBT0M
         fVTq16pAgwEpA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: 8851b: enable hw_scan support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230531060713.57203-2-pkshih@realtek.com>
References: <20230531060713.57203-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168623991153.5828.1887352097920457525.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 15:58:36 +0000 (UTC)
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
> This enables hw_scan for 8851b after firmware version 0.29.37.1.
> Extend the channel info struct with padding zeros so newer firmware
> can work properly, this change is backward compatible with older
> firmware.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

9c52e8bf07c7 wifi: rtw89: 8851b: enable hw_scan support
b25e755e5e41 wifi: rtw89: debug: txpwr table access only valid page according to chip
db67b03b04b4 wifi: rtw89: set TX power without precondition during setting channel
57369e2aa2eb wifi: rtw89: 8851b: configure CRASH_TRIGGER feature for 8851B

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230531060713.57203-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

