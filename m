Return-Path: <linux-wireless+bounces-13869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB299993CA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 22:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF51C23195
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742841DFD84;
	Thu, 10 Oct 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="E8Gd22fZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1D1D041A
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592758; cv=none; b=jhqsnXUE08uDzyTdl3jFLjB96VyErvDNuCxiaEp9AbForn4JWBymfUuXyvNo5zNcW+J//K8FFCuMehK3sMtm3YOrFgzASGg+aO7mk4AFyQDQ5i2y1njcbv0kwOvahXw9XHopse/YIvuWiIxT51dcQZb5g8nKE6EJhY5MocLbGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592758; c=relaxed/simple;
	bh=dni0lOJNFdwll3Wbd8/FDTewqKzktAAzBRFzjqHU6Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ddhu/OLzsIKMqDdzNaFug43yIp5qqEKohvBj8t9QS8a9bU12cTh6VR81cmCBrQqQi4h+rEPtWCABLGbOZGaPBzhRxa/uDEmjf6MJbeCCHDjVz1X9jBsJBsO4a04gFVPhT1MJHvq9cqyFy0hI046XwqvqXLOV7pBR+aQUriYTZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=E8Gd22fZ; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 709DC40006C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:39:14 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 202D513C2B0;
	Thu, 10 Oct 2024 13:39:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 202D513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728592753;
	bh=dni0lOJNFdwll3Wbd8/FDTewqKzktAAzBRFzjqHU6Ds=;
	h=From:To:Cc:Subject:Date:From;
	b=E8Gd22fZnQGUqh6xcHsHllPQXmprkna5CdDw9JI4tFqCuEZQLEu1usv9C3MgFY/8S
	 5QK5Z9Pa122/1goJY8tMiFyXxXd7+piRW3e+EATWPXv63M/Q+XA8tIEQ31/Dfn+4hG
	 ajHHVTowwMvPFytq+ERfHjf6PwKvi5p1L5cqVCTU=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7996:  Apply power change in bss_info_changed
Date: Thu, 10 Oct 2024 13:39:07 -0700
Message-ID: <20241010203907.1219448-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728592755-91irK2fZes9T
X-MDID-O:
 us5;ut7;1728592755;91irK2fZes9T;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

Re-calculate txpower if bss_info_changed flags it as needing
to be changed.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

I found this while looking at other txpower issues.  This didn't
actually fix the problem I found, possibly it is not needed?

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 92aea65a8be8..cf15ffa7a3de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -797,6 +797,9 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		mt7996_update_mu_group(hw, vif, info);
 
+	if (changed & BSS_CHANGED_TXPOWER)
+		mt7996_mcu_set_txpower_sku(phy);
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-- 
2.42.0


