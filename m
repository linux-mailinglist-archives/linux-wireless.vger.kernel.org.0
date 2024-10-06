Return-Path: <linux-wireless+bounces-13568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8447991F75
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C22812D7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642F185B57;
	Sun,  6 Oct 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qHwVr69X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB418594C
	for <linux-wireless@vger.kernel.org>; Sun,  6 Oct 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229002; cv=none; b=bPRzJjR8zuuxrxd9caPITq7CDKVWBafHs/rRN9KnLkAAdAoSbtM+ubwP0qRsIMGcT4gMIWkiZT3uzDCnk2kwgWVf+7llkhTNNSdWYM8t8Bj9Ic4G7dyy8zMH6FYfCeySPa4zK5AzhOF7CdsPfIQ/Ujoc7Eg0V6q/9qRJXtP7UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229002; c=relaxed/simple;
	bh=OHkilFt8Cwa8oG8hnNMX+Mih400bRMivwOyR6TopyLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9f59tJoE8Q0iCiDxBbVIA58eDCrwujo0K80Z2Hucn//SQ2tAEtZmSF3k7Pd9+aU59WOqYY6TAvYEeuAFgFY1ZtTB0iB5WQHr5c49r9Idcu8QZiZ3VfyIsR9EDzcHoz3joQPOpjS1uJAU1/x8HJzdt1yFIPS7YzJxJas+rYngWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qHwVr69X; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bM7W6/4TS8smwM1ZizZ2RQHS0QcnPkF6P7Hgz0Iyl5g=; b=qHwVr69XkP0q/gyLDjX1PZOyZ9
	tXTq8rV97udA5KDa832SbHdezvGERqEVM0Ug1TplWmf7ttbkda1eBjurLnewg915iwGgX1pg+4xzX
	m4g7ypC1f194q40I5rknUhIrwnIwhZE8m4H3C7lj4C+mGauXz5uMCzTjIiLoEihLellk=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sxTJ9-005PBA-1X;
	Sun, 06 Oct 2024 17:36:31 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
Date: Sun,  6 Oct 2024 17:36:30 +0200
Message-ID: <20241006153630.87885-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync iterator conditions with ieee80211_iter_keys_rcu.

Fixes: 830af02f24fb ("mac80211: allow driver to iterate keys")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/key.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index eecdd2265eaa..e45b5f56c405 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -987,6 +987,26 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
+static void
+ieee80211_key_iter(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_key *key,
+		   void (*iter)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct ieee80211_key_conf *key,
+				void *data),
+		   void *iter_data)
+{
+	/* skip keys of station in removal process */
+	if (key->sta && key->sta->removed)
+		return;
+	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+		return;
+	iter(hw, vif, key->sta ? &key->sta->sta : NULL,
+	     &key->conf, iter_data);
+}
+
 void ieee80211_iter_keys(struct ieee80211_hw *hw,
 			 struct ieee80211_vif *vif,
 			 void (*iter)(struct ieee80211_hw *hw,
@@ -1005,16 +1025,13 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
-			iter(hw, &sdata->vif,
-			     key->sta ? &key->sta->sta : NULL,
-			     &key->conf, iter_data);
+			ieee80211_key_iter(hw, vif, key, iter, iter_data);
 	} else {
 		list_for_each_entry(sdata, &local->interfaces, list)
 			list_for_each_entry_safe(key, tmp,
 						 &sdata->key_list, list)
-				iter(hw, &sdata->vif,
-				     key->sta ? &key->sta->sta : NULL,
-				     &key->conf, iter_data);
+				ieee80211_key_iter(hw, &sdata->vif, key,
+						   iter, iter_data);
 	}
 }
 EXPORT_SYMBOL(ieee80211_iter_keys);
@@ -1031,17 +1048,8 @@ _ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
 {
 	struct ieee80211_key *key;
 
-	list_for_each_entry_rcu(key, &sdata->key_list, list) {
-		/* skip keys of station in removal process */
-		if (key->sta && key->sta->removed)
-			continue;
-		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
-			continue;
-
-		iter(hw, &sdata->vif,
-		     key->sta ? &key->sta->sta : NULL,
-		     &key->conf, iter_data);
-	}
+	list_for_each_entry_rcu(key, &sdata->key_list, list)
+		ieee80211_key_iter(hw, &sdata->vif, key, iter, iter_data);
 }
 
 void ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
-- 
2.46.0


