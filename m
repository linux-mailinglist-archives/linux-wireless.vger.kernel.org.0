Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66C7716A4
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Aug 2023 21:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHFTqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Aug 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHFTqJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Aug 2023 15:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50044CF
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 12:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06AA6124E
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 19:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703E8C433C7;
        Sun,  6 Aug 2023 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691351167;
        bh=TDJUetIfQcwJA+iDgDBpACqiiqFqkpNv89uYxLEA+tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAcIgKNrq46/nluizDztZ4flghx9/W2RnL8hrSZATKsBLcU97RtxSMx15tT8hJHAL
         mZEbe0M4IMjjidIpd3qrJTrHAJffNM3uVc/83lN0S2KFx0WeDm+hc5NEAaM9wGEyJ6
         cJ2l1JI7LG4GzC6bu+tafFLsvswd12AzZ5YjdjxC9/M9Bw8jZ18+cBKbeyl2NU4v56
         wmvBZS/W40JtxzAhUvyvFSw7vocAnV3ylZwqayxNqjlNwHKjxxJsS0lVjIHw305GNq
         Q2IQg46iT3u08J49iMXKgJaEUiYIMHGKsQXlOXiHE1uygM598efxt+7CLH52p5CNJC
         eD4DjVYhe2KQA==
Date:   Sun, 6 Aug 2023 21:46:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Simon Horman <horms@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZM/4eUvFj7CnIUJi@vergenet.net>
References: <20230804133617.43564-1-yuehaibing@huawei.com>
 <ZM3/+pY9Fovc5AC9@vergenet.net>
 <e19091f1-497a-b673-9010-2e0a48d5942e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19091f1-497a-b673-9010-2e0a48d5942e@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 05, 2023 at 04:24:04PM +0800, Yue Haibing wrote:
> On 2023/8/5 15:53, Simon Horman wrote:
> > On Fri, Aug 04, 2023 at 09:36:17PM +0800, Yue Haibing wrote:
> >> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> >> declared but never implemented this, remove it.
> >>
> >> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> >> ---
> >> v2: fix comment
> >> ---
> >>  include/net/iw_handler.h | 11 ++---------
> >>  1 file changed, 2 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> >> index d2ea5863eedc..b2cf243ebe44 100644
> >> --- a/include/net/iw_handler.h
> >> +++ b/include/net/iw_handler.h
> >> @@ -426,17 +426,10 @@ struct iw_public_data {
> >>  
> >>  /**************************** PROTOTYPES ****************************/
> >>  /*
> >> - * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
> >> - * Those may be called only within the kernel.
> >> + * Functions part of the Wireless Extensions (defined in net/wireless/wext-core.c).
> > 
> > Can I confirm that the wireless.c -> wext-core.c change is intentional?
> > It doesn't seem strictly related to the patch description.
> 
> Commit 11433ee450eb ("[WEXT]: Move to net/wireless") rename  net/core/wireless.c to net/wireless/wext.c
> then commit 3d23e349d807 ("wext: refactor") refactor wext.c to wext-core.c
> The wext functions now sits in net/wireless/wext-core.c
> This may need describe in patch description.

Thanks, I think that would be best

...
