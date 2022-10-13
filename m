Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD25FD4CC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJMG24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJMG2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:28:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49A264BD
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BA9B81BCE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 06:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29B6C433B5;
        Thu, 13 Oct 2022 06:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665642530;
        bh=NmKHRHCSfjWM56bbjqQSj4SzOeQxq43+XIKSGWzWpik=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SxNZAyuGbeEpVQ7zqmMZzZ/P0RFZVqoUZKwFDU3ha2m1wX7HKp9Q2qzTHP9EsCzZ/
         Jx0VErrRRRmYtENR3Pe3WH75tpXjzv/ZTOXpz3xjB4fIeYZ+9adx6mYf3NkVE2XTVM
         Ob/HdmG+mltwjS/G9Q0OrfoG211WleVNYBpk2qIIRaFVM7iNlPomcGuwkJc3QFKEyn
         aRm7C1qQLMlD3Cnv/1EqZsAy1sJmFrV+Kodf/KXesknBJZODcwvNIo5FQoR4qEiZIj
         EXMmq0lQa2nUhjIv0WlQSN9oP20Gp86lcrP2aDUtos1+loyYzI7xVbdblT3yAZJUBs
         tYq3EBTiL+MvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath11k: modify accessor macros to match index
 size
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1665599807-12908-2-git-send-email-quic_msinada@quicinc.com>
References: <1665599807-12908-2-git-send-email-quic_msinada@quicinc.com>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166564252533.7747.3943450152611127759.kvalo@kernel.org>
Date:   Thu, 13 Oct 2022 06:28:49 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> wrote:

> HE PHY is only 11 bytes, therefore it should be using byte indexes
> instead of dword. Change corresponding macros to reflect this.
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

Fails to build. How did you test this if it doesn't even build? ALL
patches submitted to upstream need to be properly tested before
submission.

drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_set_he_txbf_conf':
drivers/net/wireless/ath/ath11k/mac.c:2711:33: error: 'struct ieee80211_bss_conf' has no member named 'he_su_beamformer'
 2711 |         if (arvif->vif->bss_conf.he_su_beamformer) {
      |                                 ^
drivers/net/wireless/ath/ath11k/mac.c:2713:41: error: 'struct ieee80211_bss_conf' has no member named 'he_mu_beamformer'
 2713 |                 if (arvif->vif->bss_conf.he_mu_beamformer &&
      |                                         ^
drivers/net/wireless/ath/ath11k/mac.c:2722:41: error: 'struct ieee80211_bss_conf' has no member named 'he_full_ul_mumimo'
 2722 |                 if (arvif->vif->bss_conf.he_full_ul_mumimo)
      |                                         ^
drivers/net/wireless/ath/ath11k/mac.c:2725:41: error: 'struct ieee80211_bss_conf' has no member named 'he_su_beamformee'
 2725 |                 if (arvif->vif->bss_conf.he_su_beamformee)
      |                                         ^
make[5]: *** [scripts/Makefile.build:249: drivers/net/wireless/ath/ath11k/mac.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:465: drivers/net/wireless/ath/ath11k] Error 2
make[3]: *** [scripts/Makefile.build:465: drivers/net/wireless/ath] Error 2
make[2]: *** [scripts/Makefile.build:465: drivers/net/wireless] Error 2
make[1]: *** [scripts/Makefile.build:465: drivers/net] Error 2
make: *** [Makefile:1853: drivers] Error 2

4 patches set to Changes Requested.

13005351 [1/4] wifi: ath11k: modify accessor macros to match index size
13005352 [2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
13005353 [3/4] wifi: ath11k: move HE MCS mapper to a separate function
13005354 [4/4] wifi: ath11k: generate rx and tx mcs maps for supported HE mcs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1665599807-12908-2-git-send-email-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

