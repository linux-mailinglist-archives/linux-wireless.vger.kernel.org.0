Return-Path: <linux-wireless+bounces-29733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE4CBB928
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323FA300797A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9BF3B8D7D;
	Sun, 14 Dec 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy/FOe8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862521B81CA
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765706157; cv=none; b=bqorEUg+QYuNKFvzw+lADeQj854szP+IB8al8LHLydazJeI7uFR6yyQL1yc++gqmlsMX2RiTUbq6fDvhMIh4XneHaVg+G+S14+C8ZggDlYocndKeNJOOURjiXMglAxElW4DVyhbgV19F4zGlLc5Q9ox+Booh93cdTnE7nirRM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765706157; c=relaxed/simple;
	bh=RJIBcQRuLuoNlPhpOTksAxpYrDzA6I7s1hgACVIci7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ggLNCbXVCma4POCte1SQ2R8AgyBTpmJWhxAK8YimQTTg/zpElrKfn2KHadrzyz4KFxIeQSAe68FrYPURhN8GMiwqLngpC3PsCqMOj1TmRM/Yl0ut07rIFFB6pDpACqZTau/VlsECjmCzRhxJ4FxNp0ESr5x9jk0ygJWjmlvi2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy/FOe8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B732C4CEF1;
	Sun, 14 Dec 2025 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765706157;
	bh=RJIBcQRuLuoNlPhpOTksAxpYrDzA6I7s1hgACVIci7g=;
	h=From:Date:Subject:To:Cc:From;
	b=Sy/FOe8iVA6Dzvy1X8G+7jrlk/OkGh8QXuXRFwpM0A/d/XwVRQN4nRO2duwyZgI50
	 USqGlPOQ2Y5ApW+3/sE02QUXs/irJDr99nHe9EsJAbcVUPCwA1ITNy1Xh6dt0/I0CS
	 BOoPo5xb0V4c73Ti2QeVYrGgqFDi2k1EOOYcpehJ843VNWJFsjmh0CL1wu8PqXl3dU
	 RuuVA5pPKjnCj+kYcwC7iHabc9lhVI0KvSNfF2nwOFsxLA9vn9nOUnnSf0k3d7FO/K
	 pEqrwKr7l/C51W2GluJIuuNnJ4GI8OU/DUJ2KCgtPpwxBYnmcMTlqvYowCwLF5/ofI
	 pp9+kmoMy5JmA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 14 Dec 2025 10:55:30 +0100
Subject: [PATCH mt76] wifi: mt76: mt7996: Reset ampdu_state state in case
 of failure in mt7996_tx_check_aggr()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251214-mt7996-aggr-check-fix-v1-1-33a8b62ec0fc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAMBRAf0X32S2bMfMr8sBcc5PRJin5d8vjO
 XXOA5ECU4Q2eyDQxZF3n0DkGdhl8I6Qp8QgC1kJKRRupzamxsG5gHYhu+LMNzalNnWpZjNWClJ
 7BEr6/3b9+36Ms0i6ZwAAAA==
X-Change-ID: 20251214-mt7996-aggr-check-fix-8379634f9b54
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, 
 MeiChia Chiu <meichia.chiu@mediatek.com>
Cc: Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Reset the ampdu_state configured state if ieee80211_start_tx_ba_session
routine fails in mt7996_tx_check_aggr()

Fixes: 98686cd21624c ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89a4bc46e21d796fca80b7decefa5c..b265a96c3e925233d1c410a26315efe56bde73b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1269,8 +1269,9 @@ mt7996_tx_check_aggr(struct ieee80211_link_sta *link_sta,
 	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
-	if (!test_and_set_bit(tid, &wcid->ampdu_state))
-		ieee80211_start_tx_ba_session(link_sta->sta, tid, 0);
+	if (!test_and_set_bit(tid, &wcid->ampdu_state) &&
+	    ieee80211_start_tx_ba_session(link_sta->sta, tid, 0))
+		clear_bit(tid, &wcid->ampdu_state);
 }
 
 static void

---
base-commit: 53d1548612670aa8b5d89745116cc33d9d172863
change-id: 20251214-mt7996-aggr-check-fix-8379634f9b54

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


