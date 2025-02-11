Return-Path: <linux-wireless+bounces-18747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94EA3056B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052A8162B51
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFA1EF090;
	Tue, 11 Feb 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="sMZH6Ie8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5661EE7DF
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261651; cv=none; b=ZUY+w9jh+fGB9bu+0JNf6qRzZ+tVgmWroyFii/1KKttZowyzZPE6dj0vJFd3DzNYZPnVG5nNkfFuGWuz4sHvMeRhHE7LvW7xYAUHZ1YuNwvK99HnU6Qz7ubAb9HpW/bm6ozIOCvLmjmLc554+KOJuVKWFxK4AOu7r0+uRLCBhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261651; c=relaxed/simple;
	bh=qySn+qutT/7QTH9+GPMef8PgnUwe7yKZFScnxrQJafg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iv3IAlKFaBBn8OoeLbVwXTDQK75q7yOdR/Q+062980Z1A/7nctO4rwt4LsidmX4+TxZIyNIF7jRErX47upnZ9gvI69q2FR6sAVWwJX23HF6fS1cZlwfWa6XtxMZjmDKNnxlozn0ujlZsfw3jPH8hOtFBC0D4tJC8MJczcRXgd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=sMZH6Ie8; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-5de6c70832bso4182239a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261648; x=1739866448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObnMbn2FLzqhaRiDyEEyyncfTfV/NglSimRNCizvXa4=;
        b=sMZH6Ie8dlG163YocC7TVNrftwO+3enrvyHpanX9a70vflErtL1NjAV96sn9/3qa4B
         tARUTtCDHFKGxN/NQxp1BERR8cicMF9yhYU5Y82eTgFBpjHbCWdvctgm1xrbnYt5RrUR
         nYHfhw7+/VzqBefXJLwata+nQnNQytdpf921mjcPuLj5ySO9XIUp2j750lvM271XjNZf
         WjqDAaBp4UeiiFCHOX/8iHi7eZjZG0sW1FIlw4bbF0+5RluxakF4NVBwhv2ok4vgIhhZ
         SA1OzOGLn+Eqa5lOUFm8vU4wI6LWiBlmp3I0tMNRcfDXupLFbkXtTu8mO2y3Qv/Wp9zI
         /A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261648; x=1739866448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObnMbn2FLzqhaRiDyEEyyncfTfV/NglSimRNCizvXa4=;
        b=sGGZ3lpLGE90Nk/KgJr9UBs95USTctBfRLb5wuEAmeoiexumhQMjVWIQSx5m/VKnWf
         QLtarHP1l9nZ3/FXv+NFob5BNbvseuH1uusKAQaXUWVxehLXmtDzA9WDJnfYmbKqb96a
         xy087xAWyU9KVrQV6JKkWotO7qY0jf67Gk1zRbtmEMfj6KoH50FCluVOB5s9v5fLDwju
         JIi0KHgVxNtaFNHizAWra8PcfeZ1WYFprDvsOHm/tA5/3KlCwbGDCBV7q5rDF28b+pzt
         hKkeruNKkt7Rv9trAt0/1+eWNmZfDAHPijPQgyUvymDH2Ixq/mDqfjZSv8ewGNRFzHZj
         n74w==
X-Gm-Message-State: AOJu0YzfiTrvmuPXbfpkYwiw0uoKaZ8WhN02nI/j/rJB0FxcD5gOLyFe
	BhzaqKK97dLhku4vyv4b997BsV0JUIpeDc3hblV6CItflikE+iGvcq3zPVk05U7uMRgnQ8A13vo
	4dmL/kyJ0HFHrIPf0ibOBGlTlKQfAzi0Y7p0k/ShY
X-Gm-Gg: ASbGncsppFysrUScUOO5daVQuLQ5lg2xTjO2N35QLs5zSdvNjVYDf/mP+NQV4mEUygZ
	bnSBQB2XIKuv0ucUyjqrs17fbhQQBZyFC98ukhv7Lv5QYbsng0hJjCwHUUSorQCN2svd9wC8g0f
	VG83WY10kMuuHWujedlq/LEcEMCLInnxUIsrCGYnY11SCTL6G72vJCe22ytFaI7QjMjZ6WZc7+6
	u3zDqktl9UHvjy9WoSlERtp9+AiiDu13F9j+7RgYojHgTw+iFTrAWoZOpRwXYnd3lGHlAWTsPEj
	zykuBlRsYgw35dI4Nilt3jx+4S3zUw==
X-Google-Smtp-Source: AGHT+IFaNTh5tvrp3/K1K3ow4zTUrvgNIkWuqlZ9btpnX3NIMUU7vRlpIiSIDZuEGMVy79oo4olDttGZEADk
X-Received: by 2002:a05:6402:2382:b0:5db:7353:2b5c with SMTP id 4fb4d7f45d1cf-5de9b931aaemr1862556a12.11.1739261647919;
        Tue, 11 Feb 2025 00:14:07 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:14:07 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 1/5] wifi: mt76: add mt76_get_power_bound helper function
Date: Tue, 11 Feb 2025 08:12:43 +0000
Message-Id: <20250211081247.5892-2-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
References: <20250211081247.5892-1-razvan.grigore@vampirebyte.ro>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will replace mt7915_get_power_bound function from b/mt7915/mcu.h,
since we will need it also for mt7921 and mt7925

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 508b472408c2..2c98cc42cd7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1697,6 +1697,17 @@ void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid)
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_add_poll);
 
+s8 mt76_get_power_bound(struct mt76_phy *phy, s8 txpower)
+{
+	int n_chains = hweight16(phy->chainmask);
+
+	txpower = mt76_get_sar_power(phy, phy->chandef.chan, txpower * 2);
+	txpower -= mt76_tx_power_nss_delta(n_chains);
+
+	return txpower;
+}
+EXPORT_SYMBOL_GPL(mt76_get_power_bound);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     unsigned int link_id, int *dbm)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..96f98a0d55a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1482,6 +1482,8 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx);
 
+s8 mt76_get_power_bound(struct mt76_phy *phy, s8 txpower);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     unsigned int link_id, int *dbm);
 int mt76_init_sar_power(struct ieee80211_hw *hw,
-- 
2.34.1


