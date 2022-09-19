Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395B5BC5F2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiISKCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiISKB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E289A22BC6
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F17960E9C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C73EC433D6;
        Mon, 19 Sep 2022 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581717;
        bh=M4CN8KquX+35Lugz3NG27+VlYY6w/l6K6lGuNi1+hG0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pc8qQm+S+ouFY2qhg6TkrjWdIicygtAoEWDIsF7NkM7HosF+6pJPvjQKRFBkduI/R
         8Vz8hvRgLVbbYLYDXivG0XdHwGn7j7CVym/EA6Dbj2b35I8W06+lDn71kYsjRkK0hZ
         VrF8oy6VyteKvTsntlPl+8/BScU1QNFtQd5Vgg68ioJbgikKSINd7aafyUqH4+fKJG
         G1l1ot1VpQN8vr/0ifGfb75irnIVR+pap5zYW1PM1vMoNavhezUkjPB0cSnUQDhh26
         tGrr3Ysf2pT0xMh6jprnCwW9koY+ERT1nrE4dUwVxRgsUVers4F4nE3ox64ETlBww6
         RJv0D8dKgIteQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] wifi: rtw89: coex: use void pointer as temporal
 type
 to copy report
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220913092546.43722-2-pkshih@realtek.com>
References: <20220913092546.43722-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358171494.24821.11327207476233684630.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:01:56 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> With void pointer, we don't need to cast to 'u8 *' by one by.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

8d8fe46cd36b wifi: rtw89: coex: use void pointer as temporal type to copy report
1bb2d4f1551b wifi: rtw89: coex: Add v1 Wi-Fi firmware power-saving null data report
8468446a6277 wifi: rtw89: coex: Move coexistence firmware buffer size parameter to chip info
287657e77b21 wifi: rtw89: coex: Parsing Wi-Fi firmware error message from reports
eacc3f53bdc2 wifi: rtw89: coex: Parsing Wi-Fi firmware TDMA info from reports
c918f5f49fcd wifi: rtw89: coex: Remove trace_step at COEX-MECH control structure for RTL8852C
435f87d088e5 wifi: rtw89: coex: Combine set grant WL/BT and correct the debug log

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220913092546.43722-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

