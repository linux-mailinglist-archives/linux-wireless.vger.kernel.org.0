Return-Path: <linux-wireless+bounces-32668-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBiqA/Fhq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32668-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5222289F6
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC01830152F3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3C35F8D1;
	Fri,  6 Mar 2026 23:23:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD32ECE91
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839401; cv=none; b=lR0W0gHdEkeb/jAgKx6+lYNonr23cN+EGVcl5H9FxITsccIMwUotuoXspyrnBJxvNvbiZpAKgxo/BaP2VRv8Qo+hpOfLlPL14Y16+cEQFMSQ10EOZOY9bEr5jbvH02r3qnm3twQINtiw3duiZAO3S0BRBrfTb93OdmMNbKJW1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839401; c=relaxed/simple;
	bh=Ah5mu5+Qnh4J5qFhMw+uM0mu2ugot/ZzkoSoqnBpKxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGGQ/yOOuz618t8SGXQ0Dn+oV+M1R2fowjgBLICHHbrnFN8f9mMLYD2kAUrLCPCO5590o1RwrsV5NbwPDNpkDHII3KvB4lQqu9RsfJzJBJzpCGW0n9DJTR0nbJcitFMJiQApTvL4exgE97FuL1zZoKD8N+0fSqBQxTFTaOqmT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40974bf7781so3345839fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839399; x=1773444199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFThv3/KwCcJjpSjEVWA04EAjQFCUckpBbwFZ3Jw+5M=;
        b=i6pUUh0RH2/BbV6/UiSGU1hc/MOEAPJh17Y9lmwR+ynbN8AdwzVo/QecxBraCZ/8lP
         XdD6QCFMoysFRjZjN35pagFVTrhbmIjfKoP8n2SsV3/+vAg4X+LRi3UK2bt2VjpILvds
         7EKsWt7uKhywxuN1r5abA5coKMkXjxpAm5fcKwCmnECzjJbL/4lEGs3Nizg8LuRDF8Sl
         q5l4l+9zDWsyUy1azwJGN1UxvZ0nRTIYNIatdN8819gMU56sKndv1rAWELBd0H3JF0mW
         ga3wq3x6wAcBcxCvuve5fZMI4+muzs+GbE1F5fCmMj8VfS6mhAJLjg2Xt/k9DXaJIS4J
         t+PQ==
X-Gm-Message-State: AOJu0YznVVFVTN587To1jADVg1bbSJS4qxkKuSCnzg/xK1nlIypkXkFp
	4C1cPo1V+cjZe0CkHHHiV5nuCdjgoLeoHbSZiYBWpGE+W1U1kw1socr/
X-Gm-Gg: ATEYQzx8oOHd8OQlPMu+GdUsS/KJhsTHaXKqvONeVYu3CRAl6UnW7ooB07EkfG2stMD
	pIeSFgMJGfRjtxU+Vvbm7Z1I4yQPsENf6y58v3G8Wepuwd8alVlsQZJrkmwh+d0x9Fri36rH4GH
	xd5i11VMLBm5rdxfhGhFcZ9COrjSSuI/5cCawMwxiKSIFhF7z+lJAPxxjf6ATHnpAsryqBM5bW7
	GOCo9gpCFyqKT2JLE86OeGrTm6ZHvVmNbsOrB63ain3jEafxQH2rHd8VzKZmpzjS+SOt5Y0zcEd
	Qq4Ywu4+PtRy9GKap3kPMdHQ4/7RQFEeJkvuvq2gI4oVDkFfNzC0kFX2w9Maq13PLVJ4Nivbna2
	9DBskFJF2Wk5CETveoLgfBc6MN4S4CTkDvfASoADR5ZhZm8hqQfcmVMOKMWDbdQYqVnxbUt212p
	6RAl072xSB0uJjIffMKsgw5DseB4Hy07GY4jZE81be670JKG0=
