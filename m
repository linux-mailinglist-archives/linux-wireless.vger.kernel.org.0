Return-Path: <linux-wireless+bounces-32675-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKaPNqpiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32675-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45846228A97
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5C331314CF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAFB372688;
	Fri,  6 Mar 2026 23:23:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02114371CED
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839420; cv=none; b=bOahWkqSqNw4WqhVlqtq/XdTlHvjKJkk1QIfAjjulKwxGzt4nukgDgH3abvsvrHHLOE6fZC0tGVvDML7Xze9Qvk2I51SH5UgNamqaMFXotVihhA/AM/iZ1HrMHQX162gRs+S55kh1us84q7jcg7qo7hJwKqUpaYODJqXIRoMlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839420; c=relaxed/simple;
	bh=SGs6baMrRPjFjdMsoEvMqniUvqFQTN9NL/bl30gN8pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZdJ0sx3mrqWdzGUlBGPYZij/aKwRrQuNsRbRcv5vgHiHjqG0EbOqC6NIOy8CpcSQ06DEJXwv5XtVHUcgz0hHIawAd6fb3mxBoOb3GdpHbVJFIKJdm8B42YYkzwom8DWSk5gBHbQkQJDjc6UZGwaB1KvTfM+a8aChU+4XJCQxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f387a688dso3803394fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839418; x=1773444218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DslI7VCh2ZTzU44H04itgeCGzsVbCkcEoyyw7QbL7rY=;
        b=M7sJGAw9Nao3qbWdfWENYgmd66teWYCheRrll2WoUOvd0AtTXuS7VjIH1LgSxMTiNs
         xydgvU5/Jb3oLuu/Xy91fwyOcXSPmrOEVnO3Xyz2YI2eE0+99bqH235SFm4JLEEHjKSP
         RHdclobEkhHoF9F80J/ITxn0JhsM5ld/0Om4Xd/EWLWddJQ5Q5QvYJpTSca9+0lDlZLD
         AfqbyWi6Lo8eSysmXuraO+LSSR6DZjzcEEcqlG2gLKFsWxqauSrNqon3VsQCi6IfFKKp
         wST0bDc4ENXYRojgYaPKiXqSE75kvUDM5bKl2B3/tEACojvw06oWqC7gzD7G94UPLKbT
         SggQ==
X-Gm-Message-State: AOJu0YwbEFP1glwb2b6w5oO0aXZxQAF2QG57hxnB9XjSlZXBtFEzJW/0
	s2LHmJ0t/gaYZ5Ew5CeSTstqSZ6KE2TNDnO5HYB3TANV8T0Uzo1BZrDR
X-Gm-Gg: ATEYQzwBC8730ZdUuF8mDqxqNjIX+RiSxAbcU4PJ9jkFq1tzWJhqMxINfehk2E4lQ4u
	poeGUG+4iZ4cKDjicap85sO5S1CNen/1cG1grHZ6P46WPIwAmSsrfUJXPhqmWMfy1/7sGld9RCg
	fcAS6GwLOSXE9EJrn7gTSetonwPAJMaaWUhBXX+uoWlK7ZXult5dqRMBJJ5sfF6Ii4EnVr972rz
	MDHlQ+L44U+PMUVqSFGLsDrvyhAAVNv0jEXnUPhVQlTnwPDsrbDckwwsmHIzvzFkWJ/vn264U5l
	EPu62oZ69iby2DEfK+LZXHg5DLSiIpJOhjXTS1IyFHlv4RJBPhjq8JIesEZTmGH4B5pbuUkppYB
	inOM/gxZ9S9w1Wp1u6QzL1ZWfWcJ3JJByvF/U0EbBQPw+s3P/OyuqLb5G4tcxguihj47jxWliav
	a3fwisemOm28CEzPoDt4LM5gpB5cmXv045TUSkoB2b3PBDgSE=
X-Received: by 2002:a05:6870:8094:b0:3ec:7649:f843 with SMTP id 586e51a60fabf-416e418f90bmr2210355fac.38.1772839417947;
        Fri, 06 Mar 2026 15:23:37 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:37 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 10/19] wifi: mt76: mt7925: pass mlink to set_link_key()
Date: Fri,  6 Mar 2026 17:22:29 -0600
Message-ID: <20260306232238.2039675-11-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 45846228A97
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
	TAGGED_FROM(0.00)[bounces-32675-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.408];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_set_link_key() and pass
the resolved mlink from the caller instead. The link context is already
known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes link ownership explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f5dd91dacca5..68f168a093f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -594,7 +594,8 @@ static int mt7925_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			       struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-			       struct ieee80211_key_conf *key, int link_id)
+			       struct ieee80211_key_conf *key, int link_id,
+			       struct mt792x_link_sta *mlink)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
@@ -603,7 +604,6 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_link_sta *link_sta;
 	int idx = key->keyidx, err = 0;
-	struct mt792x_link_sta *mlink;
 	struct mt792x_bss_conf *mconf;
 	struct mt76_wcid *wcid;
 	u8 *wcid_keyidx;
@@ -611,7 +611,6 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
-	mlink = mt792x_sta_to_link(msta, link_id);
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -679,6 +678,7 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
+	struct mt792x_link_sta *mlink;
 	int err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
@@ -700,12 +700,16 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		add = key->link_id != -1 ? BIT(key->link_id) : msta->valid_links;
 
 		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
-			err = mt7925_set_link_key(hw, cmd, vif, sta, key, link_id);
+			mlink = mt792x_sta_to_link(msta, link_id);
+			err = mt7925_set_link_key(hw, cmd, vif, sta, key, link_id,
+						  mlink);
 			if (err < 0)
 				break;
 		}
 	} else {
-		err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+		mlink = mt792x_sta_to_link(msta, vif->bss_conf.link_id);
+		err = mt7925_set_link_key(hw, cmd, vif, sta, key,
+					  vif->bss_conf.link_id, mlink);
 	}
 
 	mt792x_mutex_release(dev);
-- 
2.43.0


