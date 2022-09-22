Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEC5E5A58
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 06:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIVEyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 00:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVEyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 00:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B2B93
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 21:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3A662E1C
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 04:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EAEC433C1;
        Thu, 22 Sep 2022 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663822469;
        bh=PZbVwAEHV4iYX5whwNhE0FY0SR4yadNi3eTOUUIy7iI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gqbwVZNeyPFuCTTR7J4xlhl5e8Pvw3SoK36hrbVEENi2sK3zk1SvivFlXov21tFOr
         2pUf8MjVagmQ13ZJhujYr3dvM7EdAeIfVh2RF5iwqlnx0BSzXBHiej9fnIoujka+yl
         6vadUBM+AXfbbHnobQVe6OjTBOrCY0u9cTNautbumdrpsjHolaRSK7/EWGab/W+wVH
         T4c3Rw1WSliZJqlE9DchMMvwDEb8XTAZhRsfoFC2HnbQVYVG03nlkEiKLj47m7C8eU
         IRk+/Z7gelrB6U9ad7SjxeVfZiL9I9yM7u2jCejoYzfvH2paRd+PTUomvwRro7eya7
         sRNtGEP2ho/bg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/16] rt2x00: add throughput LED trigger
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <73f5ba4134e621462a26186449400cf0c1ac1730.1663445157.git.daniel@makrotopia.org>
References: <73f5ba4134e621462a26186449400cf0c1ac1730.1663445157.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382246328.9021.4194873488972008176.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 04:54:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> wrote:

> From: David Bauer <mail@david-bauer.net>
> 
> This adds a (currently missing) throughput LED trigger for the rt2x00
> driver. Previously, LED triggers had to be assigned to the netdev, which
> was limited to a single VAP.
> 
> Tested-by: Christoph Krapp <achterin@googlemail.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

This is missing Daniel's s-o-b.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/73f5ba4134e621462a26186449400cf0c1ac1730.1663445157.git.daniel@makrotopia.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

