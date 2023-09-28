Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8697B222B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjI1QWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI1QWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 12:22:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B3B7
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 09:22:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBD4C433C7;
        Thu, 28 Sep 2023 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918167;
        bh=u3b7XsKiElAWSNr1YIYXGE/clgmTiRQ/a4LE1Jn2Mmw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k5PhC8zf0MrD8a9MvhGRgdDsRa7h+hzFTFYkqyemOH0O/W2p1HIdSlO4QeZ8S19sh
         2ZRvm+NggrBV89Sh4JXk0UEWwJYP61uRrqCkiBCamTGa/lW44x3kSix/Ec55WK1P/P
         EYLDru0PKk6u4dSd38TzpeoobO+4AzX0cW1+GEbUvVvUFyd/gdRitm6p2eEKQgFopB
         X8QSXxS9LaRbBXV71Wmv91/xTy/8ykMXXtRV5M2PBTxDwmxWGUhvBWFO/D4yvCosfv
         LLc5E4b5Vo9srKPR8MNDnXXZDdl0t5PcZNUljvZr1Ky1FXdajBobkmMxRj0dTgoVlK
         2ekozxhq92J3w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: rtw89: refine uplink trigger based control
 mechanism
References: <20230925080902.51449-3-pkshih@realtek.com>
        <169591802194.3187104.18062067562610023067.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 19:24:54 +0300
In-Reply-To: <169591802194.3187104.18062067562610023067.kvalo@kernel.org>
        (Kalle Valo's message of "Thu, 28 Sep 2023 16:20:23 +0000 (UTC)")
Message-ID: <87v8bui7u1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Ping-Ke Shih <pkshih@realtek.com> wrote:
>
>> From: Po-Hao Huang <phhuang@realtek.com>
>> 
>> Rename support_ul_tb_ctrl to waveform_ctrl since we need to do more
>> trigger based control and the naming could be confusing. Move related
>> code to leaf function so we make each functions separate and can be
>> easier to maintain.
>> 
>> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> I don't see patch 1 in patchwork and I see patch 3 twice. Please check
> and resend.
>
> 3 patches set to Changes Requested.
>
> 13397427 [2/3] wifi: rtw89: refine uplink trigger based control mechanism
> 13397424 [3/3] wifi: rtw89: Refine bandwidth 160MHz uplink OFDMA performance
> 13397426 [3/3] wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

Actually patch 1 was assigned to Johannes and he has already applied it.
But due to seeing patch 3 twice it's still best to resend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
