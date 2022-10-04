Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82325F3E4B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJDI1K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJDI1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:27:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957E22513
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05213CE0E01
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F8AC433D6;
        Tue,  4 Oct 2022 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872019;
        bh=DFEQRHBLm5JZA0xuVWbYnxJ2fbkmq3IRTQdSGEhI+14=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jzT7uo+xsh5wOVODEaOH+om9ttH6blJiI2/DaQA8gC0aN9rDe6OhByaAnFlnjXlLF
         WTNqVh22mgMD6fwn0uC7HJMDXvOJ1cLdhjSTITPUrjYL5aynnu9KJKBatciDTmmnEu
         bsUsD4rqmfE7iUckzizTJxiSShp4oa2JBBC8RlhhWL+kHChcX9Bg5/xZyty7Xd0McG
         Opo/kjcUJzzKbgsT87wnv16scUnGXBSQTgS62Sa3vQrvZ4cLbfTdh5Jb+Z6dzNRGH7
         Xo4n/CsBYt4vgg5/R4joV76Kp1PXmZIu4qmCkObZ3BbUIopYTvjU51CBwClHb8gDYs
         SAdXhoRx8WCtA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: rtl8xxxu: gen2: Turn on the rate control
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
References: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487201688.2137.15541848682756407022.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:26:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Re-enable the function rtl8xxxu_gen2_report_connect.
> 
> It informs the firmware when connecting to a network. This makes the
> firmware enable the rate control, which makes the upload faster.
> 
> It also informs the firmware when disconnecting from a network. In the
> past this made reconnecting impossible because it was sending the
> auth on queue 0x7 (TXDESC_QUEUE_VO) instead of queue 0x12
> (TXDESC_QUEUE_MGNT):
> 
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
> wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out
> 
> Probably the firmware disables the unnecessary TX queues when it
> knows it's disconnected.
> 
> However, this was fixed in commit edd5747aa12e ("wifi: rtl8xxxu: Fix
> skb misuse in TX queue selection").
> 
> Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu devices not reconnecting")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

791082ec0ab8 wifi: rtl8xxxu: gen2: Turn on the rate control

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/43200afc-0c65-ee72-48f8-231edd1df493@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

