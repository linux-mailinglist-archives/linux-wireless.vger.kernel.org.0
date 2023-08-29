Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3478BE88
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjH2Gf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjH2GfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 02:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A1185
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 23:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A2F63DD8
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 06:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA1C433C8;
        Tue, 29 Aug 2023 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693290919;
        bh=h15yCxDP+AAVrnEMRaUoiOk0FC3Rz5ZP/Z8yABXlJPI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bJAIBH64mj/nBe/HjNBr71EtO5QfyspviHg+ZHTaBzYZvVQGOURh7AeEVB/7KUV28
         vge5oQ6wdS8aB4IZlZxtog23+q0xiMQXbaw7aEMofZfK4nByJpCmwGqDRIKr1ShXze
         voxKHuYLaxfWe7soye6DcWaciQk1q6RzQ2KYK1kZ6idgD4amGQaMe3NflTdzwKeuc4
         7+MzL0pvlh5pxlFhlwrIe56oiNIBE/M+oirBKPs++TYuZqlhOO1lcQDElAJO+lmumq
         Ow7m5HaVeXrnyriwwSuryDmFwyXZehHo8t8YlJSdsx3PfsFwUlxqqZMJ1aXezeczIH
         Umv+HHf9IvdmA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 5/6] wifi: mac80211: export ieee80211_tpt_led_trig_tx/rx
 for driver
References: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
        <8d18b7ac7fc394c310c0f2730da9ee7e955a9860.1692983967.git.yi-chia.hsieh@mediatek.com>
Date:   Tue, 29 Aug 2023 09:36:28 +0300
In-Reply-To: <8d18b7ac7fc394c310c0f2730da9ee7e955a9860.1692983967.git.yi-chia.hsieh@mediatek.com>
        (Yi-Chia Hsieh's message of "Fri, 25 Aug 2023 10:47:08 -0700")
Message-ID: <87il8ytkwj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com> writes:

> Whenever the H/W path is enabled and traffic is in the binding state,
> mac80211 is not aware of the traffic. Consequently, the LED does not
> blink for that reason.
>
> The ieee80211_tpt_led_trig_tx/rx functions are exported for the driver
> so that we can report the tx and rx bytes from the driver when
> the H/W path is being used.
>
> Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
> ---
>  include/net/mac80211.h | 17 +++++++++++++++++
>  net/mac80211/led.c     | 18 ++++++++++++++++++
>  net/mac80211/led.h     | 18 ------------------
>  net/mac80211/rx.c      |  2 +-
>  net/mac80211/tx.c      |  4 ++--
>  5 files changed, 38 insertions(+), 21 deletions(-)

The mac80211 patch should be first in the patchset to get more
visibility.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
