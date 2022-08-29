Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D95A50F4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiH2QG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2QG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 12:06:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD0844C6
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 09:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEB19B81113
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 16:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D915C433D6;
        Mon, 29 Aug 2022 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789184;
        bh=kO93razJehAAS6HlG3PZVa2y3zcWOkwa8L2XTA+rYqk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DBleYeUy9uyqrNkJ7GG/N+kgAX2mIRL3+iXk0a3Y+wigfeAxcF7GRDUyAom9T6h3y
         ZpIYTEED6bcXTEp8x7lzF7PzipsKP1w/HVNeTxk9ffJnWZnuO69/UhWVyMvm/nhwqk
         4i/VKWkacpJF4SuA+5CGDo+R1H7KD/ou+U3C6lbksF90B4kTtN6es69wd9XNS6HXFn
         fyTT1smiU3pCOZ1DVmtA6A10WTq2gC9BtxF816vDzegdY4L8+Sqws997zktnU9NDgE
         C28ky/Ez598CZ4KzHGuSxHjxXKIh/Brrb7Jh8M5J05WinxLXuj/WjXuV6tCST+3Km4
         ttlg8xzo87cLg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        mwalle@kernel.org
Subject: Re: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
References: <20220809075749.62752-1-ajay.kathat@microchip.com>
        <b1e606e7a36fb900bbc664bbd585ff6a@walle.cc>
        <87k07fgz16.fsf@kernel.org>
        <bbbaf29f1767a7f90851505cd4a24ce6@walle.cc>
Date:   Mon, 29 Aug 2022 19:06:21 +0300
In-Reply-To: <bbbaf29f1767a7f90851505cd4a24ce6@walle.cc> (Michael Walle's
        message of "Mon, 22 Aug 2022 09:27:04 +0200")
Message-ID: <875yibdog2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michael Walle <michael@walle.cc> writes:

> Am 2022-08-11 06:55, schrieb Kalle Valo:
>> Michael Walle <michael@walle.cc> writes:
>>
>>> Am 2022-08-09 09:57, schrieb Ajay.Kathat@microchip.com:
>>>> Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
>>>> object on the stack. Use dynamically allocated memory for cmd53
>>>> instead
>>>> of stack address which is not DMA'able.
>>>>
>>>> Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
>>>> Reported-by: Michael Walle <mwalle@kernel.org>
>>>> Suggested-by: Michael Walle <mwalle@kernel.org>
>>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>>>
>>> Thanks!
>>>
>>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>>> Tested-by: Michael Walle <mwalle@kernel.org>
>>
>> Thanks Michael. My plan is to take this to the wireless tree, seems
>> important enough fix.
>
> Do you already have any plan, when you will pick this?

Any day now. I was on vacation but now back.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
