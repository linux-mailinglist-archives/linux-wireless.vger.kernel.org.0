Return-Path: <linux-wireless+bounces-27808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE80BB8E91
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4753B3C54
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E1205E3B;
	Sat,  4 Oct 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zUs9+cL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D36645
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587347; cv=none; b=NR6Ff3+WPHXWQJA+ofgE5m9faqQFWuwNFvFEdzwimwF8BMdm2eI6xKwH5NID3vnvM9WXTTLkAl/UdXEmLJ8falpo6Api3yu2d9f+Vyb8QDOroXAAyl+UEp/YypIxSxkdWDO5fERXIrnMW1qvWkRkR/asZuqAvehbHwgx6Hr4mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587347; c=relaxed/simple;
	bh=VwS6wD6aOQfO5N3l8LdCLUsFLqX6zsGd/ZTuPki6hFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DedDLZJpB3vGLYp6uLgZ5r/JgyPd97ksVMOKnRxEp9/wN0hObBlcPmz7incLB67F9IOurfbGLf4phQuUYXyQEcz/36B0ZOmUlButHjDPw8gRn/GTxm4cC+qJBE8xSEmObyyW4fspxghmOxXWdden/+gpcLai29Eu6958yOEGvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zUs9+cL5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso2580866f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759587343; x=1760192143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6aPg5XQM47KrBayeWfvz6FQ/94diyOyozYAwDrlP0Q=;
        b=zUs9+cL5MJdvCedvk6CzR4iLNX5WEqGhCVhFonwGjONZLkZwjlcX7Y4rnYQR/oEBm4
         Uq3xSeE7rT/XGHyvZEScFqeZm65ttUGUN1v0+/10pXgoO/9CONp7ulrxy9pkzE5QSrE7
         2UxH29kv5DQn8UNrHUbrqidttn+uDk5b32zLGEhQVuQXtpiX3TBZvugwCWjfO+IoAZxO
         HrBy2Kgt1Wt/ty82o9E4zNKoQQgDvfX5DcFEhc/vAxjjOp8CrH03/3w21/PNprDeIotn
         DXwa+iYCNGSSJOF1qK0xBWdrL21DDGtCUxSOJZlvmRikcXZ/w7Lk+OeoVcDJ8eh+fTaW
         JTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759587343; x=1760192143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6aPg5XQM47KrBayeWfvz6FQ/94diyOyozYAwDrlP0Q=;
        b=AAHHMEtbBqQGtDP9Vw8JSD9nZRnS/hoNKlxw+idbLM/blwNYVATTlaTSNan5Z20nB5
         RPK6/lcn1OY31ZMr+0AXDrwpqX6sH9OOTLyk7x9f7LNIn3VgUQ2kUj1Fr4yMga1EZdBr
         WXEliU7jdmtzdKf+iQmdFW/FuB5idTL7HnNdTNLu2Rn3rC2HD3X/hLCIYhD5VSxSJAZn
         f+U2HsKS8gyjkyhk4uLgTPx679kipYpZFsCzSTjQN4KcwYcrABN/DwLeF2ZeuBbYA3EW
         qLPEdusx027IlUIXHN9wy4uiI75Kdx3dymFnAmxaO57ihOj/MibX2ZrAuoJuSc7SvHyn
         Go+w==
X-Gm-Message-State: AOJu0YzPoNt9LK3p2MA2jsbz21qG5UKATByTA/+zCOSg8NMhd6Al1l/G
	rpeRkgkx9q38jivEYhwYZJ/wjxoImre2iFFuf8ee2SzL9ebd4OxojFEWi0ZZQIOPGOQ=
X-Gm-Gg: ASbGnctN1LxSf9QKQWn3UdMMKpCSTMrYuq2dOKkwE+t8pvzjdfCabLQv29bvyJf3nbl
	hT5f74I5DFOZzfXKoGsYNwYMgkKVadcli2MqDM+JH1Cn4k0d1mhtjiTWuG2ddxGxI57a9nGt3sc
	TLhe5HjRIlZlkU1NK/0GUtnt82z13Yr2RFUsgzPtpu6kxyXTOT1L0FSvFpyMHDQop8EuOmfILFh
	/dDa45cJCp88/+EdPiqEcSbQE53g++jaVewEs1XJBHvQua6DsabVT+5GQCIgJvtvgxUnU6VRrbu
	dpe42nUpWlp4FO42bYwfclh20AWwNQ/9/ymOKqGq4kGUgkhoQRHFFKw+b51NdUaPi4aVHZXUeIV
	xcnJOEdXXxT5FgXRRYJxv+qgByionhEolHLdVvPPd6jj/OQ4=
