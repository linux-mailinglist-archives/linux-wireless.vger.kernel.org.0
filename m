Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2851CE47
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbiEFBkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiEFBkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 21:40:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437E5DBE2
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651800986; x=1683336986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FA94JyOdyKLzWnhysBgprLnh+J4ocncFt0+dV7mOlo8=;
  b=vcDJCFN8DG0MQu8K3awXrD9vkmNCcceVVN+/W/DjbZ52npZ8G4ukjuah
   JZpwgLnL9SyzAnbzaGg+ZkAQZWsBNGFr7Pp7wK5WSPxD62KR24uvgBnKg
   PcN07Z/FKI+Z5pZAGo2cpr8DV3hKcPxMZi5J7fyFQelXDLm0aFA8LmQXP
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 May 2022 18:36:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:36:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 18:36:25 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 18:36:24 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/3] ath11k: Add support for Passpoint
Date:   Fri, 6 May 2022 09:36:11 +0800
Message-ID: <20220506013614.1580274-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

This is to add Passpoint support for WCN6855 and QCA6390.
With this patch set, STA can successfully connect to an
Passpoint AP.

v2:
 1. update commit log of patch 2/3

Baochen Qiang (3):
  ath11k: Implement remain-on-channel support
  ath11k: Don't check arvif->is_started before sending management frames
  ath11k: Designating channel frequency when sending management frames

 drivers/net/wireless/ath/ath11k/core.c |   8 ++
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 120 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c  |  21 ++++-
 4 files changed, 147 insertions(+), 3 deletions(-)


base-commit: b04efb72cd9d2d471a14f0a5758873f6c78923c2
-- 
2.25.1

