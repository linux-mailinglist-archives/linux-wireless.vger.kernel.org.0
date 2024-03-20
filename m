Return-Path: <linux-wireless+bounces-5023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D58817D1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30C3B20C37
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158E85298;
	Wed, 20 Mar 2024 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NfLzTIlD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AA6AFAE
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962863; cv=none; b=UWyF31tRv6c5cyRoqsxCe3jZT2bB8Bl3gGffQInuDW291HBUIVpDRiwkrZsjvF13/TvqZInMSpBslPZ0SDouEtDUX2gIyKAMWXuVVlejWUc3KClLzxzszy/mg2VfdPSaZPambieyMR4RVlVJToiYPL5IaIEK/hMOrV7wLBNVqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962863; c=relaxed/simple;
	bh=4rEW4zi/OSriPx7/pZUf4Z+7D+YAAOaoVzA71E0tZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1kNS3VyUZlSDytq639Z5mRb2galwnyxRHpaiqxxbKP70V2fllGFjV9sYjJdokTW2gGWqIFNk8CCqmAzTnGxsEYbNkWaY2J5nr4bZAq4Cfi6MGYs9EIaTt0N0yDJhTPzaGa+V9EADITh13XKOetQ53NaBNaV+xFcdvtS+4duVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NfLzTIlD; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC5243030AD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:27:34 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 57A19980061
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:27:27 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id B6B2C13C2B0;
	Wed, 20 Mar 2024 12:27:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B6B2C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1710962845;
	bh=4rEW4zi/OSriPx7/pZUf4Z+7D+YAAOaoVzA71E0tZFc=;
	h=From:To:Cc:Subject:Date:From;
	b=NfLzTIlDfdjGtXr+iShdxNjcuM3D23A7Hu1gRt/9pPa4uZaD6b1/TQkobK1PyDYba
	 xn+NZKCqq+0NN/tO0KU2LdjcynMFkO2Kqs8rLielY1Cr3/2XdVFQOKCmI9ifXf/bg1
	 gdcNdUtTqHOl2Coihhm4F+SZlkLjyd0OqDhQUhkk=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7925:  Fix invalid chandef access.
Date: Wed, 20 Mar 2024 12:27:23 -0700
Message-ID: <20240320192723.3440938-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1710962848-urRY26yyuv4H
X-MDID-O:
 us5;at1;1710962848;urRY26yyuv4H;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

mt76.ctx can be null, and that causes chandef to be null.
Use logic found in similar code paths to use chandef
from the phy object in case ctx is NULL.

With this, my system no longer crashes, but STA will still not
associate.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index bd37cb8d734b..feb818411a25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1502,7 +1502,8 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
+	struct mt76_phy *mphy = mvif->phy->mt76;
+	struct cfg80211_chan_def *chandef = mvif->mt76.ctx ? &mvif->mt76.ctx->def : &mphy->chandef;
 	struct sta_rec_phy *phy;
 	struct tlv *tlv;
 	u8 af = 0, mm = 0;
@@ -1569,7 +1570,8 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
+	struct mt76_phy *mphy = mvif->phy->mt76;
+	struct cfg80211_chan_def *chandef = mvif->mt76.ctx ? &mvif->mt76.ctx->def : &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra_info *ra_info;
 	struct tlv *tlv;
-- 
2.42.0


