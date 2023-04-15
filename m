Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85A6E2F2D
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDOFgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 01:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFgf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 01:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6A55B4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 22:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615C5603F7
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 05:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC04C433D2;
        Sat, 15 Apr 2023 05:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681536993;
        bh=/5703C1KQ0pVciLtlUnrilZmvoQNZ1nypX2Mh4pgNu0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IENFiRQE1V/lsJrEyxz3VDsCAnKq7fzT57Xy3d9MUv7ZP5/mc/h0e5CtGuCPYUFoj
         RuryLWda22+1Z4l4elRSd/vORQ6qs+JApkc7fZqmmoz48jYD8bNHjyAUgJY1prKFcd
         ItG9w2mZU+DCrTnI9MBFeyvGpzcie/oWLEgNeWFFcBarhgs28TeqPP08WnWQOCjpES
         DqVT26JuuW4mBw77VxnyL2aPT9QH6ozJD1W6jeEH83myPRQJYisF40QitOTh+UByf8
         Q606kxjegoEuR+5aTPul7CJ8vi4pnZxTkGAnU7zXWEX8uGQMfnPamGRJlBmp0Wx83M
         urutd4415DoOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "Larry.Finger\@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "s.hauer\@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: Question about rtw88 patches
References: <3aaaceb0-1518-49b6-ca18-f7c46c35c65c@lwfinger.net>
        <e8e70392bb38ee44f29fd0dc2522daa8340cf609.camel@realtek.com>
Date:   Sat, 15 Apr 2023 08:36:29 +0300
In-Reply-To: <e8e70392bb38ee44f29fd0dc2522daa8340cf609.camel@realtek.com>
        (Ping-Ke Shih's message of "Sat, 15 Apr 2023 04:00:28 +0000")
Message-ID: <873551so4i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Fri, 2023-04-14 at 14:50 -0500, Larry Finger wrote:
>> 
>> Kalle,
>> 
>> Has something gone wrong with Sasha's rtw88 patches to fix the hardware queue
>> selection in rtw88 [1], and the corresponding rfe field width fix [2]. These two
>> patches are included in my GitHub repo for rtw88, and they fix the ubiquitous
>> "timed out to flush queue" warnings.
>> 
>> Larry
>> 
>> [1]
>> https://lore.kernel.org/linux-wireless/20230404072508.578056-2-s.hauer@pengutronix.de/
>> [2]
>> https://lore.kernel.org/linux-wireless/20230404072508.578056-3-s.hauer@pengutronix.de/
>> 
>
> Hi Larry,
>
> I think this is because I have some suggestions of [2] to improve further.
> Do you think we can take this temporary version in advance? 

Yeah, I put the patches in patchwork to "Changes Requested" as Ping had
comments for them:

https://patchwork.kernel.org/project/linux-wireless/list/?series=736690&state=*&order=date

My assumption was that there will be v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
