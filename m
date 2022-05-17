Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54745298E1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 06:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiEQEpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 00:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEQEpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 00:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30F25C5D
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 21:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE67E614FB
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 04:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC78C385B8;
        Tue, 17 May 2022 04:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652762718;
        bh=3SQJnwz9IYrVf3OXuaFRzBe8PfK65G1u+4sgg+zlAvo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qwZ08JpdkRTl+ynu8UEs8gEcc9p+whCN5D/oOjTT11iR3ProLG+jtCQ/0CQwx6v0j
         vEDrH8uBHjwuZvD3bGhtzp6X7z9EIsrMZShVNf4ghLw9ybn//1Ff4fKljYoCHMEz43
         F6ofZ0XA56vcD7r4DcyNTT2lZGx4dLGt+oaUfs3oeYHAnjCD2XZQo6jgHShJQlztCS
         w7ofBh5oC8djQk22dEtrWHswXQdxnSWrStqXUwg2NtohpWoVBW4muQ1cFOEtdrqtBK
         V2qy3u+gyerht154uu83o35wBxpKZN/MAV+XIKMGU/7PxV3yNU1+Kk1uOjT5V08bIk
         gkaqW/GTmT8/Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] cfg80211: additional processing in NL80211_CMD_SET_BEACON
References: <20220516202454.4925-1-quic_alokad@quicinc.com>
        <20220516202454.4925-2-quic_alokad@quicinc.com>
Date:   Tue, 17 May 2022 07:45:15 +0300
In-Reply-To: <20220516202454.4925-2-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Mon, 16 May 2022 13:24:52 -0700")
Message-ID: <87v8u4wyw4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> FILS discovery and unsolicited broadcast probe response transmissions
> are configured as part of NL80211_CMD_START_AP, however both stop
> after userspace uses the NL80211_CMD_SET_BEACON command as these
> attributes are not processed in that command.
>
> - Add the missing implementation.
> - Modify the local variable in nl80211_set_beacon() and input parameter
> to rdev_change_beacon() from type struct cfg80211_beacon_data to
> type struct cfg80211_ap_settings to support the new processing.
>
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
>  include/net/cfg80211.h  |  2 +-
>  net/wireless/nl80211.c  | 28 ++++++++++++++++++----
>  net/wireless/rdev-ops.h |  2 +-
>  net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
>  4 files changed, 55 insertions(+), 29 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 97a5804ccdcf..880ade4a0430 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4200,7 +4200,7 @@ struct cfg80211_ops {
>  	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
>  			    struct cfg80211_ap_settings *settings);
>  	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
> -				 struct cfg80211_beacon_data *info);
> +				 struct cfg80211_ap_settings *info);

Shouldn't patch 3 folded into patch 1? I don't see how patch 1 as is
would compile without warnings.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
