Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9838647A1F5
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhLSTve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 14:51:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:59967 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhLSTvd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639943493; x=1671479493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQM4wczQUQSfif1dzoaLqK9/w2kPTZrz1OgmJeHRzYY=;
  b=K7s+QR6GYy6nuYa2Ucy62b793EoVeQJedGz/IlbkMLZfSgCmae2Tqin9
   dTTjkiFq/etmtl/xhyabkzgmF4+vx0Dq+k06XRddLCN2OGzf1fdwmw3Mt
   cCrBewcsfjtBKMy5nRFY649YPMOBOFoB8W512ZBhBchPnc2WCC0HQeC4q
   60cPjgVuxHQnekfb+jN981Q/1mU80i50VCXczDP3ETKaiLZ916bgvIX5f
   9Ld4tKPIgmGYFKdScgeVyJrS2Txv+JU7m43b6BKYEZVNmeUWk+//ETS8D
   tzzPZXNXixuu728ictOkxeHGWndhLG7E+JKHLBL7Zl2A1nPRw8DzxeZ2N
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="226909314"
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="226909314"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 11:51:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="520530303"
Received: from skriksze-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.194.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 11:51:31 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] rfkill: allow to get the software rfkill state
Date:   Sun, 19 Dec 2021 21:51:24 +0200
Message-Id: <20211219195124.125689-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iwlwifi needs to be able to differentiate between the
software rfkill state and the hardware rfkill state.

The reason for this is that iwlwifi needs to notify any
change in the software rfkill state even when it doesn't
own the device (which means even when the hardware rfkill
is asserted).

In order to be able to know the software rfkill when the
host does not own the device, iwlwifi needs to be able to
ask the state of the software rfkill ignoring the state
of the hardware rfkill.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/linux/rfkill.h |  7 +++++++
 net/rfkill/core.c      | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 231e06b74b50..c35f3962dc4f 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -229,6 +229,13 @@ void rfkill_set_states(struct rfkill *rfkill, bool sw, bool hw);
  */
 bool rfkill_blocked(struct rfkill *rfkill);
 
+/**
+ * rfkill_soft_blocked - Query soft rfkill block state
+ *
+ * @rfkill: rfkill struct to query
+ */
+bool rfkill_soft_blocked(struct rfkill *rfkill);
+
 /**
  * rfkill_find_type - Helper for finding rfkill type by name
  * @name: the name of the type
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index ac15a944573f..5b1927d66f0d 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -946,6 +946,18 @@ bool rfkill_blocked(struct rfkill *rfkill)
 }
 EXPORT_SYMBOL(rfkill_blocked);
 
+bool rfkill_soft_blocked(struct rfkill *rfkill)
+{
+	unsigned long flags;
+	u32 state;
+
+	spin_lock_irqsave(&rfkill->lock, flags);
+	state = rfkill->state;
+	spin_unlock_irqrestore(&rfkill->lock, flags);
+
+	return !!(state & RFKILL_BLOCK_SW);
+}
+EXPORT_SYMBOL(rfkill_soft_blocked);
 
 struct rfkill * __must_check rfkill_alloc(const char *name,
 					  struct device *parent,
-- 
2.25.1

