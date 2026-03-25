Return-Path: <linux-wireless+bounces-33804-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBPuHvxlw2nFqgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33804-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:35:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531831FB1B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83313022947
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4526A0C7;
	Wed, 25 Mar 2026 04:33:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE122F9985
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413212; cv=none; b=q81NkYFfT4uVHDhcK3hoTbS+FbkyrxFT7GOPU9QOZaDCp2G+DzmaRbTdGKj/qWkf4LQhn7OElZ4rEDUa6TVTIdQGLX0l6Brff/MNn4bEeo7TkIvCE8VihNZKZl9NIlaVq5Au22wX8yh4sAcxEyvPqRMkk+HkPHBxLdt4z26IWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413212; c=relaxed/simple;
	bh=LLXJwXylXR6Aq6kjTRxhh0XnMgSDZDmmnF/PWp8JfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5jcx0mHzNdrYqkwAIObowzDek2Wf96WAB50TEq72aw4perVZOOBX6LT6M3fOcwHEweF3SQnFcyztTkSGLHWui2yqk32jGdt0cVF+mw23CI/98KvgPwZF4EhrVrjbz3AOYLEzavZXAfip0XFMBUsSeu/lqDnpK4wePMy4Bng40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ab50ee951so21442867b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774413210; x=1775018010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ardnxVXNLFnPNOoWJ45iMbsoAkD72wP/0L1ROL8+ewU=;
        b=GUTiU3RpeCqeP85K2cvxJ0sVLNG9jJt0cQsErHFDbU7TK0nveyYGU5arcH5aVuRd9e
         PjIq8cq+lb1DcfHLArWwBBoE3ikPZGWbG7VGIAnvVL7aq7CdEihEu0PmsrK/HChKdBbx
         5mhKGY7W4VjH07YNOzsHJMZ2mPdGsdIYzjJ+sSh4XJvjC3bmzPVvQ20ndcXUFJNu6ilM
         WBq2XeBM7zzc6MnGBBzh3qAQiUspZd+9VBSPIytmAKTuD35ozOBTbMBzoHqbx4xfx4Q5
         cNGXlLqfjQSvytDu/Xnj9Am+tTS97QWWqm2cDZIic1v0IH88DOTwfzOc3SdQCNsxA/Ag
         wj9w==
X-Gm-Message-State: AOJu0YwlckA/9b4IG43/LhlivE7CIr5Yner146SiSSea3lJvd9fbrqt/
	r18yBrmCH8JZQgtcPaeIKwolQQllBsgiqM5zLFX3Qa8Va+1Gh/Wxf7oL
X-Gm-Gg: ATEYQzx/7D0xUy4kwqehBQqIUWHBl7aZKKJV4wGvgzmMG71ctXvaztcDWM0VbkZQCUw
	H7Sj1fJQa/8iAr2m8ambfZjc8byKLeRY9vo5ac8Hdw0U+MPs3UjiEzhyx1KwZkBxhfztkBq1ECL
	LrENL563kVnF2+LQN1K0OyesjS47YvgjOs12wEWJBSWcufObi3pQRmWX+P2hFfox6b5rEodU4SY
	kvnaegvc7kQfvacKs6y5wgynL/eeJ6nVT7aMb0V544f3SQs1vkhoGLpCbZAEvEDVYZtB9P+HB6d
	wIwpuHOVWrcjn0NqJRJm41srZuFS5FvgA3cwTJi+JnKxew82v5lQEo9V410R+VfFSU+C6Eem2KG
	tBePoryBxqWHvrHmXYV54yI9iHf/gQ42AQeI69KWFUkIRqFtyuUsUdJ7vdoBzbLSootj3rVsxLq
	YSV9ht4oBdD2OeJmqPDChbP29eUGNVo7wT22Xldf7EYxsGVw1ZnXJpRPXqGUeSIYNyQ5LDYiplA
	A==
X-Received: by 2002:a05:690c:6:b0:79a:c701:28c5 with SMTP id 00721157ae682-79acf4efa39mr23359817b3.27.1774413209816;
        Tue, 24 Mar 2026 21:33:29 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:3916:ec63:baa5:b5f0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903e0b8csm82707977b3.12.2026.03.24.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:33:29 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: connac: factor out rate power limit calculation
Date: Tue, 24 Mar 2026 23:33:17 -0500
Message-ID: <20260325043318.13298-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325043318.13298-1-sean.wang@kernel.org>
References: <20260325043318.13298-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33804-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0531831FB1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

Factor out the per-channel rate power limit calculation into a shared
helper.

This avoids duplicating the same regulatory, SAR and rate-limit logic in
multiple paths.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 28 +++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index d0953e02810b..1549a97873ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -421,6 +421,9 @@ void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss, enum nl80211_band band);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, void *wed, u32 flags);
 void mt76_connac_set_txpower_cur(struct mt76_phy *phy, s8 max_power);
+s8 mt76_connac_get_rate_power_limit(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    struct mt76_power_limits *limits);
 void mt76_connac_write_hw_txp(struct mt76_dev *dev,
 			      struct mt76_tx_info *tx_info,
 			      void *txp_ptr, u32 id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 897b065a2be6..1117a22c70ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2223,15 +2223,10 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 				.hw_value = ch_list[idx],
 				.band = band,
 			};
-			s8 reg_power, sar_power, max_power;
-
-			reg_power = mt76_connac_get_ch_power(phy, &chan,
-							     tx_power);
-			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
-
-			max_power = mt76_get_rate_power_limits(phy, &chan, limits,
-							       sar_power);
+			s8 max_power;
 
+			max_power = mt76_connac_get_rate_power_limit(phy, &chan,
+								     limits);
 			if (phy->chandef.chan &&
 			    phy->chandef.chan->hw_value == ch_list[idx] &&
 			    phy->chandef.chan->band == band)
@@ -2967,6 +2962,23 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
 
+s8 mt76_connac_get_rate_power_limit(struct mt76_phy *phy,
+				    struct ieee80211_channel *chan,
+				    struct mt76_power_limits *limits)
+{
+	s8 reg_power, sar_power;
+	int tx_power;
+
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+
+	reg_power = mt76_connac_get_ch_power(phy, chan, tx_power);
+	sar_power = mt76_get_sar_power(phy, chan, reg_power);
+	return mt76_get_rate_power_limits(phy, chan, limits, sar_power);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_rate_power_limit);
+
 static int
 mt76_connac_mcu_send_ram_firmware(struct mt76_dev *dev,
 				  const struct mt76_connac2_fw_trailer *hdr,
-- 
2.43.0


