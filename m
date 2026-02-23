Return-Path: <linux-wireless+bounces-32130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbVDAXZnGkFLwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:47:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A799E17E8E6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1D63055961
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3437A484;
	Mon, 23 Feb 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsgXCO5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF437AA61
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886705; cv=none; b=GKu/5bTHlKQGZVzR27P6qBf/sTgzmp3cR48/OE0Af2l6/Jmaa8l5JYeJvQpsZzcWyPQq1XuUuf+H67a6BhO41hOp7EKMrUrYZZbDyTJztc5v9UjC1QliP075EBCHWDShK23S8qPSPGc9EQIdmQh6+vwchgagzvAhEVdZ9do43Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886705; c=relaxed/simple;
	bh=N55S5CJS7oD7maBdaLEKagUEImQsjUHAiSPodpHT3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEaocNZpN14/RKD+edb0skGFoi4GT3hsz9CxnHK0qp6HF81tB8F9JzS6Gh06Ba0P+fjhkhcZDf/96B5T+cROJlgcowcJHgRumyXggzivpqAtCfL/U/fuWOddr5k+C/YJ+d+eRlFoDK+uTFnrQAwmV+VSMK/AW2si3viNMO9bG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsgXCO5P; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824a2888de5so2677745b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886703; x=1772491503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OI4hfqGbqoBq8nFvZm2zjmkGtfn/+MA3Ga/ZSFfqOS0=;
        b=GsgXCO5Psg9XcqK2ipWRXQPPJBJccKhk1M6fur1B2CouT6QE32Lf7icZpZvrOggZXH
         TLAgU+nLlqgubqYr8+xkMa0CqJFWVofPdF5iQoacvWHAsO5OhIc0IJONWrnpkH0Shahs
         SfDHhbHDVXuH24EI1RLDQD1BILM2QIGRCPMhRbebhayzjHqoe3yrO9i+jX8TQYWBWraQ
         mUC31RRySitifuhOdoytGwwft7TZKwiiYpK5LNrcGtyrOQSc3E/kmqTFwENLnr8iJoGT
         6BbPF2Hpxm5vAS9MwcYImwnDCYcia82WDk1ZaGtraZoofXwj+pFkGykee39oeWZ7q9HV
         IYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886703; x=1772491503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI4hfqGbqoBq8nFvZm2zjmkGtfn/+MA3Ga/ZSFfqOS0=;
        b=YVR3ePhKFrKP67LkDRT1Ver3XmlwSza31SBuRQdX5p4Llf7KXlYK+tsBRAKuu0lIfv
         gK7Wc5K+IiTtAkDq4Ptlj9WO/l37GuNLRbHapQICjjLf6YBqdJVr7ZiWELgRUMdumJ99
         ryzcPuJF82/MxukY6wljPyz+3aaXOjyDwO9w5YaZyK/qdKg3l0Eg4XT9itKoY6umWwxY
         4j5hUe1nqwN24h8xyHMEu8pO4zCXI/GP78cBWPiofHqpptsvheVZISmca5WzPHEREqDy
         SgWmpOlm1ChhiGQcGEUajXA+DKAJHJKQ2xVPMnqi3gCDWoQT1LKiJuk0iaBx1Njvpu3c
         j5bg==
X-Gm-Message-State: AOJu0Yy9+14bVgu0Apx/Q7chmU+cqcKTp87F9pXnfscXhKRcxtfRzGTW
	beD2aPoImrZeZBOcB/A4xh9JMLCps6wjacbjIVQvyM1uaPmxq4PF/EeWy6JrD2TC
X-Gm-Gg: AZuq6aIWGDSRcr8vZSwLkEy6GT5uc+AxoA7RNRJMhtewX/0/7C5kyPl6gQu3nO6V1xr
	8Cf7yjFi6BCeV/95P7vWZfN35iqmwyHcecn5r33m6cvxzT68XBnmoT6ekUOxw0MX/CHIeCJo6or
	zujf5FvqJ5gbTAVlxph13QDrVpFff6Gy1tVA0FbpEirew4Y54M7UOUAO4Oe/obgvgbqI8B47ZiH
	owxJliCuUlUgKGF+BtH7uE9NWBZ7pdv0kQlTEhvcIx57hwqvoGcvOla4D6Y3WwpPzIXT7aB21UG
	JHRQKWVYa1fEYMBEEn/9K0BBv8fRv6VEuQaLXD0ovv+ZY3R7VEBGkfF23w9gC05LWd3R5RzuKZD
	V2ZJ/p8PzVidLWQWjEhUrpEK8pb81US3jdrbFpSN+y/X8/rRkl2sSgt+azru67XZRlcd1yyjRms
	rIaoLGlMeSIxDxKrhkT6hznLwUYQQrGefeeEmc0BOlxEpUm++l9xn2ug==
X-Received: by 2002:a05:6a21:32aa:b0:394:5513:ce0 with SMTP id adf61e73a8af0-39517e24f7amr13908213637.29.1771886702799;
        Mon, 23 Feb 2026 14:45:02 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7255491sm8495466a12.26.2026.02.23.14.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:45:02 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
Date: Mon, 23 Feb 2026 14:44:45 -0800
Message-ID: <20260223224445.27352-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32130-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A799E17E8E6
X-Rspamd-Action: no action

