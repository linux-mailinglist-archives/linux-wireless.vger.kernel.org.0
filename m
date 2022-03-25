Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E774E720C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 12:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355011AbiCYLNb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354534AbiCYLNa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 07:13:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D9CFB94
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 04:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B844B82804
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 11:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58517C340E9;
        Fri, 25 Mar 2022 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648206714;
        bh=nsfS3cuBAHQ9pojl5XhWCldZAhd67o+MJ4q9pZdHfxc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gHC6KOdlha3TSiFL54rhHLoUtWkS6iXg9/vtwHD7Lz4QgDZA+usS6QJtN7iJwHL3C
         n1HEk5pRoM470Qy9y7vH5UPsomLzfHoXXtKIMEXaA920VfpU6Th9LxuJ2Texvz336F
         LSOV2BdFJSJyK91rXn6ZdG6ZlwR/7QBRgHoShqMR5XYK+WDGEE/B2xkE/ODkmIC/gN
         Axs6VntIfmnSVjOqvEti+ujaGQ/OSdrpUFc500AkcJlHxm8/qLv5IiEMQJ9CoNDvno
         ju4zB8gMwb7jsDVkDckwdL1pPVs9CXS9IYw5V1u6UfEVFJggp3rAbO47SrvN2EIvSo
         +si6Q0PxzgNCQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: Re: [PATCH 00/16] rtw89: refine PCI and MAC codes into function with attributes
References: <20220325060055.58482-1-pkshih@realtek.com>
Date:   Fri, 25 Mar 2022 13:11:50 +0200
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 25 Mar 2022 14:00:39 +0800")
Message-ID: <87y20ynv61.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The existing PCI and MAC codes are only used by 8852AE, so many settings are
> put in single function. To be clear, move the settings into an individual
> function according to its functionality. Since functions will be shared
> with chips, add attributes to make it possible to use common functions.
>
> Also, update the settings to the latest version of our internal code.
>
> This patchset is based on                                                       
>  "rtw89: add firmware reset and dump firmware memory and backtrace" and
>  "rtw89: update TX power table and 6G, refine IGI, and add TX/RX descriptors V1"
> But no actual function dependency.     

The merge window is now open which means wireless-next is closed. I
don't mind people submitting few -next patches during the merge window,
but there's a limit for that. Currently I see 39 rtw89 patches in
patchwork, that's just too much. So please try to limit the number of
patches you submit during the merge window.

Usually wireless-next opens few days after -rc1 is released, but there's
no fixed schedule.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
