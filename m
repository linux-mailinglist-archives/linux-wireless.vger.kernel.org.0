Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092235F608F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 07:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJFFUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 01:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJFFUw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 01:20:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D92229F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 22:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BAAAB81DEA
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 05:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C74C433C1;
        Thu,  6 Oct 2022 05:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665033648;
        bh=xzMaWYgf2dyX+0wGph7+8nw93TrQEvDgkDKqvZq6Z6M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=S6P7/8b4q9fNSIs3NeEkMRsf0w/DjS7YYnp7s723zfrTt9gw/yjSvL3zxo7iHI1WK
         4C5CMfSYCwHTWZhvkmpJyAEgVhjSDpVSBn0Fnto8mTBk4v0l2gko+7SWosKuy6s8U2
         2gXaCcgUZvpnrpA5RL7PZInIqn61Mkp+7gfP/H5nnwlslr9UxyFmHx4mXpT/rUOLgO
         a6kW4iTXNcvvSoHtPjGYBfhu13WWkxS4XhBwZka7RKQ9Y4TFhTywsvB2gHPoSP0+O6
         am6jqjWVaorI0YBEsFBEYsCRy7sDdE7buHRjsaV+dcgagpNy/4UBaoj/KLvfLa3jaq
         /lr7ZHOp8md0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.0] wifi: mt76: fix rate reporting / throughput
 regression on
 mt7915 and newer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220927093823.6007-1-nbd@nbd.name>
References: <20220927093823.6007-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166503359432.31296.3751309555062829540.kvalo@kernel.org>
Date:   Thu,  6 Oct 2022 05:20:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> mt7915 and newer need to report the rate_info that's stored in wcid->rate,
> since they don't fill info->status.rates.
> 
> Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/all/CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com/
> Fixes: 44fa75f207d8 ("mac80211: extend current rate control tx status API")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Patch applied to wireless.git, thanks.

6b430f72b2bc wifi: mt76: fix rate reporting / throughput regression on mt7915 and newer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220927093823.6007-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

