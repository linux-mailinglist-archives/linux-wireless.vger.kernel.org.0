Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D675FAE42
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJKIQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJKIQG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 04:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394F91E716
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 01:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3C061146
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 08:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74FFC433D6;
        Tue, 11 Oct 2022 08:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665476139;
        bh=A6wVGA+pwMc+0q/He+Pp+aN/oc/seDRDWRwlQE7tQeQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q2rQmLTGO1zruL7ldvYdUQDpq8pvO3uGHpd++d7IDx0x94ELM8lLGfWg812wCJ3Bf
         WssmJYIf+GE3iXYYiVcz6F7LWFNAhQRbhDAKdKpmofUmI4W3EhaFDyQW8FmcGnvv4r
         S7jnZqN/ewZLcZM0EMb1qU/uvPvre8Z3CTDJbK3tjSflCVu2dIFunDmIRLQtfulWB8
         0Qioi6gZ3kvWAeaL0FNReXFw/HW/wvp0MwtLUBII2WJjsh8rY5TNt8fNFjOs0aq3MI
         0UxibB0ICVvBwJ/7BectuM/tEst+ZcWpl1B+4YwfWzqudzJlNc95zd79e11oyQaPZJ
         bGyu4gtjbxf8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6.1] wifi: ath11k: mac: fix reading 16 bytes from a region of size 0 warning
References: <20221010160638.20152-1-kvalo@kernel.org>
Date:   Tue, 11 Oct 2022 11:15:36 +0300
In-Reply-To: <20221010160638.20152-1-kvalo@kernel.org> (Kalle Valo's message
        of "Mon, 10 Oct 2022 19:06:38 +0300")
Message-ID: <87pmeyojx3.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Linaro reported stringop-overread warnings in ath11k (this is one of many):
>
> drivers/net/wireless/ath/ath11k/mac.c:2238:29: error: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Werror=stringop-overread]
>
> My further investigation showed that these warnings happen on GCC 11.3 but not
> with GCC 12.2, and with only the kernel config Linaro provided:
>
> https://builds.tuxbuild.com/2F4W7nZHNx3T88RB0gaCZ9hBX6c/config
>
> I saw the same warnings both with arm64 and x86_64 builds but couldn't figure
> out what exactly triggers the warnings, or why I didn't see them earlier.
> Nobody else has reported this either. This is also why I can't provide a Fixes
> tag as I don't know what's causing this. The function hasn't been touched for
> a year.

Thanks to Arnd I found out that KASAN caused this so I'll update the
commit log in this regard.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
