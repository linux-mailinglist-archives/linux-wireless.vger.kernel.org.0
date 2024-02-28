Return-Path: <linux-wireless+bounces-4181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868686ACB6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94D31C22397
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5012BEA1;
	Wed, 28 Feb 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hz9c8uVA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BB1292F5
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118723; cv=none; b=cmdArMIXUkYSbZldQ1wVMnXpPBEs6HEH1VpaHAFuAd//NXuMhKaZbsKxwl+QFseU5pMVltuEtgBglzq8TwyuQcXku1xxxwWSlNb1rxdQvA4TsDGVyBaZ1gyZGmtwOFFcP7YU+PnBBQQUu2pCcdIq/r49uDTZ017yPQqAxha6c8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118723; c=relaxed/simple;
	bh=WyoTElTLbucLCjgz7Zc4Lnin5COFihGmksaMg3w+GpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXHtiG5oz20i96nLIykS1fNcqToumRkU26sLr42jgtiE6cn6KhfMALN5Se0q0x1v0k1PwXN6xF+RB+GJVLp13FuTfARn3FYdmbfjPhsyy2mKwi98CnzbwAIMkcgyr24aA1+FQQv77OtQAweYiGuVb1ABlwE6ra0RRmvqL8STspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hz9c8uVA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XykWehRh/Q3JKZpNubsMMCwtMQpxQixWGPomFz/fw1E=; t=1709118721; x=1710328321; 
	b=Hz9c8uVArro6xuvdhIRh6/I3JVSkalAgblWHmYW81KhNAUL3kXsRvGWVR5TozE5ynNk0pA6vDVU
	0TZ809zNTvM5oxVT5AXWSXUuc5WPZxSB0HTD2TFf+roeX9JNFJx3ddV8dR+kubQ9+pWta/zD6dEQC
	Q4fuvBfYcD3w5koA610V7/U2G261OJmeodDtzxq1GvpCkUbNXSX9eUq6Mlgufabd69b37pQR84wLA
	1+E7uf99vXEtoXEYcXxmZHr59a8B1I1P8GyU0BHPY5vKjN4koHxnNVgweeky7rTt5XVqRHJ3ngAN6
	AKSo+BnBhifcjCEjUXFmxjxm6zzM2YJ8aHgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfHqw-0000000C5pS-10Tv;
	Wed, 28 Feb 2024 12:11:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cw1200: restore endian swapping
Date: Wed, 28 Feb 2024 12:11:56 +0100
Message-ID: <20240228121156.62f820aa6dfb.Ia63314e4d0ed1ee76f100846d68f0722abf6b793@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The code here looks well thought-out, so it seems likely
that the byte-swaps are actually needed, due to SPI bus
and device behaviour. Restore the byte-swapping, in a way
that doesn't result in sparse warnings.

Fixes: 7ceade653429 ("wifi: cw1200: fix __le16 sparse warnings")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/st/cw1200/cw1200_spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index fb3aafcafe18..4f346fb977a9 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -81,6 +81,9 @@ static int cw1200_spi_memcpy_fromio(struct hwbus_priv *self,
 	pr_info("READ : %04d from 0x%02x (%04x)\n", count, addr, regaddr);
 #endif
 
+	/* Header is LE16 */
+	regaddr = (__force u16)cpu_to_le16(regaddr);
+
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
 	*/
@@ -143,6 +146,9 @@ static int cw1200_spi_memcpy_toio(struct hwbus_priv *self,
 	pr_info("WRITE: %04d  to  0x%02x (%04x)\n", count, addr, regaddr);
 #endif
 
+	/* Header is LE16 */
+	regaddr = (__force u16)cpu_to_le16(regaddr);
+
 	/* We have to byteswap if the SPI bus is limited to 8b operation
 	   or we are running on a Big Endian system
 	*/
-- 
2.43.2


