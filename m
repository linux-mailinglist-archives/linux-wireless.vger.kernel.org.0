Return-Path: <linux-wireless+bounces-21556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEFBA8A3A4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D27A15A5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3599211472;
	Tue, 15 Apr 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXUGqz5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DF1E47B0;
	Tue, 15 Apr 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733200; cv=none; b=VooEuC5LqNJXfs/buDge/7xRiX4rXk6lNjZSk5beptHr3pjJaIdX0yrWeJi3jga19nsZl+L6QicTHOL6Z6A8LHJb8Ua+JiqZf/etPTAWGgg72+QM2P3/ErPwdgg0AWRcCQNyiHE33+0XOGORjnMM1F4tu6YnWImHfPHpMgAsH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733200; c=relaxed/simple;
	bh=DL+aIKoAnPQVQHmnFovgdIMvA3Y5jYrsjJ70RR8dZXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b+yOux6zZVeMV2zXsfjMqIfBpnqpxi8OzRaXJH3aVCpQoQ0DkRwOKqI+uCPnmc+4uv2wTIAmwTZrPtC6bXKlerWr/SxrX1HH0W4YHHE+qzaWw8bcPVxj9z+BR8ri2HfHXr7Y/XHqYrHsBdrSVNTKRAw+VBqMKsbpR9wYwkAkQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXUGqz5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B94C4CEEB;
	Tue, 15 Apr 2025 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733200;
	bh=DL+aIKoAnPQVQHmnFovgdIMvA3Y5jYrsjJ70RR8dZXA=;
	h=From:Date:Subject:To:Cc:From;
	b=LXUGqz5mUxnvMBG6PBYmkxTDN7+HJarJzj/QWuID/R4InrcdX4UVNlKZ4QBMAwqSu
	 +fSDA4N4GV5fHZ1MOdbCQVK8Ml2bXFsHn+hS3rixSybKhjuyNJvWQGiphJfmcbFk6b
	 uF532ejxOgjfTNYzprHOTnlUhJwB3LKZRoZQh/ZgYAdF3BEJcwTWuoOSYb33acrKb9
	 87vRRFEgtB1ruIH4hJuAxzs8QPTbtfhMNPt8UJ6RjJkqKsxLdATJ94Y4OUQnlBLGeT
	 mXUp1ES35yUzppKUKdc0ySOrD24H8ECw883kRWjWMz12IZ/UWF5xqZ/uuCL4NOrYOj
	 91TBJWtzIwZUw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 15 Apr 2025 17:06:34 +0100
Subject: [PATCH] wifi: brcmsmac: Spelling corrections
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-brcmsmac-spell-v1-1-3e1375586883@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAmE/mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0NT3aSi5Nzi3MRk3eKC1Jwc3TRjY+PElFQjM7NECyWgpoKi1LTMCrC
 B0bG1tQAw7jXPYAAAAA==
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com
X-Mailer: b4 0.14.0

Various spelling corrections as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c     | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h     | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c       | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c     | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c         | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c        | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h        | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c         | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
index 50d817485cf9..0cb64fc56783 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
@@ -198,7 +198,7 @@
 #define	CST4313_SPROM_OTP_SEL_SHIFT		0
 
 /* 4313 Chip specific ChipControl register bits */
- /* 12 mA drive strengh for later 4313 */
+ /* 12 mA drive strength for later 4313 */
 #define CCTRL_4313_12MA_LED_DRIVE    0x00000007
 
 /* Manufacturer Ids */
@@ -453,7 +453,7 @@ ai_buscore_setup(struct si_info *sii, struct bcma_device *cc)
 	/* get chipcommon chipstatus */
 	sii->chipst = bcma_read32(cc, CHIPCREGOFFS(chipstatus));
 
-	/* get chipcommon capabilites */
+	/* get chipcommon capabilities */
 	sii->pub.cccaps = bcma_read32(cc, CHIPCREGOFFS(capabilities));
 
 	/* get pmu rev and caps */
@@ -657,7 +657,7 @@ u16 ai_clkctl_fast_pwrup_delay(struct si_pub *sih)
 }
 
 /*
- *  clock control policy function throught chipcommon
+ *  clock control policy function through chipcommon
  *
  *    set dynamic clk control mode (forceslow, forcefast, dynamic)
  *    returns true if we are forcing fast clock
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
index 90b6e3982d2c..e791dd07ca78 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
@@ -76,7 +76,7 @@
  * conventions for the use the flash space:
  */
 
