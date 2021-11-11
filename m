Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE644D1C5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 06:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhKKFzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 00:55:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23017 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhKKFzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 00:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636609981; x=1668145981;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=kdcG9M1jEfEUbVcHne7k0qgSUkqp4rnMdn+E//9zTcU=;
  b=Fb49G6CuEg7k1NgmD803nqc0BddYzWe4HErt3xACqDRlXO1QJgp4Cq0G
   dirvhJAF6eT4iCxCS7uz5z9R96oEPwiGJjbpJjqQbdJVqAw6CG57VUlAP
   nm0qaT1D8Aqerpnd4lZxy+MNvZle5rEjd6ee3csvEL8MDyMVLLeXvbOas
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Nov 2021 21:53:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 21:53:00 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 21:53:00 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 21:52:58 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCH] ath11k: Fix 'unused-but-set-parameter' error
Date:   Thu, 11 Nov 2021 11:22:47 +0530
Message-ID: <1636609967-5114-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Below compilation error is reported when built with W=1,

drivers/net/wireless/ath/ath11k/mac.c:5408:22: error: parameter 'changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]

changed_flags is set, but left unused. So, remove unnecessary set.
Compile tested only.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 89810b2..6f3130d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5919,7 +5919,6 @@ static void ath11k_mac_op_configure_filter(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	changed_flags &= SUPPORTED_FILTERS;
 	*total_flags &= SUPPORTED_FILTERS;
 	ar->filter_flags = *total_flags;
 
-- 
2.7.4

