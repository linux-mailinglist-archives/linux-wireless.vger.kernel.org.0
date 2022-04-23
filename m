Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3106250C9F1
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiDWMfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiDWMfs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 08:35:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735411AF66C
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 05:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2B4B80B20
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 12:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CDAC385A0;
        Sat, 23 Apr 2022 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650717168;
        bh=DWqlf6d1gCq0jfiP44R3FPmdSuh/0IIj+Fy9c9iE7q8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X5zJ+fbE9gGv2+J+LaUOjlopCEn8LFjgMAaJ37wD4z1lk5/WwTD2FmRhO4zjocB7N
         Zy/N+kiyNsDHU0L0g2jeEyeQIYYmLW2y81otCg0jr5YDDtGBd4ljGU+GKA3GcGu4n0
         348ecm4U9HBDjRHnTHDnn8VqAtqSEtnuSTwIHUQWSbEbYWnwl6ToF5igGm7hI0R//s
         6IEobp2Gm4iUU8Id95nAlMVZV9kuAJ5fTHJe9qatXuemWC1Wh38X28JfRx8aNaipZp
         PGCvcNDu7r/K4zfDkQ0Hs/XNO6wZdol+X18vmC2lgiin3wkydFBOiFU5uIYIhIMlY3
         jVhqMu9UlyDTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low
 power
 mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220421120903.73715-5-pkshih@realtek.com>
References: <20220421120903.73715-5-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165071716438.1434.8811355640487410145.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 12:32:47 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In lower power mode, there are very low amount of RX, and it must process
> in a separated function instead of schedule_napi(), because the existing
> napi_poll does many things to optimize performance, but not all registers
> can access in low power mode. The simple way is to use threadfn to process
> the simple thing.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

The title is hard to understand.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220421120903.73715-5-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

