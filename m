Return-Path: <linux-wireless+bounces-8205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9D8D1E78
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E831F23A0E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185117166E;
	Tue, 28 May 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbxRnf79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452017106D;
	Tue, 28 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906049; cv=none; b=pb2ClmZiDQ1qYnJkVknStVHoRtRhqAkjpyF4O3++Dm7dYLH20TOEwN7dEJ/YdTfmIoAS0QENJcACQ++F634mzzdIHU2wPw9PT4+7F7uDBI6LVGyLbNjmPgqvC9nf1lkhM0IkxWuYapwqEuFy0HvjLykbPMffyZoRuGTotg+F65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906049; c=relaxed/simple;
	bh=9LBFDaFfhOfUAOUwwN7VN1Kk9xj/7iR191B7RgVX7U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1NXydEwbb+LqWAciYqJW2D7+/IdNGs1rfNfd+NnEwQrWIuxnSf1vmDNbUDqpyUfVCvN9HLjzcyDjRXDIY9bPuwLpzwDboCwmcJeuQ38Tts2JNnu8VmmWBAdO+MGT9P6RcX7oRcYiDCxQWO2jhhjE3c+hVux8LKZ7HRG98YxmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbxRnf79; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F840240009;
	Tue, 28 May 2024 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716906045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJi7Zl6vfBFp7vosq6ncw5ahjATKPSYSi4OHvyyAQs4=;
	b=fbxRnf79QpMKw6SvU4q6fL33PZoOJp03DCfFeeQsyhiqnPyua23CMUPTmj4jMDKIe+Fvrm
	Tju2BVObRrKy7RfMG4zFskMoRB9JgRDDZYfMctgkKzJzuypV8ttzlyJrJBTUVUUaJWkdBo
	ROUmj2HoOAWPoZ2NpC2viegQi57PAtzr4D+P11cFdSfGt16fc5p2BV0qsrr7JB32+DZJzH
	C8yuVzY8IZ2RikT3y6gSe42jlbeXYG/EDCz8BfutZ72A9fP1mUF4PtSm8eGVGy97sAUgGD
	kcbAkjlg+3CKHj0Qk+2otGMeCkkNRgep0BUFjef98Gs58fhmPYZCNNkLox7Ysg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 28 May 2024 16:20:29 +0200
Subject: [PATCH wireless 2/3] Revert "wifi: wilc1000: set atomic flag on
 kmemdup in srcu critical section"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-wilc_revert_srcu_to_rcu-v1-2-bce096e0798c@bootlin.com>
References: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
In-Reply-To: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This reverts commit 35aee01ff43d7eb6c2caa0b94e7cc6c45baeeab7

Commit 35aee01ff43d ("wifi: wilc1000: set atomic flag on kmemdup in srcu
critical section") was preparatory to the SRCU to RCU conversion done by
commit f236464f1db7 ("wifi: wilc1000: convert list management to RCU").
This conversion brought issues and so has been reverted, so the atomic flag
is not needed anymore.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 3925ca653e80..f1085ccb7eed 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1594,7 +1594,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	msg->body.net_info.rssi = buffer[8];
 	msg->body.net_info.mgmt = kmemdup(&buffer[9],
 					  msg->body.net_info.frame_len,
-					  GFP_ATOMIC);
+					  GFP_KERNEL);
 	if (!msg->body.net_info.mgmt) {
 		kfree(msg);
 		goto out;

-- 
2.45.1


