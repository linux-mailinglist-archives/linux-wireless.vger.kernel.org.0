Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5356F1FAA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbjD1Uui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbjD1Uuh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:37 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3964EF5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:26 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3D0F0B8006C
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:25 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C481513C2B0;
        Fri, 28 Apr 2023 13:50:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C481513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715024;
        bh=rA2hCKKOHgiwq3nDs+pVKcFEG4UCAYtmNrsPh3FmQBA=;
        h=From:To:Cc:Subject:Date:From;
        b=by8jxLGJgkg951fST53yBe8NuIla3RBNSVoKuThf5PqzzExiDHMNemEBvA6KUDRbv
         yKA6oxRlUlq9CfdQZnE98neeIbWk2QYZpZ/RxUYFBEGm3r8p3nP+xU5xlfNBRg7hVu
         tVnP4J5oxGP3ne5CqV5VZNHlY8ohPby5Uz1uKfdM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211: Do not clear bw restriction flags in ieee80211_prep_channel
Date:   Fri, 28 Apr 2023 13:50:22 -0700
Message-Id: <20230428205022.2648031-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715025-KI76OcAxYjlv
X-MDID-O: us5;ut7;1682715025;KI76OcAxYjlv;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This code was messing up my attempt to restrict bandwidth options,
and appears to not be needed.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e13a0354c397..2c606d9fc5b3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4732,10 +4732,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
-	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
-			 IEEE80211_CONN_DISABLE_80P80MHZ |
-			 IEEE80211_CONN_DISABLE_160MHZ);
-
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
 		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-- 
2.40.0

