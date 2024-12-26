Return-Path: <linux-wireless+bounces-16802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6C9FC747
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 02:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9ED1882C03
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92B288B1;
	Thu, 26 Dec 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="R20UgJ7s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFE182D0;
	Thu, 26 Dec 2024 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735175650; cv=none; b=nhqElyiosH3NbpAZcvGoY/5TFmoz1Sn8ZsOAqhifHKZVi1zFN608XGTL3gTDyWNrqR3bisBYvBzy9rI7RFZVoRAn6z77ZC5Wn3TEL0p02Bdab2h2g5Z7TDN2UntmX0TKLcMKVVvbUtuPfL+npWh50EEG7CfM0rY5xD3c3X1IHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735175650; c=relaxed/simple;
	bh=TrpzMhk/hiw2YNUGDv8KvgtSjlC5YUyVaL8iNu+ukhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOuEKDPAuYxs6R9iW0T1kTzWDCpcnzl8C9Iwy0tgApEMVPwtQ71BsmdUG0NSq0X/2p+LgD+C1/tiZg/vPF/K+ZshURrGYCkXltQDCoY+Ch80hVYvHtRNpCgd3ROiSnJ8cSEC1cIdanMDReeIv7wnvr6ye0hOji1PSItMyz7sVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=R20UgJ7s; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=htMGniYlE/3z8UCQIt/xDXCDtVGaQRqdewXDtgS1OCY=; b=R20UgJ7so4rEDt+R
	u8htab/1vonxbOuh2zMXE12hBi0MKn0Jo+stFSGqbtWNcIHxUFbEglvZnA5xwmszERzKlHoperJ0R
	xFsk5YhmLhyUbWh37NEqOmBCmjAahjSRA/38gjgEKn5GX6VWfZy08H0+Rrf4LzMGTUNW7Cln8XZPm
	k7y1iZEewVDTk5DqiwDNvPyIMHDuZkLNFGrotIEE24yM5jwMoc1frQVZ5viYYc1U/+VkyaAl/K4RZ
	OWBJ7tF6tcAZZg6lVMEqwsEL3Z2OTuvG4CRMgqVj423hGm3TKjWatDu0qyb1+mvwvCIOTe7e8QX8h
	MLugbW3Tsqnz8bGFQg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQcRo-007EdY-1L;
	Thu, 26 Dec 2024 01:13:56 +0000
From: linux@treblig.org
To: stf_xl@wp.pl,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio
Date: Thu, 26 Dec 2024 01:13:54 +0000
Message-ID: <20241226011355.135417-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226011355.135417-1-linux@treblig.org>
References: <20241226011355.135417-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of il3945_calc_db_from_ratio() was removed in 2010 by
commit ed1b6e99b5e6 ("iwlwifi: remove noise reporting")
when it was still called iwl3945_calc_db_from_ratio().

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/wireless/intel/iwlegacy/3945-mac.c    | 38 -------------------
 drivers/net/wireless/intel/iwlegacy/3945.h    |  1 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 74fc76c00ebc..4013443698a2 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -1127,44 +1127,6 @@ il3945_rx_queue_free(struct il_priv *il, struct il_rx_queue *rxq)
 	rxq->rb_stts = NULL;
 }
 
-/* Convert linear signal-to-noise ratio into dB */
-static u8 ratio2dB[100] = {
-/*	 0   1   2   3   4   5   6   7   8   9 */
-	0, 0, 6, 10, 12, 14, 16, 17, 18, 19,	/* 00 - 09 */
-	20, 21, 22, 22, 23, 23, 24, 25, 26, 26,	/* 10 - 19 */
-	26, 26, 26, 27, 27, 28, 28, 28, 29, 29,	/* 20 - 29 */
-	29, 30, 30, 30, 31, 31, 31, 31, 32, 32,	/* 30 - 39 */
-	32, 32, 32, 33, 33, 33, 33, 33, 34, 34,	/* 40 - 49 */
-	34, 34, 34, 34, 35, 35, 35, 35, 35, 35,	/* 50 - 59 */
-	36, 36, 36, 36, 36, 36, 36, 37, 37, 37,	/* 60 - 69 */
-	37, 37, 37, 37, 37, 38, 38, 38, 38, 38,	/* 70 - 79 */
-	38, 38, 38, 38, 38, 39, 39, 39, 39, 39,	/* 80 - 89 */
-	39, 39, 39, 39, 39, 40, 40, 40, 40, 40	/* 90 - 99 */
-};
-
-/* Calculates a relative dB value from a ratio of linear
- *   (i.e. not dB) signal levels.
- * Conversion assumes that levels are voltages (20*log), not powers (10*log). */
-int
-il3945_calc_db_from_ratio(int sig_ratio)
-{
-	/* 1000:1 or higher just report as 60 dB */
-	if (sig_ratio >= 1000)
-		return 60;
-
-	/* 100:1 or higher, divide by 10 and use table,
-	 *   add 20 dB to make up for divide by 10 */
-	if (sig_ratio >= 100)
-		return 20 + (int)ratio2dB[sig_ratio / 10];
-
-	/* We shouldn't see this */
-	if (sig_ratio < 1)
-		return 0;
-
-	/* Use table for ratios 1:1 - 99:1 */
-	return (int)ratio2dB[sig_ratio];
-}
-
 /*
  * il3945_rx_handle - Main entry function for receiving responses from uCode
  *
diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
index ffbe11902628..fb1e33c89d0e 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.h
+++ b/drivers/net/wireless/intel/iwlegacy/3945.h
@@ -173,7 +173,6 @@ struct il3945_ibss_seq {
  * for use by iwl-*.c
  *
  *****************************************************************************/
-int il3945_calc_db_from_ratio(int sig_ratio);
 void il3945_rx_replenish(void *data);
 void il3945_rx_queue_reset(struct il_priv *il, struct il_rx_queue *rxq);
 unsigned int il3945_fill_beacon_frame(struct il_priv *il,
-- 
2.47.1


