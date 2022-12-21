Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E86536A8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiLUSwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 13:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiLUSwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 13:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98912D4
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3321E618EF
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 18:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CE6C433F0;
        Wed, 21 Dec 2022 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648718;
        bh=KVa/AvlxRDVGEqClLcCqRj4GriYElnaUainJpFpPUa8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MdGhzGIEUwwRXj6ZpWpJGyH6wymDM+n6Ne/tVQRvdrDCtmFZ7T34h6TwDrQOo+FEZ
         +Ts0zp829LM0AjWmpJZ0IV1aK0GV6zqf9Nkk8pBSEMB9xYiim4hyrQDxOgLIpfej61
         xirv8z2Jvzv6zjMar6K4HAeGfTJPbyFjGUkLbhO00qYsGh+ZiUQBqTaUN+8vbgHGZw
         KT9UpRCA1uMg1qCyejs70/2pAqs5kFfsyQwL9RQjk2/yKhn2MKVj+trXDXulyjF6FI
         Mw2ndbL0ZIgy4wOh45eBcNEOr5+/Vqkq5FRJO/O7Cv+zO06rb6vFIfKooJgqmuDmaY
         l/yO0///ZWAMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167164871560.5196.478659665415497087.kvalo@kernel.org>
Date:   Wed, 21 Dec 2022 18:51:57 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Every chip family except RTL8723AU has a copy of the efuse dumping
> code. Remove this and dump the efuse from a single place using a new
> function rtl8xxxu_dump_efuse().
> 
> Also, use print_hex_dump() to print the efuse instead of a loop and
> dev_info(). It shows the ASCII interpretation of the bytes, which is
> nice.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

4f198e720eab wifi: rtl8xxxu: Deduplicate the efuse dumping code
d7a3705c9634 wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take const char*
b75289e89459 wifi: rtl8xxxu: Define masks for cck_agc_rpt bits
3dfb8e844fa3 wifi: rtl8xxxu: Support new chip RTL8188EU
8b9754b28f0f wifi: rtl8xxxu: Add rate control code for RTL8188EU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

