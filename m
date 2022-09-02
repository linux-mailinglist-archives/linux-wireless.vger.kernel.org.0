Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810335AAA2D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiIBIg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiIBIgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8162F6
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D65362091
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86DAC433D7;
        Fri,  2 Sep 2022 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107681;
        bh=xYW9iXy2Z/cXP5LC8Enc+knJDZRmY7Mrh2oSzgK1qHo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=R3AtJ2q9mQ8SmYlY5maNmktjpRpwVQEQmcpsmxJezMMApgfaCsBN0CCC+nDqZGReZ
         RQBqVaQyVbYFYeLhS5BrJQKS/CthRiAHRihsb7AJEhzhMl7E3AtRGm7nLJL1jce9tl
         AMtoUDGuFu47w1YbRSCPuLJ+mMSjGlTlGa5EfdCYqrT+80zKdXuKIaKSY/zb8CtuH7
         LmXjGmwtxm2ZkrWDVIcHNbICP6J+bBwN/MCm7lVC+zBIKc5QyrkLz0tNU82faV+zje
         cmKkAqPqB1i+H1j1o7k0ho4RAdPjK3fiyxxj0KF79C4dOQ7J4rVV01ioBBr1BIMJOE
         FDpkcjBnorf/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: TX power limit/limit_ru consider
 negative
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220812093116.56791-2-pkshih@realtek.com>
References: <20220812093116.56791-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210767561.24345.5041499206777393056.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:34:40 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Some chips' RF TX power limit/limit_ru tables start to configure some
> negative values. Fix the setting logic to prevent negative values from
> polluting fields of others.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

7f700c2566b8 wifi: rtw89: TX power limit/limit_ru consider negative
39ac0c27d0c8 wifi: rtw89: 8852c: update RF radio A/B parameters to R49
07732caa5174 wifi: rtw89: 8852c: update TX power tables to R49

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220812093116.56791-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

