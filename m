Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE476B606
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjHANje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjHANjc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 09:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA61BDB
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 06:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327B56158A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 13:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E43CC433C7;
        Tue,  1 Aug 2023 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897169;
        bh=9kGsbzX/hI4Xz6O0zEgqDeojgA8+ngAxvzHsSUzt1d0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ie3j8jUW0b06u3Ro/4D5ZrACxBDRm26lemeICO7Y2DCkajeXaZtWdK3UYhAY7pZq3
         dgBU+/GgrcOUnuWcHtc3QidiPkwvfG1kWiKoCsfBRpHSHZoyv7FJcxEV8icUJjO2RZ
         fVBqrYXI2G015/jnnObwYs7bto/q1mGB4WmyGdz+GZPAdTkd5ShT5lR1jzLrzLeFDB
         qjKFzFdJHexSU+TAcOEFANoyYLao5d2of8BR4be6AwdjNjAyAZ7j/ZDQTXBt3vwWyf
         zuayySg0AFZITpSrsJlHC6u8oFEQs6YkXi8hl+xe0zqEOY3ZHe/8X8yYStOBNUCG5Y
         9xcTiX8XvOg4Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
References: <20230724084457.64995-1-dmantipov@yandex.ru>
        <87cz0h3d1q.fsf@kernel.org>
        <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru>
        <87r0onxdra.fsf@kernel.org>
        <0368ccdc-74f4-6ec1-1b7d-cfb5ebfd479d@yandex.ru>
Date:   Tue, 01 Aug 2023 16:39:26 +0300
In-Reply-To: <0368ccdc-74f4-6ec1-1b7d-cfb5ebfd479d@yandex.ru> (Dmitry
        Antipov's message of "Tue, 1 Aug 2023 14:47:11 +0300")
Message-ID: <87mszayj8x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> On 8/1/23 13:23, Kalle Valo wrote:
>
>> Another problem I see that you don't always reply to review comments and
>> that gives an impression that the comments are ignored. Please always
>> try to reply something to the review comments, even if just a simple
>> "ok" or "I don't agree because...".
>
> Looking through my e-mails for the previous month, I was unable to find an
> unanswered review. Could you please provide an example? I'll fix it
> ASAP.

You have sent so many patches and I don't have time to start go through
them. Maybe I noticed that with some of mwifiex patches, not sure. But
that doesn't matter, I just hope that in the future you reply to
comments.

> I don't want to speculate around the workflow of others and realize
> that someone (especially the maintainer) may be overloaded and too
> busy. OTOH it's not quite clear why the trivial things like
> https://marc.info/?l=linux-wireless&m=169030215701718&w=2 stalls for
> almost a week. Should I consider this as "ignored" too?

A delay of week is business as usual, I have patches in queue which are
from last October:

https://patchwork.kernel.org/project/linux-wireless/list/?series=684424&state=*

Remember that this is not a 24/7 service and we just had a summer break.
I have 160 patches in patchwork right so expect long delays but you can
check the status from patchwork yourself:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
