Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B964DAEF2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 12:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbiCPLhC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCPLhB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 07:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E64275CE
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 04:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9176E61671
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 11:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CEFC340EC;
        Wed, 16 Mar 2022 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430546;
        bh=R26zP40G4bx4aXQtrRtqCtRbPpetQ1qRyleLrW/uvrM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Tqd8Deszp7XPWTUnYnECJD9HbiYs9uJB/pp0Ns5El9oEG84MioDt+m+vRvVX9pX7T
         EXX5Kd0WwsA4HW9rF01nzrU7Yocu+DzTarS9bIprAaKYklMhnkjTtmwbA4fKgRzafy
         sKghMjd1lBEHUtJWoULutD2aJPC9yesYk3JC3QAdUL/Ph6XcubsG+KKNnFVu2f1Q6J
         MqG4Qjsud1wtc2vlyRebGOOLY0bX6JQ2Ctp0KQb6x8LiJfD0Wi3MVcluMKOdsKQ3BP
         ORUGNYm1PfxkYDHF0pg8Zia949AJp6FwkyYlvlJQjSH3CCNjrD/PdhlSRRrHkDD8z/
         zMujCXpvNr0DQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "ath10k: drop beacon and probe response which leak
 from other channel"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220315155455.20446-1-kvalo@kernel.org>
References: <20220315155455.20446-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164743054137.26015.17991500615716853281.kvalo@kernel.org>
Date:   Wed, 16 Mar 2022 11:35:44 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> This reverts commit 3bf2537ec2e33310b431b53fd84be8833736c256.
> 
> I was reported privately that this commit breaks AP and mesh mode on QCA9984
> (firmware 10.4-3.9.0.2-00156). So revert the commit to fix the regression.
> 
> There was a conflict due to cfg80211 API changes but that was easy to fix.
> 
> Fixes: 3bf2537ec2e3 ("ath10k: drop beacon and probe response which leak from other channel")
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

45b4eb7ee6aa Revert "ath10k: drop beacon and probe response which leak from other channel"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220315155455.20446-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

