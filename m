Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DF56127A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 08:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiF3Gc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 02:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiF3Gcy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 02:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F120F6F
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jun 2022 23:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C68621ED
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 06:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA3C341C8;
        Thu, 30 Jun 2022 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656570772;
        bh=jdDk5FZOBNYJB0RdwFzat/YxmbQdC+0GA0LykpXzdOs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YqmfTaU6aLtSJIjGHqexhp0u9J1+XxmYTBEvD3M4J+1HyvQZNYqSNcPqHLPcCrkmo
         cLFIAtBzS8LKOnA++M9wlLz9JvxsdKFKj34joEd1KdKtwhX73ocSysmMGAtxteiDWp
         Dm8cKyJ9h1DDiyqCFN80QoLTYR11upxAVTBRO94bj/4yMMhTKmJMu8B6YEZrTi6uyH
         Qipxta8+jDsydUhWCsD2wNdP59FxRfmCseH3dQgRUm1lkNxfdU3S7oz3xu7/JXb4Ch
         jvKuT2JgKmQMOPwN6LmvkZNHB/33XG4s1SXbrxX68RjXjydYzYCBzD750/C1FmpCz6
         79o081exaBl+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Jithu Jance <jithu.jance@broadcom.com>
Subject: Re: [PATCH 1/1] cfg80211: Allow P2P client interface to indicate successful 4way handshake by port authorization
References: <ef25cb49fcb921df2e5d99e574f65e8a009cc52c.1655905440.git.vinayak.yadawad@broadcom.com>
        <87a69vpen5.fsf@kernel.org>
        <CAMLe8U9R=TktuhY_baVyexKsvArw70wyT-k_=LLpkXASK0M9kw@mail.gmail.com>
Date:   Thu, 30 Jun 2022 09:32:47 +0300
In-Reply-To: <CAMLe8U9R=TktuhY_baVyexKsvArw70wyT-k_=LLpkXASK0M9kw@mail.gmail.com>
        (Vinayak Yadawad's message of "Thu, 30 Jun 2022 09:24:54 +0530")
Message-ID: <87v8sioe40.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:

>>>These kind of disclaimers do not belong to public lists.  
> This disclosure got added by mistake, I will resend the patch again if needed without the disclaimer footer.

Also please don't top post or use HTML in emails, it's best to ditch
Outlook when sending emails to upstream lists. More information in the
wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
