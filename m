Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21A4F69D6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiDFT3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiDFT2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 15:28:25 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF127971F
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 10:57:22 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3E43C1C0084
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 17:57:06 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1B11168008D
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 17:57:06 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 52E9513C2B0;
        Wed,  6 Apr 2022 10:57:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 52E9513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1649267825;
        bh=mc6SLO6ffh4RwSRC2qXIzQWSBGwD8SONajM44Ak0UlY=;
        h=From:To:Cc:Subject:Date:From;
        b=BRGMtbLKnYxKQmcKkNE4c0IR2t3Q0u8D4sxW24C1p6HcBMigSqkirXSyGL7pzTpV3
         dRLu8oEVJFy0Z13XPXJlV6yJpv3nyJeoI7gw8A0sM/GhxkTrfvwOm27NHwq1HrK5AF
         FjV8RUd+vx05NnDgSTjPk6UVAksxHvFmJeAP/F+A=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  fix ht_capa printout in debugfs.
Date:   Wed,  6 Apr 2022 10:56:59 -0700
Message-Id: <20220406175659.20611-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1649267831-Bz0zECROe0A6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Don't use sizeof(pointer) when calculating scnprintf offset.

Fixes: mac80211: debugfs: calculate free buffer size correctly (eb3d6175e4a9)
Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 19195d63ae5c..db852f8c5feb 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -584,7 +584,7 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
 	if (_cond) \
-			p += scnprintf(p, sizeof(buf)+buf-p, "\t" _str "\n"); \
+			p += scnprintf(p, bufsz + buf - p, "\t" _str "\n"); \
 	} while (0)
 	char *buf, *p;
 	int i;
-- 
2.20.1

