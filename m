Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4915AAA2B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiIBIfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiIBIen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:34:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89060C0E66
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B74DB82A00
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1DAC433D7;
        Fri,  2 Sep 2022 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107620;
        bh=CblSeT7UnX0Ze1+lpjaLynbxY03m2gQ20j4pnJxseLo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NfjTqZ6saHhcpl+m1NGwrTA7OrmP30b0YsOixH1XO+qOETlJwEijnujW7fFEiQJzP
         J7iJM8r7rHJPW02iaJir6obkJ5jgZ4x4sTZyroy9WXL7ul83j1AtrzFQiAL8UI0j4M
         j9lWDo/z1bJ5fHjVTWshU+qQJfUgoojQGswFpkOiN7RCq9G09O9sE4jF3ha0Eu94M5
         eCyWuWe4AKIYNQ4fhcSD/GeQPNZNii3tMWAVsuqaGJzg8FrxVDP2fDM2dFFffvButi
         7VUQ2EhJYIxm1jlX7Jt4+QutUV2tJWpGSJ+KAhz3BD3ra5s374wxRqG8zimg5k7CVk
         pQOUx48pg2Zvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] rtw89: coex: update radio state for
 RTL8852A/RTL8852C
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220725023509.43114-2-pkshih@realtek.com>
References: <20220725023509.43114-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210761827.24345.2068881385459784249.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:33:39 +0000 (UTC)
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

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Update scoreboard setting to let Bluetooth know Wi-Fi power save state.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

38ede035a21b rtw89: coex: update radio state for RTL8852A/RTL8852C
ba787c07ca1b rtw89: coex: Move Wi-Fi firmware coexistence matching version to chip
1162584c799d rtw89: coex: Add logic to parsing rtl8852c firmware type ctrl report
3893959cd8c7 rtw89: coex: Define BT B1 slot length
ce986f3dc4fc rtw89: coex: Add v1 version TDMA format and parameters
e390cf2ebdee rtw89: coex: update WL role info v1 for RTL8852C branch using
a8a0b1f70780 rtw89: coex: Move _set_policy to chip_ops
747dc30e64cf rtw89: coex: Add v1 Wi-Fi SCC coexistence policy
3832a5424902 rtw89: coex: Update Wi-Fi driver/firmware TDMA cycle report for RTL8852c

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725023509.43114-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

