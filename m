Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7117B6EC8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjJCQnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjJCQni (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 12:43:38 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46869AD
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 09:43:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3D2C124006E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 16:43:33 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4942313C2B0;
        Tue,  3 Oct 2023 09:43:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4942313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696351410;
        bh=vuPA5a6wOTrUTTvTTy8RLTp91SZnRtyX/AcpY0CkBmE=;
        h=From:To:Cc:Subject:Date:From;
        b=WlsU7gK+cEpxThfFTeKfzYQHX7yc0G7iZUOWlrAWPHESj8yyLE3+2s3UFo0XUmmoE
         QAzopLQyO+qJP8VQR/x7hvtYzVCBkQhfRusp6MVGe6Sa/6at35ajkNh+AjLczV/OK5
         pmQukeLvfTrGzEwOPXrN1e0Nz5Hugrjd4dVZrDW4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  Allow STA to connect in AX mode to MLD AP.
Date:   Tue,  3 Oct 2023 09:43:26 -0700
Message-Id: <20231003164326.857433-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1696351413-X5T8D24_Ov8k
X-MDID-O: us5;ut7;1696351413;X5T8D24_Ov8k;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Check if user has configured STA to be AX mode, and if so,
skip the check for MLD elements (as they would not be needed
in AX mode).

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 51 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e7d42545851f..5fb0bdad88f4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5550,34 +5550,39 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (ieee80211_vif_is_mld(&sdata->vif)) {
-			if (!elems->ml_basic) {
-				sdata_info(sdata,
-					   "MLO association with %pM but no multi-link element in response!\n",
-					   assoc_data->ap_addr);
-				goto abandon_assoc;
-			}
-
-			if (le16_get_bits(elems->ml_basic->control,
-					  IEEE80211_ML_CONTROL_TYPE) !=
-					IEEE80211_ML_CONTROL_TYPE_BASIC) {
-				sdata_info(sdata,
-					   "bad multi-link element (control=0x%x)\n",
-					   le16_to_cpu(elems->ml_basic->control));
-				goto abandon_assoc;
-			} else {
-				struct ieee80211_mle_basic_common_info *common;
-
-				common = (void *)elems->ml_basic->variable;
+			struct ieee80211_link_data *link;
 
-				if (memcmp(assoc_data->ap_addr,
-					   common->mld_mac_addr, ETH_ALEN)) {
+			link = sdata_dereference(sdata->link[0], sdata);
+			if (!(link && (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))) {
+				if (!elems->ml_basic) {
 					sdata_info(sdata,
-						   "AP MLD MAC address mismatch: got %pM expected %pM\n",
-						   common->mld_mac_addr,
+						   "MLO association with %pM but no multi-link element in response!\n",
 						   assoc_data->ap_addr);
 					goto abandon_assoc;
 				}
-			}
+
+				if (le16_get_bits(elems->ml_basic->control,
+						  IEEE80211_ML_CONTROL_TYPE) !=
+				    IEEE80211_ML_CONTROL_TYPE_BASIC) {
+					sdata_info(sdata,
+						   "bad multi-link element (control=0x%x)\n",
+						   le16_to_cpu(elems->ml_basic->control));
+					goto abandon_assoc;
+				} else {
+					struct ieee80211_mle_basic_common_info *common;
+
+					common = (void *)elems->ml_basic->variable;
+
+					if (memcmp(assoc_data->ap_addr,
+						   common->mld_mac_addr, ETH_ALEN)) {
+						sdata_info(sdata,
+							   "AP MLD MAC address mismatch: got %pM expected %pM\n",
+							   common->mld_mac_addr,
+							   assoc_data->ap_addr);
+						goto abandon_assoc;
+					}
+				}
+			} /* if we are not configured to disable EHT */
 		}
 
 		sdata->vif.cfg.aid = aid;
-- 
2.40.0

