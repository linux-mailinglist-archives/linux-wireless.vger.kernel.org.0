Return-Path: <linux-wireless+bounces-38070-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MPerA+yOPGqBpQgAu9opvQ
	(envelope-from <linux-wireless+bounces-38070-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 04:14:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BA56C2595
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 04:14:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mDjJIT+V;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38070-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38070-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B13301FCA1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7B23A9615;
	Thu, 25 Jun 2026 02:14:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70D3A8FE9
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 02:13:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353641; cv=none; b=JBZYUehXD91gAlwqA1Uwayze7eTqPQmm+nNyHsMGfXxRed3rvXjiFx3exP00T+SFh03BjatI146krEFXMxEHBlPgeoA0ub+nvCPdwSIDuC/dFJgqwXZhpoXQCs5MapQlv515XBKCZKm6W1ozRPOFKeycLUHGFIcggR3fKBBxsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353641; c=relaxed/simple;
	bh=3WbksS4OXC3H/R/y3ene2Smt+05r/VjFWi7qduSGFgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbI3pYgXtN9pZUiwejrm+0xqq/GvzoGE/6uXIQxXpgzhXd0fXFeHXWa5zW58iM44WZUA/oGBFUrFn4dS2smYv0fQcyTvmwehFEYMQ5iJs1ZQe26ZmD+US4MG4iDnW5Ha67/5G4Gr0BXbFfkz92r8tmgGw/L1H7ppqD4y4qujMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDjJIT+V; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37de8c6a2b6so802468a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782353637; x=1782958437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acCx/txA6YotBH4NCsBpzCuBo/7kfUAZ8KYuBks7nNw=;
        b=mDjJIT+VcdmaZfgZkymclKHZPpLsMhF8x38XIjL5/jhjQ4ODER/Js0W5we5CQKn9x5
         dW94ecno1Bn1aroUxPpCeYP02pXSaea8fyGBgy5hgjaQ1R/vXXzkci5HJ4gBHf3UdQP+
         4tjPzgzImkfmUbZmCOJOcEK9dXWjCl03TPsAaQZc6OSz8/J08IUhcV3QnFhf9WuWj8B7
         q/ieKPS4FHmo7sKj/pmpxWC11+Xu3LOPoN0VgPvl1WUTKGMf/tV26nEdE7pthn/Dw0H/
         eYHI5/9/UHucBqxiAFjDPkgattgazjcXSMAi4W5+A8nRtWJ1eQspqx6iTrQfChzEWVs1
         yWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782353637; x=1782958437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acCx/txA6YotBH4NCsBpzCuBo/7kfUAZ8KYuBks7nNw=;
        b=RAKYGziHizICMxM59BegNWxJHHTVZWAx+BnYfdx+xmy3fNa0G6NM7FjYhMEDb89Eiz
         WsKyBsGblA6hB0fPlwhTmZacVRdosrow7N6Cjyp1/kPY0wK1oNjKgqzygB14BzFayC0d
         v726EvSMdZicvBbs6DU3JFHb3vRMJqY0akXq0i3Fv9vhcNeckyn3t3w2kL8yKG8o9pJK
         nGBp59wwgJem4v3tmkjZt5BhicyMCo/5oSVBHF1ZFJZIpQfVGy3BujdHu48Kb1CqIs2a
         hFYK+0gJ1in3cui+mIL52j+j8ikf6oTUSUBLMN3GID8kI5CxXjQLK8tpiDd9oE5NMiXH
         0uUg==
X-Gm-Message-State: AOJu0Yy+zQqS5HQjUuTLhZR6taoHUwWLn5rPbhbV82EV0EXRpNcFz8ID
	H7VZM9Rbu12b03aTkpsHUJjDMYOUIbvGLPG6VfLhWIGG7VvitunAmfvBT/fE6w==
X-Gm-Gg: AfdE7clC5vw3QCR6H1HXB0MmgkuvYilwcQnvdNB3MhHA+P/AhHdYvgxBHBFVxyRud8U
	wTrCefG6ZItmbpOfSWbLnlJfe4/6hnw6ZFJVF7aHJKqAiGDgfVpWaefZo9WLUUitzJOlQlzmBuG
	1XyRfqQckyUWNH8uNWgg86wZ0nGLXjPC3/egYGiQGlWomxXwa38Np1heKRD+gTjR6u2Cc8/2Hpn
	2r6GeLgYuyXpGxPnfH/aZM5/Moo4QQUJKAAcBH4wuKFYTjLTjpD+Xx5+QfCqAKasAhaq1nSPh5l
	QvEFVpaPVMfchocHBF+S0dgeaEhdS8U39sIEpXb5fkqOKeR7o1HBOoa2ztdEhImJlzHBI1pi/no
	knqMfinNRBLApuP3zV80uvQaI9VU7mth2F+MjT9eePeC5rAkzGprDmT2SdM1XQ+v5BzpeftYE2/
	wC2DX9As312Ist1knNnZ1qZ+/FYUOGveDLkqOXE/E0kD66VvfCR/G8qbr7wSRl4cfBCfolfxGVm
	Oz6aICqlg==
X-Received: by 2002:a17:90b:2244:b0:37c:c39c:c636 with SMTP id 98e67ed59e1d1-37dfa231761mr439440a91.18.1782353637374;
        Wed, 24 Jun 2026 19:13:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:5b5d::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b2bd01sm784905a91.9.2026.06.24.19.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:13:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv2 ath-next] wifi: ath9k: eeprom: drop static from local pdadc and vpdTable arrays
