Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D84723A3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhLMJVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMJVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:21:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE63C061574
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 01:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C8D4B80E07
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89700C00446;
        Mon, 13 Dec 2021 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639387290;
        bh=0Yv7WkfhE/JhaAx1neGa8HEvL6LbJBT4a5ccgy3f/eA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pRuDcZSAfao+kDCqb5WbufNsER7wDgEUwE1qmdg27qCzjCsumnRVE7DhZqVyXXN5B
         L2jHBLieiH8r44jU1mroo+zwlPWV5bXC3FVdDE3atCS3dSuJAcaB5IVzTDTMa86wrw
         NX0DihKJIM6sDrU2hdOPpJSBSygDGL1d1nwLpq8MjhWA/kOuAz3YLFVVk8G8jWVV2F
         H64qoHeIcUpPYO2OLmy23UF2iCcRMtXvnNpOLa+IyWvioJFNBNxi6Qxj+L6mX8yMjG
         CExw6vEjASP9Ux4oBsX4b/x62eWN9t5c403zZEzfDtdHVkSBWjsy+x3Avz0FWM2S+o
         9DCXsQeng5Y/w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        aaro.koskinen@iki.fi, rwbugreport@lost-in-the-void.net,
        ryder.lee@mediatek.com, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 5.16] mac80211: fix rate control for retransmitted frames
References: <20211122204323.9787-1-nbd@nbd.name>
        <b8cd1251-691c-a927-cff2-3476977667b1@leemhuis.info>
Date:   Mon, 13 Dec 2021 11:21:25 +0200
In-Reply-To: <b8cd1251-691c-a927-cff2-3476977667b1@leemhuis.info> (Thorsten
        Leemhuis's message of "Sun, 12 Dec 2021 12:45:37 +0100")
Message-ID: <87y24on9m2.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> Hi, this is your Linux kernel regression tracker speaking.
>
> Top-posting for once, to make this easy accessible to everyone.
>
> What is talking below fix so long to get mainlined? The patch and the
> confirmation that it fixes the regressions was 19 days ago. The patch is
> also in linux-next for 12 days. From my point of view as regression
> tracker that seem "too long", as this is a regression that also affects
> a stable kernel.
>
> Or am I missing something?

In general it just takes time for wireless patches to reach Linus' tree.
For example, we don't usually send pull requests to the net tree every
week so that alone causes delay.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
