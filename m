Return-Path: <linux-wireless+bounces-20397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5ACA621EF
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 00:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D0D3AD700
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF61F2C5F;
	Fri, 14 Mar 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAeaPgp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC931F03E5;
	Fri, 14 Mar 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995517; cv=none; b=D7K2loc2tuGeWYxe/vHFYgbN5/PrLRFVOD7ojVsBdPCCBxqFvYIYOKjx7kIljLmkXoGo42yrIY+DS7EIDhrl1qHAtee3r1kxVJzBpN9Vvdu3TUjaHztH8P2D8LrLqKi90ND0fRpTS9QhBToLScMZ5Q4mX6Zwvbr+HCLSeMu6Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995517; c=relaxed/simple;
	bh=Aat7/rEWkFcSdlzDUueOqvJeqbZyX+Ujl7CI8jffEiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQha8NVY2AyK0U2BypV7A4FTgU2Ber+YdjUlfhRcg7n1Ii7wHPRCfCm/oVX861UtgWFrKFnFuZdszWmO2RDbQjdqepyWdRjXJymGHybY0QmyNW0FW8z+Vd2neQG3fCSW32Ax/YVkuW2K+VUaDmrq6iJ/9Bazmt7P5h+Vc+wxDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAeaPgp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9DC4CEE3;
	Fri, 14 Mar 2025 23:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741995516;
	bh=Aat7/rEWkFcSdlzDUueOqvJeqbZyX+Ujl7CI8jffEiU=;
	h=From:To:Cc:Subject:Date:From;
	b=mAeaPgp6cKK3+L5gGtXf94L7VEz+JWHmCGi5nbSut4W0+yFOHFbqoQVhGz9FqM1TM
	 bTC5CFmK7iExP4O7Pk/8+tvGysYpW8+REaJqnd8ujeXt5PNJ47DQAndXr30IB/WMvx
	 GvfpyR3NhxyQzaOPUgKonXFcESRTxi/VZ7Lw8yIM+gICs7P8trp5q0c2GNQeBHjZoN
	 XFbudv2rBgsOqUJ8R+3Rk9Okz7h82R/P+Yg8TcbxIBpHYX17Lo1N772RMi1yUSiE5T
	 LrgWD7Y68XutQlSqn1JFzKzK2JHJJ4ptaOzAr4TNGutKbuk9KWE+4tQqQybpqKxcqK
	 E2jwveAsyKOSg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath10k: Drop of_get_property() call
Date: Fri, 14 Mar 2025 18:38:30 -0500
Message-ID: <20250314233831.2535170-1-robh@kernel.org>
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
v2:
 - Add check that cal_data_len is non-zero
---
 drivers/net/wireless/ath/ath10k/core.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index b3294287bce1..47206b171aa5 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1889,39 +1889,29 @@ static int ath10k_download_cal_file(struct ath10k *ar,
 static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
 {
 	struct device_node *node;
-	int data_len;
+	int data_len = ar->hw_params.cal_data_len;
 	void *data;
 	int ret;
 
 	node = ar->dev->of_node;
-	if (!node)
+	if (!node || !data_len)
 		/* Device Tree is optional, don't print any warnings if
 		 * there's no node for ath10k.
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


