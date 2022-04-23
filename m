Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1527E50C7BF
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiDWGTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 02:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiDWGTo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 02:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0771A8C09;
        Fri, 22 Apr 2022 23:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485E560AFA;
        Sat, 23 Apr 2022 06:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9095DC385A0;
        Sat, 23 Apr 2022 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650694604;
        bh=NVI7VzmGBiOb+BBY2T+Sry5ii2m+JF0yOSOAGGiJGNA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TDuUON4SFSkzEbWklnAI+3lnzbniB8kLFlbcWVemxsIJYxQk2TwXi6dXAS5XkMmM8
         NK951vyvCCosAr5rTQjj/KuZIXgDShmGTB043Z/iEOhRm8wrqNroXk3NWkStHP97nO
         7Gt6Hmu322Dip+uoTweYkFUPRzPEfqro6YXR1uQGV8S3NOgUeeMEj2e1BUaDfXrmqx
         VC1k7rL/uzdBmVR2eSV46wyvZBphfk/kDtN6/QyeQ49MSkofBTP8R4Ez1JdB9bL7EY
         A0EntQezILIo6CT/9AbOoW146GVfX0/xl4P5+B6LcQvBqiYQJS3hy5mkz8XjEPWPXH
         4qnUKAsfkd6hA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk
Subject: Re: wl18xx: NVS file handling
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
        <YmDpTAu9wmlLijDA@atomide.com>
        <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
        <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com>
        <YmKaoRfxo4bMzDdR@atomide.com>
Date:   Sat, 23 Apr 2022 09:16:39 +0300
In-Reply-To: <YmKaoRfxo4bMzDdR@atomide.com> (Tony Lindgren's message of "Fri,
        22 Apr 2022 15:08:01 +0300")
Message-ID: <87ee1oqq7s.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Yegor Yefremov <yegorslists@googlemail.com> [220422 10:40]:
>> Wouldn't we need this functionality [1] to make the NVS fw file optional? :-(
>> 
>> [1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20181112160143.4459-1-l.stach@pengutronix.de/
>
> Hmm yeah, how about if we use just an empty nvs file for no warnings then?

What's wrong with firmware_request_nowarn()?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
