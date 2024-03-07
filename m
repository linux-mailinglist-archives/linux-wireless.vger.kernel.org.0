Return-Path: <linux-wireless+bounces-4467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673D875726
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDF9B20ECD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA21AACA;
	Thu,  7 Mar 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Tqc3RJMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74E13473E
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839803; cv=none; b=WDkB59vQgkZVqDEEfyRJ570TDsurMjNwf4zUgh/oPgAwOy95F9ysQbhKhTgKIMff3VynnNRKMUslMla2CASz3Q/yV85fww9YcOn9A3wAxLTgjfFPuLIh1yj/UROGYk0JZL2Pxm3KP/GS52nHBY7kuuMM+0DhSx/3Z0OUJH05mKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839803; c=relaxed/simple;
	bh=licXwMZE9nQRR1VJBrVvcUMfdfPScXi/Vz1g26dmJEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noFZaoOEQ4nbmsWIVmk5RcHTcfv4lelBc1zM+xOmFHvpSrCO16nI92kAcNm2Ev1J8oMSG8/wc60YKdBVDkrZ91SQOYpscgMDMf1x4wSRSY4+thP4BD1fdlITYwnBS25hO/62PgPlZUQzsig0PdVOlIyBqYcjg+F19Ega4EwsmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Tqc3RJMJ; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5D2C82C006E
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 19:29:59 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id BFD5D13C2B3;
	Thu,  7 Mar 2024 11:29:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BFD5D13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709839798;
	bh=licXwMZE9nQRR1VJBrVvcUMfdfPScXi/Vz1g26dmJEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqc3RJMJtNGcThi9Zm0mRh5vbLJU/MCXx5jgEMKn+VMYnE2iY7DHOcOBYi8EnIywU
	 V3z0oQC4MeebkHbHj7OGltJC2ynJQFCIoXRvu3mLD9SbjNfRItsR3xUSyaRog8nwow
	 vGC4PI+zaTXJ5CpIXz8v50EYvZ/mFyDBVi2fYpJM=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 3/6] wifi: mt76: mt7996: Enable spectrum management hw flag.
Date: Thu,  7 Mar 2024 11:29:48 -0800
Message-ID: <20240307192951.3271156-3-greearb@candelatech.com>
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
X-MDID: 1709839800-mwwquWsOLHsO
X-MDID-O:
 us5;at1;1709839800;mwwquWsOLHsO;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

This hardware does appear to support changing txpower dynamically.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d3b72fb73c30..494679a412cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -402,6 +402,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, SPECTRUM_MGMT);
 
 	hw->max_tx_fragments = 4;
 
-- 
2.42.0


