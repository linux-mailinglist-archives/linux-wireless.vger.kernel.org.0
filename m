Return-Path: <linux-wireless+bounces-2697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700A18412CD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E821C24F3B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F8482C1;
	Mon, 29 Jan 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LLoN5ZwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140614AAA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554481; cv=none; b=MOqBAVeMfpgwxiMp2nQA/P4u20FKhAhbM9VSPwp10clJdtqb1PeO8jDO6Fi7ZZ9okBh/LX7Gc64Fyn+eXwIhv8kHD6iMiR8lXO1J5O3f2gWmOPS3R2gWtK60Uuj/gl7dsgfX/DIfFFKTOiB/dB6VMtGGL4fLDyxpldL99q+ITR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554481; c=relaxed/simple;
	bh=rgBcZVoiIsjEY8WtVNwrSoEyjvm83AsS4QGRWgC/AJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs2wes6/hpDMUqynDwR7EyH9fYr0dHZvottIJjdcNZomLA6xcGe8obrC8xtZslYe4DpS9Sb211b2Mem9W7/mZCmxJHfi14Agg/DO3NJEO1RRfGhQ1Q1K2MaW3czjJQRbQXU6CJ4lu6Ba/5/FWEF3la+ZeWe7sC7B2/bolR7P2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LLoN5ZwB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=37o3qylp52nTac3iOIHQRZ32l/7H9m6JnA2e2jY+kTE=; t=1706554479; x=1707764079; 
	b=LLoN5ZwBC4aBrGRxokqeR8BlX+JIR3xv2Mhc28+2dc8v0Sx1U8gu8oKbPUbn9yJjMs986ZXqkw/
	1PEyIMvjCXG9blWxMIp9A8wS3tFtLBsQ5e5HZP/nqZ0NRxkpWW524c+PB6hfHzxteepNK6i5TeODz
	XBx+E4Kx+EEyOt6fW9FFITR2lwAXIBFkMvdTjYZFlJ2YxBh+UdjeoHGYr9TyHd0F1ik1vHayBIpo1
	Q5xiIKYP5BYdKHLvmJktYWMasZ0VTECCG5gheABijzH7hdxVDMgryNPkr7SFNNJvF3pN0VqYR4wIx
	TDQpKEZSLSB5KCxaFDk+gUZgQ4SjZ9FD/qdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWmD-00000004ziR-0ezo;
	Mon, 29 Jan 2024 19:54:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: trace SMPS requests from driver
Date: Mon, 29 Jan 2024 19:54:35 +0100
Message-ID: <20240129195435.b20d2ead2013.I8213e65c274451d523a3397519ac578c3ed2df4d@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Even if there are a lot of possible ways drivers might
call this, at least knowing when they do and with what
settings can be useful. Add tracing for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c    |  4 +++-
 net/mac80211/trace.h | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index cfe2653ed47f..c3330aea4da3 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020-2023 Intel Corporation
+ * Copyright(c) 2020-2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -603,6 +603,8 @@ void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 	if (WARN_ON(!link))
 		goto out;
 
+	trace_api_request_smps(sdata->local, sdata, link, smps_mode);
+
 	if (link->u.mgd.driver_smps_mode == smps_mode)
 		goto out;
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 2d0d969f0c3d..806e762aa546 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -3058,6 +3058,35 @@ TRACE_EVENT(api_radar_detected,
 	)
 );
 
+TRACE_EVENT(api_request_smps,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_link_data *link,
+		 enum ieee80211_smps_mode smps_mode),
+
+	TP_ARGS(local, sdata, link, smps_mode),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(int, link_id)
+		__field(u32, smps_mode)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->link_id =
+			ieee80211_vif_is_mld(&sdata->vif) ? link->link_id : -1;
+		__entry->smps_mode = smps_mode;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " " VIF_PR_FMT " link:%d, smps_mode:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->smps_mode
+	)
+);
+
 /*
  * Tracing for internal functions
  * (which may also be called in response to driver calls)
-- 
2.43.0


