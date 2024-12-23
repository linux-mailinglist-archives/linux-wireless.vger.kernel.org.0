Return-Path: <linux-wireless+bounces-16708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27249FA8FE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3E7A1B3B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31D12C544;
	Mon, 23 Dec 2024 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Zx5TZljH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501D262BE;
	Mon, 23 Dec 2024 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917534; cv=none; b=HE/GZI9WrvZuL6roim8eV7O4Pf8RXyVy6OKxLhS9SPYI7oSuksi15MXjpzLv0cVUA6kcri5APMk0X91STgrGI1ePs1wFSDuJNZvK1CMz3Q5INzR5wJffo/tdBR4+JzmnSqIcx0EWU3ptXN6u367hJ3Kcra0Ty/kqvCVhENq+IFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917534; c=relaxed/simple;
	bh=uXLVM9n8W8ad+KEFF+20ysZZCeuodmO8jgM3QpGJNhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA7Os1VeMizDgQXvelRR2f2bkPPWKXzBdVrbuTPV/pq/Wy+M3tmzvuCBKs2R0DiYwggq3vXQva8OJx5HrzNQYbyH7vZlGbiQIQfe1f66bxX1aZEaJAZPiJr4Asp0ZK0PyW/FszAQ94DLyclF0watImmCI9W/jmi++Et/+Jt0aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Zx5TZljH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=eVxfIjX2CU61sdqSTaIXYCFXZ0dqH+ONOzFz5dfRp5s=; b=Zx5TZljHHNlRBfwR
	5G+JQUlF1ixiMQCH4d7f7VaimVHNRcIoszYdtGYg1d4JVDwm/VHGzljFW4yy/IdyH4C+hVQFsXFMx
	Q0G4HV/EZqdEciCTzaOKi+CTZbiNbaE55hOgQkL9b+c7Hiz/18EtdwlcqxVnDsaHQ4457DHA2Kp/8
	Y8RIk+2dkPC9dN9B4H+QEG2+MqpvNKajLGrzVfpfZZHCCV+3tgNjEY+MyYQIDecqOJfvgZw+cc5wN
	DHKk8fGtUdftnlgSsASeQjIzXZLSNODZT+pCTDBynXVFKX9OycjIPgDGKys524jcei6UdLyCsUNEC
	0p84rzo4HOK0leUa+A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIm-006oGv-0u;
	Mon, 23 Dec 2024 01:32:08 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 6/6] iwlwifi: Remove old device data
Date: Mon, 23 Dec 2024 01:32:02 +0000
Message-ID: <20241223013202.340180-7-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of iwl_ax204_name[], iwl_ax221_name[] and iwl_cfg_so_a0_ms_a0
was removed by
commit f473a7fd6d60 ("wifi: iwlwifi: remove devices that never came out")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 8 --------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 3 ---
 3 files changed, 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 2e2fcb3807ef..130b9a8aa7eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -205,7 +205,6 @@ const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
-const char iwl_ax204_name[] = "Intel(R) Wi-Fi 6 AX204 160MHz";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 975e8aed1526..ba4838a48628 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -199,7 +199,6 @@ const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
 };
 
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
-const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
 
@@ -267,13 +266,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 	.trans.low_latency_xtal = true,
 };
 
-const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
-	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_ma = {
 	.fw_name_mac = "ma",
 	.uhb_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e17fadfc0227..77c8fb740bb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -524,7 +524,6 @@ extern const char iwl9560_killer_1550i_name[];
 extern const char iwl9560_killer_1550s_name[];
 extern const char iwl_ax200_name[];
 extern const char iwl_ax203_name[];
-extern const char iwl_ax204_name[];
 extern const char iwl_ax201_name[];
 extern const char iwl_ax101_name[];
 extern const char iwl_ax200_killer_1650w_name[];
@@ -540,7 +539,6 @@ extern const char iwl_ax211_killer_1675i_name[];
 extern const char iwl_ax411_killer_1690s_name[];
 extern const char iwl_ax411_killer_1690i_name[];
 extern const char iwl_ax211_name[];
-extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_fm_name[];
@@ -647,7 +645,6 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 
 extern const struct iwl_cfg iwl_cfg_bz;
-- 
2.47.1


