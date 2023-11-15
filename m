Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348BE7EC803
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjKOQA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 11:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKOQA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 11:00:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE8194
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 08:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6AEC433C8;
        Wed, 15 Nov 2023 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700064025;
        bh=oScyJ9KTvIxBPm63+sx7MFVp+HeKppRXpPKIyCGg/68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRrdm9bz4B+hH4AvDLZ7ERP2i0pijDhkqdH2x8oEbVMwN1n56R9v0m1X/7qLicAeI
         Hk3fFzLQ6cNrCD03Ue2OXniAVuh6N3pW6fEBH2Hc02RkF3chnKsM40MYnIjwx5UWJa
         oZDCofS5HuHb4vN0cJtB1mxWCaGJykobrNUBKWrMkWY4QaEkVgKntSZC7/vAHAfOJb
         Q2oA7Zvy8VFTINqV5oLgzyvjD5BYM9U5Ii2NBfWM2wgWGM7L84mFVxdI5xY0+bjuOZ
         CqcNVdyQH5hVsLYGqdWU4XQQ66qQbPSNQ62/p1sgContGOXo6P1WMsV3+TpGqAb8pF
         xyDOwSG4dvJug==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3IJT-0006dG-31;
        Wed, 15 Nov 2023 17:00:24 +0100
Date:   Wed, 15 Nov 2023 17:00:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: cfg80211: hold wiphy mutex for send_interface
Message-ID: <ZVTrF7xPsf-JseJ5@hovoldconsulting.com>
References: <20231115130615.b1ccadaf9e13.Ic207e2f99f806e9120278f92fdebc2822842c301@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115130615.b1ccadaf9e13.Ic207e2f99f806e9120278f92fdebc2822842c301@changeid>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 15, 2023 at 01:06:16PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Given all the locking rework in mac80211, we pretty much
> need to get into the driver with the wiphy mutex held in
> all callbacks. This is already mostly the case, but as
> Johan reported, in the get_txpower it may not be true.
> 
> Lock the wiphy mutex around nl80211_send_iface(), then
> is also around callers of nl80211_notify_iface(). This
> is easy to do, fixes the problem, and aligns the locking
> between various calls to it in different parts of the
> code of cfg80211.
> 
> Fixes: 0e8185ce1dde ("wifi: mac80211: check wiphy mutex in ops")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/r/ZVOXX6qg4vXEx8dX@hovoldconsulting.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for the quick fix. With this I no longer see any lockdep splat on
boot with the X13s:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
