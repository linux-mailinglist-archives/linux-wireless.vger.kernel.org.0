Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4E5858C6
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiG3F1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiG3F1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 01:27:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AFE4E857
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659158841; x=1690694841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mPb39S++j7suQ1oJQQ8EDaMbiMkHXeQ0tk3OAodV/Q=;
  b=RHJIUrF5oMjp+k2k37Z56nfTC19bEgRB5VtOrQJPOo5gNVrb7Fe7TtzE
   R07L0d9/gYuIFBY43nFPD9LoLAcbMD7JK1HpWrWJZPzpp1yF15oFB/gQm
   TatYpSBCsmG/uSGOkumAd2NiJNGghHY8cSy2jNRtFJ+0sTqriJIGbmr96
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Jul 2022 22:27:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:27:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:27:02 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:27:00 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 2/3] wifi: cfg80211: Prevent cfg80211_wext_siwencodeext() on MLD
Date:   Sat, 30 Jul 2022 10:56:42 +0530
Message-ID: <20220730052643.1959111-3-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220730052643.1959111-1-quic_vjakkam@quicinc.com>
References: <20220730052643.1959111-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, MLO support is not added for WEXT code and WEXT handlers are
prevented on MLDs. Prevent WEXT handler cfg80211_wext_siwencodeext()
also on MLD which is missed in commit 7b0a0e3c3a88 ("wifi: cfg80211: do
 some rework towards MLO link APIs")

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/wext-compat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a9767bfe7330..129d3bb91dfb 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -685,6 +685,13 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 	    !rdev->ops->set_default_key)
 		return -EOPNOTSUPP;
 
+	wdev_lock(wdev);
+	if (wdev->valid_links) {
+		wdev_unlock(wdev);
+		return -EOPNOTSUPP;
+	}
+	wdev_unlock(wdev);
+
 	switch (ext->alg) {
 	case IW_ENCODE_ALG_NONE:
 		remove = true;
-- 
2.25.1

