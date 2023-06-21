Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9873813F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFUJmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFUJmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D331FF2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1404614D6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FDAC433C8;
        Wed, 21 Jun 2023 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687340531;
        bh=8+trVGJ54v2ZaztaEFTK/xsahHxjUByviYzrQhq5p7U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=p9a6W2GZTmhR3SZomzEfghvCQxO98tAQ584Svd7wmEG1Ct4RMna889s0EYhgbj+v5
         wZDi/OcHbL+ZyGrN88ARFE8gFmfnsOtsuQT3L2LWObhDFUlwYVjZ6qHt5IZobSeHvw
         jv76V9BKx+TCbpB1X4HqEvAudtd4E5t4pZmEGQKdPu8RRrTsoLxgZGt5kWwaSZbzwj
         SYRmvrCwjf8Q2woTbYiug7OP26zfoH0xUmBa4PckND+99MRK80AOzjVZcwvP67bt4b
         neGteWjL6WEqr89cxznLQT0HR6W9mFJdAxWgzz4+fK/ylElsMrOkTrYL78hBsD3UJR
         nHm03XBvY3aOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw88: use struct instead of macros to set
 TX
 desc
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616125540.36877-2-pkshih@realtek.com>
References: <20230616125540.36877-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734052871.380100.18093697722965903577.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:42:10 +0000 (UTC)
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

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Remove macros that set TX descriptors. Use struct and
> le32_encode_bits() with mask definitions.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

88b9d8e6cf9c wifi: rtw88: use struct instead of macros to set TX desc
076f786a0ae1 wifi: rtw88: Fix AP mode incorrect DTIM behavior
9e09fbc5e902 wifi: rtw88: Skip high queue in hci_flush
ad6741b1e044 wifi: rtw88: Stop high queue during scan
455afa45edb3 wifi: rtw88: refine register based H2C command
28c11c29494f wifi: rtw88: fix not entering PS mode after AP stops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616125540.36877-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