Simplifies the code slightly by removing temporary variables.
multiplication overflow is also gained for free.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_hw.c   | 6 +++---
 drivers/net/wireless/ath/ath9k/common-init.c | 8 ++------
 drivers/net/wireless/ath/ath9k/init.c        | 8 +++-----
 drivers/net/wireless/ath/ath9k/recv.c        | 4 +---
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_hw.c b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
index b26224480041..0f24539b75ec 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
@@ -80,14 +80,14 @@ static int ar9002_hw_init_mode_regs(struct ath_hw *ah)
 	/* iniAddac needs to be modified for these chips */
 	if (AR_SREV_9160(ah) || !AR_SREV_5416_22_OR_LATER(ah)) {
 		struct ar5416IniArray *addac = &ah->iniAddac;
-		u32 size = sizeof(u32) * addac->ia_rows * addac->ia_columns;
+		u32 n = addac->ia_rows * addac->ia_columns;
 		u32 *data;

-		data = devm_kzalloc(ah->dev, size, GFP_KERNEL);
+		data = devm_kmemdup_array(ah->dev, addac->ia_array, n, sizeof(u32),
+			GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;

-		memcpy(data, addac->ia_array, size);
 		addac->ia_array = data;

 		if (!AR_SREV_5416_22_OR_LATER(ah)) {
diff --git a/drivers/net/wireless/ath/ath9k/common-init.c b/drivers/net/wireless/ath/ath9k/common-init.c
index da102c791712..52e02e0752d8 100644
--- a/drivers/net/wireless/ath/ath9k/common-init.c
+++ b/drivers/net/wireless/ath/ath9k/common-init.c
@@ -133,13 +133,11 @@ int ath9k_cmn_init_channels_rates(struct ath_common *common)
 		     ATH9K_NUM_CHANNELS);

 	if (ah->caps.hw_caps & ATH9K_HW_CAP_2GHZ) {
-		channels = devm_kzalloc(ah->dev,
+		channels = devm_kmemdup(ah->dev, ath9k_2ghz_chantable,
 			sizeof(ath9k_2ghz_chantable), GFP_KERNEL);
 		if (!channels)
 		    return -ENOMEM;

-		memcpy(channels, ath9k_2ghz_chantable,
-		       sizeof(ath9k_2ghz_chantable));
 		common->sbands[NL80211_BAND_2GHZ].channels = channels;
 		common->sbands[NL80211_BAND_2GHZ].band = NL80211_BAND_2GHZ;
 		common->sbands[NL80211_BAND_2GHZ].n_channels =
@@ -150,13 +148,11 @@ int ath9k_cmn_init_channels_rates(struct ath_common *common)
 	}

 	if (ah->caps.hw_caps & ATH9K_HW_CAP_5GHZ) {
-		channels = devm_kzalloc(ah->dev,
+		channels = devm_kmemdup(ah->dev, ath9k_5ghz_chantable,
 			sizeof(ath9k_5ghz_chantable), GFP_KERNEL);
 		if (!channels)
 			return -ENOMEM;

-		memcpy(channels, ath9k_5ghz_chantable,
-		       sizeof(ath9k_5ghz_chantable));
 		common->sbands[NL80211_BAND_5GHZ].channels = channels;
 		common->sbands[NL80211_BAND_5GHZ].band = NL80211_BAND_5GHZ;
 		common->sbands[NL80211_BAND_5GHZ].n_channels =
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index b52ddb237dcf..e52775dda6a7 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -297,7 +297,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
 {
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	u8 *ds;
-	int i, bsize, desc_len;
+	int i, desc_len;

 	ath_dbg(common, CONFIG, "%s DMA: %u buffers %u desc/buf\n",
 		name, nbuf, ndesc);
@@ -351,8 +351,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
 	if (is_tx) {
 		struct ath_buf *bf;

-		bsize = sizeof(struct ath_buf) * nbuf;
-		bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
+		bf = devm_kcalloc(sc->dev, sizeof(*bf), nbuf, GFP_KERNEL);
 		if (!bf)
 			return -ENOMEM;

@@ -382,8 +381,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
 	} else {
 		struct ath_rxbuf *bf;

-		bsize = sizeof(struct ath_rxbuf) * nbuf;
-		bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
+		bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbuf, GFP_KERNEL);
 		if (!bf)
 			return -ENOMEM;

diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 34c74ed99b7b..93b41a1bb2af 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -202,7 +202,6 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
 	struct sk_buff *skb;
 	struct ath_rxbuf *bf;
 	int error = 0, i;
-	u32 size;

 	ath9k_hw_set_rx_bufsize(ah, common->rx_bufsize -
 				    ah->caps.rx_status_len);
@@ -212,8 +211,7 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
 	ath_rx_edma_init_queue(&sc->rx.rx_edma[ATH9K_RX_QUEUE_HP],
 			       ah->caps.rx_hp_qdepth);

-	size = sizeof(struct ath_rxbuf) * nbufs;
-	bf = devm_kzalloc(sc->dev, size, GFP_KERNEL);
+	bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbufs, GFP_KERNEL);
 	if (!bf)
 		return -ENOMEM;

--
2.53.0


