Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59F62D8DB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiKQLGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 06:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKQLF4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 06:05:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB12709
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 03:05:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7974460A78
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 11:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58482C433D6;
        Thu, 17 Nov 2022 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668683153;
        bh=JnZkZfRXqYTP5IRj4uwfzIyzp4p9ozHRdvswg3QUcbo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jUk0ysi2YHH2NnnN/F9aXogifS7kguazN8bBTRulEE7VLwWGBk4K+jP4Lf5kbRTUK
         YhliDX8inHD4vfeAf/OMsyFcCKp7kJAFE/5/+qSeGZ034G1FELiOyZVxJl9n098gcC
         g9ZcW6CQVQiE2eawv6FTxBcxxkEKDqRRgH7TG93rooAdjP6MIRKxNNgV0D09lKmeh7
         Cd7o67itNXwexvCzjApfVBYRXVQZnnNtAxUzuEL27dwGun75s8pHTbDl7L9IyHOHwW
         1w17J1IL7fzZhQKVwv0BSou7jl9uYkzDhq2rqUQSD0TuYPX4rwu6VGXF0m6r5bUkV6
         fPH3oPFs4lo6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] wifi: wireless: deny wireless extensions on MLO-capable devices
In-Reply-To: <05d8f323f68412c1e0284ccf52321ab776674a59.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 17 Nov 2022 11:58:34 +0100")
References: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
        <20221104174218.7817a3abaf39.Ib9eabc2ec5bf6b0244e4d973e93baaa3d8c91bd8@changeid>
        <87r0y1rgz6.fsf@kernel.org>
        <05d8f323f68412c1e0284ccf52321ab776674a59.camel@sipsolutions.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 17 Nov 2022 13:05:50 +0200
Message-ID: <87y1s9alip.fsf@kernel.org>
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

> On Thu, 2022-11-17 at 12:51 +0200, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>> > From: Johannes Berg <johannes.berg@intel.com>
>> > 
>> > These are new devices that will be introduced into the market
>> 
>> s/new/Wi-Fi 7/?
>> 
>> > in 2023, with new drivers. Wireless extensions haven't been in
>> > real development since 2006. Since wireless has evolved a lot,
>> > and continues to evolve significantly with MLO, there's really
>> 
>> s/MLO/Multi-Link Operation/?
>> 
>> It would good to spell out the acronym at least once per commit log.
>
> :)
>
>> > +++ b/net/wireless/wext-core.c
>> > @@ -662,6 +662,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
>> >  	    dev->ieee80211_ptr->wiphy->wext &&
>> >  	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
>> >  		wireless_warn_cfg80211_wext();
>> > +		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
>> > +			return NULL;
>> 
>> Should we have a some kind of warning in this case as well? Otherwise
>> the user has no idea why it stopped working, right?
>
> Well it's added after the warning wireless_warn_cfg80211_wext(), so it
> already prints the warning from the previous.
>
> I guess we could make an argument to the warning and modify the message
> if it's rejected?

Sorry, I was blind again :) I first read that the call to
wireless_warn_cfg80211_wext() was removed, but clearly it wasn't, and
IMHO that warning is enough. So please ignore this comment.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
