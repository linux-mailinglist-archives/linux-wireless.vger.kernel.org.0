Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB14EECE6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiDAML6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiDAMLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 08:11:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99392C6EEF
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648815002; x=1680351002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=opyx11aftSKol0i2AxU77/phhkQqFw6Q6f566jASU3Q=;
  b=EGrfa6yci+emtLgO0Zwvnsj9q4Oy0lnbfwxpWFc6ltR4Mve6CEWY4pv0
   vety1hM18+cPFoUUoikOKHx1rokbBKMPSynVbbZg2G85T6MLNOQhVZpaU
   vTI3z49zXZeCpYuWoIEkdNkSp2mSti0alhTIJEoGdkUR+PqOdHq0C7HpH
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Apr 2022 05:10:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 05:10:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 05:10:01 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 05:10:00 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 0/2] ath11k: Add support for SAR
Date:   Fri, 1 Apr 2022 20:09:46 +0800
Message-ID: <20220401120948.1312956-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is to add support for SAR, currently it is only enabled
for WCN6855.

v4:
 1. rebased on latest ath.git
 2. add my own s-o-b in Wen'spatch

v3:
 1. rebased on latest ath.git
 2. add Wen's patch to this patch set so that
    there is no dependency.

Baochen Qiang (1):
  ath11k: Add support for SAR

Wen Gong (1):
  ath11k: add support for extended wmi service bit

 drivers/net/wireless/ath/ath11k/core.c |   6 +
 drivers/net/wireless/ath/ath11k/hw.c   |  20 ++++
 drivers/net/wireless/ath/ath11k/hw.h   |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  |  66 +++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 151 +++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/wmi.h  |  36 +++++-
 6 files changed, 247 insertions(+), 34 deletions(-)


base-commit: 57b7042c114767b7330b14a260f61732e556742e
-- 
2.25.1

