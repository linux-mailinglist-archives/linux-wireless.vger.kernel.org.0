Return-Path: <linux-wireless+bounces-24325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C002FAE32CA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B63416EAF3
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E46136;
	Sun, 22 Jun 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3ANjxNa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10F21C187
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631154; cv=none; b=DKc7LnFjy3VuVHVhPHUIpkoQPpXeVWu7uZexxeUNmpHJRtvLWCUXRHPjvTc8FwmJNusxsqUWHZib46jvcKaMJXp2QmJFIC8Krk7I9BrdMIAuAO7dc60BdQUylXesjc3JMgymnOoBVNrPNvnlJmaUDog9l8q87o+PlafLXg0YiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631154; c=relaxed/simple;
	bh=9YD86E+kVFrUWNkttCTRoXa6NGoCuyuoPE4wdZs+VBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjU1a12keC8EWamJV2t7UUS1TMinLECHBk+PyBV+qQIWHa+LXInptuk/mi0EwoI1GhtN9Gy+F5hlzS4XO7OkrkXVmlcV87S+UZKb4BL/A7JBgdmemww19QjT+UcHJdcLY1g3rQiQJeG48911cg77RtZdSDopoh9GV0k19hLYUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3ANjxNa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631153; x=1782167153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YD86E+kVFrUWNkttCTRoXa6NGoCuyuoPE4wdZs+VBM=;
  b=X3ANjxNaAJ3ZWI9V/+D6zDFxMCKkTTEuJyBaCg/Dvdeqbmqi0zZjfPW9
   fL8AAAZ8ytRszY59zAsFrmvOvdJm/URx47DTuZJKODxHIihq8ZB1nTq5S
   CNk9L2T8E5l/f6rbfRySQMHTvFKnMseOJNFqBEY6u8duWL9tpIkG3iffL
   ClubI0+0cs12oRRm1Yq/ebPj9bBFBNF7RFq67CowvUHJDj6ErPE+5TBa0
   iMnlqBTVkbmdlUU3rHpHkHqO2iTKwpPMjaL99J0YWj17JD5VWsOszJkhB
   Lq9Q68uWwlyvuWiKV+GmD1xhMS4IBhqsutOsEE0TOeGpryq7p0l/WQCob
   A==;
X-CSE-ConnectionGUID: CODrcW83QLKP+idKLaoY9Q==
X-CSE-MsgGUID: Kg3NY0s5ReGCCTVYG+6hOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916082"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916082"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:53 -0700
X-CSE-ConnectionGUID: kgbtmvokTI6bZtBBDR5TgQ==
X-CSE-MsgGUID: qhjnJ/q+RG2RXa1HKSr0xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295740"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:51 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 3/5] wifi: nl80211: Add NAN Discovery Window (DW) notification
Date: Mon, 23 Jun 2025 01:24:42 +0300
Message-ID: <20250622222444.356435-4-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This notification will be used by the device to inform user space
about upcoming DW. When received, user space will be able to prepare
multicast Service Discovery Frames (SDFs) to be transmitted during the
next DW using %NL80211_CMD_FRAME command on the NAN management interface.
The device/driver will take care to transmit the frames in the correct
timing and flush the queues upon the termination of the DW.
This allows to implement a synchronized Discovery Engine (DE) in user
space, if the device doesn't support DE offload.
Note that this notification can be sent before the actual DW starts as
long as the driver/device handles the actual timing of the SDF
transmission.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/uapi/linux/nl80211.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f2d4a2007463..134cea046bd0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1347,6 +1347,11 @@
  *	control EPCS configuration. Used to notify userland on the current state
  *	of EPCS.
  *
+ * @NL80211_CMD_NAN_NEXT_DW_NOTIFICATION: This command is used to notify
+ *	userspace about the next Discovery Window (DW). Userspace may use it
+ *	to prepare frames to be sent in the next DW. %NL80211_ATTR_WIPHY_FREQ
+ *	is used to indicate the frequency of the next DW.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1607,6 +1612,8 @@ enum nl80211_commands {
 	NL80211_CMD_ASSOC_MLO_RECONF,
 	NL80211_CMD_EPCS_CFG,
 
+	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
-- 
2.49.0


