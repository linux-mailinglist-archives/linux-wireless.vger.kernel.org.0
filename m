Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6896D62D85B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 11:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiKQKsn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 05:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiKQKsi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 05:48:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C76443
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 02:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB736B81FF5
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 10:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B10C433D6;
        Thu, 17 Nov 2022 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668682111;
        bh=Z7aP4Ho75AfGbQk6LzW1BZcM6gY0Fi0ogtvT0WPQLgc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ILawBLuQWHfRG2SeLj30v077GjNxUC7ErXZvvRZb6XZ4AhS6W7mS83SpQ3YSm89Tk
         3Ix3uAFbq/B7KQhzAgZfn9Z6xBPvcgcUtfecpob3vK0rxTgUhvs9KmWlHKRO4VvyQ2
         xMQs2U5AzHh6Gvvo2glBLBE/asDq04RhLJhE+W2Q+uvlSI0w5jIBo+GiZxmzrdMEJa
         GTRnTqYQUH1w6QAO9F9ZZu66tXR2MsIuVIgAcSJ8jC3XEXnfIi36YSxcqk9jUADhIY
         3+VNQAUw4TVpRiKsQnu3Ncw/k3V4rP5OWOwJ2+6LtHCHGKzB4Jn8kq/wj3bIi6yVS5
         6/7GztZhnoMPA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/2] wifi: wireless: warn on most wireless extension usage
References: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
Date:   Thu, 17 Nov 2022 12:48:24 +0200
In-Reply-To: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
        (Johannes Berg's message of "Fri, 4 Nov 2022 17:42:20 +0100")
Message-ID: <87v8ndrh53.fsf@kernel.org>
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

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> With MLO/EHT support around the corner, we're going to
> remove support for wireless extensions with new devices
> since MLO cannot be properly indicated using them.
>
> Add a warning to indicate which processes are still
> using wireless extensions, if being used with modern
> (i.e. cfg80211) drivers.

I doubt people outside of wireless know what MLO or EHT are :) Also it
would be good to mention what's the replacement for wireless extensions
so better to spell out that as well. So maybe use more widely known
terminology like this:

"With Wi-Fi 7 (IEEE 802.11be) support around the corner, we're going to
remove support for wireless extensions with new devices since Multi-Link
Operation (MLO) feature cannot be properly indicated using them.

Add a warning to indicate which processes are still using the ancient
wireless extensions, if being used with modern (i.e. cfg80211) drivers.
All those users should be using nl80211 instead.

Ancient drivers, which are not using cfg80211, are unaffected."

> +#ifdef CONFIG_CFG80211_WEXT
> +static void wireless_warn_cfg80211_wext(void)
> +{
> +	char name[sizeof(current->comm)];
>  
> +	pr_warn_ratelimited("warning: `%s' uses wireless extensions that are deprecated for modern drivers\n",
> +			    get_task_comm(name, current));
> +}
> +#endif

Maybe add ", switch to nl80211" also to the warning message?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
