Return-Path: <linux-wireless+bounces-37877-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 66zeN68wM2oG+QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37877-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:41:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C969CD22
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 01:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=puNbBcuG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37877-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37877-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05E31303A244
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8AD39A4DF;
	Wed, 17 Jun 2026 23:41:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA33386559
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 23:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739686; cv=none; b=kl9LsmiciEaDIi//t87F6C8fUPDSejA11lB0w4maM7UsDg6KbtNPHJ6u6vF/dgaYg3FSicH/8Tp65pSaoYP7jjruG/sig/KrtxpIkpnmgwRS4orE7Ek5hh9wuibo3yIC84j7PN+2Pgkbc37WjSKHZ7nocaxCa7NG8YQQ6w/Iizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739686; c=relaxed/simple;
	bh=1xxApD3Hb5TuHMmSOnw8rBFtZGA1Y9mAEd5x7+SWaMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVQ9KugrbefUaJcX7m0QLC3eZizlO4vQh/BtOTW2IWeLrjBXahGXYHv/QqNZb2Gjch+3uUj27llx9MlTtCeCNGHQk7fFcRlfq8uaPJ4bvTrYEJKs9r4d17WoFY7LqDZGjNO6oN+MPICQQwUcCAV0kKE4LxlQolWEcgnSTICRIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puNbBcuG; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso132327a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781739683; x=1782344483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA3VIuiaTabMHHJ9iGApHbWoluO34hyLG8PCxZjsMXM=;
        b=puNbBcuGkGXzf3f8Q+ySJcSYPGOqH23R7OkA4xNlsd3HccByUK3g2xvGR4yTsYK8HO
         TJKXhBGFVIv1GjjqdbFUwFxdtPyEB1DBiyrxaWXOoYDBVaIgXzxPbnUBaNosjcEY8we9
         wjYlT1xEyIahMQJFxufaPlXziDbinuzrX9UiZx6vg0I8nTPJL0e0N9Km86g0K3uMrEWx
         Dbs+1FQZfpI8DZ5U33GtzSEjx+ndOwU+cRrP3Ho1D0R7i/HpyiIzZI5fydREAPjnPM+d
         PL1nHqt329z0EoCX9rcUPVEcJJGjgP8MZJFsi/d7pf8J34XepdKKw93amks+KMdjted3
         zXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781739683; x=1782344483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA3VIuiaTabMHHJ9iGApHbWoluO34hyLG8PCxZjsMXM=;
        b=qsKREXpQ+Xeo1ou3h1NJwVDV4Vwk5oNB/iwHKFpGME7w/CrbzTsRFLrw94+vXByUlp
         xPPvFgIIsZJ9t6+V1lJcHCPBHKQl0E9ia1fjmo96rFuGklfMAOT3G9awsTOf8trVqVUx
         pu2kh04WX9p9XZp2xKeQG/ascSz+Y0X5nx/pES8XIU2fEpihNaZVtQflR1A8XYlIjqLD
         zU4BYy3V759jiIX1QE/Jo45lUQ6bgnRSNNhJQfGBrCZJKFccdpRnGMWxC7qSz5Z3OWQN
         Dv81jTdiQKCkgRtp0rkYFw0wK4POgg5Nz495phjmmz6lKXER0YQ3DxM7OOgRPax7Cj9k
         3DGw==
X-Gm-Message-State: AOJu0YzQT7/p0nn4cPqmqF04+/tVkvipJhvsWeE+LF5XtuPZ+4Aqkr8L
	AdOvRdSm/GIiCTCzSl83YbX4PlMWwz2qupBl9J16EHrdKc8XMVyc00B6pgxlXw==
X-Gm-Gg: AfdE7ckPfKx/3qxTQNlzuO5ItFosB95P7mr8qU//DK7SQDVwC6Kk4T//s5C3ammeikX
	zoKHSBesus3KNT7JdXarHK5b8pmfh2WqgNybK1VbX7Hf4+z6jK9HZxNiPFKE7d4vRAKft0Roh2M
	tg+5X4PKK7VMnAmAXsPK1AZI47ehFsRZriVNPPsrlEBDZVeDn/ZgLsVNzsbH6jL0p2l9ELzFw2z
	WNYM4s1G5RsFsQEbqcBuXU/+jPSK0nl4+/2qBrcJiqoR5Yaph4Jy7DQrXYfKwO13J3vgMHmrU7m
	b9h5bz1U52I4G7uHRsF/YVKH8DbGYrvfBHQkLILUoJSfXVB4n7sSoID9k+N+iOhlPwnM4JbVrUS
	cScfbuh1rsEYYmALlmxbncvFVyVzDvQiyyaQkyBuUZLuHN7M4GWmhP27Di29y8a0qxsh41knNNR
	wKJ9u8T/ps10n73ZHJXWDqeFKM3y2+FDZ8IchJNaV3YS+R4CfXcidLfOfRTrtha3STy20Rvn1JG
	zyHFDg9K6BzUVWNK5iYl8S2
