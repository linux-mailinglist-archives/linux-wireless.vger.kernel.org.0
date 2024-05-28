Return-Path: <linux-wireless+bounces-8196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF918D1B0D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A074282A77
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB616D4CD;
	Tue, 28 May 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bwYp5VRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0F16D339;
	Tue, 28 May 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898998; cv=none; b=Xx6z9tdO2kdmMphcZWBRme1t2V3tl9roJBktrSlcudSQ7lTL02TG/D834aGAi7ASCKRXrgd9gOUxD7Fjhfp49gKWBk1T8LdRTDOcUfftuQ5/cXi2Qkqx/Vsd8fek3NBMCUuYQ+ycRA0GPwGpzDXd2RR7T47GMYToHvoYR+vtBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898998; c=relaxed/simple;
	bh=cQ6Qrc1UrA6yGCDaPEj4S8O0KCoDno1Q9QWp7KWRxa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBiIlZiB9DrU/aVTBhUXChGUO90TdlimPO+ilYEroilTv5dmuagtAOXg9mtMGZEzH5XXVGp1Rny3CJNte0UDC0SbP0IMqk75w4qq6ziF8oYw2ZQ4MSZ0+68hesXc3u1H+isXsWAEzvyDqTGTASOOvRI8UN0iVc9KTW47XjW+/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bwYp5VRb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vAuihrMR8efQHaSilDuRiX8Jb3WFGKrSCFQWlFc77iI=; t=1716898996; x=1718108596; 
	b=bwYp5VRbwY2rX9R70MlO4LA4RQhxY5KMc1kpLQWvKPuA7SEuuw2gYGOpTBPa7IDZbRhym1C8975
	XnYFerbM4HhZYJs4cWacwdt2gJkb9U08Q22HnoxkEo25mFen00vFzskaAkhTGRwI6MEZMn+97Qf6/
	2e0l6M1QEtHxTkPtgCqiLti5r91L6sz/gm3jFmg5I5F0vq8+FYnHGan1LLyGR/QQP/XBkZLGSRYv4
	KDIuyLOtoxeFcBMKVeGJMVB4XXMrW5HDqwrucT2dtX09mz/l5QVMqsCvQU1buGnywlvi5rx6CC3NH
	05siga0gMq71j3NWlrJAjElnUvrtExAosCZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBvrE-0000000EMcC-3zZa;
	Tue, 28 May 2024 14:23:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Rene Petersen <renepetersen@posteo.de>
Subject: [PATCH wireless] wifi: mt76: mt7615: add missing chanctx ops
Date: Tue, 28 May 2024 14:23:08 +0200
Message-ID: <20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Here's another one I missed during the initial conversion,
fix that.

Cc: stable@vger.kernel.org
Reported-by: Rene Petersen <renepetersen@posteo.de>
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218895
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 0971c164b57e..c27acaf0eb1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1326,6 +1326,10 @@ static void mt7615_set_rekey_data(struct ieee80211_hw *hw,
 #endif /* CONFIG_PM */
 
 const struct ieee80211_ops mt7615_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7615_tx,
 	.start = mt7615_start,
 	.stop = mt7615_stop,
-- 
2.45.1


