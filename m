Return-Path: <linux-wireless+bounces-38210-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d6rvHcY+QGpXeAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38210-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 23:21:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B16D2B13
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 23:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ajnwMPXr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38210-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38210-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EE7301990F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9B37FF6D;
	Sat, 27 Jun 2026 21:20:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1B2DC334
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 21:20:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595257; cv=none; b=tDbKBQCyDvfANpdA+C95G0gBrV592Y1haaWPnuHf+sxfi0MuV654K7OlArwqC2zSSCXWeoIimmQnNRtU32Y1cjBn7T6KDi1EZe2ElbzPM23PFpM0PQTwnZMZ5cmlGysjweng1e1Stn2CS4sMztSEvGcsu6rxZueQ3tKj4IJ/2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595257; c=relaxed/simple;
	bh=2TlzY3SStX4rOVMTDnna/dUrZX2XSX58CAjvEk1AZPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX7Ed5v5eDyb2Mu9/dUc7sxRPsiiShduK1usCUkaq29j+ygZzNdzJnVj41ZJauzV1GgjVPBopMwqt10FzTtbYVqTag1QLqevpo5fOvXHNloaLPozE+AdKfi8VR4SL4ovk31HK/V+IBuSQ6vJ1SH0F50aAMOItRYW4dFxu1W9T3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajnwMPXr; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso92523a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782595254; x=1783200054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SpI8b9qVNOcuW9fmbf+zgoNxBo4Q8Bnb/wxmioU8z88=;
        b=ajnwMPXrlihUNFpehH4kYD09qq1jzQDetnNCM0YRpbW8u4E/vEVRZSS6nldx4uYjir
         D/g+HoTUVTXmtS93Gqv6Sfhg7OAVfEXkOPS343OAHDCs8JNsQ6X2TmpUakyzyqtTiVQI
         1OhHOOGsX+CdUzMx1YQPjYOLwzPA2/UDtLeDbEoAmifT04j5UjunP5fu1ldsVdW8sA7Q
         2xgYdNhsf+Nqc46hVdX55Qj2ZNPoe0r9RrZpV/D163xiHqMTT6CGJrA1OupPj6rcEi7O
         gIrS1LUpXiQW3NZtSTwH7B2QTCxgxMp/2GToTw8wT6cX4c7zgJ/Vp5n+OO8Mw2+URTxz
         BGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782595254; x=1783200054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpI8b9qVNOcuW9fmbf+zgoNxBo4Q8Bnb/wxmioU8z88=;
        b=pvLKgDk4tr3nsijRAdS5MDDzGPDPpvLs1t5OswGPEi3vMhcw1pkbDlbZAnpt44fUgC
         gZ1A1sf1UsYcmBNpGyAsNVobGp/k7bs0+3TvuPONpp3akc76k/P1K6rpQpWk8etkNUsA
         yomF8RQpLXB5cTZxWpMfv5ukTpix4Jf3TkBFfhyhlUnh40IBv0Og1sFoa0D80IM+jzA5
         RWCG0VySWkHmTOygpaWHG0oLxWUVOMw5U1KFAJnMi9rz2g2r7Z6yqm++ZmXLPqMNC7KK
         vls+LklfaPO2S+LKg9wIqCTaSHLYdiEivazouxJ+g+4rEwmi3WZnOtPYfooyKgd2LlGH
         OLfw==
X-Gm-Message-State: AOJu0Yztjr1MzeLS0vUQ7OOqAkSrDbgNj/PWSRns/FgB5VTr+nxopw0D
	y6YzZ8BfXsPdv/wiYpOJ7jW4Q6AnsVauZ5FiTV+plv8ypEeqF469qE1XJZDAyw==
