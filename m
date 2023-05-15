Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A03703C4D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbjEOSSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbjEOSSE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 14:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9819F0E;
        Mon, 15 May 2023 11:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE64B63141;
        Mon, 15 May 2023 18:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A56AC4339B;
        Mon, 15 May 2023 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684174594;
        bh=4x6kdBVXh0JiUR2vxk9aj3HYu4Rdy4cNvtGxm+3H7ds=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oG9Leaa4njnenoDMSWTo311gXHQAGF8dRNYyRdagtu2UEFZWHSYzZtBlWJrYG9R3e
         mQKkFGZF5L/ys9e9aXwogUruv9DQYHE4jQJPXIT0uYwOY+2+iVfq8dJFp03zzjQj6I
         /sgrQWeN4M45LJ2JdiQQdgVaKIOsmpfqS8ZJTkCWcVW2vkRujo7IhYiEDRDHapObWX
         4UFfk7RvSTlFECipOBVVYndU48qAtBB4EuHIfCU9e5vgzYGIfXR6UnlIH/ATxPr0I3
         5niEIsHSibW+YZgbfBFJ7skZNbMunOOKQGu36EMmeUQQUkm/j1ipkpA6OkWqEgcFeP
         LZ9/Rb0e26OpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: correct qsel_to_ep[] type as int
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230508085539.46795-1-pkshih@realtek.com>
References: <20230508085539.46795-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <s.hauer@pengutronix.de>,
        <stable@vger.kernel.org>, <dan.carpenter@linaro.org>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168417458623.32723.2980034936740722446.kvalo@kernel.org>
Date:   Mon, 15 May 2023 18:16:32 +0000 (UTC)
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

> qsel_to_ep[] can be assigned negative value, so change type from 'u8' to
> 'int'. Otherwise, Smatch static checker warns:
>   drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn:
>   assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[8]'
> 
> Cc: stable@vger.kernel.org
> Fixes: a6f187f92bcc ("wifi: rtw88: usb: fix priority queue to endpoint mapping")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-wireless/c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain/
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless.git, thanks.

8e4942db5f5e wifi: rtw88: correct qsel_to_ep[] type as int

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230508085539.46795-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

