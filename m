Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C56E4482
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDQJ7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDQJ7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 05:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D74C28
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 02:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB1A62127
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 09:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBBCC433EF;
        Mon, 17 Apr 2023 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681724979;
        bh=9kxcbFixCrk9HrMiNJbo98NVNm6NQP+IkdBvHArm8x0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eVxhCxbkzSvJ/Mhx//frMH1Ukq/grjLtkoWG8zsKdaAeH6iw9WSVoeDJmN1HaVwkr
         YBwWFNXNbIIed567PWMa/lLfpTBTvOp+DRFQjYbHdkmhc6QkMD37wtVNnpdttIYhqJ
         f8JFQGXB2njGTK46KBzEeLLPP/MpcVw9IxVu8iIulTCihS32Q+T35KQa7SLKAjxzVH
         7fUUQSPg8gxoT/a3ViUQzWtfm/r85BFcYsqAnNdItehSD2MVQcoqqzL3lDD9Zl1QLj
         2gixfaZfxH8JJAwR8NbnfV+fPKDwMVwDa3jKRCGxBIqtWLIZ0Lo2wEBwtTJ9+Hy5oB
         nFDAIxnNFN2Lw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: coex: Enable Wi-Fi RX gain control for
 free
 run solution
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230412012831.10519-2-pkshih@realtek.com>
References: <20230412012831.10519-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172497498.26465.2182950609938766680.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 09:49:38 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> When Wi-Fi & Bluetooth are both busy at the same time, Wi-Fi need to
> enable RX gain to protect Wi-Fi RX RF ability. Without this configure
> the interference from Bluetooth will bring a big impact to Wi-Fi RX.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

36ef71db559f wifi: rtw89: coex: Enable Wi-Fi RX gain control for free run solution
9fde30562840 wifi: rtw89: coex: Add path control register to monitor list
2380a220316f wifi: rtw89: coex: Update function to get BT RSSI and hardware counter
c0fea064b264 wifi: rtw89: coex: send more hardware module info to firmware for 8851B

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230412012831.10519-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

