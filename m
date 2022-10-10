Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04465FA193
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJJQG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJJQGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 12:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED25474B9B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF0760FA2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F778C433D6;
        Mon, 10 Oct 2022 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665418003;
        bh=sbvF2C30pyi/WD894jgQd/CyRHVu2fPpNAY/vCIpK48=;
        h=From:To:Cc:Subject:Date:From;
        b=P6EBdnTGtpl1YROEAzxB1EWWF0YWNUyAtdwqcRZohRumUyb1fcJh0BPrVSimtFhLB
         44xHJMov7z8BBmAm877xOTkeFEolUXeskcH6LHyu7yJ0DTfu0u5FL5IiPD0keaZyCB
         DM2P+NLvrMr0jCVZInfTOcmLLyuXHL+Jt3NPegmUZSH4t8WznMGGqEQk4/6m3ecKRk
         ySAYZBCHnQaqDg+FmBOqyiY67TE2rHQPyISqyDM2u9kvnM8Ehp5THRbYkKznd0GOjq
         15ge2mfHBjcc5K6/pp/SkQFCRBNrh8Rg8XH05tTfWhGmMrpwSeWCh30hmw3eJPV+vm
         FY0fKqX8rfhxA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v6.1] wifi: ath11k: mac: fix reading 16 bytes from a region of size 0 warning
Date:   Mon, 10 Oct 2022 19:06:38 +0300
Message-Id: <20221010160638.20152-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Linaro reported stringop-overread warnings in ath11k (this is one of many):

drivers/net/wireless/ath/ath11k/mac.c:2238:29: error: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Werror=stringop-overread]

My further investigation showed that these warnings happen on GCC 11.3 but not
with GCC 12.2, and with only the kernel config Linaro provided:

https://builds.tuxbuild.com/2F4W7nZHNx3T88RB0gaCZ9hBX6c/config

I saw the same warnings both with arm64 and x86_64 builds but couldn't figure
out what exactly triggers the warnings, or why I didn't see them earlier.
Nobody else has reported this either. This is also why I can't provide a Fixes
tag as I don't know what's causing this. The function hasn't been touched for
a year.

I decided to fix this by converting the pointer to a new array in stack, and
then copying the data to the new array. It's only 16 bytes anyway and this is
executed during association, so not in a hotpath.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/all/CA+G9fYsZ_qypa=jHY_dJ=tqX4515+qrV9n2SWXVDHve826nF7Q@mail.gmail.com/
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 84d956ad4093..2d1e3fd9b526 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2081,7 +2081,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	struct cfg80211_chan_def def;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
 	enum nl80211_band band;
-	u16 *he_mcs_mask;
+	u16 he_mcs_mask[NL80211_HE_NSS_MAX];
 	u8 max_nss, he_mcs;
 	u16 he_tx_mcs = 0, v = 0;
 	int i, he_nss, nss_idx;
@@ -2098,7 +2098,8 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		return;
 
 	band = def.chan->band;
-	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
+	memcpy(he_mcs_mask, arvif->bitrate_mask.control[band].he_mcs,
+	       sizeof(he_mcs_mask));
 
 	if (ath11k_peer_assoc_h_he_masked(he_mcs_mask))
 		return;

base-commit: 10d5ea5a436da8d60cdb5845f454d595accdbce0
-- 
2.30.2

