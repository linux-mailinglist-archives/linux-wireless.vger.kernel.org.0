Return-Path: <linux-wireless+bounces-2830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996A8427CA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E21F2715A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D182D78;
	Tue, 30 Jan 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCLAN1BI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08F82D74
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627763; cv=none; b=KjaJcf28epCVMsr3nLw2dAtzyvRNnb2jn/S88m5HYbt5FvZ50i5H26aUhnY0YAKtoVSauGArWOFPSHx8jvI0s4CfegkICYPNvkFgGZOYJwzqqvQdGe3MbAhk+pjb5LyifAplLlMR5/1qHIUGx9ILLr9Gf2x8JRbLLRlf074S710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627763; c=relaxed/simple;
	bh=dLtn+d92qFT0cX+Rq4JpFNoJDaDmwf6jvb8ASjLVIf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APbi4auRSx3wCTY/4ANNr0xNy4QGp+sL5kp7mNtl0Opfjam2128nAJKjP4oE7rjgWQJus3ELV683TKej82N3NQkp+AcSoL1znMB7lJjjxDCSwTuhL15ThRKC5MKI/jDESx6P1eXDvO43fXao+9J2CphwkaacHKLdqi0plQhbqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCLAN1BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAEDC43609;
	Tue, 30 Jan 2024 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627763;
	bh=dLtn+d92qFT0cX+Rq4JpFNoJDaDmwf6jvb8ASjLVIf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCLAN1BIRn5o2+x+Xjo1PWUeB+NGOa7WAVRees7WNT3Qb3lJi5fBwwbuxxOhE/W1B
	 s8PLBzy4Gcxr2ksmU8HYxbsMJopJ7yfIQrxonWz66pq52jEqh43OM19yGLV+tQEtlo
	 uZ2MsCJ+5E9UNN/cmiyfCNQWazVw8YvroVHgF1zW7rjwb/jsCCJJ7UjJ2Al1VXgjzp
	 4crJyvdfC8xwJPmNhv2v/OsqaiH6uw9IrkQV4P7YnEzy6FRkbf+DLWroAA2o8ydQ1A
	 68eaK9g3mhhTHudlWGyaEKl4fOJIdmCTCHIln+Lg0xNL3pUmyMnyz3lyJ6gc+f8s/1
	 OxWN5pTlIUiKg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: xl@wp.pl
Subject: [PATCH 4/4] wifi: rt2x00: fix __le32 sparse warnings
Date: Tue, 30 Jan 2024 17:15:56 +0200
Message-Id: <20240130151556.2315951-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130151556.2315951-1-kvalo@kernel.org>
References: <20240130151556.2315951-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse warns:

drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    got restricted __le32 [usertype]

rt2x00 does some wicked casting here so no wonder sparse warns. Clean that up
and use cpu_to_le16() to avoid any warnings.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index aaf31857ae1e..8e8fab88fb2b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10946,13 +10946,20 @@ static void rt2800_efuse_read(struct rt2x00_dev *rt2x00dev, unsigned int i)
 	/* Apparently the data is read from end to start */
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data3_reg);
 	/* The returned value is in CPU order, but eeprom is le */
-	*(u32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);
+	rt2x00dev->eeprom[i] = cpu_to_le16(reg);
+	rt2x00dev->eeprom[i + 1] = cpu_to_le16(upper_16_bits(reg));
+
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data2_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 2] = cpu_to_le32(reg);
+	rt2x00dev->eeprom[i + 2] = cpu_to_le16(reg);
+	rt2x00dev->eeprom[i + 3] = cpu_to_le16(upper_16_bits(reg));
+
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data1_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 4] = cpu_to_le32(reg);
+	rt2x00dev->eeprom[i + 4] = cpu_to_le16(reg);
+	rt2x00dev->eeprom[i + 5] = cpu_to_le16(upper_16_bits(reg));
+
 	reg = rt2800_register_read_lock(rt2x00dev, efuse_data0_reg);
-	*(u32 *)&rt2x00dev->eeprom[i + 6] = cpu_to_le32(reg);
+	rt2x00dev->eeprom[i + 6] = cpu_to_le16(reg);
+	rt2x00dev->eeprom[i + 7] = cpu_to_le16(upper_16_bits(reg));
 
 	mutex_unlock(&rt2x00dev->csr_mutex);
 }
-- 
2.39.2


