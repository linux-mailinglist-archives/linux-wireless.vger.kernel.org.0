Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AF4B08BB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiBJIpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:45:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiBJIpt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:45:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7B1C1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 00:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DC85B82299
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BF2C004E1;
        Thu, 10 Feb 2022 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644482748;
        bh=sqTzFwPW40tz407Zh7QqfKoCxcD+/ob1NFrfMbmc/R0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AcUq05iZZFob/UJy+ex3lHBp1M+m5/AqlEBPO0gFjmMUQSfZK1tFKX0lvBDY6nf7E
         cLcP+aqgXJvOD/qY+vw2n3yNGGvBaiphh/8AETkfrpVBArlPR9bEwDsH0q4+pgeqVb
         VgHYi5K+0y7H8z2YhHBYYgDyp9ilGkiUAEfZaJNSBkk174JaTUQpskifOvJzfR1e2R
         U2HscDBSswzclVufPUCAdRqX1t7hipqpJqZ+BgxOzUhLFLTjb/GhBvuogmPoj+pIm/
         KePkG0w3Dx5nAkB3VK82U/zUAxeHYOMG6rNr1NrH54lG/e8VH12pbOfW3EVDiyh81p
         lscy8mTD7C/Gw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: coex: set EN bit to PLT register
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220208082751.43553-1-pkshih@realtek.com>
References: <20220208082751.43553-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164448274604.15541.5092164737894045117.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 08:45:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> B_AX_PLT_EN is to enable polluted mechanism. If it is enabled and
> gnt_bt = 1 while wlan TX, B_AX_BT_PLT_PKT_CNT counter will increase,
> but TX counter to BB will not. Without this bit BTCoex mechanism might
> have some problems.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

28e7ea8a3128 rtw89: coex: set EN bit to PLT register

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220208082751.43553-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

