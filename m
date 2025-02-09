Return-Path: <linux-wireless+bounces-18656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82400A2DA1C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 02:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319521662D7
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC7819;
	Sun,  9 Feb 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="eu+0WMt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FC243386
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063993; cv=none; b=cQzx3Mf2S+XmmpvbWhxQPP/gItA5Yd9jQwvdorE6r9fiNf8yCvkNiVVgezNAtoZLBthYdRkJaC28H+OSfdHBoje02unQ582EXCuB6CrRGyZR6DfaKCJw8Mxs4WhHEBhlkLaKrYbTfU3nu4lZlwXPDiVdUMReDng/fWdTGWLwDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063993; c=relaxed/simple;
	bh=Alo24JfScDYu0KUPK2MdwjY+Qd52SHQa7YBsObOa23g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeFIXuw10u2ZVq3m6M4atPFnddclGPRXCMAjPWbaM314fAcYffw0kdjorVOBXbn5Q9q/Yzrog4k+VSn8Xj9IR6nfZWE/Am/L3Cb54K4pDkFRt9MRhnpcuPiFPxd+6dQ6GISawTc/BDlbdUVLKokNJedygmb84c38UVEXWSwss+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=eu+0WMt9; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4393f6a2c1bso109305e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 08 Feb 2025 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739063990; x=1739668790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8BBnPAzjKUysaikDDjAj3wAwJVVzR5ozu0VghxN9PU=;
        b=eu+0WMt9ZfI3mA+AUS6H4ZFfhxuUYhHUhv5nXNefs+vJOCqH7qQMdauv8CaEwWpN/L
         s6guxZ/KqSLoU4K1OETBnJ9uojDBYandWri5b+Dku6azx2UpR/+VXjLzETRIAigfGNCJ
         L1VHsv3NL1AePn174I7KwI8xyPsH/40OUix6i/nZQhwO/1ko74I8uyTfLUrMtm0yjSF8
         2x/HuMYLON9VZNGQDjfX/e+dIz8WGYTcp90rPcmfPm9lNIc7SBAkPm0IAD7mDhpSHSUg
         D66hyDy9Me5ykc5kUuSJbTUM6CfGHNUCudsHl3Uv/6hNaoyQek0Cu4gTmn/JNCh6NdlL
         sdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739063990; x=1739668790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8BBnPAzjKUysaikDDjAj3wAwJVVzR5ozu0VghxN9PU=;
        b=oXaUghEWXotKqu9mKHR0OfDkiWBRFISYN7EVBoJKrUPIFXpYecS8+17EoX1a0Ng5+b
         nxe+3f3k/vjeOYujGqYJI3wyelIIq7vskCAoRLKHK5WRaItxqpuwUgbKhcy13Q6WACRV
         l9gHXxJ69mhGw+2tPYe0H2Er3CFPfAdXyIXudP8+2OL0EPIWTIwStIMUP4WXvD52/ycB
         LngQ0P6SMcUzLXqadlEWp7lVxbGLxbHjoX8wKX0bx3S0un5x+YV1z2Wpxne8hbeCni38
         xVaCEQItpP5OU/WUu7W5MKdaQk16VYa4urGpelL4pnJkH2NQ7te1cvDhxm+qMEz76RuJ
         7jbQ==
X-Gm-Message-State: AOJu0Yys7RhM0tko67t9ckDu/J6lMOsl9saGMaTkfJMxFOt0Juz8DKnZ
	8l8xIvzV7QxxtcWAP/5sG7cH+2RSGt9nivOB5roh3EJR99CXiRwAnH00AoomAJ4QbSy6UNeBcHK
	QBgmJSo5sVjFt0bSZdn1TO2F/tVMhhitdhf09TWS2
X-Gm-Gg: ASbGncvhRDvnJmYGRvsJNJVrdYD63BGc9oHx5JSNtyd+0MY/1d3oaZATiJ8K/dU7fe4
	pj3mVbFfSWs9PkrCBPdPGLqzNQA5IptzNislm3tmTst1rTRlslxsxuLl0n/YMDvK1s376enUYcw
	uUe43uluChSmrwZUIVIq8ah0mdZ7TjhboiKqHWd7824Vx+TMbeUTsInSEtgz7hQ8hHXJ7qstLtN
	NWV10b1JK5I4MeudBAq3GW8XmMJ69dGxcFCLJd2En4rUoAe8GHPO+1g8kNhcHM8UZcn5NLHMnyX
	PLYflpphqdN1qrw/sJQR4LRWOByzAw==
X-Google-Smtp-Source: AGHT+IF3RUwGlec9Zhsh94CaXW/wx9KKvZccyA1Fw/9jHlszajcWuoRNvemdwPNijSsFkSH/w+H2PIm/n6IO
X-Received: by 2002:a5d:6da9:0:b0:38b:ee01:ae2 with SMTP id ffacd0b85a97d-38dbb233181mr8979755f8f.10.1739063989574;
        Sat, 08 Feb 2025 17:19:49 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38dd6880056sm149536f8f.16.2025.02.08.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:19:49 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH 1/4] wifi: mt76: add mt76_get_power_bound helper function
Date: Sun,  9 Feb 2025 01:18:53 +0000
Message-Id: <20250209011856.6726-2-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
References: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will replace mt7915_get_power_bound function from b/mt7915/mcu.h, since we will need it also for mt7921 and mt7925

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


