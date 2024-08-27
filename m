Return-Path: <linux-wireless+bounces-12010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D595FE15
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 02:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA13BB217D3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 00:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0E1FB4;
	Tue, 27 Aug 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BUMm+JkO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A04C6E;
	Tue, 27 Aug 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719935; cv=none; b=UfdPkdATvGGx6q1TRl9iXHI9dIXAKbhWu5as0qpaOGaZZcXz0GFmJHFKPWAx4TzL5hs8zy+Ts8E4anbngSGdk75DIzqprOJWtXaTyRPpMdOwzlZUqjfVTXm2LSv+bSdaL/1YLSmParyLRFfwbL1EuuXFNL3aBqN8VK71K13ndLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719935; c=relaxed/simple;
	bh=o1NOOnd+S2fw7jpL4TBPLu70Zd0V9CqR2ZNRWxzWeg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dsDejUvoVipTD8mLTa+Y944qsO37ajCfdj+5ByObOy2+dnCYT1JbLg7mzJHSPxnaL90jKDiB3FyFFbSg/wDmaT7SxsHY80MHbKKO7eP/+UWvA8f3cRp4ik4NSpVbhENUAn7qWyWE4bvdubfQsM03FQ4KYCqacPhxP0GWGmh5UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BUMm+JkO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mo9Re
	kydLbB7jgzAG9tKGwNs3MPYoPW5XcLMY7TfLYE=; b=BUMm+JkOP11YShiv4MQKc
	qxhSVi8AxYkjAoysbb1n/R2HUR4FrMdJASg1xrKKKg5T/O8qfcz/uk1xO4DHT0jG
	KO8nyfeBSuSfvcfwhJzYDYbmWceL7u/isk+rnx2ji/B75BnUvS0bVBIpaxNVyrYf
	tdyhxnX6S8dyv10x24C008=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3n_EDI81mpfKyAA--.7028S4;
	Tue, 27 Aug 2024 08:51:31 +0800 (CST)
From: David Wang <00107082@163.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	gregory.greenman@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	dan.carpenter@linaro.org,
	daniel.gabay@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] wifi: iwlwifi: acpi/dsm: cache error retcode for iwl_acpi_get_dsm
Date: Tue, 27 Aug 2024 08:51:14 +0800
Message-Id: <20240827005114.4950-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n_EDI81mpfKyAA--.7028S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWkWw4rAr47uFykXF4kCrg_yoW5GryxpF
	129a12krWDAa1Ut3Z3tF4Sywn5Wwsru39xCrZ7G34UJr1DWr1SgrW5Gr12vay8Zwn7Jay5
	ZF47tF15Kr4kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxRIqmXAncCIewAAsO

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
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 79774c8c7ff4..3f98f522daac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -30,6 +30,8 @@ static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
 	[DSM_FUNC_ENABLE_11BE] =		sizeof(u32),
 };
 
+static int acpi_dsm_func_retcode[DSM_FUNC_NUM_FUNCS] = {0};
+
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
 {
@@ -169,6 +171,10 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
 		return -EINVAL;
 
+	/* If HW return an error once, do not bother try again. */
+	if (acpi_dsm_func_retcode[func])
+		return acpi_dsm_func_retcode[func];
+
 	expected_size = acpi_dsm_size[func];
 
 	/* Currently all ACPI DSMs are either 8-bit or 32-bit */
@@ -177,6 +183,7 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 
 	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
 				       &iwl_guid, &tmp, expected_size);
+	acpi_dsm_func_retcode[func] = ret;
 	if (ret)
 		return ret;
 
-- 
2.39.2


