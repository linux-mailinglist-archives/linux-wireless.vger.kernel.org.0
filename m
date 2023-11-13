Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435E7EA26A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 18:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjKMRwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 12:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 12:52:09 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF7DB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 09:52:06 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E1853B80085
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 17:52:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4B9D013C2B0;
        Mon, 13 Nov 2023 09:52:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4B9D013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699897924;
        bh=JPhRpXOtupzTJVg1NvYKAx6FcbTZX31TqooC7Vrq+dk=;
        h=From:To:Cc:Subject:Date:From;
        b=fEGyL2t96zKK5UmgawIvjKyvt9iyxIituMid0QMuUHq8K7ER7mdmEd17i1gITav5w
         X7poQ4ATgfS603N3VHi/DQ6G6OKZT0a7Nc/7Zb2KNYzl6XXT7tYxNIxoJZz2gr+ymH
         505hIlXPjkwRM3bSHqyCYwRkNuBJn3M5Tvp2JTQ8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Provide extra info in link related WARN_ON
Date:   Mon, 13 Nov 2023 09:52:02 -0800
Message-ID: <20231113175202.1546994-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1699897925-V3QO20ovrfYJ
X-MDID-O: us5;ut7;1699897925;V3QO20ovrfYJ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Provide some extra debug information to better understand why the
warning happened.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index be48b0fc9cb6..a664b7112aee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -102,8 +102,11 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int ret;
 
 	if (WARN_ON_ONCE(!link_info ||
-			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)) {
+		IWL_ERR(mvm, "Invalid info in link-changed, link_info: %p NULL or LINK_ID_INVALID\n",
+			link_info);
 		return -EINVAL;
+	}
 
 	if (changes & LINK_CONTEXT_MODIFY_ACTIVE) {
 		/* When activating a link, phy context should be valid;
-- 
2.41.0

