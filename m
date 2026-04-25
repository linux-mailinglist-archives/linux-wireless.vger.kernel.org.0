Return-Path: <linux-wireless+bounces-35290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLWdLPfT7GnHcwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 16:47:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050A466A36
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30F1300B476
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC002BB1D;
	Sat, 25 Apr 2026 14:47:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434414F70
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777128436; cv=none; b=nZtP/ZvgN0RgGJLa7G3UatSZKvnxPdwZiN4OE+B+cXL1Ni5okUkFZABvK3dz1hkot6gn3/vsWUvs04gIrApJAbOT6zlY1xUAf5TD6J0SyfvZOwES6eGfTtiKgCiuGNKzEbRPTjlxbUUH1Hebc14h8lAO94UqHHcpfO1uhnyUcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777128436; c=relaxed/simple;
	bh=WIY7teZHD6U2Bnl950UDDODyT55ZP95426d6rWjUKbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fg4NBrtKe5r7mzGWQBl0f50QzF4x7tD+Gj/mG87xPgw6jpKkjihyz1QP1nep6eQTNZWSdEMKsMDnSERpTQzjN4RTIeUBtDXyYs63HlDkGIVYhVFAGpeN3cWv1WULqtY6sdQluaxLtO7rj6RA6JeS3hg5DVuvu0zwPPNM4CQ+33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dd73b7c757so2164370a34.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 07:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777128433; x=1777733233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlJascMYcEVmDvEn/UdsWocmJsfAuvfdDTt2p2Jdu2g=;
        b=EBHq1FhPcvyesLT3eA0JF6+1wJfOv8eQxBW3CZNLmhy5mrNVEAaoVAmQ50GVEkrsjk
         7Ma+j/zmg0JSkCQTohVnHQCQSWu3rDYYKmg1MhFgHASl3keFE+GJWp39VGuJndP0AcMg
         2BmS1+872+r1UZGPrfj0agBEILFBR+fw7GDkDTE2BbOkQkKV7Z107L7sG+SO0Ned3Yc2
         BhhzUvkeoymyqb7piUiWa7099tMZdTxg285JVO30KH/tauhU6u7SQlUxdWhOpQezX/el
         U0ThNgzbb1IaFqOf823SDSsSdedW0BkmeQ7PGaxT0YzkrM4GXZiIIz6NuJbym2dqewNe
         j+5Q==
X-Gm-Message-State: AOJu0YwPQetKunmzAIXeRoz6yb8OHIY+HiMEo8PvZWmTA/hPW41e7Oew
	qhwmH8fnlteApVRLxGHN1Y3fXqdIC6s92yu4jR9S5X7WV/MU1gcv5JDV
X-Gm-Gg: AeBDies+cudK+nLEAfKtG3SKNYixIYmtuu6cIX82LJ6JJa8dfH4xRLuPR2vQQkoc1ZB
	jSne4mYeorO9sVAFJemtawb4XsSICa8hWIXWkc7ivInogTMPfqU7i0qZf6eDtvQvXDEuhh3dvtr
	Qt/tL49rn5vPSu3rN7nHyx0wu3RWTtHRTPaYj2ymKSvh0V0LKpe+9t+a8lvgmIzD9upfQhlN25Y
	r7EYiMjLjO981lQ92znAJLTUbRfCks1S53V2BoDlBD4dPKn4xYOLwigs7RSMUImxjx9+5M1lT9q
	ofDgXqgf+ThqMpnsj166beH1OCRMBnN0mRFGbw0VFlnI56H74Fb5HqhfMkBXMkYYBT75nDSf+sj
	ul4pVF/VGWRe4MnG1bEt6yYTw5gsOgxG8Sbp97BETmLOnvWKOobDYydcWL5dPcDfF/7D8TX3SLh
	TixSvCspfv7Q3tWv1GBxpJzow+e6au9elCjHwxH1L3vgKYk1kH4ziWi+Qa1R5C4pMv3Zf1cP1s5
	pFX/A90IxXu
X-Received: by 2002:a05:6830:388c:b0:7dc:d3fb:5a34 with SMTP id 46e09a7af769-7dcd3fb5b2cmr13907048a34.10.1777128433452;
        Sat, 25 Apr 2026 07:47:13 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:9f96:11d3:5f6c:5582])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm12577480a34.11.2026.04.25.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 07:47:13 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt792x: skip MLD header rewrite for 802.3 encap TX
Date: Sat, 25 Apr 2026 09:46:48 -0500
Message-ID: <20260425144648.734030-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1050A466A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35290-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

mt792x_tx() rewrites addr1/addr2/addr3 by treating skb->data as
an 802.11 header for MLD traffic.

That is only valid for native 802.11 frames. Direct 802.3 TX can also
reach this path with IEEE80211_TX_CTL_HW_80211_ENCAP set, where
skb->data is not an 802.11 header.

Skip the MLD header rewrite for HW-encap packets to avoid corrupting
802.3 frame contents.

Fixes: ebb1406813c6 ("wifi: mt76: mt7925: add link handling to txwi")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..157e48e33412 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -105,7 +105,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		wcid = &mvif->sta.deflink.wcid;
 	}
 
-	if (vif && control->sta && ieee80211_vif_is_mld(vif)) {
+	if (vif && control->sta && ieee80211_vif_is_mld(vif) &&
+	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		struct ieee80211_link_sta *link_sta;
 		struct ieee80211_bss_conf *conf;

base-commit: e8c819df02436f2c2379766946735e1f06a7c923
-- 
2.43.0


