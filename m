Return-Path: <linux-wireless+bounces-36783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKEoAfWVD2o1NgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:32:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE685ACC62
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0FEE30459C4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75552E5B02;
	Thu, 21 May 2026 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS07uhtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E730594F
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405904; cv=none; b=FVozY8iyaA5rL8ckEOS/fnqJ6ZKd/ohXxoWDkQgAu4iBU/1WAX6eJZvd0pN/hmN3vQQp52WWcgESKhGb8NeffjWv7VpFl3Z8GW8AfRr6kD8uTalMXFcFCIYVLUtrrWNMAGow1DuRUR9BZh/4z41dBdKk10yYbZo30BkopZ6y4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405904; c=relaxed/simple;
	bh=caQzFBVz9+JRDYs3VPB+WZdfbYRu03k6zu3PTsCnwLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNtjDPBLeHPinHNC8QOP4eKlqCvid89lu2EJszMeKYLxOfGnTTJTCQQvtIqmQRIFyDtmKg4gSxSPdRukF3OdM7lan0HbcdBsFCTGmA80q/xUeGumvEnOV8ZgdblOAq5bKfloPgOQLVgWXqhJ0sXhQXv6AMfZ3cXxGJ85OOKwMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS07uhtn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso3010316a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779405903; x=1780010703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/shh+HWrmrsrUU3hIQCrHnvACFJA2W4RqXWRdx38L90=;
        b=JS07uhtn8hRJksHVMFGGpieV1/TsCdFck0LGbKU6vjOOD7JN+SxMRzqaIEJhCbmWWv
         aQSK+YU5jLIExFny71lQt8aAJBzWwOo/qfzyE9aPk173tar5VBxa7OzpGu94h4MLsU3A
         W1eLr+KmNRwde31neUWKaTdWsScqBsYf+LGvhYLCQDFP7NFPa3EI5L4wPFot0dEHxc8V
         +pOG8wRHBzaUPzdHES8hkmJkBsRUlA7d5Qj85M9OgsyjLNR8D8SDhLzYSKUC1xnv8Xgb
         qQL2bEnveMxNQwvWz2TfC3lsmIC0RNbetfdnTYtzaILMyaBQerc6mhHdBoZW8iY7uGIi
         uGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405903; x=1780010703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/shh+HWrmrsrUU3hIQCrHnvACFJA2W4RqXWRdx38L90=;
        b=DY5JTwZifPePuimEJ9SvQVJ654MgMeyIIENZ+DHk5+wJohd+i7TP5tpLVWeYAMzDnN
         Biunv/lGrBuHiqlbG7OATdPfvNxN3pSEpz7psUbuVPy5X2jrDoV3ntPR++nOd2lpy6mZ
         WWK2oxq6kRkcaE/9yS70HFqwKLa9Zfb3alqwdUD/aoy/Axf3ZLa92L6JJidqnJwyjsHs
         vHXEY+ZyEKuiDVQWsMsBmVKeQX52MtsnH81a58HbCW2p1GQZPZatg7fCo0vg7I88LRpO
         LVNMVFgVOF5e16zc/dFl0Me/DVKrdRKBKL7THtSiwCIUIKpwsGEsr9wf4jPEPL2qSWHg
         nDEQ==
X-Gm-Message-State: AOJu0Yw7cjZVM8MIEehsyTe1bFLhz5zdvvjg2ZUUrGp/R6lkLM61YXV7
	V/qMjHPmieEIUsVmDUHpY7Y5Nb0CZn6weTo2F7bOMYh3g1068gcy7AgRpX1smg==
X-Gm-Gg: Acq92OFhOd/jwIqIb8DNagzow0oNLbk5kC+ND1Z0BapXcdSySE4t2A3McBP3+rQeDay
	4hQCU7D6yvZlPkaWMxHJEF++qo0FW+kZy5bBGWBFb2h3mzcNux2FGEOGoUDt6jSksjZpXxDGFFU
	A/cVRj2tg4A58YK/ObqrldnAW2eF/hx2XDfwQukuNKxTi9u2BNWTPv/+rmCa2Ao3BHO3hrp03eR
	n+1J2Gh09nTWchykG3BSDwWhJTjrp2FGlqUOaA7he45AWdDGKZ1B0DnUhkiWgbcz0vhFo1R4lZo
	vlP+sI3SXLZyPrP0/UG0u1VLJOwL2l4wRp/gqtuqAUFUQaVXrsgSmRU3guou5yKutCKhNe80u71
	eQyfBptsH/2ol8hPnIR7R1AJUs/6e1rwRPKtY9SyajAEvD0U8uCfeOzjd6tgVFb/XyL9omx49wc
	Vs0YlPu4YQRTqZtThj6oBrvSsTBz54nZjf1bPoG3g0GFsJiZA0nxwB7rR9MLiB/UJHZyCY77Uom
	2S7xAp/cUcpkmCZwMRZ8cqUHTrrUVyRx2I=
