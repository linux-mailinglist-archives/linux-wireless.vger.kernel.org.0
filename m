Return-Path: <linux-wireless+bounces-35300-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLvxBBcb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35300-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1F4678EE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E19E3300B9A3
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DC303A0D;
	Sat, 25 Apr 2026 19:50:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028C303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146642; cv=none; b=qShWwzOPmvojgrgS/3d//TJvMks2toEkbQfmUHEo3TWCsr4hGLkQiX6xYTaP5niqL4hEGdOdhwm2wh/BhvMo53iOFQtoq/GrbSzI+mq/hV5ydcFBwTz0cJcTuaJUV6y78/9S2Eeg4Lju2ydAlBSD5e5eNH21fB5pdBpzpQaauhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146642; c=relaxed/simple;
	bh=v7G6hqNOK8wXhaK+lduzYZ38K2C/5WUrZdc7Veovg9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXxvDsH12706H5LdyQCMXE3k32N0CajH6GyFZrNgkOPQwkjwjlz+jomMm3ZDNKE83AWzpECLxxBu8La1UvIaTgwumyQRBYjoVkAqy36nhbcGwpEfIyjDDFGCj8zswOFUQCclSvQVvZLJpqjwuYTwTQXdbxXyagsKyYs9XT1EbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcdd1b492eso4789658a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146640; x=1777751440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlbgcyHHgMJ+HRdBcG0VPI5pwKjamNrjevADSB1tt3A=;
        b=VaNZD1yz5PkZH5Gu5LelpDnPTWv+kVSJ2NTWYqa+97DmphAh9MNhITtHdcxpEY9v4s
         WeDrwLKfBW5l/MYhYqAZBoOlsUCMFec2ihh3EpShV5Z/JJtVmsPlpgMy+oUCR+2RjpPr
         svhXVVOksHs8oSdEFhqhGMsPJVUXniSEtQ9iWTWyTbC22/ae58RQreZkvBlSN6g27wyH
         Wdzy9HAciWm8hiiTCF0Mq/mYKcC83J2AEltGMzgDMWBHTm3Py5f5QD0C5N8Z2ptq6qkB
         lcjSXMof9LHdK6hQpxsS/jenJr8j3INBS2OpmOAJxlFu8RID1LxZevm9fpVopJOJf7sc
         T0kA==
X-Gm-Message-State: AOJu0YyNlhbP533Li3cAhOEN9DLjo7s+3KvkR2myJwh/lKul8GN7K7cM
	vwfjFTMv07Dv4mhqlfODwi4cb23zkeOTH58pLNXOlrTgOZCy7mj3/R4Q
X-Gm-Gg: AeBDietwXmJT5tVebh0VPvufCyXDSsN6P1qwNdgkTAdQTgpfMaCW5rDLbxZnozIZ3nG
	xYyMdmo+8t0uTuTZw47IYQnfGs6XkGCD27fzuvNZboYehMudd/k2W2PvqkUm9yS6zxiPh7mvCqA
	9uvxBRZVXKoJd/wDNvo6Q4ecvSta2zOVQ6/C1V+AUuVWy4mIksv9ZSHFZw/3j3uj0kVVGIRhXpF
	k2jUoYMbj7xM0V/1U7R5FgWYYjnOEhIWRV3mAx7z9/yj3zwdK3rhEfm2ktsBgPlfsEINFtK0YoJ
	+wNrM5thtggJaiUN/cFRtl5fKlMtnq6AkFKSB9G5HCjHURq7ClV6u0/B7q3J1vXTm+fxXIPOBjo
	tRqXNUP8xCFZtXcwLYy66gbU2X+Qp4m3jdGkTVDPISW2ajyfVKbxXc9Ysq33po0za2O8iptW6ad
	dd9q7wJXxNBtT4OkO0Dup+znLAgi4tzuo3Q3ekCzFQ33Btt0xv5ATobIg1g7mfoJy/MTKW5TFrr
	X/EJn+2e77j
X-Received: by 2002:a05:6830:3811:b0:7dc:e3ad:6088 with SMTP id 46e09a7af769-7dce3ad67f9mr10380486a34.0.1777146640247;
        Sat, 25 Apr 2026 12:50:40 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:50:38 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	Marcin FM <marcin@lgic.pl>,
	Cristian-Florin Radoi <radoi.chris@gmail.com>,
	George Salukvadze <giosal90@gmail.com>,
	Evgeny Kapusta <3193631@gmail.com>,
	Samu Toljamo <samu.toljamo@gmail.com>,
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
	Chapuis Dario <chapuisdario4@gmail.com>,
	=?UTF-8?q?Thibaut=20Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
	=?UTF-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 03/21] wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
Date: Sat, 25 Apr 2026 14:49:53 -0500
Message-ID: <20260425195011.790265-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53F1F4678EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,lgic.pl,gmail.com,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35300-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

The RX vector (RXV) and TX status (TXS) parsing in mac.c lack handling
for 320MHz channel width. When the hardware reports 320MHz in the
bandwidth field, mt7925_mac_fill_rx_rate() returns -EINVAL and
mt7925_mac_add_txs_skb() records no bandwidth stats.

Add IEEE80211_STA_RX_BW_320 cases to both functions. The RXV parser
also handles BW_320+1 since the hardware can report 320MHz in two
adjacent encoding positions.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c47bd812b66b..d681005cc6ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -339,6 +339,11 @@ mt7925_mac_fill_rx_rate(struct mt792x_dev *dev,
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
 		break;
+	/* RXV can report 320 in two positions */
+	case IEEE80211_STA_RX_BW_320:
+	case IEEE80211_STA_RX_BW_320 + 1:
+		status->bw = RATE_INFO_BW_320;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -997,6 +1002,10 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_320:
+		rate.bw = RATE_INFO_BW_320;
+		stats->tx_bw[4]++;
+		break;
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
 		stats->tx_bw[3]++;
-- 
2.43.0


