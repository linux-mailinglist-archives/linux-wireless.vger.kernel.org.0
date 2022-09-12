Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800A5B593B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiILLYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiILLYm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2346549
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8863061199
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928EEC433C1;
        Mon, 12 Sep 2022 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662981878;
        bh=v07OgRZfzPnswv0B4vuje/mTwsJ6kTnc2EkA0wqp19Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r5+3R0phQJdEOmn2KHAS9jh+cQ0GBCY+3UFWs7fHaSm5xOKhiY6WL9BQaumhAo1eU
         YRaPBdNQneqSVcxTX+zdtAgPZGxtVFybmOiO/JwzEWOgKWCiUzUTM3R63zxyDGo+b1
         Pgb3e+ObUWtNlsv7DrCQFYsUdxeb0yLTTVU9lRladiw02ycHm9uCYam4hpwawg53MC
         +h1d9AJg9kP1CugOdrNWtZ/qsZHuyPXrlG/hLueJbeOPlmjFjXpauFbcNh991tm+Oq
         8IlrdI3iGBHfjpQhEo22SmwptO+MwXwpp7h5d47SuOtp+phA0LRqLJpoxnMKSeaqCP
         9jR4aSkDaCiag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: iwlwifi: Mark IWLMEI as broken
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220907134450.1183045-1-toke@toke.dk>
References: <20220907134450.1183045-1-toke@toke.dk>
To:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?= =?utf-8?q?en?= 
        <toke@redhat.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298187393.17348.12497028063296177638.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:24:37 +0000 (UTC)
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

> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> The iwlmei driver breaks iwlwifi when returning from suspend. The interface
> ends up in the 'down' state after coming back from suspend. And iwd doesn't
> touch the interface state, but wpa_supplicant does, so the bug only happens on
> iwd.
> 
> The bug report[0] has been open for four months now, and no fix seems to be
> forthcoming. Since just disabling the iwlmei driver works as a workaround,
> let's mark the config option as broken until it can be fixed properly.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=215937
> 
> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Acked-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Patch applied to wireless.git, thanks.

8997f5c8a627 wifi: iwlwifi: Mark IWLMEI as broken

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220907134450.1183045-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

