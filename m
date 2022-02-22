Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76714BFC97
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiBVPaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 10:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBVPaO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 10:30:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096615F36A
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 07:29:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD7761646
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 15:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42912C340E8;
        Tue, 22 Feb 2022 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543788;
        bh=3yD/xAvzXJ35lf8RF1aIfkcQJ2eDFqA+LpQ1Wiq2cT0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LMWS9S0OlCM8kLjhO/zLzKKKADPheLbSBSkg6jHTBMgzD9jOr8z+VQK2Wf63BlJn1
         jpxLKtPN3irAPuiVybNQyCQ32a8v77s9xCbMNhAcEShY9YpCqD9SYTg4uHd1pA3yLy
         sIxpXt1ExvRYm3FQqAoRz650MCMFli2WE8h4WBFfbH0qmpsr8CZhZQp5UELcjSvbEn
         zar4jErbJz+puqjFefDt2/sHCdYjgfTWDm939QtNgQ8bGhFFelImtSaC7LG9nDoq+k
         AEtcmcQnwKbU2VYy8O2H/bNBy9jT1u7xHEpTm9XVmyhmFRZO+n7tRlAlEUteLcHQEq
         lG5hSZhOu3YiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw89: phy: handle txpwr lmt/lmt_ru of 6G band
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220218034017.9160-2-pkshih@realtek.com>
References: <20220218034017.9160-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164554378475.840.16811308674827489154.kvalo@kernel.org>
Date:   Tue, 22 Feb 2022 15:29:47 +0000 (UTC)
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
> Add declarations of 6G stuff and extend rtw89_channel_to_idx() to
> map 6G's channels to 6G channel indexes. While 6G, correspondingly
> read 6G's entry for tx power limit and limit_ru.
> 
> After this, we should pay attention to chip_info::support_bands.
> If a chip declares 6G support, it must configure txpwr_lmt_6g and
> txpwr_lmt_ru_6g in case accessing NULL pointer while setting tx power
> limit/limit_ru on 6G band.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

ac74f016f035 rtw89: phy: handle txpwr lmt/lmt_ru of 6G band
94b70cafc661 rtw89: phy: handle txpwr lmt/lmt_ru of 160M bandwidth

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220218034017.9160-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