X-Gm-Gg: AfdE7clDax4+Oc+naaVzvdmMhgQx7GbgAFXAWvjCvKZEGJR2qorGJqaSaqnVVzivHnL
	SNLUtCWrMkSHYxlbfJBsCFQHRZoMF+7zsszowqGv4LbjBmZJEu/gCx0SIPcnaqM5Zegw6Ku2Uk5
	zLb5jTfbloxl/aNipNqBi5AcElD89spUQj0GOVQouNtSpc7iPu0eBOUllp0u9xbHgJYI5YBMooh
	Dt0/ovmkfz7yILjipm2rw8hhlfaCKEN0UReFszT/Xc+eH0Zykl+4zdqvTOu9cYbZ6trHDjaN10r
	XyD5IXVz0AGvJTY+W8OQ0/ZvAUkdyGVh+NhDXFfVu/WISlp30wqbkzaBkvq/C4I6OpzGqOM24L3
	0AmQx8G4nVy3Mz5ibBUhb7wwdK5qlg0LQ84RD56QEJE0Lj4TClVlZhDHzSKmnghmkao/00Jh/KV
	CG8kwLvdd5uQer91GAbzuy9M0rOkM61/kUoxs7VvOiD3CoRLtnJ/1yf+IHiCRxr/kDAXqvHoU91
	8uJiASvTw==
X-Received: by 2002:a05:6a00:18a0:b0:845:c906:5ff5 with SMTP id d2e1a72fcca58-845c9066636mr8100051b3a.30.1782595254088;
        Sat, 27 Jun 2026 14:20:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4002c51sm8872860b3a.27.2026.06.27.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:20:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv4 ath-next] wifi: ath9k: eeprom: drop static from local pdadc and vpdTable arrays
