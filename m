Return-Path: <linux-wireless+bounces-22287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A02AA589E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1964C645B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 23:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E48228CB0;
	Wed, 30 Apr 2025 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jpKhramq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2352248B3
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055372; cv=none; b=TO5qxeiYloayYzmZtlWSGgHqxqlTehk5LMgz/y7F2op+okmpKgSfLOfSpny8aWnUSIM8lVdcTG73dqhaJFYrVTZpA9UlDBhXgS7LKBHUOJ4rtxrx8NU+5yjdk7U0+2pcQIAZm7ywP1eLurzTRa6tqCl60S9j3QmpkALkXlGuf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055372; c=relaxed/simple;
	bh=p3BfIWqmjgTp6wVfmUqbw6RjNnkxrztxHUwk0suGmbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfHKCwKqoxsmm8DHvL28+LMDKM2sWcji2sIbmR4xmC1XaUJBGrzzPNL4q17gzPFMCfywBOdzwwtwKONIN906XTz0A0bsL5PfNOTrn2UUtdExVPPdWBlRRPHjJeLGTkiW57J+jBbaR2dp2joUBMqS7f8qlNR1lIg90tyf/3A2eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jpKhramq; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.7.65.238])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EB3BF600C6;
	Wed, 30 Apr 2025 23:22:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7455D100090;
	Wed, 30 Apr 2025 23:22:47 +0000 (UTC)
Received: from carkeek.lan (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id CA8C313C2B3;
	Wed, 30 Apr 2025 16:22:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CA8C313C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746055366;
	bh=p3BfIWqmjgTp6wVfmUqbw6RjNnkxrztxHUwk0suGmbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpKhramqfQl2yZZW6zr/ODl2ttNPuzPdB079mxBLyspSOZMpBIOMT23XUmiyrpDwJ
	 9wyzzoinwv99+PJGWpfdTY8j550ybsKUVtVuviYDW3qTZpbM9u6dQV9D7vrJU7/1Sr
	 AOYnHUFc4+UE3s7cPnRIwRlPC1TE2myNCnTXE0zQ=
From: Rory Little <rory@candelatech.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH mt76 v2 4/4] wifi: mt76: mt7996: Allow monitor enable if phy is already running.
Date: Wed, 30 Apr 2025 16:22:25 -0700
Message-ID: <20250430232225.3943242-5-rory@candelatech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430232225.3943242-1-rory@candelatech.com>
References: <20250430232225.3943242-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1746055368-Oc3tXFDE95bq
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1746055368;Oc3tXFDE95bq;<rory@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
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
2.45.2


