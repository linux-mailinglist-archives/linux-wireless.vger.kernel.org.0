Return-Path: <linux-wireless+bounces-32681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGS0BMliq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B255228AAE
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85662314A23D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243D35E950;
	Fri,  6 Mar 2026 23:23:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109035BDC4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839435; cv=none; b=IB82GDFLr2aix7AOuk90mucPAKfqSk/5v0QVSqhbIHe/RmO+/pFWutalSBe/O/O/sQs/tFeczJPDouKOUBxbPO0F35Otw9HqMw7eiKanjMcZ78gLiDWXFV9oMqbSnwer1E/rRXa2C4ksUmFvAuojA011JWodJzia6JfaGgQsE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839435; c=relaxed/simple;
	bh=Q5OKpPK2NQ1Mwe7KxJrnGQFzuo+7/lEMpn3mC2EjC9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2GblpGF5n85I50pU8f4xRsaHpdGo80QoZPfu8K+ff9DiuR99dEJAKtZtd9nCcSA7imgn/3Xii6FKzb1EXF1wRDMCsMGc5N8cYP2uSKe2vfgqmisxY+Ym2+IgaOVAr3q2U9zkAr2MWSwKFMcte+E2QjZWRY3PhL3FyodMxQowSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so3122846fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839433; x=1773444233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8U9+hSIbEs940Aoyd4sF/1aA7wYAwUcqyyOlSkJHcI=;
        b=WKsGekUALeb6tVsc1n7INQiBmRCac+aDBKQzqSXakYTMtXqUFM72slLcEd+j0YuDZc
         kmMuLwWuqUVmVQuavqgKkdLA9rFoWzBsPCOZkIv3MIUkhmBnQ8FFN9fGXyOaYBU6xzVL
         CNuBUlhmRnwAsxHDBSG8/uJr4z8KlgSmAZDujMLzGgzGftt4RfU0/cGPZ5G+UGHmHvpe
         aiTp9lf5gOxDr3w2oy/288d5il11OmpvGKbiMO0EKhR6MlW48UxavaYjDF1552EIbUvZ
         S65U06ds7FiMjFvB9DChnx6W7mHV1Lx+xFKpDzyq+3zP9NX29wQj8SX57rMQxh3Tx7q2
         dtUA==
X-Gm-Message-State: AOJu0YxvIZRRnxbKwNMKlmwhgQPB6BKFI+SJ+2HpAvubyUZjRXuhaltO
	lurnd5B3erzwrVqiDpQjSbng3IU0otZL9MvVvhI9k6arIsTEc1PAexZr
X-Gm-Gg: ATEYQzxrYCCQMSX8QYX3ksy/uag7ajNxOqm2uPZwOiM2SBBKOqQdAA+Z+n0hGLmtptr
	h9mrBiXGFlCfdq0Cg21CIMaBnZimkfPlmpimnaJlAKg018XvfPf31bMeWUmQddRJUjqeoht2J/g
	PADnZfKnmr2Bm+IEoZZLgnD6a5ZhAfizeJnWOqMgzsttnaU1lcRzE3238YJfW8HuF6KcAitEIG7
	r0MwtU69zyzcb5T6QIGre5KkBkxRMt004/E8J+txadZbfXkBPBqkv4W3LQCN6XN1vXS92AOyx27
	LqrTq/MafvCNZgyld8Lg9uCdcomPRf4TjQZg7fjW59KVNa6p68s/IChYwDeOrlZIuDY7K2CURBW
	UybF9Rwq5xEPe7xDBynzKxhGCndDJ7uasTdm3PIye0e+vUhnNo70xaDKvMbMptKMhcCHDB4IeJS
	1Y8w0ywyBT9pQWHNzfb7GGz7y1fEe0gl1ayMvSAxw9mFtwwjc=
X-Received: by 2002:a05:687c:2191:b0:332:1b00:6d5 with SMTP id 586e51a60fabf-416e43ea37cmr2331768fac.39.1772839432955;
        Fri, 06 Mar 2026 15:23:52 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:52 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 16/19] wifi: mt76: mt7925: move WCID teardown into link_sta_remove()
Date: Fri,  6 Mar 2026 17:22:35 -0600
Message-ID: <20260306232238.2039675-17-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B255228AAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32681-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.378];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Move WCID teardown into mt7925_mac_link_sta_remove() to mirror the
dev->mt76.wcid[] publish done during link add.

This clears the published WCID before the rest of teardown, so WCID
lookups no longer expose a link that is being removed.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d99dbd707fcd..9e3f3874d0b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1151,12 +1151,14 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 				       struct mt792x_link_sta *mlink)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt76_wcid *wcid = &mlink->wcid;
 	struct ieee80211_bss_conf *link_conf;
 	u8 link_id = link_sta->link_id;
+	u16 idx = wcid->idx;
 
 	mt7925_roc_abort_sync(dev);
 
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
 	mt7925_mcu_sta_update(dev, link_sta, vif, mlink, false,
@@ -1183,6 +1185,10 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		list_del_init(&mlink->wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_cleanup(mdev, wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
+
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
@@ -1191,8 +1197,6 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, unsigned long old_links)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_wcid *wcid;
 	unsigned int link_id;
 
 	/* clean up bss before starec */
@@ -1235,16 +1239,12 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		if (!mlink)
 			continue;
 
-		mt7925_mac_link_sta_remove(&dev->mt76, vif, link_sta, mlink);
-
-		wcid = &mlink->wcid;
 		rcu_assign_pointer(msta->link[link_id], NULL);
 		msta->valid_links &= ~BIT(link_id);
 		mlink->sta = NULL;
 		mlink->pri_link = NULL;
 
-		mt76_wcid_cleanup(mdev, wcid);
-		mt76_wcid_mask_clear(mdev->wcid_mask, wcid->idx);
+		mt7925_mac_link_sta_remove(&dev->mt76, vif, link_sta, mlink);
 
 		if (msta->deflink_id == link_id)
 			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
-- 
2.43.0


