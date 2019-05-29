Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28B2DCB6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfE2MZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54274 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfE2MZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeL-0007wy-L6; Wed, 29 May 2019 15:25:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/10] cfg80211: report measurement start TSF correctly
Date:   Wed, 29 May 2019 15:25:28 +0300
Message-Id: <20190529122537.8564-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Instead of reporting the AP's TSF, host time was reported. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/pmsr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 1b190475359a..c09fbf09549d 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  */
 #ifndef __PMSR_H
 #define __PMSR_H
@@ -448,7 +448,7 @@ static int nl80211_pmsr_send_result(struct sk_buff *msg,
 
 	if (res->ap_tsf_valid &&
 	    nla_put_u64_64bit(msg, NL80211_PMSR_RESP_ATTR_AP_TSF,
-			      res->host_time, NL80211_PMSR_RESP_ATTR_PAD))
+			      res->ap_tsf, NL80211_PMSR_RESP_ATTR_PAD))
 		goto error;
 
 	if (res->final && nla_put_flag(msg, NL80211_PMSR_RESP_ATTR_FINAL))
-- 
2.20.1

