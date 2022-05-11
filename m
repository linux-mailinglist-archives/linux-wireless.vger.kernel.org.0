Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E6522BB6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiEKFbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiEKFbV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 01:31:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8588A4D9C8
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 22:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B97CB82119
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 05:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E00C385DB;
        Wed, 11 May 2022 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652247077;
        bh=TtPv5TDkpP0u1SaXn1uzIZDsANWmkgrqpjLSWok9+KM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qnQBJ+jJtG7xUI+QXEy9UoCyDVX0RupkdiMq8jyPg2ncgEHrrosoMTMCqG4RtCCwk
         Z2c8Q1PrVoFMDdot1pZzlNnO9VBjbWjFcfSsll1TM9bf+9Q38bfPFuNfD6hQSNXZ5f
         /B7BaWnuuQ8OqtUWtQlnHcLmGE+ktz9clgkqd+5Sw75D8gdPyk8/HHv5WC9UeRAz8b
         6aA3KsKPnHFUD66iPYN0YXw9UYs1C9AHcwv89+OpdOl/x2wo2V8bqAxqYMSDv22OBN
         Wm2wHlbUyuW9bmKl1nHhQBnYfhk+5ujRoYJI8hHXzrRhWZ3TUsksZ66BQ1QB61Y1WL
         fQKQ2LHBSczkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] rtw89: 8852c: add settings to decrease the effect of
 DC
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506120216.58567-2-pkshih@realtek.com>
References: <20220506120216.58567-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <hsuan8331@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165224707541.19198.1864840297230506413.kvalo@kernel.org>
Date:   Wed, 11 May 2022 05:31:16 +0000 (UTC)
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

> From: Hsuan Hung <hsuan8331@realtek.com>
> 
> Modify NBI and PD boost settings according to different primary channels.
> This setting can decrease the false alarm induced by DC.
> 
> Signed-off-by: Hsuan Hung <hsuan8331@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

0cd75e4f1c9d rtw89: 8852c: add settings to decrease the effect of DC
4b0d341b2e04 rtw89: correct setting of RX MPDU length
98ed6159a505 rtw89: correct CCA control
0b75b35c3867 rtw89: add debug select to dump MAC pages 0x30 to 0x33
dadb20864d89 rtw89: add debug entry to dump BSSID CAM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506120216.58567-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

