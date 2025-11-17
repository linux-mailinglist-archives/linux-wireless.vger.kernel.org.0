Return-Path: <linux-wireless+bounces-29013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08581C620E7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 158B9359E37
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000DA1C8611;
	Mon, 17 Nov 2025 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XcFz2IZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A61DA0E1;
	Mon, 17 Nov 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344976; cv=none; b=LVQzHD2hKae7PC5jiGWqlbqQHNcnl0MpGeIcci02DJGeZRwJzRC9Uw2JAXxb0Yi14xppWmeQRgaPgylt4EHpsSsWRPsPevntRut81YmY7gnzoAL7a3GBs4MBzelZum8t5Oq2QoWkTJjWKp3XG4SoMDatUIuf4dkUyV4/EcgMSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344976; c=relaxed/simple;
	bh=NyJYQPQPTFmfCiFvEIW2HI0NBNy7ZI0/knz896q2P8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ojZTyVmJG96ln9AfZ/AkQLFn/2fM//OCtnH6G8FPHCLgAPSOB28v+jm6nHvLeFcR7d4e6wULLqsCBT033Z3A2wpv0JWg0EjluuoTwajxrKbJLqFnZSuN3FW3k+RSNvTUta8lF+/KqShADuLAQBTsCKAtmKiKE5OW2akXQY3zi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XcFz2IZK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IMGCBVpvG2vZ+nIjmlkwW1kKDty6Rb9NUxkCfmhsHus=; b=XcFz2IZKfQhmE9lKPtopCNB7K0
	X+4rMO0SkAua1jHVKO5XiuuLHmE/zWJgTrt0xgXv7Ef0UeV1HsVouov+aCoe5wjm5iiOvxPzP8+Mo
	9/EbDA3a5OmFof1emVAtmom8SDbwY5tAQ2BjDtMRo+49zL2I04BX1XAM6Up7pECZILzMzD/o/8V72
	cW4FSY+fLJGQ6FHuhJeiwxqBlgj8BUNpiejGVH6kJJmeJeSlihBA7CRYFIEOAc6gK6J5f2v0UjS1h
	KwUYXFJOAEZlCkkEREoie5AxYaRY/b5i0u01r6S/tXuuKRVzjDFK4Cut6L4wX9inc3yXAfGU4Lwzl
	ifpyXvKw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKoZw-0000000FHuG-2LAb;
	Mon, 17 Nov 2025 02:02:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] ath9k-common: fix kernel-doc warnings in common-debug.h
Date: Sun, 16 Nov 2025 18:02:50 -0800
Message-ID: <20251117020251.447692-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Modify kernel-doc comments in common-debug.h to avoid warnings:

Warning: drivers/net/wireless/ath/ath9k/common-debug.h:21 bad line:
  may have had errors.
Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:23 bad line:
  may have had errors.
Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:26 bad line:
  decryption process completed
Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:28 bad line:
  encountered an error

Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debugfs.")
Fixes: 1395d3f00a41 ("ath9k: Add debugfs file for RX errors") (last 2)
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Toke Høiland-Jørgensen <toke@toke.dk>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath9k/common-debug.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20251107.orig/drivers/net/wireless/ath/ath9k/common-debug.h
+++ linux-next-20251107/drivers/net/wireless/ath/ath9k/common-debug.h
@@ -19,14 +19,14 @@
 /**
  * struct ath_rx_stats - RX Statistics
  * @rx_pkts_all:  No. of total frames received, including ones that
-	may have had errors.
+ *	may have had errors.
  * @rx_bytes_all:  No. of total bytes received, including ones that
-	may have had errors.
+ *	may have had errors.
  * @crc_err: No. of frames with incorrect CRC value
  * @decrypt_crc_err: No. of frames whose CRC check failed after
-	decryption process completed
+ *	decryption process completed
  * @phy_err: No. of frames whose reception failed because the PHY
-	encountered an error
+ *	encountered an error
  * @mic_err: No. of frames with incorrect TKIP MIC verification failure
  * @pre_delim_crc_err: Pre-Frame delimiter CRC error detections
  * @post_delim_crc_err: Post-Frame delimiter CRC error detections

