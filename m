Return-Path: <linux-wireless+bounces-14863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A899BB1B3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5091F23554
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED01C1AAA;
	Mon,  4 Nov 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ3yePr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8971C175C;
	Mon,  4 Nov 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717480; cv=none; b=aOrnnFqD0GzxX+t6rLVuJEQvym+2G669HOwV+X12/qJD+P73RmlNkcSmFCDvsWKIjv/uMMXgxKGBhtLbcHNg1BQHwYgguTBlI6sIYpCJ8r+Mqm84U8IENsAcjw18QVTnWJxeIefkjyawaV+FSZexBj3KbA5Rb2XDnfFS2CkfJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717480; c=relaxed/simple;
	bh=eTv+BagjGsivV3GsvBgWPcvHZVDbBPQm6e9T+apj65I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6eYyAr5EQXyH4TU3Dq+AeMR3T4j/dn3wAA6wcytX7GsAPuEg9ESQl1Y1aIvXSGAUY/T+xNDwBpyLFvPk4DpmsoDqexjimNs25SqT5VXN2nbl8cw3qGCHLYS5Yive+ERBD6rBCt6y6oorgJrZqM9yIlv5AOHfzllZgFyO/5luO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ3yePr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D3C4CECE;
	Mon,  4 Nov 2024 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717480;
	bh=eTv+BagjGsivV3GsvBgWPcvHZVDbBPQm6e9T+apj65I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQ3yePr9YliZ0OKC2mr3lk1ELlikBvu/vxoxB4fClHINRs83U/2uoR9vZlZM5w29s
	 bipbUi/nEpg1K3k2rK/w6tINW8PURxPY9dOd74KEkkYDuCuUBl/IS7S3PA60hxJ26N
	 Oj3ZEXSz9xlbfnEW9kKgLujtzAUMT+MGgqEg+4S0kJyI8t1ojNvs/HhTLXeObsvu5a
	 BxtAYvELuXTl3751fEdvuqF+zatosYQdifDW4AhkRvUprD2i9ryhFo6wlaS8gBXpxn
	 K4PxqGsT08p6SJuhACPt+Y1U50iliNmNAHveuuZCSmncR45jd3ric4yv3lt4j6zuDR
	 IadN2OV2/ikOQ==
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
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 11/21] wifi: iwlwifi: mvm: SAR table alignment
Date: Mon,  4 Nov 2024 05:49:47 -0500
Message-ID: <20241104105048.96444-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

[ Upstream commit 32d95ab330069f9c551b8e99770bb4e799730b55 ]

SAR table format in ACPI and local data base are different,
So modified code to read data properly.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241010140328.f077aced4dee.I4dc618f12d01f7ad19f9f8881f6e09eea77e9a14@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 96 ++++++++++++--------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index a7cea0a55b35a..0bc32291815e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -429,38 +429,28 @@ int iwl_acpi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	return ret;
 }
 