X-Google-Smtp-Source: AGHT+IFC3a01Q6okezr/1zEZE2FS4rppFre70olqqFb1+EYD+U645Zcdn6VsbgyCAgObBlX6vnCjfw==
X-Received: by 2002:a05:6000:605:b0:3ea:e0fd:2906 with SMTP id ffacd0b85a97d-4255d2ca8c1mr6718651f8f.23.1759587342381;
        Sat, 04 Oct 2025 07:15:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e6fc:e693:dd89:41a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm12357182f8f.12.2025.10.04.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 07:15:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilan Peer <ilan.peer@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD ver 6 and 7"
Date: Sat,  4 Oct 2025 16:15:39 +0200
Message-ID: <20251004141539.6512-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit e3fd06d1d8869747e02a022e3c9045a3187f3aa5 as it broke
wifi on my Thinkpad P1 (Intel AX210) in v6.17. I don't have a better idea
than reverting as - contrary to what the commit message claims - this
chip seems to still be using the commands removed by this commit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 48 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 14 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 535864e22626..d2db59615fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -328,6 +328,50 @@ struct iwl_dev_tx_power_cmd_v5 {
 	__le32 timer_period;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_5 */
 
+/**
+ * struct iwl_dev_tx_power_cmd_v6 - TX power reduction command version 6
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ */
+struct iwl_dev_tx_power_cmd_v6 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_6 */
+
+/**
+ * struct iwl_dev_tx_power_cmd_v7 - TX power reduction command version 7
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ * @flags: reduce power flags.
+ */
+struct iwl_dev_tx_power_cmd_v7 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+	__le32 flags;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_7 */
+
 /**
  * struct iwl_dev_tx_power_cmd_v8 - TX power reduction command version 8
  * @per_chain: per chain restrictions
@@ -372,6 +416,8 @@ struct iwl_dev_tx_power_cmd_per_band {
  * @v3: version 3 part of the command
  * @v4: version 4 part of the command
  * @v5: version 5 part of the command
+ * @v6: version 6 part of the command
+ * @v7: version 7 part of the command
  * @v8: version 8 part of the command
  */
 struct iwl_dev_tx_power_cmd_v3_v8 {
@@ -381,6 +427,8 @@ struct iwl_dev_tx_power_cmd_v3_v8 {
 		struct iwl_dev_tx_power_cmd_v3 v3;
 		struct iwl_dev_tx_power_cmd_v4 v4;
 		struct iwl_dev_tx_power_cmd_v5 v5;
+		struct iwl_dev_tx_power_cmd_v6 v6;
+		struct iwl_dev_tx_power_cmd_v7 v7;
 		struct iwl_dev_tx_power_cmd_v8 v8;
 	};
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6b76ce35443d..c64c599b1d78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -870,11 +870,17 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		len = sizeof(cmd_v9_v10.v9);
 		n_subbands = IWL_NUM_SUB_BANDS_V1;
 		per_chain = &cmd_v9_v10.v9.per_chain[0][0];
-	} else if (cmd_ver == 8) {
-		len = sizeof(cmd.v8);
+	} else if (cmd_ver >= 7) {
+		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
-		per_chain = cmd.v8.per_chain[0][0];
-		cmd.v8.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
+		per_chain = cmd.v7.per_chain[0][0];
+		cmd.v7.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
+		if (cmd_ver == 8)
+			len = sizeof(cmd.v8);
+	} else if (cmd_ver == 6) {
+		len = sizeof(cmd.v6);
+		n_subbands = IWL_NUM_SUB_BANDS_V2;
+		per_chain = cmd.v6.per_chain[0][0];
 	} else if (fw_has_api(&mvm->fw->ucode_capa,
 			      IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
 		len = sizeof(cmd.v5);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 44029ceb8f77..8274437b78be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1517,6 +1517,10 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
 		len = sizeof(cmd_v9_v10.v9);
 	else if (cmd_ver == 8)
 		len = sizeof(cmd.v8);
+	else if (cmd_ver == 7)
+		len = sizeof(cmd.v7);
+	else if (cmd_ver == 6)
+		len = sizeof(cmd.v6);
 	else if (fw_has_api(&mvm->fw->ucode_capa,
 			    IWL_UCODE_TLV_API_REDUCE_TX_POWER))
 		len = sizeof(cmd.v5);
-- 
2.48.1


