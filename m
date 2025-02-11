Return-Path: <linux-wireless+bounces-18751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D1A3056F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 09:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F607A2440
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAB1EEA5C;
	Tue, 11 Feb 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="GfXBNq3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F91EF097
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261663; cv=none; b=Qtj3wYkjLsNAo43TIAXZtvdzW+kJWVIrr08gloe5iMN7UPh/fScTjcfLLuPVgd9djikSWLuSBrmXwGQHEVi2TXzLwGkxfO9D3Y5EN6GhNdkfX06WrKr++VBFK0XUum9MQLQzQhgRiKtx9XQacUSAnnzS61Ct9W+43DSmO6zNgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261663; c=relaxed/simple;
	bh=J6F3zBCZe0fazTRt7fhzcVpdNnAccYYML2xKSe30dh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpxAXYshtoOZeSBmgOSMLtr8KoFLmz7yvFN1saqBoB+HomDHV14ZOA5/+EvkYClwBsHJtKxUZ498w9HqjHaGi2otNmBQ+sdFy7/dkgkFLJNj2+U4M2b7yvChgiy/XJFLJCyswLdcoc8ZZe79+CLKRV17urstVbfxI0Sbl169eMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=GfXBNq3O; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so6344583a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739261660; x=1739866460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1degeRkjr7tF9YW7hsf7m1PNJG7T8j2LksWyE93vkAw=;
        b=GfXBNq3Ow6hjeA3XybsOa7o+CINrCoRAjuFFLxxq5GFEk2QB5H6ilwM8UyS9hBCv8S
         sQkwPiwZGhvQ7iozEAkb6H9RBgyR1OpOLymQK30Cb8DwX0oe1pdEwbEIdq6nF1FvmHA3
         2J6eqTJ/zQpdoQbsXCJT27GKAAbqOMrX/B2Y4kao0j7LuMxQZWa1efZtFfaFB5obGePw
         eVEc+52FqWUjziuyCyaKHWkFr2f6C08AjW/7fgkFVa5xrt1+F5rBGInoYoHiegJ062yz
         XGkoprqKXV+1hIz006kCuk85Jdbgyzlhh9qEYOxpZneLTHG4Cgl+Gu9CCKMErNrMQru5
         wGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261660; x=1739866460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1degeRkjr7tF9YW7hsf7m1PNJG7T8j2LksWyE93vkAw=;
        b=AwbJDs9bee7aZbaJXuZPSZoI3Uv6Uh3VXH87xlon1K32OkVIlQeVJzuwtGijV1GGyf
         ROtLcxsKGoCIWrJaL8J9LcBehj7fHVVM6lGCOF1m1YnsJQRyvaaSNZMC8oJnuzjdfz6U
         gONnW3AxLtMFTVk3KdnWZ39go3M7BBt1045ZQ5R2X88E6JdEsMTjZVUp4JE98q/b0Og8
         bkhTYtGprnjIy3zTK+MpK/Qj7XfAEklzTT+i/QzYN23TzAYbrQWoa470r1tncfvk0OIO
         NJ5nYa1T+24dyxdZ0Vl4X1YrrfSqVrQz/g7LVxCK2XjPlk2UN+A6kCyVL7B/rRCqV2WA
         vFiA==
X-Gm-Message-State: AOJu0YzPK6ojeMsbGR+oAmuJ/N34KWl1/mchB6PRbQIF0hNrzIoLq9gI
	lbhcwv7PAGwnP+42EXvhr64hP+CIgVomP87GBxtxbv4sxnVBWMvJOEAyZOHN4xSW3dxZSywOzs4
	AZQuNMJic6pS12A+/LM55y06v/uOoHPv4Ajw5T54r
X-Gm-Gg: ASbGnctLhrtm+lCLTE5rOewCBDnA0epTNTVsgVQhaOFUU+YhFQfDqfJvlbNemXUnHIi
	WVGrY0k1kAuoverJImacRtoc8qdU04eWRCxJJ3k4AKh2d1tvVp6HEWlhYNfvx5jRCW5mmiN8N7i
	/Z7yplLTnk+gIAtRJE9ECe4p/Rk5Q8n5gYEzWxmlQrfAcyt/zvaovJFNPnExGPmOMKY17tREhyU
	yX4qiTlD4JhBqk65lsndbVcI1/ZuPCsPe78hU5z9pq8r1mzvW9rsKEjGeKe8w6g7EWhy1glyafd
	iVsHGUm5NcFi5BuR6NQbqbpRCCodnQ==
X-Google-Smtp-Source: AGHT+IGmceo4xpCUlPHgWiNSpUfNIptVQCJWVsQv965kNTPFGucqzfcJfpKIPW3cmSsfUlf+EvoS6S19r/z9
X-Received: by 2002:a05:6402:1ec5:b0:5dc:545:40a7 with SMTP id 4fb4d7f45d1cf-5de45005b92mr19536060a12.12.1739261659597;
        Tue, 11 Feb 2025 00:14:19 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-5de57041c05sm222537a12.12.2025.02.11.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:14:19 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH v2 5/5] wifi: mt76: mt7996: cleanup mt7996_get_power_bound
Date: Tue, 11 Feb 2025 08:12:47 +0000
Message-Id: <20250211081247.5892-6-razvan.grigore@vampirebyte.ro>
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

Refactor for making use of mt76_get_power_bound instead of the specific
mt7996_get_power_bound, since we need this for other chipsets as well
when calculating txpower

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e4569d032221..76f489e2f602 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4579,7 +4579,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 	struct sk_buff *skb;
 	int i, tx_power;
 
-	tx_power = mt7996_get_power_bound(phy, phy->txpower);
+	tx_power = mt76_get_power_bound(mphy, phy->txpower);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &la, tx_power);
 	mphy->txpower_cur = tx_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 43468bcaffc6..bd1ba00e1bc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -809,18 +809,6 @@ enum {
 #define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
 					 MT7996_BEACON_UPDATE_SIZE)
 
-static inline s8
-mt7996_get_power_bound(struct mt7996_phy *phy, s8 txpower)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	int n_chains = hweight16(mphy->chainmask);
-
-	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
-	txpower -= mt76_tx_power_nss_delta(n_chains);
-
-	return txpower;
-}
-
 enum {
 	UNI_BAND_CONFIG_RADIO_ENABLE,
 	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
-- 
2.34.1


