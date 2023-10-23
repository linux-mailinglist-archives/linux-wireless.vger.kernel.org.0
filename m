Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68BA7D3E65
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJWR5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJWR5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 13:57:45 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5CA1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:57:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E267E340062
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 17:57:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5567713C2B0;
        Mon, 23 Oct 2023 10:57:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5567713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698083861;
        bh=ivZD/LGa6z8tn3S9sqZQgEGubMGyqtF46eoNzrZop84=;
        h=From:To:Cc:Subject:Date:From;
        b=CSUZbnFr7ByQxWEHXT19/IAINjgZuNGLHHVs9+PJBn0sN+bDwzt152owMyRrO6Ohn
         rK2S8DEYhjEf6UxG5yCKFE1IWEJqgHjiDnuPkUDtJ9sruqwzwQcZFdCNoOqVStNEf5
         SYXVsQw7tiKonj94f86J1TKP7X/S0ubjfkGTfDH8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  work around crash in mlme.c
Date:   Mon, 23 Oct 2023 10:57:38 -0700
Message-Id: <20231023175738.1686631-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698083862-ki-DXbvBbzp7
X-MDID-O: us5;ut7;1698083862;ki-DXbvBbzp7;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Protect from NULL ifmgd->assoc_data in ieee80211_mgd_deauth, crash
was seen here fairly often in a 32-station test case utilizing
mtk7922 and be200 radios.  I'm not sure if radio types matters
though.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

Patch is for wireless-next tree, bug was likely introduced in
this release since this crash was not seen in earlier 6.6-rc testing
nor in 6.5 or earlier.

There may be a better way to fix this...

 net/mac80211/mlme.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7695531de611..d2a44a13625c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8185,13 +8185,18 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   "aborting authentication with %pM by local choice (Reason: %u=%s)\n",
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
-
-		info.link_id = ifmgd->assoc_data->assoc_link_id;
-		drv_mgd_prepare_tx(sdata->local, sdata, &info);
-		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
-					       IEEE80211_STYPE_DEAUTH,
-					       req->reason_code, tx,
-					       frame_buf);
+		if (WARN_ON_ONCE((unsigned long)(ifmgd) < 4000 ||
+				 (unsigned long)(ifmgd->assoc_data) < 4000)) {
+			sdata_err(sdata, "ieee80211-mgd-auth abort auth, bad memory: ifmgd: %p  ifmgd->assoc_data: %p\n",
+				  ifmgd, ifmgd->assoc_data);
+		} else {
+			info.link_id = ifmgd->assoc_data->assoc_link_id;
+			drv_mgd_prepare_tx(sdata->local, sdata, &info);
+			ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
+						       IEEE80211_STYPE_DEAUTH,
+						       req->reason_code, tx,
+						       frame_buf);
+		}
 		ieee80211_destroy_auth_data(sdata, false);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
@@ -8207,12 +8212,18 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   req->bssid, req->reason_code,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
-		info.link_id = ifmgd->auth_data->link_id;
-		drv_mgd_prepare_tx(sdata->local, sdata, &info);
-		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
-					       IEEE80211_STYPE_DEAUTH,
-					       req->reason_code, tx,
-					       frame_buf);
+		if (WARN_ON_ONCE((unsigned long)(ifmgd) < 4000 ||
+				 (unsigned long)(ifmgd->assoc_data) < 4000)) {
+			sdata_err(sdata, "ieee80211-mgd-auth abort assoc, bad memory: ifmgd: %p  ifmgd->assoc_data: %p\n",
+				  ifmgd, ifmgd->assoc_data);
+		} else {
+			info.link_id = ifmgd->auth_data->link_id;
+			drv_mgd_prepare_tx(sdata->local, sdata, &info);
+			ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
+						       IEEE80211_STYPE_DEAUTH,
+						       req->reason_code, tx,
+						       frame_buf);
+		}
 		ieee80211_destroy_assoc_data(sdata, ASSOC_ABANDON);
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
-- 
2.40.0

