Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9747BD3DC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 08:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjJIGzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345355AbjJIGze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 02:55:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C4C5
        for <linux-wireless@vger.kernel.org>; Sun,  8 Oct 2023 23:55:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A540C433C8;
        Mon,  9 Oct 2023 06:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834533;
        bh=b6Xh6O6n49XPpKfm8i9zCCwXi/HoiowiivOCuTjFgDE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J5FGIQzWwBQsZw25LRavYwzlixxlXk/bRLo1oyV3M2WTSqXoy2bCsQ9p/YhJb4L2M
         FaxxS4lJ+pnqJcIdqeMuHRqXAbwxSuRkShY3sDDV8IMbYvcnCi9sbtWhgYX/ok9c6/
         jGWT8KYZgAKoL+8zBalxJL8fRJffkbIm9FeDRq2zbh7/VKnq7ogVy7r1OUgofQa/F9
         jYp35qssX7SxErs33MzqYmL6E/qguFz1VUrF8K135g4lO6ngBUahOUImYpz4QeMfwF
         LMcTaXjrHdhcOpI1GbZcCYKrQUNeVjeRNFcyoH9OSzFy4WRmP0gHayOwGrcf+USYrU
         ThxFuGN4f1Gvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw88: regd: configure QATAR and UK
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004085051.205683-2-pkshih@realtek.com>
References: <20231004085051.205683-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169683452999.2071896.70327529099255597.kvalo@kernel.org>
Date:   Mon,  9 Oct 2023 06:55:32 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> In newer Realtek parameter package, Realtek regd can configure
> QATAR and UK individually. So, driver extends the regd enum.
> Besides, driver configure alternative of them which will be
> referenced when parameter package of a chip doesn't consider
> QATAR and UK individually.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

0c1784cbe62f wifi: rtw88: regd: configure QATAR and UK
5995ec73ef2c wifi: rtw88: 8821c: update TX power limit to V67
9c2651f6a9ba wifi: rtw88: 8822c: update TX power limit to V70
02f697ab2213 wifi: rtw88: regd: update regulatory map to R64-R42
14a5b11532e8 wifi: rtw88: 8821c: tweak CCK TX filter setting for SRRC regulation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004085051.205683-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

