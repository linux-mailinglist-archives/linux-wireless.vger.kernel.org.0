Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D065B59AE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiILLxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiILLxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36E3C8E9
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C6E8611CA
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56121C433D7;
        Mon, 12 Sep 2022 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983581;
        bh=YZ+vO/xAlBbIoyRTLKWzv76X9j7JAqAbR1D+9kVlPRU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EUnBTDrNPRwdQTlfNcHceg7bsQVHdNHBg2L2hM9enPzrgrC7H3OK356aXry3NdZNX
         ILmkaVpAKzrxVmYwf1lO/3yl5hrBSGJ9Xml8nAlqE3CnLON2IrpGWEMtvQXQ7PRYKe
         GIRwBPqOoYmmjtqo8L/9d++vg1acTDE6ByYxfGZzLa/lo0r+ceDSkSWyuo6rY30kJ5
         K4Hni/3d9U2FXr0x54GpBCM0t+SrlvKm2omLgTMxSZpMZnDU8zxVgH87mIWog1iboo
         C5TIoFJIoMO3WdukbLrYEy+T/FVZoE2BeFTFgkBdk1aUsjwDGvbxFa8oA/zq7dvQTF
         TDi94z0wweJtQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wifi: rtw89: add DIG register struct to share common
 algorithm
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220908051257.25353-2-pkshih@realtek.com>
References: <20220908051257.25353-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298357861.4036.2323245967742460761.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:53:00 +0000 (UTC)
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

> From: Eric Huang <echuang@realtek.com>
> 
> Since control register address for DIG are different per IC, add a new
> struct rtw89_dig_regs in chip info for each IC to define their own address.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

87deaad9c9e9 wifi: rtw89: add DIG register struct to share common algorithm
ef16380b69b8 wifi: rtw89: 8852c: enable the interference cancellation of MU-MIMO on 6GHz
2449ca713e67 wifi: rtw89: 8852c: enlarge polling timeout of RX DCK
755fda37b9d7 wifi: rtw89: 8852c: set TX to single path TX on path B in 6GHz band
9ef9edb9e830 wifi: rtw89: set response rate selection
183c8eff5a67 wifi: rtw89: support deep ps mode for rtw8852c
5abbb68acad1 wifi: rtw89: call tx_wake notify for 8852c in deep ps mode
3a1e7cb16d83 wifi: rtw89: 8852c: support hw_scan
bd1056d48a2b wifi: rtw89: split scan including lots of channels

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220908051257.25353-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

