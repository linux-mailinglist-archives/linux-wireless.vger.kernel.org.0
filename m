Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D364F628D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiDFPCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiDFPBx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74638BF310
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 04:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28BB3B8225A
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 11:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BC5C385A1;
        Wed,  6 Apr 2022 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649245461;
        bh=t/1WjGp8WNjjlMiYJRrZjH4WA3tZKE972/DK9Bh8DqA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BJeP7lZKM5aNKjMovQMqRUCVj23YfuXDU4sQn/IP2L2EbIZ5h4kRZv7GuHToW3kSP
         jZbzvkfMcgRkj+6dPamHm2ooUBa18M3loiS2v0LKhIP1xeDS1Ie3UOY4nPG4OC6rN1
         9l9quJbMtJtXbcjxO4M2l1kzN9BJYcce+YYWlum3s+QD/JIENMpUk+saW/cg72pCc0
         WbGWG21mJjBbugTKNNLCDci+sITNovEx+9IeRfJMizUiEuL6Tc5/iYdlrFL990GdO1
         v7pEEZUHapHvE5B811qZ6OUY9x/kqal3WKv2vLXyVHFDsIJbmiRDmyhExqfD3LMXoX
         qcWfJvYRWWU6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mwifiex: add mutex lock for call in
 mwifiex_dfs_chan_sw_work_queue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220321225515.32113-1-dossche.niels@gmail.com>
References: <20220321225515.32113-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Niels Dossche <dossche.niels@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164924545655.19026.5921699639764275443.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 11:44:19 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Niels Dossche <dossche.niels@gmail.com> wrote:

> cfg80211_ch_switch_notify uses ASSERT_WDEV_LOCK to assert that
> net_device->ieee80211_ptr->mtx (which is the same as priv->wdev.mtx)
> is held during the function's execution.
> mwifiex_dfs_chan_sw_work_queue is one of its callers, which does not
> hold that lock, therefore violating the assertion.
> Add a lock around the call.
> 
> Disclaimer:
> I am currently working on a static analyser to detect missing locks.
> This was a reported case. I manually verified the report by looking
> at the code, so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created
> this patch.
> However, as I do not in fact have this particular hardware,
> I was unable to test it.
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>

Patch applied to wireless-next.git, thanks.

3e12968f6d12 mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220321225515.32113-1-dossche.niels@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

