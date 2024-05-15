Return-Path: <linux-wireless+bounces-7689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8028C69D0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C476BB22102
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D3149DEE;
	Wed, 15 May 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="n+ZA9Vuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E564CFC
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787245; cv=none; b=awBmaOMfKxgCRD2Ak9nWzIzt5DXCMFkAZ4Rtiu8MGvOQU5dlJuYrcXTxk0Te1nD9W56WAAN0j2gjIvx8q9lAWQi/KAVmOc2xicvcIjrENHLJzUWerCLAzAakzn1z24m3OZ9xU7+S1VI9HDZueO8Hg9qCSajWRPzNXg6omhoMN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787245; c=relaxed/simple;
	bh=IVhb2NrUCokpY4cNK6fNDUktZNpV7voUV/WdjZLSZAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7JwkIn+B2Psrfv3ZHJEzuG6gSjYicpx4JVjGiGvBwaPVrfpAsLmmE/lA+2s383HOzy7KqYzqfdx/MN8w8MMYJffplE1wvVYQJKkLxOpBhtr3506K0PrJ5BbkMzQXWdNLUVmilqeBTRNOld6gskXYsN3SyuwGgXu3gXJ1lL6sJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=n+ZA9Vuj; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id B97F56461F
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 18:28:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 1DB93608EE;
	Wed, 15 May 2024 18:28:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WSiZ840mGGk0-uoJGfuop;
	Wed, 15 May 2024 18:28:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715786912; bh=UjVTtnYHEsgvGZdww01O/bSkR/lSofi21wdINCs3rMA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=n+ZA9VujAxLVUPVdpS/QnaldaEhwvSReKkRgKw9QgPTXr4DabCOzB7xY1w6D7zEpa
	 Hz6rYYptIWTcHlULuA6B6pVlmM5TrTU/GSMU9zcoglx1tbBp2zUpGhPR2K3FbYnPxQ
	 BpmCwoRUUFTCZgJLmaQU/h+/302YyYfyLE7h5pi0=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] rt2x00: remove unused delayed work data from link description
Date: Wed, 15 May 2024 18:28:24 +0300
Message-ID: <20240515152824.143537-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused 'agc_work' and 'vco_work' members of 'struct link'.
This follows commit d96324703ffa ("rt2x00: merge agc and vco works
with link tuner") where AGC and VCO calibration code was completely
redesigned. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 82af01448a0a..bb648f95dfdd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -335,16 +335,6 @@ struct link {
 	struct delayed_work watchdog_work;
 	unsigned int watchdog_interval;
 	unsigned int watchdog;
-
-	/*
-	 * Work structure for scheduling periodic AGC adjustments.
-	 */
-	struct delayed_work agc_work;
-
-	/*
-	 * Work structure for scheduling periodic VCO calibration.
-	 */
-	struct delayed_work vco_work;
 };
 
 enum rt2x00_delayed_flags {
-- 
2.45.0


