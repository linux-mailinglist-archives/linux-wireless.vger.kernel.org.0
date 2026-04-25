Return-Path: <linux-wireless+bounces-35308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAUDAEcb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A696D467929
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D94F8300E250
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B005303C83;
	Sat, 25 Apr 2026 19:51:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E375303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146689; cv=none; b=SbBWhDX1pnmj6GoXereWVTYQxqQ+E6t+zmsJLhShTQmSsWxLS6B9qRsQYbLIGcw5B0koNrJhCR37RHnMb1bnpzwYX9V2ks4l8jbk+oOH76jMtI9lmkIn9SCyVDUbI+ZTkjeWPe/TFAx6Z6kO5mi5FaSJaMLRjNUoEb8Ik8ZQplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146689; c=relaxed/simple;
	bh=c1rNSeL6KriYd3mxqPcgpQ3OntGtoX4pHWSo6zJnRNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQaH2f9vfbJxmwCh1Em/KsIe4suyDmza2v6wslcuOcjIKfL+qDx1uh7qneghU7poWmhTz08k5oIxuCCwsNCoAGBRY1fhzU/vr1Sec1qSe0gJmW/506gPrtsZgGdAkO1K/IMbfUsGsrX3N8exbKgTtZx5BtTUiST7Qd9qeg9+RaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbec19732eso7639574a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146687; x=1777751487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSvcfLBOpoUTWN4tbv5S8Vjt79qJpmtw6Uk94nia/cU=;
        b=QqegaoWEOyntVV6sUlkqR24oV37T+1xC/YGsXAOG8l7BnY8esc7DooqX3z8dSOcGI0
         OeeLQJYoQ4jpTwhQeBHpJgrcHDqrLENp2cryBiotJYJVtR79KLKAKuP9U3Ea0yNCAhFH
         ka47AjjRuF2S3M/BrlffonurQOQ0NNIkHaAyWJuLQZDhj1AKEkCddNAUlZlOVzsNYVB8
         bhmRMDs9PHFmOCTDg3lBUvDsTKK0DhhTyyMMJKtEpJ90fFjXv8LH4tdJ6eCAE4y+q+Sd
         7JrWZYOhmNmH/N3zZLONsKt5U1DPJ0pCPjoOFBAFxxiYOW++pCMCrQcI/YluunUx4Cgh
         Ax3A==
X-Gm-Message-State: AOJu0YzUQ7y+8NVKwR4l9AwO9gaXTqpw82b9fyL2P0iO+UkxZWi2+VLl
	DeAFNVQ9drEP34mVkQHyCAFWsEw0ybef8dOH/zpLwxUgZAPI3w4NohDB
X-Gm-Gg: AeBDievHNp6KaUddSRYXGJbChCxwva8aRou5IXf+dMsxOusBUKbFH2zhW3/jshpisCg
	suNvPISjLaYp31zrWjjk/Gy4a1/GlZVwT8K/RFa8Jpf/u4qiNWTcD3ycAcUD0JXhhMm+ca9gZlU
	kQKAgYZTCGgx//MDOY7xggct453d6MZ2/055niB7TNu7S8Edy+hGaSBBdnPxK4+Bm6a/nctkFZb
	76QzkmzBumPH+V16sWo+gZm99gxZoayq1173NgFs2sXpJT92svPXjaraV2eoHPbkwcqTAOmEStW
	JMrvFIc4VOg/WWjIT/Rap81AcYMw+x30d0Cm+Jyn+0BbZzB95l4E59oYkwsNrfrivIMLfhXWJdB
	MYbNTn6xegINIL0C/B+q8VHMEIgWcrpcgL4POQwod7V+leryLZcXdEDUY94DQo20ss1iotPfLK+
	O2AeKPbPNgCWFYgaTtnMDvhs/6nFyuc5RrXf/qK5pR/O382ssOqYQJ3ndKflKqyfdzAI/081cTK
	bVov3qj6Ndu
X-Received: by 2002:a05:6830:7315:b0:7db:a832:b329 with SMTP id 46e09a7af769-7dc9521f8f4mr22143740a34.21.1777146687361;
        Sat, 25 Apr 2026 12:51:27 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:26 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 11/21] wifi: mt76: mt7925: use link-specific removal for non-MLD STA
Date: Sat, 25 Apr 2026 14:50:01 -0500
Message-ID: <20260425195011.790265-12-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A696D467929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35308-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Use the default link removal path for non-MLD STA instead of the
multi-link flow.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index bf38d6502970..044043a8768d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1338,14 +1338,14 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	unsigned long rem;
 
-	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
-
-	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
-
-	if (ieee80211_vif_is_mld(vif))
+	if (ieee80211_vif_is_mld(vif)) {
+		mt7925_mac_sta_remove_links(dev, vif, sta, msta->valid_links);
 		mt7925_mcu_del_dev(mdev, vif);
+	} else {
+		mt7925_mac_link_sta_remove(mdev, vif, &sta->deflink,
+					   &msta->deflink);
+	}
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		mvif->wep_sta = NULL;
-- 
2.43.0


