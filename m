Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D5647226
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLHOrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLHOrr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 09:47:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00770BC18
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 06:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96690B82407
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 14:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A1C433D7;
        Thu,  8 Dec 2022 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510862;
        bh=9vrFXw+w9zyJeuVoJgnWYnTSEQu1EDA2aAQctMsJb88=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qh7K3RoGM9l1buurT7g9uArwz1JWurE3D4rmQY7jqrfSKhw/9j6V8WTWPjRWXpn/9
         LstEe3r492yx8eJW5Qk6lfLNO1O7hixc53OhwOEo146lvsfk7+ocYYEAYSVpR0sBaa
         tw1YdgnZvzRy8hZfJ8EXM5fKRYkltFAqdtbbaRnyyEvd7R1ZOIWGvR3qVjQx2WerQJ
         6WvuGvN8Fz7BeFj+cfhlqtRt+BQJyGUNbJpyLFMl5+o9XQQfq5G/y6zH5BExEd/bUj
         YCCjviSB4VDhZ3XmPnoRDjHI+6vM0FSe9yBGeQBUSOZ2t+70zHa5fJICMKQU9nzgwf
         mDaJy6Im5UwmA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: don't request partial firmware if
 SECURITY_LOADPIN_ENFORCE
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221202060521.501512-2-pkshih@realtek.com>
References: <20221202060521.501512-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167051085972.9839.9335859470213768636.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 14:47:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Kernel logs on platform enabling SECURITY_LOADPIN_ENFORCE
> ------
> ```
> LoadPin: firmware old-api-denied obj=<unknown> pid=810 cmdline="modprobe -q -- rtw89_8852ce"
> rtw89_8852ce 0000:01:00.0: loading /lib/firmware/rtw89/rtw8852c_fw.bin failed with error -1
> rtw89_8852ce 0000:01:00.0: Direct firmware load for rtw89/rtw8852c_fw.bin failed with error -1
> rtw89_8852ce 0000:01:00.0: failed to early request firmware: -1
> ```
> 
> Trace
> ------
> ```
> request_partial_firmware_into_buf()
> > _request_firmware()
> >> fw_get_filesystem_firmware()
> >>> kernel_read_file_from_path_initns()
> >>>> kernel_read_file()
> >>>>> security_kernel_read_file()
> // It will iterate enabled LSMs' hooks for kernel_read_file.
> // With loadpin, it hooks loadpin_read_file.
> ```
> 
> If SECURITY_LOADPIN_ENFORCE is enabled, doing kernel_read_file() on partial
> files will be denied and return -EPERM (-1). Then, the outer API based on it,
> e.g. request_partial_firmware_into_buf(), will get the error.
> 
> In the case, we cannot get the firmware stuffs right, even though there might
> be no error other than a permission issue on reading a partial file. So we have
> to request full firmware if SECURITY_LOADPIN_ENFORCE is enabled. It makes us
> still have a chance to do early firmware work on this kind of platforms.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

3ddfe3bdd3cf wifi: rtw89: don't request partial firmware if SECURITY_LOADPIN_ENFORCE
13eb07e0be1b wifi: rtw89: request full firmware only once if it's early requested

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221202060521.501512-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

