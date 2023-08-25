Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF07880CF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbjHYHXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbjHYHWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1C19AC
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC65F62AEE
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BB0C433C7;
        Fri, 25 Aug 2023 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692948157;
        bh=ct8NsqAVgtJFBmDRSj177pN6hbc7zcFgNSUeeCMXB7Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zzp8v3SG1igRyTlWLS+rCUbCe5cbqO8qG28fxbSNkCWxtGAhJpZM3E/Htiq1aLP5j
         F0wsecHU5dqKBKpUr8k5WcwDrXx3bJ9VoBgG4gCtAxncK8iBbzekAmifH8i4aq4A3+
         AsCQN6VY2cVuG7eD/jBXrIDmmurhMS2fgPTzQ8/I1Fdm7YflncsMJaiYnHSUPU524W
         NBUywnSR7iKxnaiC1wkbbk+j/2zR+AFRHkuzXw7tM/NF4a4gO2skl2yqC7RdMGSlct
         aZ+XzuKfbqwpos4JGiG64XtdI9FIPogCqPBSNw9UoeXg30Tpm9locECYW+CnOjT7Y4
         wvEyOm5JH4vuA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
References: <20230825062404.50813-1-pkshih@realtek.com>
        <87o7ivvcta.fsf@kernel.org>
        <95d1062787fc4b2994f4b880179f41ef@realtek.com>
Date:   Fri, 25 Aug 2023 10:22:34 +0300
In-Reply-To: <95d1062787fc4b2994f4b880179f41ef@realtek.com> (Ping-Ke Shih's
        message of "Fri, 25 Aug 2023 07:02:35 +0000")
Message-ID: <87bkevh9hh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Friday, August 25, 2023 2:47 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Bernie Huang <phhuang@realtek.com>; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > From: Po-Hao Huang <phhuang@realtek.com>
>> >
>> > The probe function of 8822cu is misplaced to 8822bu, so we fix it.
>> >
>> > Fixes: 07cef03b8d44 ("wifi: rtw88: Add rtw8822cu chipset support")
>> > Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> I guess this is just a cosmetic change and does not cause any changes in
>> functionality? I can add that to the commit log.
>
> Yes, it doesn't change anything. If Fixes tag is not suitable, please also
> remove it.

Good point, as this is not fixing any functionality in opinion there
should not be a Fixes tag. I'll also remove that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
