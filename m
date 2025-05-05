Return-Path: <linux-wireless+bounces-22565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF35AAAA33
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D50D1692C8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AF388C29;
	Mon,  5 May 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeiaXbwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731542D7AFB;
	Mon,  5 May 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485762; cv=none; b=s8CNNjczsQP5gQnpq/9vDqUgvBLhb+olOCpWlfmYcoMMk1TjeZ8Ll/tGN5bJ9OE+xJf0fjcNGJKIHIBhjEs01J60Wfbe2L1ospoCgj/8he6kl9rnzUHvf+ereany/1J8Z5yF38/+sK9528lD5rUXKgH3K867lvwbwEKP2yv/80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485762; c=relaxed/simple;
	bh=qH60v/UBuRVGvBvmQR7xuc+vbvwcpz4hRQkRfR3oOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIxxg2wX1asrZhifHBk5wLMHVXDg7lgGi/kFav62mmUlFJu1K8CNocWT2cscAzPGlM6pYr8y1sd9mTBfxc/G+8gy+4FOBMNJrRKQdZI/Y2RQtxG3kvHdEOKEbzPB37F6lZmRk5G4x7qQxrUAuCAH3qiHJaVYB9vpUbeo0EdXpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeiaXbwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E73EC4CEEE;
	Mon,  5 May 2025 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485762;
	bh=qH60v/UBuRVGvBvmQR7xuc+vbvwcpz4hRQkRfR3oOfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeiaXbwlnBTmRADGCWbbpiPKJOiRpioQIh1VNQh06GShrgR8WOM9OWz4jwf1/0+sm
	 DcZ7tOo/lpjJwWxH1BnZHZo5Q8+khFo4G11zbiaEl1dae3IDxBnaXwL+PYf+tgnoFg
	 ToEHZvdjDPHlm0e5wmsHkup8dliyaNLA1ABrZivBxFpbAG3010+uINK6QPlR0SKE1S
	 tFXoBNur+CNTrZcKRHVTp5dXnwSF0wDkYqCTzNiO6Uo9AlcqZJHR0U47hpn9Llti4e
	 MeniYnp0f/pocjs72XucNxHgP28I7puNONOdU4jlRhunvJEuOvM1bOmcmOENHcIS8T
	 9SeMPQwseTH+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaradhana Sahu <quic_aarasahu@quicinc.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 471/486] wifi: ath12k: Fetch regdb.bin file from board-2.bin
Date: Mon,  5 May 2025 18:39:07 -0400
Message-Id: <20250505223922.2682012-471-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

[ Upstream commit 24f587572acf7509127dbdfcbf1b681ef84eeba0 ]

Currently, ath12k_core_fetch_regdb() finds regdb.bin file through
board id's but in board-2.bin file regdb.bin file is present with
default board id because of which regdb.bin is not fetched.

Add support to fetch regdb.bin file from board-2.bin through
default board id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Link: https://patch.msgid.link/20250116032835.118397-1-quic_aarasahu@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae9..8bb8ee98188bf 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL(ath12k_core_resume);
 
 static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					   size_t name_len, bool with_variant,
-					   bool bus_type_mode)
+					   bool bus_type_mode, bool with_default)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -192,7 +192,9 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 			  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
 			  ath12k_bus_str(ab->hif.bus),
 			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id, variant);
+			  with_default ?
+			  ATH12K_BOARD_ID_DEFAULT : ab->qmi.target.board_id,
+			  variant);
 		break;
 	}
 
@@ -204,19 +206,19 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, true, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, true, false, false);
 }
 
 static int ath12k_core_create_fallback_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, false, true);
 }
 
 static int ath12k_core_create_bus_type_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, true);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, true, true);
 }
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
-- 
2.39.5


