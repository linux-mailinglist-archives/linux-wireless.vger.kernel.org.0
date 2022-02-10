Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF44B08B7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiBJIpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:45:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiBJIpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:45:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524491D7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 00:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF277617F7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A5C340EB;
        Thu, 10 Feb 2022 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644482702;
        bh=Ac7ClJbVexFD/tZ7QfQSbaz2h5FCo8YfU0mLsU0yhQY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OeZ4kQ9j6a1ROk40ZUbuVPIlP0DXKAEmMd4qyQma9dcaKX8bR4i41dk/8hbD2j+lB
         EsGbudIOV2o0/w6iIVhVKTHGymaD7tWtzgEP5myI8mSJ8mbaHJsGDJCnRMXoafrtI9
         YPEWNGTbLbaJx5GnU7Kfw7z2p6GJcEt6ToXiqsYf5xrsZqqIFnVLAKOmoybWZ7msbw
         FOn21F18r6RfCM3T0uAD61licMYKRAbnMnbtOKmmQh23zTctIL0TUwSzcgokAup8bY
         Jdv4TeiNVraPIeIzeaL7Y+YAGJGJ9G8kJrJQPiHPjXljlMKUCy1Wy96imKVVq8Mdfz
         9b58qzeu5Ytiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: recover rates of rate adaptive mechanism
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220208082427.42433-2-pkshih@realtek.com>
References: <20220208082427.42433-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ben.liao@realtek.com>, <damon.chen@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164448269487.15541.14953239889179646146.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 08:45:00 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chien-Hsun Liao <ben.liao@realtek.com>
> 
> Some APs like CMW270 only support one phyrate and the function
> rtw_update_rate_mask could disable that rate. To fix such problem, we
> restore the rate mask if we find that the rate_mask is empty.
> 
> Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

9eb071f84496 rtw88: recover rates of rate adaptive mechanism
3c2c2e2ec1d6 rtw89: recover rates of rate adaptive mechanism

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220208082427.42433-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