X-Received: by 2002:a05:6a21:4d14:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3b328e74760mr958894637.27.1779405902722;
        Thu, 21 May 2026 16:25:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841628795d5sm185466b3a.38.2026.05.21.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:25:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: improve stability on AR9330/AR9340
Date: Thu, 21 May 2026 16:24:45 -0700
Message-ID: <20260521232445.261915-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36783-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5BE685ACC62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Setting a couple of registers on these platforms improves stability.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hw.c  | 25 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath9k/phy.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 05c95e67a853..5168c02bb73c 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -248,6 +248,19 @@ void ath9k_hw_get_channel_centers(struct ath_hw *ah,
 		centers->synth_center + (extoff * HT40_CHANNEL_CENTER_SHIFT);
 }
 
+static inline void ath9k_hw_disable_pll_lock_detect(struct ath_hw *ah)
+{
+	/* On AR9330 and AR9340 devices, some PHY registers must be
+	 * tuned to gain better stability/performance. These registers
+	 * might be changed while doing wlan reset so the registers must
+	 * be reprogrammed after each reset.
+	 */
+	REG_CLR_BIT(ah, AR_PHY_USB_CTRL1, BIT(20));
+	REG_RMW(ah, AR_PHY_USB_CTRL2,
+		(1 << 21) | (0xf << 22),
+		(1 << 21) | (0x3 << 22));
+}
+
 /******************/
 /* Chip Revisions */
 /******************/
@@ -1438,6 +1451,9 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 	if (AR_SREV_9100(ah))
 		udelay(50);
 
+	if (AR_SREV_9330(ah) || AR_SREV_9340(ah))
+		ath9k_hw_disable_pll_lock_detect(ah);
+
 	return true;
 }
 
@@ -1537,6 +1553,9 @@ static bool ath9k_hw_chip_reset(struct ath_hw *ah,
 		ar9003_hw_internal_regulator_apply(ah);
 	ath9k_hw_init_pll(ah, chan);
 
+	if (AR_SREV_9330(ah) || AR_SREV_9340(ah))
+		ath9k_hw_disable_pll_lock_detect(ah);
+
 	return true;
 }
 
@@ -1843,6 +1862,9 @@ static int ath9k_hw_do_fastcc(struct ath_hw *ah, struct ath9k_channel *chan)
 	if (AR_SREV_9271(ah))
 		ar9002_hw_load_ani_reg(ah, chan);
 
+	if (AR_SREV_9330(ah) || AR_SREV_9340(ah))
+		ath9k_hw_disable_pll_lock_detect(ah);
+
 	return 0;
 fail:
 	return -EINVAL;
@@ -2074,6 +2096,9 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 		ath9k_hw_set_radar_params(ah);
 	}
 
+	if (AR_SREV_9330(ah) || AR_SREV_9340(ah))
+		ath9k_hw_disable_pll_lock_detect(ah);
+
 	return 0;
 }
 EXPORT_SYMBOL(ath9k_hw_reset);
diff --git a/drivers/net/wireless/ath/ath9k/phy.h b/drivers/net/wireless/ath/ath9k/phy.h
index 4a1b99238ec2..af667a3629b1 100644
--- a/drivers/net/wireless/ath/ath9k/phy.h
+++ b/drivers/net/wireless/ath/ath9k/phy.h
@@ -48,6 +48,9 @@
 #define AR_PHY_PLL_CONTROL 0x16180
 #define AR_PHY_PLL_MODE 0x16184
 
+#define AR_PHY_USB_CTRL1	0x16c84
+#define AR_PHY_USB_CTRL2	0x16c88
+
 enum ath9k_ant_div_comb_lna_conf {
 	ATH_ANT_DIV_COMB_LNA1_MINUS_LNA2,
 	ATH_ANT_DIV_COMB_LNA2,
-- 
2.54.0


