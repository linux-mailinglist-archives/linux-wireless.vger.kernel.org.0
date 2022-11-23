Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5218635140
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 08:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiKWHq4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 02:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiKWHqw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 02:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFBBF8864
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 23:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C904B61AC9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C257C433D7;
        Wed, 23 Nov 2022 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669189609;
        bh=QFYYq1BW8zc3/rrWH+u8oRxcb1K+RV7FJGJqixx8u/s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=r5mRzW/xfr3A/Td17XhAJS5l+8NNpK9Yc20lrBoQxXArxooNRwWNcqSCA7MtTwlJ6
         pVjaGdNMrLjBSfPQsAo+kZeg8benBYSE8xubLDaT/Lc6BT8T3u6lxViNUCJ48VV8QE
         ll+zGT68MlCMH5cSzncUJq99SVdXMqMPM92wV/NEinptvV3Qm+f8GacY76kXijWirG
         AROwYdsn1ZsiIueXhGI5boKRnkJbihvfAa2xQFU2v099I20h7D4uyWSgB+W6gUvdMq
         X2MA+22kg2WVe+4Dw21GSZr6V+RhH6oMi0d5li9Uf2hchnPz1vQrM1wfW4DpntSUpI
         t2a599Rt9wEiQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/9] wifi: iwlwifi: updates intended for v6.2 2022-11-22
References: <20221122201040.2618863-1-gregory.greenman@intel.com>
Date:   Wed, 23 Nov 2022 09:46:46 +0200
In-Reply-To: <20221122201040.2618863-1-gregory.greenman@intel.com> (gregory
        greenman's message of "Tue, 22 Nov 2022 22:10:31 +0200")
Message-ID: <87wn7mnme1.fsf@kernel.org>
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

gregory.greenman@intel.com writes:

> From: Gregory Greenman <gregory.greenman@intel.com>
>
> Hi,
>
> Here's the third set of patches intended for v6.2, with the fixes.
> Resending all the patches since I think it'll make the review easier.
> The fixes are only for two patches (1 and 4), the rest are unchanged.
>
> It contains EHT adjustments for iwlwifi. It contains only iwlwifi
> changes, all the required mac80211/cfg80211 changes are already merged
> upstream.
>
> As usual, I'm pushing this to a pending branch, for kbuild bot,
> and will send a pull-request later.
>
> Please review.

No need to resend because of this but there's no changelog to list the
changes since v1. Usually we do something like this (I'm making up the
content, I don't know what you actually changed):

v2

* patch 1: fix a typo in the commit log

* patch 5: add missing mutex_unlock() in error handling


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
