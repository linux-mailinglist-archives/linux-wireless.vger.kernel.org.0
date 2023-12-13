Return-Path: <linux-wireless+bounces-734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B695811047
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 12:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD24B20C96
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971C24205;
	Wed, 13 Dec 2023 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3NAbnGz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169AB2
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 03:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702467481; x=1734003481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IXxvGiUBfJU798ZXozBN17FbwLe12G1F9ngUMch36Ew=;
  b=h3NAbnGznz7M6pTuYAv4p7ocyp4gEP3OLMK/Ai68IObZWOBur4ZxmnNJ
   Jcc5iShmlirCliIErBiGMy++dDf+IN6UHwR0BrDYmUXKXFIfP0o1/Ojgu
   utW4szo3Qnc8hR4W1Kg3rkk+0Knx9oal438NKmv2BAw3LJbRCC+4nu37I
   pJeayh0qT8YvGTGoJ1mq5lLUQgyMUUtfGVl5ivAchI8SkV1Qznqh8b3ma
   cAdtSws+y5vy4sVlg8K09uxHC78DjBTYx7AfRd76WBWWfRkQJoigw4zs3
   a/HJRGqdOm9vM7Og6pFxnxLmzOcnkihhP/4OGB61LCRBUVQmFMJxdqVIp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392126109"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="392126109"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="15382225"
Received: from mwaksma1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.254.159.208])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:38:00 -0800
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: hostap@lists.infradead.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH] tests: Modify the QoS mapping tests
Date: Wed, 13 Dec 2023 13:37:35 +0200
Message-Id: <20231213113735.289408-1-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The cfg80211 default QoS mapping was updated to align
with the recommendations in section 4 in RFC8325. Align the QoS
mapping test accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
---
This patch depends on the corresponding pending kernel change:
https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid/
---
 tests/hwsim/test_ap_qosmap.py | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tests/hwsim/test_ap_qosmap.py b/tests/hwsim/test_ap_qosmap.py
index fb26474871..8ed3fe4734 100644
--- a/tests/hwsim/test_ap_qosmap.py
+++ b/tests/hwsim/test_ap_qosmap.py
@@ -89,8 +89,20 @@ def test_ap_qosmap_default(dev, apdev):
     dev[0].request("DATA_TEST_CONFIG 1")
     hapd.request("DATA_TEST_CONFIG 1")
     Wlantest.setup(hapd)
+
+    # build initial default mapping
+    dscp_to_tid = {}
     for dscp in [0, 7, 8, 15, 16, 23, 24, 31, 32, 39, 40, 47, 48, 55, 56, 63]:
-        check_qos_map(apdev[0], hapd, dev[0], addr, dscp, dscp >> 3)
+        dscp_to_tid[dscp] = dscp >> 3
+
+    # update the mapping based on the recommendations in section 4 in RFC8325
+    dscp_to_tid[16] = 0
+    dscp_to_tid[24] = 4
+    dscp_to_tid[48] = 7
+
+    for dscp, tid in dscp_to_tid.items():
+        check_qos_map(apdev[0], hapd, dev[0], addr, dscp, tid)
+
     dev[0].request("DATA_TEST_CONFIG 0")
     hapd.request("DATA_TEST_CONFIG 0")
 
@@ -127,9 +139,19 @@ def test_ap_qosmap_default_acm(dev, apdev):
     dev[0].request("DATA_TEST_CONFIG 1")
     hapd.request("DATA_TEST_CONFIG 1")
     Wlantest.setup(hapd)
+    # build initial default mapping
+    dscp_to_tid = {}
     for dscp in [0, 7, 8, 15, 16, 23, 24, 31, 32, 39, 40, 47, 48, 55, 56, 63]:
-        ap_tid = dscp >> 3
-        tid = ap_tid
+        dscp_to_tid[dscp] = dscp >> 3
+
+    # update the mapping based on the recommendations in section 4 in RFC8325
+    dscp_to_tid[16] = 0
+    dscp_to_tid[24] = 4
+    dscp_to_tid[48] = 7
+
+    for dscp, tid in dscp_to_tid.items():
+        ap_tid = tid
+
         # downgrade VI/VO to BE
         if tid in [4, 5, 6, 7]:
             tid = 3
-- 
2.38.1


