Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1043074F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhJQIqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53604 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245113AbhJQIqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lv-000YRM-62; Sun, 17 Oct 2021 11:44:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:48 +0300
Message-Id: <iwlwifi.20211017113927.f73e3b6384cb.I967fd394995461277eafa149bb25cefd1673751e@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/10] iwlwifi: remove contact information
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The list address is going away, and the postal address isn't
useful, remove all the contact information.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c          | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h              | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c          | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/led.c              | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/led.h              | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c              | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c         | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/main.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/power.c            | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/power.h            | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c               | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h               | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c               | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c             | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c             | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c              | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c               | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h               | 4 ----
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c               | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c            | 5 -----
 drivers/net/wireless/intel/iwlwifi/fw/img.c               | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h            | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h    | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h      | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h     | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h   | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c         | 5 -----
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h         | 5 -----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c               | 5 -----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h               | 5 -----
 35 files changed, 169 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 44c4fe975390..116defb15afb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2018 - 2020 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index df6ac00340b2..ab2038a3fbe2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2018 - 2020 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 6cdd7d983bda..e2e23d2bc1fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2018 - 2020 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 541a3ec85777..20929e59c2f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2018 - 2020 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index 911049201838..b246dbd371b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -3,10 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2018 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 
 #include <linux/slab.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 4bd792c06ff6..bbd574091201 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014, 2020 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 /*
  * Please use this file (dev.h) for driver implementation definitions.
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index c3e25885d194..39e40901fa46 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/units.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index e8a4d604b910..71f67a019cf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.h b/drivers/net/wireless/intel/iwlwifi/dvm/led.h
index 6fe20180dc87..5038fc378a1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.h
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #ifndef __iwl_leds_h__
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index 3b937a7dd403..40d790b36d85 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 75e7665773c5..754876cd27ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -6,11 +6,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 50d4e9481790..fbd57a2b2bd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -6,11 +6,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index 93ef023905c9..6d16a7105656 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -6,10 +6,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.h b/drivers/net/wireless/intel/iwlwifi/dvm/power.h
index 3f8db1fc4b59..f38201ce1e99 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.h
@@ -5,10 +5,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 #ifndef __iwl_power_setting_h__
 #define __iwl_power_setting_h__
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 548540dd0c0f..b7c8b209bfea 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 - 2020 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
index 68a840d739e8..0b47f1993c5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #ifndef __iwl_agn_rs_h__
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 3cd7b423c588..db0c41bbeb0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -7,11 +7,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portionhelp of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 12a3d464ae64..70338bc7bb54 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- *
- * Contact Information:
- * Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/scan.c b/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
index c4ecf6ed2186..2d38227dfdd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
@@ -3,10 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2018        Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index ddc14059b07d..8f7a0f36c276 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -5,11 +5,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 #include <linux/etherdevice.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
index 2684a924ba57..43e8d04d5a8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
@@ -6,10 +6,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
index 3b0ff458a158..7ace052fc78a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
@@ -5,10 +5,6 @@
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *****************************************************************************/
 #ifndef __iwl_tt_setting_h__
 #define __iwl_tt_setting_h__
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 847b8e07f81c..60a7b61d59aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
index 24194c791218..4b27a53d0bb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index c2a4e60518bc..5755e179066a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -18,11 +18,6 @@
  *
  * The full GNU General Public License is included in this distribution
  * in the file called COPYING.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  * BSD LICENSE
  *
  * Copyright(c) 2019 - 2020 Intel Corporation
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 528eba441926..8db7aeddfd05 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -5,11 +5,6 @@
  * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #ifndef __iwl_debug_h__
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
index 1bc6ecc32140..347fd95c4e3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
@@ -4,11 +4,6 @@
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015        Intel Deutschland GmbH
  * Copyright(c) 2018 - 2019 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_DATA) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h
index a57019241a78..0af9d8362c5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_IO) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
index 72ca882daed5..46ed723f138a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
@@ -5,11 +5,6 @@
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  * Copyright(c) 2018        Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
index d0467da5af03..7dd70011fd1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_MSG) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h
index 2228faefffbc..3ec0205ac9f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h
@@ -2,11 +2,6 @@
 /******************************************************************************
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_UCODE) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
index b5037db0c381..999b7c652289 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c
@@ -3,11 +3,6 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2018 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
index fc8bc212ee84..1455b578358b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
@@ -4,11 +4,6 @@
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(C) 2016        Intel Deutschland GmbH
  * Copyright(c) 2018        Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #ifndef __IWLWIFI_DEVICE_TRACE
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index b75505061e64..2783aca3619a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -4,11 +4,6 @@
  * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 32104c9f8f5e..3e206df57347 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -5,11 +5,6 @@
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
  * Copyright(c) 2018 - 2019 Intel Corporation
- *
- * Contact Information:
- *  Intel Linux Wireless <linuxwifi@intel.com>
- * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
- *
  *****************************************************************************/
 
 #ifndef __rs_h__
-- 
2.33.0

