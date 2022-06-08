Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0D542A17
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiFHI4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFHI4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A63CE241
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA6D8B825A0
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 08:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CAFC341C0;
        Wed,  8 Jun 2022 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654676214;
        bh=Evnfp3bZxO7b1ZMmJ/xwt8jr7WQx6ELnm8EwvF7sqlM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M0Ri5KV1hhn1jkOigYeDsgmX7wQM+WB4Us1/HYD0XFwEe1YTswQ2WSFMwUjPT88tB
         I9FBVzQjo7wTSEaq0S2OUHhjyE8HDf8ZtsFzN/w0291x4dRvU4NFm2St/Qy31zPGM+
         QmM1FbDPZmtb6RgUpZ5RXfJ85NamKz0BQE/PEUl0QX116/N3EQalKK6I5PrlcDfNJq
         VKjHpMpM9K27pN55ctKr0HUdrqFBVWmZrU6YwBWPZFmx/gn86OARAN7y30x6nNwSnf
         cmdEacPwXBCNWMCvpOYOquMZwuc9J2zXwVxHeKxojESXnNQBf0GjCF8mVDzOvYWpig
         fYdTV0LStlckg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
        <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
        <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
        <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
        <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
        <764fc8f115dc411e82938311273d9b51@realtek.com>
        <87bkv3r43b.fsf@kernel.org>
        <5c48cda63e844e3f9703506309854a63@realtek.com>
Date:   Wed, 08 Jun 2022 11:16:49 +0300
In-Reply-To: <5c48cda63e844e3f9703506309854a63@realtek.com> (Ping-Ke Shih's
        message of "Wed, 8 Jun 2022 08:05:46 +0000")
Message-ID: <8735gfr2mm.fsf@kernel.org>
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

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Wednesday, June 8, 2022 3:45 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Larry Finger <Larry.Finger@lwfinger.net>; Nathan Chancellor
>> <nathan@kernel.org>; Johannes Berg
>> <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> >
>> > The ch_param[3] is only used by 8821c, so it doesn't affect other devices.
>> > I will prepare a patch to fix it.
>> 
>> But why didn't the compiler catch this? Is there some evil cast
>> somewhere which removes the const? We should fix that as well (in a
>> separate patch).
>> 
>
> This is because we assign a const to .driver_data that is non-const kernel_ulong_t:
>
> static const struct pci_device_id rtw_8821ce_id_table[] = {
> 	{
> 		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
> 	},
>
> When casting it back in pci_probe(), we need to add 'const' after Larry's patches:
>
> rtwdev->chip = (struct rtw_chip_info *)id->driver_data;

Yeah, that definitely needs to be const.

> I will prepare another patch to fix that.

Great, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
