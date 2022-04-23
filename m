Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5550C9FE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiDWMkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiDWMkQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 08:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8F1CCF94
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 05:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D92610AB
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 12:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742C9C385A0;
        Sat, 23 Apr 2022 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650717439;
        bh=Hov9OVIeSqhoHhOz+5UlFfZnh/K4dDDHrHhPA80iooY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bVEPMU5d+Tx9S5RRW8jw3l4Odt4P9j0SIP5xQyuyGsXAtx+gQjPfscW/yNLZ02eAB
         KujxyUrewlBpEGPvhBLq07c8s9RXY1PvKy8Gi8cx+xrirqijD6tmMOrP6ZhAip6Sl1
         WU1d7Q6T7VNB5/+7SlFRFMgW4oRXomjF5CfX0IMbI6SYz5TpjbvXZ/xb7q2vrgQJm5
         HQO6SfK5MM507gaUFYW0wRXAUn0dNg1tuXO16eAESzxdktacmLOaBQWFe2bMK6mcvw
         gTOj8eaczqjzJY+KAr8I8vE5heiJhAfsbAh2XeiRqfvKrH5z0CeHXLTEn2Y1Jk/Tjf
         /Z3I+Jo62d9/Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/14] rtw89: pci: does RX in interrupt threadfn if low power mode
References: <20220421120903.73715-5-pkshih@realtek.com>
        <165071716438.1434.8811355640487410145.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 15:37:16 +0300
In-Reply-To: <165071716438.1434.8811355640487410145.kvalo@kernel.org> (Kalle
        Valo's message of "Sat, 23 Apr 2022 12:32:47 +0000 (UTC)")
Message-ID: <875yn0q8lf.fsf@tynnyri.adurom.net>
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

Kalle Valo <kvalo@kernel.org> writes:

> Ping-Ke Shih <pkshih@realtek.com> wrote:
>
>> In lower power mode, there are very low amount of RX, and it must process
>> in a separated function instead of schedule_napi(), because the existing
>> napi_poll does many things to optimize performance, but not all registers
>> can access in low power mode. The simple way is to use threadfn to process
>> the simple thing.
>> 
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> The title is hard to understand.

If you can provide a new title I can fix it during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
