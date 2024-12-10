Return-Path: <linux-wireless+bounces-16204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CA9EBF3E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 00:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE68D2847CD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883D1F1937;
	Tue, 10 Dec 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="UzPgXs3M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910786324
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873160; cv=none; b=KNyPaxbw7lG9AKM7nJoRmCAEvnISELakTjRt3OH4mddcpxboJA8XxgVWV0tNphEv0mQVp2d1Wb4YItVfIhZGjVzD024bnPIp4MhbSCXTZlFluuAIcGycfo3QXrH860CD/Y6DYi02trUwxxvqZ6Lf463YHXbxfOZ3Uu1k2bymlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873160; c=relaxed/simple;
	bh=nymeM55oZwa4p0SXEYro7YSRYwZdMN+I+0M32HrtO8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxvaIwEZJ3jyuRYMlbIhgPBBzWAHqGjJfLid7CiFpmYwKm6+vIwIrMlVozoxx8oqJUcvIWE9KSSuNYb9SrLHxS07Jdb1SE9MFxNWJwDNciqx2o4PuvaNDR4mNS8+mMNyqUA6uAdpMeHq5pghzJ4OKokX8zYZrkMLsOzanrODr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=UzPgXs3M; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2046DC4005D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 23:25:56 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id ADD3D13C2B1;
	Tue, 10 Dec 2024 15:25:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ADD3D13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733873155;
	bh=nymeM55oZwa4p0SXEYro7YSRYwZdMN+I+0M32HrtO8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzPgXs3MxpxxZp6/ZOY8g+GE7Axqio4r8EOrA8ogNTRnTm0vFmMygKoIaUgfxLHpC
	 w7M765Hbih61aZEyc2Dj71b5v0Cjlrh+ocAxIoGzOcfvR1y9IE4V6FKEFlUa/98vZd
	 gMo49WpYDrrMSRCYjesFRWF7W4TIVLo1wcqDSXWs=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 2/2] wifi: iwlwifi: Report link-id for transmitted frames.
Date: Tue, 10 Dec 2024 15:25:40 -0800
Message-ID: <20241210232540.183582-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241210232540.183582-1-greearb@candelatech.com>
References: <20241210232540.183582-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1733873156-mHdLXc7OXNPF
X-MDID-O:
 us5;ut7;1733873156;mHdLXc7OXNPF;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

This will let upper stack properly record stats per link.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v4:  Reorder patches, use new status tx_link_id field to report what
link transmitted the frame.

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c9867d26361b..c8b5d5cd3298 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1709,6 +1709,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	u8 lq_color;
 	u16 next_reclaimed, seq_ctl;
 	bool is_ndp = false;
+	struct ieee80211_link_sta *link_sta;
+	int link_sta_id = -1;
+
+	rcu_read_lock();
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+	if (link_sta)
+		link_sta_id = link_sta->link_id;
+	rcu_read_unlock();
 
 	__skb_queue_head_init(&skbs);
 
@@ -1732,6 +1740,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		memset(&info->status, 0, sizeof(info->status));
 		info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+		info->status.tx_link_id = link_sta_id + 1;
 
 		/* inform mac80211 about what happened with the frame */
 		switch (status & TX_STATUS_MSK) {
@@ -2048,6 +2057,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct sk_buff *skb;
 	int freed;
+	struct ieee80211_link_sta *link_sta;
 
 	if (WARN_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations ||
 		      tid > IWL_MAX_TID_COUNT,
@@ -2064,6 +2074,8 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 		return;
 	}
 
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
+
 	__skb_queue_head_init(&reclaimed_skbs);
 
 	/*
@@ -2087,6 +2099,9 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_ACK;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
+
+		if (link_sta)
+			info->status.tx_link_id = link_sta->link_id + 1;
 	}
 
 	/*
-- 
2.42.0


