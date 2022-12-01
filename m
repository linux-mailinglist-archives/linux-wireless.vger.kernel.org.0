Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74963EE09
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 11:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLAKjU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 05:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLAKjT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 05:39:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB88E5BB
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 02:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AF361F72
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 10:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A74C433D7;
        Thu,  1 Dec 2022 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669891158;
        bh=6HpDL5+INCtBpEEy8dHsD96qaaRPVHYBzx/FxGGFGBA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GShxMvi6wsH6WZPhK1cDVmSP2184tK1y+0EXFrfZGpRErT+OfTWNK6yip4kn4xIfR
         T3spuPKNdbTTiPwgVVae9s2xy9PkCoe73UVq11V5xwvMVrNkctS4jUzF9ur7qwAxdW
         9n0bR0WFQlsLxlusG27XnMQtfapdS3Mb5hKLGQKtASo6NE8Jj02RiLIr+A0nts69gp
         /HmoloTNQv69WFO213x6EpFheXlvHsqSkvQv6tunsBkIweinJ4+fvDH9VfKOZHAx/f
         6CEm482EVEH/egY8WgcWMn9yKQqakejExU2NGt3nfCQBVCJvV//rAclOnaerC1URLq
         oWa5EBfr2QuOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 5/9] wifi: mt76: mt7996: add MAC support
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
        <20221122084554.9494-6-shayne.chen@mediatek.com>
Date:   Thu, 01 Dec 2022 12:39:07 +0200
In-Reply-To: <20221122084554.9494-6-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Tue, 22 Nov 2022 16:45:50 +0800")
Message-ID: <87zgc7mmr8.fsf@kernel.org>
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

Shayne Chen <shayne.chen@mediatek.com> writes:

> (Split the big patch into smaller intermediate patches by functionality
> for easier review. Refer to the cover letter for more info.)
>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

[...]

> +static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
> +{
> +	static const u8 ac_to_tid[] = {
> +		[IEEE80211_AC_BE] = 0,
> +		[IEEE80211_AC_BK] = 1,
> +		[IEEE80211_AC_VI] = 4,
> +		[IEEE80211_AC_VO] = 6
> +	};
> +	struct ieee80211_sta *sta;
> +	struct mt7996_sta *msta;
> +	struct rate_info *rate;
> +	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
> +	LIST_HEAD(sta_poll_list);
> +	int i;
> +
> +	spin_lock_bh(&dev->sta_poll_lock);
> +	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
> +	spin_unlock_bh(&dev->sta_poll_lock);
> +
> +	rcu_read_lock();
> +
> +	while (true) {

In upstream we have a preference that there's some kind of limit for
loops, to avoid neverending loops.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