Date: Sat, 27 Jun 2026 14:20:51 -0700
Message-ID: <20260627212051.433896-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[toke.dk,kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38210-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B65B16D2B13

Remove the static qualifier from mutable local arrays in three EEPROM
power-calibration functions.  These arrays are written to during normal
operation, so static storage is both unnecessary and misleading: it
implies sharing across calls when no such sharing is intended, and it
makes the code subtly non-reentrant.  The sibling function in
eeprom_9287.c already uses an automatic (stack-local) pdadcValues,
confirming this is the correct pattern.

This keeps ~1 KB of data off the static data section at the cost of
stack usage, consistent with the rest of the driver's coding style.

As a safety measure, also add bounds validation for the EEPROM-derived
loop limits and indices that drive these arrays.  Without these guards,
a malformed EEPROM calibration dataset can cause stack buffer overflows
(vpdTable rows are 64 bytes but the fill loop runs up to 128 iterations),
out-of-bounds reads when the VPD table has fewer than 2 entries, a
negative-index fallback when numXpdGains == 0, and unbounded shifts in
the pdadc adjustment functions.  All of these are reachable through
on-device EEPROM data and were latent as BSS corruptions before the
stack move.

Also alias vpdTableI onto vpdTableL to shrink stack frame

vpdTableL, vpdTableR, and vpdTableI are never live simultaneously.
vpdTableL and vpdTableR are consumed during the frequency-interpolation
step that writes vpdTableI; after the if/else they are never read
again.  Reuse vpdTableL for the interpolated result (what was
vpdTableI), reducing the stack frame by one 256-byte array.

The read-via-write in the else branch is safe: ath9k_hw_interpolate()
receives vpdTableL[i][j] by value as a function argument before the
return value is written back to vpdTableL[i][j].

Stack frame size change (x86_64, clang):
  before: 0x440 (1088 B)
  after:  0x330 (816 B)

Also fix two pre-existing bugs identified in review:

 - When numXpdGains == 0 and eeprom_4k is false, the fallback read
   pPdGainBoundaries[i - 1] accessed index -1.  Guard with i > 0 and
   fall back to MAX_RATE_POWER.

 - In both eeprom_def.c and eeprom_9287.c, the PDADC padding loops
   extended the unshifted element at NUM_PDADC_VALUES - diff instead
   of the last shifted element at NUM_PDADC_VALUES - diff - 1, which
   could cause a discontinuous drop in the calibration curve's tail.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com
---
 v4: fix two off by one issues
 v3: clean up based on review
 v2: add bounds checks
 drivers/net/wireless/ath/ath9k/eeprom.c      | 115 +++++++++++++------
 drivers/net/wireless/ath/ath9k/eeprom_4k.c   |   2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c |  33 ++++--
 drivers/net/wireless/ath/ath9k/eeprom_def.c  |  12 +-
 4 files changed, 113 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index df58dc02e104..d4f1d34510e9 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -241,11 +241,24 @@ void ath9k_hw_fill_vpd_table(u8 pwrMin, u8 pwrMax, u8 *pPwrList,
 			     u8 *pVpdList, u16 numIntercepts,
 			     u8 *pRetVpdList)
 {
-	u16 i, k;
+	u16 i, k, maxIndex;
+	u16 range;
 	u8 currPwr = pwrMin;
 	u16 idxL = 0, idxR = 0;
 
-	for (i = 0; i <= (pwrMax - pwrMin) / 2; i++) {
+	if (pwrMax < pwrMin) {
+		pr_warn_ratelimited("ath9k: VPD table pwrMax (%u) < pwrMin (%u)\n", pwrMax, pwrMin);
+		memset(pRetVpdList, 0, AR5416_MAX_PWR_RANGE_IN_HALF_DB);
+		return;
+	}
+
+	range = (pwrMax - pwrMin) / 2;
+	maxIndex = min_t(u16, range, AR5416_MAX_PWR_RANGE_IN_HALF_DB - 1);
+	if (range >= AR5416_MAX_PWR_RANGE_IN_HALF_DB)
+		pr_warn_ratelimited("ath9k: VPD table range %u exceeds maximum, clamped to %u\n",
+				    range, maxIndex);
+
+	for (i = 0; i <= maxIndex; i++) {
 		ath9k_hw_get_lower_upper_index(currPwr, pPwrList,
 					       numIntercepts, &(idxL),
 					       &(idxR));
@@ -460,12 +473,8 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 	int i, j, k;
 	int16_t ss;
 	u16 idxL = 0, idxR = 0, numPiers;
-	static u8 vpdTableL[AR5416_NUM_PD_GAINS]
-		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
-	static u8 vpdTableR[AR5416_NUM_PD_GAINS]
-		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
-	static u8 vpdTableI[AR5416_NUM_PD_GAINS]
-		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
+	u8 vpdTableL[AR5416_NUM_PD_GAINS][AR5416_MAX_PWR_RANGE_IN_HALF_DB];
+	u8 vpdTableR[AR5416_NUM_PD_GAINS][AR5416_MAX_PWR_RANGE_IN_HALF_DB];
 
 	u8 *pVpdL, *pVpdR, *pPwrL, *pPwrR;
 	u8 minPwrT4[AR5416_NUM_PD_GAINS];
@@ -473,6 +482,8 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 	int16_t vpdStep;
 	int16_t tmpVal;
 	u16 sizeCurrVpdTable, maxIndex, tgtIndex;
+	u16 vpdRange, vpdFillMax;
+	u16 vpdFillMaxArr[AR5416_NUM_PD_GAINS];
 	bool match;
 	int16_t minDelta = 0;
 	struct chan_centers centers;
@@ -506,30 +517,27 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 				minPwrT4[i] = data_9287[idxL].pwrPdg[i][0];
 				maxPwrT4[i] = data_9287[idxL].pwrPdg[i][intercepts - 1];
 				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
-						data_9287[idxL].pwrPdg[i],
-						data_9287[idxL].vpdPdg[i],
-						intercepts,
-						vpdTableI[i]);
+							data_9287[idxL].pwrPdg[i],
+							data_9287[idxL].vpdPdg[i], intercepts,
+							vpdTableL[i]);
 			}
 		} else if (eeprom_4k) {
 			for (i = 0; i < numXpdGains; i++) {
 				minPwrT4[i] = data_4k[idxL].pwrPdg[i][0];
 				maxPwrT4[i] = data_4k[idxL].pwrPdg[i][intercepts - 1];
 				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
-						data_4k[idxL].pwrPdg[i],
-						data_4k[idxL].vpdPdg[i],
-						intercepts,
-						vpdTableI[i]);
+							data_4k[idxL].pwrPdg[i],
+							data_4k[idxL].vpdPdg[i], intercepts,
+							vpdTableL[i]);
 			}
 		} else {
 			for (i = 0; i < numXpdGains; i++) {
 				minPwrT4[i] = data_def[idxL].pwrPdg[i][0];
 				maxPwrT4[i] = data_def[idxL].pwrPdg[i][intercepts - 1];
 				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
-						data_def[idxL].pwrPdg[i],
-						data_def[idxL].vpdPdg[i],
-						intercepts,
-						vpdTableI[i]);
+							data_def[idxL].pwrPdg[i],
+							data_def[idxL].vpdPdg[i], intercepts,
+							vpdTableL[i]);
 			}
 		}
 	} else {
@@ -567,19 +575,37 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						intercepts,
 						vpdTableR[i]);
 
