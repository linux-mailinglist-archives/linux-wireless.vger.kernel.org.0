Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A09592A98
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiHOHoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiHOHoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 03:44:21 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 00:44:20 PDT
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252CA19291
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 00:44:19 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 4484 invoked from network); 15 Aug 2022 09:37:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1660549057; bh=jhDqEhiGM+n8Cdl5DAdtoFPYD0xgBQR3XpaUP79LM9o=;
          h=From:To:Cc:Subject;
          b=GfkCMu+Y9FHE5xxLiIPovPxyjLJCOaByYtofnCLBvi1sGZJrjACPrKFdHUcCq9XRR
           8ZyTv4mAwKRHVu7UEmpOqB7axS599H7iGMoimnrH/ksVcesp14bf4GM/VHckE1/Jxe
           x9/c7zIT4d+zbWdGAAORvAZlzlDrqqh5wughbJwc=
Received: from 89-64-7-186.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.186])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <sashal@kernel.org>; 15 Aug 2022 09:37:37 +0200
Date:   Mon, 15 Aug 2022 09:37:37 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, aleksei.kodanev@bell-sw.com,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.0] wifi: iwlegacy: 4965: corrected fix for potential
 off-by-one overflow in il4965_rs_fill_link_cmd()
Message-ID: <20220815073737.GA999388@wp.pl>
References: <20220813203952.1914688-1-sashal@kernel.org>
 <20220814075703.GA847900@wp.pl>
 <YvkRBQYLQI2QrnBn@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvkRBQYLQI2QrnBn@sashalap>
X-WP-MailID: 064f9660f89dc8f74b4942be8fd80768
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IeMB]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


This reverts commit a8eb8e6f7159c7c20c0ddac428bde3d110890aa7 as
it can cause invalid link quality command sent to the firmware
and address the off-by-one issue by fixing condition of while loop.

Cc: stable@vger.kernel.org
Fixes: a8eb8e6f7159 ("wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()")
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index c62f299b9e0a..d8a5dbf89a02 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2403,7 +2403,7 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 		/* Repeat initial/next rate.
 		 * For legacy IL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0) {
+		while (repeat_rate > 0 && idx < (LINK_QUAL_MAX_RETRY_NUM - 1)) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
@@ -2422,8 +2422,6 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 			    cpu_to_le32(new_rate);
 			repeat_rate--;
 			idx++;
-			if (idx >= LINK_QUAL_MAX_RETRY_NUM)
-				goto out;
 		}
 
 		il4965_rs_get_tbl_info_from_mcs(new_rate, lq_sta->band,
@@ -2468,7 +2466,6 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 		repeat_rate--;
 	}
 
-out:
 	lq_cmd->agg_params.agg_frame_cnt_limit = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	lq_cmd->agg_params.agg_dis_start_th = LINK_QUAL_AGG_DISABLE_START_DEF;
 
-- 
2.25.4

