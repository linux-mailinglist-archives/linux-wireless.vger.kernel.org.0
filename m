Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702463398B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKVKQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 05:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiKVKQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 05:16:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAE51328
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 02:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5DF615F8
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 10:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA57C433C1;
        Tue, 22 Nov 2022 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669112191;
        bh=03qm9kckWJVYUyvndknLhNDVE0U1i2uqs8jGp1LCGDA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eyJI7LXrztY/yGdHfZBaU+NuWd4SbSOgajtnAsn9QWXThDqpRRgIaaE9vi55yjnfb
         DNgL1jTgJzmHmRuXz+YEJLc1R6R5pe005J2yK0I4A+Y2lg06Wdcb+wBkO+3G3A3XYy
         uTiUG+aoV0ZWOCTgCXlvZBA6Tz/L+PayXTd11pmacAiGU09OG/aIYz81xBzEcHM/5t
         HeQgVI43DT6lo/YbNU6NwqDpzGcX+A5CJZBQYJrTleqr0nK/SMR6qXgIJBR2aRljpD
         ZUY1Zbc7/NeeQnFI6QRkvVUDHmrRHyjJVBJ9R+jntDVepfyZABBrU7f0pDmCDonzmj
         xvlkwhYi+AY5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix physts IE page check
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221118042322.26794-1-pkshih@realtek.com>
References: <20221118042322.26794-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166911218913.12832.3451158823940582982.kvalo@kernel.org>
Date:   Tue, 22 Nov 2022 10:16:30 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The index RTW89_PHYSTS_BITMAP_NUM is not a valid physts IE page.
> So, fix the check condition.
> 
> Fixes: eb4e52b3f38d ("rtw89: fix incorrect channel info during scan")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9e2f177de1bf wifi: rtw89: fix physts IE page check

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221118042322.26794-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

