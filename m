Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47F7D3D76
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjJWR0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjJWR0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 13:26:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B6D7D
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEBCC433AD;
        Mon, 23 Oct 2023 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081967;
        bh=pRYJeBP+BNiuIIA9Fk8JjeoseAZbCclgVy26xu6dGJU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tCSY5hUJIW2zKpNnx/9yCNW7sMu70RKR0SrUP3g+HkhwKIeWDPbEjTv0yFQJ9duH+
         F/RKAMLo0hzCL+Rgkj/PeOsmBVFylUJTXLWyyhEBkvl4AouB4aZIYsQGu/T+h+l2Uk
         d06tZX5864zTHSD5aBy2vJFNPTBiicd8clBeOTNRMWP5qyax9f4ylNo3WayrwQa7Cj
         /lm0frkFcIDZAJkB3MRjxq5FKmWgpxDw6DyhS4IibMQsWjXlNXo5TS1zQ5a3OX+e1l
         n0XjbTas1N6MBIzfbz3nAhnrEUGPmNn7J4ous745jMfi15N55SjAJ69gWdx8ZS+6I7
         s6BUdlkc7Rgmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB0315BC1D83D31154924F0D39BCD1A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB0315BC1D83D31154924F0D39BCD1A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808196400.695306.3954169620503448158.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:26:05 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> The watchdog function is broken on rt2800 series SoCs. This patch
> fixes the incorrect watchdog logic to make it work again.
> 
> 1. Update current wdt queue index if it's not equal to the previous
>    index. Watchdog compares the current and previous queue index to
>    judge if the queue hung.
> 2. Make sure hung_{rx,tx} 'true' status won't be override by the
>    normal queue. Any queue hangs should trigger a reset action.
> 3. Clear the watchdog counter of all queues before resetting the
>    hardware. This change may help to avoid the reset loop.
> 4. Change hang check function return type to bool as we only need
>    to return two status, yes or no.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

69708fbb2c69 wifi: rt2x00: fix rt2800 watchdog function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB0315BC1D83D31154924F0D39BCD1A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

