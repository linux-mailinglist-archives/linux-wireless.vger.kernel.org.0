Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F85850FA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiG2Nfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiG2Nfk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 09:35:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BD23BF7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 06:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81337B827B0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889DBC433C1;
        Fri, 29 Jul 2022 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659101737;
        bh=4VmtS+urVzt9azewAYaBkna0C9WmkvfNig456bD7QI0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EJIaMaqeZ6n1ucr8uq+mdqD/0sZ/G1meRY3UxtkvZ5A1wnPvpAh9jVr+3RRtjWNEo
         I7DdYyNqEClQnP9ICBggayA/PtEezWej3iXFTZtG6r7ZeHLhuA1kdNRYInTKz8KVpb
         7ACgDqB+gjhwTcYHGIPkCimU275REjvwg0cRcAEmiaX03iOxqsvRNTwBem/kC9MglK
         qfsOy9r3OP2LhWlnS6Co/OIPlBAtQ7stxahB0HvTMTDVAcPZtgzs/ZT46NV1Tyy2E/
         ynu58efuftQtwvTm9p3TGE3E8KF+b7xjytZqXnMDLhfjJsk48b91YOYFIOb7axeovt
         0VaR36A1Cgx4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: 8852a: adjust IMR for SER L1
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220721074952.19676-1-pkshih@realtek.com>
References: <20220721074952.19676-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165910173447.2014.3382516106065906571.kvalo@kernel.org>
Date:   Fri, 29 Jul 2022 13:35:36 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> SER (system error recovery) L1 (level 1) has a step-by-step handshake
> process with FW. These handshakes still rely on B_AX_HS0ISR_IND_INT_EN.
> So, even already during recovery, we enable this bit in IMR.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

334facd651b9 wifi: rtw89: 8852a: adjust IMR for SER L1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220721074952.19676-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

