Return-Path: <linux-wireless+bounces-12034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9E9604BC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8111F21AA2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B319644B;
	Tue, 27 Aug 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YTSGiMWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCE1714A8;
	Tue, 27 Aug 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748267; cv=none; b=Ylt7H48KnJGWyDcKOsIadnnlgLXrwzkGxOTxRU7LcxYAeCoSPjn45OEE1beTJ4GI1TT2nyUBbl0o2OjtoduXDLuqVTW+nKqd1HYQKZj5YnJ96fvUIawkXP6YFRH7hVzcKvo/qwMvw/kFPbHW2hTMqkUmKQQ0x1nAKyQDvFuirz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748267; c=relaxed/simple;
	bh=StXru7EHwI5/gpRagbvwB77A2UW9Fs27pgmipO98z6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hbLwxwCW5l5EuEuSEexAE3H+hJWO3YkmxGI+BSkbioO8exTN+KHDprbeEnHBNyUKArSi+se8YTkLxNR8dlFL/e+SC+3i2DZ1p4QVXw5ct+cmK6syGhkMo/zJvZtKCQKVENaoaC0NdtnBiJaBpO/LjV0INKTOgD3BcSvXyKiVfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YTSGiMWx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AJMDb
	XVZKNDuUogjILs4lsGwqWb6Fx1ewkq0VUXwj5M=; b=YTSGiMWxa0gk/JbMkod3d
	7OL6S6U3c5Ks7/MBe24IzJAMHOp5koGKukHOwtXXyFlLa9BvJoq1qvzQsyh00Wq3
	cAnXYFhs7CXtKqM2/0IdNffqh75y2ggzpdPuEa4NnR8k6jGMeq7yHl1UX9CZ/2BY
	TkZyRQ3zdW4QqSBLiwTiSQ=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgBHmyCrkc1muhMXAA--.5975S4;
	Tue, 27 Aug 2024 16:43:39 +0800 (CST)
From: David Wang <00107082@163.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	dan.carpenter@linaro.org,
	daniel.gabay@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] wifi: iwlwifi: acpi/dsm: cache error retcode for iwl_acpi_get_dsm
Date: Tue, 27 Aug 2024 16:43:18 +0800
Message-Id: <20240827084318.5169-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sCgvCgBHmyCrkc1muhMXAA--.5975S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWkWw4rAr47uFykXF4kCrg_yoW5Cr45pF
	4j9a12kryDXa1UJ3Z3tF4Sywn5GanrW398CFZrG343Zr1kJw1SqFW5WF12va10vw1UJay3
	uF47tF4jkrnYvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJKI_UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxtIqmXAncs1HgAAsS

On some HW, acpi _DSM query would failed for iwlwifi device
and everytime when network is reactiaved (boot,
suspend/resume, manually restart network, etc.),
bunch of kernel warning shows up together:
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
  ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
since iwlwifi would make 8 acpi/dsm queries for lari config.
But for iwlwifi, it is safe to cache the _DSM errors,
since it is not possible to correct it without upgrading BIOS.
With this patch, those kernel warnings would only show up once when
booting the system and unnecessary acpi/dsm queries are avoid.

Signed-off-by: David Wang <00107082@163.com>
---
Change since v1:
 - make acpi_dsm_func_retcode cache per device.
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c    | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 79774c8c7ff4..22dfce6d5111 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -169,6 +169,10 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
 		return -EINVAL;
 
+	/* If HW return an error once, do not bother try again. */
+	if (fwrt && fwrt->acpi_dsm_func_retcode[func])
+		return fwrt->acpi_dsm_func_retcode[func];
+
 	expected_size = acpi_dsm_size[func];
 
 	/* Currently all ACPI DSMs are either 8-bit or 32-bit */
@@ -177,6 +181,8 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 
 	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
 				       &iwl_guid, &tmp, expected_size);
+	if (fwrt)
+		fwrt->acpi_dsm_func_retcode[func] = ret;
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 048877fa7c71..63dca94a937c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -182,6 +182,8 @@ struct iwl_fw_runtime {
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
 	u8 uefi_tables_lock_status;
+	int acpi_dsm_func_retcode[DSM_FUNC_NUM_FUNCS];
+
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
-- 
2.39.2


