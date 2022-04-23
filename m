Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252D550C895
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiDWJfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiDWJfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 05:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F223236691;
        Sat, 23 Apr 2022 02:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0CF460E77;
        Sat, 23 Apr 2022 09:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F0C385A0;
        Sat, 23 Apr 2022 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650706345;
        bh=iTzT18ATw05JJxPbBnFZHAUxOKvVk2zyufdr7Bnot1E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QmGJZDFDPiVLQAO+00Js0dVsA0NJLwBjcRE9p3yY83qzo/FzkeDCzssrXp1ZwiMx3
         IP7aQjNSssqSQdLXiWXMpPvWExaKttOzL979WcHEHRtX7VLrzbDCQBGCxUlt5roIz8
         rid7IWNVw+yclqnE+y8xUDHWClwFjnngKeLoYKlvLIqIX4e6HeVdssHlDKmcGVta9l
         4sy+avg5DNH6stqAstKCLcVNSPnIhl/q3EjsSpOekFaHwxLiFpNnh/AkfuiuK2v+BH
         55WaLg/irgQISBHyO9iji/U6aK50++5tj3ZJYWIXeLwvsbNisjK5ZoXiFL73GL4Ym4
         WpzJLdnqamzwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid
 rxstatus->rs_keyix
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220409061225.GA5447@kili>
References: <20220409061225.GA5447@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Toke =?iso-8859-1?q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165070634193.13738.14372114031952605423.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 09:32:23 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need to
> ensure that it is within the bitmap.
> 
> drivers/net/wireless/ath/ath9k/common.c:46 ath9k_cmn_rx_accept()
> error: passing untrusted data 'rx_stats->rs_keyix' to 'test_bit()'
> 
> Fixes: 4ed1a8d4a257 ("ath9k_htc: use ath9k_cmn_rx_accept")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2dc509305cf9 ath9k_htc: fix potential out of bounds access with invalid rxstatus->rs_keyix

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220409061225.GA5447@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

