Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F67E8EE9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 08:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjKLHWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 02:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLHWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 02:22:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4B02D57
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 23:22:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86333C433C8;
        Sun, 12 Nov 2023 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699773729;
        bh=5YdLhn++J6aLaO4Fm3YQDWUBANOEf+5c4KrKpikkdfw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ne+3Z4DzbJmxm9kxtZ7E121oodSIz2fU41lP/VqpMsmA7f+M+im7PQNWdnj1wyJNN
         Hs1pbAuh78vcwSzq+9EEBN20hte1gJ0yb20m6f6Qj3wW+Z0rdB6u+b3+dMdZCx9+Oc
         mYoi6kSjpRU5ujzt3SVV7qzEQwPaZg1/m//K/F5IIqv2NbhJKd8tX57E0mvIhCQa5c
         oplBnHuYdkc0cCb/Z1KhtcaeW5byc2YpNSpMFtjOMEVA5xKd3DbEL0cRbnyBYRf8R/
         4AtcP5+q50Etit/y/UuepHaOylgyK83+qFunXDe2VE2RxFEYYLMKNYYilbygEBFu86
         lwiMbgYYhyEjw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: New iwlwifi warning
References: <CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com>
Date:   Sun, 12 Nov 2023 09:22:06 +0200
In-Reply-To: <CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 11 Nov 2023 14:34:47 -0800")
Message-ID: <87a5rja129.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I only noticed now, because it doesn't cause any issues, but that may
> be because this only happens on my desktop, and I don't actually use
> the wireless there...
>
> The WARN_ON in iwl_trans_configure() has started triggering as of this
> merge window:
>
>         WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
>
> and causes the appended warning at bootup.
>
> Comments? Anything in particular you need from me for debugging?
>
>                 Linus
>
> ---
>
>     WARNING: CPU: 3 PID: 2060 at
> drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1158
> iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]

I investigated a bit and at least two other people have reported this
warning but I couldn't find any fix:

https://lore.kernel.org/lkml/2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com/T/

Adding also Johannes and Miri.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
