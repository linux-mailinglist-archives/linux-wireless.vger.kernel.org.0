Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9256A69DD
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCAJfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9F36FD6
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197DE6128E
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 09:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5297C433D2;
        Wed,  1 Mar 2023 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677663349;
        bh=curww6jvJ4LYWD0y9N+dweLPvbbreXG5vfct2CRGpRg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JQOzdSyRmcb/CpH6ZncG9256PuXVylMXVBW9xGZqpy8ifQmPRkTbrqzAndqnfZgwC
         pUEMbjq/S3xlHqH5Q0KeVvUrgfjUECeOvhF9S/UzfS3qXMaZYRv019ziE3V5nGJxpU
         oK30TCZc00lcCFiJQvlnbypnU1SGp8RvE1M4i47GPQqhwA7RdBkPi2It8/nMBUUjrW
         NvGifMdj/780Cm3QLDGUP73FAwq4VNNFnTr+mmTxrZUWX5IuHThzy4HEDPimYYHlkh
         eUqXp8g0KzZiGALSkLQLlIr/mvESV2FCOXcE7hiivM7Uk5MW8lVJkOS8mveXp9z7rz
         kPpOaZWR5rcSg==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/21] cfg80211/mac80211 patches from our internal tree 2023-02-21
References: <20230223100942.767589-1-gregory.greenman@intel.com>
Date:   Wed, 01 Mar 2023 11:35:46 +0200
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com> (gregory
        greenman's message of "Thu, 23 Feb 2023 12:09:21 +0200")
Message-ID: <877cw024r1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com writes:

> From: Gregory Greenman <gregory.greenman@intel.com>
>
> Hi,
>
> A bunch of patches from our internal tree with mac80211 and cfg80211
> changes. It's the usual developement, cleanups and bugfixes.
>
> The changes are:
> * HW timestamping updates
> * A few MLO adjustments
> * Bug fixes and cleanups
>
> The changes were tested by kbuild bot in the pending branch.

[...]

>   wifi: net: wireless: return primary channel regardless of DUP
>   wifi: net: wireless: correct validation 6G Band for primary channel
>   wifi: net: wireless: cleanup unused function parameters

Should these be "wifi: cfg80211:"?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
