Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940C4D4FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiCJQtq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbiCJQsL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:48:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7588169230
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AF44B82567
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3272C340EC;
        Thu, 10 Mar 2022 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646930826;
        bh=+smzXJfCzkc8pov9VCK3B2/WwOUVVTk+vJZJA2ByKhY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sKxyXANabHJ17LihD5nbSWY3FyqVa7d+1sq9l8r7OgV1QRofYxb/5fn0vKNs+By5e
         9pHNvCyyuVYQfznX3WVTGBwZlYi157vsEfLgW4WtHtEvZlKwn8eX/y49+dWgtwBstd
         xFR64JDl9xJrcxrtPFZspMWQ/uq1R9YN24yaARZ9O65F43YFrt1fSv/p39pVgULGB9
         MGy9eWOVCuJn5Wa5+kOaVMbKFHjmi3mV6/jDYVB0eRnUpihvKiNFav7HGM+vKh9cag
         hrmcMo8TvUNd9ekkncCq9BsbiVqXwJ9lboiZ320C1CJIke792o7K7Twb8bi9HBJM9E
         yT34UqgSYpNmQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2022-03-10
References: <d4c71b078097ae236fc20131ea59cd5c436554bb.camel@coelho.fi>
Date:   Thu, 10 Mar 2022 18:47:03 +0200
In-Reply-To: <d4c71b078097ae236fc20131ea59cd5c436554bb.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 10 Mar 2022 10:42:21 +0200")
Message-ID: <87fsnprbzs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's my second pull request for v5.18 with the last patchset I sent.
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
> The following changes since commit 12b604d4ba693a3aa254cf7f9d0b4835770e9e97:
>
>   rtw89: declare HE capabilities in 6G band (2022-03-09 13:39:53 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2022-03-10
>
> for you to fetch changes up to 8594ab868799ce78c770498b74fe55ded30def9e:
>
>   iwlwifi: bump FW API to 72 for AX devices (2022-03-10 09:23:29 +0200)
>
> ----------------------------------------------------------------
> iwlwifi patches for v5.18
>
> * Mostly debugging infra changes;
> * Some more work on the Bz family of devices;
> * Bump the FW API twice;
> * Some other small fixes, clean-ups and improvements.
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
