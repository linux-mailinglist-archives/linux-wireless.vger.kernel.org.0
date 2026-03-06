Return-Path: <linux-wireless+bounces-32682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCPYGM5iq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B4228AB5
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AFE8305B959
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6C371CFC;
	Fri,  6 Mar 2026 23:23:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B223750D7
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839437; cv=none; b=hfTgS4oQOoDSdd0Gi7//Ia2FL/+UebFa5JDJ6fzNhs8uVf9MLOA/qF+gvWLDFxoEl6193NKWuF6YmET2vLY9t4V4UcoPUPk0xJCIP4MarO7uTXBw8Jnos7fgLI38/4b7YWb5tES30I1IVfJiFsph2IQ0DwXVr1RY54CNmu3+VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839437; c=relaxed/simple;
	bh=J2kqXsno68lP0mN6sGPfrE7YSU2VC+AS+XT+Mzw6puU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2kQN/AnnuLTVhx94AQ3/I91UC68ml/PS0B+LsB8A+TjJpM4A4gK74YaPIcX+Gh6sdz9RngNdM+TNsbYkY5k9Ky1Cnw+GLlewuWRnF2+QT2J3oNI+cw+MWPjeLIz5MNycNAbpPxWyceDA9RwXjsQiOCCPtaZmP2ZRpky1WTvPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4042fe53946so2005743fac.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839435; x=1773444235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3R5QDZUhULiTl/yEuN8UleTD/KcNOdRgdU7r70FJACI=;
        b=rtaanD81w8q+uoD3BudgceDtWyYBlGb1hL23EbFHt/Jn0N2jtVsivBgg3CP7e9iyNb
         7JkBY+/bw1dgE28S49/gr0uqXkxSVw+zwTJmpDivyGT+g3hAC8O4FMD/maXXt5+pSAG6
         fZ1P+BezsAEgcZviEcObymwQe/ZnCShJMU+zRNavByFYY4en2dUC8i6ED9f2aWRkvEw3
         4ds5+SB8TWvAcjz9wJn0L9UWgNlLCjpHio65hBoJiI15d0m9AIUAndAXvddoKtsbQf/7
         hHH+H0kwo36f+b03SrvrKxAHRu1l9n2xZr+3MH62HUnNp5MYV0R0BwCKCmItEEbs3ADe
         92CQ==
X-Gm-Message-State: AOJu0YyOBZZMgmSa8ByKcXS8uIkFDE9ToWV/lj6+ucAvuPnWvqKbH3qH
	/608vB8fGJ1WdzC5V3W3+FzxqsPsFhZv5iePaP7ndFG7YQDPKvrLagcg
X-Gm-Gg: ATEYQzzPw/zo0UyqHUtJOQx8u3KITr6NbJOV92rVs2GnPrzQZmVY3GKtu5ED7PuyKvZ
	gP8FlqItE1VcXjI45Ip1j/u/2bDXYRfNYrUYUiQIROcUunBocZmdpwYaW+zapt6851gjHETF+YJ
	kUChMer1bTp7+SN7MVCDiVv7VpEZeBcHGtxjYSztuEh3lQebNCe7DUnPIVpW3f8exPVPudA1cMB
	Y2GUakmRA4DAa761lsz2DaR1OmwRSfj33xvFiq/5nVoNxGU2rjFIdl5Ds0iCAMohsc/6GTHlst0
	tB+gw9RCjysxlPZl/IyKG0HKNJs+J7HO7bffSeFFnLS+/E00Di6VndisHu3pPtGrej0iuXOTNBE
	mfWJhcuTVIqbI0oDIcQpE9cx66OTi2r8z0KNejy6DzjXdX/8g4q47hZkVA/111qCDbmOP9VH+X0
	kq0e7B6BawXC6e3RPF53iXRew2C2pA9FStv8VoBXQCVOlyQI4=
X-Received: by 2002:a05:6871:7993:b0:409:47c2:bea with SMTP id 586e51a60fabf-416e43f6484mr2249906fac.41.1772839434703;
        Fri, 06 Mar 2026 15:23:54 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:54 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 17/19] wifi: mt76: mt7925: switch link STA allocation to RCU lifetime
Date: Fri,  6 Mar 2026 17:22:36 -0600
Message-ID: <20260306232238.2039675-18-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 054B4228AB5
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
	TAGGED_FROM(0.00)[bounces-32682-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.395];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Allocate mt792x_link_sta with kzalloc() and free it with kfree_rcu()
instead of devm-managed memory.

msta->link[] is published via RCU, so the link STA must remain valid
until readers have quiesced after teardown. Manage the object lifetime
with kfree_rcu() to match its RCU-visible publication.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 +++++++---
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9e3f3874d0b3..eb16c4683100 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1005,7 +1005,7 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			mlink = &msta->deflink;
 			msta->deflink_id = link_id;
 		} else {
-			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink), GFP_KERNEL);
+			mlink = kzalloc(sizeof(*mlink), GFP_KERNEL);
 			if (!mlink) {
 				err = -ENOMEM;
 				break;
@@ -1197,6 +1197,7 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, unsigned long old_links)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt76_dev *mdev = &dev->mt76;
 	unsigned int link_id;
 
 	/* clean up bss before starec */
@@ -1235,17 +1236,20 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		if (!link_sta)
 			continue;
 
-		mlink = mt792x_sta_to_link(msta, link_id);
+		mlink = rcu_replace_pointer(msta->link[link_id], NULL,
+					    lockdep_is_held(&mdev->mutex));
 		if (!mlink)
 			continue;
 
-		rcu_assign_pointer(msta->link[link_id], NULL);
 		msta->valid_links &= ~BIT(link_id);
 		mlink->sta = NULL;
 		mlink->pri_link = NULL;
 
 		mt7925_mac_link_sta_remove(&dev->mt76, vif, link_sta, mlink);
 
+		if (mlink != &msta->deflink)
+			kfree_rcu(mlink, rcu_head);
+
 		if (msta->deflink_id == link_id)
 			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 1f381ab356bc..4ff93f2cd624 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -97,6 +97,7 @@ DECLARE_EWMA(avg_signal, 10, 8)
 
 struct mt792x_link_sta {
 	struct mt76_wcid wcid; /* must be first */
+	struct rcu_head rcu_head;
 
 	u32 airtime_ac[8];
 
-- 
2.43.0


