Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704776BAFD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjHARTP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHARTN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C663B137
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6EE61590
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 17:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7A9C433C7;
        Tue,  1 Aug 2023 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690910351;
        bh=F7aIk1U1l9tuxGzhLWqFjxngceqbK1kPItCQPAn02gc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mIGDMk3F2KAQC10VpUxNhI6wyOEd2+qhcwNo+X0S6hFhxsjcPr357d6L1UNdEDhDB
         x3c71KfAELgbQUg+5pSxVGA7M8Umi9US4+ColOqGd6IUQKJb7CccBt9pUq4rpMdG2q
         pYbwIBKZtdIEzfWa/enVnpc91XlDhCYwXo4Pwbh177SzNQ63FcUc+sNkC8U2HBlkBC
         XuGT0ER1irtgBsUey70/KdKyV+TAayWn5PzlYs3g9SIPr4bMbEWeSBdJ6VKhqzFBYX
         bbw5iPHATlNSx4jYhIbz2Ck8I6NBr4cnw5xXXZAI9EVt0Zo7Oyp6D/gnCAqZyerJP9
         KMQiATSYl/Grg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org,
        Herton Ronaldo Krzesinski <herton@canonical.com>,
        Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: MAINTAINERS: rtl8187 wireless driver
References: <20230608095051.116702-4-dmantipov@yandex.ru>
        <168664510862.24637.10587241603155144086.kvalo@kernel.org>
        <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
        <87h6rad3fp.fsf@kernel.org>
        <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru>
        <87cz1vbulk.fsf@kernel.org>
        <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
        <fe6b1abc-d529-c20f-3fcb-43d891091080@lwfinger.net>
        <87v8dzxg5l.fsf_-_@kernel.org>
        <92233d7c-9595-9223-39e1-6df68b13d474@lwfinger.net>
Date:   Tue, 01 Aug 2023 20:19:08 +0300
In-Reply-To: <92233d7c-9595-9223-39e1-6df68b13d474@lwfinger.net> (Larry
        Finger's message of "Tue, 1 Aug 2023 12:04:55 -0500")
Message-ID: <87y1iuwuib.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 8/1/23 04:31, Kalle Valo wrote:
>
>> + Herton, Hin-Tak
>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>> 
>>> On 6/16/23 05:20, Dmitry Antipov wrote:
>>>> Note MAINTAINERS marks drivers/net/wireless/realtek/rtl818x/rtl8180 as
>>>> orphaned but drivers/net/wireless/realtek/rtl818x/rtl8187 as maintained.
>>>
>>> Driver rtl8187 is certainly maintained, not that it gets many bug
>>> reports. Devices that support 802.11g are not used very often, but at
>>> least once a year I use my device to get online to retrieve the
>>> drivers for a fancier wifi card that does not have a driver in Linux
>>> or Windows. Drivers for the USB-based 8187A and 8187B have been in
>>> Linux since version 2.6.38 (December 2010), and also in Windows 7, if
>>> not in older versions.
>> So this is what we have in MAINTAINERS right now:
>> RTL8187 WIRELESS DRIVER
>> M:	Herton Ronaldo Krzesinski <herton@canonical.com>
>> M:	Hin-Tak Leung <htl10@users.sourceforge.net>
>> M:	Larry Finger <Larry.Finger@lwfinger.net>
>> L:	linux-wireless@vger.kernel.org
>> S:	Maintained
>> W:	https://wireless.wiki.kernel.org/
>> T: git
>> git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
>> F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
>> In the git history the last activity from Herton is from 2010 so I
>> think
>> we should remove him.
>> Is Hin-Tak still active? The last activity is from 2020.
>> Also the git tree is outdated so that should be removed.
>
> Kalle,
>
> I removed Herton and Hin-Tak as Maintainers for rtl8187 and updated
> the tree entries for rtl8187 and rtl8180. Patches are submitted.

Thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
