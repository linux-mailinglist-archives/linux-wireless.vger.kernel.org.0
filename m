Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84B352A6A1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350005AbiEQPc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiEQPcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 11:32:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145140E66
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 08:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FCFFB81983
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E04C34113;
        Tue, 17 May 2022 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652801538;
        bh=Bxmt/HIG8Y1l9M1uiZ+B55O4s5z6M5V6YbHxU6QDr+I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UcOu0T6WnO7FBvU0enEWKM09BNmIKipZlf29Gp9bCW8FQEgFKIvTlwFjBJR3QyTeY
         palmuJCR29sLFhmadjMsERPnUSLj2He4d/ZQ6HVx/Q9ipDcfz37M8/XrO+TnGtwMQJ
         thBMrW5h80w1OXiIMJmXuH3clvkdIOwVaDvqhypoVonX5w1QqwDoFLYdO1ViS0Cdjc
         AwVeOl8/wY7NwxTcz6R40rXSbX0JCW/Jx3Mvj0Qa5Z2EwAwizQXlxf1U1d4z5RkxB5
         Q3nOZROT0pLMLoJTSaG/b1OVJ1XR9E3rRZPVPx+aZOtouAL0a9N9X2jNOdgHlmkwhR
         /9JXQc/sSKCdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] rtw89: add ieee80211::sta_rc_update ops
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220516005215.5878-2-pkshih@realtek.com>
References: <20220516005215.5878-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165280153588.3650.15868744684838045026.kvalo@kernel.org>
Date:   Tue, 17 May 2022 15:32:17 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> When peer's NSS, rate or bandwidth is changed, we update RA(rate adaptive)
> mask to ensure transmitting packets properly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

9d9a9edcf8ed rtw89: add ieee80211::sta_rc_update ops
d3efeee240f8 rtw89: 8852c: set TX antenna path
97df85871a5b rtw89: cfo: check mac_id to avoid out-of-bounds
aebc048d1000 rtw89: 8852c: update txpwr tables to HALRF_027_00_052
a06d2dd7e22f rtw89: convert rtw89_band to nl80211_band precisely
a456021c6f14 rtw89: pci: only mask out INT indicator register for disable interrupt v1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220516005215.5878-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

