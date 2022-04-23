Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5E50C8AB
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiDWJfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiDWJfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 05:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E4236691
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 02:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A19660E8B
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 09:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E783C385A5;
        Sat, 23 Apr 2022 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650706369;
        bh=1FuOPeHbpWF7zNpeKdchowX9Wu6JvviN/jEYZyp4DMg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AoQ/yqw8jI+e0Uofm9YW/xPSwbxrJsbq6SEMuQEaGbywDfNfPPfRVDq2mt1ApIhfJ
         LT/559RJ6SrnlNkPzbkU+suPT+GrLvMA5+Oe4oXK9GpPPGb2mjMoybYbazI1SKwbhT
         bgQ7ce7kMy2XSF2cBvH+JcVML4BcYaa7M/DlICJ/7d3z0/bfUJ39oIdc5XTPGVDdC0
         h0X1LW3Qbom6v17UdCbbQLPvMNb8/058CfxBCDndjOovI03Fa3KNa1DyQIqScrrnW5
         n5V+9e9EJ5EIzr63ZuC/HjSWWhk5Jkwe7CiUaHw2yvaiA6IYLmIsjbUY2NuuvLPmJI
         5tO/qS5Q9tFrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: fix QCA9561 PA bias level
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220417145145.1847-1-hacks+kernel@slashdirt.org>
References: <20220417145145.1847-1-hacks+kernel@slashdirt.org>
To:     =?utf-8?q?Thibaut_VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        =?utf-8?q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>,
        =?utf-8?q?Thibaut_VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165070636562.13738.512642859585994950.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 09:32:47 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thibaut VARÈNE <hacks+kernel@slashdirt.org> wrote:

> This patch fixes an invalid TX PA DC bias level on QCA9561, which
> results in a very low output power and very low throughput as devices
> are further away from the AP (compared to other 2.4GHz APs).
> 
> This patch was suggested by Felix Fietkau, who noted[1]:
> "The value written to that register is wrong, because while the mask
> definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the
> shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is
> wrong for 9561."
> 
> In real life testing, without this patch the 2.4GHz throughput on
> Yuncore XD3200 is around 10Mbps sitting next to the AP, and closer to
> practical maximum with the patch applied.
> 
> [1] https://lore.kernel.org/all/91c58969-c60e-2f41-00ac-737786d435ae@nbd.name
> 
> Signed-off-by: Thibaut VARÈNE <hacks+kernel@slashdirt.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e999a5da28a0 ath9k: fix QCA9561 PA bias level

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220417145145.1847-1-hacks+kernel@slashdirt.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