X-Received: by 2002:a17:90a:e7d1:b0:369:1dcf:4a46 with SMTP id 98e67ed59e1d1-37c937055c5mr5722005a91.25.1781739683447;
        Wed, 17 Jun 2026 16:41:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7305:54ba:2fb4:e198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ce68cab02sm238644a91.7.2026.06.17.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 16:41:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH ath-next] ath9k: eeprom: alias vpdTableI onto vpdTableL to shrink stack frame
Date: Wed, 17 Jun 2026 16:41:05 -0700
Message-ID: <20260617234105.284358-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37877-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C8C969CD22

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
 drivers/net/wireless/ath/ath9k/eeprom.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index df58dc02e104..272491ae9f29 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -464,8 +464,6 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
 	static u8 vpdTableR[AR5416_NUM_PD_GAINS]
 		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
-	static u8 vpdTableI[AR5416_NUM_PD_GAINS]
-		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
 
 	u8 *pVpdL, *pVpdR, *pPwrL, *pPwrR;
 	u8 minPwrT4[AR5416_NUM_PD_GAINS];
@@ -509,7 +507,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_9287[idxL].pwrPdg[i],
 						data_9287[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		} else if (eeprom_4k) {
 			for (i = 0; i < numXpdGains; i++) {
@@ -519,7 +517,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_4k[idxL].pwrPdg[i],
 						data_4k[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		} else {
 			for (i = 0; i < numXpdGains; i++) {
@@ -529,7 +527,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						data_def[idxL].pwrPdg[i],
 						data_def[idxL].vpdPdg[i],
 						intercepts,
-						vpdTableI[i]);
+						vpdTableL[i]);
 			}
 		}
 	} else {
@@ -568,7 +566,7 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 						vpdTableR[i]);
 
 			for (j = 0; j <= (maxPwrT4[i] - minPwrT4[i]) / 2; j++) {
-				vpdTableI[i][j] =
+				vpdTableL[i][j] =
 					(u8)(ath9k_hw_interpolate((u16)
 					     FREQ2FBIN(centers.
 						       synth_center,
@@ -605,11 +603,11 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 					(minPwrT4[i] / 2)) -
 				       tPdGainOverlap + 1 + minDelta);
 		}
-		vpdStep = (int16_t)(vpdTableI[i][1] - vpdTableI[i][0]);
+		vpdStep = (int16_t)(vpdTableL[i][1] - vpdTableL[i][0]);
 		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
 
 		while ((ss < 0) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-			tmpVal = (int16_t)(vpdTableI[i][0] + ss * vpdStep);
+			tmpVal = (int16_t)(vpdTableL[i][0] + ss * vpdStep);
 			pPDADCValues[k++] = (u8)((tmpVal < 0) ? 0 : tmpVal);
 			ss++;
 		}
@@ -621,17 +619,17 @@ void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
 			tgtIndex : sizeCurrVpdTable;
 
 		while ((ss < maxIndex) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-			pPDADCValues[k++] = vpdTableI[i][ss++];
+			pPDADCValues[k++] = vpdTableL[i][ss++];
 		}
 
-		vpdStep = (int16_t)(vpdTableI[i][sizeCurrVpdTable - 1] -
-				    vpdTableI[i][sizeCurrVpdTable - 2]);
+		vpdStep = (int16_t)(vpdTableL[i][sizeCurrVpdTable - 1] -
+				    vpdTableL[i][sizeCurrVpdTable - 2]);
 		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
 
 		if (tgtIndex >= maxIndex) {
 			while ((ss <= tgtIndex) &&
 			       (k < (AR5416_NUM_PDADC_VALUES - 1))) {
-				tmpVal = (int16_t)((vpdTableI[i][sizeCurrVpdTable - 1] +
+				tmpVal = (int16_t)((vpdTableL[i][sizeCurrVpdTable - 1] +
 						    (ss - maxIndex + 1) * vpdStep));
 				pPDADCValues[k++] = (u8)((tmpVal > 255) ?
 							 255 : tmpVal);
-- 
2.54.0


