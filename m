Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345F7516ADB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 08:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379647AbiEBG32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383424AbiEBG30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 02:29:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A363C5
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 23:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B147FB81059
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 06:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1431C385A4;
        Mon,  2 May 2022 06:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651472754;
        bh=7Jv9elAuph8QE9yzvniplE6WH4Cn9T32X+kqlly3l58=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PtmaEvA8x5jQ+D3qtf8A74qP4YVWTzEzA9dXyaRjQ55D24trCpp7oHs1wt7xRDBU6
         wF2R1fl9kyHGd3MmCn5HFN5TLdFoTR8I3+tflqdcBB+Nr8Z+5rKCW2uXu1G2OoYDZ4
         V30skYo5Ol5vYzNVikSPKFHPw+jnIKTyAf9/lhCvcM7E16sL99PyzU20EpLPBZuPOq
         0I2CqOgMwdrF/VBP0bX2Am2CS7wtlgjJ6s2UDTcGw/EJH2YvY3RLanverbHic9o1U8
         9j/ZlYySxXO1ypg7WvCVPPHtaZfKXepWyMSQTIv6xb+CdeMy18CbHyO193WD70w1Nl
         TgKOBpht+ToOw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wfx: avoid flush_workqueue(system_highpri_wq) usage
In-Reply-To: <3841528e-78ae-c3c4-169a-eeb39714f7ca@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Sun, 1 May 2022 19:23:16 +0900")
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
        <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
        <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
        <4557835.LvFx2qVVIh@pc-42>
        <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
        <87fsltd462.fsf@kernel.org>
        <3841528e-78ae-c3c4-169a-eeb39714f7ca@I-love.SAKURA.ne.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 02 May 2022 09:25:48 +0300
Message-ID: <87a6c0cuxf.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2022/05/01 17:53, Kalle Valo wrote:
>> So now the thread is created every time the module loaded, even if
>> there's no device available.
>
> Excuse me, but what thread?

Sorry, s/thread/workqueue/.

> alloc_workqueue() without WQ_MEM_RECLAIM flag does not create a
> thread, and therefore consumes little resource where there's no device
> available does not matter.

It still allocating memory which is not needed. To me allocating
resources during module_init is wrong.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
