Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E705BA93F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIPJTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIPJTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 05:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1688761719;
        Fri, 16 Sep 2022 02:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAA4AB8249D;
        Fri, 16 Sep 2022 09:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98032C433D6;
        Fri, 16 Sep 2022 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663319942;
        bh=aiE0aNs/n84c+xuU+XoKoBmHaYfUU8+iVr1pUZCDPTg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZMb2L73zBT8/jNipi1PHoOjPT+X2yU5J6G9Z5JPRUSLmShMm58j55f74drDjCDLO6
         5rXCGi5Hf1WKQwCMSSJT2VX+8LrBJTdgwlCD9IZR9VseqrgbGh8AsKGa5SftvHybGP
         NFqSZBB0GE4Eu4X6OQc/SxG3917mT/p9ofJyvAjT4AIly7tP7WtHLjLKSqBJcSBrle
         S8JwCrbsPHTkCXndH6RMGM3PZFM5fJxHDkM5MKQsRZF8Ky3SH3X0sFDb+UwpnbuIf6
         5sstBBHiRv81lIn6fUYOtVwgRB2L0YFZMnjP6U/kLHqE3tcg065sV0S+JEFGynbsnB
         4//V9RSeRZiSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Fix miscellaneous spelling errors
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220909145300.19223-1-quic_jjohnson@quicinc.com>
References: <20220909145300.19223-1-quic_jjohnson@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166331993629.3127.6990826637982175822.kvalo@kernel.org>
Date:   Fri, 16 Sep 2022 09:19:00 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Fix misspellings flagged by 'codespell'.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b8a71b953653 wifi: ath10k: Fix miscellaneous spelling errors

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220909145300.19223-1-quic_jjohnson@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

