Return-Path: <linux-wireless+bounces-34444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM4oFhil1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:32:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 970723AA4E9
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 591FC301CDB3
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC97372B3D;
	Tue,  7 Apr 2026 06:32:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7848335BBB;
	Tue,  7 Apr 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543573; cv=none; b=Po2/2PlHdo9xojcgIYcfFc3XjuTCS/BqHuLzmg1ve6NW3ZyZh5JcjAzQI5sywEAdlYa0BQ9AzPlSuN/KvfiMSRJkFqz5LX3KTFTDKdq31+DYA+AwqP+W/efgSo+IG+M1BIo//QLzHcZqm1BeWOVyfq+KWtjS0MuvIMqGh68suR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543573; c=relaxed/simple;
	bh=S9JA2PmVzXIR2YV/mI/XmMLVmTBKaLDsHs134XHA9aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0I2d20zgiUdZ7c/dSn2SHMZOFeSvYXZOp+JY/SVYGlU6RZ6s7ReCn0UCTACze7xAQPYcaHl8cw/OmXerjV030vRR05AoNqOCf2CejEBdkBCKcQTn+0OeC1+idOl1HHFVY/J4Pah/XfSS1L2F64OmOGgQTTrDsm27iLqj9MhXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 944bfaaa324b11f1aa26b74ffac11d73-20260407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:929cbdee-e623-44b0-b14e-565f096a76f2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:4bffb7716203ced1076bfc7c4bf30350,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 944bfaaa324b11f1aa26b74ffac11d73-20260407
X-User: liujiajia@kylinos.cn
Received: from iris.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 448545083; Tue, 07 Apr 2026 14:32:41 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] wifi: mac80211: remove unused variables in minstrel_ht_alloc_sta
Date: Tue,  7 Apr 2026 14:32:05 +0800
Message-ID: <20260407063205.68471-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34444-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: 970723AA4E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the unused variable max_rates and related code. Also remove the
variable mi and pass type to kzalloc_obj instead.

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 net/mac80211/rc80211_minstrel_ht.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 62745ca00e06..b73ef3adfcc5 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1849,20 +1849,7 @@ minstrel_ht_rate_update(void *priv, struct ieee80211_supported_band *sband,
 static void *
 minstrel_ht_alloc_sta(void *priv, struct ieee80211_sta *sta, gfp_t gfp)
 {
-	struct ieee80211_supported_band *sband;
-	struct minstrel_ht_sta *mi;
-	struct minstrel_priv *mp = priv;
-	struct ieee80211_hw *hw = mp->hw;
-	int max_rates = 0;
-	int i;
-
-	for (i = 0; i < NUM_NL80211_BANDS; i++) {
-		sband = hw->wiphy->bands[i];
-		if (sband && sband->n_bitrates > max_rates)
-			max_rates = sband->n_bitrates;
-	}
-
-	return kzalloc_obj(*mi, gfp);
+	return kzalloc_obj(struct minstrel_ht_sta, gfp);
 }
 
 static void
-- 
2.25.1


