Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC305E6CDE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiIVURt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIVURr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 16:17:47 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEE110B0A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 13:17:42 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1obSdd-000386-34;
        Thu, 22 Sep 2022 22:17:38 +0200
Date:   Thu, 22 Sep 2022 21:17:33 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3 02/16] rt2x00: add throughput LED trigger
Message-ID: <YyzC3ceQYGWWV+Db@makrotopia.org>
References: <73f5ba4134e621462a26186449400cf0c1ac1730.1663445157.git.daniel@makrotopia.org>
 <166382246328.9021.4194873488972008176.kvalo@kernel.org>
 <87pmfo6m1u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmfo6m1u.fsf@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 08:00:13AM +0300, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Daniel Golle <daniel@makrotopia.org> wrote:
> >
> >> From: David Bauer <mail@david-bauer.net>
> >> 
> >> This adds a (currently missing) throughput LED trigger for the rt2x00
> >> driver. Previously, LED triggers had to be assigned to the netdev, which
> >> was limited to a single VAP.
> >> 
> >> Tested-by: Christoph Krapp <achterin@googlemail.com>
> >> Signed-off-by: David Bauer <mail@david-bauer.net>
> >> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> >
> > This is missing Daniel's s-o-b.
> 
> Otherwise the patchset looked good to me. Daniel, if you can give your
> s-o-b as a reply to this mail I can then add it during commit.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thank you!

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
