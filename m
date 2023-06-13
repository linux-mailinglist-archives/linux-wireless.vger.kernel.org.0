Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18D72DCA3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjFMIhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbjFMIhQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB734CD
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D93C629DD
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDCC4339B;
        Tue, 13 Jun 2023 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686645428;
        bh=fCIjErVwfOklecRcRgYHfyOqXzBeEVKx1kIfZOGeR1c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aNOYCn1wFr280Ae8Mc/UqmZCp/GLEOEx79c4GOwkVZMJW1WMGKRsVdRu8FcxeWKXA
         1icYTmBZrVkCfBpAL6iHslKwBZ78bbbBh5bUXzqDT1h8cabKH5+ampVRhn/fIzUKcE
         6C4CrlEFBCjMKAryC5m86ZwXuFdx/KGpXNgzsCLllyCag41YkhsRq+aAAx/zA6MPIs
         w6KCsibeCMcgUT5/BEmnfvNS5wfo6PqcH9MYKuHzJUxSnUOSiuVB7M57DCZusovf8k
         bTjolWDuJOxhQzK7OF+5AheCjI6gKGZArz/DRmck+mRbrkx/lYaU8JM61WuqL1B+Y6
         Zm4SSEp/p1vFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: add missing unwind goto for
 __rtw_download_firmware()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230607012741.10353-1-pkshih@realtek.com>
References: <20230607012741.10353-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <s.hauer@pengutronix.de>,
        <dan.carpenter@linaro.org>, <lkp@intel.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664542578.24637.12994274738056453898.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:37:07 +0000 (UTC)
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

> This flaw is detected by smatch:
>   drivers/net/wireless/realtek/rtw88/mac.c:748 __rtw_download_firmware()
>   warn: missing unwind goto?
> 
> Though most things of dlfw_fail have been done by
> download_firmware_end_flow() and wlan_cpu_enable(), an exception is that
> download_firmware_end_flow() clear BIT_MCUFWDL_EN bit conditionally.
> So, make this change to clear the bit.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202306052310.OVhcUjZ3-lkp@intel.com/
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

91ccdbb94fea wifi: rtw88: add missing unwind goto for __rtw_download_firmware()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230607012741.10353-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

