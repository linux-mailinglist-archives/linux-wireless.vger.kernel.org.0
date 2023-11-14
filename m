Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF967EB889
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 22:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjKNVX0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 16:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVX0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 16:23:26 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EAB9D
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 13:23:22 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0C387C006C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 21:23:19 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 85DED13C2B0;
        Tue, 14 Nov 2023 13:23:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 85DED13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699996996;
        bh=mYm/aqdpHTXv+pXm7BduLACK4YTqUuJE2+UnYAsTyWE=;
        h=From:To:Cc:Subject:Date:From;
        b=eDRfAO1suH/Ohf73yuqyYX9qHAaYadea2b9rrAbRPkDE/yzfqGmyoC+RnNv3A2z9V
         AnUFD8erlVyNhY30H9lC120G5S2PiZVhV5uQuoVwf2QMSkRira3MWakyu1U7hChj4u
         u1Wd8rdm6EWL/ZZQ0as0maSNe4lJxcIqhteo2mg0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Add debugging around scan failure warning.
Date:   Tue, 14 Nov 2023 13:23:09 -0800
Message-ID: <20231114212309.2180281-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1699997000-6Ac7Y6sgxHi7
X-MDID-O: us5;ut7;1699997000;6Ac7Y6sgxHi7;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Provide additional information that may help debugging why
the WARN_ON is seen.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 75c5c58e14a5..ec24ece7c877 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2356,7 +2356,10 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
 			link_id = ffs(vif->active_links) - 1;
 
 		link_info = scan_vif->link[link_id];
-		if (!WARN_ON(!link_info))
+		if (WARN_ON(!link_info))
+			IWL_ERR(mvm, "scan failure: Cannot find link info for link-id: %d active-links: 0x%x\n",
+				link_id, vif->active_links);
+		else
 			gp->scan_start_mac_or_link_id = link_info->fw_link_id;
 	}
 }
-- 
2.41.0

