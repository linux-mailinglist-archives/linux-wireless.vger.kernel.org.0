Return-Path: <linux-wireless+bounces-16110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742149E9E7F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CA2831B1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906EE1990C5;
	Mon,  9 Dec 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf3BO13e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72A198A1A
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770472; cv=none; b=QGxaTDwLbdDBhIXTtRStcDMRVwrwROl1yCX0gxWNzWSEEuU0D+J8q4049b68y580RgZo35K6jfAMoFgIa7BpbFfvHXbV7RZN2HO3K5ETNqDeHIOEK1cJx1KfccyOYd+X0GasAJkzVulDQu9aBbKigX1KwIUGEzwjbld2iQP0D7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770472; c=relaxed/simple;
	bh=xdzKbQAIakc5HvAhWpI0VR56QcfIfSr18ufmz5t3vSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akGZ44P/6apsnEMFOxxNAxvHP8ICdwCV1DmrxnYF44DcgfKxEaTZnVc8O0QlplN0zdrGMyn4Dclg9TSZpNkNPuDM5/8r+1b3DVjXPwVq9xZW73fOVZfvJPJ0Zywgp++LrXFx64Si9yk3rbYGpHw2dnZ2SZr0VLmdKtwarqZ8mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf3BO13e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5948FC4CED1;
	Mon,  9 Dec 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770470;
	bh=xdzKbQAIakc5HvAhWpI0VR56QcfIfSr18ufmz5t3vSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf3BO13e8fF30QuNSQH6ld3qJxrsDlno7ng883RDpihxT3M4LQaN8JvuYlGQpv1Zz
	 fvm31VpAQjvDvxfcLbdU0EVN8MKRIWZQ0N6Ux7xtN6gxDA8PYbKOSKhp9YDe7I/DQI
	 pdXRcL/P3Wbrn6JmNXjhuYf1clMv5/JGWaf3ZcsQTy0l4GbmTHwE7rKbyHchUklGth
	 GgEJJnWN4H/Nx3GTBFvklHdFGGoei4+yYUpPajerR1PXDxIkmlozof23ygUxs8avB8
	 jvVUbm/Y2+448ukZ++7vBMfV1ilHDCCR2HIEp+T/3XdZXX4+aHrUiY1limymI7ktcp
	 lrSQGkooSHlJg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 7/9] wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
Date: Mon,  9 Dec 2024 20:54:19 +0200
Message-Id: <20241209185421.376381-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

If the requested memory chunk is too large, an error message is logged, but the
request continues to be processed. However, no actual memory is allocated to
the firmware from this request. Instead, the firmware sends another request
with smaller chunks, where memory will be allocated accordingly. Therefore, it
is pointless to proceed with parsing the request if at least one of the
requests cannot be fulfilled.

Hence, return -EAGAIN immediately and proceed to process the new request.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index e7846aaca10a..964d350be748 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2497,7 +2497,7 @@ static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
 				    chunk->size,
 				    chunk->type);
 			ath12k_qmi_free_target_mem_chunk(ab);
-			return 0;
+			return -EAGAIN;
 		}
 		ath12k_warn(ab, "memory allocation failure for %u size: %d\n",
 			    chunk->type, chunk->size);
@@ -2600,6 +2600,14 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 
 	mutex_unlock(&ag->mutex);
 
+	/* The firmware will attempt to request memory in smaller chunks
+	 * on the next try. However, the current caller should be notified
+	 * that this instance of request parsing was successful.
+	 * Therefore, return 0 only.
+	 */
+	if (ret == -EAGAIN)
+		ret = 0;
+
 	return ret;
 }
 
-- 
2.39.5


