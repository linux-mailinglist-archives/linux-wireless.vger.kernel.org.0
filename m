Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE0774BE3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 23:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjHHVAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjHHU7p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 16:59:45 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1B5998
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 13:56:09 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C81232C0066
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 20:56:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0432113C2B0;
        Tue,  8 Aug 2023 13:56:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0432113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1691528167;
        bh=WQS3XMgx9IQH4AZ7uLk86SAFI6Hjk/XmUGBubdR1uI4=;
        h=From:To:Cc:Subject:Date:From;
        b=ExUre5cznMYLvuMkQGL97bKUVWXjA/mtSNvGnmvdx9eP9pyECClg1md8TtASVn+1n
         klIzj14Ir31MS1S4is0vxYfxicwcPXd3pno3SGpeGak8c12C4TVfmHtyGabUXhhRTh
         ZPuJmKyqZslj1WqjY33eGiAojuqY4JX0MaVJv6TQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Ensure ack flag is properly cleared.
Date:   Tue,  8 Aug 2023 13:56:05 -0700
Message-Id: <20230808205605.4105670-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1691528168-phBUsIozTUVV
X-MDID-O: us5;at1;1691528168;phBUsIozTUVV;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Debugging indicates that nothing else is clearing the info->flags,
so some frames were flagged as ACKed when they should not be.
Explicitly clear the ack flag to ensure this does not happen.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0abc31a6951d..67f208cc19c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1863,6 +1863,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
 
 		memset(&info->status, 0, sizeof(info->status));
+		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2241,6 +2242,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		 */
 		if (!is_flush)
 			info->flags |= IEEE80211_TX_STAT_ACK;
+		else
+			info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
 
 	/*
-- 
2.40.0

