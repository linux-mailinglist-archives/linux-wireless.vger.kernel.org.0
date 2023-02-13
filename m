Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A5694D9A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBMREs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBMREr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:04:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09A1E9F0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037BC611E3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A3C433D2;
        Mon, 13 Feb 2023 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307885;
        bh=UMDeJgWq7vVYaHwn3rQjSqopk8a1eqY/sci7F6SNnr0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sGtIHePZ4mfBnSTtHHr1sLIF71yqop9q+lZ2x+HIiBvqaP4WVhKbvt4WMulELB1QE
         7PWU2I8fNQ7Pcat8nsh7ni1Tn6ltcwxD1YH0y2CAqMOE1H6dEC67XwjgCOBiqHr7SS
         ik18MdddiLg1wwQDYsVu4P7XBK3seyszbXoGJKhZSmHBmLdDBLbi8pUG/kjaT2qbJn
         fxKhSrPlrPRZqGuzJQvSdb5LD25q06iVFRbt+p0UfKi58GveEhdfUgrMAKwMizqGBz
         1J04a3CDpFbhiqESCGkqoA3tB31MdKuXMXLpLTxiRhUfNUnesWLo4R8OB7piKRbWmM
         p5MBxo3LeJgRw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: coex: Update Wi-Fi external control TDMA
 parameters/tables
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230117114109.4298-2-pkshih@realtek.com>
References: <20230117114109.4298-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630788127.12830.11729289792363178534.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:04:44 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> This patch update the external control (Wi-Fi firmware control) type of
> TDMA related parameters, almost all of these case were related to Wi-Fi
> multi-role situations & AP mode.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

1742fbae7a49 wifi: rtw89: coex: Update Wi-Fi external control TDMA parameters/tables
aae256c0f233 wifi: rtw89: coex: Clear Bluetooth HW PTA counter when radio state change
3f857b23dd8d wifi: rtw89: coex: Force to update TDMA parameter when radio state change
7cd8200555d4 wifi: rtw89: coex: Refine coexistence log
6d2a479c1f9e wifi: rtw89: coex: Set Bluetooth background scan PTA request priority
c7d2b22f52bd wifi: rtw89: coex: Correct A2DP exist variable source
4b3e7e813bba wifi: rtw89: coex: Fix test fail when coexist with raspberryPI A2DP idle
de06588cb95c wifi: rtw89: coex: Update Wi-Fi Bluetooth coexistence version to 7.0.0

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230117114109.4298-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

