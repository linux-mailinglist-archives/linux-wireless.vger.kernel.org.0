Return-Path: <linux-wireless+bounces-12011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F169995FF62
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A660D1F21CBA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD9B1754B;
	Tue, 27 Aug 2024 02:55:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B11758E;
	Tue, 27 Aug 2024 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727314; cv=none; b=PK9e1GS3170PZwLBGxF/PnwXa0lT4TKtHfBAciKqC9NJT+nwXE7du9U/TrLj9dbMqnnZN05JkVrYN/wlyBNbj+wUQHEYm6vTPiqrNTznXoEDeqSMaCG27ZJ1nT17NR+Ao+prJ/wZQIMkRs0+H++7wv8SPeB83SkDJ8557FPZsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727314; c=relaxed/simple;
	bh=H4mKPRXojt/PtFyQoJcO+CZAJ2xLOvJt8iri7FSTkuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H1P4OOdwEOQuVBvAOWqQKw7Yu9r9fUpYRFUIEEFdcZpoBrkIQ5auKAEVDEI3DY7pa+47uK3SXq+nqup+vSNh7AXIcEgPZox4n3sFc4wkSpohnbPU1j7IXsHKZCkAj1PaZd8eJYlPBZ7CinFAqHRILio6M0jEafOGvuxJjWcQLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtBqJ0v4NzQqp3;
	Tue, 27 Aug 2024 10:50:20 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 70B30180AE7;
	Tue, 27 Aug 2024 10:55:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:55:08 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next v2] wifi: mac80211: use max to simplify the code
Date: Tue, 27 Aug 2024 11:03:02 +0800
Message-ID: <20240827030302.1006179-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The following Coccinelle/coccicheck warning reported by
minmax.cocci:
    WARNING opportunity for max()
Let's use max() to simplify the code and fix the warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - change the commit title

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20240824074033.2134514-2-lihongbo22@huawei.com/
---
 net/mac80211/driver-ops.h | 2 +-
 net/mac80211/mlme.c       | 2 +-
 net/mac80211/scan.c       | 6 ++----
 net/mac80211/tdls.c       | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..6b75c7eeff25 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -971,7 +971,7 @@ drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
-	link_id = link_id > 0 ? link_id : 0;
+	link_id = max(link_id, 0);
 
 	trace_drv_mgd_protect_tdls_discover(local, sdata);
 	if (local->ops->mgd_protect_tdls_discover)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4779a18ab75d..60a7631f0457 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5375,7 +5375,7 @@ ieee80211_determine_our_sta_mode_auth(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_conn_settings *conn)
 {
 	ieee80211_determine_our_sta_mode(sdata, sband, NULL, wmm_used,
-					 req->link_id > 0 ? req->link_id : 0,
+					 max(req->link_id, 0),
 					 conn);
 }
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..e77c9f07b046 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1013,10 +1013,8 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	 */
 	if ((chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR)) ||
 	    !scan_req->n_ssids) {
-		*next_delay = msecs_to_jiffies(scan_req->duration) >
-			      IEEE80211_PASSIVE_CHANNEL_TIME ?
-			      msecs_to_jiffies(scan_req->duration) :
-			      IEEE80211_PASSIVE_CHANNEL_TIME;
+		*next_delay = max(msecs_to_jiffies(scan_req->duration),
+				  IEEE80211_PASSIVE_CHANNEL_TIME);
 		local->next_scan_state = SCAN_DECISION;
 		if (scan_req->n_ssids)
 			set_bit(SCAN_BEACON_WAIT, &local->scanning);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f07b40916485..719739def96c 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -919,7 +919,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 	int ret;
 	struct ieee80211_link_data *link;
 
-	link_id = link_id >= 0 ? link_id : 0;
+	link_id = max(link_id, 0);
 	rcu_read_lock();
 	link = rcu_dereference(sdata->link[link_id]);
 	if (WARN_ON(!link))
-- 
2.34.1


