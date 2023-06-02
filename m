Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5369F71F9A1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 07:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjFBFTn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFBFTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 01:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1E197
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 22:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D834A64C59
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 05:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53063C4339B;
        Fri,  2 Jun 2023 05:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685683172;
        bh=b9XqLjohgexUDBvTHch0fXNdlKc3xtN8ysTdJhrzGh0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DtmryheVXDoD/U4cyZSOkd1a5OuUzxXv3E3QwoR6MaMZRVh0BmO7/y+l0QmwnU4Qm
         oJ2Q0g8yR1UgctN0UIZQTcMsqilOfQHxOMOEYTyHEYnVR1kid6tQpFQCy5+pkv7p4K
         LzqgHdiOutEI2i0ghqoMZDFm3SfSkePGiC6J044BJ/n7k5N1AsSy5s8PNHJph7GWBs
         9vkJe8uxiULkRFmf3h/QockSRacREUozx27BL2Dv4/LHVFkHcnrfjHC5zK8G6tU6dx
         b/CWiuCiZd/ixjvg0aaUGfFWaNUv9HGeyohZJ4DJjFANl4zqLYm1u1DYAoU5UqzaBV
         HpKz/Fkr2++oA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>,
        linux-wireless@vger.kernel.org,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robert Marko <robimarko@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Shiji Yang <yangshiji66@qq.com>
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
References: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
        <d68c4b38-88e1-02ef-5779-08b93fd0d47b@kernel.org>
Date:   Fri, 02 Jun 2023 08:19:27 +0300
In-Reply-To: <d68c4b38-88e1-02ef-5779-08b93fd0d47b@kernel.org> (Jiri Slaby's
        message of "Fri, 2 Jun 2023 06:58:31 +0200")
Message-ID: <87cz2ejva8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> writes:

> On 02. 06. 23, 6:36, Shiji Yang wrote:
>> From: Shiji Yang <yangshiji66@qq.com>
>>
>> Add a struct_group to around all members in struct ath_cycle_counters.
>> It can help the compiler detect the intended bounds of the memcpy() and
>> memset().
>>
>> This patch fixes the following build warning:
>>
>> In function 'fortify_memset_chk',
>>      inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
>> ./include/linux/fortify-string.h:314:25: error: call to '__write_overflow_field' declared with attribute warning:
>> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>    314 |                         __write_overflow_field(p_size_field, size);
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>
> Hi,
>
> what compiler/version is this with?
>
>> Signed-off-by: Shiji Yang <yangshiji66@qq.com>
>> ---
>> More discussion on: https://github.com/openwrt/openwrt/pull/12764
>
> No "__write_overflow_field" there. Is this the right link?

Also it's better to include links like this in the actual commit log so
it's archived to git.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
