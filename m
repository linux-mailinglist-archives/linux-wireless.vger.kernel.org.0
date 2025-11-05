Return-Path: <linux-wireless+bounces-28602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAFC3587C
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B369F3AF708
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367C3101C9;
	Wed,  5 Nov 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMADRWc7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8D30F957
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343411; cv=none; b=FDK1AexNE7SyY04vCEjep+TaGD2yJBPrluovzS9Nzy8FKHx9aKv5PYXd6w5mv8FD1a0peo1OVQ2xQD4NpZWkQbQcCE+ryZ6EwO3jsbIjsk9utdB/BGGzR0UfvycGQt+RaaSu8+vlGCoPn6AtTiwkwndIUPR8L6ggCFaFeiCg6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343411; c=relaxed/simple;
	bh=MHbng6srjLWyY3isFngCuEsAZy+dOOpmHyWZUgmX/bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B/lyfl/CG0I11PqzV893xFb5cz2JBa7/M+i9Z3B4kOyZcF3V3FM9dhMVyJ31p8LiKVsYAKe/CzWRfMeoJJUIiY2vXN4dlhK4yavIuL56K6gKL4Mw040TaTBXpd/nWL5FRdVyxBRo/YQVxjrIiKV+OnlD96FYGnaV6xn6M3vAi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMADRWc7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3402942e79cso9037548a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 03:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762343409; x=1762948209; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjlBcVA0fwgfcOgXPYN9Hid6rAR5JqFICSTBhL/k5AU=;
        b=CMADRWc7R1lfs0D662kXOGv83isuKKIwJaTZj8NhDhxLySJ0vumTRWpupG8WETe6Jb
         X5aybOOuMKFkSyHOTKrF8FXqvBRsG2SG3BGv+2xuSB+WG+y5UiDiMRPWDTm34L65qiCl
         tSIhdF383JFPIjj777ICM/YhKV7FpbE/b5QhcUGtRBu6fl35yUMsAPsLStPfQJocC13P
         qCTbm4MzgBaE2pgUEXWKT/BO+5FXdqY+4akc5JVxw4e93/nIMPMjWsZ0CnbrBQoeuqpU
         2FgmloRVtiJm4hiWNuW2rjO8RDNHWEwuyGn9vPq86q+LwEVRtPqwzExEU43g9E8w9/Yk
         VKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343409; x=1762948209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjlBcVA0fwgfcOgXPYN9Hid6rAR5JqFICSTBhL/k5AU=;
        b=JiaiaY0ebWbPRrG6j7jeSrmS43WeGzeRI0k9XEVQztqhI2cF52xw4Vf66fP+OiiKEn
         L046YaKdmEwgzPzzCcStgCettm+A5lNVWTVsHdbS2Y4k/dpQneLWAzsW7dkIj6IyAgKn
         G78LW4IwT1nQfb0gKWVhG3GAAi9QBgpipz27vU1iSBCZkJBxaoebVossaqCrXJ39yTAY
         6e87fEDWMP5QEoRz+ZtJdQe4oOfY5a/UpHvfOoOO2m3ymLn8gcxwPPXZ3r4d5nRudslz
         nIM5E/Y7zzrguXQoBixOi3TH/HpPS+MdkGB4auvGwhvFCRRVxarcv9/frU4KCFf3BsgC
         BIsA==
X-Gm-Message-State: AOJu0YzbohDDxAYnmNU8Rawm8KVrruOPpUMydxlTW3wyl3MQTYLBkmyp
	Z3MRpW4I25ml35GNlD8KkrpNWDrvwcinevdUchGo/GMiCbkYpwP7XGG3
X-Gm-Gg: ASbGnctqWGVjwL1+b8MA01dO1MEIcv7/S/MrbNsyMSSCnxEIfovgkTKZ8Wv353Hec04
	p7IF8edD4BfV4txuWpZEv2B9KRLHxwuddkwv/cWauFcdqyOPYxVhvSdRWIKEa3XbNHALI8KcXT2
	vgPcfYJicccIEQY1ZjKlsoOJUp9kFY6fWzgMwwdNf3kH7aqd/v4Y67Fjww0yge1gftA2XEGNkyx
	VuHQgqobvdDUvzg+wVu92xdBvTVPEnp8TogKJtzfKPcRw4+CC3E1sSza14OE0EXlEcMAhXFIrYy
	4+7me5a1DpJOVdOTlPKbr1lb1xebIutpGxM5jGTKyYqsw2cskHEUeLTZZ8yOeM+qE0ddysRfpiU
	utyNT1JtOrc9IrpRLVIjwpQu/Px2RVA/lUbTsDKtpE6Jl50iOEBxWrc9kWpY4je/yBB9+Vm1TGf
	43
