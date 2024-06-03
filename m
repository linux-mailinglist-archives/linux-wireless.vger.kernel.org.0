Return-Path: <linux-wireless+bounces-8416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE48D7E4F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DB5282C15
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D404F83CCB;
	Mon,  3 Jun 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cehrddhk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9982C63
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406155; cv=none; b=Pa7ju6E5UkbhOg9JwokigGVKNFCgg/HFivy5g1QlhZuFGb1w6da5XhIUPc5ZdMHwAw9jrJTi/+cv+lKIdoXYHyAwt54GSXMNQH/vKkOxho/qutAba/nVHBP94kxJI+lwGADWObgBkaKohcMfuYSL7NkKtdY9oxbAPnaB+Tt3ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406155; c=relaxed/simple;
	bh=KuYORB2sueIbIdV8ZkFX68NtUj8C7l8czDRU62n4XqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz5YPnBllzmglpYCGV32Cz7ANy2BSLA0m/5ewQPSofzKjK9YQf91rewKtdhLzMVhOf9PeIM9fFk0MLnYCButsrYO2AUgbU2wF6qOSdn1z60s/s8T8u/0hD1kfIn6JIF780sZYauHferTNo7Rwk8g7PINbDPUsmV2DAXcF9oegZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cehrddhk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=vFiFwcvLEE/Pv747qc+Uul7awI7SHIx4wIkE2dTt7B4=; b=cehrdd
	hkCdJJ+YulpyRRPe+BHxQNyclUx7ZmMqKEZlM0MNlosr64dlYNqoV6T+D3QAlxw9
	o+cNHHkoNrL+hQ7URTExVQW7lVGo/AEOUe97VsFiQiKTdv73AO2ijC17VT4N/9qj
	80TLuzLJWn5TKvwLw95t2fvNbd+vj1qIWDCDi3BDcEJWrdHR2+CHxoeOM2q0OYPN
	Y2i8Jgs0ZFlOx/Bp0HzjNtvlIRR8eqaj73RRRCMO09ZXMoCI1S44VV+VusPchxzl
	/I4iy7M46YZx3TBAAim4Mdn3wmdyVLTW6Y6iLQIWwxQefifjaX45apTgDTdhTkQ1
	l3zdCjVzOZZyBWMA==
Received: (qmail 1899402 invoked from network); 3 Jun 2024 11:15:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:50 +0200
X-UD-Smtp-Session: l3s3148p1@Wrp9x/gZKoYgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] wifi: zd1211rw: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  3 Jun 2024 11:15:39 +0200
Message-ID: <20240603091541.8367-7-wsa+renesas@sang-engineering.com>
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
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index f3b567a13ded..2ee4218da1c5 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1698,7 +1698,7 @@ int zd_usb_ioread16v(struct zd_usb *usb, u16 *values,
 	int r, i, req_len, actual_req_len, try_count = 0;
 	struct usb_device *udev;
 	struct usb_req_read_regs *req = NULL;
-	unsigned long timeout;
+	unsigned long time_left;
 	bool retry = false;
 
 	if (count < 1) {
@@ -1748,9 +1748,9 @@ int zd_usb_ioread16v(struct zd_usb *usb, u16 *values,
 		goto error;
 	}
 
-	timeout = wait_for_completion_timeout(&usb->intr.read_regs.completion,
-					      msecs_to_jiffies(50));
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&usb->intr.read_regs.completion,
+						msecs_to_jiffies(50));
+	if (!time_left) {
 		disable_read_regs_int(usb);
 		dev_dbg_f(zd_usb_dev(usb), "read timed out\n");
 		r = -ETIMEDOUT;
-- 
2.43.0


