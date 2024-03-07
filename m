Return-Path: <linux-wireless+bounces-4469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BAE875727
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CAD281FA0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DA13666D;
	Thu,  7 Mar 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="SanJ2b7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7C13665B
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839803; cv=none; b=sjEURe6xX514jWIA7pdin4VCnCiOzS/JYHVFpiI0pTtHIpxA2R9a1zpH4XYamctBRR+m2822y3RY5Fo/qL+AMu+Uqk3oPsBK93dN1e8IeEYZQomcGyLbJ2hTPd8PSFDOO4iqZJyoVpItMWb1XnXeix0XUUZy+Un3QplB6+EPcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839803; c=relaxed/simple;
	bh=XUPe1YQt2j9RE4yyNTjIiGbnZhOmDr5YvmBxrNxCxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKPuyrsbAmzSmW1wO/CpGK3ULr2NkhpDc+n0cycRFTjbRO9svahwGl7OjhEUtWAevm1bvhBUHv3ThHL4FwctzKqATAirW+zlXU8aYqhqmGbTXrWio1ct43CgWOylJcwO1Fw9lw4HIBPcd3dcrXf2lpfYEPvFm415wJxHHb2xtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=SanJ2b7e; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8787E50006C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:59 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 230D813C2B0;
	Thu,  7 Mar 2024 11:29:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 230D813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839799;
	bh=XUPe1YQt2j9RE4yyNTjIiGbnZhOmDr5YvmBxrNxCxbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SanJ2b7eHKkIh1eQpOQqpTgOH+t0LQgdvglcepr7elTNYMDLZb4a0YcsyBmI/oj83
	 ZBim/a9C/5Nn6Ynftg479lR09XZwULVZbOwFLBPh3crH5vRb7v5eetzUGkwFKcLRTs
	 eszgL84Aq/RODJU+diXi71Zq8ehVeITOAspXTXb4=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 5/6] wifi: mt76: mt7996: Mitigate mcu communication loss.
Date: Thu,  7 Mar 2024 11:29:50 -0800
Message-ID: <20240307192951.3271156-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240307192951.3271156-1-greearb@candelatech.com>
References: <20240307192951.3271156-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709839800-e4EruPvFvAfv
X-MDID-O:
 us5;ut7;1709839800;e4EruPvFvAfv;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Many calls that end up sending mcu messages to the firmware hold
RTNL or other important locks.  So when radio stops answering,
the entire system becomes very sluggish.

Add timeout counter, and if radio times out 3 times in a row,
consider it dead and no longer attempt to talk to it.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 5550671cdaf6..77c89d2d2423 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -202,14 +202,16 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (!skb) {
 		const char *first = "Secondary";
 
+		mdev->mcu_timeouts++;
 		if (!mdev->first_failed_mcu_cmd)
 			first = "Initial";
 
 		dev_err(mdev->dev,
-			"MCU: %s Failure: Message %08x (cid %lx ext_cid: %lx seq %d) timeout.  Last successful cmd: 0x%x\n",
+			"MCU: %s Failure: Message %08x (cid %lx ext_cid: %lx seq %d) timeout (%d/%d).  Last successful cmd: 0x%x\n",
 			first,
 			cmd, FIELD_GET(__MCU_CMD_FIELD_ID, cmd),
 			FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd), seq,
+			mdev->mcu_timeouts, MAX_MCU_TIMEOUTS,
 			mdev->last_successful_mcu_cmd);
 
 		if (!mdev->first_failed_mcu_cmd)
@@ -217,6 +219,7 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		return -ETIMEDOUT;
 	}
 
+	mdev->mcu_timeouts = 0;
 	mdev->last_successful_mcu_cmd = cmd;
 
 	if (mdev->first_failed_mcu_cmd) {
-- 
2.42.0


