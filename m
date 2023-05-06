Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792CE6F8EBB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEFFvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 01:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFFvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 01:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F57DA5
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 22:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1681608D3
        for <linux-wireless@vger.kernel.org>; Sat,  6 May 2023 05:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C36DC433EF;
        Sat,  6 May 2023 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683352265;
        bh=cJNlq7s4/qMCZuG3GeMtE0cdpmLxxkHIwVlStqs9/+w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EO5Un2rUn02SD6ouy0+UQ2GFDcQmNhBaxbZ/RAg4XRgOw6B1kSVjHH70U6uXKaVrI
         z9GDJsy4nWPuQuZtA3ms+X1AUE8jvNGIVgCxWLl42sya4mFwYzC6srLnbT74D5b4UQ
         MKpl1Lo7/Fvqv++1Mwdv3ORGT8v8Imj79sIJQm54mbfibxyfEeL9YRXUneARO3Q9vb
         5z5qLYDfaP2+assuh6k7n9Nkrd6BPcik7OYEbWmh2gTmqk3bPeLYqpdLrsdHdPzkSq
         012q2aoj2+5X1lwZ3T90XIvcRhXaHfedoB6eq8woWXGjs3HzkfdHm++KcuBkEjN2j9
         YaChhh+Jlk+kA==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down during background scan
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
        <87wn1mok5g.fsf@kernel.org>
        <cffca4d1-5ab5-0633-7bab-00d65526bfa7@microchip.com>
Date:   Sat, 06 May 2023 08:50:58 +0300
In-Reply-To: <cffca4d1-5ab5-0633-7bab-00d65526bfa7@microchip.com> (Ajay
        Kathat's message of "Fri, 5 May 2023 20:53:12 +0000")
Message-ID: <87sfcanh31.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

>>> @@ -781,13 +776,15 @@ static int wilc_mac_close(struct net_device *ndev)
>>>       if (vif->ndev) {
>>>               netif_stop_queue(vif->ndev);
>>>
>>> +             if (wl->open_ifcs == 0)
>>> +                     wl->close = 1;
>>> +
>> 
>> wl-close is an int, I wonder if it's racy to int as a flag like this? In
>> cases like this I usually use set_bit() & co because those guarantee
>> atomicity, though don't know if that's overkill.
>> 
>
> I think it's a good idea to use an atomic operation but I am not sure if
> using atomic for 'wl->close' will have much impact. For instance, if any
> new work gets added to the workqueue before the 'wl->close=1' is fully
> completed, then that work would get executed as normal.

Sure, this is most likely a small race condition. But still a race.

> However, I feel it's safe to define 'wl->close' as atomic_t type. I will
> prepare the conversion patch and will try to include it along with the
> updated version of this patch.

Why atomic_t? You only use values 0 and 1 so test_bit() and set_bit()
sounds more approriate to me.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
