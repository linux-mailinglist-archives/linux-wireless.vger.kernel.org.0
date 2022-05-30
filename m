Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824EB537989
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiE3LDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiE3LDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:03:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDBA55483
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 04:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99084B80CEE
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 11:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABD4C34119;
        Mon, 30 May 2022 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653908620;
        bh=X40VI3AosjrLpvwIwftcg91/LZSossmVmIlKDyaA++k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tqxfnyAKekng3o3WkK//N44tyrQxt6XmHfAdJ7siLww8cwz85XLY7ROISNY3A0ofL
         gMQEyersHdfvE65sV4OH1N5Jd+W3XICFJM8X27An4z+WYewY1U3lbjH9U/sHXsDbwJ
         2qKQrMRBoKGL9QnBNB8yS2HcwYxKFjCnN0BgwM2S8IQjkcO04+j0CbrqLYfiXK9/kI
         /8+a0yMqK8PBAYJ6CMRrkReNJJUl5oO9nT3rdt1ZM/GEbOu+rWKtdvZzoDVxUBSoyL
         +bgfPxidCvE9fzYTAD4vxjEdR+q5dj0MLQNCuNMv/Zr9GhpglLKD+BL0w9sf9dt4wU
         BZ4+rlF4kChqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix null vif pointer when hw_scan fails
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220520081523.45987-1-pkshih@realtek.com>
References: <20220520081523.45987-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390861413.29197.7583524491539911829.kvalo@kernel.org>
Date:   Mon, 30 May 2022 11:03:39 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Add this check to avoid crash by dereferencing a null pointer. When hwscan
> fails due to no memory or dma failure, the scan flag in ieee80211_local is
> cleared. So mac80211 determine that it's not hw_scan then calls
> sw_scan_complete() with null vif, which is also freed during the fail.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

32621eb61bfd rtw88: fix null vif pointer when hw_scan fails

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220520081523.45987-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

