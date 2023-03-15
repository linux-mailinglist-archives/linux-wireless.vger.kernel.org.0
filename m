Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F806BAAF1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCOIkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCOIkB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 04:40:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743832CFD
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6057FB81D7B
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 08:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6000DC433EF;
        Wed, 15 Mar 2023 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678869597;
        bh=cn105TtdVoQAtGtc4TQTQuU3MbX397vew7n9d5l60mc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HkuSq6tsvwfPpjb9Tkx/JCFd7uq+xhEC0oaL1hwfcTgSboPzlKftUCHNiAcAWeDwB
         v7J1+Btrx3vwTebfYQcgIB5y6YzlnUqp1CoVd689O8qNG/oFRBTY2KAB9zhlOG1bWC
         EQvBKqyjJhBKA+FJb+3V3qrLAQP5tGAqbE9Ed7PeavTA0soo6u2ZAF6ALoZAXT80IC
         wXjLu0tfpeyBqdTzAExCVJBgydhmwrIuHoOjHiBiHKeifRW2Wz8J61Rv/J5ZpXi2Bg
         JPq/xg+eReztjCMYm9b2WxGy5u7Cx1VcFRTF836PvtQh/3a4izbtfNJ83Xsmy0prTO
         /29oHgRqD+gNw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/5] wifi: rtw89: add function to wait for completion of TX skbs
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-3-pkshih@realtek.com>
Date:   Wed, 15 Mar 2023 10:39:54 +0200
In-Reply-To: <20230310034631.45299-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 10 Mar 2023 11:46:28 +0800")
Message-ID: <87v8j2mmqt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> Allocate a per-skb completion to track those skbs we are interested in
> and wait for them to complete transmission with TX status. To avoid
> race condition between process and softirq without addtional locking,
> we use a work to free the tx_wait struct later when waiter is finished
> referencing it. This must be called in process context and with a
> timeout value greater than zero since it might sleep.
>
> We use another workqueue so works can be processed concurrently and
> when the PCI device is removed unexpectedly, all pending works can be
> flushed. This prevents some works that were scheduled but never processed
> leads to memory leak.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static void rtw89_core_free_tx_wait_work(struct work_struct *work)
> +{
> +	struct rtw89_tx_wait_info *wait =
> +			container_of(work, struct rtw89_tx_wait_info, work);
> +	struct rtw89_dev *rtwdev = wait->rtwdev;
> +	int done, ret;
> +
> +	ret = read_poll_timeout(atomic_read, done, done, 1000, 100000, false,
> +				&wait->wait_done);
> +
> +	if (ret)
> +		rtw89_err(rtwdev, "tx wait timed out, stop polling\n");
> +	else
> +		kfree(wait);
> +}

I admit I didn't try to understand this patch in detail but this
function just looks odd to me. Why there's polling able to free
something?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
