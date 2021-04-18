Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47D3636BD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhDRQq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhDRQq1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACAF56135B;
        Sun, 18 Apr 2021 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764359;
        bh=ke+RBzaKWQerzq999gaact9VTa49Kdm00iHJ+ieUuo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCOCFZPPk8OH2t+0SoBb9+2g5BJMHs1NGzAnav/FDZ7Uuv63hLyBnRke6J+s6lx20
         Q7IeV5Z2TEzyDqX0jPOOZXiadJ6qw7ilJ3m7drN9zUhbdvbgNlWAoi+BfzpUQNCQCb
         VfRbz4haXxHEWwwYEkH1SYDT+XV44FlPvsxeheDDvc0mEP8DAkuOUmmlAfx8SRP+FD
         yYdyE8F1lASzbqMdAS08IB3yQ3n7Jd8ZxgSDUTJpWQlx5nQg/3W6ZjMb+TYnxokflW
         WLVAU2gcx8kZyM1Q4XTaxBBZM16wvu7dtA/u4wUqHoOf3HPys3HmmAgXmNuuZGTUNu
         +E1+OFcyW2Hrg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 03/19] mt76: connac: introduce wake counter for fw_pmctrl synchronization
Date:   Sun, 18 Apr 2021 18:45:29 +0200
Message-Id: <24ce174c35b8517397d7c726b0f783b128c08ec5.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce wake counter and related spinlock in order to synchronize
tx/rx path and fw_pmctrl request.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 2b31c9794e92..85846eab8d7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -54,6 +54,11 @@ struct mt76_connac_pm {
 
 	struct work_struct wake_work;
 	struct completion wake_cmpl;
+
+	struct {
+		spinlock_t lock;
+		u32 count;
+	} wake;
 	struct mutex mutex;
 
 	struct delayed_work ps_work;
@@ -85,6 +90,32 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 void mt76_connac_free_pending_tx_skbs(struct mt76_connac_pm *pm,
 				      struct mt76_wcid *wcid);
 
+static inline bool
+mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
+{
+	bool ret = false;
+
+	spin_lock_bh(&pm->wake.lock);
+	if (test_bit(MT76_STATE_PM, &phy->state))
+		goto out;
+
+	pm->wake.count++;
+	ret = true;
+out:
+	spin_unlock_bh(&pm->wake.lock);
+
+	return ret;
+}
+
+static inline void
+mt76_connac_pm_unref(struct mt76_connac_pm *pm)
+{
+	spin_lock_bh(&pm->wake.lock);
+	pm->wake.count--;
+	pm->last_activity = jiffies;
+	spin_unlock_bh(&pm->wake.lock);
+}
+
 static inline void
 mt76_connac_mutex_acquire(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	__acquires(&dev->mutex)
-- 
2.30.2