X-Received: by 2002:a05:6870:bac4:b0:409:62ce:83f6 with SMTP id 586e51a60fabf-416c3ae28a8mr4667196fac.5.1772839399592;
        Fri, 06 Mar 2026 15:23:19 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:18 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 03/19] wifi: mt76: mt7925: pass mlink and mconf to sta_mld_tlv()
Date: Fri,  6 Mar 2026 17:22:22 -0600
Message-ID: <20260306232238.2039675-4-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 0F5222289F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32668-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.395];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_sta_mld_tlv() and
pass mlink and mconf from the caller instead. The link context is
already known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes MLD link selection
explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 53 +++++++++++++------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0d5519e5dc4a..7582a8c48607 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1914,36 +1914,53 @@ mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
 
 static void
 mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
-		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+		       struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta,
+		       struct mt792x_bss_conf *mconf,
+		       struct mt792x_link_sta *mlink)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	unsigned long valid = mvif->valid_links;
-	struct mt792x_bss_conf *mconf;
-	struct mt792x_link_sta *mlink;
+		struct mt792x_dev *dev = mvif->phy->dev;
+	struct mt792x_bss_conf *mconf_pri;
 	struct sta_rec_mld *mld;
 	struct tlv *tlv;
-	int i, cnt = 0;
+	u8 cnt = 0;
+
+	/* Primary link always uses driver's deflink WCID. */
+	mconf_pri = (msta->deflink_id != IEEE80211_LINK_UNSPECIFIED) ?
+		    mt792x_vif_to_link(mvif, msta->deflink_id) : NULL;
+
+	/* If caller is operating on deflink, reuse its mconf as primary. */
+	if (!mconf_pri && mlink == &msta->deflink)
+		mconf_pri = mconf;
+
+	if (!mconf_pri) {
+		dev_warn_ratelimited(dev->mt76.dev,
+				     "mt7925: MLD_TLV_LINK skip (no primary mconf) sta=%pM\n",
+			sta->addr);
+		return;
+	}
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MLD, sizeof(*mld));
 	mld = (struct sta_rec_mld *)tlv;
 	memcpy(mld->mac_addr, sta->addr, ETH_ALEN);
+
 	mld->primary_id = cpu_to_le16(msta->deflink.wcid.idx);
 	mld->wlan_id = cpu_to_le16(msta->deflink.wcid.idx);
-	mld->link_num = min_t(u8, hweight16(mvif->valid_links), 2);
 
-	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-		if (cnt == mld->link_num)
-			break;
+	/* Always encode primary link first. */
+	mld->link[cnt].wlan_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->link[cnt++].bss_idx = mconf_pri->mt76.idx;
 
-		mconf = mt792x_vif_to_link(mvif, i);
-		mlink = mt792x_sta_to_link(msta, i);
+	/* Optionally encode the currently-updated secondary link. */
+	if (mlink && mlink != &msta->deflink && mconf) {
+		mld->secondary_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
-
-		if (mlink != &msta->deflink)
-			mld->secondary_id = cpu_to_le16(mlink->wcid.idx);
 	}
+
+	mld->link_num = cnt;
 }
 
 static void
@@ -1969,6 +1986,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	int conn_state;
 
 	mconf = mt792x_vif_to_link(mvif, info->wcid->link_id);
+	mlink = container_of(info->wcid, struct mt792x_link_sta, wcid);
 
 	skb = __mt76_connac_mcu_alloc_sta_req(dev, &mconf->mt76, info->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1979,8 +1997,6 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 				    CONN_STATE_DISCONNECT;
 
 	if (info->enable && info->link_sta) {
-		mlink = container_of(info->wcid, struct mt792x_link_sta, wcid);
-
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      conn_state, info->newly);
@@ -1999,7 +2015,10 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 					    info->state);
 
 		if (info->state != MT76_STA_INFO_STATE_NONE) {
-			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+			mt7925_mcu_sta_mld_tlv(skb, info->vif,
+					       info->link_sta->sta,
+					       mconf, mlink);
+
 			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
 		}
 	}
-- 
2.43.0


