Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660857E9228
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjKLSyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 13:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLSyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 13:54:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F741FF6
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 10:54:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF821C433C7;
        Sun, 12 Nov 2023 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699815272;
        bh=PNhN219Fj+4DlAZyh19H0dvERmW5Z2p5dY8szFMpfb8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=boDtVr/400yhic97q5aMnlM0U99c3H86Dd2OH54C1W/cA/2U6J+kPlCFjg1dMV+sz
         qWwLo4oz8Y7PKkuXMQ46xm+tiKIbPZ+zu5sIHc/vEg36NK5pbfuBrerH3gvk6yXE0v
         J3M1kgYV63gjrNQbteimy6ft4+8AWkPxYEldlbfj7jkxpr+ZQYLQ3sPyITCfMfpk03
         Uk7tQed4TV4nlL5gpJa5ja7KlvDtqDFFR770rGbbb28xVIbSCzl/nET5elBzW1Hn5Y
         WKg8SdzTxDF9WR17jGVwW5uzXSCBh2naFi/QKXu/k20BEVTtX94JeSpK+tmAZURiON
         A6J64Ojm3AQaA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com, gregory.greenman@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        =?utf-8?Q?Nikl=C4=81vs_Ko=C4=BCes?= =?utf-8?Q?=C5=86ikovs?= 
        <pinkflames.linux@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>
Subject: Re: [PATCH v4] wifi: iwlwifi: fix system commands group ordering
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
        <20231112143620.36619-1-emmanuel.grumbach@intel.com>
Date:   Sun, 12 Nov 2023 20:54:27 +0200
In-Reply-To: <20231112143620.36619-1-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Sun, 12 Nov 2023 16:36:20 +0200")
Message-ID: <875y26ajks.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>
> The commands should be sorted inside the group definition.
> Fix the ordering so we won't get following warning:
> WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg))
>
> Link: https://lore.kernel.org/regressions/2fa930bb-54dd-4942-a88d-05a47c8=
e9731@gmail.com/
> Link: https://lore.kernel.org/linux-wireless/CAHk-=3Dwix6kqQ5vHZXjOPpZBfM=
7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com/
> Fixes: b6e3d1ba4fcf ("wifi: iwlwifi: mvm: implement new firmware API for =
statistics")
> Tested-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.com>
> Tested-by: Damian Tometzki <damian@riscv-rocks.de>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Linus, I suspect it will take a while before we make a new wireless pull
request (there's currently just one commit in the wireless tree). So if
you want to take this directly to your tree please go ahead, otherwise
you get it via the normal route in a week or two. Just let us know what
you prefer.

Acked-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
