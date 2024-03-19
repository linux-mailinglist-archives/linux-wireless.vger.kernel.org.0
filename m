Return-Path: <linux-wireless+bounces-4908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5753880052
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63061C2219D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D932D05E;
	Tue, 19 Mar 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOf/N5Gu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70F3C2D
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861205; cv=none; b=HDh8Apae2Oe+QCbea06sqgfsVnPV5rEUaaYY9/DVlZ7VNaU8fWzMJYZLud7lQ64e2tu4jbd6QaeHxtT7Jio4QtOxd83RgIxvheDO1upfua4xXPlhv7b0lYYW+xsfV6WiGITU5MUjcgCr7vA4bSOtnEfo1e5nUESAlVQffRDVHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861205; c=relaxed/simple;
	bh=iHbCw7q73Y9pa5HbsBVIi+Cg1gUkrzKtQF4h87cw/gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1E46T3nBuXFFtgV3RIfaKu7xyYhHX6eNbULr5Rje+HBAaIdKa4lgGq2mzyDRBiNLWfloKv45apWbvb+0336+JUBZZU4miDrANXCOVP7N9vBXf0tfjTEdI0cWPBlnQz2IvarSg9w2WGUVViHvZwq1DAK/jGGR1SvbEls5RX6vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOf/N5Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C62C433C7;
	Tue, 19 Mar 2024 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710861204;
	bh=iHbCw7q73Y9pa5HbsBVIi+Cg1gUkrzKtQF4h87cw/gg=;
	h=From:To:Cc:Subject:Date:From;
	b=QOf/N5GuddbPjFuZcep9lFNwPLJQ2gm04gLcldBHZqvmCXh8wTOflalPUjaKzUt3T
	 NHFAYJW1zsIFiQCnWIFT/1HE7zzEbdvLzsK9Hy9AeJqBe2071X3sOPZupIovJIsJ64
	 NDW/+AqWSaaCIy2iRveI4xLf0Q1n6iFf2tL6tIedy5In6j+H+cr5kUgb7LZRAUK+Dp
	 P0KhnCGIKrDOnQyBuwrGz6XiRStHU4d+nFFnEDWksJLKf9tkVe4/6xXoIyUNO2BfJl
	 Rbw7s7Rg1KmNt2KIV8kIQD8zyX60AAG+BeIsQLKZoOR8n4TkNqZyFCQJbHwqf1TgI1
	 0HouC66KTXqLQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	shayne.chen@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7915: workaround too long expansion sparse warnings
Date: Tue, 19 Mar 2024 16:12:47 +0100
Message-ID: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following sparse warnings:

drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion

No functional changes, compile tested only.

Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6c3696c8c700..450f4d221184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1049,6 +1049,7 @@ static ssize_t
 mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
+	int i, ret, pwr, pwr160 = 0, pwr80 = 0, pwr40 = 0, pwr20 = 0;
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
@@ -1057,7 +1058,6 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 		.band_idx = phy->mt76->band_idx,
 	};
 	char buf[100];
-	int i, ret, pwr160 = 0, pwr80 = 0, pwr40 = 0, pwr20 = 0;
 	enum mac80211_rx_encoding mode;
 	u32 offs = 0, len = 0;
 
@@ -1130,8 +1130,8 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 	if (ret)
 		goto out;
 
-	mphy->txpower_cur = max(mphy->txpower_cur,
-				max(pwr160, max(pwr80, max(pwr40, pwr20))));
+	pwr = max3(pwr80, pwr40, pwr20);
+	mphy->txpower_cur = max3(mphy->txpower_cur, pwr160, pwr);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
-- 
2.44.0