-			for (j = 0; j <= (maxPwrT4[i] - minPwrT4[i]) / 2; j++) {
-				vpdTableI[i][j] =
-					(u8)(ath9k_hw_interpolate((u16)
-					     FREQ2FBIN(centers.
-						       synth_center,
-						       IS_CHAN_2GHZ
-						       (chan)),
-					     bChans[idxL], bChans[idxR],
-					     vpdTableL[i][j], vpdTableR[i][j]));
+			vpdRange = (maxPwrT4[i] >= minPwrT4[i]) ? (maxPwrT4[i] - minPwrT4[i]) / 2 :
+								  0;
+			vpdFillMax = min_t(u16, vpdRange, AR5416_MAX_PWR_RANGE_IN_HALF_DB - 1);
+			/*
+			 * vpdTableL doubles as the interpolated output in-place.
+			 * ath9k_hw_interpolate() receives vpdTableL[i][j] by
+			 * value (left-pier data) before the return overwrites
+			 * vpdTableL[i][j], and each column j is read only once
+			 * per iteration - safe as long as vpdTableR remains a
+			 * separate buffer.
+			 */
+			for (j = 0; j <= vpdFillMax; j++) {
+				vpdTableL[i][j] = (u8)(ath9k_hw_interpolate(
+					(u16)FREQ2FBIN(centers.synth_center, IS_CHAN_2GHZ(chan)),
+					bChans[idxL], bChans[idxR], vpdTableL[i][j],
+					vpdTableR[i][j]));
 			}
 		}
 	}
 
+	/*
+	 * Compute safe VPD table index limit for each gain row.
+	 * This mirrors the vpdFillMax computation in the else-branch
+	 * interpolation above - both clamp the same derived value.
+	 */
+	for (i = 0; i < numXpdGains; i++) {
+		vpdFillMaxArr[i] = min_t(
+			u16, (maxPwrT4[i] >= minPwrT4[i]) ? (maxPwrT4[i] - minPwrT4[i]) / 2 : 0,
+			AR5416_MAX_PWR_RANGE_IN_HALF_DB - 1);
+	}
+
 	k = 0;
 
 	for (i = 0; i < numXpdGains; i++) {
@@ -605,33 +631,39 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 					(minPwrT4[i] / 2)) -
 				       tPdGainOverlap + 1 + minDelta);
 		}
-		vpdStep = (int16_t)(vpdTableI[i][1] - vpdTableI[i][0]);
+		sizeCurrVpdTable = vpdFillMaxArr[i] + 1;
+
+		if (sizeCurrVpdTable >= 2)
+			vpdStep = (int16_t)(vpdTableL[i][1] - vpdTableL[i][0]);
+		else
+			vpdStep = 1; /* no entries to diff; avoids zero-step extrapolation */
 		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
 
 		while ((ss < 0) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-			tmpVal = (int16_t)(vpdTableI[i][0] + ss * vpdStep);
+			tmpVal = (int16_t)(vpdTableL[i][0] + ss * vpdStep);
 			pPDADCValues[k++] = (u8)((tmpVal < 0) ? 0 : tmpVal);
 			ss++;
 		}