X-Google-Smtp-Source: AGHT+IHdUXKuWWISPi0q/licRMZ6Bx4YcC7Akip5kI5n3mrpw2TZuTHVRv+6VFth21ABY/rXx6TKUA==
X-Received: by 2002:a17:902:dad1:b0:295:8da5:c634 with SMTP id d9443c01a7336-2962ad835bemr33691215ad.9.1762343408930;
        Wed, 05 Nov 2025 03:50:08 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:54cc:cfa8:7cce:97b5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5254850a12.10.2025.11.05.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:50:08 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 17:20:01 +0530
Subject: [PATCH] net: wireless: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-wireless-v1-1-6c850a4a952a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOg5C2kC/x3NwQrCMBBF0V8ps3agKVbFXxEXafNiH5Qok7SKp
 f9ucHk2926SYUSWa7OJYWXmM1W4QyPj5NMDylAtXdv1zrW9+glYdUlMLPQzvwgaDVBfiumbhhk
 56xBwPh3jgIsbpcZehsjPf3S77/sPO1TKEHgAAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=MHbng6srjLWyY3isFngCuEsAZy+dOOpmHyWZUgmX/bk=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5Ld/yJc1rO3l93pqEQosd+hcCzIMv1W7IffB8n3LY3
 3upilPedpSyMIhxMciKKbIwikr56W2SmhB3OOkbzBxWJpAhDFycAjCRDbaMDOeT3l/c0rcirn7C
 81NXPf4r9IdWrz5jZKwQtICRR+X3kvcM/yNWyLFNNHfn+NMTeKtG8OBdrrCsRTc3mSVfOSYunsF
 9mhMA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

wireless doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 16 ++++++----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633e0d51194d818d479349e7c502201..7fcd76f2ef8e373f16c09ed16ade1ef16ccf6bed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -818,11 +818,11 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 
 int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
-	struct uefi_cnv_wpfc_data *data __free(kfree);
 	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
 
-	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
-					      "WPFC", sizeof(*data), NULL);
+	struct uefi_cnv_wpfc_data *data __free(kfree) = iwl_uefi_get_verified_variable(fwrt->trans,
+		IWL_UEFI_WPFC_NAME, "WPFC", sizeof(*data), NULL);
+
 	if (IS_ERR(data))
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..515728b8cacf4004a121183cc93ab28b17b3bdc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -592,7 +592,6 @@ iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 				 struct iwl_rx_packet *pkt)
 {
 	const struct iwl_wowlan_info_notif *notif;
-	struct iwl_wowlan_info_notif *converted_notif __free(kfree) = NULL;
 	u32 len = iwl_rx_packet_payload_len(pkt);
 	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mld->fw,
 						      PROT_OFFLOAD_GROUP,
@@ -609,10 +608,10 @@ iwl_mld_handle_wowlan_info_notif(struct iwl_mld *mld,
 							5))
 			return true;
 
-		converted_notif = kzalloc(struct_size(converted_notif,
-						      mlo_gtks,
-						      notif_v5->num_mlo_link_keys),
-					  GFP_ATOMIC);
+		struct iwl_wowlan_info_notif *converted_notif __free(kfree) =
+			kzalloc(struct_size(converted_notif, mlo_gtks, notif_v5->num_mlo_link_keys),
+				GFP_ATOMIC);
+
 		if (!converted_notif) {
 			IWL_ERR(mld,
 				"Failed to allocate memory for converted wowlan_info_notif\n");
@@ -996,8 +995,6 @@ static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
 			      struct iwl_mld_wowlan_status *wowlan_status,
 			      struct ieee80211_vif *vif)
 {
-	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
-
 	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
 
 	if (!wowlan_status->num_mlo_keys)
@@ -1785,7 +1782,8 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 			   struct ieee80211_vif *vif,
 			   u8 ap_sta_id)
 {
-	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree);
+	struct iwl_proto_offload_cmd_v4 *cmd __free(kfree) = kzalloc(sizeof(*cmd),
+		GFP_KERNEL);
 	struct iwl_host_cmd hcmd = {
 		.id = PROT_OFFLOAD_CONFIG_CMD,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
@@ -1793,8 +1791,6 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 	};
 	u32 enabled = 0;
 
-	cmd = kzalloc(hcmd.len[0], GFP_KERNEL);
-
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_mld_wowlan_data *wowlan_data = &mld_vif->wowlan_data;

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-wireless-bde764fbe81c

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


