Return-Path: <linux-wireless+bounces-12438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C2296A987
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CB0B22791
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F551EABB7;
	Tue,  3 Sep 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MURAwJWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31B1EAB8C;
	Tue,  3 Sep 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396514; cv=none; b=jUpCmiz3xBgVNkL6/HHI1NN8758TA/eBgDkwdeZT4VFIX0kd9mChFuZHd2Er2H78h5+JYSqsn+OCDJdyF2u/qQPgUF6snYP/LzI8nIhP5hs9gfmOBN8T/DrixaX4YicDOpYLS9c4pylAM0x9l9TRuHcFMqy5w4/I8NXL7k+50Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396514; c=relaxed/simple;
	bh=KKQM2JMxzdGKuzo4eSwOG98rPqiEwFz4U44P04ZfDyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqM3M/LH3JKq+T+vG/Hfg0p0Vpu5qE3IG8vGTEdHwTCnZTARHh9UHBZ4oUaJpadGXej5RlRMNGjPovoNm/9g0NwG4DSWhaImJPU+10tWqPxK4Q/5Nc0m73OWpSrWqNb9MtR95LbjveDuoecmy0OqxTivjvluvEvYTLk9VzxK480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MURAwJWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B008C4CEC5;
	Tue,  3 Sep 2024 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396514;
	bh=KKQM2JMxzdGKuzo4eSwOG98rPqiEwFz4U44P04ZfDyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MURAwJWvSHnhHxh3dP6zmKpfiyN61HYv8LXQmR37zCeQvzQF1thw2+l3JKeYwPw8P
	 VD81IajUhU+VenYSV+5/f/HmWtw1O9j4YUkC+1lsM4xG1fdOeOjGOVfVhMWuWXqUMo
	 dZ9xnUHr5X1e1r3VkdFM12gAGoITsNtl3lqJPb0w02pAlN1RgQ0DqB9u+BR+wUiA7U
	 UzfIOfZIN8Kob2zkLUbcpDVvTgMdIt7eRW/nAvZD8s5FBPLId96xNP+ubYBZNZ/1jQ
	 AFYcUdXOmVOEFZC4B/lAIokutvWMDrDHLM/fFLMkQ2kbEM/XbhvfxETkVY27z5nB3J
	 Jbrb1DBBZwi0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ayala.beker@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/8] wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()
Date: Tue,  3 Sep 2024 15:28:43 -0400
Message-ID: <20240903192859.1108979-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192859.1108979-1-sashal@kernel.org>
References: <20240903192859.1108979-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 916a5d9c5354c426220a0a6533a5e8ea1287d6ea ]

Driver creates also the WFA TPC element, consider that in the
calculation.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.e710ce446b7f.I2715c6742e9c3d160e2ba41bc4b35de370d2ce34@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3a58267d3d710..4d1fdc7447ee4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -93,6 +93,8 @@
 /* adaptive dwell default APs number in social channels (1, 6, 11) */
 #define IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL 10
 
+#define WFA_TPC_IE_LEN	9
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -378,8 +380,8 @@ static int iwl_mvm_max_scan_ie_fw_cmd_room(struct iwl_mvm *mvm)
 
 	max_probe_len = SCAN_OFFLOAD_PROBE_REQ_SIZE;
 
-	/* we create the 802.11 header and SSID element */
-	max_probe_len -= 24 + 2;
+	/* we create the 802.11 header SSID element and WFA TPC element */
+	max_probe_len -= 24 + 2 + WFA_TPC_IE_LEN;
 
 	/* DS parameter set element is added on 2.4GHZ band if required */
 	if (iwl_mvm_rrm_scan_needed(mvm))
@@ -776,8 +778,6 @@ static u8 *iwl_mvm_copy_and_insert_ds_elem(struct iwl_mvm *mvm, const u8 *ies,
 	return newpos;
 }
 
-#define WFA_TPC_IE_LEN	9
-
 static void iwl_mvm_add_tpc_report_ie(u8 *pos)
 {
 	pos[0] = WLAN_EID_VENDOR_SPECIFIC;
-- 
2.43.0


