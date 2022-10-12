Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39F5FBFEA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 06:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJLEen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 00:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJLEem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 00:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF826D1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 21:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD136135B
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 04:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32ABC433C1;
        Wed, 12 Oct 2022 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665549278;
        bh=QOagMnpXxWkRX00nTo3shZ9+vaOWLwknJV/JGNRz7bw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZT3P8+ui6RI1i4S6fezUJ7ekw6ajT6X2msUgTDyfPVeUhaBaoylOVtAAPdT9dcuGf
         dsINcxR2rxzgQE1OpDwDtpOSCsT6MDlvptvkfT2a8PZJ63FQxUqDfmpqDKx5+4UA9K
         sezcnLnkK5Gg7doDhZjYF+khtp85DGkz/DUKUBAvNn1P7lI8P0R6/gSQYLOR0AVu7R
         28P2g57Nd/NMN9IN7GxufgXzIxoIJckO9QPTSI+Vx+C0obIM8bLsRcxIseUYqLzyBx
         NEAdTTFYmpg0YQBWP4FmQWIi8nd8s2Xo1aXccNMqezHtK/tJN9nzGmPIZEVzyKZUHx
         yv8bcEtdG0hQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtl8xxxu: Make some arrays const
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
References: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166554925932.12621.14700322492795487094.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 04:34:37 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> All the initialisation tables, plus rtl8xxxu_rfregs.
> 
> Most of them were already static.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

3 patches applied to wireless-next.git, thanks.

79cac25e51a6 wifi: rtl8xxxu: Make some arrays const
6f103aeb5e98 wifi: rtl8xxxu: Fix reading the vendor of combo chips
6e5971503e7d wifi: rtl8xxxu: Update module description

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

