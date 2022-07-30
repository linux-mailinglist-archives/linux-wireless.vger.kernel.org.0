Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F380F5858C4
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiG3F1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiG3F1V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 01:27:21 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27066E0A2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659158841; x=1690694841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kuy6GxophU1A4DnkwhC8xOj8R4lEp35hvKkcPU8f+w0=;
  b=i2NX6JH+hqDKzZBEWAY8Yv9pL0VSbioAsmspihW5CeVf5Ty5snEZHNWc
   8rC5z5zOhRgqONdJ/rq+fqJTOi4LPzicaQsnO/yqKggVTjoMurU7vK3qh
   r5VtSriaBu8SjQfxIcxq5HLQEPEyLg0b+RDHre2Frg6Sfm/AQY6t/Fz1/
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Jul 2022 22:27:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:27:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:27:00 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:26:58 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 1/3] wifi: cfg80211: reject connect response with MLO params for WEP
Date:   Sat, 30 Jul 2022 10:56:41 +0530
Message-ID: <20220730052643.1959111-2-quic_vjakkam@quicinc.com>
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

MLO connections are not supposed to use WEP security. Reject connect
response of MLO connection if WEP security mode is used.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/sme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 62c773cf1b8d..34d27a3070f0 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -747,6 +747,9 @@ void __cfg80211_connect_result(struct net_device *dev,
 			if (WARN_ON(!cr->links[link].addr))
 				goto out;
 		}
+
+		if (WARN_ON(wdev->connect_keys))
+			goto out;
 	}
 
 	wdev->unprot_beacon_reported = 0;
-- 
2.25.1

