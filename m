Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D614E6DF8
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354240AbiCYGBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCYGBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:01:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4744C681C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648188011; x=1679724011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2mKIC4Canfy9Bt4RGPz0iaA2vqA/2yLoC71GUupdPC0=;
  b=P/8uFKe418koV0rDZCYpijbhqn4m+XE7Qeo/fKKP92DuA3D7mrvoOm7L
   fgZLYA/9hMRHHTIKBnPa6zAQIFrWjJMJ1Ow3lRUxsmykP+t3tWXOld3NT
   glRGe9+cEn0tA+wAWAoxIH+uwTIkvrH4hgxg86Y4T2j+YXUNZAHL0u6xE
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 23:00:11 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:00:11 -0700
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 23:00:09 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v6 0/3] Add support to configure beacon tx mode
Date:   Fri, 25 Mar 2022 11:29:46 +0530
Message-ID: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to configure the beacon tx mode as STAGGERED
or BURST mode via hostapd configuration during the AP
bring-up or via wpa_suppplicant configuration during MESH
bring-up.

Beacons can be sent out in burst(continuously in a single shot
one after another) or staggered (equally spread out over beacon
interval) mode.

V6: Addressed Jeff's comment on v5.

V5: Addressed Johannes's and Felix's comment on v4.

V4: Rebased on latest ath.git TOT.

V3: Addressed Johnson's comment on v2 patch.

V2: Addressed Johannes's comment on v1 patch.

Maharaja Kennadyrajan (3):
  nl80211: Add support for beacon tx mode
  mac80211: Add support for beacon tx mode
  ath11k: Add support for beacon tx mode

 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
 include/net/cfg80211.h                |  4 ++++
 include/net/mac80211.h                |  2 ++
 include/uapi/linux/nl80211.h          | 21 +++++++++++++++++++++
 net/mac80211/cfg.c                    |  2 ++
 net/wireless/nl80211.c                | 11 +++++++++++
 6 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.25.1

