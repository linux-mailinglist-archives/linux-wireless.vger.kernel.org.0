Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB46B16BB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 00:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCHXmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 18:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCHXmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 18:42:24 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C258493
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:42:03 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 24CBE24002E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 23:42:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8935713C2B0;
        Wed,  8 Mar 2023 15:42:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8935713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678318920;
        bh=q8DM6CZkkm7yeE8ehSq5PZsu06Tjjr1zOM8RPN4zCwI=;
        h=From:To:Cc:Subject:Date:From;
        b=dXPTQJEsXwxr5q31QMGtprZ7hVYUn5HuVk23a1g5vlU4wDBoZcvDKCQ5JRqCwKGnv
         75qkhDHSmKtomnizCHY1e8ZJMyZ9Zytj8qhGt6ixlGb9gfK1cOwMR31zUVeUZ8CLzM
         DAd2/NaFhXAsuehVpgUcPYTToMOmkSBpHTpV60Z8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 1/2] wireless: mac80211: Relax flags check in bw-change logic.
Date:   Wed,  8 Mar 2023 15:41:57 -0800
Message-Id: <20230308234158.2732682-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1678318921-auLbK4B54KOh
X-MDID-O: us5;at1;1678318921;auLbK4B54KOh;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

A failure was seen where AP requested change to 40Mhz, and it
failed because 160Mhz and 80P80 were disabled in ifmgd->flags.

Add check for this case so that it will not fail.

Debugging logs from the failure:

sta0001: AP 90:3c:b3:6c:41:11 changed bandwidth, new config is 5180.000 MHz, width 2 (5190.000/0 MHz) ifmgd-flags: 0x3b044 eht-oper: 0000000000000000
sta0001: AP 90:3c:b3:6c:41:11 changed caps/bw in a way we can't support (0x30000/0x3b044) - disconnect
sta0001: chandef-valid: 1 bw: 2 ifmgd->flags mask: 0x33000

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 85741e8b2787..0efca23be69b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -497,6 +497,14 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	    chandef.width > NL80211_CHAN_WIDTH_20)
 		flags |= ieee80211_chandef_downgrade(&chandef);
 
+	/* Relax check for implicit disabled. */
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
+	    chandef.width != NL80211_CHAN_WIDTH_160)
+		flags |= IEEE80211_CONN_DISABLE_160MHZ;
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
+	    chandef.width != NL80211_CHAN_WIDTH_80P80)
+		flags |= IEEE80211_CONN_DISABLE_80P80MHZ;
+
 	if (cfg80211_chandef_identical(&chandef, &link->conf->chandef))
 		return 0;
 
-- 
2.39.1

