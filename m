Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759F51B54F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 03:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiEEBmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 21:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiEEBmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 21:42:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6828E3E
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 18:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651714746; x=1683250746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eJEj/nxSr1KlTmF7oDl23RHuI5Q4XTfaWNrgPA3i6nM=;
  b=aeFhOB5pZMB9Y7xA0+qi5FmEXtBqZPaRTaRbrb1DIFAiKWs5+RjC/K/t
   SvLHT7NFPSxioJKfO02Vf+4ZC/A4XQphmoGfHlQGjnYK37SkNKbQwWSSC
   5fA6CuLUbEI5otLKSpQtOfX/BtkYDk3LeQlm7155gpsivCmZWZYl5KoHG
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2022 18:39:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:39:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:39:06 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:39:05 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3]  ath11k: Add support for Passpoint
Date:   Thu, 5 May 2022 09:38:48 +0800
Message-ID: <20220505013851.1548789-1-quic_bqiang@quicinc.com>
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

This is to add Passpoint support for WCN6855 and QCA6390.
With this patch set, STA can successfully connect to an
Passpoint AP.

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

