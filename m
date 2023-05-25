Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FEA711092
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjEYQLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjEYQLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 12:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF21B6
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2657164751
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 16:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF111C433EF;
        Thu, 25 May 2023 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031073;
        bh=dKI1coD7ah1DWH/RjD8YoJ1O3N0Fb39DzbMKepdNzlU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=i5bVwC86FBXCGKMIijeVtd1HQz6NPZQhoIpkWR3C6wRGki/SRPyXsWbsRO8/yV4qZ
         aPahPm2elaCHzBGRgTLtAP4g8O9MbF20PqR/zXPNApxeSAvUJ2XXit9r8eQ7vy9WMh
         /1aPym7q0Tba08TlYA6FOjIimyHo9vZxzWg54fC3J2rl2iij8vO2JAQ3e2BWFIpeKA
         j3WEEaGokxxlv0I0rF38FYD2wwelzyol8dpOL0sGfEJLO0bh51qiHw3+eb2oXPf00P
         WZ4QNufxVchXZ1AWGOUlwV/GyBKLwNeL4lyd9aLvcht8onedHUv+wud8WaNLJ5wKH2
         9J5ouDYhav29g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: ser: reset total_sta_assoc and tdls_peer
 when L2
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230516082441.11154-2-pkshih@realtek.com>
References: <20230516082441.11154-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503107072.22756.9472067177641035272.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:11:12 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The total_sta_assoc and the tdls_peer are used for statistics accodring
> to stations' information. L2 (Level 2) SER (system error recovery) will
> call ieee80211_restart_hw() which re-invokes sta_state ops. And then,
> the total_sta_assoc and tdls_peer will be re-increased. In case wrong
> statistics results, we reset them in SER L2 handling.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

cda66049bab5 wifi: rtw89: ser: reset total_sta_assoc and tdls_peer when L2
b79a84fbbdb0 wifi: rtw89: tweak H2C TX waiting function for SER
8b21c08ef7df wifi: rtw89: refine packet offload handling under SER

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230516082441.11154-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

