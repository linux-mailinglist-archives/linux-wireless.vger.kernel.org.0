Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677076E2329
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDNMYm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDNMYl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E968B748
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF2064782
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEDFC433EF;
        Fri, 14 Apr 2023 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475070;
        bh=//GcoP8kU8gzHbpqhP/RMEH5Vr+ZskY+Igcf18jQC78=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xt0rk75OTh5sOD1qW5DdgCTun6CKpElxXOXamumvPnVMgaGlX1dJku0k5zzj1wnjR
         vczvPuUOsNSvC6rWudPpWK0GsD+bBgqOZa45FvCrWLC1kpczC6uSDKRwX0dY3x1M1M
         /SMqcuFdYz8Fqob0ycCnNlNODV3GNd73DfJejlJfa2v5dWfPeu5j7d4SvluYJ2MrMm
         1YlM0+CR5qUh0Pf1ebPSg4AHDbBVxfcNt4O+XMQXkRVQdTFEnJM306aqDh4ou1v6sO
         StINUAGM7NsQ2+Y6NiTm5EQmk57ErkGryyn9XraAbn6azcmnAd+yT8AUugDLOCS5VP
         EIsXb4LDmyERg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: 8851b: add BB and RF tables (1 of 2)
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230401142548.55466-2-pkshih@realtek.com>
References: <20230401142548.55466-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147506759.16522.3368520394244334.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:24:29 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> These tables contain BB and RF parameters that driver will load them into
> registers. It also contains TX power according to country, band, rate and
> so on. Increasing thermal can cause TX power degraded, so power tracking
> tables are defined to compensate TX power.
> 
> Internal version of these tables:
>  - HALBB_029_106_15 (V17)
>  - HALRF_029_00_089
>    * Radio A 0x22
>    * NCTL 0x5
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

108bdaaa8bc7 wifi: rtw89: 8851b: add BB and RF tables (1 of 2)
cf4917cf0ab8 wifi: rtw89: 8851b: add BB and RF tables (2 of 2)
8c36cf0df434 wifi: rtw89: 8851b: add tables for RFK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230401142548.55466-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

