Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03B5633982
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKVKPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 05:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKVKPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 05:15:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A163FBB6
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 02:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D2F2B8190B
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 10:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE0DC433D6;
        Tue, 22 Nov 2022 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669112142;
        bh=vRL6mnc0M5kWDm1GDmBdVSIv11EbYkwIYS7acbd7oaU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lBQrrFS70k2SWLSlBXhxYbT8oXB5NIAbjcPdsKsdlIRjLb3AcpdI6lZWQfgxdIeUG
         kI6VaSE3aPtkQ7Y3H9MIimkgocALxfWymfGS/3E2dBYSOXrTH0BbViQ24whKeZS1av
         xpSiciB+Euiw8Eo9FCFjgoqE7CLunNS5L5Wac3iEA3mhDtB+moiAKTtVRnTDW5oY6B
         wfJKoyRR4w6/5xkKvCRuZH3yiHm2UU+PZu5VeOLefjjl1cms7jICV+zV1elnB/oifV
         q2Wq48r6+mPYpIGlLsuymSa/EL0XhdRAj5Ki4QzOE5AXYy/Xha/XGEX90wDkEeuS9K
         CCPrwOzJ2Lm8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: read CFO from FD or preamble CFO field
 of
 phy status ie_type 1 accordingly
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221117063001.42967-2-pkshih@realtek.com>
References: <20221117063001.42967-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166911213988.12832.7181558520625829680.kvalo@kernel.org>
Date:   Tue, 22 Nov 2022 10:15:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> Add macro to get FD(frequency domain) CFO field from ie_type 1, and correct
> the naming for preamble CFO field. Each IC could assign the CFO source to
> either FD CFO or preamble CFO in chip_info. Based on the suggestion from HW
> designer, rtw8852b and its derived versions will have better CFO tracking
> performance with FD CFO.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

10cd4092f67e wifi: rtw89: read CFO from FD or preamble CFO field of phy status ie_type 1 accordingly
29136c95fdc5 wifi: rtw89: switch BANDEDGE and TX_SHAPE based on OFDMA trigger frame

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221117063001.42967-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

