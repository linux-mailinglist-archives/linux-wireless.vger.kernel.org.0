Return-Path: <linux-wireless+bounces-8411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366808D7E41
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E299B23B5E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683380039;
	Mon,  3 Jun 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NGzWmaCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7974420
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406151; cv=none; b=ENQEnTsg5+Mv+l0ZiJ565OtGyBi47EZz4E6V15Ll3vyklnMBJozpa1dX8MbJO0Cq2VRvqDpzXiyCj7P5psgkL6O4Yr107m/Lr0G2iD6X5SdTzzsq4mptWNbTeCGbPPbI693t5tdb1dWVbKm4l/BWfoe+iICwhEYInS4DuS2gUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406151; c=relaxed/simple;
	bh=PnSLEwaMRIhusLOj1H7+hLN1hV3Obq2sv6Ok+7+MTZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMoGTzkr0rCd+LMWQx4UInzPOOxq0HVHg+iAHkXtXURDpCpoRNPiRDH/hliBwhkzw+2jLX2mU8uduL+LIEPaKNQmLeneky8xieoOB0x9BT+b/UmJgVn1DtxKMGS2Uhziq1QzWIs6L57oGRn4LbSx/GPxaZqer2pMWOZZXTNqX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NGzWmaCV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=LdfEPpYp2q55Lbd2/moAUzqffW0IB2tS5IgblPD0OA8=; b=NGzWma
	CVcolg6ZPrhBUwk1hNWstW5WslGXGh9X4xJVd+aOGNFRTOtgzHi77MTYd1szZseA
	pjQ/5aoNkBnm7yMiViL5bZf/RwXmeNX1D4MH30dmXReeZOax9ewXf0zIw9jDDbQQ
	+byec288G7tXebFyoMNuk/9U7Z7zgB3SwHo93MrGQssLsAHWawlWYsSLKsbLtH/N
	+d7s/0PbfaJn1MNRoj+l3p9cH7ZnK8MXY2roydMSCoXhL2VOqwWWVY1iDhhc95hx
	qH8eeJqOdEHkl77DLg/m98mnPN8jWld5wcttt0yq6C5S12vrdHys15Nndax2Qbad
	Aq5lFb08sx2QJhQA==
Received: (qmail 1899265 invoked from network); 3 Jun 2024 11:15:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:45 +0200
X-UD-Smtp-Session: l3s3148p1@fPQ9x/gZ+oUgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH 1/6] wifi: ath11k: use 'time_left' variable with wait_event_timeout()
Date: Mon,  3 Jun 2024 11:15:34 +0200
Message-ID: <20240603091541.8367-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_event_timeout() causing patterns like:

	timeout = wait_event_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d4a243b64f6c..2fe0ef660456 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2859,7 +2859,7 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 
 int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 {
-	int timeout;
+	long time_left;
 
 	if (!ath11k_core_coldboot_cal_support(ab) ||
 	    ab->hw_params.cbcal_restart_fw == 0)
@@ -2867,11 +2867,11 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
 
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "wait for cold boot done\n");
 
-	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
-				     (ab->qmi.cal_done == 1),
-				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
+	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
+				       (ab->qmi.cal_done == 1),
+				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
 
-	if (timeout <= 0) {
+	if (time_left <= 0) {
 		ath11k_warn(ab, "Coldboot Calibration timed out\n");
 		return -ETIMEDOUT;
 	}
@@ -2886,7 +2886,7 @@ EXPORT_SYMBOL(ath11k_qmi_fwreset_from_cold_boot);
 
 static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
 {
-	int timeout;
+	long time_left;
 	int ret;
 
 	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
@@ -2897,10 +2897,10 @@ static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
 
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait started\n");
 
-	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
-				     (ab->qmi.cal_done  == 1),
-				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
-	if (timeout <= 0) {
+	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
+				       (ab->qmi.cal_done  == 1),
+				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
+	if (time_left <= 0) {
 		ath11k_warn(ab, "coldboot calibration timed out\n");
 		return 0;
 	}
-- 
2.43.0


