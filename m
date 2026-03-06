Return-Path: <linux-wireless+bounces-32684-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DlcKdliq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32684-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E6228AC3
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567DF306294D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23853537DA;
	Fri,  6 Mar 2026 23:24:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB835E950
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839441; cv=none; b=iNbiBNKl8HqSVLBz1B8NHLd1nuSLBUGzNFyQSMCSLVVVJpBMHZW5E53wSKNAGgX4NGKvjqN/YqEDdiBedlimunGbaNUuy1o79ZjIDq4XUYB7joIxNd0i4PKlBjE3AF87clm7nLRpwgGpAe4Q3oBhUtT5EKfUqoqHScMoRAZ+2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839441; c=relaxed/simple;
	bh=QCSX20SRqKpVXNgAkaTA3AZWxO2J2F3npzUuJPnwrV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmY0CTZUVfGiztj5+x27TQ+9uR9cEqL6IswI0dkNh6SDHPlFsPe8wgOiWmJUKGVnFjjoeWUi4ga/kvXHWKoNjuWGm6XGAyeIGkPTf69bbN3sY9FTXstPkKckke835axFrV5JXUG0NCvlu6j51wC63CdXAfOZJibCUO4swDL9D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679ed01869fso3704681eaf.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839440; x=1773444240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4usbtTpP237Cyh3bnTarmi4Xn7UcGKghpAb4WKVsuwE=;
        b=CEYCCF41Pb2Cx6sFJxuoL09pI9Ghlp4Ziyx3VTFUynr62EjvfTUUJcb7JcdkQbuKfc
         rC71rGWYi0oaQjV+8KOcwtEUGJ5q6vRaS7OmCgme11vYgUKilkpLC83sNjff2x6BmiU+
         XbUv7NunzJvq0h+ixZq75p6BP0zpL3sfkhjGZ4WzxN17YmB6VGBOM3jpOu1hoFNV06Tl
         hBSUjhZ/vFUbyoCGg+RblLWSFIY8QhvBTxo69lNePKjG1se9Eu2w9tSvwX70VKg73/Bn
         RiLH6sDPMtIT+2Oq1QsOA9RWcM2ewTDat71Vr3MgHC8aHNEb+xbkoIHSoTy67tQewLmb
         Tm0Q==
X-Gm-Message-State: AOJu0Yzwfy4592H+WJ2hmNfzos2TL0WTH0Sr/L4fIefClU2qpkjxc9Qo
	JdBj712eJEc2PkI+hLGQLl5SK9LnynyDdlU6YTfzIcYj08qtu8GblaBp
X-Gm-Gg: ATEYQzyGF8/llM7VjOOOo9eLe9gibqhI+SM5IUxESVNwJ3YLrGwao6+l1uQWfQGZibg
	1iO1cIbBLP/V0CGaznpCN9i8qGAbm1L4oGOj1wQ9+9rh8yYRyuMNuQ2frYoEijoCyuETf0gh4RW
	GjHY97vFj166sauOTvGDfTvH1FdIz1iaKxSFd/Ndxaq/4j/5KpjHmt5ZZpJ2bKwpI+vaaLNzlF8
	E7xjrGv5WdTGW6MPLL8Chs8yNshPfetU/iyfiQEXhi3iheRbypHG92X+mDfRcjsezNYlvVnqf8G
	Dwu6umjFmmaZQeBBT7HEugyS4OYalQdr3KhbrNVcw2fS2ubV4aQEq10MAH+jTVGQMK0aLC1o1UI
	Flu4+dHRxFjuAg1TuYKlbPx3Xyg7TAdxMdFCFq8m86tqEnx/XOVIAJRKjPw5dGq68mDN0ERb+JD
	Nzmei0oTqs1jDrxILRkzVja/iM8SchC+lQEeAdhd9VP8+8MBo=
X-Received: by 2002:a05:6820:3103:b0:679:97ac:2cc0 with SMTP id 006d021491bc7-67b9bc96eddmr2546250eaf.24.1772839439571;
        Fri, 06 Mar 2026 15:23:59 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:59 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 19/19] wifi: mt76: mt7925: host-only unwind published links on add failure
Date: Fri,  6 Mar 2026 17:22:38 -0600
Message-ID: <20260306232238.2039675-20-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 0E0E6228AC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32684-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.386];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Release host link resources when mt7925_mac_sta_add_links() fails after
partial success.

msta->link[] and dev->mt76.wcid[] may already be published, so unwind
the host state to avoid leaving stale links behind.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 95c631b57894..73d3722739d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -989,11 +989,51 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	return ret;
 }
 
+/*
+ * Host-only unwind for sta_add_links() failures.
+ *
+ * If add_links fail due to MCU/firmware timeouts; calling the full remove
+ * path would send more firmware commands and may hang again. So only rollback
+ * host-published state here (msta->link/valid_links, dev->mt76.wcid[idx]) and
+ * free mlink objects (RCU-safe). Firmware state is left for reset/recovery.
+ */
+static void
+mt7925_mac_sta_unwind_links_host(struct mt792x_dev *dev,
+				 struct ieee80211_sta *sta,
+				 unsigned long links)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt792x_link_sta *mlink;
+		u16 idx;
+
+		mlink = rcu_replace_pointer(msta->link[link_id], NULL,
+					    lockdep_is_held(&dev->mt76.mutex));
+		if (!mlink)
+			continue;
+
+		msta->valid_links &= ~BIT(link_id);
+		if (msta->deflink_id == link_id)
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+
+		idx = mlink->wcid.idx;
+		rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+		mt76_wcid_cleanup(&dev->mt76, &mlink->wcid);
+		mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
+
+		if (mlink != &msta->deflink)
+			kfree_rcu(mlink, rcu_head);
+	}
+}
+
 static int
 mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, unsigned long new_links)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned long added_links = 0;
 	unsigned int link_id;
 	int err = 0;
 
@@ -1030,8 +1070,13 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 
 		rcu_assign_pointer(msta->link[link_id], mlink);
 		msta->valid_links |= BIT(link_id);
+
+		added_links |= BIT(link_id);
 	}
 
+	if (err && added_links)
+		mt7925_mac_sta_unwind_links_host(dev, sta, added_links);
+
 	return err;
 }
 
-- 
2.43.0


