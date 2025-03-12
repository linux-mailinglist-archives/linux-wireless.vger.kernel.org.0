Return-Path: <linux-wireless+bounces-20281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D417A5E882
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 00:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9429D3AAEA8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7A1F0E45;
	Wed, 12 Mar 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEznmNDD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B216FF44;
	Wed, 12 Mar 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822953; cv=none; b=f+EIHdqlR/iFq+6OnwEO4GifTCKlQ2O+0QDST4wLdctFbeIk/CTDSSsfiALolFngbcIi+561OFCiGuur2G4KGGezYnNP3PoE7x9tbzmdbt1sHtFuY2UC1q4JrCvHFi1W0f2ZFxtIE+/nGKk2taCegZIzfYs47iix4wrWY0Mi0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822953; c=relaxed/simple;
	bh=qfr+2zQR+Sacn+n4lmc0XvBgQVef5IcvW3V6IrEHRjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAR13DXRzfo81w7wueIIbklCyN7xjL8o649pdOtT9QGLTWFyL1Fanam1rjMm4NXh9hwsFrXepiFGR4ACtsi2aRBFXzOKllgbBYOyAQBmPjmmvW74zxbGleUERROg+ixarbOenBNN8wBSLwvKoSIcpYjyI1noOUSAEcduibEM/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEznmNDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345DDC4CEE3;
	Wed, 12 Mar 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741822953;
	bh=qfr+2zQR+Sacn+n4lmc0XvBgQVef5IcvW3V6IrEHRjY=;
	h=From:To:Cc:Subject:Date:From;
	b=QEznmNDDw2mWRCdJFMz0BQsGUXBUqqp4i2TF1aqfqFjbP0mcv+ee+/aXL/ng+BycS
	 smOraYvyBoMajGCCiToJlWpLF5eKHeP7MJtOnkrlHJCMGr36vMEyEZwrfwPOIvv1LH
	 myE6FBt5+CjyT2qeUOvovlA1f8cJkI2VgW/dRU67o2den8CLJ7jBGMFC3QJ6YtdUuK
	 zvKuyeBfl+tgwxSFvs1b6SnVpN93VZkkioU1wR3m7dLno2VBdokwwyKxh8T9U+BNSZ
	 vj+eOVVnfExX2MrBPgxSRLxRsPtTscma0wR2C0ERGKcUPQFqo8xMsg8x2Fs57H5LUy
	 59Iu6HTg/Gt8w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath10k: Drop of_get_property() call
Date: Wed, 12 Mar 2025 18:42:27 -0500
Message-ID: <20250312234228.1243477-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to check the property presence and length before calling
of_property_read_u8_array() as it will return an error if the property
is missing or the length is too small. The return errno doesn't matter
to the caller, so no change in behavior there.

Change of_property_read_u8_array() to of_property_read_variable_u8_array()
as the former allows properties to be longer than the requested length.
Now the property has to be the exact length requested as the removed
check required.

This part of a larger effort to remove DT functions like
of_get_property() and of_find_property() which return raw DT data
having no reference counting.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index b3294287bce1..db7444af251d 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1889,7 +1889,7 @@ static int ath10k_download_cal_file(struct ath10k *ar,
 static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
 {
 	struct device_node *node;
-	int data_len;
+	int data_len = ar->hw_params.cal_data_len;
 	void *data;
 	int ret;
 
@@ -1900,28 +1900,18 @@ static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
 		 */
 		return -ENOENT;
 
-	if (!of_get_property(node, dt_name, &data_len)) {
-		/* The calibration data node is optional */
-		return -ENOENT;
-	}
-
-	if (data_len != ar->hw_params.cal_data_len) {
-		ath10k_warn(ar, "invalid calibration data length in DT: %d\n",
-			    data_len);
-		ret = -EMSGSIZE;
-		goto out;
-	}
-
 	data = kmalloc(data_len, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = of_property_read_u8_array(node, dt_name, data, data_len);
+	ret = of_property_read_variable_u8_array(node, dt_name, data, data_len, data_len);
 	if (ret) {
-		ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
-			    ret);
+		/* Don't warn if optional property not found  */
+		if (ret != -EINVAL)
+			ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
+				    ret);
 		goto out_free;
 	}
 
-- 
2.47.2


