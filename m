Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1B58ABDF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiHENy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiHENyS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 09:54:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621052E57
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659707635; x=1691243635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kRBD8WSxyB96Mk1/Yu2P7dKUP8Tr8SrQ/B8NMq23w+0=;
  b=aQrOk3X/wYp4ivL5DVv6KX4YeEJ13rsWp1tkwB1P34yxJsKXFzdiFmbR
   MtbOGzLii/shEOG/KRmD4Ig27dNhX0WgDIrvpegzQrV+ks2ujBezOBRfB
   4IgpmHtL47gU4EF2Yc15HFkKgmXaRryTZkKZbgRDxvYFTQwOgjNCOnAut
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Aug 2022 06:53:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 06:53:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 5 Aug 2022 06:53:53 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 5 Aug 2022 06:53:52 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: cfg80211: Fix validating BSS pointers in __cfg80211_connect_result
Date:   Fri, 5 Aug 2022 19:22:59 +0530
Message-ID: <20220805135259.4126630-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver's SME is allowed to fill either BSSID or BSS pointers in struct
cfg80211_connect_resp_params when indicating connect response but a
check in __cfg80211_connect_result() is giving unnecessary warning when
driver's SME fills only BSSID pointer and not BSS pointer in struct
cfg80211_connect_resp_params.

In case of mac80211 with auth/assoc path, it is always expected to fill
BSS pointers in struct cfg80211_connect_resp_params when calling
__cfg80211_connect_result() since cfg80211 must have hold BSS pointers
in cfg80211_mlme_assoc().

So, skip the check for the drivers which support cfg80211 connect
callback.

Fixes: efbabc116500 ("cfg80211: Indicate MLO connection info in connect and roam callbacks")
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/sme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 62c773cf1b8d..27fb2a0c4052 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -782,9 +782,11 @@ void __cfg80211_connect_result(struct net_device *dev,
 #endif
 
 	if (cr->status == WLAN_STATUS_SUCCESS) {
-		for_each_valid_link(cr, link) {
-			if (WARN_ON_ONCE(!cr->links[link].bss))
-				break;
+		if (!wiphy_to_rdev(wdev->wiphy)->ops->connect) {
+			for_each_valid_link(cr, link) {
+				if (WARN_ON_ONCE(!cr->links[link].bss))
+					break;
+			}
 		}
 
 		for_each_valid_link(cr, link) {
-- 
2.25.1

