Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503877B7397
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 23:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJCV6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJCV6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 17:58:46 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD1A6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 14:58:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 93B19A80071
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 21:58:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 1833913C2B0;
        Tue,  3 Oct 2023 14:58:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1833913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696370321;
        bh=j+2iI5Ljhwh3oxtbEWOohd0yhLv4csUwh/m1ozxjmsE=;
        h=From:To:Cc:Subject:Date:From;
        b=NB+Tm4WcTVfAWO3KkbQpH1D6SvEXN7KrBaBR8dkzd87OW0id+HEPQxuuCys3Bpo/B
         72cFxAHfSTv15o8hu1ETtaThslXCFVcUmgupzWgvFkgs1BZKNfYoAuwYL2ErOvSuu/
         kiMViskWEQ2efPWJ0PJQA/MdCL9bjV4X/deyHLqM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  ethtool:  check link sta if deflink sta not found.
Date:   Tue,  3 Oct 2023 14:58:39 -0700
Message-Id: <20231003215839.981227-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1696370322-O5XpusY6R4Lx
X-MDID-O: us5;ut7;1696370322;O5XpusY6R4Lx;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

While testing with wifi-7 radio put into AX mode, link-0 is created.
sdata->deflink.u.mgd.bssid was 00 in this case, so sta was not
found.

Use link-0 for sta if it is available to do a better job of reporting
ethtool stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 6bd7fba8a867..1b58304fc68a 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -96,6 +96,7 @@ static void ieee80211_get_stats2(struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct station_info sinfo;
 	struct survey_info survey;
+	struct ieee80211_link_data *link;
 	int i, q;
 	int z;
 #define STA_STATS_SURVEY_LEN 7
@@ -128,6 +129,12 @@ static void ieee80211_get_stats2(struct net_device *dev,
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
 		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
 
+		if (!sta) {
+			link = sdata_dereference(sdata->link[0], sdata);
+			if (link)
+				sta = sta_info_get_bss(sdata, link->u.mgd.bssid);
+		}
+
 		if (!(sta && !WARN_ON(sta->sdata->dev != dev)))
 			goto do_survey;
 
-- 
2.40.0

