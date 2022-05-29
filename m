Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB93537052
	for <lists+linux-wireless@lfdr.de>; Sun, 29 May 2022 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiE2I3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 May 2022 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiE2I3o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 May 2022 04:29:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81456FA2
        for <linux-wireless@vger.kernel.org>; Sun, 29 May 2022 01:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E65CCB80AB9
        for <linux-wireless@vger.kernel.org>; Sun, 29 May 2022 08:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFC6C385A9;
        Sun, 29 May 2022 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653812980;
        bh=q0EHEaQifoNSeIRcX0nIMWnBLf+KFpRZjK2hMP8ry3s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uLcEdiNEOOHeTcoL2yFFbT7kq/SPoh4mBc61tiuZh1BuLbdSCq81YLFdURZl03eQR
         0765yVH08IJoFc5nAdAo64dz6vFEGDKGrDAwUIuwWYebOZv07wzSH5uwMgVfhLLXg0
         ZbRONT5t0DJGYCXpryRSLHMXkgWw+Mvxbq/dTJ+zOaHoIeaEloMRQYEsrKC/NArSQD
         ANZa1bmQc/LMwe3k3+nvh3Uw62T0EyOfdoZ9Xq5q2rKP8Io/xDXvbeQcg85gsd4s7z
         i59vKDDh5CD46neZKQc64n1fY6u0o58pAbkYxxtWMVuCrq83L5NYc5XhwdqLsCyIHx
         MeQuwPAQ/exnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: pcie: rename CAUSE macro
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
References: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165381296442.13565.7947896885459495012.kvalo@kernel.org>
Date:   Sun, 29 May 2022 08:29:39 +0000 (UTC)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> At least mips64 has ist own CAUSE macro, so rename ours to
> IWL_CAUSE to fix build issues.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: c1918196427b ("iwlwifi: pcie: simplify MSI-X cause mapping")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

As this fixes a build failure I would like to take this directly to
wireless-drivers. Gregory, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

