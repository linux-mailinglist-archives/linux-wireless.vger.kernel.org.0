Return-Path: <linux-wireless+bounces-33032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLY6CrgZsmmpIgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 02:41:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A8A26BF81
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 02:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A71630B9839
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D163336ECC;
	Thu, 12 Mar 2026 01:41:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE351A6832;
	Thu, 12 Mar 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279669; cv=none; b=FGwl19CXLRzkyap+kZ9zddum+seQfEmUqpCTtC7Ydy1fgc1n4P6svLnxUJJmCMGomh0yYRYuRMgsV5X5sfVhJnPlShoCKotdsVt2UofggJ88b65oVSaw3TBBERwlyKtyVSGCiV/jUWuAaRcRLSAo8LjaoFUBVR88dRkJqRJ6DX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279669; c=relaxed/simple;
	bh=yLo/YY+YfuQ6BSr+REO8tabywheEmVWKKoLtLuAIyHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHTXCJyD7OitbiO+6N3aADBZyK0u0M11e31Itd/oYGEEyeFrAUPsPEDHpD9x5SjZq72zI3Uv7qYR7eqDXvlkWIyr+df7mX7kcrAgkIOYW5K9DGq+zZzhfxRZoGolmzICgJF742ybWl2rBbKa6ymVEsGJKxXAyF7TcycH3pMYQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 83356ff41db411f1a21c59e7364eecb8-20260312
X-CID-CACHE: Type:Local,Time:202603120931+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:6ecbe081-bbc8-49f5-9a7c-2efdc8cfe5c9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:c01da53ef879e46a6af16c8db909bb4c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83356ff41db411f1a21c59e7364eecb8-20260312
X-User: liujiajia@kylinos.cn
Received: from iris.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 400210812; Thu, 12 Mar 2026 09:40:55 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] wifi: iwlwifi: use unique thermal zone type
Date: Thu, 12 Mar 2026 09:40:43 +0800
Message-ID: <20260312014043.13361-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33032-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57A8A26BF81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unloading iwlmld or iwlmvm can trigger hung task when two devices
using iwlmvm and iwlmld respectively on one setup. Their thermal
zones have the same type and share the same hwmon device created
by the first zone. The second zone indirectly holds the first zone
through hwmon and prevents the first zone from unregistering.
Tested with AX211 (8086:7af0) and BE200 (8086:272b).

INFO: task modprobe:5295 blocked for more than 120 seconds.
      Not tainted 7.0.0-rc2-up1 #2
Call Trace:
 __schedule+0x4df/0xfd0
 schedule+0x27/0xd0
 schedule_timeout+0xbd/0x100
 __wait_for_common+0x97/0x1b0
 ? __pfx_schedule_timeout+0x10/0x10
 thermal_zone_device_unregister+0x173/0x1c0
 iwl_mld_thermal_exit+0xbb/0xd0 [iwlmld]
 iwl_op_mode_mld_stop+0x37/0x120 [iwlmld]
 iwl_opmode_deregister+0xc0/0x160 [iwlwifi]
 __do_sys_delete_module+0x1b5/0x320

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c   | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-utils.h   |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c      |  6 ++++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
index d503544fda40..fe5fa5e59664 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
@@ -193,3 +193,13 @@ s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len)
 	return clamp(average_magnitude - i, -128, 0);
 }
 IWL_EXPORT_SYMBOL(iwl_average_neg_dbm);
+
+#ifdef CONFIG_THERMAL
+u8 iwl_thermal_zone_get_id(void)
+{
+	static atomic_t counter = ATOMIC_INIT(0);
+
+	return atomic_inc_return(&counter) & 0xFF;
+}
+IWL_EXPORT_SYMBOL(iwl_thermal_zone_get_id);
+#endif
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
index 5172035e4d26..84a4543fd290 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
@@ -55,4 +55,8 @@ u32 iwl_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
 
 s8 iwl_average_neg_dbm(const u8 *neg_dbm_values, u8 len);
 
+#ifdef CONFIG_THERMAL
+u8 iwl_thermal_zone_get_id(void);
+#endif
+
 #endif /* __iwl_utils_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
index f8a8c35066be..500028a4dbd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -5,6 +5,7 @@
 #ifdef CONFIG_THERMAL
 #include <linux/sort.h>
 #include <linux/thermal.h>
+#include "iwl-utils.h"
 #endif
 
 #include "fw/api/phy.h"
@@ -243,7 +244,6 @@ static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
 {
 	int ret;
 	char name[16];
-	static atomic_t counter = ATOMIC_INIT(0);
 	struct thermal_trip trips[IWL_MAX_DTS_TRIPS] = {
 		[0 ... IWL_MAX_DTS_TRIPS - 1] = {
 			.temperature = THERMAL_TEMP_INVALID,
@@ -254,7 +254,7 @@ static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
 
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
-	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
+	sprintf(name, "iwlwifi_%u", iwl_thermal_zone_get_id());
 	mld->tzone =
 		thermal_zone_device_register_with_trips(name, trips,
 							IWL_MAX_DTS_TRIPS,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 53bab21ebae2..ea8e616174db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -7,6 +7,9 @@
 #include <linux/sort.h>
 
 #include "mvm.h"
+#ifdef CONFIG_THERMAL
+#include "iwl-utils.h"
+#endif
 
 #define IWL_MVM_NUM_CTDP_STEPS		20
 #define IWL_MVM_MIN_CTDP_BUDGET_MW	150
@@ -652,7 +655,6 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 {
 	int i, ret;
 	char name[16];
-	static atomic_t counter = ATOMIC_INIT(0);
 
 	if (!iwl_mvm_is_tt_in_fw(mvm)) {
 		mvm->tz_device.tzone = NULL;
@@ -662,7 +664,7 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
-	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
+	sprintf(name, "iwlwifi_%u", iwl_thermal_zone_get_id());
 	/*
 	 * 0 is a valid temperature,
 	 * so initialize the array with S16_MIN which invalid temperature
-- 
2.53.0


