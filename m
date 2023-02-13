Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656F3694DD2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBMRT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMRT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:19:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D102F1CAC3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:19:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85095B810D6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91402C433EF;
        Mon, 13 Feb 2023 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308765;
        bh=IXaD0st4a6UF9AVY/RsEuGD9rK7KJz9UgrR8NZ2jQnE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l+GNlWeSe4vRVwu2sCOrC5CRYHZuLGheh0NMji6HDuo92idDwy2jDxwrRZ79FDlSI
         zy+HlrvxGxVDz0PXeOrpIoeubgnYUahTmvkKaXbzmCuEQTqH9UUcblgPwLdZTfNLVH
         y7n1Vy8OJRh6gocB/VV89Yuv9PA8YdVCa97d3Z4G6qHGZWkd8RA1jRlC1R009vcNua
         5IUfEvpCrQWreBjBBc4aTyDjqVXjE/vt8QdqCQUF8JdRrqPFX6LJKzNOlP8gtg5nNC
         nyF22TvEwQTeNXUpmLcHKXZlSka1Swn7F3nzWB+1hdmBLNJpjfY/j3Np3QHtO2DzW2
         DppVotaAMcOXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: phy: set TX power according to RF path
 number by
 chip
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230203065157.8227-1-pkshih@realtek.com>
References: <20230203065157.8227-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630876282.12830.15391868631033088936.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:19:24 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Previously, all supported chips had two RF paths. Therefore, these
> codes used static number for TX power setting. Now, we are planning
> to support a new chip which has only one RF path. So, we refine the
> setting codes to refer to chip's RF path number at runtime.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

ddf9a2ead167 wifi: rtw89: phy: set TX power according to RF path number by chip

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230203065157.8227-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