-/* Minumum amount of flash we support */
+/* Minimum amount of flash we support */
 #define FLASH_MIN		0x00020000	/* Minimum flash size */
 
 #define	CC_SROM_OTP		0x800	/* SROM/OTP address space */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index a767cbb79185..e1d707a7c964 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -479,7 +479,7 @@ void brcms_c_ampdu_reset_session(struct brcms_ampdu_session *session,
 
 /*
  * Preps the given packet for AMPDU based on the session data. If the
- * frame cannot be accomodated in the current session, -ENOSPC is
+ * frame cannot be accommodated in the current session, -ENOSPC is
  * returned.
  */
 int brcms_c_ampdu_add_frame(struct brcms_ampdu_session *session,
@@ -529,7 +529,7 @@ int brcms_c_ampdu_add_frame(struct brcms_ampdu_session *session,
 	}
 
 	/*
-	 * Now that we're sure this frame can be accomodated, update the
+	 * Now that we're sure this frame can be accommodated, update the
 	 * session information.
 	 */
 	session->ampdu_len += len;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
index d1b9a18d0374..3878c4124e25 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
@@ -445,7 +445,7 @@ brcms_c_channel_reg_limits(struct brcms_cm_info *wlc_cm, u16 chanspec,
 
 		/*
 		 * OFDM 40 MHz SISO has the same power as the corresponding
-		 * MCS0-7 rate unless overriden by the locale specific code.
+		 * MCS0-7 rate unless overridden by the locale specific code.
 		 * We set this value to 0 as a flag (presumably 0 dBm isn't
 		 * a possibility) and then copy the MCS0-7 value to the 40 MHz
 		 * value if it wasn't explicitly set.
@@ -479,7 +479,7 @@ brcms_c_channel_reg_limits(struct brcms_cm_info *wlc_cm, u16 chanspec,
 
 		/*
 		 * 20 MHz has the same power as the corresponding OFDM rate
-		 * unless overriden by the locale specific code.
+		 * unless overridden by the locale specific code.
 		 */
 		txpwr->mcs_20_siso[i] = txpwr->ofdm[i];
 		txpwr->mcs_40_siso[i] = 0;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index 80c35027787a..c739bf7463b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -1348,7 +1348,7 @@ static void prep_ampdu_frame(struct dma_info *di, struct sk_buff *p)
 	ret = brcms_c_ampdu_add_frame(session, p);
 	if (ret == -ENOSPC) {
 		/*
-		 * AMPDU cannot accomodate this frame. Close out the in-
+		 * AMPDU cannot accommodate this frame. Close out the in-
 		 * progress AMPDU session and start a new one.
 		 */
 		ampdu_finalize(di);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 5b1d35601bbd..1c3d29dca424 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -48,9 +48,9 @@
 	FIF_BCN_PRBRESP_PROMISC | \
 	FIF_PSPOLL)
 
-#define CHAN2GHZ(channel, freqency, chflags)  { \
+#define CHAN2GHZ(channel, frequency, chflags)  { \
 	.band = NL80211_BAND_2GHZ, \
-	.center_freq = (freqency), \
+	.center_freq = (frequency), \
 	.hw_value = (channel), \
 	.flags = chflags, \
 	.max_antenna_gain = 0, \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 2738d4d6c60a..c1a9c1e442ee 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -921,7 +921,7 @@ brcms_c_dotxstatus(struct brcms_c_info *wlc, struct tx_status *txs)
 		 * The "fallback limit" is the number of tx attempts a given
 		 * MPDU is sent at the "primary" rate. Tx attempts beyond that
 		 * limit are sent at the "secondary" rate.
-		 * A 'short frame' does not exceed RTS treshold.
+		 * A 'short frame' does not exceed RTS threshold.
 		 */
 		u16 sfbl,	/* Short Frame Rate Fallback Limit */
 		    lfbl,	/* Long Frame Rate Fallback Limit */
@@ -6259,7 +6259,7 @@ brcms_c_d11hdrs_mac80211(struct brcms_c_info *wlc, struct ieee80211_hw *hw,
 		}
 
 		/*
-		 * Currently only support same setting for primay and
+		 * Currently only support same setting for primary and
 		 * fallback rates. Unify flags for each rate into a
 		 * single value for the frame
 		 */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
index 9f76b880814e..b7ca0d9891c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
@@ -603,7 +603,7 @@ enum brcms_bss_type {
  * cur_etheraddr: h/w address
  * flags: BSSCFG flags; see below
  *
- * current_bss: BSS parms in ASSOCIATED state
+ * current_bss: BSS parameters in ASSOCIATED state
  *
  *
  * ID: 'unique' ID of this bsscfg, assigned at bsscfg allocation
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
index 71b80381f3ad..c9a29e626daa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c
@@ -31,7 +31,7 @@
 #define EXT_ILP_HZ 32768
 
 /*
- * Duration for ILP clock frequency measurment in milliseconds
+ * Duration for ILP clock frequency measurement in milliseconds
  *
  * remark: 1000 must be an integer multiple of this duration
  */


