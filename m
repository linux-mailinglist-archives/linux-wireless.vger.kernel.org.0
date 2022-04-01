Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A94EE879
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiDAGlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiDAGko (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 02:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55984266B63
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 23:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89810611D4
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 06:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB50C340EE;
        Fri,  1 Apr 2022 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648795067;
        bh=1wO6TNsAAwmdzEM5yoRZNqlnV3OrUmzXpwEu8sRlRhM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pDgChhXAFBHp7eQm6cph+IqEh7JnSHsieeWVjnDa3l/8w7nCctAZPGQ8Nfaw8M6Db
         kpeLBHIbiM9CkSkt3214r/ss4FEFhjnjUtgTYsz+mDgA74aNoGL9hTFYmlxnKPgGiP
         2YmFKl6sIay2e4bddbb1Qk8i3yCPiagGlplDvgByO41xYQhBbbO+MFNQL4icLX3sQr
         lxOri0E+Pv9ZeO+kxrF5YW215LtKRcuI3PdFeu7TNO9fu1I3U9nMvUIiMy8RE+WIre
         j1c+r7dtL5Jn7QLnWdp8rWqyfQH9rjyP4chbQhwlFENTY36yFKTOVJ325YtsG7O/B3
         2139f6aYOZynA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v5.18] ath9k: Properly clear TX status area before reporting to
 mac80211
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220330164409.16645-1-toke@toke.dk>
References: <20220330164409.16645-1-toke@toke.dk>
To:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164879506244.20606.13026596473794143862.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 06:37:46 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> The ath9k driver was not properly clearing the status area in the
> ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
> it was manually filling in fields, which meant that fields introduced later
> were left as-is.
> 
> Conveniently, mac80211 actually provides a helper to zero out the status
> area, so use that to make sure we zero everything.
> 
> The last commit touching the driver function writing the status information
> seems to have actually been fixing an issue that was also caused by the
> area being uninitialised; but it only added clearing of a single field
> instead of the whole struct. That is now redundant, though, so revert that
> commit and use it as a convenient Fixes tag.
> 
> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before reporting TX status")
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Patch applied to wireless.git, thanks.

037250f0a45c ath9k: Properly clear TX status area before reporting to mac80211

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220330164409.16645-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

