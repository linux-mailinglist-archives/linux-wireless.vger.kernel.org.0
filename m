Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F550CF17
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiDXESv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 00:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiDXESt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 00:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D41C04BD
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 21:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D709F6124F
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 04:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E566C385AB;
        Sun, 24 Apr 2022 04:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650773749;
        bh=HihQALnqFpJOjpZ/CRj1wUbh8YQud7YOBCN7QKcEZo8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dTi+5LNXEy1OQBJXE0lzsqnpZpfy6Vs8ASnoXRXOiOYgxUYDdPYhEX2U2vy7lqIYR
         q5ca+h7J++Ww0fN7LuIhNarZROssKjb4YLL5zi9k1uCCiDNT+6EhBtbxiPmQKBttmP
         3WG7bKwqWIcqn4qJDRh7xe1Dz/T7ztE5ofjLh/k4NVjXBkUwZxN99H7OqT/jEA6NFG
         KiflCVZ4gyZhDR+xNVLcqRuhhjCgJIOegf2tzF8pUXqdQY7duB3BuLTeJ6IqtTimiP
         OkY30NgOMDftLNtPRwVzeT51eKKF0QnTRMgoZfd5RG2nRO0Do4YyWS8iABVs4UpDg1
         21Dwinj+L2SxA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low power mode
References: <20220421120903.73715-5-pkshih@realtek.com>
        <165071716438.1434.8811355640487410145.kvalo@kernel.org>
        <875yn0q8lf.fsf@tynnyri.adurom.net>
        <dcdf7eed815fb6e557a85910ad91d4a2f4614f5c.camel@realtek.com>
Date:   Sun, 24 Apr 2022 07:15:43 +0300
In-Reply-To: <dcdf7eed815fb6e557a85910ad91d4a2f4614f5c.camel@realtek.com>
        (Pkshih's message of "Sun, 24 Apr 2022 02:58:48 +0000")
Message-ID: <871qxnqfps.fsf@tynnyri.adurom.net>
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

Pkshih <pkshih@realtek.com> writes:

> On Sat, 2022-04-23 at 15:37 +0300, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>> > Ping-Ke Shih <pkshih@realtek.com> wrote:
>> > 
>> > > In lower power mode, there are very low amount of RX, and it must process
>> > > in a separated function instead of schedule_napi(), because the existing
>> > > napi_poll does many things to optimize performance, but not all registers
>> > > can access in low power mode. The simple way is to use threadfn to process
>> > > the simple thing.
>> > > 
>> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> > 
>> > The title is hard to understand.
>> 
>> If you can provide a new title I can fix it during commit.
>> 
>
> Please help re-title to "rtw89: pci: add a separated interrupt handler for low power mode".

This is much better, thanks. I'll update the title during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
