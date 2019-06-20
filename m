Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440824D62A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFTSFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 14:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfFTSFC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:02 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053901;
        bh=Tet6We5LAT61iq9rXmZ/ioron9PWqR4Z/wAcFJW+uaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d7EaMCPtv36/flzGtvzmdqYDIefPRc5U8lXJV1Ds2TkZj5dbEOUXFFqq1SZt8tOYs
         BrShsDXKQphFXBUFJrhmPptrObSPZUsh8CpxOMqOnM2RbmvabaaKCADp7OPs3IiWsW
         hTDSmXdd8lerA+FTxgRD+g0rqW9aL9piJdB99UtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620111602.17958-1-ulf.hansson@linaro.org>
References: <20190620111602.17958-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-wireless.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620111602.17958-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc4
X-PR-Tracked-Commit-Id: 83293386bc95cf5e9f0c0175794455835bd1cb4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6331d118ac61454ee52d5f9be098e9ddab6d6572
Message-Id: <156105390175.28041.11147339547209360887.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 18:05:01 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 13:16:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6331d118ac61454ee52d5f9be098e9ddab6d6572

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
