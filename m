Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCF4E5B6F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 23:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbiCWWsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiCWWsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 18:48:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663198F989
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 15:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648075608; x=1679611608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cS69bWsi0yZrTJWwbQtqTekYkjlpxBw3J1exyAVZGrQ=;
  b=hhwCKFX39U4WDzMAvptfLiS5d9iL90hyT8RDxEaWb0M28qmw2zc9yYCj
   vLZysUrunGoRLHkN1VoWhekRYlpYgDkL39+gcsTsgZ4ZRid3zAMfbEaCY
   LspRZHlxlmcERU5qv70eVbqk8RfYwGKiJ4FXuawr0m3K8shMxgJZ/a7uF
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 15:46:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:46:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:46:47 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:46:47 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Muna Sinada <quic_msinada@quicinc.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 2/2] mac80211: support disabling EHT mode
Date:   Wed, 23 Mar 2022 15:46:36 -0700
Message-ID: <20220323224636.20211-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323224636.20211-1-quic_alokad@quicinc.com>
References: <20220323224636.20211-1-quic_alokad@quicinc.com>
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

From: Muna Sinada <quic_msinada@quicinc.com>

Allow userspace to disable EHT mode.
This forces EHT capable interfaces to disable during association.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: Rebased on top of wireless-next git repository.

 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1b30c724ca8d..7f1e3569dd5d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5964,7 +5964,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 			netdev_info(sdata->dev,
-				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
+				    "disabling HT/VHT/HE/EHT due to WEP/TKIP use\n");
 		}
 	}
 
@@ -6126,6 +6126,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
 	}
 
+	if (req->flags & ASSOC_REQ_DISABLE_EHT)
+		ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
+
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
 		goto err_clear;
-- 
2.31.1

