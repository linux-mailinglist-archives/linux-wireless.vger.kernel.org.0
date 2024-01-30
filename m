Return-Path: <linux-wireless+bounces-2829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273C8427C9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C94728C755
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704781AB6;
	Tue, 30 Jan 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVxwOnV9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECC7F7F8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627762; cv=none; b=j5q2aUAKXtaxWW35eElpeC3gofzYq3ndRnob1CS6W/NmWL/B7goMrM0zRDrWDX4fEUaO0f9hFaLYk65tdV8JwT+WJRzf/eGHJLWz4V+pZJuQ2+PD2h6XUctkTLDsDyJM3E7r9SFiRwvPMj9CVBHmULrb63Nz25aBuTTA+b6mYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627762; c=relaxed/simple;
	bh=661G/XNd/XpaNMgjXRXDDVUfCFyZa8CkM+1nZ+Jeon8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7vZFrOOc8Vx5aa/lrzJawG2RUfvWD2q8xYhxMd4ikpo/dUGtNcLkaYmKKrqOVOzz56Jr00OMCvY2LShjOv7HhQWd6wkNm6dMBTjqWBkvCnv9WKHWxgCv8yI09dclqOJlHUpL1GFOahFFGa5u+pHpRljkhFRBIcR5mOJfu20Fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVxwOnV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DBC43142;
	Tue, 30 Jan 2024 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627762;
	bh=661G/XNd/XpaNMgjXRXDDVUfCFyZa8CkM+1nZ+Jeon8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVxwOnV9cVfGDeRVXgWohtCvXjM44gsm84TqVaKoygtd5Ea5PPAEKNk4LEuFm/7n7
	 5J90lb90zWBjl6fMEu88YVagQ3hjy3QX+vAygMIlD1gFlhTBm9UYxzUBPdpL1l0DFm
	 8YgJWEC9yokz2mFam4OUa+ITm8F7gqf9s/cdsB7ha3ouggKrXbfgeYVRG3QOj2CDQH
	 ubhKOkgxpdg/6GI44Ve7Sosn6inmQWbWBsUtOuVOnIjD+bakI+US+WDWwUZ6f8r6gd
	 Vy9LcHBGD+c6mr9pdih6LKKYNxZ6zm9qaKwvl1bZBbPWYnno1iaZrf9fyF18FzLLu3
	 yz95S70D6AhNQ==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: xl@wp.pl
Subject: [PATCH 3/4] wifi: cw1200: fix __le16 sparse warnings
Date: Tue, 30 Jan 2024 17:15:55 +0200
Message-Id: <20240130151556.2315951-4-kvalo@kernel.org>
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

drivers/net/wireless/st/cw1200/cw1200_spi.c:83:17:    got restricted __le16 [usertype]
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17:    expected unsigned short [addressable] [assigned] [usertype] regaddr
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17:    got restricted __le16 [usertype]

These cpu_to_le16() calls are not really making any sense to me. On a big
endian system we first convert regaddr from big to little using cpu_to_le16()
but immediately after we convert them back to big endian? So just remove them.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/st/cw1200/cw1200_spi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index c82c0688b549..b27b57fc25bc 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -79,9 +79,6 @@ static int cw1200_spi_memcpy_fromio(struct hwbus_priv *self,
 	pr_info("READ : %04d from 0x%02x (%04x)\n", count, addr, regaddr);
 #endif
 
-	/* Header is LE16 */
-	regaddr = cpu_to_le16(regaddr);
-
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
 	*/
@@ -144,9 +141,6 @@ static int cw1200_spi_memcpy_toio(struct hwbus_priv *self,
 	pr_info("WRITE: %04d  to  0x%02x (%04x)\n", count, addr, regaddr);
 #endif
 
-	/* Header is LE16 */
-	regaddr = cpu_to_le16(regaddr);
-
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
 	*/
-- 
2.39.2


