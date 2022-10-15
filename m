Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA235FF87B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Oct 2022 06:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJOEvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Oct 2022 00:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJOEvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Oct 2022 00:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99A59709
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 21:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCD79B80DFE
        for <linux-wireless@vger.kernel.org>; Sat, 15 Oct 2022 04:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40429C433D6;
        Sat, 15 Oct 2022 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665809469;
        bh=8z75NSZE3HzGHYQ+adXyIptV4iDRoSrEyuVHiE57hbc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fnp9nA3jaYjW+P5KE9XMsMb1Qa45rNkfoepHOco9Dj5u/QbG9/M0hC1I1utp24ISJ
         T4Rjo81VBowkDIY3Ur81IGnmptnKGyhJpJC0iEmHE58fAhpWa88Vduc0/rnvsFoGHC
         eqm5NO8OXITMrWh9F3BDgK4tWfT2BXOUnsRE1GDeQ6WlQ50i1YQSO9He9fAJwIdH9/
         Iqc7hwdDgjmg2hy4zNQlzK60EnJ7GCaumMFuOrazsmfA9WnzFsDQ5zoR0JSoaW4Mzj
         2ZA8LNNlcte+oKI6+StGkyuEFbTOqfrAa7teOrr1y/hn1uHt1LlZ9yrBGf/s6+/CA5
         66OkxwUitAOGQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] bcma: gpio: Convert to immutable gpio irqchip
References: <20221012192348.2234478-1-linus.walleij@linaro.org>
Date:   Sat, 15 Oct 2022 07:51:01 +0300
In-Reply-To: <20221012192348.2234478-1-linus.walleij@linaro.org> (Linus
        Walleij's message of "Wed, 12 Oct 2022 21:23:48 +0200")
Message-ID: <878rlh4rm2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This switches the BCMA gpio irqchip to be immutable.
>
> Tested on the D-Link DWL-6810AP.

I'm not familiar with the gpio system, what's the benefit from this? I
can add that to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
