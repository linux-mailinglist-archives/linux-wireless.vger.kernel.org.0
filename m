Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065F4B5954
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 19:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiBNSGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 13:06:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiBNSGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 13:06:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB860D9A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 10:06:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87010B81252
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 18:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10392C340E9;
        Mon, 14 Feb 2022 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644862001;
        bh=MMUIJ7l9ej4RjpaXQXzWp38jKJCtzEWNwj6nD9O4uxE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sJ5TPv52r2NBSPYLN5Cawx5R7zzQ0swQzh/6iJK84zpfmTsWUGAIyYGbxA6BCDoiW
         MbUVPKmD6fnKIrXIskCbtvvXV38sZuo4cvaWhZN0zd31cG+kfc5oCG6IIMb2ZXvQoa
         xv8QxP9oVsHsAMnFa3B4879zRZZJivtYqXbJ+dN6kgQ9VigIbws4o2gcrHD8BZXALF
         Oo1gZ/kH5/vf9atBTnjzvRZar0FrnC0cnmoQXbSUOmbolyVwWI5ATl9dsv2e+4rGIs
         mptjgTSFw76/PM9L1QZXRM2NF1xGWK8dCrWrHXkzAobW/d2Z170TSKmHJ+rnhwLEtl
         vT5yVBR9+yvTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] rtw89: make rfk helpers common across chips
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220211075953.40421-2-pkshih@realtek.com>
References: <20220211075953.40421-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486199935.6494.14707384588723589394.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 18:06:40 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> These rfk helpers are also useful for the chip which is under planning.
> So, move them to common code to avoid duplicate stuff in the future.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

db7fa61ae443 rtw89: make rfk helpers common across chips
0701a42499d8 rtw89: refine naming of rfk helpers with prefix
8e438ad4826c rtw89: extend subband for 6G band
f76b327606c7 rtw89: add 6G support to rate adaptive mechanism
d221270af360 rtw89: declare if chip support 160M bandwidth
167044af3887 rtw89: handle TX/RX 160M bandwidth

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220211075953.40421-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

