Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F84DE532
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 03:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiCSCh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 22:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCSChZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 22:37:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5772BB7CD
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647657365; x=1679193365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RF5igoTu3j2FYAqjDSBzSvxMRT7HE8ocLWW0XvWMDw8=;
  b=jA7o6DqLwt+4IjfXZfK1Z9/lXBmYzfEu00/nKcICg5qZpDCngvLsag/Q
   Q2xncBUHBXvFzQ7EY+/XCPsilRSJ5ByWwRbE6w5i9RuKe+Hom/hT7EPZI
   B4xygp4ufAXYukdu1KoQWqTdYyYIapgB8TJdN8qU71xSJvY/GnK0A/TuZ
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Mar 2022 19:36:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 19:36:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 19:36:04 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 19:36:03 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 0/3] ath11k: add support muti-type regdb data for WCN6855
Date:   Fri, 18 Mar 2022 22:35:40 -0400
Message-ID: <20220319023543.14288-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
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

Add enum value ATH11K_BD_IE_REGDB and enum type ath11k_bd_ie_regdb_type
for regdb data, the board-2.bin will include both board data and regdb
files.

Wen Gong (3):
  ath11k: remove unused ATH11K_BD_IE_BOARD_EXT
  ath11k: disable regdb support for QCA6390
  ath11k: add support to search regdb data in board-2.bin for WCN6855

 drivers/net/wireless/ath/ath11k/core.c | 81 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/hw.h   | 20 ++++++-
 2 files changed, 75 insertions(+), 26 deletions(-)


base-commit: d845cf007bdf8b2bf41522e1ecd0eb804e553d57
-- 
2.31.1

