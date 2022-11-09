Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270F462315E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKIRX2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 12:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKIRX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 12:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D910543
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 09:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D1561BC2
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 17:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E9AC433C1;
        Wed,  9 Nov 2022 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668014605;
        bh=qUp0zD8DwnKrCS+n4jussuNv1LIwr64aiVzXPwhtimY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bUohAEl4jDWd4tO6WQuReAENEGdvTJRUVsFqhKR7G+XJ3FhRwvSn1lj/uErpqbMZ7
         4bAhSqln0hxPwqYt3L1ZS3Wjs38WRfcWw/VHG7JpOuhKxKqX4EzyaD4Jrp1Qkhbh+q
         W7ck3gH22uwUFvBht/rhwCpE0iFs4uCTW0krlnvvIrn8TjFoHoBJ9rsqmZh2+Jkapa
         eMFUx46dlIAZeMpZOdd5LAxHitUFfaPneSmW+Lm+3vG5AEvv7zXpang3jqpIwRasoM
         Sspt/cAbc2KF++G5me8PoNMsSp/QrQkjHpKPV3q7ABIZU2SonzKrAu2tFL3PoUo51l
         0FjPwWuvDr2Mw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Greenman\, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: iwlwifi-next-for-kalle-2022-11-06
References: <141140c10cd372c03abccb0483548108de705565.camel@intel.com>
Date:   Wed, 09 Nov 2022 19:23:22 +0200
In-Reply-To: <141140c10cd372c03abccb0483548108de705565.camel@intel.com>
        (Gregory Greenman's message of "Sun, 6 Nov 2022 11:01:38 +0000")
Message-ID: <87sfisavp1.fsf@kernel.org>
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

"Greenman, Gregory" <gregory.greenman@intel.com> writes:

> Here's my first pull request for v6.2 with the last two patchsets I sent.
>
> It contains bugfixes (mostly mei) and cleanups. 
> The second patchset depends on the first one.
>
> Please let me know if there are any issues.
>
> Thanks,
> Gregory
>
>
> The following changes since commit bd954a7e4aa0739630884fc572d2d0e4dcd16e25:
>
>   wifi: rtl8xxxu: Use dev_* instead of pr_info (2022-11-04 13:01:35 +0200)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-11-06
>
> for you to fetch changes up to 68efade8ef5c0656cf40d511dfa3676762941138:
>
>   wifi: iwlwifi: mei: wait for the mac to stop on suspend (2022-11-06 12:02:40 +0200)
>
> ----------------------------------------------------------------
> iwlwifi patches for v6.2
>
> Patch sets 0 and 1
>
> ----------------------------------------------------------------

Could you write a short summary about what the pull request contains to
the signed tag? That's what is stored to git.

Also I see your Signed-off-by twice in commits.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
