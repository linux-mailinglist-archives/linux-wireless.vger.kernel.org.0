Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235234BFC75
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiBVP0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 10:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiBVP0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 10:26:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23069162036
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 07:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC75661636
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 15:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833A4C340E8;
        Tue, 22 Feb 2022 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543586;
        bh=9lMvTGrxBW33Hy8BkbHgZ+ocpLTJLyP22aPRRkMp+9M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=C6kYHh2nK+X5hOtRErMC9In0V+VOjwuJe1gpVVS6ETNeN9gUGnFuqJBhZ/bFA4cb0
         wfSzxxwKsHHRefnQUDt5fTz3gUX2NciNucP+MVJ6vunwpGMQmhnHTYLbRwqbx3djiY
         hwfp8NTjnOBOId42/Uys+j1HJ4JJYhjQMTXzUudZ5ZDWcD9z5YMdaETVyHVdpdP047
         5HRNAgRBsXr0gx4M707WGcqBWT4eVcQwboTxCyxsWKj69VSQKeKbJmq3sw4OjHSTY6
         Zvr1bwVahM5OtDp5zDMb/qaOF7kZ9/LoyFZOCiO8yeVpzIRyXDM+bkMwNW7y8RY+5C
         897LeJK+7A/1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2022-02-18
References: <d19d9ad6a7ddab0c8345e5922e58e4a28a593c45.camel@coelho.fi>
Date:   Tue, 22 Feb 2022 17:26:22 +0200
In-Reply-To: <d19d9ad6a7ddab0c8345e5922e58e4a28a593c45.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 18 Feb 2022 11:22:02 +0200")
Message-ID: <87sfsavs69.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's my first pull request for v5.18 with the six patchsets I sent
> earlier, plus about 10 patches sent by the community.
>
> This is all normal development, new features, bugfixes and  cleanups. 
> More details about the contents in the tag description.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit ea0de861374b06f97620eb508d442161b56cfa62:
>
>   mac80211_hwsim: Advertise support for EHT capabilities (2022-02-16 15:44:45 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-02-18
>
> for you to fetch changes up to cb0a1fb7fd86b0062692b5056ca8552906509512:
>
>   iwlwifi: dbg_ini: Split memcpy() to avoid multi-field write (2022-02-18 10:40:56 +0200)
>
> ----------------------------------------------------------------
> iwlwifi patches for v5.18
>
> * Support UHB TAS enablement via BIOS;
> * Remove a bunch of W=1 warnings;
> * Add support for channel switch offload;
> * Support a new FW API command version;
> * Support 32 Rx AMPDU sessions in newer devices;
> * Support a few new FW API command versions;
> * Some debugging infra fixes;
> * A few fixes in the HE functionality;
> * Add a few new devices;
> * A bunch of fixes for W=1 and W=3 warnings;
> * Add support for a couple of new devices;
> * Fix a potential buffer underflow;
> * W=1 warnings clean up continues;
> * Some improvements and fixes in scanning;
> * More work on the Bz family of devices;
> * Add support for band disablement via BIOS;
> * Bump FW API version;
> * Fix config structure for one device;
> * Support a new FW API command version;
> * Support new queue allocation command;
> * Some more debugging improvements;
> * Some other small fixes, clean-ups and improvements.
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
