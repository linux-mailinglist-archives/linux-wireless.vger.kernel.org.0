Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492BE7D0201
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjJSSr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSSr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 14:47:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC9124
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 11:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E207C433C7;
        Thu, 19 Oct 2023 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697741246;
        bh=B213AO4xFnaHkwhZj+H4Og0bnzLtybxH5GNDhUER34A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Rft7g5YXq0af1fRdH9NPA3Rs51+N0LQ8zsSIWeGWoqkfG39+nx2YamjRgm56Nihbl
         nEckVjtZDLiRQGaC8oUqBNK2Ilg/CTmmOE9c3UpS37dQuWSVg8IPzEzuJrF59E8Qsl
         KQ71+DQVRTKwpaqB/nfy7Fw+d5/ydNrNo/+apYMqDdcHTG8HI39F+jDiqHe/lR6IeR
         iUa9Qc771ztXQcuaNMx6EdR6hyd/yBjaOQZxEU6uP3U/8pLCtZUwxiXEA4r8NoJsu0
         /H31hs+k2c0yNrE3m2qHayvxroUKOcPvB1GRXdVsNbN0Z/7a1p/HApWJZUaeDS3dih
         RKA1Bj9H/xYDQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Shiji Yang <yangshiji66@outlook.com>, helmut.schaa@googlemail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
References: <169769882877.117236.15856778587852752332.kvalo@kernel.org>
        <TYAP286MB0315BFF338DEE34898A20584BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
        <87h6mm20vl.fsf@kernel.org> <20231019175328.GA512047@wp.pl>
Date:   Thu, 19 Oct 2023 21:47:23 +0300
In-Reply-To: <20231019175328.GA512047@wp.pl> (Stanislaw Gruszka's message of
        "Thu, 19 Oct 2023 19:53:28 +0200")
Message-ID: <87cyxa1mbo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> writes:

> On Thu, Oct 19, 2023 at 04:33:02PM +0300, Kalle Valo wrote:
>> Shiji Yang <yangshiji66@outlook.com> writes:
>> 
>> > On Thu, 19 Oct 2023 07:00:30 +0000, Kalle Valo wrote:
>> >
>> >>Shiji Yang <yangshiji66@outlook.com> wrote:
>> >>
>> >>> The watchdog function is broken on rt2800 series SoCs. This patch
>> >>> fixes the incorrect watchdog logic to make it work again.
>> >>> 
>> >>> 1. Update current wdt queue index if it's not equal to the previous
>> >>>    index. Watchdog compares the current and previous queue index to
>> >>>    judge if the queue hung.
>> >>> 2. Make sure hung_{rx,tx} 'true' status won't be override by the
>> >>>    normal queue. Any queue hangs should trigger a reset action.
>> >>> 3. Clear the watchdog counter of all queues before resetting the
>> >>>    hardware. This change may help to avoid the reset loop.
>> >>> 4. Change hang check function return type to bool as we only need
>> >>>    to return two status, yes or no.
>> >>> 
>> >>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks!

>> That reminds me, is Helmut still maintaining this driver? I haven't seen
>> an ack from him since 2016. As we nowadays try to keep the MAINTAINERS
>> up-to-date so should we remove him?
>
> Yeah, feel free to remove him. I can post a patch if needed.

It would help if you can send a patch, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
