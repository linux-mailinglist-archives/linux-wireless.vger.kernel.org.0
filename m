Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B35E5A5F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 07:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIVFAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 01:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIVFAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 01:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2C9F0F5
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 22:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A2F62E1C
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 05:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9133AC433D6;
        Thu, 22 Sep 2022 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663822820;
        bh=qRZNWRiGpBeU1U2hg+pMKI/UMWBdmZ5WknX7D9cJl5s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DfUYAnLFdWcz1GBRcg30EV9IImUSV/ViYXSVUwiq9MTmjQhjhfXCBNnAMNKN2cEqS
         bYefCT68fI0T4BNnots2yaUGhIIgiyPYxaVpUUQNdhv953QW2Lj3inNDHKCpJ+JBh6
         BSJehjv2KQzKLKZh6hJsw2+hRCG5XKjWFaqjILRKuwbPkLmg6zbhD5v9cRuqTB/VSu
         1+JeiVvbe/qs96ExCWI4PpU/L+S9FPrEbkrjZ6c1hOSKMDLuQF2NGSlZMHxokT0RiQ
         GhPFNQfxVwkxpM9k3NMF1GEQbbpO72lwxAPaPZR9RQ8oN2JvsSaeHJ3Er5CJ3oIaGg
         7VA8ou4K4vOoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3 02/16] rt2x00: add throughput LED trigger
References: <73f5ba4134e621462a26186449400cf0c1ac1730.1663445157.git.daniel@makrotopia.org>
        <166382246328.9021.4194873488972008176.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 08:00:13 +0300
In-Reply-To: <166382246328.9021.4194873488972008176.kvalo@kernel.org> (Kalle
        Valo's message of "Thu, 22 Sep 2022 04:54:26 +0000 (UTC)")
Message-ID: <87pmfo6m1u.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Daniel Golle <daniel@makrotopia.org> wrote:
>
>> From: David Bauer <mail@david-bauer.net>
>> 
>> This adds a (currently missing) throughput LED trigger for the rt2x00
>> driver. Previously, LED triggers had to be assigned to the netdev, which
>> was limited to a single VAP.
>> 
>> Tested-by: Christoph Krapp <achterin@googlemail.com>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
>> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>
> This is missing Daniel's s-o-b.

Otherwise the patchset looked good to me. Daniel, if you can give your
s-o-b as a reply to this mail I can then add it during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
