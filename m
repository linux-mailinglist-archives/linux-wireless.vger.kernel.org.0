Return-Path: <linux-wireless+bounces-36641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD+LJisJDGo5UQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:54:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B93B5786E2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8942830A5F25
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A023A0EA2;
	Tue, 19 May 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0VEa82e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5F39EF1D
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172845; cv=none; b=rv+iCobPEWe5Pa6xYRt6/5u7HaXY8TVMgc9gNASWOFeJqJzO6D1oAVXVsOmd5QmSBpaL2oo12BMJY+7q6O+1Hu7nid+ybVEgwaMxNrH9oS/0kfImtvzv/PMM+TIUVfhvntAvZu9h+B7UireiI8pAGpD779rtpMryZm5RCVl5P38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172845; c=relaxed/simple;
	bh=YcaBI/Mj3miKcjxOhFHlLj7Ldyc3x6oHF043u9+VBOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cG8PnPuaxtz2CFv+fEBdyIr98Ky7hiDXzyyw9g1Al3cUVbTIbyKeN/wxbQIoE4JhwlAOL75BCcmbgDA7tK3DMzTNKeyNeR11hgCczhHlZDs9/nrYZLG4OvJsEoB9bz+85Qet+lVVSj1fsXlQEq65sQy64S5Wa+lNdSaOqRhkcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0VEa82e; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172845; x=1810708845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcaBI/Mj3miKcjxOhFHlLj7Ldyc3x6oHF043u9+VBOc=;
  b=T0VEa82eX8HROg87yU/F9AQQ3kinmgjBuhHdV5LdMjZZs7bnaOf37oZN
   yTaU7yEj2orY3qTHycB2eaueEvqgz6VyUUW94RXjSyCK0X6JhrqGOhyWs
   qdNi6OzYM57U4Y91qp/39OWPrneZl2wklgy7v79HvsL9l8bidyfNCaeM1
   Ek+YcHdOvY8aWTLTVvKAqskWs1Q5jp/MzuW/fp6iEA5+lbcshJjhP8HsG
   b3j3NJpRpWB97ayUvgwtYte8EFS2CXxNW1CpFApZzWJlyPK1b9JFW/Cnn
   V4rFh8IMXpEh2BALBBgsZ2Ywm7APgW1DTGMgjnhRZFyG983btQ6+fi/z8
   w==;
X-CSE-ConnectionGUID: COXaKihxQ4CYPXAmE8F6Sw==
X-CSE-MsgGUID: NmbehFbIQd250ExOiYNwxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605678"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:44 -0700
X-CSE-ConnectionGUID: 9YEmMqMzSmyEcaxik3Ze2A==
X-CSE-MsgGUID: a25AYxeMQWeDO0yI6WSFTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227330"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 iwlwifi-next 15/15] wifi: iwlwifi: transport: add memory read under NIC access
Date: Tue, 19 May 2026 09:40:10 +0300
Message-Id: <20260519064010.549003-16-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36641-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 9B93B5786E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Add functions to be able to do memory read under NIC access,
in order to use them later during firmware dump. These may
drop and re-acquire the spinlock, but will not acquire and
release the NIC access.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20260517100550.7bb1ea51c347.I91420a24fb0c481c75a2600d60e1365c15c1c5a9@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  6 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 16 ++++++
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  2 +
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 54 +++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 5b44e15fe64d..0009488ca51b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -459,6 +459,12 @@ int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
 }
 IWL_EXPORT_SYMBOL(iwl_trans_read_mem);
 
+int iwl_trans_read_mem_no_grab(struct iwl_trans *trans, u32 addr,
+			       void *buf, u32 dwords)
+{
+	return iwl_trans_pcie_read_mem_no_grab(trans, addr, buf, dwords);
+}
+
 int iwl_trans_write_mem(struct iwl_trans *trans, u32 addr,
 			const void *buf, int dwords)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1ed6bcb7882c..3ae840e546e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -919,6 +919,14 @@ void iwl_trans_write_prph(struct iwl_trans *trans, u32 ofs, u32 val);
 int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
 		       void *buf, int dwords);
 
+/*
+ * Note the special calling convention - it's allowed to drop the
+ * internal transport lock and re-enable BHs temporarily, but will
+ * not release NIC access.
+ */
+int iwl_trans_read_mem_no_grab(struct iwl_trans *trans, u32 addr,
+			       void *buf, u32 dwords);
+
 int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
 			    u32 *val);
 
@@ -934,6 +942,14 @@ void iwl_trans_debugfs_cleanup(struct iwl_trans *trans);
 				   (bufsize) / sizeof(u32));	\
 	})
 
+static inline int
+iwl_trans_read_mem_bytes_no_grab(struct iwl_trans *trans,
+				 u32 addr, void *buf, u32 bufsize)
+{
+	return iwl_trans_read_mem_no_grab(trans, addr, buf,
+					  bufsize / sizeof(u32));
+}
+
 int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
 			    u64 src_addr, u32 byte_cnt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 24f8714eae9f..abc0c831d1ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1186,6 +1186,8 @@ u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg);
 void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val);
 int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 			    void *buf, int dwords);
+int iwl_trans_pcie_read_mem_no_grab(struct iwl_trans *trans, u32 addr,
+				    void *buf, u32 dwords);
 int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership);
 struct iwl_trans_dump_data *
 iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 50342604491d..1c4ee76d8387 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2424,6 +2424,15 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return false;
 }
 
+static void iwl_trans_pcie_resched_with_nic_access(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	spin_unlock_bh(&trans_pcie->reg_lock);
+	cond_resched();
+	spin_lock_bh(&trans_pcie->reg_lock);
+}
+
 void __releases(nic_access_nobh)
 iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
@@ -2506,6 +2515,51 @@ int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 	return 0;
 }
 
+int iwl_trans_pcie_read_mem_no_grab(struct iwl_trans *trans, u32 addr,
+				    void *buf, u32 dwords)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+#define IWL_MAX_HW_ERRS 5
+	unsigned int num_consec_hw_errors = 0;
+	u32 offs = 0;
+	u32 *vals = buf;
+
+	lockdep_assert_held(&trans_pcie->reg_lock);
+
+	while (offs < dwords) {
+		/* limit the time we spin here under lock to 1/2s */
+		unsigned long end = jiffies + HZ / 2;
+		bool resched = false;
+
+		iwl_write32(trans, HBUS_TARG_MEM_RADDR,
+			    addr + 4 * offs);
+
+		while (offs < dwords) {
+			vals[offs] = iwl_read32(trans, HBUS_TARG_MEM_RDAT);
+
+			if (iwl_trans_is_hw_error_value(vals[offs]))
+				num_consec_hw_errors++;
+			else
+				num_consec_hw_errors = 0;
+
+			if (num_consec_hw_errors >= IWL_MAX_HW_ERRS)
+				return -EIO;
+
+			offs++;
+
+			if (time_after(jiffies, end)) {
+				resched = true;
+				break;
+			}
+		}
+
+		if (resched)
+			iwl_trans_pcie_resched_with_nic_access(trans);
+	}
+
+	return 0;
+}
+
 int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val)
 {
-- 
2.34.1