Date: Wed, 24 Jun 2026 19:13:55 -0700
Message-ID: <20260625021355.235542-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[toke.dk,kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38070-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7BA56C2595

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

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add bounds checks
 drivers/net/wireless/ath/ath9k/eeprom.c      | 51 ++++++++++++--------
 drivers/net/wireless/ath/ath9k/eeprom_4k.c   |  2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c | 20 +++++---
 drivers/net/wireless/ath/ath9k/eeprom_def.c  | 22 ++++++---
 4 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index df58dc02e104..1f76afb68e8f 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -241,11 +241,18 @@ void ath9k_hw_fill_vpd_table(u8 pwrMin, u8 pwrMax, u8 *pPwrList,
 			     u8 *pVpdList, u16 numIntercepts,
 			     u8 *pRetVpdList)
 {
-	u16 i, k;
+	u16 i, k, maxIndex;
 	u8 currPwr = pwrMin;
 	u16 idxL = 0, idxR = 0;
+	if ((pwrMax - pwrMin) / 2 >= AR5416_MAX_PWR_RANGE_IN_HALF_DB)
+		pr_warn_ratelimited("ath9k: VPD table range %u exceeds maximum %u\n",
+				    (pwrMax - pwrMin) / 2,
+				    AR5416_MAX_PWR_RANGE_IN_HALF_DB - 1);

-	for (i = 0; i <= (pwrMax - pwrMin) / 2; i++) {
+	maxIndex = min_t(u16, (pwrMax - pwrMin) / 2,
+			 AR5416_MAX_PWR_RANGE_IN_HALF_DB - 1);
+
+	for (i = 0; i <= maxIndex; i++) {
 		ath9k_hw_get_lower_upper_index(currPwr, pPwrList,
 					       numIntercepts, &(idxL),
 					       &(idxR));
@@ -460,12 +467,8 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
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
@@ -509,7 +512,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_9287[idxL].pwrPdg[i],
 						data_9287[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		} else if (eeprom_4k) {
 			for (i = 0; i < numXpdGains; i++) {
@@ -519,7 +522,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_4k[idxL].pwrPdg[i],
 						data_4k[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		} else {
 			for (i = 0; i < numXpdGains; i++) {
@@ -529,7 +532,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_def[idxL].pwrPdg[i],
 						data_def[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		}
 	} else {
@@ -568,7 +571,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						vpdTableR[i]);

 			for (j = 0; j <= (maxPwrT4[i] - minPwrT4[i]) / 2; j++) {
-				vpdTableI[i][j] =
+				vpdTableL[i][j] =
 					(u8)(ath9k_hw_interpolate((u16)
 					     FREQ2FBIN(centers.
 						       synth_center,
@@ -605,33 +608,39 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 					(minPwrT4[i] / 2)) -
 				       tPdGainOverlap + 1 + minDelta);
 		}
-		vpdStep = (int16_t)(vpdTableI[i][1] - vpdTableI[i][0]);
+		sizeCurrVpdTable = (u8)((maxPwrT4[i] - minPwrT4[i]) / 2 + 1);
+
+		if (sizeCurrVpdTable >= 2)
+			vpdStep = (int16_t)(vpdTableL[i][1] - vpdTableL[i][0]);
+		else
+			vpdStep = 1;
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
+			vpdStep = 1;
 		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);

 		if (tgtIndex >= maxIndex) {
 			while ((ss <= tgtIndex) &&
 			       (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-				tmpVal = (int16_t)((vpdTableI[i][sizeCurrVpdTable - 1] +
+				tmpVal = (int16_t)((vpdTableL[i][sizeCurrVpdTable - 1] +
 						    (ss - maxIndex + 1) * vpdStep));
 				pPDADCValues[k++] = (u8)((tmpVal > 255) ?
 							 255 : tmpVal);
@@ -650,6 +659,8 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 		i++;
 	}

+	if (k == 0)
+		pPDADCValues[k++] = 0;
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
index c139ac49ccf6..9ee272d5c751 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
@@ -463,13 +463,19 @@ static void ath9k_hw_set_ar9287_power_cal_table(struct ath_hw *ah,
 					     (int32_t)AR9287_PWR_TABLE_OFFSET_DB);
 				diff *= 2;

-				for (j = 0; j < ((u16)AR5416_NUM_PDADC_VALUES-diff); j++)
-					pdadcValues[j] = pdadcValues[j+diff];
-
-				for (j = (u16)(AR5416_NUM_PDADC_VALUES-diff);
-				     j < AR5416_NUM_PDADC_VALUES; j++)
-					pdadcValues[j] =
-					  pdadcValues[AR5416_NUM_PDADC_VALUES-diff];
+				if (diff >= 0 && diff < AR5416_NUM_PDADC_VALUES) {
+					for (j = 0; j < ((u16)AR5416_NUM_PDADC_VALUES - diff); j++)
+						pdadcValues[j] = pdadcValues[j + diff];
+
+					for (j = (u16)(AR5416_NUM_PDADC_VALUES - diff);
+					     j < AR5416_NUM_PDADC_VALUES; j++)
+						pdadcValues[j] =
+							pdadcValues[AR5416_NUM_PDADC_VALUES - diff];
+				} else {
+					ath_warn(ath9k_hw_common(ah),
+						 "ignoring invalid PDADC offset %d\n",
+						 diff);
+				}
 			}

 			if (!ath9k_hw_ar9287_get_eeprom(ah, EEP_OL_PWRCTRL)) {
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 5ba467cb7425..be3e6ab11562 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -744,14 +744,20 @@ static void ath9k_adjust_pdadc_values(struct ath_hw *ah,
 	 */
 	if (AR_SREV_9280_20_OR_LATER(ah)) {
 		if (AR5416_PWR_TABLE_OFFSET_DB != pwr_table_offset) {
-			/* shift the table to start at the new offset */
-			for (k = 0; k < (u16)NUM_PDADC(diff); k++ ) {
-				pdadcValues[k] = pdadcValues[k + diff];
-			}
+			if (diff < 0 || diff >= AR5416_NUM_PDADC_VALUES) {
+				ath_warn(ath9k_hw_common(ah),
+					 "ignoring invalid PDADC offset %d\n",
+					 diff);
+			} else {
+				/* shift the table to start at the new offset */
+				for (k = 0; k < (u16)NUM_PDADC(diff); k++ ) {
+					pdadcValues[k] = pdadcValues[k + diff];
+				}

-			/* fill the back of the table */
-			for (k = (u16)NUM_PDADC(diff); k < NUM_PDADC(0); k++) {
-				pdadcValues[k] = pdadcValues[NUM_PDADC(diff)];
+				/* fill the back of the table */
+				for (k = (u16)NUM_PDADC(diff); k < NUM_PDADC(0); k++) {
+					pdadcValues[k] = pdadcValues[NUM_PDADC(diff)];
+				}
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


