Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DE791A87
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbjIDPW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjIDPW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 11:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE153E6A
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 08:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874B161864
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 15:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7FCC433C8;
        Mon,  4 Sep 2023 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693840931;
        bh=etRCoMCTX5NlGcqqpz9AuU1aUpXkazd4SsTN45gaFHI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tFmppNXHY1YaKMH0QkPzWyQEaRKdTwxdnoqVHmWMttKtNv6V47lrQbEnulkx/fhEg
         NMX2HXPU51V81cj6wLIjJYiUvwZzHwIL6jzI6NFEgyX78amKTbcKW+S/50x/B4ArUp
         mJFhjUGrrpmFk9X6IIuoaqQR/e2weW59QHDd7W1NhBxuONsOFfMggjdLSMyg9966/Q
         cJWOAX5WmTfM4wpmDbbrUrvx6zSZ/qgTszEAuvsj9sDrnqkkaJl92b69qXiBqNeO6J
         utxbHXedw0pwP2Gun9pfLfUpeyZF7ekrxjUfeO8uSHYqbDV4a21Y4/83rDMXmNZuNM
         IPYugQ6p7+j6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 04/15] wifi: mac80211: add an element parsing unit test
References: <20230827110532.348304-1-gregory.greenman@intel.com>
        <20230827135854.333bc75df13f.I0ddfeb6a88a4d89e7c7850e8ef45a4b19b5a061a@changeid>
Date:   Mon, 04 Sep 2023 18:23:31 +0300
In-Reply-To: <20230827135854.333bc75df13f.I0ddfeb6a88a4d89e7c7850e8ef45a4b19b5a061a@changeid>
        (gregory greenman's message of "Sun, 27 Aug 2023 14:05:21 +0300")
Message-ID: <877cp6q7ws.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

> From: Johannes Berg <johannes.berg@intel.com>
>
> Add a unit test for the parsing of a fragmented sta profile
> sub-element inside a fragmented multi-link element.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>  net/mac80211/Kconfig        |  11 ++++
>  net/mac80211/Makefile       |   2 +
>  net/mac80211/tests/Makefile |   3 ++
>  net/mac80211/tests/elems.c  | 101 ++++++++++++++++++++++++++++++++++++
>  net/mac80211/tests/module.c |  10 ++++
>  net/mac80211/util.c         |   3 ++
>  6 files changed, 130 insertions(+)
>  create mode 100644 net/mac80211/tests/Makefile
>  create mode 100644 net/mac80211/tests/elems.c
>  create mode 100644 net/mac80211/tests/module.c
>
> diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
> index 51ec8256b7fa..037ab74f5ade 100644
> --- a/net/mac80211/Kconfig
> +++ b/net/mac80211/Kconfig
> @@ -57,6 +57,17 @@ endif
>  comment "Some wireless drivers require a rate control algorithm"
>  	depends on MAC80211 && MAC80211_HAS_RC=n
>  
> +config MAC80211_KUNIT_TEST
> +	tristate "KUnit tests for mac80211" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	depends on MAC80211
> +	default KUNIT_ALL_TESTS
> +	depends on !KERNEL_6_2
> +	help
> +	  Enable this option to test mac80211 internals with kunit.
> +
> +	  If unsure, say N.

Just wanted to say that this is great. Hopefully we will have more tests
in the future.

But what's KERNEL_6_2? I tried to grep for that in wireless-next but
didn't find anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
