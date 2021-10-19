Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB143334B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhJSKPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235173AbhJSKPZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B4A6137B;
        Tue, 19 Oct 2021 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638392;
        bh=uatDr9PikZZvm1xJF/UuyOk8v1kSgPXBnlmJDtjCBEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdJoz43foHRtMe7SckqMtR9rEBy6iXLne/3atZrSsrdEWqMNRLJH9Kf53c09leFSu
         bJPqjO/oJ2va8nPV9ySOkDzveAA9utOS4HzgKUEUdq7Lk6reLvLAXuOid5fgEQlKyV
         e8dyaIwZVxd/dJnTyX4uNnCcGp0Y9NUrmeA4QXU4jUP59UjWI0hzoaQMkxpbtNWFB7
         cBgUogsbZshoMYXP1CwXnqK2xbi9jOOi9RIge1LhawVxo9f6g2dzMiRIdTIdzmvFlh
         iXraS05F+u1iSFn+mjuvhT9BGE0egooPKTaBCrjf78Ec385du1q/GsHcBTX86PPbMG
         cR/7swNp+R9rg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 05/10] mt76: do not reset MIB counters in get_stats callback
Date:   Tue, 19 Oct 2021 12:12:27 +0200
Message-Id: <803ee266c21ea1667960738c9d4b5801eac9d8e3.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MIB counters are used for ethtool stats as well

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d5bcffef7122..343e157261ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -862,8 +862,6 @@ mt7615_get_stats(struct ieee80211_hw *hw,
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
-	memset(mib, 0, sizeof(*mib));
-
 	mt7615_mutex_release(phy->dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 15daacabed75..34349961b751 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -811,13 +811,12 @@ mt7915_get_stats(struct ieee80211_hw *hw,
 	struct mib_stats *mib = &phy->mib;
 
 	mutex_lock(&dev->mt76.mutex);
+
 	stats->dot11RTSSuccessCount = mib->rts_cnt;
 	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
-	memset(mib, 0, sizeof(*mib));
-
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index d968990dac6e..22d5a0adb5ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -856,8 +856,6 @@ mt7921_get_stats(struct ieee80211_hw *hw,
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
-	memset(mib, 0, sizeof(*mib));
-
 	mt7921_mutex_release(phy->dev);
 
 	return 0;
-- 
2.31.1

