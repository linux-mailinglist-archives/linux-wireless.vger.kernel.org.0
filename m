Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5E603989
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 08:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJSGE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 02:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJSGEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 02:04:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63D23170
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 23:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 135B7CE1FC8
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 06:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6263AC433D6;
        Wed, 19 Oct 2022 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666159488;
        bh=aQRs+/IRtJHrswbGzIT9ohc09v4w/jmxfdJX50vDM50=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ioRbakc9zhTJBn8cgPEe3Xyix7wyuJfaGncggZSI8T2GjI5PCLOHJloxtxEN6iO9n
         L58aUY07eThyxjsXkn2m/c258DOhlOpNES+H8Z9SOEH3tcq3hYCBFoTnKt8Jfeast7
         Xo4nJxrvRnUKAO2+NjZULPmERQ0H3OLgMhjLbLCVhCzPIJ93hYK5A5dIGwsEjTkfr8
         5/IGugiOs8AUJV215hgxh2ZVshx8NHrd75dABmVGMIrymhGMOPhae20wti8xwOQSwv
         oxQ2i5VWjapAclYclH+JEby2J6ktuFHL7Q4UmHnkENUyaSFdSk8LCQAkMNR4hA23n9
         zE5pA4SyhhUnA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?Q?Rafa=C5=82_Mi?= =?utf-8?Q?=C5=82ecki?= 
        <zajec5@gmail.com>, linux-wireless@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] bcma: gpio: Convert to immutable gpio irqchip
References: <20221012192348.2234478-1-linus.walleij@linaro.org>
        <878rlh4rm2.fsf@kernel.org> <86bkqdflts.wl-maz@kernel.org>
Date:   Wed, 19 Oct 2022 09:04:45 +0300
In-Reply-To: <86bkqdflts.wl-maz@kernel.org> (Marc Zyngier's message of "Sat,
        15 Oct 2022 11:00:31 +0100")
Message-ID: <87tu40l56q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On Sat, 15 Oct 2022 05:51:01 +0100,
> Kalle Valo <kvalo@kernel.org> wrote:
>> 
>> Linus Walleij <linus.walleij@linaro.org> writes:
>> 
>> > This switches the BCMA gpio irqchip to be immutable.
>> >
>> > Tested on the D-Link DWL-6810AP.
>> 
>> I'm not familiar with the gpio system, what's the benefit from this? I
>> can add that to the commit log.
>
> TL;DR: the GPIO subsystem plays dirty tricks on the irqchip
> structures, and we're fixing it one driver at a time.
>
> See merge commit 4bde53ab3370 for all the details.

Thanks, I included this to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
