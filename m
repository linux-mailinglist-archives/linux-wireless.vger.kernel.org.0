Return-Path: <linux-wireless+bounces-3956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1148860FB7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BAA1F21DCF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB377E58F;
	Fri, 23 Feb 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N24ONDDs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27807CF37
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684831; cv=none; b=n+HSigJsKfbkx7rzYA6/urIWiZGFWYCxvGNYGbCoOPUvTLKkO1ayuXPbMh/dYgx8J/s4FUvoYVIfr6RJYCRchXHu3Sc64UmgIoaNAwbVTkWyiQpprKb14OsOy7oeCPhK8oNhR3y8AMShe1r9+gCY6b9mtuWJee8qCOoiO0/LhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684831; c=relaxed/simple;
	bh=yJBHhg66I9gAzK8JKZkjPgaVzzAj8ITk9ABCBkUGnLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWiSWuxmxWZdaqPU2nNw0d3Xn3n8QoB5FWIs2dMLD8D/SHsX1/tCirJLAPhF/sQ0Cwf/p/Ze9jPKV1/lqUvnoDPkoNeYzwtCgd7xs7XI8UhZPNHHHT1pAPE+9pU4S8h056NJao1HDKkgVu6KFSCSXIkpeA1JG4x8/5a7WP+VZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N24ONDDs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ukPxDPASKUXuyCwdJq87C/AB58oj9TXotqNNN7+832Q=;
	t=1708684830; x=1709894430; b=N24ONDDseS7cjrlZheC3FcCH8hvX7DaopKNCmX4hl+d1//b
	LrgnW9F0jXwbMp6zWj+4BXtkIuV7jLmXmULu30TyIjIKhgb4T8Tjg4xRJ5LpYB6xCvMslRDHd/BTx
	q0AQBcFKih/kxZyBdSKyIfAw4Xa8WPmgUWzhflnfF4VhL1yEfcpFXjbeJeTjG90gJfurJWpcoUGA0
	L7fH7cW1Tdi4MGMfXdgcnLlXPJEUI2jdA5CDvq7qMDDwpdOUs6CeitoBOZOOn6NJcuK0ZYjFj4OFO
	x0rsLSZAlEygwm1EgpERWJ++2tpJM8Qyjz2giWLc82JWnBhSS0LpBbDdR9V7ID/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSyh-000000051om-008G;
	Fri, 23 Feb 2024 11:40:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] wifi: cw1200: silence sparse warnings
Date: Fri, 23 Feb 2024 11:40:26 +0100
Message-ID: <20240223114023.94a005ba767e.I7039051d0aa62fa992afeeec679174c606ef37e8@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This code clearly intends to do some unorthodox byte
order conversions, so add casts to silence sparse.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/st/cw1200/cw1200_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index c82c0688b549..0ce9a1d39db1 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -80,7 +80,7 @@ static int cw1200_spi_memcpy_fromio(struct hwbus_priv *self,
 #endif
 
 	/* Header is LE16 */
-	regaddr = cpu_to_le16(regaddr);
+	regaddr = (__force u16)cpu_to_le16(regaddr);
 
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
@@ -145,7 +145,7 @@ static int cw1200_spi_memcpy_toio(struct hwbus_priv *self,
 #endif
 
 	/* Header is LE16 */
-	regaddr = cpu_to_le16(regaddr);
+	regaddr = (__force u16)cpu_to_le16(regaddr);
 
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
-- 
2.43.2


