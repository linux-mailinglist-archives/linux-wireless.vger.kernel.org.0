Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B94B5949
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbiBNSCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 13:02:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiBNSCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 13:02:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D84DF73
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 10:02:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 360BC615CB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 18:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681BEC340E9;
        Mon, 14 Feb 2022 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644861751;
        bh=dYaFO02L4Xk4qfqxIgreKmJIWMOjVE0hnzNy4CcBVBM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lo1unv4rURsTFtn7toLVPI+Btrnvm8B/QUIeDQHnqV9sCWtVotT7BImJb2Uy1QpN8
         l7o7DRXq9uGU9jponG9Rw9YTk0uM/JPJ13faTLLSJ3PMakPku0q9i63kSrSVkRmClr
         rHRccZ5VFfVhhhogxFgY2iNquYYouY8xU7bItg5bjOvPHx49hbqDWFT2pvuDHvzBJX
         Akm5SmPcsPskRAqKbn0H/piB3/BA2BbKg7NJVrxRRftBLqWvreKGgNM0TW4w0rJCqz
         8ZrnFOtF3Vkt/DJb55LQBVYRsiVtOIvedIv8acnsd5PSmzcMJTTTvC7i+evJDE3x5O
         maAZqH3AiMZ5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] rtw88: coex: Add WL MIMO power saving for Bluetooth
 gaming controller
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220211071533.34716-5-pkshih@realtek.com>
References: <20220211071533.34716-5-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <ku920601@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486174876.6494.7997539624404042264.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 18:02:30 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> To keep high sensitivity reaction, Bluetooth gaming controller will send
> packet very frequently, it will make WL performance very poor. To solve
> this situation, MIMO PS mechanism makes WL/BT own an antenna itself, WL
> quits 2SS performance but it can get a stable 1SS performance and Bluetooth
> gaming controller can keep sensitivity reaction at the same time.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Does WL mean WLAN or what?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220211071533.34716-5-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

