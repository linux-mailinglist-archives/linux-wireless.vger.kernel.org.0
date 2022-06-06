Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7353E75F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiFFOHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiFFOH2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:07:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF39A45B
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC00B8198C
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE6C385A9;
        Mon,  6 Jun 2022 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524445;
        bh=tMeKQ0wXvAI3qCeplV2raWzXVOm0eYF7/LHEWAjhbTE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KiGOJWIB5gd1nYJXdSjfXvd/H5zZ10lGtxHEFp0YW1AnkDaYp8UKLQUuW94KsYstw
         O7KxAkBH6CXj01EoPMdH7qsl76DoUWflR5xjECWj4cX4vKBzVXfadqfzutvMJH41Cm
         RDBiy6KWrIjCl+zQCbBl/bd64F9202YLphEm+mky0BlREC9jt81+gV1+8GMKxh+O2q
         iMH78f1GTKtwa70BuAhDcqA4+vdvcUhVWJkg4DtB6LK+GHBfTU3CzBs/qLOp65NQ4M
         LD4KNc2sxG7bC5eIuQ2YYPC7c2FcOOAtVPYxR1+/oG0OTS3dSSjTXsM7xKLKl1lGMe
         JTvJV6oKm/zbw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: fix missing skb drop on htc_tx_completion
 error
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220528142516.20819-2-ansuelsmth@gmail.com>
References: <20220528142516.20819-2-ansuelsmth@gmail.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165452443982.15301.6395234457917940547.kvalo@kernel.org>
Date:   Mon,  6 Jun 2022 14:07:23 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian 'Ansuel' Marangi <ansuelsmth@gmail.com> wrote:

> On htc_tx_completion error the skb is not dropped. This is wrong since
> the completion_handler logic expect the skb to be consumed anyway even
> when an error is triggered. Not freeing the skb on error is a memory
> leak since the skb won't be freed anywere else. Correctly free the
> packet on eid >= ATH11K_HTC_EP_COUNT before returning.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f951380a6022 ("ath11k: Disabling credit flow for WMI path")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e5646fe3b7ef ath11k: fix missing skb drop on htc_tx_completion error

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220528142516.20819-2-ansuelsmth@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

