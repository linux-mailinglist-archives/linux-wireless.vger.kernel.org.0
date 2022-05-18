Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BEF52C48A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbiERUjj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiERUji (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 16:39:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74102AE32
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652906377; x=1684442377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZUsmLbsivRKfl6EIkOcK9BMLBxnzH6DNWi1Sk/VaIQ=;
  b=cEGL29jc1f7XUQ4I/BFTUsk3MGnoqtOM77eM+QECQSU7eKT8hNZ+NtBo
   pPBhB2Srm3GX44BmAcTUClPKnXMMIIwVIqgYgAda4vOeweps8a9ZxbZQR
   PgEEVTW2vaDpCl9sEEdlDRFp6zJzp6MxBsz+73dYSlZeG7qgMSMWgakMr
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 13:39:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 13:39:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:39:36 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:39:35 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v6 2/3] nl80211: additional processing in NL80211_CMD_SET_BEACON
Date:   Wed, 18 May 2022 13:39:21 -0700
Message-ID: <20220518203922.26417-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220518203922.26417-1-quic_alokad@quicinc.com>
References: <20220518203922.26417-1-quic_alokad@quicinc.com>
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

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed in that command.
Add the missing implementation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/wireless/nl80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4b48819c69d6..4bb4889e4eee 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5810,6 +5810,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ap_settings *params;
+	struct nlattr *attrs;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -5830,6 +5831,20 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	attrs = info->attrs[NL80211_ATTR_FILS_DISCOVERY];
+	if (attrs) {
+		err = nl80211_parse_fils_discovery(rdev, attrs, params);
+		if (err)
+			goto out;
+	}
+
+	attrs = info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP];
+	if (attrs) {
+		err = nl80211_parse_unsol_bcast_probe_resp(rdev, attrs, params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, params);
 	wdev_unlock(wdev);
-- 
2.31.1

