Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FB552AE3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiFUGPb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 02:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFUGP3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 02:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBD1AD9E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 23:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3A761158
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D891C3411D;
        Tue, 21 Jun 2022 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655792128;
        bh=TY4Jqh7gvLhITIlP721u8SMul5QQ9BprZBkKrP2G+U8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gFVA5t04BWc2gh3hG6iBJedZaf/k5/OiyXdW/kHAN8s2vKmdMdViAQi6lme7e/KAV
         kak7/YWSMgVJDyJbthgFJrr2llOZrFyI2KSaHqbsVD2qFK7wjxRjVRQYFQkKY83teb
         XS7NyUvSe6QXat6LPFmm6x2anVkvoSF5/y2Nnow9OkjEpmp/8V3f9LlKeSuOqESXhB
         8Gf73NPRXOQTOU8MqK4+QeTd30Km3d2rTO5tYV51+FBkjLgUtv+fEoiTiPTqu8Arcd
         A3oVGgzKMKlMamYn7pWcPuSHY6yZWLMksa2HHx0TGgA/t8+PqKRJRksfyZndC1btHM
         Is4nPkyPWheSA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/5] wifi: rtw88: access chip_info by const pointer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220610065102.17580-2-pkshih@realtek.com>
References: <20220610065102.17580-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165579212499.12213.18092907064021474862.kvalo@kernel.org>
Date:   Tue, 21 Jun 2022 06:15:26 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Since chip_info has became const table, we must access them via const
> pointer to avoid invalid writing.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw88/main.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtw88: access chip_info by const pointer
Patch failed at 0001 wifi: rtw88: access chip_info by const pointer

5 patches set to Changes Requested.

12876532 [1/5] wifi: rtw88: access chip_info by const pointer
12876530 [2/5] wifi: rtw88: 8822c: extend supported probe request size
12876529 [3/5] wifi: rtw88: fix stopping queues in wrong timing when HW scan
12876531 [4/5] wifi: rtw88: fix store OP channel info timing when HW scan
12876527 [5/5] wifi: rtw88: phy: fix warning of possible buffer overflow

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220610065102.17580-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