-
-		sizeCurrVpdTable = (u8) ((maxPwrT4[i] - minPwrT4[i]) / 2 + 1);
 		tgtIndex = (u8)(pPdGainBoundaries[i] + tPdGainOverlap -
 				(minPwrT4[i] / 2));
 		maxIndex = (tgtIndex < sizeCurrVpdTable) ?
 			tgtIndex : sizeCurrVpdTable;
 
 		while ((ss < maxIndex) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-			pPDADCValues[k++] = vpdTableI[i][ss++];
+			pPDADCValues[k++] = vpdTableL[i][ss++];
 		}
 
-		vpdStep = (int16_t)(vpdTableI[i][sizeCurrVpdTable - 1] -
-				    vpdTableI[i][sizeCurrVpdTable - 2]);
+		if (sizeCurrVpdTable >= 2)
+			vpdStep = (int16_t)(vpdTableL[i][sizeCurrVpdTable - 1] -
+					    vpdTableL[i][sizeCurrVpdTable - 2]);
+		else
+			vpdStep = 1; /* no entries to diff; avoids zero-step extrapolation */
 		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
 
 		if (tgtIndex >= maxIndex) {
 			while ((ss <= tgtIndex) &&
 			       (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-				tmpVal = (int16_t)((vpdTableI[i][sizeCurrVpdTable - 1] +
+				tmpVal = (int16_t)((vpdTableL[i][sizeCurrVpdTable - 1] +
 						    (ss - maxIndex + 1) * vpdStep));
 				pPDADCValues[k++] = (u8)((tmpVal > 255) ?
 							 255 : tmpVal);
@@ -642,14 +674,21 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 
 	if (eeprom_4k)
 		pdgain_boundary_default = 58;
-	else
+	else if (i > 0)
 		pdgain_boundary_default = pPdGainBoundaries[i - 1];
+	else
+		pdgain_boundary_default = MAX_RATE_POWER;
 
 	while (i < AR5416_PD_GAINS_IN_MASK) {
 		pPdGainBoundaries[i] = pdgain_boundary_default;
 		i++;
 	}
 
+	/* Ensure the table contains at least one valid element. */
+	if (k == 0) {
+		WARN_ONCE(1, "ath9k: no PDADC values produced for gain boundaries\n");
+		pPDADCValues[k++] = 0;
+	}
 	while (k < AR5416_NUM_PDADC_VALUES) {
 		pPDADCValues[k] = pPDADCValues[k - 1];
 		k++;
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_4k.c b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
index 3e16cfe059f3..eec7efdc21c3 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_4k.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_4k.c
@@ -288,7 +288,7 @@ static void ath9k_hw_set_4k_power_cal_table(struct ath_hw *ah,
 	struct cal_data_per_freq_4k *pRawDataset;
 	u8 *pCalBChans = NULL;
 	u16 pdGainOverlap_t2;
-	static u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
+	u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
 	u16 gainBoundaries[AR5416_PD_GAINS_IN_MASK];
 	u16 numPiers, i, j;
 	u16 numXpdGain, xpdMask;
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_9287.c b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
index c139ac49ccf6..951943d71339 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
@@ -366,6 +366,15 @@ static void ath9k_hw_set_ar9287_power_cal_table(struct ath_hw *ah,
 	int16_t diff = 0;
 	struct ar9287_eeprom *pEepData = &ah->eeprom.map9287;
 
+	/*
+	 * pdadcValues must be zeroed here: under EEP_OL_PWRCTRL the
+	 * ath9k_hw_get_gain_boundaries_pdadcs() init path is skipped and
+	 * only the unconditional diff-offset shift below runs, which would
+	 * otherwise operate on indeterminate stack data.  eeprom_def.c
+	 * does not need this because both branches of its OLC/!OLC fork
+	 * fully populate the array.
+	 */
+	memset(pdadcValues, 0, sizeof(pdadcValues));
 	xpdMask = pEepData->modalHeader.xpdGain;
 
 	if (ath9k_hw_ar9287_get_eeprom_rev(ah) >= AR9287_EEP_MINOR_VER_2)
@@ -463,13 +472,23 @@ static void ath9k_hw_set_ar9287_power_cal_table(struct ath_hw *ah,
 					     (int32_t)AR9287_PWR_TABLE_OFFSET_DB);
 				diff *= 2;
 
-				for (j = 0; j < ((u16)AR5416_NUM_PDADC_VALUES-diff); j++)
-					pdadcValues[j] = pdadcValues[j+diff];
-
-				for (j = (u16)(AR5416_NUM_PDADC_VALUES-diff);
-				     j < AR5416_NUM_PDADC_VALUES; j++)
-					pdadcValues[j] =
-					  pdadcValues[AR5416_NUM_PDADC_VALUES-diff];
+				/* diff is safe: the bounds check above ensures
+				 * it is in [0, AR5416_NUM_PDADC_VALUES), so the
+				 * subtraction AR5416_NUM_PDADC_VALUES - diff
+				 * cannot underflow.
+				 */
+				if (diff >= 0 && diff < AR5416_NUM_PDADC_VALUES) {
+					for (j = 0; j < ((u16)AR5416_NUM_PDADC_VALUES - diff); j++)
+						pdadcValues[j] = pdadcValues[j + diff];
+
+					for (j = (u16)(AR5416_NUM_PDADC_VALUES - diff);
+					     j < AR5416_NUM_PDADC_VALUES; j++)
+						pdadcValues[j] =
+							pdadcValues[AR5416_NUM_PDADC_VALUES - diff - 1];
+				} else {
+					ath_warn(ath9k_hw_common(ah),
+						 "ignoring invalid PDADC offset %d\n", diff);
+				}
 			}
 
 			if (!ath9k_hw_ar9287_get_eeprom(ah, EEP_OL_PWRCTRL)) {
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 5ba467cb7425..07ce4c8baa85 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -744,14 +744,20 @@ static void ath9k_adjust_pdadc_values(struct ath_hw *ah,
 	 */
 	if (AR_SREV_9280_20_OR_LATER(ah)) {
 		if (AR5416_PWR_TABLE_OFFSET_DB != pwr_table_offset) {
+			if (diff < 0 || diff >= AR5416_NUM_PDADC_VALUES) {
+				ath_warn(ath9k_hw_common(ah), "ignoring invalid PDADC offset %d\n",
+					 diff);
+				return;
+			}
+
 			/* shift the table to start at the new offset */
-			for (k = 0; k < (u16)NUM_PDADC(diff); k++ ) {
+			for (k = 0; k < (u16)NUM_PDADC(diff); k++) {
 				pdadcValues[k] = pdadcValues[k + diff];
 			}
 
 			/* fill the back of the table */
 			for (k = (u16)NUM_PDADC(diff); k < NUM_PDADC(0); k++) {
-				pdadcValues[k] = pdadcValues[NUM_PDADC(diff)];
+				pdadcValues[k] = pdadcValues[NUM_PDADC(diff) - 1];
 			}
 		}
 	}
@@ -769,7 +775,7 @@ static void ath9k_hw_set_def_power_cal_table(struct ath_hw *ah,
 	struct cal_data_per_freq *pRawDataset;
 	u8 *pCalBChans = NULL;
 	u16 pdGainOverlap_t2;
-	static u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
+	u8 pdadcValues[AR5416_NUM_PDADC_VALUES];
 	u16 gainBoundaries[AR5416_PD_GAINS_IN_MASK];
 	u16 numPiers, i, j;
 	int16_t diff = 0;
-- 
2.54.0


