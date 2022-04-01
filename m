Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933F4EE920
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbiDAHdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDAHds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 03:33:48 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5D1E6E9C
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648798316; x=1680334316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/rPu336six2VeuZ+f8xOlNtVLTMD9/U1JCdnnpPLX0=;
  b=C5FrzBXegbVordKCdbElr7Fl+wm0nwHs+jARWDDi5t+aU2Nq0cJmOEB8
   xLMP4SYBqWZ/OZ8F+v16WJXTy3b7MXG+rjpNAHAeZzi6G2XjuNGnNrxc2
   Bpvh/zEbCRWcnSz/PlIHgvmw+5dlfmG5Hrt0NVdD/TLGbR3Iq7UMhFxlJ
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Apr 2022 00:31:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 00:31:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:31:55 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 00:31:54 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/2] ath11k: Add support for SAR
Date:   Fri, 1 Apr 2022 15:31:42 +0800
Message-ID: <20220401073142.1195018-1-quic_bqiang@quicinc.com>
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

This is to add support for SAR. Currently SAR is enabled
only for WCN6855.

v3:
 1. rebased on latest ath.git
 2. add Wen's patch "ath11k: add support for extended wmi service bit"
    to this patch set so that there will be no dependency for the SAR patch.
v2:
 1. rebased on latest ath.git
 2. add base-commit tag.

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


base-commit: 748b34786d1c96e758862d8e8577106ccde6515a
-- 
2.25.1

