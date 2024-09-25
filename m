Return-Path: <linux-wireless+bounces-13161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474C998596B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E75F2818E4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD2185950;
	Wed, 25 Sep 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/iffEaN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6118594A;
	Wed, 25 Sep 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264336; cv=none; b=dA6om+UNXeTugCUPST/G/0KzZAoCy1WhsZ1xPmenEr+q6QUIefS6O4e4XthkQZg8wTtb0STBV81ER4WhdG+p/6GVYm+RVuU5pKODqDA+6KAJKnbl7m7WKWXHJmXQi0PTlXpmZ54BCkYJk8A4Y5UD2PeeBgHIMRgZDLDmLa2vFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264336; c=relaxed/simple;
	bh=vIT6N0MsGECIMwMYUxQhHmtXu8SZxomje8lsjE5St1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrYStJc+0z4r29MxRn3Vzq2NnG79uFc+vV6a3YgeSNxw2ZBHTr4mqoP4PSdDmK9yejyz69jaOF0C56Btbybzf3jupY/WPnBT2oRH5/zGPrirukjN/MjJsL4j3KlwW4WVQn9td8oKJGAV/vULle+fbI0jSPTmoo5gcGBP+Wy6Ya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/iffEaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DC3C4CECD;
	Wed, 25 Sep 2024 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264335;
	bh=vIT6N0MsGECIMwMYUxQhHmtXu8SZxomje8lsjE5St1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/iffEaNUOnQ7MiMXmB5e/2alepu255GGAZRWgHHi3d/uwH72XRA3kzip+Hi8olP1
	 yz+fMT3ke6cH5O2LIzayrWtzV0DQ8uSJWszPoQDC3CZQ1oj3tm5IZq1UF6zWYPOYtR
	 FWgGzcBu94BCJiiPXVFs5B5fWbvJXFL7Y/16GJFPZ3dh79V/zUwEoPfJxJmwTe3aCy
	 dSc6lkxHIsVLWEptOyItLFXpU4bXQscgY8h63h7bAzwW00f7P67e0OtuAO+QC/QXjC
	 MzTYJRQDxa2NLRmp75m/j1MY+3JXuXFvfCpV36MOuMd0B+ZxbRpU7JM/BEJB5XJY+g
	 xZuTtQXsCyoIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	dan.carpenter@linaro.org,
	daniel.gabay@intel.com,
	mukesh.sisodiya@intel.com,
	arnd@arndb.de,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 059/244] wifi: iwlwifi: allow only CN mcc from WRDD
Date: Wed, 25 Sep 2024 07:24:40 -0400
Message-ID: <20240925113641.1297102-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit ff5aabe7c2a4a4b089a9ced0cb3d0e284963a7dd ]

Block other mcc expect CN from WRDD ACPI.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240808232017.fe6ea7aa4b39.I86004687a2963fe26f990770aca103e2f5cb1628@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 5 +++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       | 2 --
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 8c8880b448270..a7cea0a55b35a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -357,6 +357,11 @@ int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 	}
 
 	mcc_val = wifi_pkg->package.elements[1].integer.value;
+	if (mcc_val != BIOS_MCC_CHINA) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "ACPI WRDD is supported only for CN\n");
+		goto out_free;
+	}
 
 	mcc[0] = (mcc_val >> 8) & 0xff;
 	mcc[1] = mcc_val & 0xff;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index e2c056f483c1c..c5bd89e61d4a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -45,6 +45,8 @@
 #define IWL_WTAS_ENABLE_IEC_MSK	0x4
 #define IWL_WTAS_USA_UHB_MSK		BIT(16)
 
+#define BIOS_MCC_CHINA 0x434e
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fb982d4fe8510..2cf878f237ac6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -638,7 +638,7 @@ int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 		goto out;
 	}
 
-	if (data->mcc != UEFI_MCC_CHINA) {
+	if (data->mcc != BIOS_MCC_CHINA) {
 		ret = -EINVAL;
 		IWL_DEBUG_RADIO(fwrt, "UEFI WRDD is supported only for CN\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 1f8884ca8997c..e0ef981cd8f28 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -149,8 +149,6 @@ struct uefi_cnv_var_splc {
 	u32 default_pwr_limit;
 } __packed;
 
-#define UEFI_MCC_CHINA 0x434e
-
 /* struct uefi_cnv_var_wrdd - WRDD table as defined in UEFI
  * @revision: the revision of the table
  * @mcc: country identifier as defined in ISO/IEC 3166-1 Alpha 2 code
-- 
2.43.0


