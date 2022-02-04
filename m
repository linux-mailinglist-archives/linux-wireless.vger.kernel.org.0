Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF504AA169
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 21:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiBDUub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 15:50:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53798 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiBDUub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 15:50:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 047DAB838FF
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 20:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BDCC004E1;
        Fri,  4 Feb 2022 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644007828;
        bh=aJGVjHyrlVBEUvpLVwHzwJPccySlBZuLLEIkAFifMns=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ixl7xCbBPlbK8rrTlhLRkSgQQZCfpNEXGSdFXxZkzCmbDRz30GnRCChnBA65ed3gk
         cuPFSd0tPbsQlgBdF5ZMxK5g3+HlqSc8xAOXK9uqwRntTd71GiAIRELIWtZT5v/hZ7
         N8rvXrMLyALMIi4iXmvbf0HCOMIt9slbloANJ6spd4Y7CnZnsm7jsiwLccfdjeQcu8
         cWiUMHmdT36dObfLYlS+xJBeCP+WmsRZWa25BXQz1dco+3Lrtd7Hnlcw4kEO9xZVWB
         e4+mrmixgfM5zn3FzXgOErNSTuImQ1Q4OGCfRhk2H2BnHArDCBH5x4DsSpNUz2S18h
         ryczU/2xKnDCA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211_hwsim: don't shadow a global variable
References: <20220204210616.918edc67b94f.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
Date:   Fri, 04 Feb 2022 22:50:23 +0200
In-Reply-To: <20220204210616.918edc67b94f.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
        (Johannes Berg's message of "Fri, 4 Feb 2022 21:06:17 +0100")
Message-ID: <87sfsybblc.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The argument to hwsim_init_s1g_channels() shadows a global,
> change that to be clearer.
>
> type=cleanup
> ticket=none
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/333108
> automatic-review: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
> Tested-by: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>

I guess these are some kind of gerrit tags?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
