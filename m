Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2730E6A52F1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 07:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB1GY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 01:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1GY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 01:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AEDB750
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 22:24:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AC4B80BD9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 06:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF59BC433EF;
        Tue, 28 Feb 2023 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677565461;
        bh=aNBDcYizuw33x+2Dz6pUASN6ePubshvhAiLaTRm7m2g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PJ/Bgr50bPKJS33ae6dfmKKoE9Q5DtAFiwiYMtUzfINh2QDKkOXap8ZOxkwbIEvRW
         71bnF8h7TcmIBeJEte0kUkPzkPUvvXKPKB1d7/Q9iNfa+a7tQPm1msMEQ+XNKHPI+T
         XFqMho+4UQG62lXOhAGzZC3kl+y2UfatHINBivtUmDnkIJJZ9tz8VNLsd0i3P8ZRmc
         LPWn/qMhW1yIz5a4kFjPSJ8CsmNEsZlKOrEzXKXkXf3lYvFJrwI8xj9lmeUJnbbmEp
         fq+kCJj2tHnNAN5Xg5n5AQDyTgKKYTFDjSJvCwmV1ymnRn8lwaPUNBLBpJz7rpNpzI
         5CTexPNyu1APw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/3] net: wireless: use struct_size where appropriate
References: <20230227203927.3662811-1-jacob.e.keller@intel.com>
Date:   Tue, 28 Feb 2023 08:24:18 +0200
In-Reply-To: <20230227203927.3662811-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Mon, 27 Feb 2023 12:39:24 -0800")
Message-ID: <87h6v61f59.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> This series fixes a few wireless drivers to use struct_size rather than open
> coding some equivalent checks. This ensures that these size calculations
> will not overflow but instead be bounded at SIZE_MAX.
>
> In the first case, the code is first converted to a flexible array, which
> saves a few bytes of memory in addition to the fix with struct_size.
>
> These were caught with a coccinelle patch I recently posted at [1].
>
> [1]: https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/
>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
>
> Jacob Keller (3):
>   wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]
>   wifi: cfg80211: use struct_size and size_sub for payload length
>   wifi: nl80211: convert cfg80211_scan_request allocation to *_size
>     macros
>
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  7 +++--
>  drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  3 +--
>  .../net/wireless/quantenna/qtnfmac/commands.c |  7 ++---
>  net/wireless/nl80211.c                        | 26 ++++++++++---------
>  4 files changed, 22 insertions(+), 21 deletions(-)

I don't see the actual patches, only the cover letter. Also nothing on
patchwork:

https://patchwork.kernel.org/project/linux-wireless/list/?state=*

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
