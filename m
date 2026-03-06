Return-Path: <linux-wireless+bounces-32683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBnEItRiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E638B228ABC
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95103155A75
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A535E950;
	Fri,  6 Mar 2026 23:23:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80560372B5A
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839438; cv=none; b=jHXom7bCmNa5uIoPG1IvIKzMV4j4ilrWyKuZ/eLkQ9dsrP8Aiv3/261hOlSchmFVxDluw/73D9UtDx8/wV98ssXdaWg7VJ7xjbtCM6pLFH1JtdWH3mx8yZ6dnytIHm/q/4SDuyDbiAIoo816LvghP9bTDWSgUSQ8lJrQnMyTvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839438; c=relaxed/simple;
	bh=5Xs1INnEYC7gDfWPWZz0z3vR/hupicJohMbcworHzeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppHEAu0em8r/ft0OZV8+Qm5CpPsxqno4H+6nPUyqcxk1zEcacDUXd85Kh2lqDEJF+9zWInEFwyae7nQKqoD4/ISlzka4S+scG5tc4hqMcOttQ/rRI+bPwjqGFrlEXxCKc53BwMMsGhmmk8aREpD//8fehOU0XrO4xN/pFxp5Trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4ba9abbecso11563562a34.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839436; x=1773444236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqkwc4qahyVC1i4Brqm30Kr/xENgHWOOasft1YJy04E=;
        b=RKlRxhCg83ceKIQ2vpEIfxRMsNU0ULOuur+8m5jigmiED0cGCN8vnGO/oQgckX6+U2
         3qbRXbaWC5AQ5+D/01rIUWRdDdm2dA5H747Bk+Gebo7akXo+W/MV6TPPJoq0WNvE6vUb
         KR4TCvj//XCEFahNYdXhnqkPzU43d2xJwsv9i/Vbn2/H4XX8KNg3pj9e5riLNNZj3DRb
         TAHVOFYgKSELOHDLKJ6o39nup6sGh/dqQljOn2amRDL2J4kb7rFWjPmmFrrF02WWshY9
         kImptbF8AZxazABkY6VfFcWzvDAXOvCVd5gCJ1qU0IHuOZS9x8KhrSjd+4IGrnKF83JK
         gMfw==
X-Gm-Message-State: AOJu0YyQQW62QGAxsXTbjEOYWTeRxbIec8VL4tA6F7Vd++ljdNEjaClI
	Svw96rcCR+yX8wQH0JIkyfHOt2rjo25LsdGNVTCa/oM/w4yA9HXDM4OV
X-Gm-Gg: ATEYQzxBDqHa9o2orsBZTnRJl4UEQQKppIRbeZ5d6zC4OC6bRWHlD0b6j3XKNDBS5HA
	Y4YmdIQr8LiGuAA/gmvG6ykOq52GPF01pX9mRaCdga4Y56Q2r9zMnhgH4bEcpsRT0MaYAsdND9z
	G5Gzo0Q4FtueqJzoEpvsNAvOxyMKo93bTBBr0yyquTBPIRXaPkhLcxt3ePID+CFDwJMRR9JTanW
	5mGy8ovPWzRiutXU6OLK3hjgfPN69mZevFBrhrhRC7IcGWFU2A3XZ8u+fGPib8/vHpF7yVpvyX/
	NnGzTX6WVAq7A9CaVm1M4ep2UoPLjjKsjL+3rAB7B/yukgIMlWRz7Ow1K3q3Sluj0GLmUiga67M
	G220fq4zuAS1PrWdwjI2PUQnhaKjc3vCZH1AjluPEPz4yaRdnoDPeqFObhjdGtQciht6fua+2QA
	saMFxaYZjL+kzht8oiPxwQ9nWkKPxScPXrXj97bSy+sCPthsrJbUdJkogVBg==
X-Received: by 2002:a05:6820:488e:b0:679:f16a:6228 with SMTP id 006d021491bc7-67b9bca200bmr2063257eaf.27.1772839436606;
        Fri, 06 Mar 2026 15:23:56 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:56 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 18/19] wifi: mt76: mt7925: publish msta->link after successful link add
Date: Fri,  6 Mar 2026 17:22:37 -0600
Message-ID: <20260306232238.2039675-19-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: E638B228ABC
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
	TAGGED_FROM(0.00)[bounces-32683-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.400];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Move the msta->link[link_id] publication until after
mt7925_mac_link_sta_add() succeeds.

msta->link[] is RCU-visible, so publishing it before setup completes can
expose a link whose add path later fails. Publish it only after success
to avoid partially initialized link state becoming visible.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index eb16c4683100..95c631b57894 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1000,10 +1000,11 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta;
 		struct mt792x_link_sta *mlink;
+		bool is_deflink = false;
 
 		if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
 			mlink = &msta->deflink;
-			msta->deflink_id = link_id;
+			is_deflink = true;
 		} else {
 			mlink = kzalloc(sizeof(*mlink), GFP_KERNEL);
 			if (!mlink) {
@@ -1012,14 +1013,23 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			}
 		}
 
-		msta->valid_links |= BIT(link_id);
-		rcu_assign_pointer(msta->link[link_id], mlink);
 		mlink->sta = msta;
 		mlink->pri_link = &sta->deflink;
 		mlink->wcid.def_wcid = &msta->deflink.wcid;
 
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
-		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta, mlink);
+		err = mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta, mlink);
+		if (err) {
+			if (!is_deflink)
+				kfree_rcu(mlink, rcu_head);
+			break;
+		}
+
+		if (is_deflink)
+			msta->deflink_id = link_id;
+
+		rcu_assign_pointer(msta->link[link_id], mlink);
+		msta->valid_links |= BIT(link_id);
 	}
 
 	return err;
-- 
2.43.0


