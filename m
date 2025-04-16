Return-Path: <linux-wireless+bounces-21573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45290A8ACB3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59497441053
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8591A264A;
	Wed, 16 Apr 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YGP+Ic+Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4D1A2643
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763306; cv=none; b=W//K0sMXWSQ769R8ij5rIWSH5oJKgMexHhwsuvMUi7lNNQAJd2MsQkKg4wTnUc853187E4RL/p5mLiH6vnflO4ryV7yIYGmwzVWXa6QUYiIpyR6wvLfo1umrdhtrK7RhIWRrWRMLjE0uintR4vfNZ1LG8bNQzeX0TswJwKNI7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763306; c=relaxed/simple;
	bh=YQ/7oX+aIJiQYkZ2sWYWLgEMl5brguO/ZoGI/yA/TkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq1TIE7rskbBWA53fIq08U43I2kHv/uKZppPR4SJuG4qfqMrI0JSqmvVC9CLmKoIzOd4u5pbUrzZBX3v6UKFrC2bOb7dCHhmHLqbkwHKZaugwXVFeC5xmtus/fgdJf2FwYORH/Dmc8QsQlFff7gPJAnAK2Yk6ObOy25/d+TKEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=YGP+Ic+Z; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.239])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1056C600FD;
	Wed, 16 Apr 2025 00:28:22 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6688E1C0068;
	Wed, 16 Apr 2025 00:28:20 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A32DD13C2B4;
	Tue, 15 Apr 2025 17:28:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A32DD13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1744763299;
	bh=YQ/7oX+aIJiQYkZ2sWYWLgEMl5brguO/ZoGI/yA/TkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGP+Ic+ZmQlHcmiXYrvz8cj2L6iEZlDoXFcUx9F+D3knXfs/Runn491tLrMZwB5at
	 5wuBoQa4d2JTzZKOtuREguw7o9Ooz4lW9FpQBEdcgoIGnlYel0+TI4/I31liRtiDGP
	 PtWPNIO8fVZLJZgQIk/pLKOLensPS/xzhigZ06WI=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 4/4] wifi: mt76: mt7996: Allow monitor enable if phy is already running.
Date: Tue, 15 Apr 2025 17:26:17 -0700
Message-ID: <20250416002617.1328286-5-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250416002617.1328286-1-rory@candelatech.com>
References: <20250416002617.1328286-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1744763301-QDgg88ITqcOU
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1744763301;QDgg88ITqcOU;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;

This path was being skipped if, for example, a monitor was created on
a phy which already contained a station.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index cbc9826320a7..16314fdc090c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -478,13 +478,14 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	for (i = 0; i < MT7996_MAX_RADIOS; i++) {
 		struct mt7996_phy *phy = dev->radio_phy[i];
 
-		if (!phy || !(wdev->radio_mask & BIT(i)) ||
-		    test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		if (!phy || !(wdev->radio_mask & BIT(i)))
 			continue;
 
-		err = mt7996_run(phy);
-		if (err)
-			goto out;
+		if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state)) {
+			err = mt7996_run(phy);
+			if (err)
+				goto out;
+		}
 
 		if (vif->type == NL80211_IFTYPE_MONITOR)
 			mt7996_set_monitor(phy, true);
-- 
2.48.1