-static int iwl_acpi_sar_set_profile(union acpi_object *table,
-				    struct iwl_sar_profile *profile,
-				    bool enabled, u8 num_chains,
-				    u8 num_sub_bands)
+static int
+iwl_acpi_parse_chains_table(union acpi_object *table,
+			    struct iwl_sar_profile_chain *chains,
+			    u8 num_chains, u8 num_sub_bands)
 {
-	int i, j, idx = 0;
-
-	/*
-	 * The table from ACPI is flat, but we store it in a
-	 * structured array.
-	 */
-	for (i = 0; i < BIOS_SAR_MAX_CHAINS_PER_PROFILE; i++) {
-		for (j = 0; j < BIOS_SAR_MAX_SUB_BANDS_NUM; j++) {
+	for (u8 chain = 0; chain < num_chains; chain++) {
+		for (u8 subband = 0; subband < BIOS_SAR_MAX_SUB_BANDS_NUM;
+		     subband++) {
 			/* if we don't have the values, use the default */
-			if (i >= num_chains || j >= num_sub_bands) {
-				profile->chains[i].subbands[j] = 0;
+			if (subband >= num_sub_bands) {
+				chains[chain].subbands[subband] = 0;
+			} else if (table->type != ACPI_TYPE_INTEGER ||
+				   table->integer.value > U8_MAX) {
+				return -EINVAL;
 			} else {
-				if (table[idx].type != ACPI_TYPE_INTEGER ||
-				    table[idx].integer.value > U8_MAX)
-					return -EINVAL;
-
-				profile->chains[i].subbands[j] =
-					table[idx].integer.value;
-
-				idx++;
+				chains[chain].subbands[subband] =
+					table->integer.value;
+				table++;
 			}
 		}
 	}
 
-	/* Only if all values were valid can the profile be enabled */
-	profile->enabled = enabled;
-
 	return 0;
 }
 
@@ -543,9 +533,11 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	ret = iwl_acpi_sar_set_profile(table, &fwrt->sar_profiles[0],
-				       flags & IWL_SAR_ENABLE_MSK,
-				       num_chains, num_sub_bands);
+	ret = iwl_acpi_parse_chains_table(table, fwrt->sar_profiles[0].chains,
+					  num_chains, num_sub_bands);
+	if (!ret && flags & IWL_SAR_ENABLE_MSK)
+		fwrt->sar_profiles[0].enabled = true;
+
 out_free:
 	kfree(data);
 	return ret;
@@ -557,7 +549,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	bool enabled;
 	int i, n_profiles, tbl_rev, pos;
 	int ret = 0;
-	u8 num_chains, num_sub_bands;
+	u8 num_sub_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_EWRD_METHOD);
 	if (IS_ERR(data))
@@ -573,7 +565,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV2;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV2;
 
 		goto read_table;
@@ -589,7 +580,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV1;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV1;
 
 		goto read_table;
@@ -605,7 +595,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			goto out_free;
 		}
 
-		num_chains = ACPI_SAR_NUM_CHAINS_REV0;
 		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV0;
 
 		goto read_table;
@@ -637,23 +626,54 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	/* the tables start at element 3 */
 	pos = 3;
 
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAINS_REV0 != ACPI_SAR_NUM_CHAINS_REV1);
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAINS_REV2 != 2 * ACPI_SAR_NUM_CHAINS_REV0);
+
+	/* parse non-cdb chains for all profiles */
 	for (i = 0; i < n_profiles; i++) {
 		union acpi_object *table = &wifi_pkg->package.elements[pos];
+
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't
 		 * have profile 0).  So in the array we start from 1.
 		 */
-		ret = iwl_acpi_sar_set_profile(table,
-					       &fwrt->sar_profiles[i + 1],
-					       enabled, num_chains,
-					       num_sub_bands);
+		ret = iwl_acpi_parse_chains_table(table,
+						  fwrt->sar_profiles[i + 1].chains,
+						  ACPI_SAR_NUM_CHAINS_REV0,
+						  num_sub_bands);
 		if (ret < 0)
-			break;
+			goto out_free;
 
 		/* go to the next table */
-		pos += num_chains * num_sub_bands;
+		pos += ACPI_SAR_NUM_CHAINS_REV0 * num_sub_bands;
 	}
 
+	/* non-cdb table revisions */
+	if (tbl_rev < 2)
+		goto set_enabled;
+
+	/* parse cdb chains for all profiles */
+	for (i = 0; i < n_profiles; i++) {
+		struct iwl_sar_profile_chain *chains;
+		union acpi_object *table;
+
+		table = &wifi_pkg->package.elements[pos];
+		chains = &fwrt->sar_profiles[i + 1].chains[ACPI_SAR_NUM_CHAINS_REV0];
+		ret = iwl_acpi_parse_chains_table(table,
+						  chains,
+						  ACPI_SAR_NUM_CHAINS_REV0,
+						  num_sub_bands);
+		if (ret < 0)
+			goto out_free;
+
+		/* go to the next table */
+		pos += ACPI_SAR_NUM_CHAINS_REV0 * num_sub_bands;
+	}
+
+set_enabled:
+	for (i = 0; i < n_profiles; i++)
+		fwrt->sar_profiles[i + 1].enabled = enabled;
+
 out_free:
 	kfree(data);
 	return ret;
-- 
2.43.0


