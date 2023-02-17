Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267369A835
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBQJgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQJgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:36:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA734B507
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C10EB82AA2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C3C433EF;
        Fri, 17 Feb 2023 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676626573;
        bh=Xc7AtEAwkRCCPDVP9wWJ5wCC7a7dqrMZztj5mpDUJGk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TMUJSxtmjSFDmJx6CsQZ8JbwiMB4g3y2fJp2mP4a5sY5Koq9OZgwE2s0U1L9M7C3t
         xZBI3IxiyMcC7/S6m9QyKefBrwryebEmYf4PpzYbq+M6OGffBgBaYgyHF/q/LJrBY3
         yVKQFF3/G/SQ0Q8cIEd8l7ARDussW2BYW73GsEZwHHqq5s0GZfd6RsWV+48wILrYup
         O2DWIjK9Ps4r1csEkIsjzTq+PbSLwyZV1tFlbBtUqX1MJSPX1pcJcyun7+uJ+R8MYt
         rre85X4yzLbrvE9SOw4mxgSWxgYUn26fpptz2sVPP1ppHNHjUKg8o/iouy/DKNxpkH
         FM+iQqkbt9ujg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlegacy: avoid fortify warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230216203444.134310-1-johannes@sipsolutions.net>
References: <20230216203444.134310-1-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167662657011.23451.3229061993310328477.kvalo@kernel.org>
Date:   Fri, 17 Feb 2023 09:36:12 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are two different alive messages, the "init" one is
> bigger than the other one, so we have a fortify read warn
> here. Avoid it by copying from the variable-sized 'raw'
> instead.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

3a156b52c73c wifi: iwlegacy: avoid fortify warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230216203444.134310-1-johannes@sipsolutions.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

