Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD6653699
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiLUSuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 13:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiLUSug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 13:50:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1027142
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:50:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78E21B81BFC
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 18:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72810C433EF;
        Wed, 21 Dec 2022 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648627;
        bh=pRhRcFd5TtgeRUwup6hWgItv8NfBzVkIMuP4K6zXf18=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NvwjnM5mmaycqmWqhy5MnYBSG/hqmSWMKAUmg3txQL21vIABljI/REgk3LgK4BK7j
         7iXdXCdEaTOWadFq4lhV5xEbiwG04yQotOPxzhCAzR9QH6EFMSaMw2mhZMcn/6yAe0
         32ri5oN4woCVjOzUsm9bi+v2D+yOqWhnQvO3JSJ6GFcW+EgrAvGSgbaNDNBsfUpBUN
         QmOICQZ2Pa1ke2x+D4ktb9A4Gg56jl/pD3rQ4CWaD3WIzMoD13mV7eCQFBPtTK1Ni0
         ErjkHZElCC8Oet2HTMcjPpoulmZPUkG/i7RmAD6Tfk0dfmuieKxqoKpiX3xu247EP9
         kIeseg0LemWhg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: 8852b: update BSS color mapping register
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221214091803.41293-1-pkshih@realtek.com>
References: <20221214091803.41293-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167164862459.5196.4113826347767869753.kvalo@kernel.org>
Date:   Wed, 21 Dec 2022 18:50:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> BSS color mapping register is different per IC, therefore, move this
> register to chip_info and update the setting function. Without this patch,
> wrong BSS color causes behavior abnormal, especially DL-OFDMA.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

a48f4fd05d5e wifi: rtw89: 8852b: update BSS color mapping register

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221214091803.41293-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

