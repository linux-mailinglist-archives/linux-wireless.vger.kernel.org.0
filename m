Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F307B2220
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjI1QU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjI1QU1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 12:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF35B7
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 09:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D08C433C7;
        Thu, 28 Sep 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918024;
        bh=QhL4AGLoqi3mblUrblfILODEI3FfTwjkplDMWY3+gWM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=a3PVDDe63TGhrNSL0vy9pUmrDZtRqVz76TGGE3rATACszzmLmTbw/rjennX4MAU7L
         afk1Ab1hHPqMVewxlkru1PVZ8YaPgO1enQec2b7GwZhs/Nfk+1SEuZoifPjlYrP9Tn
         FV2p9rL42am72OgRe7RtJmKJ+ydxcV7CNLbCmv40o6E9qw6wFzVemNH9XfEQyXXL/z
         JrQfdmzG+9DL/ovJknfhse0SDGBMoLQfakS3CBJvCDTt1U+xjxk9IdfVA0fU/OT9fM
         W52E0u6GHqIHyhYP9FrvQuF8wm4Dv3CHciHPmp6ppIUSIHwWG/tA5/7oLH0Xu2KOr8
         MMwAVdqzln1EQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] wifi: rtw89: refine uplink trigger based control
 mechanism
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230925080902.51449-3-pkshih@realtek.com>
References: <20230925080902.51449-3-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591802194.3187104.18062067562610023067.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 16:20:23 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Rename support_ul_tb_ctrl to waveform_ctrl since we need to do more
> trigger based control and the naming could be confusing. Move related
> code to leaf function so we make each functions separate and can be
> easier to maintain.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I don't see patch 1 in patchwork and I see patch 3 twice. Please check
and resend.

3 patches set to Changes Requested.

13397427 [2/3] wifi: rtw89: refine uplink trigger based control mechanism
13397424 [3/3] wifi: rtw89: Refine bandwidth 160MHz uplink OFDMA performance
13397426 [3/3] wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230925080902.51449-3-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

