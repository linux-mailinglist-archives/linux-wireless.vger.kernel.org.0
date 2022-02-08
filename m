Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52184AD737
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiBHLcA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 06:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbiBHLJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 06:09:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF6C03FEC0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 03:09:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B0CD61534
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 11:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2FAC004E1;
        Tue,  8 Feb 2022 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644318539;
        bh=rdR76wip6LTIaVQW9tpCx04sy+vg71IYJnK49c2+b8M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Sdt4HzF7R9c6xmNIQ0GrnPFuIUTTDUAPt1mULid6+FlUFSTDtkl3ECx1f8MIQcYpc
         etvG6/s07tzypbTW3yNhrdu/1m1Y0fTDga84cTQ4tO9V7Hgx5DsMrarsflGtlB9+Gv
         ybZM8ic/7il5W543tk7caqJk8JuhmG+BPQjPoWBcwIo/RO6CY4pBHWRUowgMR2a521
         EIF/W342zVNYCvZLo79zyiU7Y9NMkxn9DSNFInErl6J10vCYuqRO7DcCWZ2VkRs5WA
         ZX9ss8hNQbMkgJd27Q077mgVUIp0kHrTY89TvX0mHGKaxUXueyYO8P4tnar/dEtTL6
         7RNUt5BNT6Hlw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     ath9k-devel@qca.qualcomm.com,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: QCN5502 support in ath9k
References: <CAKe_nd1jthFhJhojQLXMeU741AoTks74K+J1v5FqS6ABB6gW-Q@mail.gmail.com>
Date:   Tue, 08 Feb 2022 13:08:55 +0200
In-Reply-To: <CAKe_nd1jthFhJhojQLXMeU741AoTks74K+J1v5FqS6ABB6gW-Q@mail.gmail.com>
        (Wenli Looi's message of "Tue, 8 Feb 2022 02:21:18 -0800")
Message-ID: <87r18d1upk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> I'm wondering if there's any plan to support QCN5502 in ath9k. If not,
> is it possible to obtain the initvals and other information that would
> be required to support QCN5502 in ath9k? (such as those for QCA956x in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/ar956x_initvals.h)
>
>
> For context, I have recently submitted two patches that seem to allow
> QCN5502 to be fully functional except for the integrated wifi:
>
> * https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=a0b8cd5c223042efe764864b8dd9396ee127c763
>  
> * https://github.com/openwrt/openwrt/pull/4271
>
> Thanks!

Don't use HTML, linux-wireless drops all HTML mail, I don't know about
QCN5502 support, but hopefully people see your email now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
