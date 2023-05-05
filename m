Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E36F8269
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjEEMAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjEEMAn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 08:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530221884B
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 05:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDB063D8D
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 12:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6076AC433D2;
        Fri,  5 May 2023 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683288042;
        bh=rNeB+ns+pdIh2cLPTWaFcd/xbxv1L4AjNJL8XYuBti4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ljO2S/oNKJtZmN3zAaElMbG6PU32/s0sU6G567opc6zl5jXUi1dgF4Zo/BNeVPlbx
         BlAXHXo4TCyjKxZi7En6ALT0faFmDLYYBR3MhAJ8VDbEx2URDRhrIqliq7UqO7N0jU
         s1LKP7AV+6UcJBIcVarsu3YLcUjOsArXpGg8LkoUjTlLoSSMg7J4AlOXkdVMGwTcps
         8P8kWA9680p0PwxKecnS6WWZXRfHmyJH/kGZ4J1BB/v7dOYtFAMHyJx1yTLQ1qacXk
         oHOO+7m4IL2RDwcQwih15NiKytq1ctbbfrmE+ucWjDvKxuQCO0R+Pv1FJWK7gUPnMR
         1Rn+dT/mkBBSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: 8851b: add 8851B basic chip_info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230421024551.29994-2-pkshih@realtek.com>
References: <20230421024551.29994-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328803919.30117.8666430288453487819.kvalo@kernel.org>
Date:   Fri,  5 May 2023 12:00:41 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8851B is a 1x1 80 MHz bandwidth chip working on 2/5 GHz. Add these basic
> information, and more settings will be added by functions.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

c8d89bf6b82f wifi: rtw89: 8851b: add 8851B basic chip_info
99ff8da56322 wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
a24be8bbcbd2 wifi: rtw89: 8851b: add NCTL post table
0789881aa370 wifi: rtw89: add CFO XTAL registers field to support 8851B
ce816ab54bc9 wifi: rtw89: use chip_info::small_fifo_size to choose debug_mask
b6335d91607d wifi: rtw89: change naming of BA CAM from V1 to V0_EXT
2273dd724a6c wifi: rtw89: 8851b: add support WoWLAN to 8851B
85d1539c0273 wifi: rtw89: 8851b: add DLE mem and HFC quota

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230421024551.29994-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

