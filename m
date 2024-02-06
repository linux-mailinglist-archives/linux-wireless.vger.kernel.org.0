Return-Path: <linux-wireless+bounces-3230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620584B899
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA025B30038
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5961339B1;
	Tue,  6 Feb 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQf5SZOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431013474B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231285; cv=none; b=T6ZO8scrdITtDZHwutnveNNMSHvNW3S/AUEJ17QSn44yckbc4DAsNQ6p9dxbCcMcHnD50YY8mdNMnEjENDCuRs/W2foj8C9h40v+MBfuuM/tWJZym3tDE61SAkajRkgTB+RwlxqHNNjBCWND0pSJMjcpIOVEwiKp5yaka0PJ/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231285; c=relaxed/simple;
	bh=6O1y6Qmi/IMLrZ21sKCvCQMcOzC2jHDEHub++mAi2xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llNyTEjouhgmJbqyzaeEMhUujydJPk3p4gWjP/l6sTwyf5RbM5zqQ9+sReNoKmKoKgqLZBmM452Ru+Mli+Js6oG1gmZyx89URA4XqDaZHbLTGRl+qFb2sdes2bAFx2T97Wdq/NsB1Z7Pw9Y5BjZK9BqSEDHLYp7qZQ2HaNvKTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQf5SZOH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231284; x=1738767284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6O1y6Qmi/IMLrZ21sKCvCQMcOzC2jHDEHub++mAi2xc=;
  b=RQf5SZOHkj3AGoWn2YDl0YRcnpi3y17zKzgpigBPBeUXheEbpzt6GTpp
   CYgU05xhPWq3r2a609GfuIbD8Rcy8DZZjBCNM4rjrTNFOBM2ldZnhrwBp
   j5CBWJTGFA3l6fZApfu+zABHEWb5bgTGJNAzXp4uwhcmZI6j1fteM7yJN
   CjdcSr4bpJXw0HWxieB1ZxEU5AFI2RGPiDUnK2v66UEGCbIrwGo0BPJC2
   68auhmykRkpXJO8LaSuMg/K0oQN9eM/p2iKzbv0Y2WtYF1AWVEEsAM/Ii
   N3r1dJ/+hsuc415Uh7XvphGW2dUu+igRvLMM2/eLSDWxaKYVN3XyIrILF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917836"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917836"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197967"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197967"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 8/8] wifi: cfg80211: report unprotected deauth/disassoc in wowlan
Date: Tue,  6 Feb 2024 16:54:11 +0200
Message-Id: <20240206164849.a3d739850d03.I8f52a21c4f36d1af1f8068bed79e2f9cbf8289ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

Add to cfg80211_wowlan_wakeup another wakeup reason -
unprot_deauth_disassoc.
To be set to true if the woke up was due to an
unprotected deauth or disassoc frame in MFP.
In that case, propegate WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 5 ++++-
 net/wireless/nl80211.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69e50bc2aa43..e154218ebc39 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3590,12 +3590,15 @@ struct cfg80211_wowlan_nd_info {
  * @tcp_connlost: TCP connection lost or failed to establish
  * @tcp_nomoretokens: TCP data ran out of tokens
  * @net_detect: if not %NULL, woke up because of net detect
+ * @unprot_deauth_disassoc: woke up due to unprotected deauth or
+ *	disassoc frame (in MFP).
  */
 struct cfg80211_wowlan_wakeup {
 	bool disconnect, magic_pkt, gtk_rekey_failure,
 	     eap_identity_req, four_way_handshake,
 	     rfkill_release, packet_80211,
-	     tcp_match, tcp_connlost, tcp_nomoretokens;
+	     tcp_match, tcp_connlost, tcp_nomoretokens,
+	     unprot_deauth_disassoc;
 	s32 pattern_idx;
 	u32 packet_present_len, packet_len;
 	const void *packet;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 40b4405d15bd..358dae67924d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19852,6 +19852,11 @@ void cfg80211_report_wowlan_wakeup(struct wireless_dev *wdev,
 				 NL80211_WOWLAN_TRIG_WAKEUP_TCP_NOMORETOKENS))
 			goto free_msg;
 
+		if (wakeup->unprot_deauth_disassoc &&
+		    nla_put_flag(msg,
+				 NL80211_WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC))
+			goto free_msg;
+
 		if (wakeup->packet) {
 			u32 pkt_attr = NL80211_WOWLAN_TRIG_WAKEUP_PKT_80211;
 			u32 len_attr = NL80211_WOWLAN_TRIG_WAKEUP_PKT_80211_LEN;
-- 
2.34.1


