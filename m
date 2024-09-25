Return-Path: <linux-wireless+bounces-13182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17752985CB7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31201F21C79
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12118A6C4;
	Wed, 25 Sep 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHANmOqD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622413D520;
	Wed, 25 Sep 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265622; cv=none; b=MM91RlDFYbFCI+9FAsmOjdApzAQhKmTrspwWcQw646nm+HAxiZFEaTXWrdTgLxciC/2hcNk0QyagjSCbJHp7sIJuzZffREA/4CxT3VciEk+THkzTXDGGfONS/XE6EqBkLrOjdVUtP7iOBolw2dx0txFc2hYXfGnmaXFyIW8P44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265622; c=relaxed/simple;
	bh=y53wtsUn2HG6tdkyQ5fHyz1/mgyKQu04rLSXx2Rpm1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyIp0KrRV8hfbQT1HAaWHfjFOYoW/eZOcDBjsq2moUuEgGBvl7RLlPnyJYLPp6utGDQXwJjjeN2Prr6Pv9kJIbqcjnC72pqTWVMpLeg26o5HJ7IQIwhkXWJ8WtIJU8Ovc32xmCPB8zaAKmvRPGi+QtSoackFGe8cDhFHQQJBD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHANmOqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E59C4CECE;
	Wed, 25 Sep 2024 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265622;
	bh=y53wtsUn2HG6tdkyQ5fHyz1/mgyKQu04rLSXx2Rpm1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHANmOqDo4lNOS5vv5TJTKTXNwMd54YjrR6+jtmbPBkeWIoh26bPu32IeZJZKVLs4
	 oCH8lQGZtRBSlvXBBngTkpKEcX9ReWJ4AZj2KOtOtH8CbA3W8e8WXJRfem83u/6Pwz
	 VJ775qHRnrfyCjMYaI4s+KfzeJqxIYpNpfkM/E9NZxF6YIWBsdtaxNivqgcjUksOZx
	 rOBwhPDK5GEGpVMXoPTEDY9j+TDaxYjPTe8ACVAe9xziXM3AlezyeKB3NHjghg0A4J
	 qKMX4MxQh3c9Vgbuew9RzJp+QfcT0tcvZBxWfIbm4AN4qOAPZjTtlYcgvWr1d7+SFa
	 RJBPF5/ppeD6A==
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
Subject: [PATCH AUTOSEL 6.10 050/197] wifi: iwlwifi: allow only CN mcc from WRDD
Date: Wed, 25 Sep 2024 07:51:09 -0400
Message-ID: <20240925115823.1303019-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index ba9e656037a20..9b3d3405fb83d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -356,6 +356,11 @@ int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
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
index 633c9ad9af841..ecf482647617c 100644
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


