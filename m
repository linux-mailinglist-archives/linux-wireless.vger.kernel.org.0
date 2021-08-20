Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20D3F323F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhHTRao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 13:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhHTRao (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 13:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3B92361101;
        Fri, 20 Aug 2021 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629480606;
        bh=91wtAUX0DHAjf77wynlTZ8bGyj3vdwhcJFsT3qQW2Vg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ANvmzkfOZNfAHtiSxa9L5nivc0tYD6HTD4RKX9pJSEuDoLztqQc17xiFTuCq1lRv8
         lzifylImXwFz2k0zBN9NB7c2REVYW9hwAh9rxRQDocWI28qc+gUsUX25p9NBItAQU+
         F32X8WJKGmzFxxj6DAXtDXNOI27qmBHLF52Z07o2ZmyPODGMG+Ufj3FosIrwCVGy8i
         H95QezmgDTwLbh83w/VtN+a4XaeuzI7qnGpJghztCn2CjAg0FFI2IgSzu4S3Yhk8U2
         0dIsFabQNO/MLOkFlHZE5g3gG2UjazGPlXHar/zhDygaF1cugOgYLcXC8SK+3Zd6I1
         7mYrOPygDpLWw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2E17260A6B;
        Fri, 20 Aug 2021 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: mac80211-next 2021-08-20
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162948060618.10361.9672929543729098480.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Aug 2021 17:30:06 +0000
References: <20210820105329.48674-1-johannes@sipsolutions.net>
In-Reply-To: <20210820105329.48674-1-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (refs/heads/master):

On Fri, 20 Aug 2021 12:53:28 +0200 you wrote:
> Hi,
> 
> Just a couple of smallish items, in case we get a release.
> I expect a few resends of other things, but don't know if
> they'll make it, we'll see.
> 
> Please pull and let me know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: mac80211-next 2021-08-20
    https://git.kernel.org/netdev/net-next/c/4af14dbaeae0

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


